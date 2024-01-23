Return-Path: <linux-kernel+bounces-35294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11356838F24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD230288F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD735FF16;
	Tue, 23 Jan 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="myfLVAq1"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C245F867
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014781; cv=none; b=fva4rIGrd+FPfywS/spqMgSmkqkBoFBHsXa71hT+i1fq1cOiJq5n/BYEAxedJqLNC2Ua7B3iVKcTTHxhZMz1rz0HrkDoqLpvg+eeUFAXIFjODg4wn7tqUWI2ohLmLRGPqsIh+Essydr+J63BnnJtnsfKSWCCPtcvGW3fu0GJszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014781; c=relaxed/simple;
	bh=dRyt6tWlbiKqoIJh66DiSSuXinFPKcVAZdUgI40W4Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVfxx3XmEd5vnf9SjxC8YRS6/ek4YV5Z7jd7SEQcIfRr1qioSYjKewP/cRaXAlY5TIBxy1yF9NxJOQFVVViFlmNlyPr4CKJSoOY6CahDustb2x7qjmNb9qdKnV50aSwgD6GfEGsVGJ3hFLVIrEwXuphKkcz7hIzLy9Mz5SL/7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=myfLVAq1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e7065b692so46617735e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706014777; x=1706619577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pkNsgorlOGjO2MgWb/dT6E51SlKpQ9V2ft0OBIasSE=;
        b=myfLVAq1GSzrsIPignzEqKZyx4XfxUBYnJg+wgXt9As14Qg19xDU4hdgR4KmKcaCK4
         lNvIzXFakDO0S+kYB+f8lGMT+XBgMO0ehgbygVQkMW/PXoxbRmj8HRFtohyDZWJRCfiS
         9pkZClJvLLQG7Y6rbwimFZI9scQjX2AipL73F5h6qs6UO/WmV8GrwCuiw/KE0momw09o
         7sGcoXAjAl61c54MI60wrB2RnaJiKp6VisA4e5co9VibeX9VdZ4QnjJEwWbN5WhWwKRi
         NBuGoXbiTAteEr0OZS8BnXr4T80HoiSkLurJuAU+KKq6x81M2WU22Vqjw8x84RN8+0fK
         cjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014777; x=1706619577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pkNsgorlOGjO2MgWb/dT6E51SlKpQ9V2ft0OBIasSE=;
        b=W8msXe4EaK+VxvJv8NalMHUT3iZL8vegJeGBolXcdUeE9ltu+pw+Vx1vdY4GbotObe
         Kn/T6UR9pEWuKHg1jg6kyO+9hKT0RtsryEY1BZLc7GWcfI5NoZeZ3+OwldfBWrlKA4SD
         ZLnf6JrLSe1093lM4jMgJv3rZDa9Skdm7YPHGTI1ePbSW+EyfMniONVhEAV1JnMVsRWS
         E2pM2pSTIX2RPM0Qs05+4qnLIoBWdmqotNs0/SAj/cRph0V3AzbiMfMAr7eQsrPxsJWN
         bRLIqOYuq5Smg0mj3QJvAkiDTrv1eNG4qV0yiCg3zw2r4wX4mttKNdQzmV4uLccemxgB
         MfPw==
X-Gm-Message-State: AOJu0Yz+HFG42JTXw0D8E5T5MPgybxNu8/rdoNfe8G9NIEhzQKt8xiyq
	1f39jqT4Vl8U7SiyFu7hhEvVNgxuiioBG21y/zZyD4m5hwb1nK9kU78R6AdksgM=
X-Google-Smtp-Source: AGHT+IFH7tBcsGS3WsUDe+n7CUyuFtsX+cq7kxc9uy/KMcmXwHHJNM9zSRkzhzDJxNKStViTBqQnSg==
X-Received: by 2002:a05:600c:1e84:b0:40e:4395:bc4a with SMTP id be4-20020a05600c1e8400b0040e4395bc4amr111242wmb.67.1706014777163;
        Tue, 23 Jan 2024 04:59:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c45c400b0040e6ff60057sm33655711wmo.48.2024.01.23.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:59:36 -0800 (PST)
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
Subject: [PATCH net-next v4 04/15] net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Tue, 23 Jan 2024 14:58:18 +0200
Message-Id: <20240123125829.3970325-5-claudiu.beznea.uj@bp.renesas.com>
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

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require __maybe_unused protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the __maybe_unused markings.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags


 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 65b084778b93..d054d1405cec 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2971,7 +2971,7 @@ static int ravb_wol_restore(struct net_device *ndev)
 	return disable_irq_wake(priv->emac_irq);
 }
 
-static int __maybe_unused ravb_suspend(struct device *dev)
+static int ravb_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2993,7 +2993,7 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_resume(struct device *dev)
+static int ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -3052,7 +3052,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_runtime_nop(struct device *dev)
+static int ravb_runtime_nop(struct device *dev)
 {
 	/* Runtime PM callback shared between ->runtime_suspend()
 	 * and ->runtime_resume(). Simply returns success.
@@ -3065,8 +3065,8 @@ static int __maybe_unused ravb_runtime_nop(struct device *dev)
 }
 
 static const struct dev_pm_ops ravb_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	SET_RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
+	SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
+	RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
 };
 
 static struct platform_driver ravb_driver = {
@@ -3074,7 +3074,7 @@ static struct platform_driver ravb_driver = {
 	.remove_new	= ravb_remove,
 	.driver = {
 		.name	= "ravb",
-		.pm	= &ravb_dev_pm_ops,
+		.pm	= pm_ptr(&ravb_dev_pm_ops),
 		.of_match_table = ravb_match_table,
 	},
 };
-- 
2.39.2


