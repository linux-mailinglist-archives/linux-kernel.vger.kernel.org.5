Return-Path: <linux-kernel+bounces-113883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60A88871B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83391C23C06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166F920CDF3;
	Sun, 24 Mar 2024 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5Z9nU22"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7DC1EC649;
	Sun, 24 Mar 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320952; cv=none; b=VFxaOLUml/27Q8UIAufrUYVML/NDB85RKIU48uG4CenlQaGk/fyj7MTLjwms/Db1tJfFudfw/P0wrkcCkoj0qLagAMXKy05LfxV52iM/ZJQJFOmH7oCw1DH56BzvGFGUYWk/5J3Ulwhk7Q0tRIiFGySxy12PP9fOSQG55kB+vvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320952; c=relaxed/simple;
	bh=Fh4E4z39r7oA0cEzec0Z79XrPswQA0teNAo3fCt4Zg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeJqJfid/UhoD1rUFrBOQSEK3zcfSALipanmDwagtlCwt/w1MiWmk2QBDeARYxV5IJQS1KiDSEQmxTmCW2y++qfOAn0U+yLeb8dZnAYbFWJOcsgSECy8woZ+NmsUVZ33SFJwr3dy97TOUTZ5LgTcSZPrfyyOTv75qglQpEaxrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5Z9nU22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1684C433F1;
	Sun, 24 Mar 2024 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320951;
	bh=Fh4E4z39r7oA0cEzec0Z79XrPswQA0teNAo3fCt4Zg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5Z9nU22MGN1ISNOwgRwY65zg9gFx/o1Rnmau110n6UFiyaDCvTISr/jJPhnynpli
	 JVThTvW4yCh91I8YtEJ1cmid0Awk+4YwSOokDVb9VOcICDalZlxWbGEEKuTdcYOpcL
	 f/O585Knh+QSP41yS+OxqJhtkqaN1Ocru9R/1DBsX4rHAF73Q0bd9SxuHpjIjPoR/B
	 hPz8t7gdjw5ydSHBDjnyJypvJQGRVIuMhLCLRYAdUtamuJyl10Q/LAuRqjg4tf+/Nh
	 chMNYpJQA+HN43jT3urI6Ljvuf9zvn0yzS6ZgshTdKSSbK40nQDiZce8//NbemNEYX
	 94KWv0KO3R6dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 515/713] HID: amd_sfh: Avoid disabling the interrupt
Date: Sun, 24 Mar 2024 18:44:01 -0400
Message-ID: <20240324224720.1345309-516-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit c1db0073212ef39d5a46c2aea5e49bf884375ce4 ]

HP ProBook x360 435 G7 using older version of firmware which doesn't
support disabling the interrupt for all commands. Hence avoid disabling
the interrupt for that particular model.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218104
Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 30 +++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 2530fa98b568b..ce449da08e9ba 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -35,6 +35,8 @@ static int sensor_mask_override = -1;
 module_param_named(sensor_mask, sensor_mask_override, int, 0444);
 MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
 
+static bool intr_disable = true;
+
 static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts)
 {
 	union cmd_response cmd_resp;
@@ -55,7 +57,7 @@ static void amd_start_sensor_v2(struct amd_mp2_dev *privdata, struct amd_mp2_sen
 
 	cmd_base.ul = 0;
 	cmd_base.cmd_v2.cmd_id = ENABLE_SENSOR;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = info.period;
 	cmd_base.cmd_v2.sensor_id = info.sensor_idx;
 	cmd_base.cmd_v2.length = 16;
@@ -73,7 +75,7 @@ static void amd_stop_sensor_v2(struct amd_mp2_dev *privdata, u16 sensor_idx)
 
 	cmd_base.ul = 0;
 	cmd_base.cmd_v2.cmd_id = DISABLE_SENSOR;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = 0;
 	cmd_base.cmd_v2.sensor_id = sensor_idx;
 	cmd_base.cmd_v2.length  = 16;
@@ -87,7 +89,7 @@ static void amd_stop_all_sensor_v2(struct amd_mp2_dev *privdata)
 	union sfh_cmd_base cmd_base;
 
 	cmd_base.cmd_v2.cmd_id = STOP_ALL_SENSORS;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = 0;
 	cmd_base.cmd_v2.sensor_id = 0;
 
@@ -292,6 +294,26 @@ int amd_sfh_irq_init(struct amd_mp2_dev *privdata)
 	return 0;
 }
 
+static int mp2_disable_intr(const struct dmi_system_id *id)
+{
+	intr_disable = false;
+	return 0;
+}
+
+static const struct dmi_system_id dmi_sfh_table[] = {
+	{
+		/*
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=218104
+		 */
+		.callback = mp2_disable_intr,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook x360 435 G7"),
+		},
+	},
+	{}
+};
+
 static const struct dmi_system_id dmi_nodevs[] = {
 	{
 		/*
@@ -315,6 +337,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (dmi_first_match(dmi_nodevs))
 		return -ENODEV;
 
+	dmi_check_system(dmi_sfh_table);
+
 	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
 	if (!privdata)
 		return -ENOMEM;
-- 
2.43.0


