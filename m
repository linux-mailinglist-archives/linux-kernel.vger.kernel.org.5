Return-Path: <linux-kernel+bounces-154779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD458AE0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3571F216E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C55EE8D;
	Tue, 23 Apr 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CDIXZBin"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235C5730D;
	Tue, 23 Apr 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864079; cv=none; b=SvSIj7GnZMIEtM9xlqANFjqSBVS2NegvG9t4VrWjba9HwBioSkhMGgDyEf+vWZbJ9dawh+P8HMvduQx7uaHHOHJ3sEg17CoUswuUbtQ+E9tlXbQYbymRl7lMaV01CRD3Naoa1jbClwL/LiYW6swcdaEy0S4ZpW+EQfiGA8VEt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864079; c=relaxed/simple;
	bh=+bcOG7iwFtnTz2lO3InRZDB83IfORLXmlQlsJoEGxnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tL0eShSYHDPk4l7WQojWmex8BvkeXal0aISfMZq9I0+IUvrDx/bPFNWruF3dLlH+8/+TnX6mgDDiSO/kXq0xMWWq38axbFZzmhkCCzzGrj8Oh8AI9DXCLtGR9hUJHFCTwIGKxwGCkIUD2M2iCGqHzfxSjisZy2fZbg0EZfB3Yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CDIXZBin; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6947D240005;
	Tue, 23 Apr 2024 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713864076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgnZ9zkLYTGa0PybM1NeuEhzLN21P/rf+/AbMdi1VXM=;
	b=CDIXZBinKb58tvc+8OO9aLxk2NOB9NHuGFKFEBruVht5n4Zd5ygFqxwIeA1ZlbaxXcRSiz
	fgl+MVMMCTgVDlTUbQl1Vx0lnbgoR/ArTYS2wqDup9jTKnoaqLbQLKWeXSIPpIh0SA1r6f
	GAO5enmLMFj13KRJjZ00N7wnez/f1wpRpOgCETd1HYZ44GUj3e/mkZ5NTbvxCEgB4CCdSc
	Gz/jzACbosfAtLZsJrznT0VrSIEUhkFaK0uoyKja9HPFLOrcs22cErgnEaZPfckZFnquVI
	Bhs89zU+a77Hh2mdSkQ7Grhwm1J/0900hFCnot9XDzkXHLmavanUJVGBVQdh9w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 23 Apr 2024 11:21:11 +0200
Subject: [PATCH net-next v3 2/3] net: pse-pd: pse_core: Fix pse regulator
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-fix_poe-v3-2-e50f32f5fa59@bootlin.com>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
In-Reply-To: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Clarify PSE regulator as voltage regulator, not current.
The PSE (Power Sourcing Equipment) regulator is defined as a voltage
regulator, maintaining fixed voltage while accommodating varying current.

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Change in v3:
- Add a missing Fixes tag.
---
 drivers/net/pse-pd/pse_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index bad29eaa4d01..795ab264eaf2 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -294,7 +294,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	 */
 	rdesc->id = id;
 	rdesc->name = name;
-	rdesc->type = REGULATOR_CURRENT;
+	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->ops = &pse_pi_ops;
 	rdesc->owner = pcdev->owner;
 

-- 
2.34.1


