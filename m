Return-Path: <linux-kernel+bounces-59696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762B84FA90
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072D81F2810A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DF680BF7;
	Fri,  9 Feb 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l7T8VIHe"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2E7CF37
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498312; cv=none; b=RMKLTgNUcXRC5Vxs6/eVJHpCyJ8u2sAgxoycWCMnhPqpQl6bEIUuAcmdoDLbXAkiezh8DUVKOwE+MghtDhuetz8rgSG+gl6mNbC5hCzDs6QCjoLtsH2S/2DB6aIkZPTQ8dJpTuFntArblc9AjhQOlAWosJsgAcBVjgWfrsUlLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498312; c=relaxed/simple;
	bh=E9qfFlPW1e6QyyiFWyQNW8LWGspZ155/NwV+vfM7aoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXEW2FScKo1XqKyxJ0zdfBEOu7gFe82JET3NFPov0MTM2SChNApQYTqYOOD56Iz0BEc24B4IhwQxKkL28NovT+P1YSPlcRP6bbSoODyRH46fiI7kAU2n5dUUVPUoUusTUiijy2HWC5v59xD9FR602GaCAc15xauS4vIIlb5RmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l7T8VIHe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so727217f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707498309; x=1708103109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJVjrzAqciRb2/LRj7N8tiqtGPPPqEc7yCwP1DwWHTU=;
        b=l7T8VIHegpD1YRWTO6MaIW2hj6CeU+uTg5tmRZ3y2TRklBUpQTWPvdsoLPhKmVOqUv
         QgRzKMXBg0ut+7cipkcImfG6GD6hpaRcqtiPlauQAOX4xqqqKt5rQGJKAytvzIrlWTcT
         b6pkLV1KFEm5HKWkfBDmIc4VFq3kyKvd4nwjgTJWDsarNV7ziH3wQSSi6bA4DJ7iiJPp
         19I731vgH5Sys0J51pDwf8WM1UaL9vzNeC2m/KUXED+yaiBleWTGuhGeBpf3pTfrmqdV
         jU2oMlTH/Y3xBdJ4yGrIcJKaS8eUcPLmt+/vG9l4GU+bq7jY74RyTRDAPBmLA6IF3lZO
         SeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498309; x=1708103109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJVjrzAqciRb2/LRj7N8tiqtGPPPqEc7yCwP1DwWHTU=;
        b=KERJgesn/UksiohgAxBnttYf14ldnoCh5V/6CDKR/I6gWnIsIVqle24oeYoI/6rH9t
         bZONxtibKQVggXCw1yBfhbHd+Vf48CztnODFowR6xa5vBojyKXUAR7pCRUSRcUTvxzN+
         ntbQJmysS3juzyIzD+ESzXHSIs0964RUJbnlFRT90vspJRnQMNLjDVK9bGiwMTjs/962
         n+aonykvci24tGIAAgHcUXACD0x38vEaK/SkyuyW5MlBrt0h6l4VqMA6N7qOmihnp6pP
         zStt61t74eQJvk6vnADBv56xNEJnSKkKiCarvXhEheMszvi1IRicmt9Z2CY6ZIFYmAVc
         rdfw==
X-Forwarded-Encrypted: i=1; AJvYcCXuXUEFButP+HeMc7Xs2byS8kb6ubhuwmCPJNC7ABdRLZaSSe3ZX3JC26ICSB64xKcO9Jm4wRdwkKuAYws0E13L9Nm7czf/KhGC3DeY
X-Gm-Message-State: AOJu0YyNiKfEvJsj/XypcMkLSY4B0ETtdW81FKkwJ+C4bYJ60b/JAF+5
	t6Vu8Me/bfe2QkPb3Igch2i0vVJ7vydNaaYQjrxqdPic14xhRmJB9y4YK5/Zwx0=
X-Google-Smtp-Source: AGHT+IEHp22JYBjn3LBrSBS2ExLaFTW9k7a4NPbhDL5/QOqpK139dOb9BQtAHdDvKxL8IrBvZERLSw==
X-Received: by 2002:adf:f987:0:b0:33a:e7de:aa8b with SMTP id f7-20020adff987000000b0033ae7deaa8bmr1508064wrr.26.1707498309451;
        Fri, 09 Feb 2024 09:05:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUL4NavJtL5JVa5Qyv6YHLP16s54U4xbfNKAHPk4QSUTjHRZVC7rScJU2FPwmIlt5b5HX+LCfOT34/72Q9ciLLpeaEVxL8z/63tDftL56fqTjsDzwzwsxM+iS1lUHZau+4yGYUkv+XDo762sSc/3MQxMQ5D0ilM5MW0hgWRBglOy31oJFFWTMnMF6SkJCf9copIVlu0I3rUm5CSFm/rzAEogw0wWxINU2/ly9Qpl0O3lkygYzXQpUGpEXQb8+MyVWTeI94r22kUn9+84bXezFq3HEc6y1fzHZxhoWLC27uKfqO6GOK/gDoRwy7Ue+KEw4ZmJ826uZE2e5Q=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0033afe816977sm2254998wrx.66.2024.02.09.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:05:08 -0800 (PST)
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
Subject: [PATCH net-next v2 2/5] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Fri,  9 Feb 2024 19:04:56 +0200
Message-Id: <20240209170459.4143861-3-claudiu.beznea.uj@bp.renesas.com>
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

Keep the reverse order of operations in ravb_close() when compared with
ravb_open(). This is the recommended configuration sequence.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v2:
- none

Changes since [2]:
- none

Changes in v3 of [2]:
- fixed typos in patch description
- collected tags

Changes in v2 of [2]:
- none; this patch is new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a1bf54de0e4c..c81cbd81826e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2321,6 +2321,14 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, RIC2);
 	ravb_write(ndev, 0, TIC);
 
+	/* PHY disconnect */
+	if (ndev->phydev) {
+		phy_stop(ndev->phydev);
+		phy_disconnect(ndev->phydev);
+		if (of_phy_is_fixed_link(np))
+			of_phy_deregister_fixed_link(np);
+	}
+
 	/* Stop PTP Clock driver */
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
@@ -2339,14 +2347,6 @@ static int ravb_close(struct net_device *ndev)
 		}
 	}
 
-	/* PHY disconnect */
-	if (ndev->phydev) {
-		phy_stop(ndev->phydev);
-		phy_disconnect(ndev->phydev);
-		if (of_phy_is_fixed_link(np))
-			of_phy_deregister_fixed_link(np);
-	}
-
 	cancel_work_sync(&priv->work);
 
 	if (info->nc_queues)
-- 
2.39.2


