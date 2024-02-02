Return-Path: <linux-kernel+bounces-49359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765DC846926
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E871C23047
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0417999;
	Fri,  2 Feb 2024 07:20:17 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29354C60;
	Fri,  2 Feb 2024 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858417; cv=none; b=rOPrVBJ88E7CLt54oAJg9aoSepgKLJJS5PtgqBpZZDcX36mYI7INyZ5ndtR2VaHdpR4dBk5THUCqDeIWVmzAYk7vsfWbXvDYajMyVdsXqFpH7HOe0F07lq+E1renCUPSU47/NcnyyV6BQSuDSi0y1LlbZJOiPJSD8RwFxTfnN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858417; c=relaxed/simple;
	bh=b5/YX2L+A41gJRV3oTdRuM+uovTXznd+6lM2Bfht5iU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1d4T87FnFk2VtgUYSYz0SbjMEqQhmVLdeByTGzFdattlvDMUuOFLu+YNUaGwPMhRqDATD+dFgslPzi+CFGBUHBgEQhAUQbhQ6BAYcxX9XO0ftRfV0rEvZOtFk20hVrXufnj3ErkoBfmUX5hwvG94L2ZFKXu0mmDXFvyF6hxM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id YZW00009;
        Fri, 02 Feb 2024 15:20:09 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 15:20:08 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] hwmon: (nct7802) convert to use maple tree register cache
Date: Fri, 2 Feb 2024 02:20:07 -0500
Message-ID: <20240202072007.41316-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 202420215200950bfaae5d74554043fb46bf5d002abaa
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/hwmon/nct7802.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 024cff151c36..a0e664d5ebfe 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -1051,7 +1051,7 @@ static bool nct7802_regmap_is_volatile(struct device *dev, unsigned int reg)
 static const struct regmap_config nct7802_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = nct7802_regmap_is_volatile,
 };
 
-- 
2.18.2


