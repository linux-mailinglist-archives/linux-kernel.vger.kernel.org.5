Return-Path: <linux-kernel+bounces-49352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282B5846916
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5F21C25A29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89C1775F;
	Fri,  2 Feb 2024 07:15:00 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1317BA1;
	Fri,  2 Feb 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858100; cv=none; b=HWIvV65wyamiBwMyE1zcv87auF9b5lG+1AN+EVxxkq5UgayteW8oo2whOQDIcx7db+5wwxUJSZy9TobQgmWPQOyB2Yl2h6g3vLwuSgPonNqh42B3JA0984yCYnoxajeHSm92mJdHoNIXaTuyO3k0Q2yTtLoHcgV7akPPvrSEc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858100; c=relaxed/simple;
	bh=6jB33lPwZhwrcu4My0/XvWpya2EXxkDHxttSjCdsHaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tb9pvoY/J7TrpbSoqWPXBnEU5MqKiOv232q+ouWq2sbAtNCvnr7sZxTLySFzfYRoJeyb2ihgBZHHk3V2BoLfm9R0ondWm5K9ckqdrCYS9G7MNEx8u/LPe/83iHhW5Iv1PGaVJRpEnzyos8kb/yeQ7j+F1NTF3bxIEdeosyYK2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YZQ00154;
        Fri, 02 Feb 2024 15:14:54 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 15:14:53 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] hwmon: (emc1403) convert to use maple tree register cache
Date: Fri, 2 Feb 2024 02:14:52 -0500
Message-ID: <20240202071452.40778-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024202151454b2fc73ba65bf636c683318eb1d2fb29d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/hwmon/emc1403.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 1332e4ac078c..d370efd6f986 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -385,7 +385,7 @@ static bool emc1403_regmap_is_volatile(struct device *dev, unsigned int reg)
 static const struct regmap_config emc1403_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = emc1403_regmap_is_volatile,
 };
 
-- 
2.18.2


