Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1557B9E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjJEN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjJEN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BE71F759;
        Thu,  5 Oct 2023 02:59:37 -0700 (PDT)
From:   Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696499973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEcmtjaXtVKR/FAZlgMVJnQNS9IPw4/oTIf2c1S/O20=;
        b=lleZ2iChN6yQS/m0/TYcjZ8y+o+bmLltCCUSETeccQG8qwsOlu9zDg4nbAfPrDe3lE9wqq
        3+Y9IM52fXAhCClHNqC0FyeT0sP+sKV+f+ccNMBjq1Q/Qi3Njbg3ZYYB84PCLxgMjdhOD4
        A0nn/bX2R1wY6ZtGerzhhqY9QR9QF8zd+99p8Dbc2VyBiLKrQjYv090d5c37Q/jijqkAfe
        vh7BP0dK8NIbf3o0FZavZSLQYQfIptOUOwFtsxjoG8bTEU1T48XoCyTnnL00BFhGqkSZdS
        56UH+EkDN2gkkSdSuSHAP0TTK4n5LIEP6Zvj5ZHp4xCDiV17qCzOkMZlQGSBew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696499973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEcmtjaXtVKR/FAZlgMVJnQNS9IPw4/oTIf2c1S/O20=;
        b=abLGdVaH0yzo6cqfyNu5ZsAouwNArtrKeFG6Q7ZvHAlTPC1QCqsr1s4nq0TEkdUzmt2oko
        ptyMBJM0puVgO6Dg==
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 1/1] clk: socfpga: gate: Fix of by factor 2 for serial console
Date:   Thu,  5 Oct 2023 11:59:27 +0200
Message-ID: <20231005095927.12398-2-b.spranger@linutronix.de>
In-Reply-To: <20231005095927.12398-1-b.spranger@linutronix.de>
References: <20231005095927.12398-1-b.spranger@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9607beb917df ("clk: socfpga: gate: Add a determine_rate hook")
introduce a specific determine_rate hook. As a result the calculated
clock for the serial IP is off by factor 2 after that i.e. if the system
configures a baudrate of 115200 it is set physicaly to 57600.

Change the determine_rate hook to the reparent variant
__clk_mux_determine_rate() to fix the issue.

Cc: stable@vger.kernel.org
Fixes: 9607beb917df ("clk: socfpga: gate: Add a determine_rate hook")
Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
---
 drivers/clk/socfpga/clk-gate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 8dd601bd8538..47500976f987 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -110,7 +110,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 
 static struct clk_ops gateclk_ops = {
 	.recalc_rate = socfpga_clk_recalc_rate,
-	.determine_rate = clk_hw_determine_rate_no_reparent,
+	.determine_rate = __clk_mux_determine_rate,
 	.get_parent = socfpga_clk_get_parent,
 	.set_parent = socfpga_clk_set_parent,
 };
-- 
2.42.0

