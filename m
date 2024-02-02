Return-Path: <linux-kernel+bounces-49354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6480284691A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E741E1F24CD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0630517995;
	Fri,  2 Feb 2024 07:16:37 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B817562;
	Fri,  2 Feb 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858196; cv=none; b=cV/y3KUQLXJYIyoFJw75QKHXAhTtENUytG2/lvqGB42lLQrkJ/Ge/8lwvhGTJAWJk/TvfPCmri/yHpkykPirUJoomstxzc2zqig835s3DdpvokMnr2BE5tsiOCvFulMaLWZIIdzLliSSjBjlk0UPMS45xY/7+vRxB7JsMxDJuz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858196; c=relaxed/simple;
	bh=aAeYcxLLnb/t/SYbhPaewpAiyt6DK70tqwjVhH1Yw48=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SwUetPlJGZSg3vWygkJTFC/1Vh98jSbywWhK7Z8HVkUkTbyC5KdUpb+rtmD+eZfiFgr27z1SU7SrJ+08rsR9rZ1wapfaIXwt5gJYHAE8KbOt3OKUBi6eIIBHau9z+4d7B1rjH7Qqy41qnvvgwGQXjT/Ib4PGKtjGscJ2n4J0Jgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YZS00130;
        Fri, 02 Feb 2024 15:16:30 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 15:16:29 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] hwmon: (jc42) convert to use maple tree register cache
Date: Fri, 2 Feb 2024 02:16:28 -0500
Message-ID: <20240202071628.40990-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024202151630d81a363d5406a5b7d5d9639f532e3f43
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/hwmon/jc42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index f958e830b23c..75dc25df0f8b 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -497,7 +497,7 @@ static const struct regmap_config jc42_regmap_config = {
 	.writeable_reg = jc42_writable_reg,
 	.readable_reg = jc42_readable_reg,
 	.volatile_reg = jc42_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int jc42_probe(struct i2c_client *client)
-- 
2.18.2


