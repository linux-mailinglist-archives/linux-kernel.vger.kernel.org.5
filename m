Return-Path: <linux-kernel+bounces-115965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA58C8898E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD701C31E56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12865393B56;
	Mon, 25 Mar 2024 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRnjTNRJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23E2310F3;
	Sun, 24 Mar 2024 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322242; cv=none; b=s7MOJ+36XM1+lgFiy3MUOvN0gNvXq6nbzDa5MroAg+eTPjIqaEutzhr86s+ogo7Bch4l9+NwRzpfRp4WFKdKHIJoMfT1jOP3TtZq1IkpHRxVODJYXgvAhwp6OdAGAnN50QBQmQY03AUrNI82F+qw2syJBqDi6ko18u7mpMLX668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322242; c=relaxed/simple;
	bh=Y7pSJCIFy5hLzie/88qVNlRFb+4wqmhmG+ookRDJzGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIrjDpJdYO8VRbTD2NNpTPloInneZRmFtB/3gk15XtdznwcQ8AP4oLWK2WubHlEgBn5r5T/AYyjJS0yZHdMq6ST+ud6Y60qy5ROQ0eMnzxemuqmRttv/DWiEcy2AhAqLEx2QGP0bHWmD0XOCLRIZ6uxZy5wEoL8+0+NfvSMNhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRnjTNRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE93C433F1;
	Sun, 24 Mar 2024 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322240;
	bh=Y7pSJCIFy5hLzie/88qVNlRFb+4wqmhmG+ookRDJzGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRnjTNRJdQqqkYIHp/B7FEEMONkDIlcWANsvmO4MaIO080Vy5pjqYpOT2ZtySSskO
	 hK2t6Uh3UEzdEsytk5bi57wAh07vCS7Ja/qEkrdzgmSTKu1KX9It7oT5e87VXCL8J+
	 cMUl4NyPH/uV4mFKAjzoe8z/LVN3PxEuxGHkDJEDhafjRoIlOUMwYDdzhVwMMz2G2r
	 WFOMajJysIBeDoZCjiJfwE272BdOaiKZeSBgodiD5FUsAgum+90tyEgN+K3YiboiQ/
	 1USpRbqxsFq/N1TAZJTiN9Td+W5ybdIxrdcJaJ8xd46oDWXv4AIekX2hhX8+TDYTME
	 XzPEpZZbawjUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 322/451] HID: amd_sfh: Avoid disabling the interrupt
Date: Sun, 24 Mar 2024 19:09:58 -0400
Message-ID: <20240324231207.1351418-323-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index c936d6a51c0cd..9c963ad27f9d1 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -34,6 +34,8 @@ static int sensor_mask_override = -1;
 module_param_named(sensor_mask, sensor_mask_override, int, 0444);
 MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
 
+static bool intr_disable = true;
+
 static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts)
 {
 	union cmd_response cmd_resp;
@@ -54,7 +56,7 @@ static void amd_start_sensor_v2(struct amd_mp2_dev *privdata, struct amd_mp2_sen
 
 	cmd_base.ul = 0;
 	cmd_base.cmd_v2.cmd_id = ENABLE_SENSOR;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = info.period;
 	cmd_base.cmd_v2.sensor_id = info.sensor_idx;
 	cmd_base.cmd_v2.length = 16;
@@ -72,7 +74,7 @@ static void amd_stop_sensor_v2(struct amd_mp2_dev *privdata, u16 sensor_idx)
 
 	cmd_base.ul = 0;
 	cmd_base.cmd_v2.cmd_id = DISABLE_SENSOR;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = 0;
 	cmd_base.cmd_v2.sensor_id = sensor_idx;
 	cmd_base.cmd_v2.length  = 16;
@@ -86,7 +88,7 @@ static void amd_stop_all_sensor_v2(struct amd_mp2_dev *privdata)
 	union sfh_cmd_base cmd_base;
 
 	cmd_base.cmd_v2.cmd_id = STOP_ALL_SENSORS;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = 0;
 	cmd_base.cmd_v2.sensor_id = 0;
 
@@ -288,6 +290,26 @@ int amd_sfh_irq_init(struct amd_mp2_dev *privdata)
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
@@ -311,6 +333,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (dmi_first_match(dmi_nodevs))
 		return -ENODEV;
 
+	dmi_check_system(dmi_sfh_table);
+
 	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
 	if (!privdata)
 		return -ENOMEM;
-- 
2.43.0


