Return-Path: <linux-kernel+bounces-54399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F584AEC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA951C2306F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E2812AAF8;
	Tue,  6 Feb 2024 07:13:51 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468112BEA0;
	Tue,  6 Feb 2024 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203631; cv=none; b=a9YFN5sqpQr/TmSWDQLkSecxjcOvXlrlV1sPn9Q886DlRFB5K49CWdj7GQv6pQtSyfnKZgKw7QRvrXGLXHUnAEvYqMhS7ReU2G/seF8jIag7PGwDLyscKhvaVDoO13zEg+akTPKjRmCwuB32kYBqiaOJEyi/EUDbWR+TyJy+TWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203631; c=relaxed/simple;
	bh=QpJ7YkU2g9iHCXuzjsqQvlUek4FOFOhMQ9iS3IfyCsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQK+w44KDunkvvq4KmS5AnJYeBJSU9xzeMMT7Ys5qlWXOFfoI6AKMOeblDKIjTPeW/TROUzBEL0o3IBwWFtkh+iRF60WIXGEwjNMEcVvG9EF/KhWA5VbGuZChhIgj/1p5BZeTDkbhH86Ts5Fv0YKSAwtWSUJ0q6ms9PI2+YcSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CZT00043;
        Tue, 06 Feb 2024 15:13:43 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.34; Tue, 6 Feb 2024 15:13:43 +0800
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
Subject: [PATCH 11/18] mfd: rohm: convert to use maple tree register cache
Date: Tue, 6 Feb 2024 02:13:07 -0500
Message-ID: <20240206071314.8721-12-liubo03@inspur.com>
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
tUid: 20242061513430f5b0a1bdcc148beebfea2a7bea359c1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/mfd/rohm-bd71828.c | 4 ++--
 drivers/mfd/rohm-bd718x7.c | 2 +-
 drivers/mfd/rohm-bd9576.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 594718f7e8e1..2f3826c7eef4 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -197,7 +197,7 @@ static const struct regmap_config bd71815_regmap = {
 	.val_bits = 8,
 	.volatile_table = &bd71815_volatile_regs,
 	.max_register = BD71815_MAX_REGISTER - 1,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct regmap_config bd71828_regmap = {
@@ -205,7 +205,7 @@ static const struct regmap_config bd71828_regmap = {
 	.val_bits = 8,
 	.volatile_table = &bd71828_volatile_regs,
 	.max_register = BD71828_MAX_REGISTER,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /*
diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index 4798bdf27afb..7755a4c073bf 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -87,7 +87,7 @@ static const struct regmap_config bd718xx_regmap_config = {
 	.val_bits = 8,
 	.volatile_table = &volatile_regs,
 	.max_register = BD718XX_MAX_REGISTER - 1,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int bd718xx_init_press_duration(struct regmap *regmap,
diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index bceac7016740..3a9f61961721 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -62,7 +62,7 @@ static struct regmap_config bd957x_regmap = {
 	.val_bits = 8,
 	.volatile_table = &volatile_regs,
 	.max_register = BD957X_MAX_REGISTER,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static struct regmap_irq bd9576_irqs[] = {
-- 
2.18.2


