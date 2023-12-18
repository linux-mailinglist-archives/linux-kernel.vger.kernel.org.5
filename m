Return-Path: <linux-kernel+bounces-3606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C66816E58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA8F1F247BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2501396FA;
	Mon, 18 Dec 2023 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOofPSKi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA383B04;
	Mon, 18 Dec 2023 12:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA5BC433C7;
	Mon, 18 Dec 2023 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903466;
	bh=RoYQ+Ptszx7ik1lC1pQDKGAUjmuzsKC1juVKnHgxrrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOofPSKiCHCk+wttNhCZkjPmfJRmUlfEfxRQzxIB3DWhdrxJQSE3K+Eeg0EYxhiC5
	 A+HK10BuXuEit6/2+LkVv+MBYmROdtpL2UwAdHWO5imgjhPaFqdJQurWSpAtrnTpmS
	 q8CU7kxddPZ97Ti+tlILolUAfqD4eh8SMTY+wKIj9F2P8Sdm55GsdExsHDkHHBxp0q
	 GlFufgjTTo8v2WyAGaxtc2mrM6fcFuA6gj+x6l6ZDpNHVFMp7e5ezKYqoTr6dmjN3k
	 JsfMDAAabg0L82GdXtJ3WuGPtrQchXUq5mkEzS7Kxsmika/cDXOsOuhHc17HuCtvFn
	 y1sxAAjW6v3BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Parschauer <s.parschauer@gmx.de>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/18] HID: Add quirk for Labtec/ODDOR/aikeec handbrake
Date: Mon, 18 Dec 2023 07:43:40 -0500
Message-ID: <20231218124415.1379060-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124415.1379060-1-sashal@kernel.org>
References: <20231218124415.1379060-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.7
Content-Transfer-Encoding: 8bit

From: Sebastian Parschauer <s.parschauer@gmx.de>

[ Upstream commit 31e52523267faab5ed8569b9d5c22c9a2283872f ]

This device needs ALWAYS_POLL quirk, otherwise it keeps reconnecting
indefinitely. It is a handbrake for sim racing detected as joystick.
Reported and tested by GitHub user N0th1ngM4tt3rs.

Link: https://github.com/sriemer/fix-linux-mouse issue 22
Signed-off-by: Sebastian Parschauer <s.parschauer@gmx.de>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d10ccfa17e168..97ab317570dd3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -744,6 +744,7 @@
 
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
+#define USB_DEVICE_ID_LABTEC_ODDOR_HANDBRAKE	0x8888
 
 #define USB_VENDOR_ID_LCPOWER		0x1241
 #define USB_DEVICE_ID_LCPOWER_LC1000	0xf767
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 5a48fcaa32f00..d9a4f8f7bbb07 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -120,6 +120,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406XE), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_T609A), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_ODDOR_HANDBRAKE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019), HID_QUIRK_ALWAYS_POLL },
-- 
2.43.0


