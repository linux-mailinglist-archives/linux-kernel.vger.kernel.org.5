Return-Path: <linux-kernel+bounces-46037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA25484399C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5D31C27574
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40477F488;
	Wed, 31 Jan 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="djfqqTDn"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094857BB0F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690531; cv=none; b=coOHJCMG4RoH3829oVFSldW5atFilh+uYgRKWu6MiC06jtR8dx9wr5Oo4AZ7ayWxtpq8+mr2+1RP7SaphlfK/xBG+EUGMwAdzeF92IFa2EZDgNNJMSHd9Pfoop0EklxS3XkJhIZDMRPPInlC+8zTffhErpLYhnd2dZzTFQ+qtVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690531; c=relaxed/simple;
	bh=WfssnXglDOxvPIQ881a3cyhpT+Q6juxzbfkgOXoITAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFxsGiD3wWu4/rzhIx7U/VQtRrFCCe0frg2kAGTn+bNcwYMjbSwAXX6nMdbre5AP1FhReP5ryn3yYyxMJ1yAjv/GcPiFZ+qEE60TycJZ9ZIpq97oJb97kl0DJ6ze72Ka+7JaLcparHI5RGQeY5ihyRKWxsFrcNqeyObXzj5k14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=djfqqTDn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so2788691a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690527; x=1707295327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBX8tkoIGR61lIZo86EimVQm/t/fqsSustUrCgWT/u8=;
        b=djfqqTDn7y3VRP2bpuhyzGm/rVDZ97/sQXKzf1cCxpgzrpkQ563YnBkC/ILWiCq5TU
         K66AdcGkUUeOCafM7dzgze6uP1xmB3DQ0z0QrfVCHNel1lAl+FMAm1yDSPLEHLYk+YtR
         JOQN2cyi+M6rWSlizvbWYrL/bu6bBq6YCOXOFLmv37mvewZ5IXsbqqmx9wfDw9xlrz6a
         cHk7h2mOLSBOOrWfmxTFkl/fVF6DExmkeICh5gKVudlniEEYEBAhKwG4ok6Bkq/4k8SD
         9F5ZynX1KdkwdUFd6FBxbTrXRdB4YcCDi4jns3PBvQxdUOYQJnVVTBS8e1fd8dK6OLQb
         xSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690527; x=1707295327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBX8tkoIGR61lIZo86EimVQm/t/fqsSustUrCgWT/u8=;
        b=VCahGt0PwjAl9BOtmPtPb2jMkeIBOfWg/yZ2mKuw2kXXo19J6SLZaKkjl3CgZrTnzl
         fIsBLTsoTZQ/MvfSEgm+7BMVoPZ3j49c44S1vfsLT65DCdJLQz68zSNKFkp1CG4v1QwB
         evR6GAxn/ZA2wOQ6OzKCkJuvWULSim3RuXQPpsyTrH/ipANhxlTDzDHWpG26LyFKcfRK
         TBAzld709HCUo4riF6yLbiW86G6f/C86dv1YMuhS+MD+cmoN80XO0F6P+XNYVkmsCKiI
         a8EsQAikW4oFYoL+mgirvVIbVx+1W+4g1ldwZJqlBzploZFLIKK5Z4RX98IXLmJrxZ7B
         w0Ng==
X-Gm-Message-State: AOJu0YxpCohxqRISYrciTGHgUMXoWNCRdISmvv1kPUfBS+dblajme9c5
	WczuKn7lakxjG+H3hKA22nJxWT9lXrq84CaP3ze96pADR7eu10P5yom/ZfNA/Ec=
X-Google-Smtp-Source: AGHT+IETb+W9LxMAOv3c52JCdeIUNnyL/r7fCODulLaukxAbqKVWWDu8z8ad43Vur2B0BD+jnUXWjg==
X-Received: by 2002:a05:6402:ca3:b0:55f:6b5a:6310 with SMTP id cn3-20020a0564020ca300b0055f6b5a6310mr526532edb.33.1706690527359;
        Wed, 31 Jan 2024 00:42:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUj9A6JryuTEC/GJvCzjlvGXsHqucq7yAlwoC3FuaYE4ZR6bPhrBiy7YkBu2VgTH9sX5DKKTdyA82C5fc8TDoNnKNNNsbaFV9eG2gf2fLyWjC+UIa+MY8jck33SpF4f3f1w6OkzUUYR3/rcXZ9lKRq5St844j8pX468KStrj+j3O3Q7m4mnUA3Cgyx6jkx5xYy4afFm5at6VZ+i0ve0gTCFO2XphAkUqm1r70SxrsM+2eXeT1kITr9IyiqeKWALqEGF3MGpqRSIhVWbk3tYrcZhAudIj2T8NKjXt1/ots8H40cP7PJxCYxzPbykt+B4evpDX9ywLwKKDjVKOLAASc5uODthJmEIDeWdn3QDBEHZ9pDErNauNgjfVmM8sZmUGV6u7s7SPDkGqovHkqkII7G01nuzG5Eg4ca9i7D85kyVK96/osU=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:42:07 -0800 (PST)
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
Subject: [PATCH net-next v5 15/15] net: ravb: Simplify ravb_resume()
Date: Wed, 31 Jan 2024 10:41:33 +0200
Message-Id: <20240131084133.1671440-16-claudiu.beznea.uj@bp.renesas.com>
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

Remove explicit calls to functions that are called by ravb_open(). There is
no need to have them doubled now that the ravb_open() already contains
what is needed for the interface configuration. Along with it,
configurations needed by PTP were moved to ravb_wol_restore(). With this,
code in ravb_resume() becomes simpler.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- fixed typos in patch description
- collected tags

Changes in v2:
- none; this patch is new


 drivers/net/ethernet/renesas/ravb_main.c | 58 ++++++++++--------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 661236affa5b..9521cd054274 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2939,6 +2939,20 @@ static int ravb_wol_restore(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	/* Set reset mode to rearm the WoL logic. */
+	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
+	if (error)
+		return error;
+
+	/* Set AVB config mode. */
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		return error;
+
+	if (priv->info->ccc_gac)
+		ravb_ptp_init(ndev, priv->pdev);
 
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
@@ -2978,53 +2992,29 @@ static int ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	int ret;
 
 	ret = reset_control_deassert(priv->rstc);
 	if (ret)
 		return ret;
 
-	/* If WoL is enabled set reset mode to rearm the WoL logic */
+	if (!netif_running(ndev))
+		return 0;
+
+	/* If WoL is enabled restore the interface. */
 	if (priv->wol_enabled) {
-		ret = ravb_set_opmode(ndev, CCC_OPC_RESET);
+		ret = ravb_wol_restore(ndev);
 		if (ret)
 			return ret;
 	}
 
-	/* All register have been reset to default values.
-	 * Restore all registers which where setup at probe time and
-	 * reopen device if it was running before system suspended.
-	 */
-
-	/* Set AVB config mode */
-	ret = ravb_set_config_mode(ndev);
-	if (ret)
+	/* Reopening the interface will restore the device to the working state. */
+	ret = ravb_open(ndev);
+	if (ret < 0)
 		return ret;
 
-	ravb_set_gti(ndev);
-
-	if (info->internal_delay)
-		ravb_set_delay_mode(ndev);
-
-	/* Restore descriptor base address table */
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
-
-	if (priv->info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
-
-	if (netif_running(ndev)) {
-		if (priv->wol_enabled) {
-			ret = ravb_wol_restore(ndev);
-			if (ret)
-				return ret;
-		}
-		ret = ravb_open(ndev);
-		if (ret < 0)
-			return ret;
-		ravb_set_rx_mode(ndev);
-		netif_device_attach(ndev);
-	}
+	ravb_set_rx_mode(ndev);
+	netif_device_attach(ndev);
 
 	return ret;
 }
-- 
2.39.2


