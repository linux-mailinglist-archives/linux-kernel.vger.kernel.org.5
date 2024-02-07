Return-Path: <linux-kernel+bounces-56467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FEA84CA86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEE01F2831C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B65D743;
	Wed,  7 Feb 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ov5mgB4g"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE945B68A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307679; cv=none; b=GDKqyLsNsa6oLlpvT4jjKPnMLDQ9RqqDD8HKM8g+/a6eUhJz78wZ+DDIc2WlcVoisxHfc5VOBxdAKwtzkcVIKqrCpcsd8OxXE8kEKSzNrU/guebCY0ky7FboN4fA89KKl1OFCIaEwkFZQUIlUfPx/u4PIj82/zI51R72bNO9NT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307679; c=relaxed/simple;
	bh=F9b6vWTtJjoroXcTR8WWfJ3XK0LPvKUUjYgH6P43a3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nf/afDxFkTEBJlu7rT0hOSn8ySoe3Jw1t2sM8PWh54hRKDWcDkk05mqUJqYcj1WLESsAfSUn06NhIUoMFQlhPaxddnT6F5hWCVuAoOjPmoDCoaLF8R8poZpPjiXIfqY4otFwAT0dDgQt1/LweJkIFZU7m1qYKPh/vBV9x4eV+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ov5mgB4g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso4205415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707307676; x=1707912476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXrz4m7f0rJ3JiKSvzdX6uwlbnfuFKCWsRP1dHUwshs=;
        b=ov5mgB4gwBWLiewhnc2EstSSHr3JGjJe0u66oBvYtPoOkSlgQIumAwvkBOsvRJWbyc
         7LSYG8khWVtc09z6Nb9MzH/xNfhbbeOCYdYcsaDwbSH7Lpxdfs7X5GRMWiHC33hCxtxo
         mY9zNSsmRxCUJpjeQNzBVRTdeE20HUYPbu/LYWNcRWwG2kwC3nc2qS+rNgGy1znF/i4g
         t1kwvdyT2G6auEqp7JY0oaLiGEe9et19kWtoMedqKc1bMdIB6w/yWmh7Po1ZvjvVQcv3
         vU1JdLRLpAGSMu0IZ3yAz5aGG9jzr1hnA8PktFJtDUvMWssIQ8S/jEllCqHTm3yU/LU/
         ztMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307676; x=1707912476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXrz4m7f0rJ3JiKSvzdX6uwlbnfuFKCWsRP1dHUwshs=;
        b=qN5WPXG3mGusSEiNpOGsulfRKqcFlM3ILXiCPVvPAtu6xtAqzshedU3ww6Ilzp4W0f
         /oijbC0zDtIkvK7eaZhC2Lz0nZrNqw5J6rqyHDDlyJjpPHZSCtM1vnJUYhpvC4B2IJeF
         gcPVHHkUAqcIJsV2b+1NPoBrD+MpCA1kvPXY1c2mlNWTJ1ehCMediRqUGhuWSJqm+WDg
         V+riRZn8fdt8NBw0EkUxSPDl/DRsEIMbKF0IsNtLVYn4TYbKIu8ww3IyryZ9UDz9a+eb
         4KY/yc+ej0YOVbK+wTLczdqsy8rOfgy9vYMbHwXX/kRxk0YUAHVOYAbu++V+jJ4zGbRE
         k2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZPG3+RYYOHEYKXM0lsLhPvPEczCg9Pho7W1Is+tmcC5SdXES/Vt+dq//B+RWjVtcKsQj8wsMOlSm9CrU+TPAWwDBx477TNyEcRtoe
X-Gm-Message-State: AOJu0Yy0Yy3J6JVcd1WI7bLCchYjAqD9x+VxQSqh4vouYx4P5IzrzJSf
	vwI5epF9agCCgtC/Q1FUfXA75b6zsnli+pKlaDL7TC3K1JGkhLSC54sgggfj190=
X-Google-Smtp-Source: AGHT+IHqgCbrwi/B6iOm1M7wrFOpNwO6bCbtWz4pRYf8W+JVuhruT0mh9p3lHzZxaXmmCsd3Ply5JQ==
X-Received: by 2002:a05:600c:a48:b0:40f:d3d8:c8d5 with SMTP id c8-20020a05600c0a4800b0040fd3d8c8d5mr4758685wmq.9.1707307676300;
        Wed, 07 Feb 2024 04:07:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXt+qPwWfutWoTuu5m18N3VTIW5s+99Y11Ssn0X6+okgZLtO6Bc/dIi+xYQSsj5hCMdDX43+1bjs8JiZUvV8BFePNa+pPx3w6EYREmI3XiKK38+EcDl3Vs8Cr2AcjCnY2cTTWvd9g3i2p0NZuCWflQYjf85e4tRdObt7NoaZD+wzF5G8kLtioazEegYeroQMZMS4btE3XZXsgJmTwwEBE7dEbioRnTG2eho41Q7S5NHvgN/KB8dHavGhSMlGCLAQ2OKDn2dNGeFbKSuviVR3dHf/mqcblmigSyCy+cXGeerMZhoj6uXJSkoElnpWnguWhReTzB/SptjRaU=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0033b4db744e5sm1363957wrt.12.2024.02.07.04.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:07:55 -0800 (PST)
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
Subject: [PATCH net-next 4/5] net: ravb: Do not apply RX checksum settings to hardware if the interface is down
Date: Wed,  7 Feb 2024 14:07:32 +0200
Message-Id: <20240207120733.1746920-5-claudiu.beznea.uj@bp.renesas.com>
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

Do not apply the RX checksum settings to hardware if the interface is down.
In case runtime PM is enabled, and while the interface is down, the IP will
be in reset mode (as for some platforms disabling the clocks will switch
the IP to reset mode, which will lead to losing registers content) and
applying settings in reset mode is not an option. Instead, cache the RX
checksum settings and apply them in ravb_open() through ravb_emac_init().
This has been solved by introducing pm_runtime_active() check. The device
runtime PM usage counter has been incremented to avoid disabling the device
clocks while the check is in progress (if any).

Commit prepares for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes since [2]:
- use pm_runtime_get_noresume() and pm_runtime_active() and updated the
  commit message to describe that
- fixed typos
- s/CSUM/checksum in patch title and description

Changes in v3 of [2]:
- this was patch 20/21 in v2
- fixed typos in patch description
- removed code from ravb_open()
- use ndev->flags & IFF_UP checks instead of netif_running()

Changes in v2 of [2]:
- none; this patch is new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4f8d5c9e9e03..df47d3e057c5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2385,8 +2385,14 @@ static int ravb_change_mtu(struct net_device *ndev, int new_mtu)
 static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	unsigned long flags;
 
+	pm_runtime_get_noresume(dev);
+
+	if (!pm_runtime_active(dev))
+		goto out_rpm_put;
+
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Disable TX and RX */
@@ -2399,6 +2405,9 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 	ravb_rcv_snd_enable(ndev);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 }
 
 static int ravb_set_features_gbeth(struct net_device *ndev,
-- 
2.39.2


