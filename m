Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B185D7A3EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbjIQWlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbjIQWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B412D;
        Sun, 17 Sep 2023 15:40:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-403012f27e1so41840165e9.1;
        Sun, 17 Sep 2023 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990436; x=1695595236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4cz3ddudUKiI7NnTMxIyuudgr4C+r48kicDtdOb7Wo=;
        b=Ofm6xD6hRILie2GXLkZfknjM9VFJ5qhvjeoifGCy9YIbK/Ov0mizRL7wN1N4PV5ga1
         NASPraLe8QJRa0YYO6gAd5qzXIl7/fuD11S+Gqv9dVnvR9j+QGp603L4zfAIBHNpvRYg
         CtMUmbHgO19lFSFgCKXLLWiFgjvV6N0tZABKxOL6oK76qfahsCtjMc6IkjIyeO6WdiyG
         0wsPP8G05m7gGNeD8piyxBvcTEXwZG13wKKRsTZuUlei1K2t9FIdkN6RznUuqD0kUb+P
         25OTftf40/RNAwUnWDIE0hq6MFnIkdFugeCEaeHIrA+KbMCayRKYcFSHU5v0sIMbevEX
         R8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990436; x=1695595236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4cz3ddudUKiI7NnTMxIyuudgr4C+r48kicDtdOb7Wo=;
        b=Ke6rMRyWSg6/HoqhXNe5gWZ8LV3rY9voWXCBBsQYnYlS9XXwkv8nZK5+bPY2P7+rJp
         dQOO5H60M6XaqmCT9hy9S74F3f7n5ye49stxXEh46PeMUUxlMQW0fh95G8gByjP8jOP3
         YtajEOBkuZOsuzk0+8A0M3oNBhy7a+ol8qfXqUtzhASUcrCu+oypK+ljdKk5QcfoJ/di
         YtjovA4bKfueZrRaV7VPd65F3H1OcEw723qlW7+2DmkGqOT56nsWcfmOvMjlno9yvlSx
         7XIBO8jJqA+ioYgjLkR5zbjAsi9tXi5FrHaYFX0Lt2kMxF53P3QHfaR6O2fRIO9hrbAe
         WeVQ==
X-Gm-Message-State: AOJu0Yxd5fXthXnFLHt/HuFzf71Ahqebm11CjdNiP62KS3OjVoFB4By+
        DxVNv0PEykQCQA+1fSA2hjw=
X-Google-Smtp-Source: AGHT+IE2H/LAUCgWRax7Ln7Pf/RNykjRml+cUSy7LIhvq+pmSE6UUuK6rKrg8wHXJMeh2LS9XviDXg==
X-Received: by 2002:a05:600c:3781:b0:401:b2c7:349b with SMTP id o1-20020a05600c378100b00401b2c7349bmr5879782wmr.7.1694990436518;
        Sun, 17 Sep 2023 15:40:36 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:36 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:02 +0200
Subject: [PATCH 06/13] clk: keep track if a clock is explicitly configured
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-6-1d008b3237c0@skidata.com>
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

When we keep track if a clock has a given rate explicitly set by a
consumer, we can identify unintentional clock rate changes in an easy
way. This also helps during debugging, as one can see if a rate is set
by accident or due to a consumer-related change.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c            | 25 +++++++++++++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8f4f92547768..82c65ed432c5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -70,6 +70,7 @@ struct clk_core {
 	unsigned long		rate;
 	unsigned long		req_rate;
 	unsigned long		new_rate;
+	unsigned long		set_rate;
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
 	unsigned long		flags;
@@ -541,6 +542,12 @@ bool __clk_is_enabled(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_is_enabled);
 
+bool __clk_is_rate_set(struct clk *clk)
+{
+	return clk->core->set_rate > 0;
+}
+EXPORT_SYMBOL_GPL(__clk_is_rate_set);
+
 static bool mux_is_better_rate(unsigned long rate, unsigned long now,
 			   unsigned long best, unsigned long flags)
 {
@@ -578,6 +585,19 @@ static bool clk_core_has_parent(struct clk_core *core, const struct clk_core *pa
 	return false;
 }
 
+static bool clk_core_is_ancestor(struct clk_core *core, const struct clk_core *ancestor)
+{
+	struct clk_core *tmp = core->parent;
+
+	while (tmp) {
+		if (tmp == ancestor)
+			return true;
+		tmp = tmp->parent;
+	}
+
+	return false;
+}
+
 static void
 clk_core_forward_rate_req(struct clk_core *core,
 			  const struct clk_rate_request *old_req,
@@ -2358,6 +2378,9 @@ static void clk_change_rate(struct clk_core *core)
 
 	trace_clk_set_rate_complete(core, core->new_rate);
 
+	if (rate_trigger_clk && clk_core_is_ancestor(rate_trigger_clk->core, core))
+		core->set_rate = core->new_rate;
+
 	core->rate = clk_recalc(core, best_parent_rate);
 
 	if (core->flags & CLK_SET_RATE_UNGATE) {
@@ -2528,6 +2551,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		clk_core_rate_protect(clk->core);
 
 	rate_trigger_clk = NULL;
+	clk->core->set_rate = rate;
 
 	clk_prepare_unlock();
 
@@ -2579,6 +2603,7 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 	}
 
 	rate_trigger_clk = NULL;
+	clk->core->set_rate = rate;
 
 	clk_prepare_unlock();
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3fb99ed5e8d9..e3732e0bbed9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1325,6 +1325,7 @@ bool clk_hw_is_prepared(const struct clk_hw *hw);
 bool clk_hw_rate_is_protected(const struct clk_hw *hw);
 bool clk_hw_is_enabled(const struct clk_hw *hw);
 bool __clk_is_enabled(struct clk *clk);
+bool __clk_is_rate_set(struct clk *hw);
 struct clk *__clk_lookup(const char *name);
 int __clk_mux_determine_rate(struct clk_hw *hw,
 			     struct clk_rate_request *req);

-- 
2.34.1

