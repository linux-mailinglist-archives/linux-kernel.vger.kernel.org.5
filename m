Return-Path: <linux-kernel+bounces-108653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7981F880E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6841F21728
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C103985A;
	Wed, 20 Mar 2024 08:57:55 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17137747F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925075; cv=none; b=P+yuDHDbNNexXSKHYbbMTnae4sklGFEbKtKzIpa1V0flqgsO4pjx6hUm4AAnh9UEJ/oZn2lzO7IUQB/LC6t96tqBcYYIvc2L33xRpqWTBJeJJt/3HhJqELBKfkZelyBk+GSW/G4PO5tFxLeWiodJhxmE+vB4MAgYDnzFStAcyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925075; c=relaxed/simple;
	bh=hvv7cHcVQra5jm9gAhsdjQ+/tc7OHDMp6x6QbS699pg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qdw5fW/5F0Ak4B8fbov2Ez0IFRxtNSaNPDy0+T5FRUG+SaPP0X4D0Su/7MSgE8wD+MdGTF7twFZS6gTA0VUmtCH5B18B3+y8HtMhgnk0pnPKbDSYIKkrHw5d6hOLMl8eHsW0r7/ZvLRWrQC/7oaXRcX0k9M8LIqt25+VxoP0J8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id RDA00047;
        Wed, 20 Mar 2024 16:57:47 +0800
Received: from localhost.localdomain (10.94.17.92) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.35; Wed, 20 Mar 2024 16:57:48 +0800
From: Bo Liu <liubo03@inspur.com>
To: <support.opensource@diasemi.com>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jagan@amarulasolutions.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH v1 02/13] regulator: da9211: convert to use maple tree register cache
Date: Wed, 20 Mar 2024 04:57:29 -0400
Message-ID: <20240320085740.4604-3-liubo03@inspur.com>
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
tUid: 20243201657470351910969c524b14ca9b88b663cdbe8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/regulator/da9211-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index af383ff0fe57..d8b39ea3de0e 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -68,7 +68,7 @@ static const struct regmap_config da9211_regmap_config = {
 	.val_bits = 8,
 	.max_register = 5 * 128,
 	.volatile_reg = da9211_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.ranges = da9211_regmap_range,
 	.num_ranges = ARRAY_SIZE(da9211_regmap_range),
 };
-- 
2.18.2


