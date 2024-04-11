Return-Path: <linux-kernel+bounces-139923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5378A092D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474BB283885
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAECC13F003;
	Thu, 11 Apr 2024 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZS5Om35"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEFD13F007;
	Thu, 11 Apr 2024 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819204; cv=none; b=BUXPEIG0SvQK6QD4xSVE6Ah0xR5cfBo763cwdheGSXb0DhDkUWpIniJXdgICTtWxIb81wSNhrXXJkEXGaAMyQoSqrQsFReb1LGRq+AfX3HerMKmHCjVei64UaSLAlZIvrGE1FWLgA41xzmOAOtLeZ5C7O7rnzSJeNRu0zAAVkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819204; c=relaxed/simple;
	bh=CoPdM7gWgxzc4l9ttrmWpcv9QLyj1sEO29fhIflzIZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD9oQSg8hpt6XqdWpXF5P472cA3PRARj9sI0zFiT7K8kpW3EnaHJeeiIkQdlwctwhgTOz4LhkkBMlr+sFBck30aBAHbXnKFm6txdJRjEySqEjgSUOF7Ezhl6mNLtJn7JWEn+Mxv9KBoUCtSJ8ijZcuf+dG5AZ4Qu+4jDkNhbGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZS5Om35; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecf406551aso5365611b3a.2;
        Thu, 11 Apr 2024 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819202; x=1713424002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVxLPB3ir51RqOrUeQ4RuKuT1LuXZfsGpQp9xlrvQqA=;
        b=hZS5Om35x8gGgz3/xdzgM2sbjvMfftZDjTNoOa19sgXcXS0Al1nkvwkCasqQNv6Lav
         IKSW98OfFGjjXC7KQiUCaAmAFTBo0ylGzrSoZsU3xAOOjc/qa7eK2Z/gZv+SxnU9AteS
         Hr/PzkXNZ0jTtDk6dUhrfQmspRPCsU6ufIqJMYP4jU9VpCVk2O5qSZ1Y5pJA/AhitwwH
         XDIQ5FszCGXHUQeW0ItKJDxoidK8UnbF6Ujxm/QJqkYA4jNPVVYBPGqYqzGv4mZfNLJr
         ANamj+NNudoZEKT4gvqbGQrv3SIODFeWQ00B0Gc5rN32LMZdpn1pWZW+gx9VZwrVzhRT
         7Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819202; x=1713424002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVxLPB3ir51RqOrUeQ4RuKuT1LuXZfsGpQp9xlrvQqA=;
        b=Ze5K1P6kRX3VX+pTlsZi3MsUkwlvNa65SsBCMnknpYNPnpeLAhmvuJrPjiUQfUAWN5
         itkqHxRroCMtZgCbQdB59x8v27FyiICPmDSV0XMczWn4Rau6WteYy68DY34vnPHfnAoS
         IGCQVZLq1Cw2UdLZbG8CS0mudjbH0rKVvl6BE4TDyoCqxvY3O47o+MbkM3NfnpYZMxwW
         s7ycKwGP9c/4L7Gn8OflYmOOZwqO9gM+udnj0emQRkoWvkgrVqK4XcqUa7lgA58TBGwq
         z7mniwfD4UvdoFHxJzArSSYHNXYjlzUxmvYWeV5A2sV8/vgyeua5EM1eDvBkRB0SaPwT
         0jOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoOeu/mPBqRrJ2xGtRA5EOUrN1J0tv6rf5xt/97rUXDl4NqHNrR5Vsue/5CUotF4dHbRRYH+ihNQkGyuNV0suDtOSY9U1iBkMrxMXb
X-Gm-Message-State: AOJu0YxiRePpzK1t8qDtT40AKEI3LPzkzTvBAg9CmnRJWbWELy/hXR7x
	SeEeGrwTglXkVwdMVitBfGdDvTj1Qzxb6r5mkjAq35tt1NLp/kHIwUT74OFO
X-Google-Smtp-Source: AGHT+IEsoySlg/IoPcuv/Q17w5RW1t3NP492Gd5CeJgXJm79j2TQMX8KwWgDe2hNgERwxHUb9E2Nlw==
X-Received: by 2002:a05:6a21:3d85:b0:1a7:a8ea:794c with SMTP id bj5-20020a056a213d8500b001a7a8ea794cmr4915020pzc.18.1712819202149;
        Thu, 11 Apr 2024 00:06:42 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:41 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 07/13] clk: hisilicon: hi3660: Convert into module
Date: Thu, 11 Apr 2024 15:04:52 +0800
Message-ID: <20240411070503.38093-9-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411070503.38093-2-mmyangfl@gmail.com>
References: <20240411070503.38093-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3660.c | 194 ++++++++---------------------
 1 file changed, 54 insertions(+), 140 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 50f13dbb0e48..7fc5c16e5264 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -5,9 +5,13 @@
  */
 
 #include <dt-bindings/clock/hi3660-clock.h>
+
 #include <linux/clk-provider.h>
-#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
@@ -469,169 +473,79 @@ static const struct hisi_gate_clock hi3660_iomcu_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x90, 0, 0, },
 };
 
-static struct hisi_clock_data *clk_crgctrl_data;
-
-static void hi3660_clk_iomcu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3660_iomcu_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
-				   clk_data);
-}
-
-static void hi3660_clk_pmuctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pmu_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3660_pmu_gate_clks,
-			       ARRAY_SIZE(hi3660_pmu_gate_clks), clk_data);
-}
+static const struct hisi_clocks hi3660_clk_iomcu_clks = {
+	.gate_sep_clks = hi3660_iomcu_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
+};
 
-static void hi3660_clk_pctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pctrl_gate_clks);
+static const struct hisi_clocks hi3660_clk_pmuctrl_clks = {
+	.gate_clks = hi3660_pmu_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_pmu_gate_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3660_pctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_pctrl_gate_clks), clk_data);
-}
+static const struct hisi_clocks hi3660_clk_pctrl_clks = {
+	.gate_clks = hi3660_pctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_pctrl_gate_clks),
+};
 
-static void hi3660_clk_sctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_sctrl_gate_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_mux_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_divider_clks);
+static const struct hisi_clocks hi3660_clk_sctrl_clks = {
+	.mux_clks = hi3660_sctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3660_sctrl_mux_clks),
+	.divider_clks = hi3660_sctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3660_sctrl_divider_clks),
+	.gate_clks = hi3660_sctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_sctrl_gate_clks),
+	.gate_sep_clks = hi3660_sctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3660_sctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_sctrl_gate_clks), clk_data);
-	hisi_clk_register_gate_sep(hi3660_sctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_mux(hi3660_sctrl_mux_clks,
-			      ARRAY_SIZE(hi3660_sctrl_mux_clks), clk_data);
-	hisi_clk_register_divider(hi3660_sctrl_divider_clks,
-				  ARRAY_SIZE(hi3660_sctrl_divider_clks),
-				  clk_data);
-}
+static const struct hisi_clocks hi3660_clk_crgctrl_clks = {
+	.fixed_rate_clks = hi3660_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3660_fixed_rate_clks),
+	.fixed_factor_clks = hi3660_crg_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
+	.mux_clks = hi3660_crgctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3660_crgctrl_mux_clks),
+	.divider_clks = hi3660_crgctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3660_crgctrl_divider_clks),
+	.gate_clks = hi3660_crgctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_crgctrl_gate_clks),
+	.gate_sep_clks = hi3660_crgctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
+};
 
 static void hi3660_clk_crgctrl_early_init(struct device_node *np)
 {
-	int nr = ARRAY_SIZE(hi3660_fixed_rate_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_gate_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_mux_clks) +
-		 ARRAY_SIZE(hi3660_crg_fixed_factor_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_divider_clks);
-	int i;
-
-	clk_crgctrl_data = hisi_clk_init(np, nr);
-	if (!clk_crgctrl_data)
-		return;
-
-	for (i = 0; i < nr; i++)
-		clk_crgctrl_data->clk_data.clks[i] = ERR_PTR(-EPROBE_DEFER);
-
-	hisi_clk_register_fixed_rate(hi3660_fixed_rate_clks,
-				     ARRAY_SIZE(hi3660_fixed_rate_clks),
-				     clk_crgctrl_data);
+	hisi_clk_early_init(np, &hi3660_clk_crgctrl_clks);
 }
 CLK_OF_DECLARE_DRIVER(hi3660_clk_crgctrl, "hisilicon,hi3660-crgctrl",
 		      hi3660_clk_crgctrl_early_init);
 
-static void hi3660_clk_crgctrl_init(struct device_node *np)
-{
-	struct clk **clks;
-	int i;
-
-	if (!clk_crgctrl_data)
-		hi3660_clk_crgctrl_early_init(np);
-
-	/* clk_crgctrl_data initialization failed */
-	if (!clk_crgctrl_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3660_crgctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
-				   clk_crgctrl_data);
-	hisi_clk_register_gate(hi3660_crgctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_crgctrl_gate_clks),
-			       clk_crgctrl_data);
-	hisi_clk_register_mux(hi3660_crgctrl_mux_clks,
-			      ARRAY_SIZE(hi3660_crgctrl_mux_clks),
-			      clk_crgctrl_data);
-	hisi_clk_register_fixed_factor(hi3660_crg_fixed_factor_clks,
-				       ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
-				       clk_crgctrl_data);
-	hisi_clk_register_divider(hi3660_crgctrl_divider_clks,
-				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
-				  clk_crgctrl_data);
-
-	clks = clk_crgctrl_data->clk_data.clks;
-	for (i = 0; i < clk_crgctrl_data->clk_data.clk_num; i++) {
-		if (IS_ERR(clks[i]) && PTR_ERR(clks[i]) != -EPROBE_DEFER)
-			pr_err("Failed to register crgctrl clock[%d] err=%ld\n",
-			       i, PTR_ERR(clks[i]));
-	}
-}
-
 static const struct of_device_id hi3660_clk_match_table[] = {
 	{ .compatible = "hisilicon,hi3660-crgctrl",
-	  .data = hi3660_clk_crgctrl_init },
+	  .data = &hi3660_clk_crgctrl_clks },
 	{ .compatible = "hisilicon,hi3660-pctrl",
-	  .data = hi3660_clk_pctrl_init },
+	  .data = &hi3660_clk_pctrl_clks },
 	{ .compatible = "hisilicon,hi3660-pmuctrl",
-	  .data = hi3660_clk_pmuctrl_init },
+	  .data = &hi3660_clk_pmuctrl_clks },
 	{ .compatible = "hisilicon,hi3660-sctrl",
-	  .data = hi3660_clk_sctrl_init },
+	  .data = &hi3660_clk_sctrl_clks },
 	{ .compatible = "hisilicon,hi3660-iomcu",
-	  .data = hi3660_clk_iomcu_init },
+	  .data = &hi3660_clk_iomcu_clks },
 	{ }
 };
-
-static int hi3660_clk_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
-	void (*init_func)(struct device_node *np);
-
-	init_func = of_device_get_match_data(dev);
-	if (!init_func)
-		return -ENODEV;
-
-	init_func(np);
-
-	return 0;
-}
+MODULE_DEVICE_TABLE(of, hi3660_clk_match_table);
 
 static struct platform_driver hi3660_clk_driver = {
-	.probe          = hi3660_clk_probe,
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
 	.driver         = {
 		.name   = "hi3660-clk",
 		.of_match_table = hi3660_clk_match_table,
 	},
 };
 
-static int __init hi3660_clk_init(void)
-{
-	return platform_driver_register(&hi3660_clk_driver);
-}
-core_initcall(hi3660_clk_init);
+module_platform_driver(hi3660_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3660 Clock Driver");
-- 
2.43.0


