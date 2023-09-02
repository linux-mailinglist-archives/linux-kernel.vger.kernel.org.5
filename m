Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72B7905F0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbjIBHpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjIBHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:45:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775351722;
        Sat,  2 Sep 2023 00:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4B030CE25A9;
        Sat,  2 Sep 2023 07:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394D7C433C9;
        Sat,  2 Sep 2023 07:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640711;
        bh=igYFzeu09JXMCYReR1pVMS95JjRHTi+y4Ts88ORpSUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJsnc5L985T5bg+ibk3/kGrxNZm/+MU7ZPc6Nl/8FzBaE0YR5pp525s7TH2CPCdRt
         6ZCApl7lOU9/Q0TzS8ePOwRAXtFHOMPrWewYluQTXXA1hwkKtKuHoP+jwdo7Rxf1Ku
         oRUztxd8xQUktnQkViY2NNPD3WAYMg/0JAM2m1dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.325
Date:   Sat,  2 Sep 2023 09:45:07 +0200
Message-ID: <2023090206-cogwheel-backshift-547d@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023090206-dimness-twelve-1bff@gregkh>
References: <2023090206-dimness-twelve-1bff@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index d1c052d0232f..9aa13e67a218 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 324
+SUBLEVEL = 325
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index b07956883e16..de998830f534 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -9,7 +9,6 @@
 #include <linux/io.h>
 #include <asm/mach/time.h>
 #include "soc.h"
-#include "platform.h"
 
 /*************************************************************************
  * Timer handling for EP93xx
@@ -61,7 +60,7 @@ static u64 notrace ep93xx_read_sched_clock(void)
 	return ret;
 }
 
-static u64 ep93xx_clocksource_read(struct clocksource *c)
+u64 ep93xx_clocksource_read(struct clocksource *c)
 {
 	u64 ret;
 
diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 122f8c0d258e..fc482d900ddd 100644
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
