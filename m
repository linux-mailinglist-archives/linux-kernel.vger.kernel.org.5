Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36B754FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjGPRD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 13:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjGPRDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 13:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716BE5D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 10:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C513460DCB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 17:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8391C433C8;
        Sun, 16 Jul 2023 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689527001;
        bh=20Zikv72OY76YPWE++4/3jVTe/sLWDTAfsZqK7N92KQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Y7tUXlqTb2RTqjU/5X6XsYUAKr/1DDq7xMzby0BIFbpXmiQLOK8k8LS+kbQS/qrfJ
         1SZysyfCHvFm1K/x5nW1nCrAkICcHzkrG7y8zmrTLEm733ySdb33bfCO+63pDhHivv
         IpOeg2jLQhicVR/g7jrMR/bANwzH6CDbvmbRHErQeK589svbW0w4wqp0esok7DLphh
         NKWMVyOTZtmkEcOMbMavx2rnEH3553pfJBQaOXqBy9aeJhqK2NYxL9U/Zysl2ml7pz
         0s7csg7Xp0mVfYdatvdojnWSjKsoJJYIWbVVgTgTlQ6o5FnJeUml62SyglnrDg2fny
         c/xR76ujLxVpQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv: Reduce ARCH_KMALLOC_MINALIGN to 8
Date:   Mon, 17 Jul 2023 00:51:45 +0800
Message-Id: <20230716165147.1897-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, riscv defines ARCH_DMA_MINALIGN as L1_CACHE_BYTES, I.E
64Bytes, if CONFIG_RISCV_DMA_NONCOHERENT=y. To support unified kernel
Image, usually we have to enable CONFIG_RISCV_DMA_NONCOHERENT, thus
it brings some bad effects to coherent platforms:

Firstly, it wastes memory, kmalloc-96, kmalloc-32, kmalloc-16 and
kmalloc-8 slab caches don't exist any more, they are replaced with
either kmalloc-128 or kmalloc-64.

Secondly, larger than necessary kmalloc aligned allocations results
in unnecessary cache/TLB pressure.

This issue also exists on arm64 platforms. From last year, Catalin
tried to solve this issue by decoupling ARCH_KMALLOC_MINALIGN from
ARCH_DMA_MINALIGN, limiting kmalloc() minimum alignment to
dma_get_cache_alignment() and replacing ARCH_KMALLOC_MINALIGN usage
in various drivers with ARCH_DMA_MINALIGN etc.[1]

One fact we can make use of for riscv: if the CPU doesn't support
ZICBOM or T-HEAD CMO, we know the platform is coherent. Based on
Catalin's work and above fact, we can easily solve the kmalloc align
issue for riscv: we can override dma_get_cache_alignment(), then let
it return ARCH_DMA_MINALIGN at the beginning and return 1 once we know
the underlying HW neither supports ZICBOM nor supports T-HEAD CMO.

So what about if the CPU supports ZICBOM and T-HEAD CMO, but all the
devices are dma coherent? Well, we use ARCH_DMA_MINALIGN as the
kmalloc minimum alignment, nothing changed in this case. This case
can be improved in the future.

After this patch, a simple test of booting to a small buildroot rootfs
on qemu shows:

kmalloc-96           5041    5041     96  ...
kmalloc-64           9606    9606     64  ...
kmalloc-32           5128    5128     32  ...
kmalloc-16           7682    7682     16  ...
kmalloc-8           10246   10246      8  ...

So we save about 1268KB memory. The saving will be much larger in normal
OS env on real HW platforms.


patch1 allows kmalloc() caches aligned to the smallest value.
patch2 enables DMA_BOUNCE_UNALIGNED_KMALLOC.

After this series:

As for coherent platforms, kmalloc-{8,16,32,96} caches come back on
coherent both RV32 and RV64 platforms, I.E !ZICBOM and !THEAD_CMO.

As for noncoherent RV32 platforms, nothing changed.

As for noncoherent RV64 platforms, I.E either ZICBOM or THEAD_CMO, the
above kmalloc caches also come back if > 4GB memory or users pass
"swiotlb=mmnn,force" to force swiotlb creation if <= 4GB memory. How
much mmnn should be depends on the specific platform, it need to be
tried and tested all possible usage case on the specific hardware. For
example, I can use the minimal I/O TLB slabs on Sipeed M1S Dock.

[1] Link: https://lore.kernel.org/linux-arm-kernel/20230524171904.3967031-1-catalin.marinas@arm.com/

Since v1
 - remove preparation patches since they have been merged
 - adjust Kconfig entry to keep entries sorted
 - add new function riscv_set_dma_cache_alignment() to set the
   dma_cache_alignment var.

Jisheng Zhang (2):
  riscv: allow kmalloc() caches aligned to the smallest value
  riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC for !dma_coherent

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/include/asm/cache.h      | 14 ++++++++++++++
 arch/riscv/include/asm/cacheflush.h |  2 ++
 arch/riscv/kernel/setup.c           |  1 +
 arch/riscv/mm/dma-noncoherent.c     |  8 ++++++++
 5 files changed, 26 insertions(+)

-- 
2.40.1

