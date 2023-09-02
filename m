Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3C7905EA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351812AbjIBHpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351823AbjIBHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49871726;
        Sat,  2 Sep 2023 00:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A476179A;
        Sat,  2 Sep 2023 07:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5391BC433C9;
        Sat,  2 Sep 2023 07:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640696;
        bh=RTwg7kvJshWqtJnaku6O8hHJT5o/1EaPwjFSoJIdOVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtELa6X/sgb3fB6SoLw/CaqbKkf0wo40rB/4yh2j0Jy7yOuiHmRhBLuGvVCgtaEs3
         IkV+X7YKqhNOiFDlqWiwukfypoja4Fillt4TxraH+ajVibgbPE+/KWw56NY2UAKuUF
         j+vgcEbSDi3Zv9UhL6J1SBg+OEviAybpFJJVLlO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.256
Date:   Sat,  2 Sep 2023 09:44:50 +0200
Message-ID: <2023090250-primal-opt-0a36@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023090249-crimp-rash-0a5f@gregkh>
References: <2023090249-crimp-rash-0a5f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 041adebe7da2..e5761a10f4a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 255
+SUBLEVEL = 256
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index e9ee9ab90a0c..4ca2c28878e0 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -30,7 +30,6 @@
  *
  */
 
-#include <linux/dma-map-ops.h> /* for dma_default_coherent */
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -624,18 +623,17 @@ u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 		dp->dscr_cmd0 &= ~DSCR_CMD0_IE;
 
 	/*
-	 * There is an erratum on certain Au1200/Au1550 revisions that could
-	 * result in "stale" data being DMA'ed. It has to do with the snoop
-	 * logic on the cache eviction buffer.  dma_default_coherent is set
-	 * to false on these parts.
+	 * There is an errata on the Au1200/Au1550 parts that could result
+	 * in "stale" data being DMA'ed. It has to do with the snoop logic on
+	 * the cache eviction buffer.  DMA_NONCOHERENT is on by default for
+	 * these parts. If it is fixed in the future, these dma_cache_inv will
+	 * just be nothing more than empty macros. See io.h.
 	 */
-	if (!dma_default_coherent)
-		dma_cache_wback_inv(KSEG0ADDR(buf), nbytes);
+	dma_cache_wback_inv((unsigned long)buf, nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
-	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
@@ -687,18 +685,17 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 			  dp->dscr_source1, dp->dscr_dest0, dp->dscr_dest1);
 #endif
 	/*
-	 * There is an erratum on certain Au1200/Au1550 revisions that could
-	 * result in "stale" data being DMA'ed. It has to do with the snoop
-	 * logic on the cache eviction buffer.  dma_default_coherent is set
-	 * to false on these parts.
+	 * There is an errata on the Au1200/Au1550 parts that could result in
+	 * "stale" data being DMA'ed. It has to do with the snoop logic on the
+	 * cache eviction buffer.  DMA_NONCOHERENT is on by default for these
+	 * parts. If it is fixed in the future, these dma_cache_inv will just
+	 * be nothing more than empty macros. See io.h.
 	 */
-	if (!dma_default_coherent)
-		dma_cache_inv(KSEG0ADDR(buf), nbytes);
+	dma_cache_inv((unsigned long)buf, nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
-	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index f95fbdee6efe..d2900689d642 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -660,13 +660,13 @@ static void smp_core99_gpio_tb_freeze(int freeze)
 
 #endif /* !CONFIG_PPC64 */
 
-/* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
-volatile static long int core99_l2_cache;
-volatile static long int core99_l3_cache;
-
 static void core99_init_caches(int cpu)
 {
 #ifndef CONFIG_PPC64
+	/* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
+	static long int core99_l2_cache;
+	static long int core99_l3_cache;
+
 	if (!cpu_has_feature(CPU_FTR_L2CR))
 		return;
 
