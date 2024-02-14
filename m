Return-Path: <linux-kernel+bounces-65305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED831854ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C221C20B99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6B55E5E;
	Wed, 14 Feb 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mzhq07Tf"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291954BF5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919129; cv=none; b=dZkr/o+Uj3zu+AS9qFWHFdb+brMi2s2s3g++ybp2mR73tk1qCy6P4Znw+ElN1jRwk7c9JLZ2IsUJ+FTlQDacjr9VfV3yZeXir4mdf9H5r1PfxSGibUtN6ezyvZ0/s1LQFCPs7gBNZ4awfi2heeI6glCxfAHy6A4Lw5D3ATiJbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919129; c=relaxed/simple;
	bh=ovrPp+G0VODHlIZZU4WtY6ajQ42RxzeAYpVNEp/CzVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NteKl7z2mR9e5yWxMs2qqSUtTz2R8ZP5go843U5tKsZvOCtHzfai2g8u6tPlEjwQTZntfC7NLc20eKTBAZUmkZZw+WZG7rz1lqZ4fwBMuE8dpxLImVRRIYQYpUhjRW24n1QPWThlvg1b6MoXDezVGwm2rtZDAsg9LbaYwrvY5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mzhq07Tf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so3832761f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707919125; x=1708523925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swsP/3c8yGBz0+swt8nV2kFhh+Xlnvuijm0NkYnRlL0=;
        b=mzhq07TfcC6Fz2m+pzssbdBYS5+AIXRxrOi/f/73JMpyWwg4piHoX3dQZh3y8JMLaU
         bdOpS7oHldrsFbd3iCHTOCx0ZWCI4vtQQ5jdg4lGTzviUWipiaDTbiJdNN8rX9XFoBvE
         yMtqfSLsg76Xqx1cLCAp7e4xI5s9osU1Rej3S2P/8uBSYT62Y4nHMB8R0WStAAoGNqGU
         L+bEd7UxpQD4K1LfCpNj3qPwGsNWuCa8AkG1qwM1B6Q/xFg5Tbl72m7V/hvhQmdLaO1R
         fBt/iyuxIP18Fj8bsYOT0j7AJXchobrm1UpmFSS9MboTO727nV8BVZ60Szx4w4H7E5LN
         /vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919125; x=1708523925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swsP/3c8yGBz0+swt8nV2kFhh+Xlnvuijm0NkYnRlL0=;
        b=vlVtKS6xIb0sKHyklVeOy8AW/9mfhNMXkpoyE33/2sX9kXnYfiApttemoFjW3i6off
         u7SikdTCuPJlDTdDKbBsFRBTRfIOWVPGaeWZvPg0LkNoLnixEGsBp4TXbz2NsIkwWe88
         b2NN5fJZoptrmiD+N+5QxTRzvelQbKZ13BRywqr2sf2VK/0KWCE79BJid9WvIU0FWu9J
         t07YJWUUr4Ej3CJikp9Wp8fOH58nZkw22jzV8rG8AZLILSMWviuFdLEQopS1Vd04BhY8
         J+yFcIMbZwW0mI+RUkV54+8hQnkEecSvPWyzb3jmZs/LBYnGU/EKchs1kCgYLDoCLUUK
         DhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5GIBKB3NlIMRwHjeN/DjhK7d+F9PVVrDysYc5PdaZHCGH0SLSdFKSyBiHAnkcxtCqZot55XWn8FnSBJQhqNrTFjMmD0y+IXnSgR/w
X-Gm-Message-State: AOJu0Yxm7f5hBPuyLqedifzMhgPWu6tRyTPpApPETk0VG6+cBJM/RepR
	TZMUOtgVSuXhLQ3cUMa04k6aB2WbxyQ5Xqu2EvIns9XwNW4iigiaWAGWH5bL/Co=
X-Google-Smtp-Source: AGHT+IENq/aQVmiWIMkqE6w6BpWTXhUntX74dLJ1qh//yRk8CEm3sfE3YuGQ3K6h974s7VbERJttiw==
X-Received: by 2002:a05:6000:152:b0:33b:4b0f:b989 with SMTP id r18-20020a056000015200b0033b4b0fb989mr1657935wrx.0.1707919125306;
        Wed, 14 Feb 2024 05:58:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7Vta8OeopnfxHn57LmxvTKp1JIiFuRvtgRSj9PFHX8slQ+UHHUIOc3ukCNu00VWYWt4tSAaBXccLgLazfdBWb9Ufc/kye2D6MSHXhGBaTtV4vE1ERFI60jz9BKes+xGNkghe33es23MfBrukQ9l+LfbSPfvTvAgSLeFBw0kQalbcfTF1SYhX6COOt4ong7shGYM+xXoaaa8jJifyTjz/M6ML4hM2qz4lJNXZEXV51vOTNe6FV/f4RMQex0uT4DWl2OYW1K4hXMOv7WrEEgORFIhNgYiBMRu5KeycqQOD99H6ppr1jVRSR+DpeS6Ax5nqMPpR+2HQJc/UvZvCnP34nTxeXdSALSYxE3a9tPL4UGEwMO0VU
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033cdbebfda7sm4282140wro.14.2024.02.14.05.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:58:45 -0800 (PST)
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
Subject: [PATCH net-next v4 1/6] net: ravb: Get rid of the temporary variable irq
Date: Wed, 14 Feb 2024 15:57:55 +0200
Message-Id: <20240214135800.2674435-2-claudiu.beznea.uj@bp.renesas.com>
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

The 4th argument of ravb_setup_irq() is used to save the IRQ number that
will be further used by the driver code. Not all ravb_setup_irqs() calls
need to save the IRQ number. The previous code used to pass a dummy
variable as the 4th argument in case the IRQ is not needed for further
usage. That is not necessary as the code from ravb_setup_irq() can detect
by itself if the IRQ needs to be saved. Thus, get rid of the code that is
not needed.

Reported-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Change in v4:
- none

Changes in v3:
- collected tag

Changes in v2:
- use a temporary variable in ravb_setup_irq()

Changes since [2]:
- this patch in new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f9a1e9038dbf..a1bf54de0e4c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2747,24 +2747,27 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 	struct device *dev = &pdev->dev;
 	const char *dev_name;
 	unsigned long flags;
-	int error;
+	int error, irq_num;
 
 	if (irq_name) {
 		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
 		if (!dev_name)
 			return -ENOMEM;
 
-		*irq = platform_get_irq_byname(pdev, irq_name);
+		irq_num = platform_get_irq_byname(pdev, irq_name);
 		flags = 0;
 	} else {
 		dev_name = ndev->name;
-		*irq = platform_get_irq(pdev, 0);
+		irq_num = platform_get_irq(pdev, 0);
 		flags = IRQF_SHARED;
 	}
-	if (*irq < 0)
-		return *irq;
+	if (irq_num < 0)
+		return irq_num;
+
+	if (irq)
+		*irq = irq_num;
 
-	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
+	error = devm_request_irq(dev, irq_num, handler, flags, dev_name, ndev);
 	if (error)
 		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
 
@@ -2776,7 +2779,7 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	const char *irq_name, *emac_irq_name;
-	int error, irq;
+	int error;
 
 	if (!info->multi_irqs)
 		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
@@ -2799,28 +2802,28 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 		return error;
 
 	if (info->err_mgmt_irqs) {
-		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "err_a", "err_a", NULL, ravb_multi_interrupt);
 		if (error)
 			return error;
 
-		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", NULL, ravb_multi_interrupt);
 		if (error)
 			return error;
 	}
 
-	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);
+	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", NULL, ravb_be_interrupt);
 	if (error)
 		return error;
 
-	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);
+	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", NULL, ravb_nc_interrupt);
 	if (error)
 		return error;
 
-	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);
+	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", NULL, ravb_be_interrupt);
 	if (error)
 		return error;
 
-	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
+	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", NULL, ravb_nc_interrupt);
 }
 
 static int ravb_probe(struct platform_device *pdev)
-- 
2.39.2


