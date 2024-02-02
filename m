Return-Path: <linux-kernel+bounces-49363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED7846931
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77751F22C71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37807179A6;
	Fri,  2 Feb 2024 07:22:45 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8617998;
	Fri,  2 Feb 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858564; cv=none; b=eTAHO8pIpXoOvaHkfI9LrIHf1QF+gi45eYJ3DGHpfYEcmyDWUR1jFm2r5+nfUDdEfeh23cvchSm4szJVOjAXVEPbhn6g3LJeB+owqci/rKL92y1qsiuf6Pi1UjGoo7G7fV43VAeX/hFb4vzWUxUstbfBfNexfzuIFkRhp10CMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858564; c=relaxed/simple;
	bh=VoQqbRu16rEJ8qlra3eB+muBUWplkAHGaTdPZMDU8RA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/Cwvd8nHtf/eK2sKhLmLCftGQmLeZlEzSHzWZlJFAc3Ryiqo1vjuMi00QBN2iESTBHno3nHXAVjDxWkdAWrr3HMgoJIdNxVvkiwPzJWzkLQJ6YVnE+vDwF9ioAbfayBqbHP3koMP11oOFFDNHCXb8nolYCjeeHo+VQHNkq96xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id YZY00137;
        Fri, 02 Feb 2024 15:22:37 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 15:22:36 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] hwmon: (tmp401) convert to use maple tree register cache
Date: Fri, 2 Feb 2024 02:22:35 -0500
Message-ID: <20240202072235.41614-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20242021522379caa3bd455eee71f31d339256167edeb
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/hwmon/tmp401.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index 91f2314568cf..df1b45a62e80 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -256,7 +256,7 @@ static int tmp401_reg_write(void *context, unsigned int reg, unsigned int val)
 static const struct regmap_config tmp401_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = tmp401_regmap_is_volatile,
 	.reg_read = tmp401_reg_read,
 	.reg_write = tmp401_reg_write,
-- 
2.18.2


