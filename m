Return-Path: <linux-kernel+bounces-102655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D987B567
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D072FB20C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D355E075;
	Wed, 13 Mar 2024 23:54:35 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1735D73A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374075; cv=none; b=C5fjKW1HjT62LutGfipEtNuOqxSUYmVfQPvEHeJI7j2FmnmwpyH6rrXNDmG+YTHnHBqrXeHM+9ryNQrxUufVqDocGhpOAEwNARz+0PgRZhdZMKZGNvu4WdzDhtjrViiZd0w/mudDL5cLOFY+ecDuu6a7ehGS//+ftNoAB2XlBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374075; c=relaxed/simple;
	bh=4haKc0BWmXZv48XAJVDKU0krU0tVfIaoXXWWf/W8YnQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Unb7JQ9BwaaB4GdhQGs1Y1NVkhvcjuS5h/c8C9dKSxdGeq2pLTwvciNhpSSjrWTTEg+X1+WkdWRgUzle8Y1v+LExY0wkEL8KVKvzXUOr/y8bpPz4EBcOznWW4R4zAxuif9wP3Wg2GKutMZzBUZlN8WLt+M27LAvXIwcCFOAfLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 05614ad2-e195-11ee-a9de-005056bdf889;
	Thu, 14 Mar 2024 01:54:25 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/11] pinctrl: aw9523: Destroy mutex on ->remove()
Date: Thu, 14 Mar 2024 01:52:04 +0200
Message-ID: <20240313235422.180075-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313235422.180075-1-andy.shevchenko@gmail.com>
References: <20240313235422.180075-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If aw9523_hw_init() fails on ->remove() the mutex left alive.
Destroy it in that case as well. While at it, remove never
true check at the beginning of the function.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 4edd371c469fb..66629af0b88b4 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -1067,10 +1067,6 @@ static int aw9523_probe(struct i2c_client *client)
 static void aw9523_remove(struct i2c_client *client)
 {
 	struct aw9523 *awi = i2c_get_clientdata(client);
-	int ret;
-
-	if (!awi)
-		return;
 
 	/*
 	 * If the chip VIO is connected to a regulator that we can turn
@@ -1082,10 +1078,8 @@ static void aw9523_remove(struct i2c_client *client)
 		regulator_disable(awi->vio_vreg);
 	} else {
 		mutex_lock(&awi->i2c_lock);
-		ret = aw9523_hw_init(awi);
+		aw9523_hw_init(awi);
 		mutex_unlock(&awi->i2c_lock);
-		if (ret)
-			return;
 	}
 
 	mutex_destroy(&awi->i2c_lock);
-- 
2.44.0


