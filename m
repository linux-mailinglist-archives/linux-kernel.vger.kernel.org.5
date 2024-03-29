Return-Path: <linux-kernel+bounces-124788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E4891C84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABAC28531E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE3189253;
	Fri, 29 Mar 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG6USFjQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B418923F;
	Fri, 29 Mar 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716142; cv=none; b=mtkKD87kNzQuwKDE/bdOJD+DGWeCTodB1zp/UFS4I518t8SZZiW68aUH4vIwoucdzt9CYqQ6h0PktW6R+SK8tBqbzFkZAdKz9m5bmxGZRsOFiDO1oKp7MF33auAPKrpF7khM1fi283yV6l+cCTBJQ3wOLeIt52sOEa7epEP0ZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716142; c=relaxed/simple;
	bh=yuX9XVGrAT1kcHDp/0Thq9ukxuSdmRxes7/j7tsWnhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWj+bkb1+mR0p0rvnlgXgGWHJvA6WhxKobUGkO3tFk+iamq1bh0Qiys3MaMIqwuYNurhnutfybZ3P3syhrR8CaJkV5205JMgPuxoYWV3magL5NnXhgpwDwsjEjpoq6MmNzaJz1AwBPrAsmsqZCjS3h+30lXDTNSRcvdVEjyk5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG6USFjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA94C43390;
	Fri, 29 Mar 2024 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716142;
	bh=yuX9XVGrAT1kcHDp/0Thq9ukxuSdmRxes7/j7tsWnhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FG6USFjQwib2yBJ/6g5fcEOWPkDdfwjBcXi+laz+3w2pjqKf6/V8//pu76OsqyYg0
	 QNgpoZHD7YpWaDtYoXEJMs+VXTmdOiWspGL7JxTNicLbltUlyq+eTlXln8SBSVAUVf
	 EPT1flVWiRSY5ZVHp+Nl4+zjJGmTLodU9XOjtNoTCb+ajrKFEVOKSHHgiVtmHsgXnA
	 glde2mQlI9Nk7Eijb3plxQOtxpHLpMd3f1GQ/HbascSE0nEkBs0F2Tb3fhc1eBRjB6
	 ITr5CeraFt+nhyOYgIflGrc0VdiRgWQ8IrKPS6VAFzHFnJl8kzSsPhwx+NEUkQG4aB
	 tZUg/sLSqsYgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karel Balej <balejk@matfyz.cz>,
	Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 78/98] input/touchscreen: imagis: add support for IST3032C
Date: Fri, 29 Mar 2024 08:37:49 -0400
Message-ID: <20240329123919.3087149-78-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

[ Upstream commit 90cb57a6c5717b83a110c0da720a03ee32ed255e ]

IST3032C is a touchscreen chip used for instance in the
samsung,coreprimevelte smartphone, with which this was tested. Add the
chip specific information to the driver.

Reviewed-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
Link: https://lore.kernel.org/r/20240301164659.13240-6-karelb@gimli.ms.mff.cuni.cz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/imagis.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 9af8a6332ae67..e1fafa561ee38 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -11,6 +11,8 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
+#define IST3032C_WHOAMI			0x32c
+
 #define IST3038B_REG_STATUS		0x20
 #define IST3038B_REG_CHIPID		0x30
 #define IST3038B_WHOAMI			0x30380b
@@ -363,6 +365,13 @@ static int imagis_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
 
+static const struct imagis_properties imagis_3032c_data = {
+	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
+	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
+	.whoami_cmd = IST3038C_REG_CHIPID,
+	.whoami_val = IST3032C_WHOAMI,
+};
+
 static const struct imagis_properties imagis_3038b_data = {
 	.interrupt_msg_cmd = IST3038B_REG_STATUS,
 	.touch_coord_cmd = IST3038B_REG_STATUS,
@@ -380,6 +389,7 @@ static const struct imagis_properties imagis_3038c_data = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id imagis_of_match[] = {
+	{ .compatible = "imagis,ist3032c", .data = &imagis_3032c_data },
 	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
 	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
 	{ },
-- 
2.43.0


