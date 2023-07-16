Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16303754FFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 19:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGPRDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGPRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 13:03:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFF2E7C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 10:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33E1F60DD7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 17:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD4AC433C9;
        Sun, 16 Jul 2023 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689527004;
        bh=61mHo/GoVFw4VYteCT18+1hTq6UHmH6Xpf8WnsgzgCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vO6eZga+ienruHXDg35BGubyuIUJiAL1YyXmXrYs1J5+HGDaEcPgHQZd8pwxYrooU
         WokiyETebjl6dNFeWMDBANeTWTKKK6r0xK2LOim7QQeW4ErwbKkDrz3HE7rYqIsGQk
         i0+0+5tduLOS9s/+jgt7iU/eO+2VuQqCXZ2SpN52nQi2K/MzM/a61y1a+6wK3qO4Le
         4pexAyiwFbgLLRhsLBwnC9qkmh3m4onCefHfdZQk+I8w/86gLggnnFDVKOjBvY+Z0w
         VxLqk81TpI5mzF8M6jbMYXlurSAViV5kZBzTVsN+YwB7k8XDmTSVDYglr7b807mbpZ
         7cXMcynUHNwLg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC for !dma_coherent
Date:   Mon, 17 Jul 2023 00:51:47 +0800
Message-Id: <20230716165147.1897-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230716165147.1897-1-jszhang@kernel.org>
References: <20230716165147.1897-1-jszhang@kernel.org>
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

With the DMA bouncing of unaligned kmalloc() buffers now in place,
enable it for riscv when RISCV_DMA_NONCOHERENT=y to allow the
kmalloc-{8,16,32,96} caches. Since RV32 doesn't enable SWIOTLB
yet, and I didn't see any dma noncoherent RV32 platforms in the
mainline, so skip RV32 now by only enabling
DMA_BOUNCE_UNALIGNED_KMALLOC if SWIOTLB is available. Once we see
such requirement on RV32, we can enable it then.

NOTE: we didn't force to create the swiotlb buffer even when the
end of RAM is within the 32-bit physical address range. That's to
say:
For RV64 with > 4GB memory, the feature is enabled.
For RV64 with <= 4GB memory, the feature isn't enabled by default. We
rely on users to pass "swiotlb=mmnn,force" where mmnn is the Number of
I/O TLB slabs, see kernel-parameters.txt for details.

Tested on Sipeed Lichee Pi 4A with 8GB DDR and Sipeed M1S BL808 Dock
board.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..6681bd6ed2d7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -267,6 +267,7 @@ config RISCV_DMA_NONCOHERENT
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_BOUNCE_UNALIGNED_KMALLOC if SWIOTLB
 	select DMA_DIRECT_REMAP
 
 config AS_HAS_INSN
-- 
2.40.1

