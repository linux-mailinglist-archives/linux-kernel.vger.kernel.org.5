Return-Path: <linux-kernel+bounces-37310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42BF83AE18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0A2876E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989DD7E788;
	Wed, 24 Jan 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="naF+CmDy"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DDC80058
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112710; cv=none; b=ovTX6IBfZihbxb08JbdXprepnTSEUFCWm5U1GnZlpPjtRqD57QZ0Ykg34nzn8kjo9L+vJtmRJqI/VIYDReYyPqLD+w9+dUbmYbxu3nVj4+xwvxhRsne7d2uwMvnq+Evg8H/2QaHJ2C2MZXjf4I1U/iJ4Qr7KuPWaOnNXIFHy+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112710; c=relaxed/simple;
	bh=d4bsKmm/S0cNV+rPnLXkgJTdv/5usqe7TAF0r+e9VBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=cmGR2gD4H95WU5/gOIOtiLZfVoOao+0YBnaCBbjgXdHuK6fED54C8kwvCYl6kCJxhgRGpwiQEsgHIhd7DAPhayADuK4x5ck2oVwiBIm5VvuXQXuuBQAgR26tNAno8ttjWAwplAkAdENUiL0UyluRzQ7hxrKiAd0don3H7AEkSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=naF+CmDy; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240124161146epoutp04da9dc482dd0f9d55a7aeff2319a00562~tVHervRk92642826428epoutp04J
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240124161146epoutp04da9dc482dd0f9d55a7aeff2319a00562~tVHervRk92642826428epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706112706;
	bh=h8EqZYKtyKm8YLRUkquBdtpHYnrssIr8zIGAQ4rp3Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naF+CmDyo5iwxCLoK3eMWHLUASvl0NK8zthVT9jmhpQ+r0w+ZiElCY+AzFPOuY1pj
	 /Cm0eraSlbsrctSntxKoQXbyva7F+0plQ4SsZj1X5D/NVTfgkCW/oUgJx8/s4FsNFt
	 IpGFoh6aKO6f/sgAI7oUgYMuzrM4jDuq8u1slLJU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240124161145epcas5p46a1a72c03f970a81808f00b9ea17162d~tVHdhztvD1524215242epcas5p4w;
	Wed, 24 Jan 2024 16:11:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TKpqg5p5fz4x9Pr; Wed, 24 Jan
	2024 16:11:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.5F.09672.FB631B56; Thu, 25 Jan 2024 01:11:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240124161142epcas5p42fe248ea16530b66c617890bc495234b~tVHamGOpE1524115241epcas5p4r;
	Wed, 24 Jan 2024 16:11:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240124161142epsmtrp1643eaa5331301037219738476473db3f~tVHalc0vD1601516015epsmtrp1u;
	Wed, 24 Jan 2024 16:11:42 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-9c-65b136bf4e62
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.CA.18939.EB631B56; Thu, 25 Jan 2024 01:11:42 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161140epsmtip19fbb19c480d74e7e21c0c23dc83e1550~tVHZJwhzq1251112511epsmtip1m;
	Wed, 24 Jan 2024 16:11:40 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v3 6/6] HID: Samsung : Add
 Samsung wireless bookcover and universal keyboard support.
Date: Wed, 24 Jan 2024 21:40:28 +0530
Message-Id: <20240124161029.3756075-7-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124161029.3756075-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTU3e/2cZUg45lGhbXp2xmtbi9wNNi
	65K5rBa3jrcyWrx8sIHdYvPkRywWNz99Y7W4vGsOm0X77GeMFo9WbGJy4PLYtKqTzeP9vqts
	Hn1bVjF6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE7Y/72LqaCl4YVxx9+YGxg3K3ZxcjJISFgIjH74FvWLkYuDiGB3YwSU4/e
	YodwPjFKzDszA8Fpv/CFDaZl9YEXUImdjBIzPndA9XcySbS8PcUOUsUmoCXRd+Q7E4gtIhAh
	8W7BJkYQm1ngOqPEg4eBIA3CAk2MEkff7WQBSbAIqEpM3t7MCmLzCthK/L/xkAVinbzE/oNn
	mUFsTgE7if6+e2wQNYISJ2c+YYEYKi/RvHU2M8hQCYGv7BIbd6xkhWh2kVi2YBHUIGGJV8e3
	sEPYUhIv+9vYIRq6GSWW3j4G5cxglGjZeZUZospe4ufrCUDrOIBWaEqs36UPsY1Povf3EyaQ
	sIQAr0RHmxBEtYrE067drDDzv5/YyARhe0h8+zsf7GghgYmMEvv74yYwys9C8sMsJD/MQli2
	gJF5FaNkakFxbnpqsWmBcV5qOTxuk/NzNzGCU6aW9w7GRw8+6B1iZOJgPMQowcGsJMJrYrox
	VYg3JbGyKrUoP76oNCe1+BCjKTCQJzJLiSbnA5N2Xkm8oYmlgYmZmZmJpbGZoZI47+vWuSlC
	AumJJanZqakFqUUwfUwcnFINTGtObGA3vDU5ep6lRCWvr+rcU6tjBCTsbT89d9w4OaVIaprL
	nNb+mV+3R204OTu/5Y6LXu7JUxXbc8Tzj763Dl+jXZS1nKutfP6VjeZ1zpaO4YaaZ65Mf1Hu
	vSpY5ugzTffzDrv9lt45dVWis2TvV+XPsWdfx2VNXyXgnyrC33Q2QdnrfArP30V1hmIJItai
	9u3unh2vzyt/XmjUG1hw+fFkntmruI8xvnf12f/0yTbugKRjChqb5p5urGT6HDRJRejO1pMB
	bPc6wj+d2nrX6cU1lyk2F366PrS0c7urffalVenXTLMnq1JP3vlsXePj2P189czKE1Pnvpoc
	dU/ELNxy4TPlmNlS/kaH1j0PEFZiKc5INNRiLipOBACgoFZzIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSnO4+s42pBqfbRSyuT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlissmJTUnsyy1SN8ugStj/vYupoKXhhXHH35gbGDcrdnFyMkhIWAisfrA
	C/YuRi4OIYHtjBInHr9mg0hISay6fo8RwhaWWPnvOVRRO5PExw1vWEASbAJaEn1HvjOB2CIC
	ERLT/q1lBCliFrjPKLF1/1U2EEdYoIFRYt3Sz8wgVSwCqhKTtzezgti8ArYS/288ZIFYIS+x
	/+BZsBpOATuJ/r57YGcIAdXs+d7LAlEvKHFy5hMwmxmovnnrbOYJjAKzkKRmIUktYGRaxSia
	WlCcm56bXGCoV5yYW1yal66XnJ+7iREc5FpBOxiXrf+rd4iRiYPxEKMEB7OSCK+J6cZUId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6pBib34Afih4p/7dp+
	ZqK6/r3mRaed9CQnnfW/eaJAcs6JsxEMb+68LEx/vpPTrcquTPx04k8l9fN/WWda2/zhnbtO
	5MdWh7NzbI9OLttxKbvlwrLmPQtOiHZH7l3Ke+Wr6NdPbuId2y2XPdq2Zuv+yIfi7AmTZsbt
	tir47iZg+f76Si6WF5/FNn2avVF8x+aK9ifGVlr1XVf7F+9a2jN770l+tefLpkXICNyeur7s
	fMb7lRdNbqWHcxTXfp7VM+XCvkWfypYk7ImNvB3N1yvNWXXY7eanBSfeXJNx13l+NuaMbXj7
	rOZs1i0hc08x866Z/91YvMQgRPH95uTq+B5DYOqaeXVXXMeKebscorxO3HvYrcRSnJFoqMVc
	VJwIAH0XKKXhAgAA
X-CMS-MailID: 20240124161142epcas5p42fe248ea16530b66c617890bc495234b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124161142epcas5p42fe248ea16530b66c617890bc495234b
References: <20240124161029.3756075-1-sandeep.cs@samsung.com>
	<CGME20240124161142epcas5p42fe248ea16530b66c617890bc495234b@epcas5p4.samsung.com>

Add support for samsung wireless bookcover and universal keyboard with input mapping events.

Device a005 (Samsung wireless bookcover keyboard)
Device a006 (Samsung wireless universal keyboard)
Device a064 (Samsung wireless multi hogp keyboard)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
Signed-off-by: Gwangho Lee <gaudium.lee@samsung.com>
---
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-samsung.c | 142 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 43a990086225..e44a48b852fd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1149,6 +1149,9 @@
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE	0xa004
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_BOOKCOVER	0xa005
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD	0xa006
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD	0xa064
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index df0de72062b7..845768397036 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -357,6 +357,140 @@ static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
 	return 1;
 }
 
+static int samsung_universal_kbd_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	if (!(HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE) ||
+			HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)))
+		return 0;
+
+	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n",
+		usage->hid & HID_USAGE);
+
+	if (HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)) {
+		set_bit(EV_REP, hi->input->evbit);
+		switch (usage->hid & HID_USAGE) {
+		/* Only for UK keyboard */
+		/* key found */
+#ifdef CONFIG_HID_KK_UPGRADE
+		case 0x32:
+			samsung_kbd_mouse_map_key_clear(KEY_KBDILLUMTOGGLE);
+			break;
+		case 0x64:
+			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
+			break;
+#else
+		case 0x32:
+			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
+			break;
+		case 0x64:
+			samsung_kbd_mouse_map_key_clear(KEY_102ND);
+			break;
+#endif
+		/* Only for BR keyboard */
+		case 0x87:
+			samsung_kbd_mouse_map_key_clear(KEY_RO);
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
+		switch (usage->hid & HID_USAGE) {
+		/* report 2 */
+		/* MENU */
+		case 0x040:
+			samsung_kbd_mouse_map_key_clear(KEY_MENU);
+			break;
+		case 0x18a:
+			samsung_kbd_mouse_map_key_clear(KEY_MAIL);
+			break;
+		case 0x196:
+			samsung_kbd_mouse_map_key_clear(KEY_WWW);
+			break;
+		case 0x19e:
+			samsung_kbd_mouse_map_key_clear(KEY_SCREENLOCK);
+			break;
+		case 0x221:
+			samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
+			break;
+		case 0x223:
+			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
+			break;
+		/* RECENTAPPS */
+		case 0x301:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY1);
+			break;
+		/* APPLICATION */
+		case 0x302:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY2);
+			break;
+		/* Voice search */
+		case 0x305:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY4);
+			break;
+		/* QPANEL on/off */
+		case 0x306:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY5);
+			break;
+		/* SIP on/off */
+		case 0x307:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY3);
+			break;
+		/* LANG */
+		case 0x308:
+			samsung_kbd_mouse_map_key_clear(KEY_LANGUAGE);
+			break;
+		case 0x30a:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
+			break;
+		case 0x070:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
+			break;
+		case 0x30b:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
+			break;
+		case 0x06f:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
+			break;
+		/* S-Finder */
+		case 0x304:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY7);
+			break;
+		/* Screen Capture */
+		case 0x303:
+			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
+			break;
+		/* Multi Window */
+		case 0x309:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY9);
+			break;
+		/* HotKey App 1 */
+		case 0x071:
+			samsung_kbd_mouse_map_key_clear(0x2f5);
+			break;
+		/* HotKey App 2 */
+		case 0x072:
+			samsung_kbd_mouse_map_key_clear(0x2f6);
+			break;
+		/* HotKey App 3 */
+		case 0x073:
+			samsung_kbd_mouse_map_key_clear(0x2f7);
+			break;
+		/* Dex */
+		case 0x06e:
+			samsung_kbd_mouse_map_key_clear(0x2bd);
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
@@ -383,6 +517,12 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE)
 		ret = samsung_actionmouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD)
+		ret = samsung_universal_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD)
+		ret = samsung_universal_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -428,6 +568,8 @@ static const struct hid_device_id samsung_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


