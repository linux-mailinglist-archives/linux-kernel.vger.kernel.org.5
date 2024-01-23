Return-Path: <linux-kernel+bounces-35299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10AD838F36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0B31F28B81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF97605DA;
	Tue, 23 Jan 2024 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="L6A1GV/F"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE1604D7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014787; cv=none; b=TRGJokW3bTieE77Z7cUkz0GzqLZ3atWg2DRO3F4MZn49w1wx/wOiTIiFJxP5IGhUtDuA/Nc3XPtjqdELp4rRtiFfFAcp37iQi3G5JaDC/yiTTzFZFmUfGDnpnW0AdTpKiO7fHgl1+OyDqhTuy587Djq8moXeFLzvRq8LSoKQx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014787; c=relaxed/simple;
	bh=66YZ7j3bbfBxS5uutkyub/JMoxPJjimQzdpNYerbURw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXikdECRLtYZ+YOFn4amIZ2eLgOFU2YeM51ynaRuqJeSzv15/xMntp4qih19abfWtM4F7i9yICIuGX5xnKPCWd5lPiU1sWDMKb25xPsCRzJf0Wv3X4/NRAgLZXnaKy7lfQk3xHtZjEfTsTu1ESxhxerkg+M+cUrCb7Y+RFiihTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=L6A1GV/F; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so22622445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706014783; x=1706619583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPYX9VHMb5f2krEz/XFumSk5tOXOzxIPHZoPxQJGoC4=;
        b=L6A1GV/FBHtkjnElUV806ttJngEDL/dkL9hZj1AYA8I+FnuP135SIp0EPy49B0XsgB
         cLn6L592+4NN/8YJ7m7Hzm3EZ2svMdYG0F+N8ssgFF9mDr+ncEiZPGV5AAbCo2FonemT
         AmnYyoP8xuiLiYTnB3YZwWfkWAgOBMmq5La+q21dDMe6NQkzfh/Ji0gIAQ3270XkGpke
         Cx6+j+AH0kTdVgnoK5Plg0tg+OigLhEK7bifyfOPjEcbKbc83K48PTEVO94PoL4WQFo3
         7C7gqr23EJT9y2DueSqL9qT+7TqtSs1t82lx/9l1B5OkiTbK4hsdCCkj2N30B2O7yAzx
         sS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014783; x=1706619583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPYX9VHMb5f2krEz/XFumSk5tOXOzxIPHZoPxQJGoC4=;
        b=fYLISqcP43Ria/+NIXDvCSUy7OG87DqfXkBxZ9zYm+dROGfMf0cqRumEcPm6RtfLJC
         qFAtSv4f1PEf3Bu6mZ3yoF9uQR547bWxOixBl+ZHk1NPLyLxpeoI5Ue8hujs3uSIZowF
         U3aqrqfWqHahwegUB2sz0a2teWRMCp0bW5VM8/LZUbD6soAuTjAfl1MV0ywCq7ZMggdS
         PesZ2W9XprudHfmPpD+oFQe+qKbeDrZOLU13S60jsck3ZyFjybD9EbIIx+sxlWJR3KKS
         i6gPEC8OdwaEPZeFs9js5ZWju5Db10nlut8OXAIQ21PmP2xs4LR8ot1BRx2HUq3c91d4
         Ippw==
X-Gm-Message-State: AOJu0Yw8qq1a+ELjSKmu9ix4iJAXgizK9Q6LDxk1t9CtBZx2fxfedfvW
	1cMuRc/MmdKywaXI912H52bk7UGvXmSEcT/MHWkrVbtpGAt84Dkj6+CbLxWTtnk=
X-Google-Smtp-Source: AGHT+IE9Q3DU+PUy1VAqj0vkb2chQI/LqQSeoFS3iyf8ioxJySqdNOVF5WdNSAyWwlVlqRZ5rc4B4g==
X-Received: by 2002:a05:600c:2305:b0:40e:4913:58b5 with SMTP id 5-20020a05600c230500b0040e491358b5mr105852wmo.174.1706014783526;
        Tue, 23 Jan 2024 04:59:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c45c400b0040e6ff60057sm33655711wmo.48.2024.01.23.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:59:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v4 09/15] net: ravb: Split GTI computation and set operations
Date: Tue, 23 Jan 2024 14:58:23 +0200
Message-Id: <20240123125829.3970325-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

ravb_set_gti() was computing the value of GTI based on the reference clock
rate and then applied it to register. This was done on the driver's probe
function. In order to implement runtime PM for all IP variants (as some IP
variants switches to reset mode (and thus the registers content is lost)
when module standby is configured through clock APIs) the GTI setup was
split in 2 parts: one computing the value of the GTI register (done in the
driver's probe function) and one applying the computed value to register
(done in the driver's ndo_open API).

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- fixed typos in patch description
- use u64 instead of uint64_t
- remove ravb_wait() for setting GCCR.LTI

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb.h      |  2 +
 drivers/net/ethernet/renesas/ravb_main.c | 96 ++++++++++++------------
 2 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index e3506888cca6..268ccfafe7aa 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1102,6 +1102,8 @@ struct ravb_private {
 
 	const struct ravb_hw_info *info;
 	struct reset_control *rstc;
+
+	u32 gti_tiv;
 };
 
 static inline u32 ravb_read(struct net_device *ndev, enum ravb_reg reg)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 724c11c747a6..8956c33c60e2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1756,6 +1756,50 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
+static void ravb_set_gti(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+
+	if (!(info->gptp || info->ccc_gac))
+		return;
+
+	ravb_write(ndev, priv->gti_tiv, GTI);
+
+	/* Request GTI loading */
+	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+}
+
+static int ravb_compute_gti(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = ndev->dev.parent;
+	unsigned long rate;
+	u64 inc;
+
+	if (!(info->gptp || info->ccc_gac))
+		return 0;
+
+	if (info->gptp_ref_clk)
+		rate = clk_get_rate(priv->gptp_clk);
+	else
+		rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -EINVAL;
+
+	inc = div64_ul(1000000000ULL << 20, rate);
+
+	if (inc < GTI_TIV_MIN || inc > GTI_TIV_MAX) {
+		dev_err(dev, "gti.tiv increment 0x%llx is outside the range 0x%x - 0x%x\n",
+			inc, GTI_TIV_MIN, GTI_TIV_MAX);
+		return -EINVAL;
+	}
+	priv->gti_tiv = inc;
+
+	return 0;
+}
+
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
 {
@@ -1773,6 +1817,8 @@ static int ravb_open(struct net_device *ndev)
 		goto out_napi_off;
 	ravb_emac_init(ndev);
 
+	ravb_set_gti(ndev);
+
 	/* Initialise PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_init(ndev, priv->pdev);
@@ -2464,34 +2510,6 @@ static const struct of_device_id ravb_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
 
-static int ravb_set_gti(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-	struct device *dev = ndev->dev.parent;
-	unsigned long rate;
-	uint64_t inc;
-
-	if (info->gptp_ref_clk)
-		rate = clk_get_rate(priv->gptp_clk);
-	else
-		rate = clk_get_rate(priv->clk);
-	if (!rate)
-		return -EINVAL;
-
-	inc = div64_ul(1000000000ULL << 20, rate);
-
-	if (inc < GTI_TIV_MIN || inc > GTI_TIV_MAX) {
-		dev_err(dev, "gti.tiv increment 0x%llx is outside the range 0x%x - 0x%x\n",
-			inc, GTI_TIV_MIN, GTI_TIV_MAX);
-		return -EINVAL;
-	}
-
-	ravb_write(ndev, inc, GTI);
-
-	return 0;
-}
-
 static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2763,15 +2781,9 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_rpm_put;
 
-	if (info->gptp || info->ccc_gac) {
-		/* Set GTI value */
-		error = ravb_set_gti(ndev);
-		if (error)
-			goto out_rpm_put;
-
-		/* Request GTI loading */
-		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
-	}
+	error = ravb_compute_gti(ndev);
+	if (error)
+		goto out_rpm_put;
 
 	if (info->internal_delay) {
 		ravb_parse_delay_mode(np, ndev);
@@ -2984,15 +2996,7 @@ static int ravb_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (info->gptp || info->ccc_gac) {
-		/* Set GTI value */
-		ret = ravb_set_gti(ndev);
-		if (ret)
-			return ret;
-
-		/* Request GTI loading */
-		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
-	}
+	ravb_set_gti(ndev);
 
 	if (info->internal_delay)
 		ravb_set_delay_mode(ndev);
-- 
2.39.2


