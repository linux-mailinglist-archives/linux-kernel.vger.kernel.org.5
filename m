Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491F1758107
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjGRPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjGRPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0E172D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78AB56164C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4A2C433C8;
        Tue, 18 Jul 2023 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689694430;
        bh=mqwYcIZH+M6h8d7AW+YLg7/JE8kUv6dByMB/fsXMe5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZauC2YoS57Y7Z75WX93K8wwq6vCm7vKYIrjQ7e1PVKNVB9oFy4zuFqlAHt/o9u8ig
         +jHL7t3YG0DIEB6aHqFTmfny58qvFcbf5CIXyGWvdZTy1e53lTQ536dn67rE17C/nX
         tNSMeABCJ0uBzJAhNRUYMbCjBerE73usUmO+jRF0pZkGkqrR+kns0jDAsySb5rrjm0
         vJ0c0tNKTFlWD33YC5Vz/yDQMvPds538rFQgalIrZPB3wuBc466LP3kRSqQwFP4Ch0
         oEvk6Z0ioJ5Hc+hwquvbxlp6Z83T51FMAMWjgZo4xqIpfbbJNOElQr6m7JucSJtx3Y
         kYKEx/dV4ZjKQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/2] riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC for !dma_coherent
Date:   Tue, 18 Jul 2023 23:22:14 +0800
Message-Id: <20230718152214.2907-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230718152214.2907-1-jszhang@kernel.org>
References: <20230718152214.2907-1-jszhang@kernel.org>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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

