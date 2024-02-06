Return-Path: <linux-kernel+bounces-54391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D584AEAD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525CF281AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9391292DD;
	Tue,  6 Feb 2024 07:13:43 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFA12880D;
	Tue,  6 Feb 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203623; cv=none; b=VPZSq4EeJ1Lpn5FvP6QqHkJ0oqNlohE8sjz5gfzte3VwvuQFNudow8S0dPp0lcqL84+lsvkrGET0WFg0u2EriBwsNnkFoaTcgAbe3kunvG4WoKFA3Z2pK0qvBZsFhxPtR2IWwN6wKrFPKD+5ElXcRvrqWFEmjLZBJxpPAXLZuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203623; c=relaxed/simple;
	bh=iQJdkPR8SAvx/jGjx9Gz/bscBOmOuhsP8uWNTMe8BVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2jefs+PORIU3s1iy9l0mI3Hf/JHz0FWQHNLxFMD+29hqtgQ3bWhIcyWj+a0WX10YFHbKlAu6AAMpiPq67hOxmZ134Xn4ZQqAa57UrO5ZcHMpNIY0OkabjvuxnhedOpGQjoP/8U1TcLOgHke2y7qbVdpQCw9OpbuJYsnzzby750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CZT00036;
        Tue, 06 Feb 2024 15:13:36 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.34; Tue, 6 Feb 2024 15:13:36 +0800
From: Bo Liu <liubo03@inspur.com>
To: <lee@kernel.org>, <wens@csie.org>, <marek.vasut+renesas@gmail.com>,
	<support.opensource@diasemi.com>, <neil.armstrong@linaro.org>,
	<ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
	<mazziesaccount@gmail.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <patches@opensource.cirrus.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH 05/18] mfd: bcm590xx: convert to use maple tree register cache
Date: Tue, 6 Feb 2024 02:13:01 -0500
Message-ID: <20240206071314.8721-6-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20240206071314.8721-1-liubo03@inspur.com>
References: <20240206071314.8721-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024206151336ec2d835c1ca5d9c2e9f058ff5cffbd80
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/mfd/bcm590xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 92eede9a5e61..8b56786d85d0 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -27,14 +27,14 @@ static const struct regmap_config bcm590xx_regmap_config_pri = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
 	.max_register	= BCM590XX_MAX_REGISTER_PRI,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static const struct regmap_config bcm590xx_regmap_config_sec = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
 	.max_register	= BCM590XX_MAX_REGISTER_SEC,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
-- 
2.18.2


