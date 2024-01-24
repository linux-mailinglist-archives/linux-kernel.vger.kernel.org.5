Return-Path: <linux-kernel+bounces-37306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81E83AE26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E4AB2E899
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378AC7E584;
	Wed, 24 Jan 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sS979LcI"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FB7E596
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112688; cv=none; b=jK9bO8ZzVnOtQu4U4sO+Vw2td+k3jTmKaUuHskzmdaU4FsrfGhs7RNW+hkzqv11e+wLJlUQRKtc6MWQlw3Kn1e3CPnnl+HG8srMR7LICx2JQzlTpgDHwCJEKGJxO8CiJGDYO/596SNZKoY2j7GoyqmfGNUJK+nJaAsQpkko0YgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112688; c=relaxed/simple;
	bh=gjb6UzmphU1fLW4iK3dWmvcJQoG7enxLnp+wvNbqm3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Lkq38QwdDrGYNSgzHAa+iRzdhn9m0dZZDeXjz7AkEqjpygLqVi/OSys4g52MVZZ5fo12R6aHQYgoR9YbH2eSJph0itcDpwkWnZ3nRqomkhccFB67TH7c4LoShKxdZui521q2ehiyJ0R4v1rEZdxZfYxZ+f0FvujfgeKeuw96AhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sS979LcI; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240124161123epoutp03d08ef7b18f2157a8d095df8a82ed3ef7~tVHJayXT_2126421264epoutp03k
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240124161123epoutp03d08ef7b18f2157a8d095df8a82ed3ef7~tVHJayXT_2126421264epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706112684;
	bh=YYocl0PZ0LFHH8dX+SfcttbxYw4fewhczxNV2KWMvIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sS979LcIU8h4haHdcEZOSICVFbisg3Q75qZzIF7TIXepvyPaxZaLCucrO62qZziXp
	 5LwjriPjN8FHlCIkWCFCZP5epLhans4Z+bXUqhSeQbgBr0iMUMNS/HLGrS/XZg/9fF
	 MbxVA8KRDBBkwr88LHz3wIx/36jhn9i2HwNjfAB4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240124161123epcas5p23f0817e17010ca8d48bb9799ffb31283~tVHJKcrUx0408404084epcas5p2A;
	Wed, 24 Jan 2024 16:11:23 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TKpqF6v3rz4x9Pt; Wed, 24 Jan
	2024 16:11:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.8A.08567.9A631B56; Thu, 25 Jan 2024 01:11:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161121epcas5p1fef1a14624b26cc436b899d9f6cde164~tVHHA8l6K2559125591epcas5p1a;
	Wed, 24 Jan 2024 16:11:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240124161121epsmtrp18e1a76e1639d887a9cb297145dd58c22~tVHHASwZ41601516015epsmtrp1o;
	Wed, 24 Jan 2024 16:11:21 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-64-65b136a9a4da
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.34.08755.9A631B56; Thu, 25 Jan 2024 01:11:21 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161119epsmtip1f679da7e4d53e86adf1237a5da5ed17a~tVHFlh_P71251112511epsmtip1j;
	Wed, 24 Jan 2024 16:11:19 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v3 3/6] HID: Samsung : Add
 Samsung wireless keyboard support.
Date: Wed, 24 Jan 2024 21:40:25 +0530
Message-Id: <20240124161029.3756075-4-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124161029.3756075-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTU3el2cZUg4szTSyuT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2Ru+eJ2wFf9Qqvl/YyNbAOEehi5GDQ0LARGLKbcEuRi4OIYHdjBJv9y5g
	gXA+MUpsXvuXHcL5xihx5s97pi5GTrCOidd6oRJ7GSUm925ihXA6mSQ+zpjLAlLFJqAl0Xfk
	O1iHiECExLsFmxhBbGaB64wSDx4GgtjCAlkSP5bfZgOxWQRUJbZtXQJm8wrYShzfsJ8RYpu8
	xP6DZ5lBbE4BO4n+vntQNYISJ2c+YYGYKS/RvHU2M0T9R3aJ30e5IWwXiXVHT7NC2MISr45v
	YYewpSRe9reBfSAh0M0osfT2MShnBqNEy86rUJPsJX6+nsAGCiVmAU2J9bv0IZbxSfT+fsIE
	CTxeiY42IYhqFYmnXbtZYeZ/P7ERGloeEmtnHgCbKCQwkVHi8n2LCYzys5C8MAvJC7MQli1g
	ZF7FKJlaUJybnppsWmCYl1oOj9jk/NxNjOBkqeWyg/HG/H96hxiZOBgPMUpwMCuJ8JqYbkwV
	4k1JrKxKLcqPLyrNSS0+xGgKDOOJzFKiyfnAdJ1XEm9oYmlgYmZmZmJpbGaoJM77unVuipBA
	emJJanZqakFqEUwfEwenVAPToeVKNStmTPLr4zE8cuuq9cWPz4/4luXsPWTZxRHRkGQZzNu8
	8WnG7uwzKcqrxAurEspWiTzIiGAXvnSsNOsk23Lfgg9GD9+6fz7j7cj2znrrnBimoluNV24s
	XafNF8VbKWLxO39JVMbplz9Y/ucw3jR/Nn2PxP+MuOK383hk31xq39lZ6OH/75a32x3N5XdW
	5IhZ/Pu8rsBsqc+DJ37ve7O2pv/KsG+2UN/baPL5iejakGNtDG6J7hqfdq/2tTpxLkR2drnU
	1fcTb7Gx5l9tDWkryHLi43Xklvm75cBls1tcH+IiLXU6bMT2R637/NBoyatnabXOlnq3L0ms
	tlqSv3VB+xbnAkWeFSfPJz5QYinOSDTUYi4qTgQAqAiI5h8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO5Ks42pBn9XCVtcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAldG754nbAV/1Cq+X9jI1sA4R6GLkZNDQsBEYuK1
	XvYuRi4OIYHdjBJNr78wQSSkJFZdv8cIYQtLrPz3HKqonUni9ZEesCI2AS2JviPfwWwRgQiJ
	af/WMoIUMQvcZ5TYuv8qG0hCWCBD4s+LTjCbRUBVYtvWJWA2r4CtxPEN+6E2yEvsP3iWGcTm
	FLCT6O+7B1YjBFSz53svC0S9oMTJmU/AbGag+uats5knMArMQpKahSS1gJFpFaNkakFxbnpu
	sWGBYV5quV5xYm5xaV66XnJ+7iZGcKhrae5g3L7qg94hRiYOxkOMEhzMSiK8JqYbU4V4UxIr
	q1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwLbVxtZ09i0ef03Pp
	0s4yg3SWkkUHfP3YLI6VOm88HZrs+frLJa8/B/6JBYQvn/V1ZaiX1qQd4r6/9X9fcLiQat77
	dt6zvvj7KQetDnw0Sc02FNuZ/3dDXPIp3cIvb6aHsoTMt9Pb9rwjcqtmaca8xvqfRyYzztF9
	ErP3sOS7H4fEl7Cqbw182Xi1S1v1XqSdrfvyLw57S2Sq7x4PqE63yl09//USfe/Uy/y/05dy
	xGTffZqz65dPhsmW6sgZByeozuLniXpm1birxNQj+bf5z0uM06NY9t9c+ed8nMlzqbq9nxUn
	V75zWpZf9eo0n9Y0j99JAXvmOka+vFS51DfjrZH7z2/a5s7ru7vfvn0WqcRSnJFoqMVcVJwI
	AM9Bp+vkAgAA
X-CMS-MailID: 20240124161121epcas5p1fef1a14624b26cc436b899d9f6cde164
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124161121epcas5p1fef1a14624b26cc436b899d9f6cde164
References: <20240124161029.3756075-1-sandeep.cs@samsung.com>
	<CGME20240124161121epcas5p1fef1a14624b26cc436b899d9f6cde164@epcas5p1.samsung.com>

Add Support for samsung wireless keyboard with input mapping events.

Device 7021 (Samsung wireless keyboard)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-ids.h     |   2 +
 drivers/hid/hid-samsung.c | 108 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index fb30e228d35f..c4a2490a6496 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1143,8 +1143,10 @@
 #define USB_DEVICE_ID_SAITEK_X65	0x0b6a
 
 #define USB_VENDOR_ID_SAMSUNG		0x0419
+#define USB_VENDOR_ID_SAMSUNG_ELECTRONICS   0x04e8
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 97d0bf7d4d7e..cec532be987a 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -139,6 +139,110 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
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
@@ -156,6 +260,9 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE && hid_is_usb(hdev))
 		ret = samsung_kbd_mouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD)
+		ret = samsung_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -198,6 +305,7 @@ static int samsung_probe(struct hid_device *hdev,
 static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


