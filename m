Return-Path: <linux-kernel+bounces-49361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0684692B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A78B1F27758
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4303217BDD;
	Fri,  2 Feb 2024 07:20:48 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E417984;
	Fri,  2 Feb 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858447; cv=none; b=o0TqZaHZJQobTZfbKO05pvUWIO9X+NHe/1j4Fo1lFnGWhuHHgjIFZJMD3fRbKH9dYELgI3RkAIolVDfTasoizsHO1u1NkZLwKX9TIrfA306JecNyenV615C1kE9p9lUQ3upDfdPZgLcgLk94W1WUKXQ7uobC4tL44JAHshXRG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858447; c=relaxed/simple;
	bh=5N6m21E8pl1uoSMhFNAvPRQOtFLBWQGHSScbL/gMau4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DqY5d1X+gfMN2lEYdFOkK95TpEFizzPR27+aFeVE8MN9HKxW2FSmdGDJy/IWV40OO2iXOiZsz2+Sl9cP1piQ6YMsDQZzjMu4O4jcKRsThf8xhoUZnWRvyq89uboTFauPlPAxgppICzkclf0t7DE9YxGMevkvnF0WYSodYSP9uMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id YZW00141;
        Fri, 02 Feb 2024 15:20:41 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 15:20:40 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] hwmon: (sch5627) convert to use maple tree register cache
Date: Fri, 2 Feb 2024 02:20:39 -0500
Message-ID: <20240202072039.41419-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20242021520412869875d4905c8a298351518245b46df
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/hwmon/sch5627.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 1891d4d75aa9..33e997b5c1f5 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -116,7 +116,7 @@ static const struct regmap_config sch5627_regmap_config = {
 	.val_bits = 8,
 	.wr_table = &sch5627_tunables_table,
 	.rd_table = &sch5627_tunables_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 	.can_sleep = true,
-- 
2.18.2


