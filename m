Return-Path: <linux-kernel+bounces-65310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AC4854AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FE51F2262B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD505B1FC;
	Wed, 14 Feb 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PqwY+T3B"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA658AA7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919135; cv=none; b=MP4KLBRtcNSK9wMJhVd/x3OMprPmHTWBGtW0K3FYvDmEmLOSC1PnfMBJ+8svzouEUqZMWTP+qMIGhmm2xPMcUy58uxHfE21RKRRPyrc979EmvmFPwxQVcM+0R52zD0EpmSOPX4gsCBkAX/0GZ6lXFq9S9eBkfK1PI5GhKbQgIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919135; c=relaxed/simple;
	bh=DCOkytDLppS2bYn3RErvOIjLsPi/YOCWIUBoGo2hi0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpmmSNJbQmkcqzcK2dsq3qKPjsyDf4WZfWvmI7jLSNw2LvB5lr4xnZD0j8EQFFft7pyjCxTq9nSrrKoNREtqEgVuyusrm1sSUT1EiPk4EzG8Ol++DdknzBExNgxzlo5z5A1N9XWSt60eIgpwA+/cI0G6DBdYBa06eAwMDIex+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PqwY+T3B; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-339289fead2so3587512f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707919131; x=1708523931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zjiXPc38mpvdFc3Koad2qjD+UloWUSOxb8tDBr5OK4=;
        b=PqwY+T3BgK+ZRZjW/x3inefq7peSvBzf6BHmjvV/vXexaKPWYFPlpNQINna855jr7F
         2ZWBLsEvwyLL4d+Z9eICXk9oONtXZ2Xd4sMaA5FfdhU0DRIunsVLunMXpV4iOq1qbWAu
         aBCwkFHPmtWyzJSBPhCESvDCGKwz6E22H6koq0kbRQn5iZYnHkAWdhst9a08guI5Dnj4
         MwO45kG2mGu2IfsWIvptSZQCzefZd8+P0SVayv9Oe540zdqiRVdXxnNcR7bSJ+66zxay
         q74Yc5R5XXWL+FcdSVLNlcz0KNBmbax1XXtK8hBg0YbArXGAYWydufCjyMmIdPWZokGJ
         5+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919131; x=1708523931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zjiXPc38mpvdFc3Koad2qjD+UloWUSOxb8tDBr5OK4=;
        b=vCynr7Rkwbov0dqiDPMk1DdKbCn1wt6qS/E4XXq5oH3urwak0MYYZ3Sdw3+NnMHd2C
         SzmMigTht0pfkAhdHtwFa1aXs+K7f5nmzLp3oKyhSjQWwaPdxKCudh6u2SSicjC2wS3o
         K41sFmMcExPenwu26CT0L5nqCBuOlWciaudOz2d9eOYqJElPneK16ReLC84sMnXQqmT/
         qORRgJM1c6AWwv5CiHqWZk+qbBAixXoEbVLd9x0XxdBwIjPhKHo9LAlj6FYNrbstcDtl
         MRA26hQEU1lEzk+wpcxIFv9r2VIS4kelUGsXi5o7qYhy7G2PhrItEJrK/qqsOSxRyWfM
         ViIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAHU2hjFCXsR5SsNuYNQv0UM/cxXN5fkXWLza8hK8lGBr1ZAC3neAMHVyFPVcQkxRUAWz+RZLY44e7CucQzFzeVzWvb5YA09v3cLVs
X-Gm-Message-State: AOJu0Yx6DWHQBsuiRMSxlmx6BxDlNSbwIpUR200IzvFjPk0JilG41HDp
	2OlH50AB+eexzmOgP7b5lNkk/l+S1Up2dft7GmH2chsMS7s5jkk/IuC0etBFuw4=
X-Google-Smtp-Source: AGHT+IEbIprofj1cnMyJXEX5AiYlHF4Wk00M8lDTzMe7s0Qz1nMc7jBS1yKOy5LpTVcQlPPFlfCriw==
X-Received: by 2002:adf:f18e:0:b0:33b:5087:c913 with SMTP id h14-20020adff18e000000b0033b5087c913mr2242505wro.54.1707919131582;
        Wed, 14 Feb 2024 05:58:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLwJ2RO2UWMIdJhAp4ZOX+nEM6u7OawSEXibKwgIZurbbgG6FeY89PAkWMrsvonE3leWhdvP3H0IHro4PglhJH2in/eFz4JvexoF6IActYBupfvxjZ/e9P+FrlcoosPha8/GdCgPYMa45MTqxnDwnaWvyZsClbLpfa4AgBy5qjkW/L12UmoVQhRiG5LG9pUx15X4i29vZbRW5EqzbdY6ieGCKpFV6vQMJgEV5hR6fzwVesRp5/C1JyCnxhbLLvOCs6SPrJZh1QtgfHmCWwEXDE47V3+wDG6JhWTr7kpcWcpOAG3k4BrCyp5nTXl69QrpdnetW+0CGRQdiykSjD4Ak3rKJz8P7O7V+YiMzw0q1B3+HncYr+
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033cdbebfda7sm4282140wro.14.2024.02.14.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:58:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	biju.das.jz@bp.renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v4 6/6] net: ravb: Add runtime PM support
Date: Wed, 14 Feb 2024 15:58:00 +0200
Message-Id: <20240214135800.2674435-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add runtime PM support for the ravb driver. As the driver is used by
different IP variants, with different behaviors, to be able to have the
runtime PM support available for all devices, the preparatory commits
moved all the resources parsing and allocations in the driver's probe
function and kept the settings for ravb_open(). This is due to the fact
that on some IP variants-platforms tuples disabling/enabling the clocks
will switch the IP to the reset operation mode where register contents is
lost and reconfiguration needs to be done. For this the rabv_open()
function enables the clocks, switches the IP to configuration mode, applies
all the register settings and switches the IP to the operational mode. At
the end of ravb_open() IP is ready to send/receive data.

In ravb_close() necessary reverts are done (compared with ravb_open()), the
IP is switched to reset mode and clocks are disabled.

The ethtool APIs or IOCTLs that might execute while the interface is down
are either cached (and applied in ravb_open()) or rejected (as at that time
the IP is in reset mode). Keeping the IP in the reset mode also increases
the power saved (according to the hardware manual).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v4:
- none

Changes in v3:
- fixed typo in patch description

Changes in v2:
- none

Changes since [2]:
- none
- didn't returned directly the ret code of pm_runtime_put_autosuspend()
  as, in theory, it might return 1 in case device is suspended through
  this calltrace:
  pm_runtime_put_autosuspend() ->
    __pm_runtime_suspend() ->
      rpm_suspend() ->
        rpm_check_suspend_allowed()

Changes in v3 of [2]:
- this was patch 21/21 in v2
- collected tags
- fixed typos in patch description

Changes in v2 of [2]:
- keep RPM support for all platforms

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 54 ++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 6f0677d1adee..289d6482cd72 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1939,16 +1939,21 @@ static int ravb_open(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	error = pm_runtime_resume_and_get(dev);
+	if (error < 0)
+		goto out_napi_off;
+
 	/* Set AVB config mode */
 	error = ravb_set_config_mode(ndev);
 	if (error)
-		goto out_napi_off;
+		goto out_rpm_put;
 
 	ravb_set_delay_mode(ndev);
 	ravb_write(ndev, priv->desc_bat_dma, DBAT);
@@ -1982,6 +1987,9 @@ static int ravb_open(struct net_device *ndev)
 	ravb_stop_dma(ndev);
 out_set_reset:
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
+out_rpm_put:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2322,6 +2330,8 @@ static int ravb_close(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	struct ravb_tstamp_skb *ts_skb, *ts_skb2;
+	struct device *dev = &priv->pdev->dev;
+	int error;
 
 	netif_tx_stop_all_queues(ndev);
 
@@ -2371,7 +2381,14 @@ static int ravb_close(struct net_device *ndev)
 	ravb_get_stats(ndev);
 
 	/* Set reset mode. */
-	return ravb_set_opmode(ndev, CCC_OPC_RESET);
+	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
+	if (error)
+		return error;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static int ravb_hwtstamp_get(struct net_device *ndev, struct ifreq *req)
@@ -2926,6 +2943,8 @@ static int ravb_probe(struct platform_device *pdev)
 	clk_prepare(priv->refclk);
 
 	platform_set_drvdata(pdev, ndev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	error = pm_runtime_resume_and_get(&pdev->dev);
 	if (error < 0)
@@ -3031,6 +3050,9 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 out_napi_del:
@@ -3048,6 +3070,7 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	clk_unprepare(priv->refclk);
 out_reset_assert:
 	reset_control_assert(rstc);
@@ -3061,6 +3084,12 @@ static void ravb_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
+	int error;
+
+	error = pm_runtime_resume_and_get(dev);
+	if (error < 0)
+		return;
 
 	unregister_netdev(ndev);
 	if (info->nc_queues)
@@ -3072,8 +3101,9 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
@@ -3155,6 +3185,10 @@ static int ravb_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_force_suspend(&priv->pdev->dev);
+	if (ret)
+		return ret;
+
 reset_assert:
 	return reset_control_assert(priv->rstc);
 }
@@ -3177,16 +3211,28 @@ static int ravb_resume(struct device *dev)
 		ret = ravb_wol_restore(ndev);
 		if (ret)
 			return ret;
+	} else {
+		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			return ret;
 	}
 
 	/* Reopening the interface will restore the device to the working state. */
 	ret = ravb_open(ndev);
 	if (ret < 0)
-		return ret;
+		goto out_rpm_put;
 
 	ravb_set_rx_mode(ndev);
 	netif_device_attach(ndev);
 
+	return 0;
+
+out_rpm_put:
+	if (!priv->wol_enabled) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
 	return ret;
 }
 
-- 
2.39.2


