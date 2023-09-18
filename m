Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9099F7A4129
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbjIRG2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbjIRG1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:27:54 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDCB8F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:27:45 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Rpvtc1lv5z9xnT8;
        Mon, 18 Sep 2023 14:25:44 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 18 Sep
 2023 14:27:35 +0800
Date:   Mon, 18 Sep 2023 14:27:34 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nstange@suse.de>, <wangjinchao@xfusion.com>,
        <tangqingmei@xfusion.com>, <stone.xulei@xfusion.com>
Subject: Issue: padata: UAF in padata_serial_worker reproduce
Message-ID: <ZQft1jGSMSTRlxfi@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I have reproduced the issue mentioned by Nicolai Stange on an arm64 server.
After applying Nicolai Stange's patch, the issue did not reoccur even after running for two days.
The test tools used were ltp20220121 and stress-ng-0.15.06.tar.gz.

refurl: https://lore.kernel.org/all/20221028160401.cccypv4euxikusiq@parnassus.localdomain/T/#u

The testing steps were as follows:
1. Enabled the KASAN (Kernel Address Sanitizer) feature.
2. Applied CPU and memory stress to the physical machine, each at 80% load:
   ```
   stress=$(($(cat /proc/cpuinfo | grep "processor" | wc -l) * 80 / 100))
   stress-ng --vm 1 --vm-bytes 80% -c $stress -t 168h
   ```
3. Applied stress to the filesystem:
   ```
   stress-ng --sequential 1 --class filesystem --exclude "io,iomix" --timeout 168h --verbose --metrics-brief --times
   ```
4. Ran the LTP (Linux Test Project) test for approximately 4 hours, which resulted in the KASAN logs:
   ```
   ./runltp -s pcrypt_aead01
   ```



[  788.732881] ==================================================================
[  788.740821] BUG: KASAN: slab-use-after-free in padata_serial_worker+0x20c/0x320
[  788.748837] Write of size 4 at addr ffff002102d37018 by task kworker/1:2/664

[  788.758835] CPU: 1 PID: 664 Comm: kworker/1:2 Kdump: loaded Not tainted 6.6.0-rc1-dirty #5
[  788.767769] Hardware name: Huawei S920X00/BC82AMDYA, BIOS 1.99 01/06/2023
[  788.775247] Workqueue: pdecrypt_serial padata_serial_worker
[  788.781529] Call trace:
[  788.784687]  dump_backtrace+0xa0/0x128
[  788.789145]  show_stack+0x20/0x38
[  788.793171]  dump_stack_lvl+0x78/0xc8
[  788.797531]  print_address_description.constprop.0+0x84/0x2b0
[  788.803979]  kasan_report+0xe0/0x118
[  788.808282]  kasan_check_range+0xe8/0x190
[  788.812980]  __kasan_check_write+0x20/0x30
[  788.817783]  padata_serial_worker+0x20c/0x320
[  788.822868]  process_one_work+0x310/0x638
[  788.827594]  worker_thread+0x424/0x650
[  788.832054]  kthread+0x164/0x178
[  788.836000]  ret_from_fork+0x10/0x20

[  788.842484] Allocated by task 215792:
[  788.846863]  kasan_save_stack+0x2c/0x58
[  788.851426]  kasan_set_track+0x2c/0x40
[  788.855893]  kasan_save_alloc_info+0x24/0x38
[  788.860868]  __kasan_kmalloc+0xa0/0xb8
[  788.865319]  kmalloc_trace+0x64/0xf8
[  788.869613]  padata_alloc_pd+0x48/0x370
[  788.874140]  padata_alloc_shell+0x5c/0x120
[  788.878932]  pcrypt_create_aead.isra.0+0x98/0x280 [pcrypt]
[  788.885139]  pcrypt_create+0x6c/0x88 [pcrypt]
[  788.890189]  cryptomgr_probe+0x58/0xe0
[  788.894639]  kthread+0x164/0x178
[  788.898565]  ret_from_fork+0x10/0x20

[  788.905040] Freed by task 149081:
[  788.909041]  kasan_save_stack+0x2c/0x58
[  788.913577]  kasan_set_track+0x2c/0x40
[  788.918015]  kasan_save_free_info+0x38/0x60
[  788.922885]  __kasan_slab_free+0xe8/0x168
[  788.927584]  __kmem_cache_free+0x130/0x298
[  788.932373]  kfree+0x78/0x108
[  788.936037]  padata_free_shell+0xe0/0x120
[  788.940736]  pcrypt_free+0x38/0x68 [pcrypt]
[  788.945620]  crypto_aead_free_instance+0x34/0x50
[  788.950930]  crypto_destroy_instance_workfn+0x50/0x80
[  788.956666]  process_one_work+0x310/0x638
[  788.961378]  worker_thread+0x424/0x650
[  788.965841]  kthread+0x164/0x178
[  788.969763]  ret_from_fork+0x10/0x20
