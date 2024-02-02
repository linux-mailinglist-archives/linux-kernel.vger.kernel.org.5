Return-Path: <linux-kernel+bounces-49304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637F846875
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889F01C25447
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03801B7E7;
	Fri,  2 Feb 2024 06:44:57 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E2487A3;
	Fri,  2 Feb 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856297; cv=none; b=dnEPuHVyByrnE5t56+I3JUjcqEp7ZlpwsZxrQsbV+txtxR8825GgKCCkiMYMKXlydzS+ySpEByjDpUMpAA6lRtzSMkpq8d+6PyEBJ4mJLxeOKl4CnaWLzmituWXsG2rBCspuCHMdPa8/RkqhiBwNcuWFPvHmSuL1MrQjdED6ghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856297; c=relaxed/simple;
	bh=TdFGU89xpk1hjNXN+ZsruSkJjk4d0NqyQ9VSJozPCjM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hFEhJ64n8JjqINELULhOdUAiBMSNXKB6/Bzh1jc+JAGMwdGkfKmadwbs+O562nrxg7rgeefnvUaRzkdyQHMGD2cp4Wp+yHti1dy3cdzWPserHVapItGg50sZnlX0TTAo5WF+HFaVv64SqowdUSYnMPNmQcg8ZymwC3e5tD9e/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YYT00038;
        Fri, 02 Feb 2024 14:43:38 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 14:43:37 +0800
From: Bo Liu <liubo03@inspur.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] net: encx24j600: convert to use maple tree register cache
Date: Fri, 2 Feb 2024 01:43:36 -0500
Message-ID: <20240202064336.39138-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024202144338eccbe320a9b895256bb1bc63e56e9fe0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/net/ethernet/microchip/encx24j600-regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600-regmap.c b/drivers/net/ethernet/microchip/encx24j600-regmap.c
index 2e0fe16a4082..443128adbcb6 100644
--- a/drivers/net/ethernet/microchip/encx24j600-regmap.c
+++ b/drivers/net/ethernet/microchip/encx24j600-regmap.c
@@ -464,7 +464,7 @@ static struct regmap_config regcfg = {
 	.val_bits = 16,
 	.max_register = 0xee,
 	.reg_stride = 2,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 	.readable_reg = encx24j600_regmap_readable,
 	.writeable_reg = encx24j600_regmap_writeable,
@@ -485,7 +485,7 @@ static struct regmap_config phycfg = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = 0x1f,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 	.readable_reg = encx24j600_phymap_readable,
 	.writeable_reg = encx24j600_phymap_writeable,
-- 
2.31.1


