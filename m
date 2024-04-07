Return-Path: <linux-kernel+bounces-134636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9089B3F7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C801F214BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BC9405FF;
	Sun,  7 Apr 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZrzm/8m"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C5405DB;
	Sun,  7 Apr 2024 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520948; cv=none; b=Tj21OSFSbr4N9LKHQ9lf7pH0iWTOvUr6P7Te7Ew7VdCKRriKbQywR3QAMW/NIDc+ocUzQrE1K0djTftW9B/FolapaBf5sI02t6GF11+d53vfqJ9Uyf+svgc2KvwIeUB/3mBozhgxBfkV53J7SWQgB4G098jUZDeSKqOQB5TITug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520948; c=relaxed/simple;
	bh=76XjftA/KrWaAs/RyC554gpcc/C1GBVNnSKTMj6RfK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IuyZ4jVuGPV6ZK4t437E6tGTB0BYVB9v9rctARd5jSm07WPT82fFavJefU/nJHxsEsQDDua71LMmQe091aG6VdRvuA5x9Hq/7a5/CG9zY+MH6bg/ki5CHEeLrQ72oRV6QO32jzpi4S11oi9HBJYF5beeCNYC9l1rXuAuj/iqSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZrzm/8m; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so639817466b.1;
        Sun, 07 Apr 2024 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712520944; x=1713125744; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6eQqk7gGTUAVRT9CeP6Y7G5z0ZafAHB/W/7nu1XoWo=;
        b=bZrzm/8m35xAigg+n+mWXn0aJdjTIK3E+yQ4vlLa8wrKbbW3uUk/HgXCZ1gqFpnfSz
         icMv8UHy5qs/OOHvxq4IWzUuRqKmNXDXV3AAX1yQ9nRkEOpq1nmV1RSQj9/VfdBZaNHG
         auL0tWgbPdJoV94Ta/H1fgVZcTu1PX6alQpQ1VTR9oze1ycJQtezJCFxJ8DzuNiMLH0W
         4fbTXynwvQ6tvkUN6pbkXas6KsJt2RmhWldxRnu9qF+p0LJZYYNjCjMLVGCZWvkQg5tx
         P7L8AZuKlEJ+AbNOEAGkKjYskO/vgOjGQxVsBF4DopnxozGCPMTl0iXYcdiCz7nz5mJj
         0luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712520944; x=1713125744;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6eQqk7gGTUAVRT9CeP6Y7G5z0ZafAHB/W/7nu1XoWo=;
        b=dtN1IT+E36AaJDS3bqNhsIXUNFrQS1jGciLCZZjAmB55I95pux4BwSITkBFGsL6RKw
         e1vQp4UNO6TDeqidEYnC94X5jFPIudQfPHd1SZnypggdaMrCPWJQIzMjKLtytReurGTD
         gRcqpKZvu0sa5SDljI44SMKT2//0lGvy3M8k3qjf+85ajdv0caG7Jdh39dIedOwrMNNW
         EpZnSXXQkXoalDpMMCVLLo8t+iE+Bn2hUrqLTB/OQbp5ATXZsQQU+Rp160PGQRQ8i6ea
         D41Jhzp4R/Kmcd4eZM0WvIjwpsuQNkFVG7NnAd1hqwSnI7Z6esnISoDH24IaHS7iuwCY
         7RFA==
X-Forwarded-Encrypted: i=1; AJvYcCVQwFn2RTvqVZeVmrtopprDLauH7KMh9bfgvcMDxO1BjofzPuFfezfvha5bl9OGjCLqzkSQkgzweMuzcPQUgrwOdrSensFKXI6iUJR07bkRWPBrc7e5x4elMQye2Pf8V2jASzGsVaq6DBk=
X-Gm-Message-State: AOJu0YzqWy8mGzgteVFk/VX+3e4+6/RDc+JLFWoVSjT6qEfK4wPQpebG
	By6r1N2V7gk6/MQ2wMmMWNOy5dkoavBv6C6xOYOdoA7e+qmQYl51wb1htPqP3TkNYA==
X-Google-Smtp-Source: AGHT+IG5YM5cfeqUYXvBWMmIzoUk0aO3X5ru2tfzO0tWUfmHRGrKwjFUD4YymbcQPRIBcLrWy5e//w==
X-Received: by 2002:a17:907:9693:b0:a51:b1ab:2903 with SMTP id hd19-20020a170907969300b00a51b1ab2903mr6582767ejc.8.1712520943752;
        Sun, 07 Apr 2024 13:15:43 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906039000b00a51a5c8ea6fsm3393559eja.193.2024.04.07.13.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 13:15:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 07 Apr 2024 22:15:29 +0200
Subject: [PATCH next] cpupfreq: tegra124: eliminate uses of of_node_put()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-cpufreq_of_node_put-v1-1-2c8889d4935d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOD+EmYC/x3MQQqAIBBA0avErBPUrKirREjoWLNR04ogunvS8
 i3+fyBjIswwVg8kvChT8AWirsBsi1+RkS0GyaXiivfMxNMl3HVw2geLOp4H41YMvVyapu0ElDI
 mdHT/1wk83gfM7/sBV8tQ3msAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Julia Lawall <julia.lawall@inria.fr>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712520942; l=2900;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=76XjftA/KrWaAs/RyC554gpcc/C1GBVNnSKTMj6RfK8=;
 b=95c6Mi2WcY3kgBihjHDclcelzfvVrsaeLSngA4Fww1oc27t0iyuuxmytDFcy0ouE1t2/EiTXk
 WcgwJI/3S+QBA8vNURb26iq6wqzmpSMRP1QGb2QK7SX/KnPyykEILLf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Make use of the __free() cleanup handler to automatically free nodes
when they get out of scope. Only the probe function is affected by this
modification.

Given that this mechanism requires the node to be initialized, its
initialization and the value check have been moved to the top of the
function.

After removing uses of of_node_put(), the jump to out_put_np is no
longer necessary.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This patch is a proof of concept to remove uses of of_node_put() in
cpufreq, which can be replaced with the clenaup handler introduced with
54da6a092431 ("locking: Introduce __cleanup() based infrastructure").

This change provides a scope-based cleanup mechanism to avoid potential
memory leaks that can appear if of_node_put() is not used correctly.

The patch is based on the latest linux-next tag (next-20240405).
---
 drivers/cpufreq/tegra124-cpufreq.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index aae951d4e77c..514146d98bca 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -52,12 +52,15 @@ static int tegra124_cpu_switch_to_dfll(struct tegra124_cpufreq_priv *priv)
 
 static int tegra124_cpufreq_probe(struct platform_device *pdev)
 {
+	struct device_node *np __free(device_node) = of_cpu_device_node_get(0);
 	struct tegra124_cpufreq_priv *priv;
-	struct device_node *np;
 	struct device *cpu_dev;
 	struct platform_device_info cpufreq_dt_devinfo = {};
 	int ret;
 
+	if (!np)
+		return -ENODEV;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -66,15 +69,9 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	if (!cpu_dev)
 		return -ENODEV;
 
-	np = of_cpu_device_node_get(0);
-	if (!np)
-		return -ENODEV;
-
 	priv->cpu_clk = of_clk_get_by_name(np, "cpu_g");
-	if (IS_ERR(priv->cpu_clk)) {
-		ret = PTR_ERR(priv->cpu_clk);
-		goto out_put_np;
-	}
+	if (IS_ERR(priv->cpu_clk))
+		return PTR_ERR(priv->cpu_clk);
 
 	priv->dfll_clk = of_clk_get_by_name(np, "dfll");
 	if (IS_ERR(priv->dfll_clk)) {
@@ -110,8 +107,6 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	of_node_put(np);
-
 	return 0;
 
 out_put_pllp_clk:
@@ -122,8 +117,6 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	clk_put(priv->dfll_clk);
 out_put_cpu_clk:
 	clk_put(priv->cpu_clk);
-out_put_np:
-	of_node_put(np);
 
 	return ret;
 }

---
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
change-id: 20240407-cpufreq_of_node_put-0d1972a33561

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


