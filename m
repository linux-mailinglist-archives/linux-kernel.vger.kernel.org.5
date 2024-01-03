Return-Path: <linux-kernel+bounces-15266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59485822960
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25702852F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF8182A7;
	Wed,  3 Jan 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MSd03c94"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1463182DF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so7943214a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 00:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704269650; x=1704874450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3Ym4A7BbOoEfvsp/Jf7JMIgBawRWmRnv6gC4m6vgIE=;
        b=MSd03c94cSB0j2Ml+LDjc0lrkaunqkHakBZ8nHDcTlrSdj9gaTdqxIGNsQ4Uxjvr+b
         J+eSoLk1cJLp4iX9Uw/qt3thDMyFHHrXzQzNE3PtA+JKlevqmA4d8JW/WpwsesczOc6r
         23obIejFuiWUKp/FscVgwq8gF/Ln5g5x7GSwDuluFIQoKBuTLjHRpT+7Owjs/ekDOGKb
         P98MCew5E5N7SdlkROhush75W+PEpmbL/8lquMH0LuWOSwDFTBmfrvaZPcnUcj/yQKI4
         x/PQ0lGKff+/ZDGlM4cwnEmvJtObRlKz4uX6FMJFYmaGXQz+3BFtNLKK6vcwzlRuvztx
         eOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704269650; x=1704874450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3Ym4A7BbOoEfvsp/Jf7JMIgBawRWmRnv6gC4m6vgIE=;
        b=r2GFYkCDpU53NqiXVrjHeegX8b9J6sNrsIfhtpJSwikQImajiy5KNU/LNBktGdMtaR
         /mLlzmp9Y7zfFAurlrLbAxM/E9KDddIVp7E/YZpHIOFGgRpKcpOpqsiZc4wmUTLpriLn
         PStJY6G21fcXOmZRzb/ntomVdd3dnzloSwLFQURLRqmhNj31gNeoe2orrAbNwHDejSVD
         DA1WxFOR7pscsxUqFtsFJfa39BH6S4MEDmkbLNx2crqdMcee+jARzDcLnSfHh39OO5uM
         jgdnS+14Ck3SI2CILZkGNnIPUXrezme8hLyj0qw6q5KzphF9sJb6CngsabJMY70iddj0
         nZJw==
X-Gm-Message-State: AOJu0YwqHtm+aQ57Ed3cprZBXQ4/ciezPHuqK3fZvTty4HBLeVrTw7nj
	JY6BJFKLvizSOktVUBSq0yZk48nfwF5W1Q==
X-Google-Smtp-Source: AGHT+IFHoJNjn4t10m0M3DuDGFBwatp7Fw+n3FDWpeiLND7uz5GFZTVIQZsyO78e0k+de0LYcsoTAw==
X-Received: by 2002:a50:aad2:0:b0:553:b4d8:737 with SMTP id r18-20020a50aad2000000b00553b4d80737mr12543096edc.0.1704269650109;
        Wed, 03 Jan 2024 00:14:10 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id cn13-20020a0564020cad00b00554b089f1dcsm13104196edb.38.2024.01.03.00.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 00:14:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mitsuhiro.kimura.kc@renesas.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 1/1] net: ravb: Wait for operating mode to be applied
Date: Wed,  3 Jan 2024 10:13:53 +0200
Message-Id: <20240103081353.4165445-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103081353.4165445-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240103081353.4165445-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

CSR.OPS bits specify the current operating mode and (according to
documentation) they are updated by HW when the operating mode change
request is processed. To comply with this check CSR.OPS before proceeding.

Commit introduces ravb_set_opmode() that does all the necessities for
setting the operating mode (set CCC.OPC (and CCC.GAC, CCC.CSEL, if any) and
wait for CSR.OPS) and call it where needed. This should comply with all the
HW manuals requirements as different manual variants specify that different
modes need to be checked in CSR.OPS when setting CCC.OPC.

If gPTP active in config mode is supported and it needs to be enabled, the
CCC.GAC and CCC.CSEL needs to be configured along with CCC.OPC in the same
write access. For this, ravb_set_opmode() allows passing GAC and CSEL as
part of opmode and the function updates accordingly CCC register.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/net/ethernet/renesas/ravb_main.c | 65 +++++++++++++++---------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 664eda4b5a11..8649b3e90edb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -66,16 +66,27 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
 	return -ETIMEDOUT;
 }
 
-static int ravb_config(struct net_device *ndev)
+static int ravb_set_opmode(struct net_device *ndev, u32 opmode)
 {
+	u32 csr_ops = 1U << (opmode & CCC_OPC);
+	u32 ccc_mask = CCC_OPC;
 	int error;
 
-	/* Set config mode */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
-	/* Check if the operating mode is changed to the config mode */
-	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
-	if (error)
-		netdev_err(ndev, "failed to switch device to config mode\n");
+	/* If gPTP active in config mode is supported it needs to be configured
+	 * along with CSEL and operating mode in the same access. This is a
+	 * hardware limitation.
+	 */
+	if (opmode & CCC_GAC)
+		ccc_mask |= CCC_GAC | CCC_CSEL;
+
+	/* Set operating mode */
+	ravb_modify(ndev, CCC, ccc_mask, opmode);
+	/* Check if the operating mode is changed to the requested one */
+	error = ravb_wait(ndev, CSR, CSR_OPS, csr_ops);
+	if (error) {
+		netdev_err(ndev, "failed to switch device to requested mode (%u)\n",
+			   opmode & CCC_OPC);
+	}
 
 	return error;
 }
@@ -673,7 +684,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 	int error;
 
 	/* Set CONFIG mode */
-	error = ravb_config(ndev);
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	if (error)
 		return error;
 
@@ -682,9 +693,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Setting the control will start the AVB-DMAC process. */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
-
-	return 0;
+	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
 }
 
 static void ravb_get_tx_tstamp(struct net_device *ndev)
@@ -1046,7 +1055,7 @@ static int ravb_stop_dma(struct net_device *ndev)
 		return error;
 
 	/* Stop AVB-DMAC process */
-	return ravb_config(ndev);
+	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
 /* E-MAC interrupt handler */
@@ -2560,21 +2569,25 @@ static int ravb_set_gti(struct net_device *ndev)
 	return 0;
 }
 
-static void ravb_set_config_mode(struct net_device *ndev)
+static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
 
 	if (info->gptp) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+		if (error)
+			return error;
 		/* Set CSEL value */
 		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
 	} else if (info->ccc_gac) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG |
-			    CCC_GAC | CCC_CSEL_HPB);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
 	} else {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	}
+
+	return error;
 }
 
 /* Set tx and rx clock internal delay modes */
@@ -2794,7 +2807,9 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_disable_gptp_clk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
@@ -2917,8 +2932,7 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
 	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
@@ -3000,8 +3014,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	int ret = 0;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
-	if (priv->wol_enabled)
-		ravb_write(ndev, CCC_OPC_RESET, CCC);
+	if (priv->wol_enabled) {
+		ret = ravb_set_opmode(ndev, CCC_OPC_RESET);
+		if (ret)
+			return ret;
+	}
 
 	/* All register have been reset to default values.
 	 * Restore all registers which where setup at probe time and
@@ -3009,7 +3026,9 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	 */
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	ret = ravb_set_config_mode(ndev);
+	if (ret)
+		return ret;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
-- 
2.39.2


