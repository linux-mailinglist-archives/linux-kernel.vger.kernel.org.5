Return-Path: <linux-kernel+bounces-153390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B65D8ACD88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1D81C2154C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2DB153BC5;
	Mon, 22 Apr 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XZR3t/Fn"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA514F139;
	Mon, 22 Apr 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790278; cv=none; b=EoRfFDYsnzOE7kjzBsiFqA5LiPRJLy5sB1IgpLgdBsLJWkg1XIDIFc8+MgicIXBMVVfppPh4t0P9IaD1y2K3hZHCfFvT7NunycbueZBPwYdqWOD+lR1KbJGGTyZrEpr+BBp0gDX4DQpEXD1SGyCahKQuEGnpTBoQlFtkYATuM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790278; c=relaxed/simple;
	bh=pZup6IX9whDC+GUqv8toQf9MbWPsLL+BwlekArhfqug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lR6Y6W2ycrRqYc2IJae6PYDVW8tozYK+5SkTfCvzrssZ+xWMbpLSvdwoeR4B2pwBubYEuv8Uz3HIbCecMnduLDu2CJXCy2xnC1sonj4NhhtQDu8WckeNgeKlyppPUyQB5VaQJIlVBJ8a552ut+l3Jc+Bffr0xKqpQdKZly+MX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XZR3t/Fn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 123586000B;
	Mon, 22 Apr 2024 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfes+4t5c35ODiMlxWYaLOGHAams96sWxDZfek9UqcU=;
	b=XZR3t/FnPPfN3XcwEk19O7PvefnlYGOa/C+pp/E2iMomhu/Jt4OEkXRMtP0vu0RPOTr8lT
	54K0f3eVNqrh6arEQkVgDEfBNAIrbVx++qTbwwb7etthC5Y10knbK7/TD1Lq/GM8aMAi3V
	kfJTK0RJC9bKuaABY3HWXew8tQdkdnq5lBj2ThLvfl3sMmV3nSG/UbOT5EWV/HXsAVCh62
	H1PWHuqhaynv0QljE40GqmH014aaXXUBHdTwFTZ1TZFDZW+tqVm8b4Dneh1BuJfSyoWFEz
	nrhfbE/RpxySuESH95xiBvHkFflHdYQ8QsZhLl9EqswOA+XbebiorfbzlrQzGQ==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 14:50:49 +0200
Subject: [PATCH net-next 2/3] net: pse-pd: pse_core: Fix pse regulator type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix_poe-v1-2-811c8c0b9da7@bootlin.com>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
In-Reply-To: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Clarify PSE regulator as voltage regulator, not current.
The PSE (Power Sourcing Equipment) regulator is defined as a voltage
regulator, maintaining fixed voltage while accommodating varying current.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
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


