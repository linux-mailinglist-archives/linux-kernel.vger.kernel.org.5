Return-Path: <linux-kernel+bounces-108661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98225880E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B6A1F21948
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2980405EC;
	Wed, 20 Mar 2024 08:58:02 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9C3FB9A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925082; cv=none; b=f/wUMHyCYGToVDZFZBbA+7w2FleGkQtaAXPFDg4r89yp3IsLpDq/c8D61DzwH1pK1gDZAAbEi2RAIgYZv/5m2S72sO7phUr+sam04fOO1Q5a4XBokEaBPVGqsA2WGzYl+erqSTc8KUJ8lCfxeKD6ciuUw/YIHqE2TWiHfLAE6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925082; c=relaxed/simple;
	bh=zBOalU4rrrEjXh341Q9ScXERLDVCcmVH1f7WW5Yw8zE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZNHL9iDB47snwg09W6Rp8/8bhNKdPNG8YrOaM2YXk2WbqwOQTftAgV5lnXGtTcC5A0gLwVsOise1dFbEJS0UwgWx1+d50ZfNdB4T/oP0/Orp0g60gecOA5MpRMAw+SHgiRfdtIiV/0LdbZiWGXhzHdB0HRfRpaE5iFZenjVEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id RDA00055;
        Wed, 20 Mar 2024 16:57:55 +0800
Received: from localhost.localdomain (10.94.17.92) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.35; Wed, 20 Mar 2024 16:57:55 +0800
From: Bo Liu <liubo03@inspur.com>
To: <support.opensource@diasemi.com>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jagan@amarulasolutions.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH v1 09/13] regulator: rtmv20: convert to use maple tree register cache
Date: Wed, 20 Mar 2024 04:57:36 -0400
Message-ID: <20240320085740.4604-10-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20240320085740.4604-1-liubo03@inspur.com>
References: <20240320085740.4604-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 202432016575599dce4ce8f4c4c7ca6b8396a8419d560
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/regulator/rtmv20-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
index dfd1522637e4..3d8d29f87b58 100644
--- a/drivers/regulator/rtmv20-regulator.c
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -312,7 +312,7 @@ static bool rtmv20_is_volatile_reg(struct device *dev, unsigned int reg)
 static const struct regmap_config rtmv20_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = RTMV20_REG_LDMASK,
 	.num_reg_defaults_raw = RTMV20_MAX_REGS,
 
-- 
2.18.2


