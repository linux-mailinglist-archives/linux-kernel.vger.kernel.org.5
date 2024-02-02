Return-Path: <linux-kernel+bounces-49307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE7984687D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57D7B2135F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076317755;
	Fri,  2 Feb 2024 06:46:21 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A4175A9;
	Fri,  2 Feb 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856380; cv=none; b=WlrHyYvMIJmm7Y55FFpFCFISavzZPls2dHubWkTgxys7QkorF/ZnsK9SbT7f9Ou5QgAn9X360g7TDY+ERroBujHYm+KsNqmmrf6zaeh2BeZFSduNDa7RM9Lq8QLgNfUzv42j0CcsSIBtUKQpDMHbkNvzjYlqJGe8ZotUS+9AJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856380; c=relaxed/simple;
	bh=YSIGkkTm1BFmSdfaGPJduVdS5Z2k8kDYQ0Evv9sjTJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7pbHMRjFhzXDiYHZ+pKHHSL3Icl6B7q4WRDLHunGK535OlSrJYLuJoNIpG0gLslunR+pBsZURlswpjcjCW3GkGeIRVwAjH0/qm+QdnQ2dpX3/7LNEDlrOcjBpFx1qfrSwb/IrasGvzaif/GsEsTNx7LGAoAhSiZ032jSdG2F/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YYW00113;
        Fri, 02 Feb 2024 14:46:13 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 2 Feb 2024 14:46:13 +0800
From: Bo Liu <liubo03@inspur.com>
To: <alex.aring@gmail.com>, <miquel.raynal@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] net: ieee802154: mcr20a: convert to use maple tree register cache
Date: Fri, 2 Feb 2024 01:46:11 -0500
Message-ID: <20240202064611.39346-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024202144613db1c81093f198205b717d8230eab2310
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/net/ieee802154/mcr20a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 87abe3b46316..efb1be3c644e 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -251,7 +251,7 @@ static const struct regmap_config mcr20a_dar_regmap = {
 	.val_bits		= 8,
 	.write_flag_mask	= REGISTER_ACCESS | REGISTER_WRITE,
 	.read_flag_mask		= REGISTER_ACCESS | REGISTER_READ,
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 	.writeable_reg		= mcr20a_dar_writeable,
 	.readable_reg		= mcr20a_dar_readable,
 	.volatile_reg		= mcr20a_dar_volatile,
@@ -387,7 +387,7 @@ static const struct regmap_config mcr20a_iar_regmap = {
 	.val_bits		= 8,
 	.write_flag_mask	= REGISTER_ACCESS | REGISTER_WRITE | IAR_INDEX,
 	.read_flag_mask		= REGISTER_ACCESS | REGISTER_READ  | IAR_INDEX,
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 	.writeable_reg		= mcr20a_iar_writeable,
 	.readable_reg		= mcr20a_iar_readable,
 	.volatile_reg		= mcr20a_iar_volatile,
-- 
2.31.1


