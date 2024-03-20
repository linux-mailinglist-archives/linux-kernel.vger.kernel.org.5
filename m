Return-Path: <linux-kernel+bounces-108655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577E880E12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CBB284E62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7639AC7;
	Wed, 20 Mar 2024 08:57:55 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717011720
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925075; cv=none; b=HwYJ84vWtWAS3dQKY3gO7nRKRBB06atBsAX2+0ZErWVFk244EI7gj2ovznedzfj5iJjSwGYg73Pxs8k1HJweewlSdVEY+oAHnz+lm+KJm+sxjntGzuOrXqI28Uy0aIU/dznrKoYnsPVTcBjQ2TjQDY62IJqBWeQEytck9l+6oIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925075; c=relaxed/simple;
	bh=sBiif9fhAGNCI/yrck7qHK13G0zJ4qN2nbe0aD9vhsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brqU/v8Mgrf7uYWFwEYoxGkLE/8T4V6Rs8ihXY/ZRXL8Ka5UFX6v8pDE5MQTEM7jhsC5iz2l0mCROTIhzYd1x5dUP3T2b1qD74wNdbGliT2yW4qCu8RjaBnUT4271cYskxFYVlKnIsU8oPNMtD21CGOFkZFGFVAoICOEvYb81a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id RDA00046;
        Wed, 20 Mar 2024 16:57:46 +0800
Received: from localhost.localdomain (10.94.17.92) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.35; Wed, 20 Mar 2024 16:57:46 +0800
From: Bo Liu <liubo03@inspur.com>
To: <support.opensource@diasemi.com>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jagan@amarulasolutions.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH v1 01/13] regulator: da9121: convert to use maple tree register cache
Date: Wed, 20 Mar 2024 04:57:28 -0400
Message-ID: <20240320085740.4604-2-liubo03@inspur.com>
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
tUid: 2024320165746aad7dc223c642e3cd2cb0c306415dbf7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/regulator/da9121-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 5ee76b533576..96257551bb12 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -872,7 +872,7 @@ static struct regmap_config da9121_1ch_regmap_config = {
 	.rd_table = &da9121_1ch_readable_table,
 	.wr_table = &da9121_1ch_writeable_table,
 	.volatile_table = &da9121_volatile_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /* DA9121 regmap config for 2 channel variants */
@@ -883,7 +883,7 @@ static struct regmap_config da9121_2ch_regmap_config = {
 	.rd_table = &da9121_2ch_readable_table,
 	.wr_table = &da9121_2ch_writeable_table,
 	.volatile_table = &da9121_volatile_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
-- 
2.18.2


