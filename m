Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83AB7E0266
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjKCL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344094AbjKCL4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:56:08 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25971BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:56:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 374E64206F;
        Fri,  3 Nov 2023 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1699012560; bh=rBYpj2x0/z/rYy3b4TkErdBxLgTGpCyBqvT1ta/GVlc=;
        h=Date:To:From:Subject:Cc;
        b=MbdshQ2iGswPrLcTdej1OotLGp21FXpRAEtB60+dS8yLrVSTpQ6cC7UdZqZTuyz6j
         E/rvq75ApXgt5v+klM8xUsCpte8lSZbR2xJf9iNRuYUNOKr24a/HEPWSn14KtgMqeq
         5ZltarapwIVpfxwSbcRfYW1itcm59rH0MZrMnpDY4cTtjd3jXzTLVP4EQZV9WgmxoK
         YNeDXf1UyqDu2YxrDRJ/9F8Q5OruPYG9IUJasPzRUjQ2otGDE2tKfBV55pN+n0VgAZ
         dRd7NR+IFcz5K1AHU2fbVwEDD+ifbbstbF5ZHdsCXub5FYrUiyRZ/kNvtzkZc6bC/F
         fnGP5HOwIA1kw==
Message-ID: <a36ddb05-9e5f-dfae-81e2-0da5e4925743@marcan.st>
Date:   Fri, 3 Nov 2023 20:55:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     iommu@lists.linux.dev, Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Race between of_iommu_configure() and iommu_probe_device()
Cc:     Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just hit a crash in of_iommu_xlate() -> apple_dart_of_xlate() because
dev->iommu was NULL. of_iommu_xlate() first calls iommu_fwspec_init
which calls dev_iommu_get(), which allocates that member if NULL. That
means it got freed in between, but the only thing that can do that is
dev_iommu_free(), which is called from __iommu_probe_device() in the
error path. That is serialized via a static lock, but not against the
xlate stuff.

I think the specific sequence of events was as follows:

- IOMMU driver has not probed yet
- Device driver tries to probe, and gets deferred via of_iommu_xlate()
-> driver_deferred_probe_check_state() because there are no IOMMU ops yet
- IOMMU driver probes
- IOMMU driver registration triggers device probes
- IOMMU device probe fails, because there is no fwnode/OF data yet (e.g.
apple_dart_probe_device returns ENODEV if dev_iommu_priv_get() returns
NULL, and that is set in apple_dart_of_xlate())
- __iommu_probe_device is in the error exit path, and at this exact
point a parallel device probe is running of_iommu_xlate()
- of_iommu_xlate() calls iommu_fwspec_init(), which ensures dev->iommu
is non-NULL, which at this point it is
- immediately after that, __iommu_probe_device() calls dev_iommu_free()
since it is in the process of erroring out. This frees and sets
dev->iommu to NULL.
- of_iommu_xlate() calls ops->of_xlate()
- apple_dart_of_xlate() calls dev_iommu_priv_set(), which crashes
because dev->iommu is now NULL.

As far as I can tell it's not just the specific driver xlate call
setting priv that's the problem here, but there is one big race between
the entire fwspec codepath (accessing dev->iommu->fwspec) and
__iommu_probe_device() (allocating and freeing dev->iommu).

Thinking about this whole thing is making my brain hurt. Thoughts? How
do we fix this?

Splat:
apple-dart 228304000.iommu: DART [pagesize 4000, 16 streams, bypass
support: 0, bypass forced: 0, locked: 0, AS 32 -> 36] initialized
apple-dart 231304000.iommu: DART [pagesize 4000, 16 streams, bypass
support: 1, bypass forced: 0, locked: 1, AS 32 -> 36] initialized
apple-dart 23130c000.iommu: DART [pagesize 4000, 16 streams, bypass
support: 1, bypass forced: 0, locked: 1, AS 32 -> 36] initialized
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000040
fbcon: Taking over console
apple-dart 22c0e8000.iommu: DART [pagesize 4000, 16 streams, bypass
support: 1, bypass forced: 0, locked: 0, AS 32 -> 36] initialized
Mem abort info:
  ESR = 0x0000000096000044
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
  CM = 0, WnR = 1, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 16k pages, 48-bit VAs, pgdp=000000081d900d50
[0000000000000040] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000044 [#1] SMP
Modules linked in: i2c_apple apple_dart(+) adpdrm drm_dma_helper sunrpc
vfat fat nvme_apple apple_sart nvme_core nvme_common scsi_dh_rdac
scsi_dh_emc scsi_dh_alua fuse dm_multipath
CPU: 2 PID: 12 Comm: kworker/u16:1 Tainted: G S
6.5.6-403.asahi.fc39.aarch64+16k #1
Hardware name: Apple MacBook Pro (13-inch, M1, 2020) (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
apple-dart 22c0f4000.iommu: DART [pagesize 4000, 16 streams, bypass
support: 0, bypass forced: 0, locked: 0, AS 32 -> 36] initialized
pc : apple_dart_of_xlate+0x54/0x1f8 [apple_dart]
lr : apple_dart_of_xlate+0x154/0x1f8 [apple_dart]
sp : ffff8000800e3a10
x29: ffff8000800e3a10 x28: 0000000000000000 x27: 0000000000000000
x26: ffffcfcf9c75d9c0 x25: 0000000000000000 x24: ffffcfcf9b54c798
x23: ffffcfcf9b54d568 x22: ffff1aea0a88dc10 x21: ffff1aea22738080
x20: 0000000000000000 x19: ffff1aea0af34000 x18: ffffffffffffffff
x17: ffff4b1e41cac000 x16: ffffcfcf99eabeb0 x15: ffff8000800e3810
x14: ffffffffffffffff x13: 0000000000000000 x12: 0000000000000003
x11: 0101010101010101 x10: 000000000011cdb8 x9 : 0000000000000000
x8 : ffff1aea0af34080 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : ffff8000800e3960 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff1aea0a30ee00 x0 : 0000000000000000
Call trace:
 apple_dart_of_xlate+0x54/0x1f8 [apple_dart]
 of_iommu_xlate+0xa4/0xe8
 of_iommu_configure+0x190/0x1f8
 of_dma_configure_id+0x13c/0x348
 platform_dma_configure+0x38/0xd0
 really_probe+0x7c/0x3d8
 __driver_probe_device+0x84/0x180
 driver_probe_device+0x44/0x120
 __device_attach_driver+0xc4/0x168
 bus_for_each_drv+0x90/0xf8
 __device_attach+0xa8/0x1c8
 device_initial_probe+0x1c/0x30
 bus_probe_device+0xb4/0xc0
 deferred_probe_work_func+0xbc/0x118
 process_one_work+0x1f4/0x4a0
 worker_thread+0x74/0x418
 kthread+0xf4/0x108
 ret_from_fork+0x10/0x20
Code: 540003a1 b9400e94 b40007b3 f94172c0 (f9002013)
---[ end trace 0000000000000000 ]---

- Hector
