Return-Path: <linux-kernel+bounces-46032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA184398F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2546B27454
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AA579DAE;
	Wed, 31 Jan 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eSqED3ta"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8563768FA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690525; cv=none; b=M7d/L3J6/o/7ISED/xOjvkO2luAtizemcbRvYy4819hLubDEWO63uES+jqjTv1CSURNlDAn/mFDIpEDCHgEVQaoL+8DurHw2Al9fQIMoQDboFQbUrFWnAqDhQ/kObzMHpgaFuSjDBoV1Xc95Wry9nmHZLnAYzGa+vGT7wui6V98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690525; c=relaxed/simple;
	bh=/BMX0x/G9bxJjbupfpU/dtjHS5xnYYvUXfe51rH81nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfTcq+BUKpkj9yxoa5F0PnYfo5wvlQBWsDwvpGZsu7SwhsEweJS7ksmXFaCskLRPH6yJ/iWeyq/wFXLlfbNCxbWwRiH4CFXY5c97vItK+5nqj1hjy5naMoq00gjTjlJebfBGvCSRZYQSccxnsAfeU4rh5w8GPg+n+SxXUXjWQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eSqED3ta; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so2788507a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690521; x=1707295321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHLjzks9Tom/l8TYALcWPAs3A8Rh44UPVwxAZBkCSa4=;
        b=eSqED3ta/qRiamOCL/TLnLipHg9Z10wFkl8ama7sgAkrRQMan5Pz8pm8wRxUuEdYFF
         puxriH13WkHiMoUtfkzZZe2KkIgL/JW9l1sLN4ftXdHhdham9lRhsoFoQl/wOeD2LiBN
         8KKRXhXrxqoO2ncHOYjxqb4FSKOVXni5prUktAn97sEjkekrRpSavEoySwKsgZdvxbYu
         niDDImlAgBfTTZGgAHS+IyMutAgDPvUaE61vU/tMmpBghYlyc4AQNqmTQztY/z9fCdQv
         q6p0curhvtj+AWAKWKOA91R5XStjgbBgqzB70CyJyU9DuUn++0XvvxmkLUbRKDoQhCm3
         vkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690521; x=1707295321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHLjzks9Tom/l8TYALcWPAs3A8Rh44UPVwxAZBkCSa4=;
        b=MK2GevaODaIbuOySms9t27OhP0PQtKef846iBC9R84stLMmFLCiYn8oH1+0E8nDGUw
         IYtHvmZffezime+t++bfmyu0cwlJCfMpJq/ibgPLX4YoU8UIJSnRNSjUvkz1+lRljK3j
         IZSnu58g5aHyJQygluOeMyQS755Dwvedya6mneQdgwcQDnqVnG9C/TqmfU4kAiKsZ1ja
         4Nb23I51ABWZCydsWSMf0syAD2JaMmnj90WP+fTZevOAW7C4hr+FxYfjSc4p+51CosFE
         DygjSk0XTIcK1RQMV46/42LCuuhVpEbVxWjTQ50MRK8zEZaSxDymELlgVFAt0V2PTf7y
         oWfg==
X-Gm-Message-State: AOJu0YxTicXXmJOR+nBfnaixPcbssTeIKM2BKCvqfKhvt54laaEaZBgT
	wUR6snGOw6djkAWeFHH/5ksJOwHnwVpQEEe9eAqFnq1ynK1/EfGGMEasksKoJRU=
X-Google-Smtp-Source: AGHT+IH7MVKtCh910v/vagl15wE63ppiKdvQ13gV3Gx6m2Z9oNLNc/iGIHulI8TVJy/3HvqwCdFLAw==
X-Received: by 2002:aa7:ca47:0:b0:55e:e9f3:4f7f with SMTP id j7-20020aa7ca47000000b0055ee9f34f7fmr633451edt.9.1706690521065;
        Wed, 31 Jan 2024 00:42:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWEqOO0JVT3DNYj7IKD4YRbtpXvrwJCG2b4edkq52HydSFFRxV7Ng6U6xMATXJ6aNp2dAu4bAMZ+6klPV014fzrh4XOGsjeEDXUVhBewECEZHWT4XEENKxgIek4iEVBD0TMe8WIk+2PZVsjJX/ZKL1yQiDekgRT6Dc2wQqjwiwMywZcz8OMNgu+5tt6ooSSRblgT3JFkiRnZs5h/FOpDKj2sIwv+WQ+6MjCLspkBhUrdDMZCN1ZTcPTt3YO/+M4hpi0AoW/JxOWKc3cHmTi17E0l9JiFKQqLEGtCnvCqpO9eskZ31wZQFEH1BaZ8vcWqGMhRfnI5JA/46wacFJTpf0g1TKQnBfzX4qG/ivcedEizuaAu42QfH/52Ww9lEoMDd/bW+FUGsIISiPX16gMDSy77cmocKlzKdOUKWdFG7aapqvqDvU=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:42:00 -0800 (PST)
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
Subject: [PATCH net-next v5 11/15] net: ravb: Move DBAT configuration to the driver's ndo_open API
Date: Wed, 31 Jan 2024 10:41:29 +0200
Message-Id: <20240131084133.1671440-12-claudiu.beznea.uj@bp.renesas.com>
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

DBAT setup was done in the driver's probe API. As some IP variants switch
to reset mode (and thus registers content is lost) when setting clocks
(due to module standby functionality) to be able to implement runtime PM
move the DBAT configuration in the driver's ndo_open API.

This commit prepares the code for the addition of runtime PM.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e5805e0d8e13..318ab27635bb 100644
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


