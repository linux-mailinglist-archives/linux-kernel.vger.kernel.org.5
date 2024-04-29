Return-Path: <linux-kernel+bounces-161688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AD58B4F82
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DDD1C20B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAFB8BE5;
	Mon, 29 Apr 2024 02:47:15 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E6C2C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714358835; cv=none; b=djZrZEzKUwPA5vlbDuobOiifilVTorCwQH48YCvdRKHXuayqoJBpmP19on0vsQl/sEpJUwulYs6jpxcCmubjT58rmHKUj2oC2V9CCHggMmj8jEtKlkDLYwDZRo8LOyMqZDl0mfgjMm3ArjLK31BN/Pz9CtRM/s+Y1Wopp+f4c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714358835; c=relaxed/simple;
	bh=thbFZ8yBL5OGWizoHOgdZS/5jmT8HQSpOscTQ3lncZg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I8V3ksUZygy6uKPx83j1KzRjpFjcm799aqvq4dS45OUrFwMm0jZ+7bF6f4NnqYcpKicglZKbdbhjFTKMiH8HcnRHgTT+Y6NxQ0wLPBtY2MopPyyweCBnkwYGYJUs1MW7UxVqC1Y8QDVDTOGzL7l6dqdrW5nbqUMhPIIFgj11QCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id ZWW00155;
        Mon, 29 Apr 2024 10:45:55 +0800
Received: from localhost.localdomain (10.94.16.97) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 10:45:55 +0800
From: wangkaiyuan <wangkaiyuan@inspur.com>
To: <lee@kernel.org>, <wens@csie.org>
CC: <linux-kernel@vger.kernel.org>, wangkaiyuan <wangkaiyuan@inspur.com>
Subject: [PATCH] mfd: axp20x: convert to use maple tree register cache
Date: Mon, 29 Apr 2024 10:45:47 +0800
Message-ID: <20240429024547.27724-1-wangkaiyuan@inspur.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201617.home.langchao.com (10.100.2.17) To
 jtjnmail201621.home.langchao.com (10.100.2.21)
tUid: 2024429104555997ce63c2bf7eb3d89a2e7640832a09c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 48ce6ea693ce..f2c0f144c0fc 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -422,7 +422,7 @@ static const struct regmap_config axp717_regmap_config = {
 	.wr_table = &axp717_writeable_table,
 	.volatile_table = &axp717_volatile_table,
 	.max_register = AXP717_CPUSLDO_CONTROL,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct regmap_config axp806_regmap_config = {
-- 
2.27.0


