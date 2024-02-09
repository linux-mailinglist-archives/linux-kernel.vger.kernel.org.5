Return-Path: <linux-kernel+bounces-59694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37484FA8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3771C2555A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB67E115;
	Fri,  9 Feb 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IveuWMye"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA227BB0F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498311; cv=none; b=QcLI5nOD+bj22XDIfIjPZdKXBY1EklwD+Wz8ClN+CtTpmVXMUgnaU2MqgZMjaW6q/7HZ1wAfIcpdz6Qa+xS3Ic4ANR+6a2u8sID1ytO/TGvkAp+GowLZ+OrEoiFSSw9hVZrAzjcKFfGME48zDGxzjXGaLAGKi5flzj49FCE2Oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498311; c=relaxed/simple;
	bh=uPRNapVGw8gXTZ9OJ20weiuo8n1QMpLfQmGGR/SfpJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WeDQzhs2vSpxaaeW19DPBG54MRqqKcHqtO4sqroHYOBCYIaq12nc9VjOJZnuxobLHJM8nh256e4+PtPjg02aOe3VqDlzlWaGAkmA8geJSL6FtxVI6rS43GSeC2pQPmTypuqHkjrb5uZ2JMhn/6GS91PcdxHYwH30dBTG0UUSaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IveuWMye; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b65b2e43eso527853f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707498308; x=1708103108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMmTy0VJjCKazgGQSctD6Q6nmkdCJjbXHjwyCoGK8ZU=;
        b=IveuWMye9Cd9q8ph/SP4YD04s8QI7MP+PbhGzJy7fi59ft97RWRRbZFiEfBSeYE64/
         MJQe1wWn4v8rlT8UCL1F9LK6y6CTvb8F9wv4iHOSnJDLRSnwQpp+sS4+nmnV6bcUNt65
         BcCmQEGzqt1hM8lTLuycP/D2rZNMPmOEN70E9SElkszcBaccv/3EFn4dXMscbtdwQz9i
         EUO09uczCb5HlwGlN490Z6k3Zup+fjHA1A7LfqLLCBLl/RwiJXZN6Rejz5X7RM2k/ywR
         Jhe+IKRXuSB2yi/8+Y2wuDOf0DwX3GNdcLcY9psTaPHVm1wtmMSafqghAiHDpm38saDe
         o1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498308; x=1708103108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMmTy0VJjCKazgGQSctD6Q6nmkdCJjbXHjwyCoGK8ZU=;
        b=WNV9YJLeyWwMmlksGMgtKc8MauOeFOYWPqrgaEG/pUNwAjA9O0QKDGWzogz7CE0z4h
         Ho+JiveMlOb3Paip6KXWTlRq9r+w6XBlGUzjbr/GXSRo8nuoAelznmH39Oy2VIcp25PF
         noKrg5iMPI8fBR+l5P/IsZ8RTfZA32AOov/qGuwmLmj4Ax5RhRTJeFM7jnF2ZvoVSjd1
         obRnrxAkbV8LekyAPoS5v8Ew5Zlnl5tB0WyyJrixTEttVkSvha4lSAgK3x21Qw9yu0RP
         yA+g9grvm8JsAEIjGzzbHj+I+LOfMcU5rVRETgwpObaOQ6jrmxBd50XqqP5nNFMPYKDp
         EOIA==
X-Forwarded-Encrypted: i=1; AJvYcCWIadIo8CNyy5IoH+qemZtKw6M0sOY5sSn4c8IjgJ1yKxL8R7rYb3dEVk13U3qmWxiFmztcU8aB2hjaVR4Owteq9w3B7QvC4Jm71Kiu
X-Gm-Message-State: AOJu0YzT4ZLhnqv6PPaxgx/5nNq6UXkKaIA0dwe7I74Z9nSKr+6DXqf+
	aH1MhJ2aacK6zO3nzwzRIA6nrEZdDqs45N5UaBygMTEc/51QNEgHSZtnl0K7Y2w=
X-Google-Smtp-Source: AGHT+IFgtzspeBK4hEYCypshcRxjjVT3A2LpSsRXKi1lePH7r9k6/qCMkhxkT0CbxGA5+0FisbZkBQ==
X-Received: by 2002:a5d:5192:0:b0:33a:fe3b:b2ae with SMTP id k18-20020a5d5192000000b0033afe3bb2aemr1626156wrv.66.1707498307928;
        Fri, 09 Feb 2024 09:05:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrLVQK/yh1IgtY5zXY/uBTVgbbVheQV+mlW1rD/wFw/A5oow2qDFCsFiFu9EZPhOIoPkmvtTQBE1s4Xl/QTeXHLFgkdfzSRe2qmagqQLxDCH9aghystw7iRORqPnmf5CXD+2qJ3uG3k1quoSjoEqjiNNqJyu53UF3nbhupyw4ayNagnLcnBKcOTE3ceKXo7U4SDWsUg4gX0bjUsQ5UKpwJHUyAh23F63h34yF4zVhSdunsd2CHThAXaaaGz8SZXrjNtYakqjl3yKa+fshWN1F5gNProC6DyS2t/HBmYyZYlfMxDpehA+wyI6658HOQjCtRQZceK+Ap00Y=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0033afe816977sm2254998wrx.66.2024.02.09.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:05:07 -0800 (PST)
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
Subject: [PATCH net-next v2 1/5] net: ravb: Get rid of the temporary variable irq
Date: Fri,  9 Feb 2024 19:04:55 +0200
Message-Id: <20240209170459.4143861-2-claudiu.beznea.uj@bp.renesas.com>
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


