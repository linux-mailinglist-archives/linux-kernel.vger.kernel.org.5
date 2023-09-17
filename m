Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2BD7A3EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbjIQWlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbjIQWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E81912C;
        Sun, 17 Sep 2023 15:40:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401b5516104so42229985e9.2;
        Sun, 17 Sep 2023 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990441; x=1695595241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kviONp3xwBUSyMm3n9HmjGMrxjEliGN8QJc2qo9i9Gg=;
        b=EDdjdIGq2P7Xcv8PTewEF6v1RKp/aAo6CdgQlXiuUxJoN1KGwOSCvXSdin+JCy8h6c
         khklOsRT7uUW9r/H/LKBpi9atO1TixYZUZbqw7tupfo9Y9TNg1qK9LA03g5s5cmdnhTB
         7GRVNKZRVy7FU5mpYZirDWPioOpyMYi1ylagszL2Utaja+7cwNirZU3EaZQIMHyb/tko
         hUaO2UKcNA2gm6QqCiGCDQSBnRy0YLXzdU68ztsltiYrG6batmzBAqTcKbBkIYVZ/jd4
         SsT3cN7bI8yk7y8eN/FEn4jPQrh61ekJzoYexDrZKVs/evUeAaa4CMbnV6+QXFYzmCRm
         nhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990441; x=1695595241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kviONp3xwBUSyMm3n9HmjGMrxjEliGN8QJc2qo9i9Gg=;
        b=dSBtFbhFxmgvhygqfB3Y+VjsuhnKFnxgfFTeIm3m2JuwbfcWYCMIhCzzXrAidveUCi
         KiH/zGOiEmCQ6SfHXgDs6oT139M1L/h0EIs/SFgRJl68IhZU6Ot3xjjkM2IAbiVO0TIv
         NdIN157uKdSb2FV8V/vMOkrxj4mj2N9eYhx9kLQeFyvehqjDRBHm/4ob+GEdhUktPyF3
         YZ5gzF9O0wbUsp5Z72zanmId+Vmd+hkSiICLQEYEtLPYMt/o9CUC/yiOYnaBlwe6IGea
         gsrDDGivSFaLDbBxjeKI/hqB0NdteR5hHCIxHnRtKVZD/K69t0oqLf2wknPC1NBmSYNw
         B4/w==
X-Gm-Message-State: AOJu0Yyy8fH5syG+MI+u7y3E/6V3G0pfo1piz2YoqLWIXIQ3YWUr8bR5
        F6E1IVti8lkVm+tlnueQ1HI=
X-Google-Smtp-Source: AGHT+IGI9iHWZr7kzzg0eUkNH07Lgn024wjCqs9NAjnnhsL3UBw49Jv26TH9svgPt6bxfNSbTxu3XQ==
X-Received: by 2002:a1c:6a01:0:b0:401:b53e:6c3b with SMTP id f1-20020a1c6a01000000b00401b53e6c3bmr6295687wmc.6.1694990441025;
        Sun, 17 Sep 2023 15:40:41 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:40 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:07 +0200
Subject: [PATCH 11/13] clk: imx: composite-8m: implement
 CLK_SET_RATE_PARENT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-11-1d008b3237c0@skidata.com>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

One of the key parts to enable dynamic clock propagation on the imx8m,
are the consumer-facing composites. They currently only divide,
therefore the parent must be already quite good in shape to provide a
close enough rate. Therefore, the parents are usually hard-assigned in
the dt. To workaround that, this commit enables propagation to the
parent of the composite.

If a rate cannot be reached exactly by only dividing, the parent is
asked (for now simply for the exact required rate - no dividers taken
into account). If the parent already has a configured rate, it's the
parent's job to ensure that all children are satisfied.

By using a notifier, the propagation-enabled clocks listen to clock
changes coming from the parent. If one is happening, it's the composites
job to verify if the rate is satisfying and if it is an intended change.

Otherwise, countermeasures have to be taken into account (e.g. setting
the rate back or aborting the change).

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/imx/clk-composite-8m.c | 71 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index a121f1285110..068f61df28b1 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/io.h>
@@ -119,8 +120,12 @@ static int imx8m_divider_determine_rate(struct clk_hw *hw,
 				      struct clk_rate_request *req)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
+	struct clk_hw *parent = clk_hw_get_parent(hw);
 	int prediv_value;
 	int div_value;
+	unsigned long target_rate;
+	struct clk_rate_request req_parent;
+	int ret;
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
@@ -140,9 +145,29 @@ static int imx8m_divider_determine_rate(struct clk_hw *hw,
 						 divider->flags, prediv_value * div_value);
 	}
 
-	return divider_determine_rate(hw, req, divider->table,
-				      PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
-				      divider->flags);
+	target_rate = req->rate;
+	ret = divider_determine_rate(hw, req, divider->table,
+				     PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
+				     divider->flags);
+	if (ret || req->rate == target_rate)
+		return ret;
+
+	/*
+	 * If re-configuring the parent gives a better rate, do this instead.
+	 * Avoid re-parenting for now, which could be done first if a possible
+	 * parent already has a satisfying rate. The implementation does not
+	 * consider the dividers between the parent and the current clock.
+	 */
+	clk_hw_forward_rate_request(hw, req, parent, &req_parent, target_rate);
+	if (__clk_determine_rate(parent, &req_parent))
+		return 0;
+
+	if (abs(req_parent.rate - target_rate) < abs(req->rate - target_rate)) {
+		req->rate = req_parent.rate;
+		req->best_parent_rate = req_parent.rate;
+	}
+
+	return 0;
 }
 
 static const struct clk_ops imx8m_clk_composite_divider_ops = {
@@ -198,6 +223,33 @@ static const struct clk_ops imx8m_clk_composite_mux_ops = {
 	.determine_rate = imx8m_clk_composite_mux_determine_rate,
 };
 
+static int imx8m_clk_composite_notifier_fn(struct notifier_block *notifier,
+					   unsigned long code, void *data)
+{
+	struct clk_notifier_data *cnd = data;
+	struct clk_hw *hw = __clk_get_hw(cnd->clk);
+
+	if (code != PRE_RATE_CHANGE)
+		return NOTIFY_OK;
+
+	if (!__clk_is_rate_set(cnd->clk))
+		return NOTIFY_OK;
+
+	/*
+	 * Consumer of a composite-m8 clock usually use the root clk, a gate
+	 * connected to the composite (e.g. media_ldb and media_ldb_root).
+	 * Therefore, evaluate the trigger's parent too.
+	 */
+	if (cnd->clk != cnd->trigger && cnd->clk != clk_get_parent(cnd->trigger))
+		return notifier_from_errno(clk_hw_set_rate(hw, cnd->old_rate));
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block imx8m_clk_composite_notifier = {
+	.notifier_call = imx8m_clk_composite_notifier_fn,
+};
+
 struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
@@ -211,6 +263,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	struct clk_mux *mux = NULL;
 	const struct clk_ops *divider_ops;
 	const struct clk_ops *mux_ops;
+	int ret;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -268,6 +321,18 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	if (IS_ERR(hw))
 		goto fail;
 
+	/*
+	 * register a notifier which should switch back to the configured rate
+	 * if the rate is going to be changed unintentionally.
+	 */
+	if (flags & CLK_SET_RATE_PARENT) {
+		ret = clk_notifier_register(hw->clk, &imx8m_clk_composite_notifier);
+		if (ret) {
+			hw = ERR_PTR(ret);
+			goto fail;
+		}
+	}
+
 	return hw;
 
 fail:

-- 
2.34.1

