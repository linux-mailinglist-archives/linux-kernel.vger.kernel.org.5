Return-Path: <linux-kernel+bounces-124852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D96891D20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E483C284170
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE231C1322;
	Fri, 29 Mar 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j68fjMDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66D1C130E;
	Fri, 29 Mar 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716291; cv=none; b=CPdPtzJAXm1nNbJgEnjEe2irwcRdHPD4J1s5QY17Jp3o5PReKNUu29QEFwMOTP+aa90onOchkt9ECGaGqVKS2W/ecexLRsxwp+LYzEgsVhJI7Pq/A/vBSEIR6ybPlHRATcfoWApwiNU+nqjG1zyHKoZYGhSV1dKuYdLJBwvUpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716291; c=relaxed/simple;
	bh=yY0XL742VCwTAjeTJMc11JrIqXdyI7PgiIUYNM1dC+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESNyynEnHAEdTmNvxqAUIowWUBinN7HOSVolSWWuFP6uMzLizD9pvF8jdYtWs9b5s3RPeUxRy6zsMBDPhknH75S5FyYD1z3unvak/9mQaiCrUuGUEa7CKQlyY44Dwll9Aim8yvi++7EgN9qV/DOerV+3ZynOS7hATbB56gOuhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j68fjMDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685DEC433F1;
	Fri, 29 Mar 2024 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716291;
	bh=yY0XL742VCwTAjeTJMc11JrIqXdyI7PgiIUYNM1dC+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j68fjMDBmXUlFDaw3zNE1SXlXPrEWvZwMy1DDEFPrul+xatsqhfusmYvQbcE3gVyF
	 LsHlGa464++W521HHtSERZY+OymSdiCD+E6aKKmI4zfLcZBqtDYO+9XD4QiBzotn9Z
	 fTLS9KgrnLjKphlvbnad6Qm7TJJnsi8VnXSdhd8qtRisM5IcMNmtrs/ALFpxQz/l/s
	 qOztz5W8F0WYVEic47qDRYOBfRzeOj0m73TkrlXPsE9v0+omoQgUEWeqLjPGbxMF/a
	 10DD83RGkXAzECarqJjcrewzcBn1OGilSjsRtuq4+1aQN2rjBLr7NUtxAZe1zbJyRD
	 iFuF3ap4dBCbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 43/75] HID: input: avoid polling stylus battery on Chromebook Pompom
Date: Fri, 29 Mar 2024 08:42:24 -0400
Message-ID: <20240329124330.3089520-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 9a5b1521e2d0d7ace70c6e5eed073babcec91409 ]

Internal touchscreen on Trogdor Pompom (AKA Dynabook Chromebook C1)
supports USI stylus. Unfortunately the HID descriptor for the stylus
interface does not contain "Stylus" physical collection, which makes
the kernel to try and pull battery information, resulting in errors.

Apply HID_BATTERY_QUIRK_AVOID_QUERY to the device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 72046039d1be7..0a4daff4846ff 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -427,6 +427,7 @@
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1	0x2BED
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2	0x2BEE
 #define I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG		0x2D02
+#define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c8b20d44b1472..e03d300d2bac4 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -411,6 +411,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{}
 };
 
-- 
2.43.0


