Return-Path: <linux-kernel+bounces-28485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97282FF20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7F51F2301C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB0B4685;
	Wed, 17 Jan 2024 03:09:19 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A612881F;
	Wed, 17 Jan 2024 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460958; cv=none; b=LwZf5NMRj5uKRQMZ8etu/JJoeEicZbCSsZ4witqIqNnbwiKR15XgN8zv5wZ1e1Y9QSm0qwsJWnp2VcBUHezeRA1nvaYGM/RJ3I1HLB4yS7l4h+HSj9BiaryTSjkUlffsIW9r092c7luOGtgYg6380U5xtI4rF8HNtqBf2hmb4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460958; c=relaxed/simple;
	bh=W3rg5FlB9tMMoDc8+Qd/Q05sRobEmsQObUmMziWSXSs=;
	h=Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:tUid:
	 X-Abuse-Reports-To:Abuse-Reports-To:X-Complaints-To:
	 X-Report-Abuse-To; b=T5V+6yugdKLOIQzjS/bQaOCWbJImT8a0ZmA6+GpRIVFa5wNTLWL5tKvfYQCtxDg7IHtcQDVnlXm3KAb/R0k0nS5X6a6iQLcEidSCLXybAAl0eugIE8IfMNrqm5UjhOBgJwXAGx3CwN5kAl9RkUwhVkekLrQY5aPRFRXPn1Pmv+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id NUA00111;
        Wed, 17 Jan 2024 11:09:11 +0800
Received: from localhost.localdomain.com (10.73.43.35) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 11:09:11 +0800
From: Bo Liu <liubo03@inspur.com>
To: <m.tretter@pengutronix.de>, <kernel@pengutronix.de>, <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] media: i2c: isl7998x: convert to use maple tree register cache
Date: Tue, 16 Jan 2024 22:09:10 -0500
Message-ID: <20240117030910.2790-1-liubo03@inspur.com>
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
tUid: 2024117110911277784f801d71b02f9ce26acf89d9765
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/media/i2c/isl7998x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/isl7998x.c b/drivers/media/i2c/isl7998x.c
index 89e13ebbce0c..c7089035bbc1 100644
--- a/drivers/media/i2c/isl7998x.c
+++ b/drivers/media/i2c/isl7998x.c
@@ -1337,7 +1337,7 @@ static const struct regmap_config isl7998x_regmap = {
 	.rd_table	= &isl7998x_readable_table,
 	.wr_table	= &isl7998x_writeable_table,
 	.volatile_table	= &isl7998x_volatile_table,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static int isl7998x_mc_init(struct isl7998x *isl7998x)
-- 
2.31.1


