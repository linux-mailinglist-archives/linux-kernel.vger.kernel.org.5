Return-Path: <linux-kernel+bounces-17593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2C824FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBE61F23B02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699252E41A;
	Fri,  5 Jan 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qP021Lgu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760122E40A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a27733ae1dfso154070166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704443107; x=1705047907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ8CzScii+mqzmjbtrVuVx2JcFAYoPC8SxGsrNUa8W0=;
        b=qP021LguCyMr20k6VTFD5ZxUE6GRlK8C3CiuWrIFYOV+JclvpV2cBL36RMHV9Hhcwj
         mT9TxnYeIav2/S0KfmlpJulGNLjgjkfGIjS6mhH987sbEJuH7AkRafcwfidD8GukWA94
         BmzZkMP9LThfnVA1mo3qijIrj7fi0IJEPsG5ocB3Quh0W7jyK++EApGGL1TmYtfwUUXP
         ZflJuXWm4gEf33J5mGa+D2hNIbnhwd0wM28tvv1tS4KG/12MbLMCBcAsyc8G0e2y+t8G
         up3cJBuccEqlCDRDoi5b89jlTscIZza++3L5SYtdjxFo7eOQ4B7036lY8CaoCUE9EAut
         HdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443107; x=1705047907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ8CzScii+mqzmjbtrVuVx2JcFAYoPC8SxGsrNUa8W0=;
        b=WxerRSirsaanxJJ/1gmGPylspDgH9/KLTduYQjMc/i7ItOlylHEacq40qejDK9jMxd
         +X1oqildpPlm5jRlY1t/mfdgmPWTkOG8h3rpIDN4BjzUv81o/6SEnc/N6rBbLBXKU+U1
         nf0hniNf0IeEzi4gFces8txrl5qeEsUg/lfxUDfMoleIunuG3T2v6RgEmW977ieXV80k
         QMrwAczjwND1zfufXBaL7Y657r2ejlzYFnmieu1WlpzlIZZvwa6yGQv4f8H6G4dRsQM9
         +8mcXlYoMixNr6biQcuKwFknrkJ+suf+jqqVpu/Jg43p9okK4GFJ8oR/TNft9BymWdlx
         sAEw==
X-Gm-Message-State: AOJu0YwBWOfsV/JirR8IxyO7MqkKhMPDsAOxtBdVOVY1/B2IHuNvix9d
	gBBaiy+xdWp24+aXwmYBG4BOpYsARnnGrA==
X-Google-Smtp-Source: AGHT+IFWZB6NKmnO2ulUMzSLhOWaBcth0szNVWmeTUpG37ZUpJY8VeDUyPHoAe3UQk8czZx9fE0w8A==
X-Received: by 2002:a17:906:4a81:b0:a23:65cb:6f7a with SMTP id x1-20020a1709064a8100b00a2365cb6f7amr479978eju.78.1704443106857;
        Fri, 05 Jan 2024 00:25:06 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b00a28e759a447sm596198ejv.213.2024.01.05.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:25:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v3 14/19] net: ravb: Simplify ravb_suspend()
Date: Fri,  5 Jan 2024 10:23:34 +0200
Message-Id: <20240105082339.1468817-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

As ravb_close() contains now the call to ravb_ptp_stop() for both ccc_gac
and gPTP aware platforms, there is no need to keep the separate call in
ravb_suspend(). Instead, move it to ravb_wol_setup(). In this way the
resulting code is cleaner.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- fixed typos in patch description
- collected tags

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 434b4777de5e..1d228e0d875f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2890,6 +2890,9 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
+	if (priv->info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -2922,14 +2925,10 @@ static int ravb_suspend(struct device *dev)
 	netif_device_detach(ndev);
 
 	if (priv->wol_enabled)
-		ret = ravb_wol_setup(ndev);
-	else
-		ret = ravb_close(ndev);
+		return ravb_wol_setup(ndev);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
-	if (priv->wol_enabled)
+	ret = ravb_close(ndev);
+	if (ret)
 		return ret;
 
 reset_assert:
-- 
2.39.2


