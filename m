Return-Path: <linux-kernel+bounces-28488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE6B82FF27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8011C23D90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3179CC;
	Wed, 17 Jan 2024 03:11:44 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637253B4;
	Wed, 17 Jan 2024 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461104; cv=none; b=BWruCSFps7u51fbkKW9/T8KoSmuPUzQrsbQW41+OfPcsKWz3ZP6g82Si5++S6C99LLr/+iXRpz281xZX2gLVnCdE8BIlh/7XOp8RiJ3v275KsIQUYXSa7mi5gRUg3mUnyR144cmgmh4qs4UxQ8HvpKqjDMe87AYHvu+JxZ7IGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461104; c=relaxed/simple;
	bh=aUVNiTyTZPgZDwBmBhGhfv+KH4i/doocCmIOP0Gw9zs=;
	h=Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:tUid:
	 X-Abuse-Reports-To:Abuse-Reports-To:X-Complaints-To:
	 X-Report-Abuse-To; b=JuU7zUpyoPnCb5l9bQk6vVEn9ITrFZL9LIx+15f+EdvRbyyuLdFzoaQB0rtosMMfPubvIxGyIAD+NFPrB1B+8bK6rPsHwHi3Uju1hwkP3vtSc8LXNTnil0fQb+TzquUcM4vdSHQFuwquYYD5ztRwMFz/zaw//pODNxukA1wrO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id NUC00037;
        Wed, 17 Jan 2024 11:11:37 +0800
Received: from localhost.localdomain.com (10.73.43.35) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 11:11:36 +0800
From: Bo Liu <liubo03@inspur.com>
To: <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] media: i2c: tvp5150: convert to use maple tree register cache
Date: Tue, 16 Jan 2024 22:11:34 -0500
Message-ID: <20240117031134.3106-1-liubo03@inspur.com>
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
tUid: 20241171111372cc224f991c14bae0232f01debbcf7c5
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/media/i2c/tvp5150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 9fc586cfdcd8..64b91aa3c82a 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -1817,7 +1817,7 @@ static struct regmap_config tvp5150_config = {
 	.val_bits = 8,
 	.max_register = 0xff,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.rd_table = &tvp5150_readable_table,
 	.volatile_reg = tvp5150_volatile_reg,
-- 
2.31.1


