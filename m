Return-Path: <linux-kernel+bounces-63252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE573852CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763EE28D33C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519C45578E;
	Tue, 13 Feb 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jbKsIs1S"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BBA54BCB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817312; cv=none; b=Qqg4oSHTWbV4jzMDBXh1xR19ryzrbfi9Mz9tJ7MzR2JNdeQ7awyK2a08RNhBCS2wZ63Aoe6aQOXi0p3obwxb7vruJiR8oKS8zMRjVEuLMQ+VH0CRJbDr6MPTwuFGmOQEK9tUmFIsksdmMQTYlCHVHmIz2RA69MS/MjGooFsl60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817312; c=relaxed/simple;
	bh=fmzS2Yan2keHs53R4x+qMd55iIATYx4wBLC/B6HhXB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Smx+M6sVWBVJdAuDqLMVo9zvSgUIWGJvw6f3Jyw1pUeVrQWNWG1BSe3VyqecGXGtBBPG7ZN4fBO17IzRxV/JIxtFvlmgzEfcMEgLErvdgU9Ij9nEWPyyhTBZ9mDyAansDtpu8AjqRWQ4b8Y1WZ8az3aee4LerGRDj54VApOt/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jbKsIs1S; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51176eb6a4bso4134279e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707817308; x=1708422108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4yzSzCHL5tZEjla4g9SMO0ApNhYh0fsLQEGXJT8U68=;
        b=jbKsIs1SclKnjQ5ATPFcUEyiVmAx1FZPlVLf2181zVTwPJpFSHQNcNIRMNY4Vu04b5
         xmW3s1Lam6j2AfH1kmsxH5NXcjxZZIGoW8+VzwySDqHhrtlx6VXjLy4npok3kfDjQc1K
         zuipQK9sYk2fx8gGie8vsJO0QRju6wygmGsxj0NIE9ey8xRhJWOoxrPVfvajHC6R+zTJ
         84ypKKKvBCkq9fg1e8K6uXuhEZ2Zt2CiKq15wPkimPsixDzE0HGQIW0ILecw8aTyAsyb
         m9p6nok9uE1iUEz5yvo7ZGCRCH+Qp7PXPGk1G4R55vGDp8kwu17hSRoVaLmdcmwWdMSe
         zKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817308; x=1708422108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4yzSzCHL5tZEjla4g9SMO0ApNhYh0fsLQEGXJT8U68=;
        b=dl8q4aBErCUA/Lf/UYjDYZQJ4AAMzRit/MafVKmmVmF5TwQtSrzmdwBkG28opU/U4F
         gI8gXC1En2RdqhB6+0sFPRCWFUJP5m0I58khstNI8n0Upb6oOcpYYUzL6R6yOEugnBp2
         w4IJe+sKQTbUa3zrTczz7E3vS0/u1wPoj2qzgLtNwz0H/o3p4SXZuWSL/9p4gbwmtap6
         Cr0OzQvCK1I6qx9D5gPHMu/wSk+P0TZe3r5dWINqW5mn7innsHMrW5AUOHLgUrBt2FsI
         NqiZf5++x2h1/AIV8qfnXxz+mtU48ZDRgaiLdWJENNeKqYtZLbV6BzD/zOT0xS4MBDlP
         Lg8w==
X-Forwarded-Encrypted: i=1; AJvYcCXNicN0yj571/sdJruz/d1xhR1mn4nccrnooFk+pPkTrF61tPsdFJO1bMrejq5ra1FZ33t52+FQBhqPlVOZZeXzy2aDySBIvL6vtMaC
X-Gm-Message-State: AOJu0YxJeimIpTawKT+rReYKn0mH34axC939X3DlPGbSBn21dowBvVI+
	aa6nK7ayKeGOG4bs/358FN7XQ+One0BWTYA0CmnUSJXBGMO66wfzDYIvpofxEBY=
X-Google-Smtp-Source: AGHT+IEVzdayMM+BRXxhLfMHE4x2j0UZkfG8mlaWyqLGaC0qX2RaAhJUayyUwDYZPowrqCPvSMSgkg==
X-Received: by 2002:a05:6512:eaa:b0:511:87b4:d01 with SMTP id bi42-20020a0565120eaa00b0051187b40d01mr5770164lfb.27.1707817308520;
        Tue, 13 Feb 2024 01:41:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUL7UtBYOYE16wvxX8CYyA+8ywuXQvbt/fW3DEuuyGoO7IhMSzDZacgkkn+aMm0J28D3Vq0lJU2IVf+dCi/Q+SDQP3yGeqXBijeWPFMNrjplKQU6PIGO2zNHaf6maqZ3NTGOX5BS8x0HUpuVT27f7uxK5TH+vb6BDo8lquohy0GlrVtP/R4I32TGqCPpcLVy4Tc8UWzuzx9ztMgYGPfJORaLUKmQwgfF4J35ev3hCS7hNUuMPP5s8k2F/67ZrR9gYQp2OFg523ehSWDtOBEo4mHyIk9xYq+Nn1+0Y+ZLhHwmy8L/qq57GY8v1njFDzphUF3T5H9BeTiVt5DSO2914NCNBM1De6A0ea35WH7TLXLAXdDtiv4
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm11207446wmb.25.2024.02.13.01.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:41:48 -0800 (PST)
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
Subject: [PATCH net-next v3 6/6] net: ravb: Add runtime PM support
Date: Tue, 13 Feb 2024 11:41:10 +0200
Message-Id: <20240213094110.853155-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
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
index 4dd0520dea90..1d3de2e3f917 100644
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
@@ -2927,6 +2944,8 @@ static int ravb_probe(struct platform_device *pdev)
 	clk_prepare(priv->refclk);
 
 	platform_set_drvdata(pdev, ndev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	error = pm_runtime_resume_and_get(&pdev->dev);
 	if (error < 0)
@@ -3032,6 +3051,9 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 out_napi_del:
@@ -3049,6 +3071,7 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	clk_unprepare(priv->refclk);
 out_reset_assert:
 	reset_control_assert(rstc);
@@ -3062,6 +3085,12 @@ static void ravb_remove(struct platform_device *pdev)
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
@@ -3073,8 +3102,9 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
@@ -3156,6 +3186,10 @@ static int ravb_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_force_suspend(&priv->pdev->dev);
+	if (ret)
+		return ret;
+
 reset_assert:
 	return reset_control_assert(priv->rstc);
 }
@@ -3178,16 +3212,28 @@ static int ravb_resume(struct device *dev)
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


