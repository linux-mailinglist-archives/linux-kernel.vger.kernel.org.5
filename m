Return-Path: <linux-kernel+bounces-28484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F6482FF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E68B23A71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612B4685;
	Wed, 17 Jan 2024 03:08:49 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A881C6FB9;
	Wed, 17 Jan 2024 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460929; cv=none; b=mt0DMfUDRA0rUhd05OQ/xQb4rGu/JruZxpaGzRlpkja9gL/aMaLv2+sJ2nVxivpgf6m9G+If+bVYLT6cdPlIqXj2+09+k/szJwiyvBGBOOH5UfbztD5iJMbFvHhxPFPL4+WsKF2CQ169LcZUX2akmg1S5pYbq8K8Bk3q7nVFdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460929; c=relaxed/simple;
	bh=jY+NXMkTqUvIFNdDRoTWqSBvn/6OLwroA91s1Dp/Fls=;
	h=Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:tUid:
	 X-Abuse-Reports-To:Abuse-Reports-To:X-Complaints-To:
	 X-Report-Abuse-To; b=K7K5zgqpo99EL4Ef+Gg2qn7C2sCmK/8I+SHf4URSWQEOkm/y5xP9a/LsKNl3Ei7rcvwkR/v2v+0NVoRe+/r+o7cOzyUGLjtRjWePM+9NxXCCpMhPs4AGNQ7u6QrwjMk4fohQ3yGfl0pLqHkDOKEoSUXhPRiOeQ8OJAZ2WRb7pcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id NUY00131;
        Wed, 17 Jan 2024 11:07:31 +0800
Received: from localhost.localdomain.com (10.73.43.35) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 11:07:32 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sakari.ailus@linux.intel.com>, <ribalda@kernel.org>, <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] media: i2c: imx214: convert to use maple tree register cache
Date: Tue, 16 Jan 2024 22:07:30 -0500
Message-ID: <20240117030730.2667-1-liubo03@inspur.com>
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
tUid: 2024117110731bce681c772561e92e87569ceeb8b6d93
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/media/i2c/imx214.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index b148b1bd2bc3..10b6ad66d126 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -968,7 +968,7 @@ static const struct v4l2_subdev_internal_ops imx214_internal_ops = {
 static const struct regmap_config sensor_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int imx214_get_regulators(struct device *dev, struct imx214 *imx214)
-- 
2.31.1


