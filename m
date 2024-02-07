Return-Path: <linux-kernel+bounces-56464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C293A84CA7C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307671F2C27E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E425BAF4;
	Wed,  7 Feb 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DALnMaps"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E15B68C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307676; cv=none; b=UAiqPNJjKwgYJ6NGutW2LJSKxR0KRbQMwEwAxuYFrVdIDHA2HNcotQxVxyzR3FmA11SHy8gdrsst5wqlHfW3TTrEtGrQ/r09B1aablsM/hc/cvkwN6uP2AazjVjRnE2o2eGS6M7tklYatxA1hqzPQwZiJZKNX91VnNHEciPLq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307676; c=relaxed/simple;
	bh=HzMlCY/Qn/3NM/tReDw8aLGBXBUfCm+QYcZzIw0FINM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cwdo8PIiNpjsx+LQt/dP/Oo+hobCNbK71Vjz+LcMLJWVKeFbc0FhNPPW0r9c/9bGbqc+f77m3gBoLw+BYJEeXANhf7Lnu+j55ftFrQBiIKv0zPtSAAfR7jGHOUstxh6gnymseNuL3hrJ4miwthqzVRELXICkWTIhqitdgpHt6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DALnMaps; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so416266f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707307673; x=1707912473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kaiMDGRSMM1zSx7d5RwSXQOkmnjMZGD3UM1O1/WIzw=;
        b=DALnMapsKTD0udKd3+Q+4Xk+oWruDSSiDUwAYuObz7NcmpJ+kLXh9pQ1pkoYzfCdPK
         pJYwkSm6BSJNWHYPUNSjCg6+/DrLxR8UJDTP82UpXpTxG8KAlPnH4MpTq2Ri1tiGOIjG
         nSjuckaRyxx+58pszxV+/Ms6a1SE6k5JPFWVzLiZdVg7dBet7nnWef5ONIyuTW44vJso
         cgfjeoXNV4FBV4YvnOJEptusfIUuP5JzP8O9gYy8vTQAVFe9ByDw9t9iwj4aixdkZ4g8
         OjJ80gJJ1eQ4m5kK3Qqk7hD7rC7OvXU8OWKLARQxa7GjFPZ/K2apRaVNWolOuCEoixO/
         ZQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307673; x=1707912473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kaiMDGRSMM1zSx7d5RwSXQOkmnjMZGD3UM1O1/WIzw=;
        b=aLA6Q5nQaRYkh9n/sU/gQ5XfuHnVY1chSuyAz6MIzIgQsQbrh6ZThHKRxmblIdbSqL
         DhfQXABX81KxdmpjfKaIXYoBjS5XQCyldP1kMXjg/kwunrNirXVTQ/zvhgeLUnVFN5cq
         a30C8HZhI7JIfXOdAtGtovl/c6UmQhjqYAmP1xwbXlbNKWCAcd8PUR3+oQfXXzL9na+X
         iT1rhkzE/YFr/frhWR8z384W+82wgi3lor8l6jsE9i4rUAwFbuhFnBm96bLcecFSFL7b
         n3AMVVqz/MTUea3htisrA62/zBgLm8NMms1qWT/TDU5ssc//bAK2abl+enssrBuz7bLO
         JN2w==
X-Gm-Message-State: AOJu0YzRXhL/K3ouejtA5e2j94X9Jiuf/fv7kDGB2TkyXnu1G/IG6R9H
	6gQ3Rl69l7ffV/4E0KixNhsLTIedig9gEHjOsrH29P2xSWUwWwGhdWCwUkPNp+g=
X-Google-Smtp-Source: AGHT+IFLRqFpSYGEH05+H5nozQ5GlEoOkoTg3cB6FW88PVgbemVDuudp3Wnd9c2gDgAmMYG3688qKg==
X-Received: by 2002:a5d:5f83:0:b0:33b:4b0f:b989 with SMTP id dr3-20020a5d5f83000000b0033b4b0fb989mr2495919wrb.0.1707307672200;
        Wed, 07 Feb 2024 04:07:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtAmcMTuR90O6jEqWVyYaTB5twZsArS+hW6V0aatu+fU3AQDC4ELo2FdCW2ZsBYkVDizPBElBHV85Xoo0o/BWimP1pXMWsd+fsG5Vh4eMt2yu7Wch0uckFs7kfSdMwxykrWwdKO9KmON0w3lxYXNMe2aRsRc+6TGJvY5yWfHbOYvtvt1F3LBKSMCHiQHW2VOytpSBgVtCtMZVh8I9DgQN+FuN5rmsL9QRzCWysI0ZDfjc+RGHF22eVLDkG7KnFfu6gTRgQxiZxQl8eH+jIS/POVoMVaeMB9u5gN7l8dWx+ECxcH6INv32HkIyUYkXrnR8WiJfhEvSumn0=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0033b4db744e5sm1363957wrt.12.2024.02.07.04.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:07:51 -0800 (PST)
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
Subject: [PATCH net-next 1/5] net: ravb: Get rid of the temporary variable irq
Date: Wed,  7 Feb 2024 14:07:29 +0200
Message-Id: <20240207120733.1746920-2-claudiu.beznea.uj@bp.renesas.com>
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

The 4th argument of ravb_setup_irq() is used to save the IRQ number that
will be further used by the driver code. Not all ravb_setup_irqs() calls
need to save the IRQ number. The previous code used to pass a dummy
variable as the 4th argument in case the IRQ is not needed for further
usage. That is not necessary as the code from ravb_setup_irq() can detect
by itself if the IRQ needs to be saved. Thus, get rid of the code that is
not needed.

Reported-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes since [2]:
- this patch in new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 27 +++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 9521cd054274..e235342e0827 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2611,17 +2611,20 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 		if (!dev_name)
 			return -ENOMEM;
 
-		*irq = platform_get_irq_byname(pdev, irq_name);
+		error = platform_get_irq_byname(pdev, irq_name);
 		flags = 0;
 	} else {
 		dev_name = ndev->name;
-		*irq = platform_get_irq(pdev, 0);
+		error = platform_get_irq(pdev, 0);
 		flags = IRQF_SHARED;
 	}
-	if (*irq < 0)
-		return *irq;
+	if (error < 0)
+		return error;
 
-	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
+	if (irq)
+		*irq = error;
+
+	error = devm_request_irq(dev, error, handler, flags, dev_name, ndev);
 	if (error)
 		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
 
@@ -2633,7 +2636,7 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	const char *irq_name, *emac_irq_name;
-	int error, irq;
+	int error;
 
 	if (!info->multi_irqs)
 		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
@@ -2656,28 +2659,28 @@ static int ravb_setup_irqs(struct ravb_private *priv)
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


