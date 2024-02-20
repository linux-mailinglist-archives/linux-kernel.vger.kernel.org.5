Return-Path: <linux-kernel+bounces-73243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20285BFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBA1C2113C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55F762FC;
	Tue, 20 Feb 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s58moo8e"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFB76050
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443022; cv=none; b=gCoRCgIHaU9RlOZ9CJ+F4AoFjS07R0bQsNUZQtmftEoi6geATnyQUlNsstJIiI4drSHWtAgk8MnBvreybjDC94rNi29M80q8uH2vDTrpAVcR9vdIaU+U6lyBkP4KtIPysuuGpu60oc0HT54EY9GHQ9tFhjOQQWOJDKwDLVRT+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443022; c=relaxed/simple;
	bh=O1s6f0aVlfXsIZe84Tbyl+6qx99iwWHj2GqrxpYofNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK8A1G0m58JUqeoK4sOsgGwDVocVgYGJgPZasD8xraz8TEPR0Mb8dZgSXaEQWZVj0jAkkwjE791rLUY7klLtU18hwLHoVMFs3TlvwPFzVOyoryw/PwYjKOmt2/qvRpnYx7kBqqic/Rr7R/O+saz5VeWvENbmLGxbokfaTgb3zC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s58moo8e; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41272d31489so629305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443019; x=1709047819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg9eYBATJE28KVVYL5JHYrMeYFjWDGTymWB+eHLR51Y=;
        b=s58moo8e4vRXAc/2zrcfftYY3bK2AtDu/F8iOkPPou/KqAAOEX6NftKqsK2WXUTNTU
         n7LT7+BvO4SUbiXW7iV3fIn04qY8jS6aHYlYbdfIWkkYnJtpLo7DArbeFEnPLFdzKfmA
         L3XKfvq/AbfRmUV9PWC9OpQRfO2djA0JjmQWY1cKDT4zFos+MvPnUdw452ic3jDbEd6D
         vTQ3t3KZv/94d2b4C/pYkQs3Y5F9Juxiuv588rQ1gOfpwh5qPC9WXuagNC1xOf0qV7Fy
         GczybFyeZAqVkk+MD1krH5eqXECOuEQAqd/cp7p1uN6uN7Ill10D3GOzbz9GY2vytQuv
         Tinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443019; x=1709047819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg9eYBATJE28KVVYL5JHYrMeYFjWDGTymWB+eHLR51Y=;
        b=dAIloFehk/3DZAqqkJdv41VWwbTNLwlpSSbvGC+g+BcBQgNVnZXlmuYbsSW/p7WjU9
         d+vSfhIzGhApYo9CPR24xshs4NgTAPVIZpoJbw7c0Ndv6HLDMslvbw+44kQD1divB2Tr
         qdds7HHQFf5Lc66Ek8OBFFhlCJlJpLqOyJstpeGtEWPP9i41YoA6VWNBY70OGdWN0yQG
         c1RuVsdxivz+JbI25FHMLA1YTFMWQ9jSAFc39BceRg0w/PDTlBcYHNsy1O86Cms348ba
         mmxv1HM6/2pSy2NzxyAomttedB46ra8D5FaBRDm7D4Tqg9t0PLwFrr3wRSG7ECHDL26e
         V4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA6QtK9yqLtPkjc4KH88+8otw6W4rm7+zcEMEU4FVtqqusrhKIduzi3+Unq5DWYbyMT40cHaHe53yX/NG1f4e2OwDuK159axPrkVJg
X-Gm-Message-State: AOJu0Ywp9baq1XMoge2hSX45N4C5wE6grQnervrUmOPZMj8/SiiYpvvX
	gczpakSDpTSAwJaBg7FDSQ/dtnIxe09p9Cm1yyfXagFeUHz/EmorsMZOOuPhi9U=
X-Google-Smtp-Source: AGHT+IGVWP1PsTIPuhfoCEDD9mFLoVD1M1jFW0GdMz0Ht5jy2dnUwgwZCQxJtaVq+F+uxqiSbUMY5A==
X-Received: by 2002:a05:600c:1d04:b0:412:62ec:672e with SMTP id l4-20020a05600c1d0400b0041262ec672emr4734507wms.30.1708443019097;
        Tue, 20 Feb 2024 07:30:19 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b0040fe308ff25sm14691564wmb.24.2024.02.20.07.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:30:17 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:30:06 +0000
Message-ID: <20240220153010.76238-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153010.76238-1-daniel.thompson@linaro.org>
References: <20240220153010.76238-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 0f59858d5119 ("backlight: add new lm3639 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/lm3639_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 5246c171497d6..564f62acd7211 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -338,6 +338,7 @@ static int lm3639_probe(struct i2c_client *client)
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0


