Return-Path: <linux-kernel+bounces-37948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E602B83B8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902D2B23F91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952811181;
	Thu, 25 Jan 2024 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tYXXNZDI"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72010A37
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157440; cv=none; b=laHDAdtw2NbrcvV6P/8dOFBFz5ihMzTmiQ2sRt8m4lB/9HL2lG8kg1+jq5cuGngn4VzFb1oSb+zHYP1buLMnZmMr/CXVV5LNC5HAZve+qtPehNhDjsIyJmTVbtbKTA7rAwyi/Udrr62Rq4Y0ihHPk4U7b1xw0xM05oChTmkIt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157440; c=relaxed/simple;
	bh=RErscL7igkrg2TYIr7QQtxltUVjpmwgtImO9C3vZ9Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=eUDJmyoABTwsfr/JDiq+1WpK4ZDgmcpXotR3fh3TQOHOeLpJzjIJj8MwgtMXxKUQFo46pGKoqdpDU9WNhr5e/ka1mVaWc59wiO3uXks44KSRBwCwv64DrhjxM3rsupqrNzW6dBprZChWRVNQzBWLFvJu6ZS7PgV+DvxN2/mwtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tYXXNZDI; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240125043717epoutp02a0f96c656444371a62b7eb78bfcc3417~tfSZDVbI_2235522355epoutp02k
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240125043717epoutp02a0f96c656444371a62b7eb78bfcc3417~tfSZDVbI_2235522355epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706157437;
	bh=583dwtAg42kW3WOPS9CCwl4vBTavsqUFWB6XNKTada0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYXXNZDIYaG1XboogKFhSSE7iTclOPeTqJvhvFuSfepxj441olb4pOgoGh8H+oMhW
	 vKWkL+RiaC0WbCDVCan3RCSSFLObIhPzUouTTAgtlkW1L64recbVDZQSE987YQ8mEf
	 hy8+/vXAeauADsOM9NTKNaCgiZrgoQ8RGPYo6EUo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240125043716epcas5p33b5d3658e2bdbfb887490edcc47c2e10~tfSYsQuIt0575905759epcas5p3R;
	Thu, 25 Jan 2024 04:37:16 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TL7Mt0RXYz4x9Pr; Thu, 25 Jan
	2024 04:37:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.F8.19369.975E1B56; Thu, 25 Jan 2024 13:37:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043713epcas5p29fff47db75cec104be21265031128bf4~tfSVx4n4l2130721307epcas5p2O;
	Thu, 25 Jan 2024 04:37:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125043713epsmtrp10026edf8a58e9d9b74d3917b28230df6~tfSVxN4x41631016310epsmtrp1X;
	Thu, 25 Jan 2024 04:37:13 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-50-65b1e5799684
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.E4.08755.975E1B56; Thu, 25 Jan 2024 13:37:13 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043711epsmtip233a5e95300e7a8e99d757091c4adc099~tfSUQ5n_x2197421974epsmtip21;
	Thu, 25 Jan 2024 04:37:11 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v4 3/6] HID: Samsung : Add
 Samsung wireless keyboard support.
Date: Thu, 25 Jan 2024 10:06:26 +0530
Message-Id: <20240125043630.4031634-4-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125043630.4031634-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmum7l042pBleOWVpcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
	i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
	1BIrQwMDI1OgwoTsjCkTnjIVfFCpuLa7k62B8bhcFyMnh4SAicSKW3NYuxi5OIQE9jBKnFq/
	iQ3C+cQocWDufijnG6PExRlX2GBaDt2awAiR2MsosXTVL3YIp5NJ4uHSmewgVWwCWhJ9R74z
	gdgiAhES7xZsYgSxmQWuM0o8eBgIYgsLZEl8+vGGGcRmEVCV+PvlK1gNr4CtxNtPfawQ2+Ql
	9h88C1bDKWAn0bf0DRNEjaDEyZlPWCBmyks0b53NDHKEhMBPdomn/V1Qp7pILLy+GmqQsMSr
	41vYIWwpiZf9bewQDd1AL9w+BuXMYJRo2XmVGaLKXuLn6wlAkziAVmhKrN+lD7GNT6L39xMm
	kLCEAK9ER5sQRLWKxNOu3aww87+f2MgEYXtIHLx8ABpCExkl/hzawTSBUX4WkidmIXliFsK2
	BYzMqxilUguKc9NTk00LDHXzUsvhkZucn7uJEZw0tQJ2MK7e8FfvECMTB+MhRgkOZiURXhPT
	jalCvCmJlVWpRfnxRaU5qcWHGE2BwTyRWUo0OR+YtvNK4g1NLA1MzMzMTCyNzQyVxHlft85N
	ERJITyxJzU5NLUgtgulj4uCUamCq37e8rf6botPZSTylh9WU/VP9/fcLXpbnPuF49UjcPz7H
	E5ZnFT8FZVdWxfhrlls+NJu/qoKtMoex6MuEzG2STxZ57bvK5xgbXFWptX1VbJt2C0/+yf1e
	/SfNPHdaL8iP+tBhOEHx9aeatJtt0T5Nu21eKOpu9Ti87vak+gcF9xSsjRlkLvjbzzoeGp63
	RJKJc6b1t4a0g0JMjmI+7eX81iEzBJyNnbw2vslYarmtaOYCJ/PcuSLyZYyHBPn2iVRP+6mf
	p565aO3Xla23Th4xYXuWcTWBie+x06eUmAey+V2fw77ocAtqiE5fdd1uSW/5ca1t19r+ynwr
	iGDcO2GzxqUD/y7H9P+9nRGrqsRSnJFoqMVcVJwIAO81IEkjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvG7l042pBq9my1tcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGlAlPmQo+qFRc293J1sB4XK6LkZNDQsBE4tCt
	CYxdjFwcQgK7GSUmN7WyQySkJFZdv8cIYQtLrPz3nB2iqJ1J4u3KHiaQBJuAlkTfke9gtohA
	hMS0f2vBJjEL3GeU2Lr/KlsXIweHsECGxIVP6iA1LAKqEn+/fAUbyitgK/H2Ux8rxAJ5if0H
	zzKD2JwCdhJ9S9+AzRQCqrn/ZjYrRL2gxMmZT1hAbGag+uats5knMArMQpKahSS1gJFpFaNk
	akFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcKBrae5g3L7qg94hRiYOxkOMEhzMSiK8JqYb
	U4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwOXy+c+Xd
	a+VNX9avWbI49K/ZKq2w8rvKx6NDDj7llXZ/o/4uttuU0/t6np8072PNbRcWPGUKkZSXL5v4
	7J798tT610mfZomdWbV+f0dk3qO+GMnY71/XOzXW6F/N1tbmipLZvWLJ9LnTY3qydp3Zp+eX
	23Ollf9voCXXge8Tek23u/wRWLP9Qv6Xktzf26aprcv9GnHYtGrG3w3+RZ9q3PdFl7Vcf+aT
	NKc7I5VJKPYf46WtyQz+9QZiLpczdQxXrfzqzNZ5QPJS0SeLaT525/N/s0w9x3dcsnbNnlwm
	90sGXldXXZxx9qdp9bOcmgCnBz82GwgtX7Cf+R8X86xo+4CjgWXVqz9nqT1knLPOV4mlOCPR
	UIu5qDgRAPbWfUrjAgAA
X-CMS-MailID: 20240125043713epcas5p29fff47db75cec104be21265031128bf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043713epcas5p29fff47db75cec104be21265031128bf4
References: <20240125043630.4031634-1-sandeep.cs@samsung.com>
	<CGME20240125043713epcas5p29fff47db75cec104be21265031128bf4@epcas5p2.samsung.com>

Add Support for samsung wireless keyboard with input mapping events.

Device 7021 (Samsung wireless keyboard)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-ids.h     |  2 +
 drivers/hid/hid-samsung.c | 97 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index fb30e228d35f..d7572ab5ea6c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1143,8 +1143,10 @@
 #define USB_DEVICE_ID_SAITEK_X65	0x0b6a
 
 #define USB_VENDOR_ID_SAMSUNG		0x0419
+#define USB_VENDOR_ID_SAMSUNG_ELECTRONICS		0x04e8
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 97d0bf7d4d7e..aa8e7805be76 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -139,6 +139,99 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 	return 1;
 }
 
+static int samsung_kbd_input_mapping(struct hid_device *hdev,
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
+		case 0x32:
+			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
+			break;
+		case 0x64:
+			samsung_kbd_mouse_map_key_clear(KEY_102ND);
+			break;
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
+		/* Smtart Voice Key */
+		case 0x300:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY13);
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
+		case 0x30b:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
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
@@ -156,6 +249,9 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE && hid_is_usb(hdev))
 		ret = samsung_kbd_mouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD)
+		ret = samsung_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -198,6 +294,7 @@ static int samsung_probe(struct hid_device *hdev,
 static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


