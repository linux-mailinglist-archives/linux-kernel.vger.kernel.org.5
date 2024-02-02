Return-Path: <linux-kernel+bounces-49353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F022846918
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6091C24EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E0D17994;
	Fri,  2 Feb 2024 07:15:48 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2017752;
	Fri,  2 Feb 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858147; cv=none; b=p3U+Cacxk67L3bIPLY8Go94X0j2zvkEywiH0UNpcx6XEYzQU7ejlLyk3y+stBqgLdklZeVnKUCcc/0V9BoFDXK2D3QV0Hup2kt7l7KwyYOupFw3Zt8beS4bsxz6ItUhHBBUPIyxuSq7THXvMXn9UQvInyxHvRnDU1Kw48zM2NIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858147; c=relaxed/simple;
	bh=fKambqWpxwdiPvXhtSzQ2mMIOb+h/ldO9aCfGiZlTeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FAwsZf+L1UP+O0AivLbZCKeFRLfN2MVf8qIK+FHVc0W6gN0lC8uzbZjj0ZRXnNPVyqVHKvoifyWrFlbxOy/MCSQx2SA4bA/OerMxuxX8Sp/PSrfqkM2FHaoDqHkjXjM+eK0/HfpHAhVWXviOmXWpVNpDEWW8HMcPBg1xM6cMxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YZR00041;
        Fri, 02 Feb 2024 15:15:41 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 15:15:40 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] hwmon: (ina3221) convert to use maple tree register cache
Date: Fri, 2 Feb 2024 02:15:38 -0500
Message-ID: <20240202071538.40877-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024202151541b65c4775ebc1dddca9d3daab5f9177f3
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/hwmon/ina3221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 5ffdc94db436..2c9530b6f192 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -762,7 +762,7 @@ static const struct regmap_config ina3221_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_table = &ina3221_volatile_table,
 };
 
-- 
2.18.2


