Return-Path: <linux-kernel+bounces-28487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9082FF24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2EA289B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732704685;
	Wed, 17 Jan 2024 03:11:41 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0C747C;
	Wed, 17 Jan 2024 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461101; cv=none; b=NPVWUrRNoylS70chrpI0DUXLj5Es1XOvGToDCIdIAYqq3HHp+m6B9o9OoFrgsaRF9U0qX4GNuLHMiMc5jIaJUTPpPEOfEjsh2R1F2XkE3U0OpOg5oxagSO7qUTkHBLXpWz1E9Wemp3TFh0ZO9KCVGNbth0NtSWfxnO4Km3cH6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461101; c=relaxed/simple;
	bh=KYELrHu36Kr3uhJTZi6rvw5/PDiJvzYP7hohk15E04A=;
	h=Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:tUid:
	 X-Abuse-Reports-To:Abuse-Reports-To:X-Complaints-To:
	 X-Report-Abuse-To; b=r2DnI/3dld4/co+wvenY/gP29ZfysmxEcMd16TsDjgfq8ttKFpuqcSIXsYN75ujKnehMPQ4YP3/MFzd2D7JVUS6TLNpCUc7mDXtJK/mgJsCd7V3PL5rWDx6REXsZbK/GEhbdnORyK7FbBGlA4pb9YpXBd+Pj7DbAPhLtnuyHVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id NUB00026;
        Wed, 17 Jan 2024 11:10:26 +0800
Received: from localhost.localdomain.com (10.73.43.35) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 11:10:26 +0800
From: Bo Liu <liubo03@inspur.com>
To: <rashanmu@gmail.com>, <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] media: i2c: max2175: convert to use maple tree register cache
Date: Tue, 16 Jan 2024 22:10:24 -0500
Message-ID: <20240117031024.2994-1-liubo03@inspur.com>
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
tUid: 202411711102684143add0769ff9c5abf4e633a90e0ac
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/media/i2c/max2175.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/max2175.c b/drivers/media/i2c/max2175.c
index 70c2a2948fd4..cd73d2096ae4 100644
--- a/drivers/media/i2c/max2175.c
+++ b/drivers/media/i2c/max2175.c
@@ -257,7 +257,7 @@ static const struct regmap_config max2175_regmap_config = {
 	.reg_defaults = max2175_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(max2175_reg_defaults),
 	.volatile_table = &max2175_volatile_regs,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 struct max2175 {
-- 
2.31.1


