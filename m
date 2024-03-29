Return-Path: <linux-kernel+bounces-124418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A87891742
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C978DB23CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E66A32B;
	Fri, 29 Mar 2024 10:57:50 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205D69E0D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709870; cv=none; b=DUr6fcvhqt2qDwIkgM4HFiJmi2xPfv96hcg6qRO6XWAH+94oytXM86T5AYBu756cZb4YygNx3dE56v9qDYG2k88Bhj1R/uOWSbPqTxWP0ni5qYG+DBCb5nABkjC6PO+hJ4mOLVvtmDykFyzG+BThuGesfWWhQqMFB+vVlzVGtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709870; c=relaxed/simple;
	bh=4haKc0BWmXZv48XAJVDKU0krU0tVfIaoXXWWf/W8YnQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/XXIHKXmPHphBkZ3PreHulCy5SVVprKBQ2VyJ8WrqArS7oIiOiW2zAj1fmYfYMhKEvYhwCzIDZ6rQ7SXFPB69uE6Ag2svzrNvIy/P3M60r0PZF+ZGgdO/aMqayvbu7I1rFephm3tigm2wR4lYeRi0qjXATkXtigjlm4Al9z1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 04261c89-edbb-11ee-b3cf-005056bd6ce9;
	Fri, 29 Mar 2024 12:56:38 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] pinctrl: aw9523: Destroy mutex on ->remove()
Date: Fri, 29 Mar 2024 12:55:15 +0200
Message-ID: <20240329105634.712457-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329105634.712457-1-andy.shevchenko@gmail.com>
References: <20240329105634.712457-1-andy.shevchenko@gmail.com>
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


