Return-Path: <linux-kernel+bounces-49492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A4846B0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1C1F2345D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A877642;
	Fri,  2 Feb 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HEVcMwvW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9F7429B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863336; cv=none; b=bUFYkgNuLNadWMLXLVgpqtxyFk/qCbvgCrubFyMG8NlVYfDTBWQ60/WqYkK5I2EG56QD+cSlplFynH4h7bYPxgwa8BA4UMdGlNkMziaof5kUCCLlmVwpYcckjLvuyRuVdToPdqsAkfPhA9s2Bf1v5Lx6bQiNA30UhA/ffoEaIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863336; c=relaxed/simple;
	bh=jZ3wrAg3WdunwbfvNLxFkUjw65+VHGXuZ6j3a0GMwc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojZP3WeW525asKAvZKFzM39vYESm5lrUKB5oqjsRC35qFrYCD/ZYxPcVMqUDinriZ/QFojyGZXXux199pLJAfzifqTJAv/9E7PF4LTm+SQpgY7+q+FQjhR/k+vT9jxOu2uX7fK9qmJQcFBh3rVtIfMDbecLq29oB2tpBGY5yFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HEVcMwvW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2a17f3217aso262203566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863332; x=1707468132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMe2EsCOFj/0fOiVmhxLtZq33Zm/0qJvFbnQUCQS9Lk=;
        b=HEVcMwvWMmTtIkvzKrAHbG9SzlEyAP7Mbzhye5B4HVKz0jziniBogmF5YVC/FVX4Li
         NHE2VZEFdKlzINPaZY34nePviuDdTNH6RQj54urlxnvyY8Ii6Pi+likZLH6AMjHzKVGr
         UOxfaXTU0hUIWFsDsWFmZN0VQAxH9B76g5ivqB3Qs/T7K0oWQ4bjp3taA0Q75pyW9EUp
         2TnprOYd1y6NpItUZai8dkuSvjP+okRAKHjuJ/FmdQ+pXHsr7Rn3+ca/RKOT3lsC6WQn
         phink5Tn8jnLLUiaEKX4nTnVHzhHxKKWaU82/phN8y7zXhbfQOIcAL1MA10WJWgCFQwc
         iOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863332; x=1707468132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMe2EsCOFj/0fOiVmhxLtZq33Zm/0qJvFbnQUCQS9Lk=;
        b=SZG15QiLSe/IFo1ap2zZ5eegW6bpTQIfMn7Pwjz/wwU4p821uznetplFy94K/YLiEn
         MkvrBI/u8RqSECGDO+QcNp1uWdY+XSl7ahoChV8AOeg2+yIdLvrQ0ean6V1eDLAHYctG
         TfLv2tamCmswPvtHLID7nTOJlnWNobpJ2mIhCQn4l5xyNEqwt5hyfzuTvOpNYHuYQT82
         /3CXQUpgMGJlVn8fwFzm/mffFXjPSdjzHWHXuSNhCmfjpr/fstyS8nzZZbXXvALT7juw
         swyzN5iVEyzJBaDoGWGKxgU+X1qpaVDl6edw6r1e//3cX+x0mMAZKP2A4pQX4Sp3PO41
         H/YQ==
X-Gm-Message-State: AOJu0YxzoUqEA5rkWDto82yLwlY4a4gi4gXJ04NlCC3suV4garBXmMiq
	vg9zG9DqQiPFo09xz3rpqJLcPtYAnaZ5BSTZZ3mUTaIb/gT0xgxmHdvI+DIWmjA=
X-Google-Smtp-Source: AGHT+IFk+pB61DX9vBo1JzXqSqp2gldW864VkGgbSCw+b3cwztYr0l3+oPvx2AxFTjRvVGkEW68gtw==
X-Received: by 2002:a17:906:2e87:b0:a35:6bc6:a300 with SMTP id o7-20020a1709062e8700b00a356bc6a300mr5118743eji.61.1706863332358;
        Fri, 02 Feb 2024 00:42:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHFRTAM57GGRPyS7WH41ak8hlPCOds1zYhyTtogNMyE2KQqW+dO9dGg4X5cg4J0W3JWXdf77Ddgb/E6D+IOi8bV/Q/NAfFVHenctbfWN+qt5E723YIM5salXuNCfCUv64/tkm0eIVdZru2kO0lxxLTJZUEhVjJdcWHBr+JNZGpbr5D2uJM1dmTH2rdw8bYLxC95EEUBNhpvc3HVas/n0JxqoVkBL5kLkUvBvsEcrw91oERHS3z9/5R4u7/G9MeItKqLsgb5KegrPXIAlKd2KTAjSDv3wfjj4te+6djS1HFtWvyGPPVB3UQGXwODcqCik3/1Osc02zPviSlZ/PM/ol0nnpfJDaTQ7WhiYzTX0/tC0ucPnzazJ8vHPDu+XGATakpdfoxC8hzODgzRQ==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:42:10 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v6 10/15] net: ravb: Move delay mode set in the driver's ndo_open API
Date: Fri,  2 Feb 2024 10:41:31 +0200
Message-Id: <20240202084136.3426492-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Delay parsing and setting were done in the driver's probe API. As some IP
variants switch to reset mode (and thus the register contents is lost) when
setting clocks (due to module standby functionality) to be able to
implement runtime PM keep the delay parsing in the driver's probe function
and move the delay applying function to the driver's ndo_open API.

Along with it, ravb_parse_delay_mode() function was moved close to
ravb_set_delay_mode() function to have the delay specific code in the
same place.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v6:
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag

Changes in v5:
- fixed typos in patch description
- improved patch description

Changes in v4:
- collected tags

Changes in v3:
- fixed typos in patch description

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 107 ++++++++++++-----------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0f7b1d503618..e5805e0d8e13 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1800,6 +1800,59 @@ static int ravb_compute_gti(struct net_device *ndev)
 	return 0;
 }
 
+/* Set tx and rx clock internal delay modes */
+static void ravb_parse_delay_mode(struct device_node *np, struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	bool explicit_delay = false;
+	u32 delay;
+
+	if (!priv->info->internal_delay)
+		return;
+
+	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay)) {
+		/* Valid values are 0 and 1800, according to DT bindings */
+		priv->rxcidm = !!delay;
+		explicit_delay = true;
+	}
+	if (!of_property_read_u32(np, "tx-internal-delay-ps", &delay)) {
+		/* Valid values are 0 and 2000, according to DT bindings */
+		priv->txcidm = !!delay;
+		explicit_delay = true;
+	}
+
+	if (explicit_delay)
+		return;
+
+	/* Fall back to legacy rgmii-*id behavior */
+	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
+	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) {
+		priv->rxcidm = 1;
+		priv->rgmii_override = 1;
+	}
+
+	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
+	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) {
+		priv->txcidm = 1;
+		priv->rgmii_override = 1;
+	}
+}
+
+static void ravb_set_delay_mode(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	u32 set = 0;
+
+	if (!priv->info->internal_delay)
+		return;
+
+	if (priv->rxcidm)
+		set |= APSR_RDM;
+	if (priv->txcidm)
+		set |= APSR_TDM;
+	ravb_modify(ndev, APSR, APSR_RDM | APSR_TDM, set);
+}
+
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
 {
@@ -1811,6 +1864,8 @@ static int ravb_open(struct net_device *ndev)
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	ravb_set_delay_mode(ndev);
+
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
@@ -2531,41 +2586,6 @@ static int ravb_set_config_mode(struct net_device *ndev)
 	return error;
 }
 
-/* Set tx and rx clock internal delay modes */
-static void ravb_parse_delay_mode(struct device_node *np, struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	bool explicit_delay = false;
-	u32 delay;
-
-	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay)) {
-		/* Valid values are 0 and 1800, according to DT bindings */
-		priv->rxcidm = !!delay;
-		explicit_delay = true;
-	}
-	if (!of_property_read_u32(np, "tx-internal-delay-ps", &delay)) {
-		/* Valid values are 0 and 2000, according to DT bindings */
-		priv->txcidm = !!delay;
-		explicit_delay = true;
-	}
-
-	if (explicit_delay)
-		return;
-
-	/* Fall back to legacy rgmii-*id behavior */
-	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) {
-		priv->rxcidm = 1;
-		priv->rgmii_override = 1;
-	}
-
-	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) {
-		priv->txcidm = 1;
-		priv->rgmii_override = 1;
-	}
-}
-
 static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 			  const char *ch, int *irq, irq_handler_t handler)
 {
@@ -2650,18 +2670,6 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
 }
 
-static void ravb_set_delay_mode(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	u32 set = 0;
-
-	if (priv->rxcidm)
-		set |= APSR_RDM;
-	if (priv->txcidm)
-		set |= APSR_TDM;
-	ravb_modify(ndev, APSR, APSR_RDM | APSR_TDM, set);
-}
-
 static int ravb_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -2785,10 +2793,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_rpm_put;
 
-	if (info->internal_delay) {
-		ravb_parse_delay_mode(np, ndev);
-		ravb_set_delay_mode(ndev);
-	}
+	ravb_parse_delay_mode(np, ndev);
 
 	/* Allocate descriptor base address table */
 	priv->desc_bat_size = sizeof(struct ravb_desc) * DBAT_ENTRY_NUM;
-- 
2.39.2


