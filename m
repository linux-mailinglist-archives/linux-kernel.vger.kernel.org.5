Return-Path: <linux-kernel+bounces-54397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3601B84AEBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86F51F23C28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D468B12BE88;
	Tue,  6 Feb 2024 07:13:48 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E612AAEA;
	Tue,  6 Feb 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203628; cv=none; b=jcrHnlIPWYBb6jm9q0N84EBayjDt7t52pWYtXKQyq3X+7Y5RNxZ94QLQSeIIa3rqzec6RyrGddTkkvSCGbQKKj4oLvUyQ64Fl6kYl/qJJ72JNpOaIU4xJfKdF55dFFimxVswQVjr0PvnDMZWfhLFwAPW9k0v4bsQKk7UG9to0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203628; c=relaxed/simple;
	bh=qB5GzC3zkschhLT3slzOBrMhudQ+aeb62nRO5srixYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aD6BFc00pA9P/R5JXOGe/UPT9ZfAlT6f/yC87Z3ZrmXC+ySwkdyT/qmtxOJRI7xEE+EDkW1OnT7MJzOcniJxrwop18HdK55Pv4R42mOw9gnJRor3fscq9ZS7+g4QNVovw0tNPQYbfjvjFQJjXWtJZQqm/EU5V+YgfYeGdfepFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CZT00041;
        Tue, 06 Feb 2024 15:13:41 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.34; Tue, 6 Feb 2024 15:13:42 +0800
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
Subject: [PATCH 10/18] mfd: wolfson: convert to use maple tree register cache
Date: Tue, 6 Feb 2024 02:13:06 -0500
Message-ID: <20240206071314.8721-11-liubo03@inspur.com>
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
tUid: 20242061513412c33292c74460fb4cc83da7df0762be9
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/mfd/wm5102-tables.c | 2 +-
 drivers/mfd/wm5110-tables.c | 2 +-
 drivers/mfd/wm8350-regmap.c | 2 +-
 drivers/mfd/wm8400-core.c   | 2 +-
 drivers/mfd/wm97xx-core.c   | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/wm5102-tables.c b/drivers/mfd/wm5102-tables.c
index f77ecc635b6f..6a8602c1c4ee 100644
--- a/drivers/mfd/wm5102-tables.c
+++ b/drivers/mfd/wm5102-tables.c
@@ -1922,7 +1922,7 @@ const struct regmap_config wm5102_spi_regmap = {
 	.readable_reg = wm5102_readable_register,
 	.volatile_reg = wm5102_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = wm5102_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(wm5102_reg_default),
 };
diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index eba324875afd..6ff33a54a068 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -3202,7 +3202,7 @@ const struct regmap_config wm5110_spi_regmap = {
 	.readable_reg = wm5110_readable_register,
 	.volatile_reg = wm5110_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = wm5110_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(wm5110_reg_default),
 };
diff --git a/drivers/mfd/wm8350-regmap.c b/drivers/mfd/wm8350-regmap.c
index 5663b8b0b3ad..3d0ebb004dbf 100644
--- a/drivers/mfd/wm8350-regmap.c
+++ b/drivers/mfd/wm8350-regmap.c
@@ -325,7 +325,7 @@ const struct regmap_config wm8350_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.max_register = WM8350_MAX_REGISTER,
 	.readable_reg = wm8350_readable,
diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 75483c9be0c4..ddfb234849dd 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -100,7 +100,7 @@ static const struct regmap_config wm8400_regmap_config = {
 
 	.volatile_reg = wm8400_volatile,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /**
diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
index 663acbb1854c..1566a9b04b6a 100644
--- a/drivers/mfd/wm97xx-core.c
+++ b/drivers/mfd/wm97xx-core.c
@@ -95,7 +95,7 @@ static const struct regmap_config wm9705_regmap_config = {
 	.reg_stride = 2,
 	.val_bits = 16,
 	.max_register = 0x7e,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.reg_defaults = wm9705_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm9705_reg_defaults),
@@ -163,7 +163,7 @@ static const struct regmap_config wm9712_regmap_config = {
 	.reg_stride = 2,
 	.val_bits = 16,
 	.max_register = 0x7e,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.reg_defaults = wm9712_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm9712_reg_defaults),
@@ -234,7 +234,7 @@ static const struct regmap_config wm9713_regmap_config = {
 	.reg_stride = 2,
 	.val_bits = 16,
 	.max_register = 0x7e,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.reg_defaults = wm9713_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm9713_reg_defaults),
-- 
2.18.2


