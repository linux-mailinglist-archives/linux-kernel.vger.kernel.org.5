Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5E57B4EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjJBJYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbjJBJXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:23:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA991;
        Mon,  2 Oct 2023 02:23:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4060b623e64so17034395e9.0;
        Mon, 02 Oct 2023 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696238627; x=1696843427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zfNZlxXcCTfNfmsz4BOltE66rgV2iaZsNlV7GrJxxA=;
        b=PUSHbJzyijUr1rpI8epmHVk+nCxLKUH1kzecaZs0XqrrYH6uG9pLmocoFRMqOtQ3D3
         IXX8Dg+WyQ2OZTMe5gxIbFYprbKuMgBNGLtcaRlkrcVqdEZOg7PcfQ8SzgUSKrpvPV2g
         MbOXnFm9WSaFziC2IIzprhMEEnyCUURmraR3mqS0HTZfUTOyXXjMPHW6gS5FXOtDmWxS
         Srdu8j/1acXUS8MCfgf11gG5cGuf5QFQJ7x1D4GxSDIOm1kpCupxFWV53oCNdr1IrT6q
         BGVX5DMOVpNbNN36ICNFUgh2II3dErmikrxnaNAevAFGGX/HHaBbLM3dxC4V0YUp4mVE
         2I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238627; x=1696843427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zfNZlxXcCTfNfmsz4BOltE66rgV2iaZsNlV7GrJxxA=;
        b=ZPj0cXgipgDPTcACLEWbNrw5HRed16snHb3/7f8O93HA3mU4TSko732Bseg409icUO
         tZfsejGZMWUX7EDYqCvsMcAcRlUS8sSiV4dDD4JoqctsuT6zfxhQEm690QYNPbpfhzFy
         c1+nxp5N3OtQgutGOdG89uutjQU8xCd7V0L0kvEBwVvVmhyqQPYsQWc8hySS7ej3AoHz
         vdigSHuGHQKAGDmKko5MP8xC+egyFMx04pOrxr8CKcvvW0yimvkx+vQIlzWbb7wXAhzo
         gfQrXYsjvmm7jP2zIIXAPLntWS5QpLGJEqa631cVEI+mh+YIxhHRGxixWWM/pBzZGPqP
         d0AQ==
X-Gm-Message-State: AOJu0Yx1gfVSx/txVBRLBfwbtAYrL3poX2jwHPkqXDSZGFz4PTrQ+Goq
        xeQQNfdZNjSRqqy9TIHwLnqTurm1Pgw=
X-Google-Smtp-Source: AGHT+IGwfzei/DJdHX7odp7l+Tnxd+hri1iomzAmP3bzlVoXIU31ZrWDGHFiUZ3WBrZH79yoCaEKmw==
X-Received: by 2002:a05:600c:5022:b0:405:3f06:d2ef with SMTP id n34-20020a05600c502200b004053f06d2efmr9149200wmr.4.1696238626910;
        Mon, 02 Oct 2023 02:23:46 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b003fef5e76f2csm6156589wms.0.2023.10.02.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:23:46 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 02 Oct 2023 11:23:32 +0200
Subject: [PATCH RFC 1/4] clk: only set req_rate if it is set by consumer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-ccf-set-multiple-v1-1-2df5e9eb3738@skidata.com>
References: <20231002-ccf-set-multiple-v1-0-2df5e9eb3738@skidata.com>
In-Reply-To: <20231002-ccf-set-multiple-v1-0-2df5e9eb3738@skidata.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Currently, the req_rate is set during initialization and during
re-parenting. Therefore, it is not clear whether the req_rate is really
required by a consumer or just set by accident. Fix this by only setting
the req_rate when it is really required (clk_set_rate() is called by
consumer).

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..82f954121e4d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -24,6 +24,8 @@
 
 #include "clk.h"
 
+#define CLK_RATE_UNSET -1UL
+
 static DEFINE_SPINLOCK(enable_lock);
 static DEFINE_MUTEX(prepare_lock);
 
@@ -1832,7 +1834,6 @@ static unsigned long clk_recalc(struct clk_core *core,
 /**
  * __clk_recalc_rates
  * @core: first clk in the subtree
- * @update_req: Whether req_rate should be updated with the new rate
  * @msg: notification type (see include/linux/clk.h)
  *
  * Walks the subtree of clks starting with clk and recalculates rates as it
@@ -1842,8 +1843,7 @@ static unsigned long clk_recalc(struct clk_core *core,
  * clk_recalc_rates also propagates the POST_RATE_CHANGE notification,
  * if necessary.
  */
-static void __clk_recalc_rates(struct clk_core *core, bool update_req,
-			       unsigned long msg)
+static void __clk_recalc_rates(struct clk_core *core, unsigned long msg)
 {
 	unsigned long old_rate;
 	unsigned long parent_rate = 0;
@@ -1857,8 +1857,6 @@ static void __clk_recalc_rates(struct clk_core *core, bool update_req,
 		parent_rate = core->parent->rate;
 
 	core->rate = clk_recalc(core, parent_rate);
-	if (update_req)
-		core->req_rate = core->rate;
 
 	/*
 	 * ignore NOTIFY_STOP and NOTIFY_BAD return values for POST_RATE_CHANGE
@@ -1868,13 +1866,13 @@ static void __clk_recalc_rates(struct clk_core *core, bool update_req,
 		__clk_notify(core, msg, old_rate, core->rate);
 
 	hlist_for_each_entry(child, &core->children, child_node)
-		__clk_recalc_rates(child, update_req, msg);
+		__clk_recalc_rates(child, msg);
 }
 
 static unsigned long clk_core_get_rate_recalc(struct clk_core *core)
 {
 	if (core && (core->flags & CLK_GET_RATE_NOCACHE))
-		__clk_recalc_rates(core, false, 0);
+		__clk_recalc_rates(core, 0);
 
 	return clk_core_get_rate_nolock(core);
 }
@@ -2455,7 +2453,6 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	/* change the rates */
 	clk_change_rate(top);
 
-	core->req_rate = req_rate;
 err:
 	clk_pm_runtime_put(core);
 
@@ -2485,6 +2482,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
  */
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
+	unsigned long old_req_rate;
 	int ret;
 
 	if (!clk)
@@ -2493,6 +2491,9 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
+	old_req_rate = clk->core->req_rate;
+	clk->core->req_rate = rate;
+
 	if (clk->exclusive_count)
 		clk_core_rate_unprotect(clk->core);
 
@@ -2501,6 +2502,9 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->exclusive_count)
 		clk_core_rate_protect(clk->core);
 
+	if (ret)
+		clk->core->req_rate = old_req_rate;
+
 	clk_prepare_unlock();
 
 	return ret;
@@ -2528,6 +2532,7 @@ EXPORT_SYMBOL_GPL(clk_set_rate);
  */
 int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 {
+	unsigned long old_req_rate;
 	int ret;
 
 	if (!clk)
@@ -2536,6 +2541,9 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
+	old_req_rate = clk->core->req_rate;
+	clk->core->req_rate = rate;
+
 	/*
 	 * The temporary protection removal is not here, on purpose
 	 * This function is meant to be used instead of clk_rate_protect,
@@ -2546,6 +2554,8 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 	if (!ret) {
 		clk_core_rate_protect(clk->core);
 		clk->exclusive_count++;
+	} else {
+		clk->core->req_rate = old_req_rate;
 	}
 
 	clk_prepare_unlock();
@@ -2723,7 +2733,7 @@ static void clk_core_reparent(struct clk_core *core,
 {
 	clk_reparent(core, new_parent);
 	__clk_recalc_accuracies(core);
-	__clk_recalc_rates(core, true, POST_RATE_CHANGE);
+	__clk_recalc_rates(core, POST_RATE_CHANGE);
 }
 
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent)
@@ -2807,9 +2817,9 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 
 	/* propagate rate an accuracy recalculation accordingly */
 	if (ret) {
-		__clk_recalc_rates(core, true, ABORT_RATE_CHANGE);
+		__clk_recalc_rates(core, ABORT_RATE_CHANGE);
 	} else {
-		__clk_recalc_rates(core, true, POST_RATE_CHANGE);
+		__clk_recalc_rates(core, POST_RATE_CHANGE);
 		__clk_recalc_accuracies(core);
 	}
 
@@ -3706,7 +3716,7 @@ static void clk_core_reparent_orphans_nolock(void)
 			__clk_set_parent_before(orphan, parent);
 			__clk_set_parent_after(orphan, parent, NULL);
 			__clk_recalc_accuracies(orphan);
-			__clk_recalc_rates(orphan, true, 0);
+			__clk_recalc_rates(orphan, 0);
 
 			/*
 			 * __clk_init_parent() will set the initial req_rate to
@@ -3888,7 +3898,8 @@ static int __clk_core_init(struct clk_core *core)
 		rate = parent->rate;
 	else
 		rate = 0;
-	core->rate = core->req_rate = rate;
+	core->rate = rate;
+	core->req_rate = CLK_RATE_UNSET;
 
 	/*
 	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks

-- 
2.34.1

