Return-Path: <linux-kernel+bounces-113820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44578886C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64B11C25E31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D84612FB33;
	Sun, 24 Mar 2024 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De74/UMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BFE1DB08C;
	Sun, 24 Mar 2024 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320850; cv=none; b=qy2wL8DuATcLwG7j+yX96FD5vaO64HwxNgESxh6O1OovfUJReAqF3CNCC1DFtuy5ZcaC9LiEsd91VoJL1bllIDMa2RDSb1xN1ixQu5bGdJJjqbf4eemApkAv9L0kxicDUP5BBzaxZLZDlvSyZtu44zD4hMGSEhycmM/YnsPDg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320850; c=relaxed/simple;
	bh=k0CHCQeQYAxizY/a36oGNxW78++AXdIg+U+sNWUr7Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6G98fHla1Q1OqDQv+KdVdScNdh0ZmsbOFxzjJcZE2vDUHXvUElDGUMUOu1fV+ccDP0VcLLpYeiUsUfmp82HXw/pe2BP7RxSUAJdHYMFoaKAsk32FxV6ollwMGFN5tZ/kjDCCh8OBJQcayzQtYuFSjL0gY7gk1Epg+L3FosXLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De74/UMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5441BC433F1;
	Sun, 24 Mar 2024 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320849;
	bh=k0CHCQeQYAxizY/a36oGNxW78++AXdIg+U+sNWUr7Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=De74/UMDBEBoP7sJj0l0xXGMZfAhFZVUP9P6Ms3fXjtgCRUOPVajRqHAPhFTvxd3q
	 MTtp/bPs8WKVYD5xizLf7JrXUoFMg5zaIGmtaMsU4+bH+BgXOqzBCV1vIY+Bzf9V0d
	 J5Maokb1v82coCxqMOhAR00Jt2FB2GwE9J4V5x3S2yT+OJ5mpEKs8ln97sj3FQu6S+
	 mfkLqbMER0kgLcUXRhWN9WLUuJsTCkPl+guTANUhGhzvVlRYmm82Y6z1TtJHGrpww4
	 FWolErcM4j7npvfCGK+r5Fve9cQ4fO8RllFRTC8Fxb/8ifdMATj+rLAgO9g041yHrn
	 OokkL1n580y7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikhail Khvainitski <me@khvoinitsky.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 414/713] HID: lenovo: Add middleclick_workaround sysfs knob for cptkbd
Date: Sun, 24 Mar 2024 18:42:20 -0400
Message-ID: <20240324224720.1345309-415-sashal@kernel.org>
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

From: Mikhail Khvainitski <me@khvoinitsky.org>

[ Upstream commit 2814646f76f8518326964f12ff20aaee70ba154d ]

Previous attempt to autodetect well-behaving patched firmware
introduced in commit 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw
on cptkbd and stop applying workaround") has shown that there are
false-positives on original firmware (on both 1st gen and 2nd gen
keyboards) which causes the middle button click workaround to be
mistakenly disabled.

This commit adds explicit parameter to sysfs to control this
workaround.

Fixes: 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround")
Fixes: 43527a0094c1 ("HID: lenovo: Restrict detection of patched firmware only to USB cptkbd")
Signed-off-by: Mikhail Khvainitski <me@khvoinitsky.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-lenovo.c | 57 +++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 149a3c74346b4..f86c1ea83a037 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -54,10 +54,10 @@ struct lenovo_drvdata {
 	/* 0: Up
 	 * 1: Down (undecided)
 	 * 2: Scrolling
-	 * 3: Patched firmware, disable workaround
 	 */
 	u8 middlebutton_state;
 	bool fn_lock;
+	bool middleclick_workaround_cptkbd;
 };
 
 #define map_key_clear(c) hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
@@ -621,6 +621,36 @@ static ssize_t attr_sensitivity_store_cptkbd(struct device *dev,
 	return count;
 }
 
+static ssize_t attr_middleclick_workaround_show_cptkbd(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+		cptkbd_data->middleclick_workaround_cptkbd);
+}
+
+static ssize_t attr_middleclick_workaround_store_cptkbd(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
+	int value;
+
+	if (kstrtoint(buf, 10, &value))
+		return -EINVAL;
+	if (value < 0 || value > 1)
+		return -EINVAL;
+
+	cptkbd_data->middleclick_workaround_cptkbd = !!value;
+
+	return count;
+}
+
 
 static struct device_attribute dev_attr_fn_lock =
 	__ATTR(fn_lock, S_IWUSR | S_IRUGO,
@@ -632,10 +662,16 @@ static struct device_attribute dev_attr_sensitivity_cptkbd =
 			attr_sensitivity_show_cptkbd,
 			attr_sensitivity_store_cptkbd);
 
+static struct device_attribute dev_attr_middleclick_workaround_cptkbd =
+	__ATTR(middleclick_workaround, S_IWUSR | S_IRUGO,
+			attr_middleclick_workaround_show_cptkbd,
+			attr_middleclick_workaround_store_cptkbd);
+
 
 static struct attribute *lenovo_attributes_cptkbd[] = {
 	&dev_attr_fn_lock.attr,
 	&dev_attr_sensitivity_cptkbd.attr,
+	&dev_attr_middleclick_workaround_cptkbd.attr,
 	NULL
 };
 
@@ -686,23 +722,7 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 {
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	if (cptkbd_data->middlebutton_state != 3) {
-		/* REL_X and REL_Y events during middle button pressed
-		 * are only possible on patched, bug-free firmware
-		 * so set middlebutton_state to 3
-		 * to never apply workaround anymore
-		 */
-		if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD &&
-				cptkbd_data->middlebutton_state == 1 &&
-				usage->type == EV_REL &&
-				(usage->code == REL_X || usage->code == REL_Y)) {
-			cptkbd_data->middlebutton_state = 3;
-			/* send middle button press which was hold before */
-			input_event(field->hidinput->input,
-				EV_KEY, BTN_MIDDLE, 1);
-			input_sync(field->hidinput->input);
-		}
-
+	if (cptkbd_data->middleclick_workaround_cptkbd) {
 		/* "wheel" scroll events */
 		if (usage->type == EV_REL && (usage->code == REL_WHEEL ||
 				usage->code == REL_HWHEEL)) {
@@ -1166,6 +1186,7 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
 	cptkbd_data->middlebutton_state = 0;
 	cptkbd_data->fn_lock = true;
 	cptkbd_data->sensitivity = 0x05;
+	cptkbd_data->middleclick_workaround_cptkbd = true;
 	lenovo_features_set_cptkbd(hdev);
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group_cptkbd);
-- 
2.43.0


