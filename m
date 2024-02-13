Return-Path: <linux-kernel+bounces-63251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42774852CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF8A28CE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29154F8C;
	Tue, 13 Feb 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="avw8iUbx"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E30524C2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817310; cv=none; b=gi281XROXuNG2+sTWqfmmAyUIfSw4T+C9zBGjDnXC241ZZJIQrLG2GU67BU5+9ojQfdJnBieWZX9VhlIdOBShjPRFlzxKlfjYJ5GFGeGMC5VcjHM3Xxuk8aX8yDzQH2GAGOWyLUKqRNHmh+uwN1tyDRPOF1rdWxeUS5bJ66HFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817310; c=relaxed/simple;
	bh=WV8FSkl5YwYxmgU6Z/VKljzD29i9dc9v4Oo9UOpnmTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwJO137uVXu1ORZDdwdDPJ7rg1sVeGZ0AGG0FdgeEDQ2tRNbxffKDjW5kYkkUTKp5iIis0BBSyK8vzr/tX7hcZoIAexS5wTLC4dahHSa92mCroBVEANOVLKYDRbdU4JWdrH8XL5XYdGfevnv0Twt7lEp9xVSBazZYdGVv541dpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=avw8iUbx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso6520835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707817307; x=1708422107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjpBbInCxVXMckDKlb1X2pBcFBDdY3zPqFanpTI/+i4=;
        b=avw8iUbxPkxL4+oaJHW0LrSkUDZ30IXRe5YUHL7EbRmsEHqaDbNVT3RD13sj1hsv1N
         Q05QMNcdwJx5Xk7UAFHWUyG5Dp7WRKVgQ+dAS0Ow/w+qUejBphbdU8PQiVwRLnllEe5g
         22iG/sJzjke2wttb5DDAcEB+oaufabkIc111LhWn+oYpvudbNpVZQc2OBlWdSV/6/9nY
         o2EZYDFi4WMOwAbLM6XWWGgCbnYc2CgLg8j61a1t8rNm87Y5ZaUBjxUJxV6bhz/fOSWv
         y78Xwlk3a8kz1iE4P0+1OwoNA4leI2vqk16Mr8H+ltCdh9lElh93xNHfIgfMp7uTOiW/
         LGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817307; x=1708422107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjpBbInCxVXMckDKlb1X2pBcFBDdY3zPqFanpTI/+i4=;
        b=laQuTlx9TB4L77hNhiuUoK7tVXTuG6nNWapMq8NOIcP4Lz9klwaxkAy6Xa+2rxxEZK
         7KuwyUA/fuP7dYlgBW1CaMVPr+E9isaXojbsRv1/mXH65KZbH8+WtRf9oisVW7Zahr1U
         P1JqaSItLiT7M6q5Nr54tPuPF4QTdfiytN2EKl/ZYA8CWzX6uNogfSjSysjxzMm4elEf
         zgs/p7LcFQP4UASsF8cUjINjFQ1EFfgFyQ7S06TBN+aJ8ydADxC0ouldxuO+C/kbeeWX
         vYM7MWy1U/Mw3dAZsZenHwrGhZbBds2ewwpEAA0lwHmLAMq89XHV8b9m4EsEP7OYC85f
         uhyA==
X-Gm-Message-State: AOJu0YzGlQWOZs8WUk54bMGWz38J94RPDqb+dYOee1GTrAhZY+1+FTA6
	N7+W7sIXXflr6Smlv1AZP2AHPjOx3yoTpdjgFMGvdzy/8x3NqhiQ8tUkIVI6SvI=
X-Google-Smtp-Source: AGHT+IFjCaHzNMpqVPuRua2fReqvdqjAgVYWybfp7wGjFQt+6CVMGyFSfT5t3z86mlx/Gqm0FXikTQ==
X-Received: by 2002:a05:600c:1d1c:b0:411:50aa:110c with SMTP id l28-20020a05600c1d1c00b0041150aa110cmr1737496wms.12.1707817307225;
        Tue, 13 Feb 2024 01:41:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVu4bAcAhu3dzF1s6vl2Da30WVZxWiUvmrTiLoQvpFkuWYVuwImENr83RFlEORbdTcYMKPR/wq+OmyR70o1CKQH7BGQRdQo+qx0+f1Lhx4fdl9ghJBog4sE3Tfr82cigYgVQPNhj4NsRr9+0fGaj//HuhzWqfZmIXIXLaZPSfpctCZpB378rFBD12xDr1lBENW0kqn6FhfxzyhQ9W1m1qnR4b/w+8INO1hENq5NH0IF2n+w8FPocz32Jc1M54QOXK7aZIsoEk/6nQlbWr9hkC+9dyzM72t4qxABfnxE7hIPzxJ3UQ4TP8vUg4tD0w7+zQSPsBzfGIR2+KfmqQAxzkuKfLhnwCTeEhB5OiopPhdd8StyTb+g
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm11207446wmb.25.2024.02.13.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:41:46 -0800 (PST)
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
Subject: [PATCH net-next v3 5/6] net: ravb: Do not apply features to hardware if the interface is down
Date: Tue, 13 Feb 2024 11:41:09 +0200
Message-Id: <20240213094110.853155-6-claudiu.beznea.uj@bp.renesas.com>
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

Do not apply features to hardware if the interface is down. In case runtime
PM is enabled, and while the interface is down, the IP will be in reset
mode (as for some platforms disabling the clocks will switch the IP to
reset mode, which will lead to losing register contents) and applying
settings in reset mode is not an option. Instead, cache the features and
apply them in ravb_open() through ravb_emac_init().

To avoid accessing the hardware while the interface is down
pm_runtime_active() check was introduced. Along with it the device runtime
PM usage counter has been incremented to avoid disabling the device clocks
while the check is in progress (if any).

Commit prepares for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- updated patch title and description
- updated patch content due to patch 4/6

Changes in v2:
- fixed typo in patch description
- adjusted ravb_set_features_gbeth(); didn't collect the Sergey's Rb
  tag due to this 

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


 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b3b91783bb7a..4dd0520dea90 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2566,15 +2566,23 @@ static int ravb_set_features(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int ret;
+	struct device *dev = &priv->pdev->dev;
+	int ret = 0;
+
+	pm_runtime_get_noresume(dev);
+
+	if (!pm_runtime_active(dev))
+		goto out_set_features;
 
 	ret = info->set_feature(ndev, features);
 	if (ret)
-		return ret;
+		goto out_rpm_put;
 
+out_set_features:
 	ndev->features = features;
-
-	return 0;
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
+	return ret;
 }
 
 static const struct net_device_ops ravb_netdev_ops = {
-- 
2.39.2


