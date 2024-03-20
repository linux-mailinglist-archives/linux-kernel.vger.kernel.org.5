Return-Path: <linux-kernel+bounces-108666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9D880E28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5072A1C22EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0747F72;
	Wed, 20 Mar 2024 08:58:08 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFEB44C92
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925088; cv=none; b=FROuzJCm4hqyeVaozsSEtUE7Cw8rKTPBv+ZQl1ZeFIJN2f8sf9SkPVAnW3CKLPFuOCjQhnPNVfGAOr/JGfCH8AythFk/sbpGDF8cfrmO6n3xlVTAex4/pMyxnMi39YIj5zqNAwLI7JRlcsoOeerAYqIJ4k/LytG3GNHZrnqfY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925088; c=relaxed/simple;
	bh=po8nGs/QX+OygQoV6swHooAskwzfSgOE/HJMqFrbV/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbramVMudQN6OHO2X2k0j2HzXjNQgYAlqpqCjYPn6wW4o/8Nyea4S/9maimjqaI49ZKphypzSZmqCwdf9qGXz548qGyYckGM1yjuO1CCppYJlcAK6/WLVlz++sXXozPV8BS9vCp6Bc9H5ArbRgK11pPhQboT4bEOiEWpK9wHOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id RDB00100;
        Wed, 20 Mar 2024 16:58:00 +0800
Received: from localhost.localdomain (10.94.17.92) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.35; Wed, 20 Mar 2024 16:58:00 +0800
From: Bo Liu <liubo03@inspur.com>
To: <support.opensource@diasemi.com>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jagan@amarulasolutions.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH v1 13/13] regulator: rpi-panel-attiny: convert to use maple tree register cache
Date: Wed, 20 Mar 2024 04:57:40 -0400
Message-ID: <20240320085740.4604-14-liubo03@inspur.com>
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
tUid: 20243201658003ea40bb9b9dfda1388c23940ac561bf7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index f52c3d47ecea..6c3b6bfac961 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -75,7 +75,7 @@ static const struct regmap_config attiny_regmap_config = {
 	.val_bits = 8,
 	.disable_locking = 1,
 	.max_register = REG_WRITE_DATA_L,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int attiny_set_port_state(struct attiny_lcd *state, int reg, u8 val)
-- 
2.18.2


