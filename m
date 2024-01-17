Return-Path: <linux-kernel+bounces-28483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16CF82FF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659A61F233E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D44685;
	Wed, 17 Jan 2024 03:08:35 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51110F5;
	Wed, 17 Jan 2024 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460915; cv=none; b=giVzf+c29oBrB72GR26Zl+vrcHOMXUtAL2NmVqGdfXgoKa3qO+FsDIvM0RjL6vTMWLY7vI/KL9SNNuSDzVbi6JkbGkALjE55ahuKuZPW0Vz2mVXBkZF68bMnX983ksRhoc9pKpLJCWvaYugv0JHQ6dsxczDz/qc6LkDrw/vOuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460915; c=relaxed/simple;
	bh=LgzqIfQ4rKmhCQsEDtO2mK5y78n/3iuzzhayRt3smYQ=;
	h=Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:tUid:
	 X-Abuse-Reports-To:Abuse-Reports-To:X-Complaints-To:
	 X-Report-Abuse-To; b=kKDljfXJVtCYZX8GJVZ/1Ci2XFcqL0r/zDKuO4IMCkTy2e3+nQHRdKtX+TDdf3tlwMqK4YU6rE6B/h9pO0pi16Tmvp5Gj2N5eaAzO1flchzNv+NGD1c79+3mmsk4RMEykCL/kzx4A9j5695yAlts8+e/dEGdI7ZfoUwn+Rht6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id NUZ00126;
        Wed, 17 Jan 2024 11:08:26 +0800
Received: from localhost.localdomain.com (10.73.43.35) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 11:08:26 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sakari.ailus@linux.intel.com>, <leonl@leopardimaging.com>,
	<mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] media: i2c: imx274: convert to use maple tree register cache
Date: Tue, 16 Jan 2024 22:08:25 -0500
Message-ID: <20240117030825.2730-1-liubo03@inspur.com>
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
tUid: 2024117110826d0e23e1a324e1e8bbbcbd8ad1250f9ab
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/media/i2c/imx274.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index 352da68b8b41..3800de974e8a 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -151,7 +151,7 @@ struct reg_8 {
 static const struct regmap_config imx274_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /*
-- 
2.31.1


