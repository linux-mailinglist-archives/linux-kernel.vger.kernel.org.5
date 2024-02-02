Return-Path: <linux-kernel+bounces-49358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB4846924
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F92C1F2775E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1917C62;
	Fri,  2 Feb 2024 07:18:10 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E10317597;
	Fri,  2 Feb 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858289; cv=none; b=dZaFW+vFOw9UpS1X/fOgKDpyfOrLoz1NDNqb1vClHDAoBAzEhadgVfFVOgBuxD76gc3GT/HCZ4f9FZmimgpPYw4EeLK2HVj6FlhZeaIBP83nxmcW+HXYl7z2p3O3Cc/T3MtzcobqQ17M83YqgVzak5DyPXDtM/XTmEuOnYbSQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858289; c=relaxed/simple;
	bh=Kum7o1alLSvm1YoX3tw3PNjk3Tfex81WspETMVStbY0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KqrVNmeC59kLqAAAjDLQXcrNpdVt3HjwWOX57eevJSQkd8UabNfjjsVoysA+91OKMkPIxdsrIN1CwG4Rb4Nq3TzbocD8yW3I2mYXOVOC0pi5HLBw7+5HHt6slgaBwI+Jq6+qYE6EHQMFqu5SWSgOGASNeXLNAG4PKAeH9aZhUwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YZU00002;
        Fri, 02 Feb 2024 15:18:02 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 15:18:01 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] hwmon: (lm83) convert to use maple tree register cache
Date: Fri, 2 Feb 2024 02:18:00 -0500
Message-ID: <20240202071800.41113-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20242021518026d7035affc6b10d694d2b5c3e46fb64f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/hwmon/lm83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 5befedca6abb..b333c9bde4e6 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -165,7 +165,7 @@ static bool lm83_regmap_is_volatile(struct device *dev, unsigned int reg)
 static const struct regmap_config lm83_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = lm83_regmap_is_volatile,
 	.reg_read = lm83_regmap_reg_read,
 	.reg_write = lm83_regmap_reg_write,
-- 
2.18.2


