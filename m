Return-Path: <linux-kernel+bounces-124922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62D891DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9B01C22AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D833CDFE7;
	Fri, 29 Mar 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/9upM9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAE3CDFD1;
	Fri, 29 Mar 2024 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716435; cv=none; b=d2P3S5uZ2yE8KTzyKBsK6oHjvc+v6S58o+r71Bwx8S5kJ9Rl2wHcPr/+zkqnYWmn2ZrE6cvCPdXBsvj7ovIhz3YdJSMM/lvm0DqPb/fZuFe7/gOrIDagScQBk3jk8AMji3IkPsDth+LGvJPQAU99U0wxrpv0We40wPxFOA16E+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716435; c=relaxed/simple;
	bh=FhflmwTDHgb2DGhLTLaolrnWf5HOYW5FaDwLAJXVu2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUoFN5EHdKhAtVXu6KNI4n5AOjEPeAf3uB0TQaM+LYtZsZPPuP3DPEyq0X8EK4gykSz3codnQywJT6vkdpage1IWBzLVTGvjV8wCijZUIpZFlXe0y3VbT2i5VoSeuVoZnDQCjOobEeiqsp73GQVO2aQOC8xq1bXqWvANPCHuON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/9upM9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A6C433C7;
	Fri, 29 Mar 2024 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716434;
	bh=FhflmwTDHgb2DGhLTLaolrnWf5HOYW5FaDwLAJXVu2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/9upM9j31mk99A1bQiC2DNYJ1b5kNVli921vx9K7MmG865Rck/Oa2yEd5oNocdQq
	 IcRxvXobxtWSPmes/EMMWVuBK5viB07kTYhpuXrAzMThM3zBkjowvYi71vT81yHdkb
	 r1PcLMihNg/9ZLW5aXS73ut3rF7NJo7DIleK9KoJPOrr+vQbJpjxIPk+Qnbm4gb+ah
	 Z5N+v0yfyBQhCN1ReLPLo3LQ3SqcPDR6l2Jtiwa3QZvRcck2rq3pfopjpgdbs2MaKE
	 NkN87U7C3d3RPL9TqEBdPCu0wWZtx255LDZzQ/WsjETEgFzfwQY0UCL/qqkzk/BzhW
	 //JMQm6yQHMQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karel Balej <balejk@matfyz.cz>,
	Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 38/52] input/touchscreen: imagis: add support for IST3032C
Date: Fri, 29 Mar 2024 08:45:32 -0400
Message-ID: <20240329124605.3091273-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 309088eadad21..400d53eae9424 100644
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
@@ -363,6 +365,13 @@ static int __maybe_unused imagis_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
 
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


