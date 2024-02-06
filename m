Return-Path: <linux-kernel+bounces-54389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D007B84AEA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656F7280DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB5C128809;
	Tue,  6 Feb 2024 07:13:43 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27341128804;
	Tue,  6 Feb 2024 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203622; cv=none; b=Q/Y2RQUCtIThhTujEt1DAQF9n+mmC3VmGXycOJvlKHsrRxvCwIDlV/NvEF8/K7EiTkzHDHMrfIC3Lm2SeqbOJaBjtCwea2D45euxgihcTQBy0cg1Y366ZKsFp8s11/61DgZJ+0OmgML2Xbst4ZGb+15NgNBgVBpeCYMyAnMmJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203622; c=relaxed/simple;
	bh=DiaHYmNc6bF7PygFJrnRHF0LPWs4SCQMsw8gKMZvi90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ft4K5VzbYHCZEIOt5yO2Uhzfa4FxJK/m8nB8hZqmrKTeMF51u4AkJ3Th9oytpPml6Un4WmUjVwGyT7QGXpdPyRhe+0oCkTJUY4DF52WyHkwLront3QsiErbKKzp1qJloPRVN2AGFm+Zf18CbFRqotF9AIctRWwQPZWebEYbWNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CZT00132;
        Tue, 06 Feb 2024 15:13:32 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.34; Tue, 6 Feb 2024 15:13:32 +0800
From: Bo Liu <liubo03@inspur.com>
To: <lee@kernel.org>, <wens@csie.org>, <marek.vasut+renesas@gmail.com>,
	<support.opensource@diasemi.com>, <neil.armstrong@linaro.org>,
	<ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
	<mazziesaccount@gmail.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <patches@opensource.cirrus.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH 01/18] mfd: ac100: convert to use maple tree register cache
Date: Tue, 6 Feb 2024 02:12:57 -0500
Message-ID: <20240206071314.8721-2-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20240206071314.8721-1-liubo03@inspur.com>
References: <20240206071314.8721-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20242061513323aabcb358b26888c73e9f44d39c0d4b0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/mfd/ac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ac100.c b/drivers/mfd/ac100.c
index 6d49d7fb5f14..8f47c392cbd1 100644
--- a/drivers/mfd/ac100.c
+++ b/drivers/mfd/ac100.c
@@ -72,7 +72,7 @@ static const struct regmap_config ac100_regmap_config = {
 	.wr_table	= &ac100_writeable_table,
 	.volatile_table	= &ac100_volatile_table,
 	.max_register	= AC100_RTC_GP(15),
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static struct mfd_cell ac100_cells[] = {
-- 
2.18.2


