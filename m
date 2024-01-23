Return-Path: <linux-kernel+bounces-35301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8130F838F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10921C2650B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E760878;
	Tue, 23 Jan 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kVpYesco"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F7605C8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014790; cv=none; b=N0nIrFz0FnJEgS39k5fia0YDMOdHAWqYfm84OtxApyWunGYYLsj1kZlvRrWtBQ5FU03bsZ0BE4jxMGGaQ8nCWjd/CC/czVBRn8obpsOnNbvv6xKq322kDDpWJqz3flZdKdwwLvJOksub6OQn/6lNkjI1A+NgjdmIz8j6123NdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014790; c=relaxed/simple;
	bh=zwRf00erI7gL+iVp7EL8wRdj+/3c4hH+mO5H4G4Z5WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEPt/Ecm9pEyrvpIQhOMd93cuF6NZ12bqAaUIt6z8nUEnMFPi3WT3XXJyUcv+1F6oUEzPZdONbJFp26h/2r1ulZbCK+mGYY7RrkySZJ50HNUnjj6wypycPffc43gdd8NEOfGMaf0K31+6/+FTtmzLCoVVmTHUQjSjYhOV9glVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kVpYesco; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33931b38b65so2210994f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706014786; x=1706619586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oU6e2ETHxF91J7rUEFncHWZOjTNYygzuarRFBzd88c=;
        b=kVpYescoHborLoAT9qW+S2lnooV0v/b3/gznd1o5vXvEeodA2PO1bd2ppn5zhMCn16
         End3R3dAhRk5TqPXUD9ddS+vZuEVfmSnDS90dNyKRNE4j/Pv8hBVJ7va1fqOR9NaEs88
         vZyUq0ZnjE04WqDx5wq4F8/Fm1VBhUQGdMiHRIuR4ijBpgg0+KPo4f9c1j7bFyJ77MP7
         fXKKvlywOONJTtBta0fGRKQTUvM7j/pK1kJ2ckI214RJLP4D44sPHdvnXV59lJZY5kqz
         Hhk6DQ7/6k8YrpPVF1C1dhjvy9iG6gS/tKsTvJAcpSUvwqajGfLkWCa59fG+dSTEy3d/
         iPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014786; x=1706619586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oU6e2ETHxF91J7rUEFncHWZOjTNYygzuarRFBzd88c=;
        b=j/QAE12WnUKwENABVZk1ggi2Q4JvLyrN8W6ltPNCyt3Ym1qANnj1V1LaonxXNS3dz6
         yyn6UuabOVAZQy/28Tz85cC+KJ2zoAyloKnMZWCilNjv7k2xWoCR7gLwcuZuz1Xp6e6x
         vzD68pGJPewbS2vCxVL8oXQTg3A3BIfZxAa6j0oXtaHuBKGUUsrUCeB+DMUMpgbuh6/r
         AytwQ+hPAkzcGjn+ICvA0x/89/TwIXdFzAEurBfo3bJGCwM6PP05/i8hVDcoAj+qEcNx
         nycRzzNeJkjS8ObuDXa7bm8Rrgk/jvM6Eqr3OFH8TezCCeqKodox/MoquQ54cZxLlCZF
         pJXg==
X-Gm-Message-State: AOJu0YwvPk+5wIaoKEccpROTmg6qDH8ATNuw8VPSdcAt2yppxBirS+Mh
	lK5xHxisteZhrSoHEioE4bbRcdGDGLgV/TX3kZwx6KIj/NtNLERsBg+qz/TG2KE=
X-Google-Smtp-Source: AGHT+IGB+gMNBnzgu6BSJSZSWfnZQHIGkS7WejcQ267fGk9sxfCygh1ubyAyFYo2rFP0dkj3WSmDkw==
X-Received: by 2002:a7b:cb0e:0:b0:40e:4996:13b0 with SMTP id u14-20020a7bcb0e000000b0040e499613b0mr240501wmj.272.1706014786082;
        Tue, 23 Jan 2024 04:59:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c45c400b0040e6ff60057sm33655711wmo.48.2024.01.23.04.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:59:45 -0800 (PST)
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
Subject: [PATCH net-next v4 11/15] net: ravb: Move DBAT configuration to the driver's ndo_open API
Date: Tue, 23 Jan 2024 14:58:25 +0200
Message-Id: <20240123125829.3970325-12-claudiu.beznea.uj@bp.renesas.com>
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

DBAT setup was done in the driver's probe API. As some IP variants switch
to reset mode (and thus registers content is lost) when setting clocks
(due to module standby functionality) to be able to implement runtime PM
move the DBAT configuration in the driver's ndo_open API.

This commit prepares the code for the addition of runtime PM.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- none; this patch is new


 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 69d4854d6738..3c7748b5e14e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1865,6 +1865,7 @@ static int ravb_open(struct net_device *ndev)
 		napi_enable(&priv->napi[RAVB_NC]);
 
 	ravb_set_delay_mode(ndev);
+	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
@@ -2808,7 +2809,6 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
-- 
2.39.2


