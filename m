Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA027695F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGaMT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGaMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:19:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269F10E4;
        Mon, 31 Jul 2023 05:19:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68706d67ed9so2484729b3a.2;
        Mon, 31 Jul 2023 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690805963; x=1691410763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nC80tf2Fqm9NV1HkrgmsaoEnP1GJqadflAYCzRO4B1o=;
        b=X6W7mqga45fEeKztcwv+LtayLEkKvGLiRsqC1tyfDiRbj2BIIy/XOVJSq05b7P84qa
         b0nGgrvrFyp/uxwpk4+dBuuGYx0Uq7PcrwbPh6De3tXa5BvE/pUBwhu5l/MQXO2QeItz
         ZY3vXjIKVmNcIwcrtcCAY3dJ4ocGMoYwhHRYbXYkhn3s/R8wbW2qF6F7hIiqyyII6KP+
         +WLIP0KR5EZDTJVVKFspO1/fE9yg7RQAu3AkjLLdFpFpRmJLAJCDEIX4Lpl/MMFcnN6n
         gEHDaym5TFXGw5H+CcYj723Fybs02WnsySDWciJbjURLNvAwRyfY/qMVXCxSiVSpWYOz
         o9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805963; x=1691410763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nC80tf2Fqm9NV1HkrgmsaoEnP1GJqadflAYCzRO4B1o=;
        b=ZUk3FO9yHkpEXvXSjwIA9SUSxx4Ql6R+BYEjYOMtTd0dWyI6BLSYlqz+w6caOeCyg2
         BKf1E3H99gesU2exRyEaSCIrHi/jcT5txh0OMZokRl5ffccihkMDd76GvAt6kbznZdYr
         5DnFkub58cBB6ihyTONsm/Mh7SoqTyn4L9nUxQ45ee1w29c61Q4w/YUx2GAYyuSRnTRj
         8HAwD5XjZ4EzcaKuVDfetSqFo2f6ZZbjRNNucJROPe2op1wpz8RXgcap83Swn0wihYJ3
         NY/4zYfOQphXUV5YXGv/iaKn2h1dQmVbj1shAPXYl9CwU90OdHsUillWp+D4lkzDppIo
         Ds7g==
X-Gm-Message-State: ABy/qLa6hw+D7FZbhLFbyn4eeuFdWl9pWnTKMZlZQg7xAlTPuPiqgOPu
        BQd5B8oYAHBY7SLTe5tg5Bow0i9SNbIH4Yd3
X-Google-Smtp-Source: APBJJlFNdotp1aUxntJ1PcxhVe0Tj4gRjMRawbvy8cUAYmm2HOENmN5k0tB+UvTO3WqkqQqCg+qdwQ==
X-Received: by 2002:a05:6a20:7491:b0:134:1b62:fac0 with SMTP id p17-20020a056a20749100b001341b62fac0mr11632421pzd.51.1690805963016;
        Mon, 31 Jul 2023 05:19:23 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b00687227dd8f1sm3529559pfn.122.2023.07.31.05.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:19:22 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/13] clk: hisilicon: Add helper functions for platform driver
Date:   Mon, 31 Jul 2023 20:18:01 +0800
Message-Id: <20230731121821.22242-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731121821.22242-1-mmyangfl@gmail.com>
References: <20230731121821.22242-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helper functions extract common operations on platform drivers.

During migration to devm APIs, (virtual) fixed clocks were found hard on
devm APIs, since they often depended by crucial peripherals, thus require
early initialization before device probing, and cannot use devm APIs.

One solution to this problem is to add a "fixed-clock" node to device tree,
independent to clock device, and make those peripherals depend on that.
However, there is also some devices that do use fixed clocks provided by
drivers, for example clk-hi3660.c .

To simplify codes, we migrate clocks of other types to devm APIs, while
keep fixed clocks self-managed, alongside with struct hisi_clock_data, and
remove devm-managed hisi_clock_data.

hisi_clk_alloc() will be removed in the following patch.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk.c   | 157 ++++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.h   |  46 +++++++++-
 drivers/clk/hisilicon/crg.h   |   5 ++
 drivers/clk/hisilicon/reset.c |  42 +++++++++
 4 files changed, 248 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc93599..aa8908714cd0 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -88,6 +88,25 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(hisi_clk_init);
 
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
+{
+	if (data->clks) {
+		if (data->clks->fixed_rate_clks_num)
+			hisi_clk_unregister_fixed_rate(data->clks->fixed_rate_clks,
+						       data->clks->fixed_rate_clks_num,
+						       data);
+		if (data->clks->fixed_factor_clks_num)
+			hisi_clk_unregister_fixed_factor(data->clks->fixed_factor_clks,
+							 data->clks->fixed_factor_clks_num,
+							 data);
+	}
+
+	of_clk_del_provider(np);
+	kfree(data->clk_data.clks);
+	kfree(data);
+}
+EXPORT_SYMBOL_GPL(hisi_clk_free);
+
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
 					 int nums, struct hisi_clock_data *data)
 {
@@ -341,3 +360,141 @@ void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+
+static size_t hisi_clocks_get_nr(const struct hisi_clocks *clks)
+{
+	if (clks->nr)
+		return clks->nr;
+
+	return clks->fixed_rate_clks_num + clks->fixed_factor_clks_num +
+		clks->mux_clks_num + clks->phase_clks_num +
+		clks->divider_clks_num + clks->gate_clks_num +
+		clks->gate_sep_clks_num + clks->customized_clks_num;
+}
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks)
+{
+	struct hisi_clock_data *data;
+	int ret;
+
+	data = hisi_clk_init(np, hisi_clocks_get_nr(clks));
+	if (!data)
+		return -ENOMEM;
+	data->clks = clks;
+
+	ret = hisi_clk_register_fixed_rate(clks->fixed_rate_clks,
+					   clks->fixed_rate_clks_num, data);
+	if (ret)
+		goto err;
+
+	ret = hisi_clk_register_fixed_factor(clks->fixed_factor_clks,
+					     clks->fixed_factor_clks_num, data);
+	if (ret)
+		goto err;
+
+	np->data = data;
+	return 0;
+
+err:
+	hisi_clk_free(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_early_init);
+
+static int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+			     struct hisi_clock_data *data)
+{
+	int ret;
+
+	if (clks->mux_clks_num) {
+		ret = hisi_clk_register_mux(clks->mux_clks,
+					    clks->mux_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->phase_clks_num) {
+		ret = hisi_clk_register_phase(dev, clks->phase_clks,
+					      clks->phase_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->divider_clks_num) {
+		ret = hisi_clk_register_divider(clks->divider_clks,
+						clks->divider_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->gate_clks_num) {
+		ret = hisi_clk_register_gate(clks->gate_clks,
+					     clks->gate_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->gate_sep_clks_num) {
+		hisi_clk_register_gate_sep(clks->gate_sep_clks,
+					   clks->gate_sep_clks_num, data);
+	}
+
+	if (clks->clk_register_customized && clks->customized_clks_num) {
+		ret = clks->clk_register_customized(dev, clks->customized_clks,
+						    clks->customized_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int hisi_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct hisi_clocks *clks;
+	struct hisi_clock_data *data;
+	int ret;
+
+	clks = of_device_get_match_data(dev);
+	if (!clks)
+		return -ENOENT;
+
+	if (!np->data) {
+		ret = hisi_clk_early_init(np, clks);
+		if (ret)
+			return ret;
+	}
+
+	data = np->data;
+	np->data = NULL;
+
+	if (clks->prologue) {
+		ret = clks->prologue(dev, data);
+		if (ret)
+			goto err;
+	}
+
+	ret = hisi_clk_register(dev, clks, data);
+	if (ret)
+		goto err;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+err:
+	hisi_clk_free(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_probe);
+
+void hisi_clk_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct hisi_clock_data *data = platform_get_drvdata(pdev);
+
+	hisi_clk_free(np, data);
+}
+EXPORT_SYMBOL_GPL(hisi_clk_remove);
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 7a9b42e1b027..87b17e9b79a3 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -17,10 +17,12 @@
 #include <linux/spinlock.h>
 
 struct platform_device;
+struct hisi_clocks;
 
 struct hisi_clock_data {
-	struct clk_onecell_data	clk_data;
-	void __iomem		*base;
+	struct clk_onecell_data		clk_data;
+	void __iomem			*base;
+	const struct hisi_clocks	*clks;
 };
 
 struct hisi_fixed_rate_clock {
@@ -103,6 +105,39 @@ struct hisi_gate_clock {
 	const char		*alias;
 };
 
+struct hisi_clocks {
+	/* if 0, sum all *_num */
+	size_t nr;
+
+	int (*prologue)(struct device *dev, struct hisi_clock_data *data);
+
+	const struct hisi_fixed_rate_clock *fixed_rate_clks;
+	size_t fixed_rate_clks_num;
+
+	const struct hisi_fixed_factor_clock *fixed_factor_clks;
+	size_t fixed_factor_clks_num;
+
+	const struct hisi_mux_clock *mux_clks;
+	size_t mux_clks_num;
+
+	const struct hisi_phase_clock *phase_clks;
+	size_t phase_clks_num;
+
+	const struct hisi_divider_clock *divider_clks;
+	size_t divider_clks_num;
+
+	const struct hisi_gate_clock *gate_clks;
+	size_t gate_clks_num;
+
+	const struct hisi_gate_clock *gate_sep_clks;
+	size_t gate_sep_clks_num;
+
+	const void *customized_clks;
+	size_t customized_clks_num;
+	int (*clk_register_customized)(struct device *dev, const void *clks,
+				       size_t num, struct hisi_clock_data *data);
+};
+
 struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				const char *, unsigned long,
 				void __iomem *, u8,
@@ -113,6 +148,7 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 
 struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int);
 struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
 				int, struct hisi_clock_data *);
 int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
@@ -154,4 +190,10 @@ hisi_clk_unregister(mux)
 hisi_clk_unregister(divider)
 hisi_clk_unregister(gate)
 
+/* helper functions for platform driver */
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks);
+int hisi_clk_probe(struct platform_device *pdev);
+void hisi_clk_remove(struct platform_device *pdev);
+
 #endif	/* __HISI_CLK_H */
diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index 803f6ba6d7a2..bd8e76b1f6d7 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -22,4 +22,9 @@ struct hisi_crg_dev {
 	const struct hisi_crg_funcs *funcs;
 };
 
+/* helper functions for platform driver */
+
+int hisi_crg_probe(struct platform_device *pdev);
+void hisi_crg_remove(struct platform_device *pdev);
+
 #endif	/* __HISI_CRG_H */
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 93cee17db8b1..c7d4c9ea7183 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -6,11 +6,15 @@
  */
 
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+
+#include "clk.h"
+#include "crg.h"
 #include "reset.h"
 
 #define	HISI_RESET_BIT_MASK	0x1f
@@ -116,3 +120,41 @@ void hisi_reset_exit(struct hisi_reset_controller *rstc)
 	reset_controller_unregister(&rstc->rcdev);
 }
 EXPORT_SYMBOL_GPL(hisi_reset_exit);
+
+int hisi_crg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_crg_dev *crg;
+	int ret;
+
+	crg = devm_kmalloc(dev, sizeof(*crg), GFP_KERNEL);
+	if (!crg)
+		return -ENOMEM;
+
+	ret = hisi_clk_probe(pdev);
+	if (ret)
+		return ret;
+
+	crg->rstc = hisi_reset_init(pdev);
+	if (!crg->rstc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, crg);
+	return 0;
+
+err:
+	hisi_clk_remove(pdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_crg_probe);
+
+void hisi_crg_remove(struct platform_device *pdev)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	hisi_reset_exit(crg->rstc);
+	hisi_clk_remove(pdev);
+}
+EXPORT_SYMBOL_GPL(hisi_crg_remove);
-- 
2.40.1

