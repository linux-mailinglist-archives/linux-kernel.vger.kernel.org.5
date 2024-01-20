Return-Path: <linux-kernel+bounces-31768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E508333BC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A33B21F25
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F063DDC1;
	Sat, 20 Jan 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GYpUNtW5"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FAD26A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705748620; cv=none; b=RVpfYLDkzUiAblq+1tX/5+i9jz4QIOPWLjbt7tFspK265d7JWgdESaNYij0vfXKDdwcrpQpYxQZPBc1UkOCSs5nNvxkFVhwG1mC2rOspiGL43ttZ8TpnwijBerWxX5KbkgkTk1Q/7+8HsNIPveXhqM/B0RXVatZCLBvQGtiC4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705748620; c=relaxed/simple;
	bh=rq05Q3CTtTgQ1urJlIhpHt7f6eCXdIHqDcVdECHIwao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJCyPGN0RMLfSDPe0sRfvtYvNt5iJXUlLes3AuReNl2ZchHh0zf658dVhinFqDAPbutxZPSbQeRLwO+93SsMOpAyN/vmv4QBvCXYp8e8VxZG+LFE6emqm8V0BHbPA+KDy/tAneN6F+Q+naQp1acBq17aHfV9MAwADOlCxgrqvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GYpUNtW5; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id R98NrmVHvBejiR98NrhEeh; Sat, 20 Jan 2024 12:03:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705748612;
	bh=GxQFw8ZsE9hz9MpyTlvTEQNDbRZXAH6gthc9NucWNh0=;
	h=From:To:Cc:Subject:Date;
	b=GYpUNtW5ZgVk4Q0J2G/GpD92kEHqtkXbQNsn+2OVT4l1CvJVqbtfrxPFPpn4D+IFm
	 NFi71HNKYBRUyLvXBO52gApxR0o0YWhj/3ZaQewPxtx0cUUkJp/KejSd6OI22u59Xy
	 6DKRvlZbxzxOPIFwqUukl6EX48AEWgmKkUvSzTG+gTlen6Iq4ZzPr//NBd9xUuRKwf
	 r7fgS5X48SsnbO0Gu8VGY5aPV3g6WV6rrm1y3xMDvy+wno4yPBGp85Ddl3TyoNbl5O
	 4AlX9hK4p1g0xVqTSBFUR+0A1+BUvxzVHUM7iCr+2C8NOHgnhBNy7F8j1RJ8FGu67S
	 DxxAlI+cWtGnw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jan 2024 12:03:32 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regulator: fixed-helper: Save a few bytes of memory when registering a 'nfc_llc' engine
Date: Sat, 20 Jan 2024 12:03:26 +0100
Message-ID: <3f990a7b80d72c31371735b24ed08acbb8392c80.1705748586.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regulator_register_always_on() calls pass a string literal as the 'name'
parameter.

So kstrdup_const() can be used instead of kfree() to avoid a memory
allocation in such cases.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/regulator/fixed-helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index 0eb2442456f0..2d5a42b2b3d8 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -15,7 +15,7 @@ static void regulator_fixed_release(struct device *dev)
 {
 	struct fixed_regulator_data *data = container_of(dev,
 			struct fixed_regulator_data, pdev.dev);
-	kfree(data->cfg.supply_name);
+	kfree_const(data->cfg.supply_name);
 	kfree(data);
 }
 
@@ -36,7 +36,7 @@ struct platform_device *regulator_register_always_on(int id, const char *name,
 	if (!data)
 		return NULL;
 
-	data->cfg.supply_name = kstrdup(name, GFP_KERNEL);
+	data->cfg.supply_name = kstrdup_const(name, GFP_KERNEL);
 	if (!data->cfg.supply_name) {
 		kfree(data);
 		return NULL;
-- 
2.43.0


