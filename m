Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4977F2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbjHQJCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242446AbjHQJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:02:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A1910C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:02:32 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRJpB1kgbzNmy7;
        Thu, 17 Aug 2023 16:58:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 17:02:30 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH 0/2] Fix memory leak in coresight drivers
Date:   Thu, 17 Aug 2023 16:59:35 +0800
Message-ID: <20230817085937.55590-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build kernel with CONFIG_KASAN=y
there are reports of memory leaks, like:
...
unreferenced object 0xffff2020510fe200 (size 64):
  comm "insmod", pid 4642, jiffies 4295983961 (age 46049.752s)
  hex dump (first 32 bytes):
    10 20 40 06 28 20 ff ff 10 40 7f 06 20 20 ff ff  . @.( ...@..  ..
    10 20 bb 8a 20 00 ff ff 10 e0 c7 8a 20 00 ff ff  . .. ....... ...
  backtrace:
    [<0000000034ec4724>] __kmem_cache_alloc_node+0x2f8/0x348
    [<0000000057fbc15d>] __kmalloc_node_track_caller+0x5c/0x110
    [<0000000055d5e34b>] krealloc+0x8c/0x178
    [<00000000a4635beb>] coresight_alloc_device_name+0x128/0x188 [coresight]
    [<000000000ce9d17b>] smb_probe+0x268/0x478 [ultrasoc_smb]
...
unreferenced object 0xffff00213c141000 (size 1024):
  comm "systemd-udevd", pid 2123, jiffies 4294909467 (age 6062.160s)
  hex dump (first 32 bytes):
    04 00 00 00 02 00 00 00 18 10 14 3c 21 00 ff ff  ...........<!...
    00 00 00 00 00 00 00 00 03 00 00 00 10 00 00 00  ................
  backtrace:
    [<000000004b7c9001>] __kmem_cache_alloc_node+0x2f8/0x348
    [<00000000b0fc7ceb>] __kmalloc+0x58/0x108
    [<0000000064ff4695>] acpi_os_allocate+0x2c/0x68
    [<000000007d57d116>] acpi_ut_initialize_buffer+0x54/0xe0
    [<0000000024583908>] acpi_evaluate_object+0x388/0x438
    [<0000000017b2e72b>] acpi_evaluate_object_typed+0xe8/0x240
    [<000000005df0eac2>] coresight_get_platform_data+0x1b4/0x988 [coresight]
...

The patchset based on "coresight: platform: acpi: Ignore the absence of graph"
https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/commit/?h=next&id=3a2888aa1f962c55ca36119aebe67355c7bf54e4

Junhao He (2):
  coresight: Fix memory leak in acpi_buffer->pointer
  coresight: core: fix memory leak in dict->fwnode_list

 drivers/hwtracing/coresight/coresight-core.c  | 20 +++++++++-
 .../hwtracing/coresight/coresight-platform.c  | 40 ++++++++++++-------
 2 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.33.0

