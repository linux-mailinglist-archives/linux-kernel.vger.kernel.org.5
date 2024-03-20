Return-Path: <linux-kernel+bounces-108657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09279880E17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C265285A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1713C478;
	Wed, 20 Mar 2024 08:57:57 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D638394
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925077; cv=none; b=dvtIeUZ8cOzgdlYlQ5hvoDrANnAl89KyryKLlxlkElEqz4lGYlQ9bty3u14jhT1c7koTrhOhjUjW02Zrn4l8dQO46BMeWiulz7PCq6lxmBYW30mSW2D9gyuP+fsau+X4qFWYa2kHx3IMaksNtYPHiSLbRjJbWZyzTyEU7SSgwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925077; c=relaxed/simple;
	bh=SewUkeTXkgIRKg0uYxnU2gaFiMRuA0y29c1F58Men+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qww0Z6ZiOUR1bvbhO14S9lE+aHbiOiTlEXG3kkG/4KxZTqa8tn4EO/7NLv2X72lT9cUgPoZjpYzQEzcd2qNFoGT6FXziU2eryQ6cGBxQbVuxXvjUYLhtLWpIApgN+w/n+ta7tu/bPl9OmcmJG/Y624z2QH/05KmxWMNbYfdY+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id RDA00050;
        Wed, 20 Mar 2024 16:57:50 +0800
Received: from localhost.localdomain (10.94.17.92) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.35; Wed, 20 Mar 2024 16:57:51 +0800
From: Bo Liu <liubo03@inspur.com>
To: <support.opensource@diasemi.com>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jagan@amarulasolutions.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH v1 05/13] regulator: mt6311: convert to use maple tree register cache
Date: Wed, 20 Mar 2024 04:57:32 -0400
Message-ID: <20240320085740.4604-6-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20240320085740.4604-1-liubo03@inspur.com>
References: <20240320085740.4604-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024320165750ed5486ec9672c0407245c005de12d5a1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/regulator/mt6311-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index 63a51485f2cc..c00638cd2d1e 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -20,7 +20,7 @@ static const struct regmap_config mt6311_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = MT6311_FQMTR_CON4,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /* Default limits measured in millivolts and milliamps */
-- 
2.18.2


