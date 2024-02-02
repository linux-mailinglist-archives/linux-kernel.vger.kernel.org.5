Return-Path: <linux-kernel+bounces-49308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1B846880
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB6E2813A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B2179AC;
	Fri,  2 Feb 2024 06:47:07 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27B1755F;
	Fri,  2 Feb 2024 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856427; cv=none; b=OfV3QmTJARUK2tlCXXL/7sBevHML8PcepnIPj/JC/dRCP5lp0TSTuoqffWYHMnlzjW3LsfsA9r90G2MvJ8SWp6xzYMPjFB8ASj/3cs0GzZnU7WFHqT4iKiEIcjgvioDqSbSzMalj5/cDTa/6iUXmBHXIUbz2BLtqPDXKjYlS8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856427; c=relaxed/simple;
	bh=5I7K9Aet616w+WQ5bWBBDLZY6f95EOyNAZnvn62J0mg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2n0lR3SCfRFld/ZmWssudUvpgZytOItQR4zWGaOHOI5txTX2gy9s1yz8fCoYuKnyVjZuQV59ihKWU73qclxgv+aegs8ls1r/e9VPp6JX9psCtY6L4CLEMRk/HyxqSbm5xGQfyzx9XSPkZXSeGqbvY2tLyhTW8SzISFkkYTIJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YYX00001;
        Fri, 02 Feb 2024 14:47:01 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 14:47:00 +0800
From: Bo Liu <liubo03@inspur.com>
To: <alex.aring@gmail.com>, <miquel.raynal@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] net: ieee802154: mrf24j40: convert to use maple tree register cache
Date: Fri, 2 Feb 2024 01:46:59 -0500
Message-ID: <20240202064659.39434-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024202144701d61234cc7682d80a545840d590fa313a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/net/ieee802154/mrf24j40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index ee4cfbf2c5cc..d3f42efc5d1a 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -388,7 +388,7 @@ static const struct regmap_config mrf24j40_short_regmap = {
 	.pad_bits = 1,
 	.write_flag_mask = MRF24J40_SHORT_WRITE,
 	.read_flag_mask = MRF24J40_SHORT_READ,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = MRF24J40_SHORT_NUMREGS,
 	.writeable_reg = mrf24j40_short_reg_writeable,
 	.readable_reg = mrf24j40_short_reg_readable,
@@ -495,7 +495,7 @@ static const struct regmap_config mrf24j40_long_regmap = {
 	.pad_bits = 5,
 	.write_flag_mask = MRF24J40_LONG_ACCESS,
 	.read_flag_mask = MRF24J40_LONG_ACCESS,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = MRF24J40_LONG_NUMREGS,
 	.writeable_reg = mrf24j40_long_reg_writeable,
 	.readable_reg = mrf24j40_long_reg_readable,
-- 
2.31.1


