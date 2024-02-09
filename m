Return-Path: <linux-kernel+bounces-59699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE684FA98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DD21C26B30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08328613F;
	Fri,  9 Feb 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RGEh8TJ9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977282867
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498316; cv=none; b=ckSmbTm9jg+3TKNmMy4+qIo19mAh3/kK7my7Y/CIQzAADyrgACjlBCI1ndByzOAXtOEOmce8N9VVecS1r0LzjTo4VnggdJ/fGNtp/26jUu8Ihc2x5ToYUxsG7dEsfohgwoPh2WvTNLD762xykIZof/+1hVFlwWdqU1vuxX6yahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498316; c=relaxed/simple;
	bh=aJyW6klkiCEWCaN1kbMLvNn/LlK4LBkX7wlr068Ea4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qk4NU8YcPDNUfPhuu90FVIcUsddmSHDwBIKZNdgd5ioSflbd+nwU6fDjjX5shaJCtC7dbLdv2+gwgGfbGsjnTKx8qiR3CNhhWZLASfJw7eqv2vdKGDe5fe9goVsHSivkHnmZNQavEdWITgHauFXOFga0Z1E+LQR9V4Z3Q6LYAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RGEh8TJ9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so800040f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707498313; x=1708103113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqzOcrxXkmN2Q8OVFhHyTRPrKazqUHrRQjUC+mJFZvQ=;
        b=RGEh8TJ9P41fDWbgg8mMzyM48VALVnzIwSvQ9jE3B+JHDfNuC8RMn4HoL1x4Xk/Vxz
         UK13PS0Cnet/r3bs+KaZIC4g+Cw9vJPkZ5ot3DjosbkbbEyYzSq76xdnUhQ4l4PooM7/
         rWTbcCloSS33zP4teeEu2l5me+gJPVXFKDIqFAcNGh7BMvB87fT5Xe45hXU3DCf7Rwfy
         Pqrxs+oZZ7pluO33yyKJR/yHVmp+YsRvUBxSXla1xwFu6Lb1DZjijNmVa14sKGA9T0do
         PPeKiGb03Q3hlKYf7zjL4aCCqwwe939sEV75PSDnBGLf7Yv5m6p1yh6texPSTYJmPQXC
         GvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498313; x=1708103113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqzOcrxXkmN2Q8OVFhHyTRPrKazqUHrRQjUC+mJFZvQ=;
        b=LRTaFg31QgFiCt+qXjn1IKlllIHOs6R2bfNlKapDpqwReL/v+nne7V3b8gIq4RGJdS
         8yKwT2sjzLiHdoC2GO82H+WvXhme9Ljn84QgAJaeT6norR/EeKyCeEQmrDnRPCaW/Lr6
         eHI1RS+reS7JuGWwawSh9ax005+S1bBZ7pLlC64OyY72tEBZm5StPyWDTYR99RQCTZzv
         Tieg15oQTxID/Zg8ocrerWjz2k98wErxpSVI1Cz9QgZZZnWQhscRbsNeIND/3XThKmMB
         9pk0V2bnmHaBoBZtp28Z/DGWOKijvo8PkYCwCdid3dkE3I2Ls4WWIZHV/3qmnADP/Ofp
         yCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR6rTm2o/Kw6CGNDsQo5HT9A7dU8AcKrcN6CwLI38tpg+TLSk/RuFK3PV/p0K/6Xb2FfZfHkDYzBNDfW5pWr8QlS508SIMuR96JGvB
X-Gm-Message-State: AOJu0YxAh9b1WKdLmjuoW6ZOl0xvwfxRAMJ2iCZQfwDG4sa/KvIJBVtO
	A/ks6UKu3qoMQs3GZRm/gaV8p/t23KhQk1NSoUTEJfOu7odhpqBZPTixuc1KZXA=
X-Google-Smtp-Source: AGHT+IFxLo+CiICYpnYHw6k+gNZW5Zk0PUqPuUfJPLlH2Wr89LM0zZi9p0YCjDX9UvUIpD6pI6Nl8g==
X-Received: by 2002:adf:b192:0:b0:33b:4f08:ac9c with SMTP id q18-20020adfb192000000b0033b4f08ac9cmr1629190wra.33.1707498313034;
        Fri, 09 Feb 2024 09:05:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8Rwost7tjJg6H1HzwrY78TwXxkunRNolTYR9oJ4fG7D3nXXseL7stbAf9T6SFH0QGRTfODwm+agRk/BYFce57fErHFoVBgoPkQ0jj0q6Kadw4aCCyu09k1CzpvrcZXo4AC9UldBwunIc6SrriDUoBeD5Zqf/q2LgKlmNczgl3bp0oirUtBRkOnat2ztVWG7deSi0mfMtqmthieTmNRCMoXGVnX2Ua5X889aRGMlf1mg9Vug7O46MJUiIrEtdckFytwSstSCPlZKUypyIcI24qU8364+pVtm5jgTbxJkCw/5RC0K5cn0+fI9s7wLG2Oiu9WNWJNVLWXq8=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0033afe816977sm2254998wrx.66.2024.02.09.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:05:12 -0800 (PST)
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
Subject: [PATCH net-next v2 5/5] net: ravb: Add runtime PM support
Date: Fri,  9 Feb 2024 19:04:59 +0200
Message-Id: <20240209170459.4143861-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
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
index f4be08f0198d..5bbfdfeef8a9 100644
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
@@ -2931,6 +2948,8 @@ static int ravb_probe(struct platform_device *pdev)
 	clk_prepare(priv->refclk);
 
 	platform_set_drvdata(pdev, ndev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	error = pm_runtime_resume_and_get(&pdev->dev);
 	if (error < 0)
@@ -3036,6 +3055,9 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 out_napi_del:
@@ -3053,6 +3075,7 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	clk_unprepare(priv->refclk);
 out_reset_assert:
 	reset_control_assert(rstc);
@@ -3066,6 +3089,12 @@ static void ravb_remove(struct platform_device *pdev)
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
@@ -3077,8 +3106,9 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
@@ -3160,6 +3190,10 @@ static int ravb_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_force_suspend(&priv->pdev->dev);
+	if (ret)
+		return ret;
+
 reset_assert:
 	return reset_control_assert(priv->rstc);
 }
@@ -3182,16 +3216,28 @@ static int ravb_resume(struct device *dev)
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


