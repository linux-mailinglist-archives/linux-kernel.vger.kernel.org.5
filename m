Return-Path: <linux-kernel+bounces-56468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0084CA88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9771C2169E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054F5FF10;
	Wed,  7 Feb 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dQPdc6pF"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BE5CDD2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307681; cv=none; b=lF6H7Vmt4c72dF2wmOke9UjR0hyQsFV+645YJgl2VtSA0ryZnxYkL6K+ZNV3+bH6IpASCMmvbxa8dy0KLr8OVZFhnAxgyC47bbd8iYcROZ2AthRRMHXmj6FjJ6p8nYfqkDQCjwCyVMUPQ0bo3175Ka+J3ufDlNOteyvrrH9pUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307681; c=relaxed/simple;
	bh=8myFEFdHxubvxUdidyiyBKUjeNFZRh73aQh+IGE32GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NI3kDCpgIdVBxvkLNvMlfCDsFcNrlQI34Dg+6hEzIZBoOZIWLzDF6wJCQrGQotooacaRccyIUD3CaUKth8w8xBfKajrcLxi+4my/IhKmxN93oWnoe2CnyutfJ//oujnk0gA1vevWPDscSwXTybOtlDGOity8dSK7svbAp8n9YwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dQPdc6pF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511413e52d4so582688e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707307677; x=1707912477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9pUYyEyHMbAgMlD3we/lMOjIaBa3lJL0ER73fS7AMY=;
        b=dQPdc6pFpR8mxpP6IFUQBHUlPt99Npd6N2zHf/xuufV6PFSkkyNFodfAJHlOfxw2uO
         qLkITM+80amcg7IWEB2pQ9jOb1KeGwyvVCXpXS9IWztpKVir2GW+NpCut7Sq6UOGzpcs
         G6IOzz+laYoH+GMIECBa52yGqn2cFr3C2PpG/3JHhRwA7a2wUvrZAcPsNCZDk5q4QbZJ
         69BwEeI3f0KYMaSQSV/JXrHCdfx8AXbq1TsbHkjB6XETLoin8DSSuJFDBYpgHtG8sjb5
         gsl6duvQMO9dYA8qLZAYrBBBLPo3PIuL7bdDEpAIpqec4uXUdbPMpRqt0dFYFLyDm9MB
         v+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307677; x=1707912477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9pUYyEyHMbAgMlD3we/lMOjIaBa3lJL0ER73fS7AMY=;
        b=miWNzbI9yU9yOT4avq8wQX2mLOEuNgQ8if6oqjVa1CVFJm1U7RZm5ziRw+4Uw3vDT/
         wwynYkWxeWINIeiNhEVWrjyLLfmBCrj5w4hTNqwDJYibN5E5DsJcHeJXjDOB3v5yWy1N
         M4XLwDblAnuPZ7PBJz21l7PYA7ZVT3EfkDflJn2zrWrD8RkVgrmhfVLjVZ0rwGTVq9N9
         FsgyMZfamLM0eI7R5udAe753/Rd+1Fn1wHMRVpwM67i6naGvLXrA90oPpCy95Yd6JfBt
         p7f3hRwrvla/Iri59lnld5Gvn4MzT10SgbhTYWmTbcz53n9dK/wZbHbavnVCIzJFZ+CD
         CcJQ==
X-Gm-Message-State: AOJu0Yz2+0t6OfgAB1sU4TLEFm3pD+0XK12zP+EmMiVayLqxBN3h8rIt
	bvAsD4VKUXFXLmZlLeNhXzjKmDA8wcbaxxO+hb96/N+1ZUYRaXQM5dJQv14m4IU=
X-Google-Smtp-Source: AGHT+IFvm2K0sydvLOZo2QG9HI63+zSNMi0XDoXWtebHAXEukgs5AmG9Z8DYNKZfDB9OPEvlqjqeww==
X-Received: by 2002:a05:6512:3255:b0:511:4d22:dcf9 with SMTP id c21-20020a056512325500b005114d22dcf9mr3539493lfr.23.1707307677694;
        Wed, 07 Feb 2024 04:07:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2DpxgUHQ/7TWBk9ACo+3yDy3x5MTCFX4dP3IVsi4E+2wDKnwtKNe/BK4Ao10lcIJNf/skgBkhEO3614h900nokp7v4iJMpX7RMt4jzQ3+STOWF1eCkdjFxTNiK8Ji+VPRXcQIoTM9eTyf0nbRNuKveoSYZauTJmTjRWftBa56jSj+hC/xcTc0llqbpUWXCYIONWzTKuX7gtj8C6Q0sQ8PkHNmmyKrhxdVeZ3POGJVK9+CCy6pAfsltft3TVHOX9WeIzM92AKVjCpDOAgy/+pN3dkM4bUDDaSbFArvxW+VxG9KotQwCJNLgXQkqZE4zlLJ5Y5vYxYsCfQ=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0033b4db744e5sm1363957wrt.12.2024.02.07.04.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:07:57 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next 5/5] net: ravb: Add runtime PM support
Date: Wed,  7 Feb 2024 14:07:33 +0200
Message-Id: <20240207120733.1746920-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
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
will switch the IP to the reset operation mode where registers' content is
lost and reconfiguration needs to be done. For this the rabv_open()
function enables the clocks, switches the IP to configuration mode, applies
all the registers settings and switches the IP to the operational mode. At
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
index df47d3e057c5..a7381a90b739 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1879,16 +1879,21 @@ static int ravb_open(struct net_device *ndev)
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
@@ -1922,6 +1927,9 @@ static int ravb_open(struct net_device *ndev)
 	ravb_stop_dma(ndev);
 out_set_reset:
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
+out_rpm_put:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2229,6 +2237,8 @@ static int ravb_close(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	struct ravb_tstamp_skb *ts_skb, *ts_skb2;
+	struct device *dev = &priv->pdev->dev;
+	int error;
 
 	netif_tx_stop_all_queues(ndev);
 
@@ -2278,7 +2288,14 @@ static int ravb_close(struct net_device *ndev)
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
@@ -2779,6 +2796,8 @@ static int ravb_probe(struct platform_device *pdev)
 	clk_prepare(priv->refclk);
 
 	platform_set_drvdata(pdev, ndev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	error = pm_runtime_resume_and_get(&pdev->dev);
 	if (error < 0)
@@ -2884,6 +2903,9 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 out_napi_del:
@@ -2901,6 +2923,7 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	clk_unprepare(priv->refclk);
 out_reset_assert:
 	reset_control_assert(rstc);
@@ -2914,6 +2937,12 @@ static void ravb_remove(struct platform_device *pdev)
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
@@ -2925,8 +2954,9 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
@@ -3008,6 +3038,10 @@ static int ravb_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_force_suspend(&priv->pdev->dev);
+	if (ret)
+		return ret;
+
 reset_assert:
 	return reset_control_assert(priv->rstc);
 }
@@ -3030,16 +3064,28 @@ static int ravb_resume(struct device *dev)
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


