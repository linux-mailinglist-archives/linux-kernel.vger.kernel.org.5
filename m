Return-Path: <linux-kernel+bounces-153464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC08ACE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2671F2152F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A9152165;
	Mon, 22 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LkJ9hzO2"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702A1509AF;
	Mon, 22 Apr 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792971; cv=none; b=lmgMSnHOKJdHbCQlCHIxWxaVcmwhw6Zhrjc+t9YlEqkNBDGG+q4cNa0wMQONGxS7c4v1aubykC7uu7iRdzB78Mfh81XasX+EEVuZj8kZ9BYU8vm4XgRQWYkfnmHW0i1OsqihGtdFxIL80m8DWpgY4qlRG9IHgOpk8E00vWj5Q2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792971; c=relaxed/simple;
	bh=+w06Be0TAX3C5KYPO88oXI77bWnptU5o1vfpfDnP5CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=si5GT/Zk2oPdEwPnr4Z5EEXB28mmzmPhpOk1LvqHbWDdQQc5G421y2lFyZCFh0gCpqqzKj73Q5O/3uO6YJBz+M9xrZy2L/0qdJPP2c/rlYOaLRMCtbB7JuziyXE5SyecieiwdJvRdyfzT/RwIsvwSy45R0yMhUWoLQL+THfShbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LkJ9hzO2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 428651C000A;
	Mon, 22 Apr 2024 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713792961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNswcMmS0UYfsHKzGlg9eZWnaGdsyWARoSLz/i+rBuk=;
	b=LkJ9hzO2NSwzw9itaFvpwdJx+aik2qdRH/KeHDycjZDHEE2UeLUPWgZQs2cF4XAa8hQOBH
	mKWT00mNYNx7zge54CVDzm79Ene73xxkts3IfBBJwKU36+3y7lKPUaO2kjXZbKCkKM2cND
	iuP80+12/YLfjalfmYtw+vGmyWXapRgidUoJtMoZHOXZ+kNZ8sKruXRH+oOnRnTlMMwviO
	7PfqKSBKoVHw0oLTA/SHdsvYW6bgTynr4djRBDUhMHMiw9LhnS07dMgboAzXk0miWs/pw9
	IEU5bfsVYL0o95bECyMp47YlblmI3r/aEW+MRuNTtz6eNuRfVHDQ8UGctj9s4A==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 15:35:47 +0200
Subject: [PATCH net-next v2 2/3] net: pse-pd: pse_core: Fix pse regulator
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix_poe-v2-2-e58325950f07@bootlin.com>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
In-Reply-To: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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


