Return-Path: <linux-kernel+bounces-28486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B19C82FF23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE3B289116
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8B4687;
	Wed, 17 Jan 2024 03:11:15 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5C1C05;
	Wed, 17 Jan 2024 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461074; cv=none; b=S6+tqUenhK3CZzNQJtQkA1h0t12xEibHkLgM3IPnd9zfMIArpqApq9YrfxlIvg+vekOO4x75kSjwAu3JXKOwtT++RwO0bG2DiQvYVHM0y416gKATwF6d2fbGeRTdJedxujlqOpZe1PR9+vGezabLDaG8r0zWnungIsZ65S3t+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461074; c=relaxed/simple;
	bh=nh2lhXlBjGkKVlhpGjA1fsfZKqu0JF42Z8AmKr3Wjrw=;
	h=Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:tUid:
	 X-Abuse-Reports-To:Abuse-Reports-To:X-Complaints-To:
	 X-Report-Abuse-To; b=Uwj8hMU08kuLWv+1IWZJqmgASz0kMUfx2yWAT+sHs/s5tWXimA7FSy/hhM0mBkCTCuC0CXUqepfdePXqKBsbVD8UAg9OVoK+fWkVPTlu1L+kD4UD/cnHEFXm/aLh+KZhO01VpaDPpNm6uJaLJnrBUMp7AL+IkQMT0sxRt6Er7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id NUC00007;
        Wed, 17 Jan 2024 11:11:07 +0800
Received: from localhost.localdomain.com (10.73.43.35) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 11:11:06 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sakari.ailus@linux.intel.com>, <laurent.pinchart@ideasonboard.com>,
	<mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] media: i2c: mt9v032: convert to use maple tree register cache
Date: Tue, 16 Jan 2024 22:11:05 -0500
Message-ID: <20240117031105.3054-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201621.home.langchao.com (10.100.2.21)
tUid: 20241171111073ec408c72695cd09dedf78ca275dff02
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/media/i2c/mt9v032.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/mt9v032.c b/drivers/media/i2c/mt9v032.c
index 3ca76eeae7ff..6dfbd1c56c22 100644
--- a/drivers/media/i2c/mt9v032.c
+++ b/drivers/media/i2c/mt9v032.c
@@ -988,7 +988,7 @@ static const struct regmap_config mt9v032_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = 0xff,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /* -----------------------------------------------------------------------------
-- 
2.31.1


