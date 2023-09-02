Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CE7905EC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348940AbjIBHp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjIBHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:45:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E281728;
        Sat,  2 Sep 2023 00:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F7BAB82707;
        Sat,  2 Sep 2023 07:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3996C433C7;
        Sat,  2 Sep 2023 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640704;
        bh=peOo+17POryfQOqK7qYAI+J3fpWzerub+oX9A9n+x4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJgaeyjzavZ/LfELHR7apqraUVB4BZckil44JI75kbdLUCdeIeM3Swl9AqgBJqjx4
         kW+ssk5HuQQfr7v/1LInG+Vlcrwk4N/E2LflBzZTX40/fnmuRk53RjWiwhFISpzxM/
         1vqGnM2Wz44OagMiF0sG1MLhBT6GquRDvKjMDW3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.294
Date:   Sat,  2 Sep 2023 09:45:01 +0200
Message-ID: <2023090200-john-dandelion-9ae2@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023090259-humbly-theater-4cbf@gregkh>
References: <2023090259-humbly-theater-4cbf@gregkh>
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
index 5965df0393fd..4f8f98c7227a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 293
+SUBLEVEL = 294
 EXTRAVERSION =
 NAME = "People's Front"
 
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
