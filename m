Return-Path: <linux-kernel+bounces-54394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E0784AEB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC081F2432F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FFE12AADB;
	Tue,  6 Feb 2024 07:13:45 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBC128828;
	Tue,  6 Feb 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203625; cv=none; b=QMmMqfGojuIqdLZQe+97kncL32Te2MYIF9vu0vGCjwmqq88U1R9x0uKSmVwy1IrYtu0C0Dz7fdSSoVBLJaZtb04H3IBmOhvtuZUatXWA4SoaFxIMUh+fBUFJa+QtV+FMz9o25jydvEdqo6WeG4G1kjaxMdQvVDUe9HcM6cfVLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203625; c=relaxed/simple;
	bh=JVp1JSCOyKrEPZ247bdobVMOqhmicREheRxwYMuAkWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKbi3ftFSjgND5ThLADmdkDwdy7x4aLYuNDC7+u+LhqhjxVt38uHzGpzqCDNEpgk9vIf4T+Mq7TJUf15s2ZGlejAMYDq1OoWne0VL3Ta3CJWUlCRgLvtSsDog3hfhmDjkuDcExfyGKg+e6yHIF6IcIHPDiNI3bwqZ2/ze+c9oIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CZT00139;
        Tue, 06 Feb 2024 15:13:39 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.34; Tue, 6 Feb 2024 15:13:39 +0800
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
Subject: [PATCH 08/18] mfd: khadas-mcu: convert to use maple tree register cache
Date: Tue, 6 Feb 2024 02:13:04 -0500
Message-ID: <20240206071314.8721-9-liubo03@inspur.com>
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
tUid: 2024206151339888f549b31f273a362f0bbdd55baa0cf
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/mfd/khadas-mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index 61396d824f16..ba981a788692 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -72,7 +72,7 @@ static const struct regmap_config khadas_mcu_regmap_config = {
 	.max_register	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
 	.volatile_reg	= khadas_mcu_reg_volatile,
 	.writeable_reg	= khadas_mcu_reg_writeable,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static struct mfd_cell khadas_mcu_fan_cells[] = {
-- 
2.18.2


