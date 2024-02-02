Return-Path: <linux-kernel+bounces-49351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA60D846914
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619731F27468
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584521775F;
	Fri,  2 Feb 2024 07:14:18 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515018021;
	Fri,  2 Feb 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858057; cv=none; b=gPi7wrUQn221RsfDjGlE+5LN2rvcdlvwh9pGQ+XMR2q3Gro0GCvL24bIw+I3ckh8O0nVd/uKw0gwPg2wf6lyCj87z3W4gD93wn/4eVZ5qKxz6RYxHScTFJLjoANVAFHmI254KHhFg1Z0h6mSxB1iCy5lp+Qn9E0rJ5i8tLCba9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858057; c=relaxed/simple;
	bh=uaMC5DdvRw4UG3agCRC/d9ndStoUMBwWCSOYLgyxsvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dc3u+YwJwJWKfLzLt1oJZ5sxG3UbAsn1Rwc4ptEbMFgDsfJP0IyjDV3elnDpBYkaZuVZ2o79JAqPOEThoV5+WCGhwEhkILqpgIGsRlHm8OwhT+bO1OzngUvd14wHBcGvYRsIqkrWQzcWX0aXWwpyW/V0dgOYWuAa/v9bgGxsWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YZQ00012;
        Fri, 02 Feb 2024 15:14:12 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 15:14:11 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] hwmon: (adt7x10) convert to use maple tree register cache
Date: Fri, 2 Feb 2024 02:13:55 -0500
Message-ID: <20240202071355.40666-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024202151412078439a468ebc70c40b5bd3f283a6154
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/hwmon/adt7310.c | 2 +-
 drivers/hwmon/adt7410.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
index 067865f4887a..25281739aa3b 100644
--- a/drivers/hwmon/adt7310.c
+++ b/drivers/hwmon/adt7310.c
@@ -124,7 +124,7 @@ static int adt7310_reg_write(void *context, unsigned int reg, unsigned int val)
 static const struct regmap_config adt7310_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = adt7310_regmap_is_volatile,
 	.reg_read = adt7310_reg_read,
 	.reg_write = adt7310_reg_write,
diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index fd214d9b3a89..d15f64d4b6e7 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -69,7 +69,7 @@ static const struct regmap_config adt7410_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = ADT7X10_ID,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = adt7410_regmap_is_volatile,
 	.reg_read = adt7410_reg_read,
 	.reg_write = adt7410_reg_write,
-- 
2.18.2


