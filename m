Return-Path: <linux-kernel+bounces-46036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE29843998
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C05E1C273BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C488B7E77B;
	Wed, 31 Jan 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IpHUfG7v"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D17B3EC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690529; cv=none; b=rCtPGcc/NTF5KjCbfzUR9QFGL0i1F01gM319E+2rEVvMLYh95s38bxlm4a8XjWE9Wll4I5STB8oKz+L+xIeTNi+/aezfNS06qc7FHpi/HxlfLg8GeRJKvfIOyJgyJOmq0hQEIz8SosUm197GxQiqb7DG+VwLxtOi/5MK3bXsFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690529; c=relaxed/simple;
	bh=M4XElsAbkAPToo3ZEnKBpvLmehS5jEZzhlJpMuxS2lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cImx18yFzDOUk+YCRPUqINz5U4qCwgJXBeMuEPdk54yWO7ke+wO/Fc46Nr/jM1V1s6JwkqYmIj4v8wuOZGGFF2N7COruj9zx9b1Yr/dKy5T4TubxODiGm8kKeWmsskxeF6/xn+MedPVvHqRwLhpWbsZrt6wC7emYlzkNgBrZvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IpHUfG7v; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so5325172a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690526; x=1707295326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1XrNomjmra/GM8RS/lknacwokF475kMeMhwWZ3EcPk=;
        b=IpHUfG7vGrYoMGri/XmbloOWvDcKQ9AFzDYOQ92wu4KCpW1cbM2Px27HrdVYIJd+Eq
         zHLXboJ+ZgY/cRoPLGoKEHiymO2GtyH9RJkdHWzVo050pyjLp434PA7uQp3kf6RNLLbX
         uaL14BScifZSILXbfD2M0fKUvvodRjAB5Qsv+S3Vab4tKL7tgqMJWwOO/AJsQ5kxvIrA
         gYE8nOo/BCrlmVU15EKn/iEBtGpRJidIa+h3spZQNZFZ4CJQ6lv8LSkzSZqkep8FgXwf
         lgJJZuuYBONWGxdrPHdtVy6U4xY53qFUJTDnk0fYHTWY078LMZFVoTBUoOOUA5mdSs+o
         rs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690526; x=1707295326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1XrNomjmra/GM8RS/lknacwokF475kMeMhwWZ3EcPk=;
        b=SNNVW8ZFEGHZwKWXlGOsw4/2B7bii2XhrKWLKWFXHgw1fbiVqb2Uk7xGUA7R5LQ2eT
         AzUtx5RmxUT7BzbC0qLMfQPJFS+IUG9bTDRmdMo3b4B8s6Pdvwv5V1W1Q0kEp7CjDQF+
         Okp8KB7faQ/YpfuzIW763XfrZFj0ScI3imW6VMrlAlcPRyM0xB9+6Om5f+tuIUdI3Vho
         lgd4sTd9OqerVbRenH2jpH3Th0I/NVermkwp9bO6/kwaP3Wq38iy8p/BI00z9Q/r+vm2
         8djo56rLEg2tJQSU+v1DCd1aR5AUUAG3efnu7C7VBZcuU/VzA0hfygp1BFy5g40IZq7X
         rWDw==
X-Gm-Message-State: AOJu0YwBawJVdum893GHHtzIo93SkpiZ/aE44Ccpc3HJnJr9uqOcu9tz
	FBRL2i2jRcMyx5mv52XzhGgmEFgLMt7fTxp4Cbndt+8awMwdLVjOuQMvL4tPsJc=
X-Google-Smtp-Source: AGHT+IEYcNtSIIzLCU/TMm9w1bEGYlnXRZN3KzRwiFoYa83jrAWMHaIWWxOlkyinI5M2+MzKlTNT+g==
X-Received: by 2002:a05:6402:1cad:b0:55f:82b:2da3 with SMTP id cz13-20020a0564021cad00b0055f082b2da3mr561401edb.22.1706690525968;
        Wed, 31 Jan 2024 00:42:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXIkeN+/q/7fkLe7PzMiRTrGGYp00Bgy3bQ1jPEuKPEBJVX0h37D/hMWLvhlSkSi/f13QSgf+r+BRMOgXxH2a6200kHM1DYhsUJAYuPrh+rbrACpP24O0qT5nlfxcDfkhTSEYigBHk9WPIqNVGzy9itC6VRSD6ZM1TfbPIlUSq3J48kjLfI4HMJy0NaWMPPtGVnHq8NwXx8klz1JZY0Q3wBlpSgklAgzL1FuUmw9Dk+JQnTPWmfWMRX4x6r5HlVt1p4uNCk2AwybR+1C1+9FID1AXV+1CbZiZQhaYKIfgfSUJXhmrQHcocU6CSpuKjHJENER11RspvZ3awkm5ws8gSx+02Joy+fx4+IfcaVqF2QmJ8kX2UsBRZQXPGQYRlqCKdibrNBG1lMKzAyZkHH6xN444BHhbTPURQnrRaOj4AcTId80Hw=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:42:05 -0800 (PST)
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
Subject: [PATCH net-next v5 14/15] net: ravb: Simplify ravb_suspend()
Date: Wed, 31 Jan 2024 10:41:32 +0200
Message-Id: <20240131084133.1671440-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- fixed typos in patch description
- collected tags

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0dab98ea615a..661236affa5b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2929,6 +2929,9 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
+	if (priv->info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -2961,14 +2964,10 @@ static int ravb_suspend(struct device *dev)
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


