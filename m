Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677607A3EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjIQWlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbjIQWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B75412C;
        Sun, 17 Sep 2023 15:40:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-404773f2501so33760315e9.0;
        Sun, 17 Sep 2023 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990437; x=1695595237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d58DRMcmmqVdQpNWAbMiLz0ISFX3idJISFoDmPX5pV4=;
        b=Fs1yJekj5VZUsnEwk9NjkR7+d7C7lyzCpZip1ahwWs1mGgft6TG5RqPx+wrvTtqsWZ
         /QCbhKrRJDXxHldMLq3iHY0DvSJ37cGAsd7rO7u7G/UnOnohw8sUhKsgv1hvGTDNDAww
         OX1qTn04J6/iBfzcbRpJdPelsM1+/TTMGCiYgsKVnOiS154bMd/NNIt9qBLDJeXCilSZ
         KH4tAyjbUS8GMCB2HoFbFGcUmmeuP6Cl+f74TnNYNpq4AkxAzW55/wRZtPH2ugWiikcC
         1OO0wAH6oq7hdQYEhqqvGXuFwBi9j1ffgisbh9sYlvjgvGgiOaL7QWlnO2eQWUtCdhWw
         iAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990437; x=1695595237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d58DRMcmmqVdQpNWAbMiLz0ISFX3idJISFoDmPX5pV4=;
        b=VXyNeom/Fyb4dEl2F1Y5JaxUVfwz3zHMy5p7T1SbScVrYrFJhvSsihGAOehk9q9k9P
         Ea55zYD7NtynzM5/E6wt2bPGX5xTQbdfThUzr5GtPezM1yo7UUnz64zaeQCG7sm6xOrA
         ETZXEfxQGNdKH+yL3U14tiBoxg/DD/eeyH5ukz6c7Zb7lHHpfhPSgSctb2ZSPSQtpkhU
         5fhd1pwaw+PrxOtxRRABr1G1jHj/wPtmEW9ZTnTAZb7VXebpbjpIY+6oDvgW8P8II5GB
         +1SRmnAKEw/+4aJlee8aK9gP5j5hDKPsoIplFBwKmY8UWxmvyO+cat/NaloJzV9EUwwZ
         7tfg==
X-Gm-Message-State: AOJu0YyIe0uu+Qhs+6T5rOShuYIqN5wHgEn7t7u+ESt94JseKIqY0jy1
        mewS16w93B3q9CTezvjGCyA=
X-Google-Smtp-Source: AGHT+IEYhBep8mg6WS7aKBOBPPKW2JCJgL7HelrqDWQ8VqlnSyxcZRRMfPYvNeB+WumXVoC+/YvMXQ==
X-Received: by 2002:a05:600c:2288:b0:404:7865:bf4 with SMTP id 8-20020a05600c228800b0040478650bf4mr5869641wmf.39.1694990437396;
        Sun, 17 Sep 2023 15:40:37 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:37 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:03 +0200
Subject: [PATCH 07/13] clk: detect unintended rate changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-7-1d008b3237c0@skidata.com>
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

As we now keep track of the clocks which are allowed to change - namely
the ones which are along the ancestor line between the rate trigger and
the top-most changed clock, we can run through the subtree of changes
and look for unexpected ones. Shared parents must set their rate in a
way, that all consumer-configured rates are respected. As this is
sometimes not possible and clocks sometime doesn't require the *exact*
rate, we might have to find a way to find out if it is *exact enough*.
Then we could fix it in the core.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 82c65ed432c5..faececc44c28 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2280,6 +2280,74 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 	return top;
 }
 
+/*
+ * If the changed clock is consumer-configured, but not an ancestor of the
+ * trigger, it is most likely an unintended change. As a workaround, we try to
+ * set the rate back to the old without changing the parent. If this is not
+ * possible, the change should not have been suggested in the first place.
+ */
+static struct clk_core *clk_detect_unintended_rate_changes(struct clk_core *core,
+							   bool fix)
+{
+	struct clk_core *child, *tmp_clk;
+
+	if (core->rate == core->new_rate)
+		return NULL;
+
+	if (core->set_rate && core != rate_trigger_clk->core &&
+	    !clk_core_is_ancestor(rate_trigger_clk->core, core)) {
+		struct clk_core *parent = core->new_parent ? : core->parent;
+		struct clk_rate_request req;
+
+		pr_debug("%s: unintended change by %s (%lu -> %lu)\n", core->name,
+			 rate_trigger_clk->core->name, core->rate, core->new_rate);
+
+		if (fix) {
+			clk_hw_init_rate_request(core->hw, &req, core->rate);
+			req.best_parent_rate = parent->new_rate;
+			req.best_parent_hw = parent->hw;
+
+			if (clk_core_round_rate_nolock(core, &req))
+				return core;
+
+			/* TODO: how close is close enough? */
+			if (req.rate != core->rate) {
+				pr_debug("%s: %s fix failed, req=%lu, sugg=%lu\n",
+					 __func__, core->name, core->rate, req.rate);
+				return core;
+			}
+			if (req.best_parent_rate != parent->new_rate ||
+			    req.best_parent_hw != parent->hw) {
+				pr_debug("%s: %s fix failed, req=%s@%lu, sugg=%s@%lu\n",
+					 __func__, core->name, parent->name,
+					 parent->new_rate,
+					 req.best_parent_hw->core->name,
+					 req.best_parent_rate);
+				return core;
+			}
+
+			core->new_rate = core->rate;
+		}
+		return NULL;
+	}
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		if (child->new_parent && child->new_parent != core)
+			continue;
+		tmp_clk = clk_detect_unintended_rate_changes(child, fix);
+		if (tmp_clk)
+			return tmp_clk;
+	}
+
+	if (core->new_child) {
+		tmp_clk = clk_detect_unintended_rate_changes(core->new_child, fix);
+		if (tmp_clk)
+			return tmp_clk;
+	}
+
+	return NULL;
+}
+
 /*
  * Notify about rate changes in a subtree. Always walk down the whole tree
  * so that in case of an error we can walk down the whole tree again and
@@ -2484,6 +2552,21 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 		goto err;
 	}
 
+	/*
+	 * The notifying process offers the possibility to fix the rates of
+	 * unrelated clocks along the tree. After that, run a detection to find
+	 * clocks which are potentially wrongly configured now. These might be
+	 * fixed by the core in the future.
+	 */
+	fail_clk = clk_detect_unintended_rate_changes(top, false);
+	if (fail_clk) {
+		pr_err("%s: unintended rate change cannot be fixed\n",
+		       fail_clk->name);
+		ret = -EINVAL;
+		goto err;
+	}
+
+
 	/* change the rates */
 	clk_change_rate(top);
 

-- 
2.34.1

