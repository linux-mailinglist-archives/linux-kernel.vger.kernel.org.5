Return-Path: <linux-kernel+bounces-37307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B483AE50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905A2B2EA82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1417E775;
	Wed, 24 Jan 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dDp7CwBk"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD27CF37
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112695; cv=none; b=EaGUk3bjsvI55UVG/LLxTx9IkVkV4TW3A7gDPJzFSh+PUa7aFHyxoZPZTYA0tKmM9K/bBecDdH5rSgytRjsGSGoZzMT6IsfiRyYt6ftjKVi0sm4IpU/WqoMbFg+V4cVp+D7gMdJ5R2J37tWPhfKUVRN9tjDViX8UzniF5UxCAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112695; c=relaxed/simple;
	bh=7li+Hxsf+wL83uj3m0Pitx9JVztk/Cqvbj3cMlBFK2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qv1r5dhptgs3t3kcKIFUAShi0h+0HIx0rCT/S0nGVlsuBf/4vlbqZ8bNH3rcSua/0kkIZGsEEI9Lwj29Q/iiJ9iuDPhct+y9ujtz/gjkk39Fa0iFM6ksiQFvBV/kDCDMdctLRXSXWYfhjPX3VBE/3hqErcr0RpblM/RvIU+bgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dDp7CwBk; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240124161131epoutp026931a678f553cd241a44e49396492044~tVHQ3k06Q0910909109epoutp02A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240124161131epoutp026931a678f553cd241a44e49396492044~tVHQ3k06Q0910909109epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706112692;
	bh=Ni46Nkp7ayqbORI9e18qVq1HTZEdKxuftPhx9y5VuYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDp7CwBkpD7pm7i7HeCQCME8TOjxHVp1YsuuqcgEkFkNmYZzsnKj4gVVRlFFgdI/J
	 UlDWSte+kbnYCxMfCjBdPM5bj54ORcS3IJ/NJuZLUorZhS0hAi6/yBsguTzN7LFGtZ
	 /UkoSYkym4lFJBwHyxrMrBFCUnmks3RBREhMxgOI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240124161130epcas5p102eed728f947436409e7f25dc4b4ac31~tVHP1_J_B2558925589epcas5p1X;
	Wed, 24 Jan 2024 16:11:30 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TKpqP15Fmz4x9Pt; Wed, 24 Jan
	2024 16:11:29 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.0A.19369.0B631B56; Thu, 25 Jan 2024 01:11:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240124161128epcas5p38a703fcedbacb6e506d9c46579b07b04~tVHNtd1DY0931509315epcas5p37;
	Wed, 24 Jan 2024 16:11:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240124161128epsmtrp2f660edcd2b84eb01603db197db250fd9~tVHNsxdCm1827518275epsmtrp2T;
	Wed, 24 Jan 2024 16:11:28 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-85-65b136b01996
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.34.08755.0B631B56; Thu, 25 Jan 2024 01:11:28 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161126epsmtip116dc2461168747e5797d574a12225c27~tVHMPFWAf1251112511epsmtip1k;
	Wed, 24 Jan 2024 16:11:26 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v3 4/6] HID: Samsung : Add
 Samsung wireless gamepad support.
Date: Wed, 24 Jan 2024 21:40:26 +0530
Message-Id: <20240124161029.3756075-5-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124161029.3756075-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTXXej2cZUg/WKFtenbGa1uL3A02Lr
	krmsFreOtzJavHywgd1i8+RHLBY3P31jtbi8aw6bRfvsZ4wWj1ZsYnLg8ti0qpPN4/2+q2we
	fVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
	E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
	xMrQwMDIFKgwITtj/yTeghPKFU/v32BuYDwu28XIySEhYCJxbfsK5i5GLg4hgT2MEqcmrWAB
	SQgJfGKUWLRSFSLxjVFiZt93dpiOs+/72CESexklJnfMZ4Po6GSS6PucCmKzCWhJ9B35zgRi
	iwhESLxbsIkRxGYWuM4o8eBhYBcjB4ewQKbEg1lmIGEWAVWJj3c/gZXzCthKzF38gAlil7zE
	/oNnmUFsTgE7if6+e2wQNYISJ2c+YYEYKS/RvHU2M0T9V3aJo3/5IWwXiZlHe1ggbGGJV8e3
	QN0vJfH53V42kPslBLoZJZbePsYO4cxglGjZeRVqkr3Ez9cT2EAOZRbQlFi/Sx9iGZ9E7+8n
	TCBhCQFeiY42IYhqFYmnXbtZYeZ/P7ER6n4Pic2H5zFCwmoio8TENXdZJjDKz0LywywkP8xC
	2LaAkXkVo1RqQXFuemqyaYGhbl5qOTxek/NzNzGCE6VWwA7G1Rv+6h1iZOJgPMQowcGsJMJr
	YroxVYg3JbGyKrUoP76oNCe1+BCjKTCUJzJLiSbnA1N1Xkm8oYmlgYmZmZmJpbGZoZI47+vW
	uSlCAumJJanZqakFqUUwfUwcnFINTP4tTA8qty6JnddkJntvt+bJCL0OiwOGhnsYvn7blPPl
	6VYb3Y+TAh/47zeYMHnqCUPP+y/5rzEs1nuvxOayw3XLyz7v2AscE4zbOrysTjBL7zz4mqFj
	MbfpVckdU28vFjC3vnR8bWBhkn3okX/XJB7XPFjTzpl3UcVo9TK1VLlJlZ+k9pRq17c25QoH
	izw7eC2pU8Cg6bXPFvdLi29+eu8m0mFWOGMyy9qbs97crHg7O9Q+nc1CJsu2ZEvxXeYYY++5
	G2SrLeRq3xS+tvn3z2oBx8TWqalvE1YeNT36b/Od6yU/7CSqn7YkrlYJvb+b7cl1u51OxZyf
	Q/zLhOJ/6D97F3lBY8ns/5sOhXFOalBiKc5INNRiLipOBABTXUhcHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnO4Gs42pBv8eSVtcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG/km8BSeUK57ev8HcwHhctouRk0NCwETi7Ps+
	9i5GLg4hgd2MEs9vHGaHSEhJrLp+jxHCFpZY+e85VFE7k8TJ5+vAEmwCWhJ9R74zgdgiAhES
	0/6tZQQpYha4zyixdf9VNpCEsEC6xLYJLWBFLAKqEh/vfgKzeQVsJeYufsAEsUFeYv/Bs8wg
	NqeAnUR/3z2wXiGgmj3fe1kg6gUlTs58AmYzA9U3b53NPIFRYBaS1CwkqQWMTKsYJVMLinPT
	c4sNCwzzUsv1ihNzi0vz0vWS83M3MYIDXUtzB+P2VR/0DjEycTAeYpTgYFYS4TUx3ZgqxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgUnP7IZMBdv8O9yG
	RXetNeSuNtrcs2LZZz3t73+7Yv0FXhJLjPPy1aerRq6WvlSyTmJ1hzUTW/LMun1bljfelpae
	u/L4ro/Ldk7QMNayXvzp5U//JSwGMgonFmZaMZQJ+EzufvlfZvONnbM3Mu6xzp0m2+L9dIHV
	8Tj2XydnPboX8srRsim/t3O57Gex8FbOuOTH4Rc+T5z1UvfllCrja7kLn2UZnar+u8dg/fV0
	jb8rzIJjD0Qz86R9OvTNd8GC2bwzXTT5Pj8+cPxi5ONk5poLKpxGS+ZP0T4Y3hj6e9LyHwnX
	jrx3MtFTX7ledOody2IGdrFlBWrdu16onHn9rswyqdJYwSu944uyurXtukdKLMUZiYZazEXF
	iQDMYVLs4wIAAA==
X-CMS-MailID: 20240124161128epcas5p38a703fcedbacb6e506d9c46579b07b04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124161128epcas5p38a703fcedbacb6e506d9c46579b07b04
References: <20240124161029.3756075-1-sandeep.cs@samsung.com>
	<CGME20240124161128epcas5p38a703fcedbacb6e506d9c46579b07b04@epcas5p3.samsung.com>

Add support for samsung wireless gamepad with input mapping events.

Device a000 (Samsung wireless gamepad)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-ids.h     |  1 +
 drivers/hid/hid-samsung.c | 95 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c4a2490a6496..621853b21923 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1147,6 +1147,7 @@
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index cec532be987a..b786888ec077 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -243,6 +243,97 @@ static int samsung_kbd_input_mapping(struct hid_device *hdev,
 	return 1;
 }
 
+static int samsung_gamepad_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	if (!(HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE) ||
+			HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)))
+		return 0;
+
+	dbg_hid("samsung wireless gamepad input mapping event [0x%x], %ld, %ld, [0x%x]\n",
+		usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0], usage->hid & HID_USAGE_PAGE);
+
+	if (HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE)) {
+		switch (usage->hid & HID_USAGE) {
+		case 0x01:
+			samsung_kbd_mouse_map_key_clear(BTN_A);
+			break;
+		case 0x02:
+			samsung_kbd_mouse_map_key_clear(BTN_B);
+			break;
+		case 0x03:
+			samsung_kbd_mouse_map_key_clear(BTN_C);
+			break;
+		case 0x04:
+			samsung_kbd_mouse_map_key_clear(BTN_X);
+			break;
+		case 0x05:
+			samsung_kbd_mouse_map_key_clear(BTN_Y);
+			break;
+		case 0x06:
+			samsung_kbd_mouse_map_key_clear(BTN_Z);
+			break;
+		case 0x07:
+			samsung_kbd_mouse_map_key_clear(BTN_TL);
+			break;
+		case 0x08:
+			samsung_kbd_mouse_map_key_clear(BTN_TR);
+			break;
+		case 0x09:
+			samsung_kbd_mouse_map_key_clear(BTN_TL2);
+			break;
+		case 0x0a:
+			samsung_kbd_mouse_map_key_clear(BTN_TR2);
+			break;
+		case 0x0b:
+			samsung_kbd_mouse_map_key_clear(BTN_SELECT);
+			break;
+		case 0x0c:
+			samsung_kbd_mouse_map_key_clear(BTN_START);
+			break;
+		case 0x0d:
+			samsung_kbd_mouse_map_key_clear(BTN_MODE);
+			break;
+		case 0x0e:
+			samsung_kbd_mouse_map_key_clear(BTN_THUMBL);
+			break;
+		case 0x0f:
+			samsung_kbd_mouse_map_key_clear(BTN_THUMBR);
+			break;
+		case 0x10:
+			samsung_kbd_mouse_map_key_clear(0x13f);
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
+		switch (usage->hid & HID_USAGE) {
+		case 0x040:
+			samsung_kbd_mouse_map_key_clear(KEY_MENU);
+			break;
+		case 0x223:
+			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
+			break;
+		case 0x224:
+			samsung_kbd_mouse_map_key_clear(KEY_BACK);
+			break;
+
+		/* Screen Capture */
+		case 0x303:
+			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
+			break;
+
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
@@ -263,6 +354,9 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD)
 		ret = samsung_kbd_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
+		ret = samsung_gamepad_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -306,6 +400,7 @@ static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


