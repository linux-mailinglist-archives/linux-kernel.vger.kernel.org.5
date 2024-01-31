Return-Path: <linux-kernel+bounces-46031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6260843989
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BD6B27112
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BDD762E0;
	Wed, 31 Jan 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WB5gRiGg"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413F69951
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690523; cv=none; b=eItYkEEHGS84dEtQ/me0caaAnAr80Fe+BB3rc4JF86rwM0FTjrz2FPOlvY22sdBwSNbslDU6KflfAUDBR4cnADEL40ale0rkQV1cbvjYvUTs8zRPdUASFWAAFTRQ1mtIlKiRMJ00gr/SMMM9f6iXqgSd8a4odpRc7Y2TGtgSFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690523; c=relaxed/simple;
	bh=Tl9EE4rSqsLaclcX/s9TRCT5vjw2U2y2/W8A3V/zf38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REof9bQ0ZfIY+LHk+d/aQQUHIF8o8jBQcX+R6mlxO2YW9PEkcPu9WiOx5N9nFmkDCNuegR3ccf8LLPcAjvO4VODHkopwyP0MWVRp8nA/IVx9ta+y0ASDL4m9hXw/AjuCgQjGMX+iRrZkDvY1It0lANJKKrW8QaTOJeMfl1ZNMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WB5gRiGg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf2adac1ccso57059101fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690520; x=1707295320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOBNXx2ouuErkvp20qBEr9vbTwPM99kJ0Yx6JPusU6c=;
        b=WB5gRiGgOfX3jqysJlbDF7pEMokYyqw7/f/swlQSaBM2boFD4xdJmaV7+xsSIYfWtz
         Ga2rDrPAj9t9JX2IX/QinsNv14b9yLfsNP/SS4c0/IoePJKnQ54JfkJkuohipk2WZzbM
         P9QSn7KnKyTcks+H9XNCihEz8krvXoefmk3t3xxzJk10Lf0baqxfEK8Ck/rws0gwgEiu
         EddRL/j/CMRex436gGklNA8Emy4DqWwcBjjRE6HyQWJYS4BTnltlg7AjwfDE5q2NQg5l
         e0hUHgt49GjC9pBpfp13xyNbfv4tVudYqzP3/QFzv+jzBHvk7wOJndEw5TLLLpepaFOi
         yyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690520; x=1707295320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOBNXx2ouuErkvp20qBEr9vbTwPM99kJ0Yx6JPusU6c=;
        b=ZRtgHQ4GKwfEv/zJ8pcXfusz5hTGdb997QHsRKul5RGT5lYrhNGeiupQqWo91z1kEA
         RH4nNZo8y4Wiy9M8/qbv1YBTuN9Eg/rP88RUH9oFv0ZzQ8x1JV1EpJ3AEfqo8u9w4Jbw
         3DB/yGL5Yr0qLl2zPJwRROEQlyIIxmsp+E2yCLvHUQimTA0oII/KZ0Bvt94HTs/mp9va
         ZeRzjTpfBed68/TcgwSH5PeMUjTC5DiYqV3MO/tslo6cDmPUG60RdPQRaVE1XEUBbExx
         GJGdTNopCK0fBd2b559q55AaPFGgcfbSxtFQoYHgzF9J3OyQ/uo21t0fsHg9hg9B57Mt
         HQ0w==
X-Gm-Message-State: AOJu0YyAYy/1LtpUZ5JSt59a0Q5WNYieEogWHK8zN4LJVZQNHZNzWMHc
	61VTKHa1p27/6dzPtNnW7s2IoEidwpqOaarJ7MqdZml0n+saCof2Jesq+bA7ufE=
X-Google-Smtp-Source: AGHT+IEy54eqGheW/EcWLkVM1buIOI5MscBwZx+E5+NeZmv6WTH76R9G6m2m4IJBp0Kg9+eYzgAL8w==
X-Received: by 2002:a2e:a687:0:b0:2ce:19d:2118 with SMTP id q7-20020a2ea687000000b002ce019d2118mr516799lje.6.1706690519652;
        Wed, 31 Jan 2024 00:41:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX5OZwG3k4GNd39QHlTcc5E9v6eJdTIABspjil8bPAO7sdAtLA+9npvhHYSz2JSgV0riKTS6KTUQagdYE53HoRbW7qcXIUhi/uGIePJDGKlwdJ38B6etmmx6f5q/B0o3FTZ2CNOSqwWgoVmx30vGw/b/QlpTc10Rw4O12+KMefjkk/pYqKdGfnpIeI9DNHj7xo3aCZdSLpBmCPQdLPidfLQoLpVghAId5Aifu51bmfH2lCLUnsh8+PtVA/kwEL1p2fi87aSjr5hCw1SnTaGfPV51fh4i7MIpHJ92c3cJpln1ABEktaNg4KO+uhOMIBWYQ4GA1bj54yUnb7MkivTn/ujMSp3e4+eqz213PpguBBkS4EdgL6QLPT5A3gMihr+qvCAyE/CdouoZXC4xRDfnBPCdyxxi9mq3vnca8gQyksVVvITnHA=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:41:59 -0800 (PST)
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
Subject: [PATCH net-next v5 10/15] net: ravb: Move delay mode set in the driver's ndo_open API
Date: Wed, 31 Jan 2024 10:41:28 +0200
Message-Id: <20240131084133.1671440-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
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

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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


