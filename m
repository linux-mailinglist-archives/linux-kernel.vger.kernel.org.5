Return-Path: <linux-kernel+bounces-37305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ACB83AE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C7628A00E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27507CF18;
	Wed, 24 Jan 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R6Wv1uFu"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74D7E584
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112680; cv=none; b=Iu0m6J3+b45mA2SX7VNhIy2qxBr5E0Dzv7B2BzoCYPIT2cdByKR1aXnaEwtoOY9+Tbr1TPTdQ0XKwgKB3m/zu9vJipQsRS6yYa+ds7cPT1m5agSC1bX9T1MCpxxY11qPjThrajBXo9kHY6btgaJrpN+dQjY86H9D6p4e53oZAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112680; c=relaxed/simple;
	bh=rmEWhlVDpeIv0NBvUoVUkcUuNtoCG83x6jLTykAx0mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bCP1+IMTDnBVIMqZRUXVTdaB5L1jrJPid2IfmVDHm/AdmsTA9dDogocIFqB7szreGMF0w9ijqZIYauFiOmu3Rn2Ud7Y0gDIq3/sQ2v8shWL7/8K4s02iwXVWR3iWLjTmWcllIS35ZBqNGXWc4M11svrq1dQgsVpjkf35SO+6Swc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R6Wv1uFu; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240124161116epoutp01aa98b5089f0c103b75268b67019b6781~tVHCt8q-C2165721657epoutp01t
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240124161116epoutp01aa98b5089f0c103b75268b67019b6781~tVHCt8q-C2165721657epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706112676;
	bh=KW0GPlc8JiP+I2GAgypKX/jwr3P9ZdZ55AOnVvit4IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6Wv1uFuIuD9sOD7K10nWZaqcfuJPpBTnNHXk2/9Qs7e/zcNh7XplNAoxXoM5eNyB
	 ogP45hwBWmOO5wSMSYKJnpqsa40lv+26AbqXDpKyIxBr7TYM0ZAr7KKN2aePzroMDn
	 TEmGbgGPzwX6v4+zqMDKevVtZrlyfsfqyJygNISU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240124161115epcas5p3211e75c97e58314bb598ccb8891f7656~tVHB91QF30932009320epcas5p31;
	Wed, 24 Jan 2024 16:11:15 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TKpq61Zm8z4x9Pq; Wed, 24 Jan
	2024 16:11:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.0A.19369.2A631B56; Thu, 25 Jan 2024 01:11:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161113epcas5p154500f0e71e1145e94f2779ca4c92948~tVG-3ajHo2561625616epcas5p1X;
	Wed, 24 Jan 2024 16:11:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240124161113epsmtrp2bb0a7c8374c6cfa1a0f324bd503ab9d7~tVG-2wPVK1827518275epsmtrp2S;
	Wed, 24 Jan 2024 16:11:13 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-72-65b136a2a0a1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.CA.18939.1A631B56; Thu, 25 Jan 2024 01:11:13 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161112epsmtip1e4a0213f489baa74271d04c50b80b157~tVG_a1XS21326113261epsmtip1f;
	Wed, 24 Jan 2024 16:11:12 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v3 2/6] HID: Samsung : Fix the
 checkpatch complain. Rewritten code using memcmp where applicable.
Date: Wed, 24 Jan 2024 21:40:24 +0530
Message-Id: <20240124161029.3756075-3-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124161029.3756075-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTXXeR2cZUg7lvOS2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xvmr/5kLTmpVTFp2g6WBcYtyFyMnh4SAicTWlZuYuhi5OIQE9jBKnJxy
	jB3C+cQosXjPARY459+ihSwwLf/XL4Kq2skocXTbNGYIp5NJ4tLmH0wgVWwCWhJ9R76D2SIC
	ERLvFmxiBLGZBa4zSjx4GAjSICzQxyjxe/sSsCIWAVWJRc27gMZycPAK2Ep8WGAAsU1eYv/B
	s8wgNqeAnUR/3z02EJtXQFDi5MwnLBAz5SWat84GO0JC4Cu7xOd/V5khml0kTnw7wghhC0u8
	Or6FHcKWkvj8bi8bREM3o8TS2xBfSwjMYJRo2QnTbS/x8/UENpCLmAU0Jdbv0ofYxifR+/sJ
	E0hYQoBXoqNNCKJaReJp125WmPnfT2yEKvGQONYaBBIWEpjIKDFvs9QERvlZSF6YheSFWQi7
	FjAyr2KUSi0ozk1PTTYtMNTNSy2HR21yfu4mRnDC1ArYwbh6w1+9Q4xMHIyHGCU4mJVEeE1M
	N6YK8aYkVlalFuXHF5XmpBYfYjQFhvFEZinR5Hxgys4riTc0sTQwMTMzM7E0NjNUEud93To3
	RUggPbEkNTs1tSC1CKaPiYNTqoEpy6YyJ0lpxTwDps2vjs+6GDO1Pf/Mr2mNLssmVV1tcvWO
	5eGpe9TAucXdndFb/mHz22mbnr96ev1/n6raea0HU+K1j0mZhQomLz+pvzwv+biryaQkN6Xb
	bxff9LwcF8n1dHZl7LUDfL7JPBViil9eewot5rH5xRDK4MJxePr8HLk8boum5sJlZkbNP9aZ
	xFffW/de+3HvJo4Lku4Shcbfbtp62KVZPX2aXxUsP2n3BCUpCeWJt8tZze4uXLd54UeT7+Hf
	zl9cbzP1cq7jMdNbLhstOPf8dXbc4tz39rBPqvncpYqrAzaF7q/bEaFz4IL0Af7e5dxnkp3a
	vJVabT+xi++QEr6jH1FbZfWTxUiJpTgj0VCLuag4EQB20EZoIQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnO5Cs42pBp+fqlpcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG+av/mQtOalVMWnaDpYFxi3IXIyeHhICJxP/1
	i9hBbCGB7YwSPZNqIeJSEquu32OEsIUlVv57DlTDBVTTziRx5lULK0iCTUBLou/IdyYQW0Qg
	QmLav7WMIEXMAvcZJbbuv8oG4ggL9DBKnHvRBlbFIqAqsah5F9AoDg5eAVuJDwsMIDbIS+w/
	eJYZxOYUsJPo77vHBnGRrcSe770sIDavgKDEyZlPwGxmoPrmrbOZJzAKzEKSmoUktYCRaRWj
	aGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcIBrBe1gXLb+r94hRiYOxkOMEhzMSiK8JqYbU4V4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYNL8rzl3vd0dm
	H0OFV4/hjzXMYvsuvajxCdVN+h0Qcj1Q9Os+8xWnFBY/MU0+FLtk/TmLGbOXuXB+PKF44PyP
	hB/6fwXNfHf8UZA0fWixKmWB2kNPkf5Pz461i+5PE62/JSHBNCXhjNJZfnvHeLOSFVGbPuyb
	ypPw90ddZVDERsaoOROqGW+6LnjF6uWyZZ3LN4aTNy8urRZ+35fCJlbR81Ex1/r6qUU8Mtw6
	QuYCktsvPdJhaH5yc7nuEYYEho+/K39te1Toe5qpTUD4k95Mmymsltxnf9kuyPg8sfvPH1f2
	1E7vn0Hq06bMq3z74Lvs71Ye5fzk3s6fdUY5mzKjPcz2a59J5HnWxTnDpvSuEktxRqKhFnNR
	cSIAnhA4Ut8CAAA=
X-CMS-MailID: 20240124161113epcas5p154500f0e71e1145e94f2779ca4c92948
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124161113epcas5p154500f0e71e1145e94f2779ca4c92948
References: <20240124161029.3756075-1-sandeep.cs@samsung.com>
	<CGME20240124161113epcas5p154500f0e71e1145e94f2779ca4c92948@epcas5p1.samsung.com>

Resolved warnings found by checkpatch.pl script.

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-samsung.c | 80 +++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 3a8756232731..97d0bf7d4d7e 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -58,33 +58,25 @@ static inline void samsung_irda_dev_trace(struct hid_device *hdev,
 static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	if (*rsize == 184 && rdesc[175] == 0x25 && rdesc[176] == 0x40 &&
-			rdesc[177] == 0x75 && rdesc[178] == 0x30 &&
-			rdesc[179] == 0x95 && rdesc[180] == 0x01 &&
+	if (*rsize == 184 && !memcmp(&rdesc[175], "\x25\x40\x75\x30\x95\x01", 6) &&
 			rdesc[182] == 0x40) {
 		samsung_irda_dev_trace(hdev, 184);
 		rdesc[176] = 0xff;
 		rdesc[178] = 0x08;
 		rdesc[180] = 0x06;
 		rdesc[182] = 0x42;
-	} else
-	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
-			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
+	} else if (*rsize == 203 && !memcmp(&rdesc[192], "\x15\x00\x25\x12", 4)) {
 		samsung_irda_dev_trace(hdev, 203);
-		rdesc[193] = 0x1;
-		rdesc[195] = 0xf;
-	} else
-	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
-			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
+		rdesc[193] = 0x01;
+		rdesc[195] = 0x0f;
+	} else if (*rsize == 135 && !memcmp(&rdesc[124], "\x15\x00\x25\x11", 4)) {
 		samsung_irda_dev_trace(hdev, 135);
-		rdesc[125] = 0x1;
-		rdesc[127] = 0xe;
-	} else
-	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
-			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
+		rdesc[125] = 0x01;
+		rdesc[127] = 0x0e;
+	} else if (*rsize == 171 && !memcmp(&rdesc[160], "\x15\x00\x25\x01", 4)) {
 		samsung_irda_dev_trace(hdev, 171);
-		rdesc[161] = 0x1;
-		rdesc[163] = 0x3;
+		rdesc[161] = 0x01;
+		rdesc[163] = 0x03;
 	}
 	return rdesc;
 }
@@ -99,7 +91,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 	unsigned short ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 
-	if (1 != ifnum || HID_UP_CONSUMER != (usage->hid & HID_USAGE_PAGE))
+	if (ifnum != 1 || HID_UP_CONSUMER != (usage->hid & HID_USAGE_PAGE))
 		return 0;
 
 	dbg_hid("samsung wireless keyboard/mouse input mapping event [0x%x]\n",
@@ -107,17 +99,39 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 
 	switch (usage->hid & HID_USAGE) {
 	/* report 2 */
-	case 0x183: samsung_kbd_mouse_map_key_clear(KEY_MEDIA); break;
-	case 0x195: samsung_kbd_mouse_map_key_clear(KEY_EMAIL);	break;
-	case 0x196: samsung_kbd_mouse_map_key_clear(KEY_CALC); break;
-	case 0x197: samsung_kbd_mouse_map_key_clear(KEY_COMPUTER); break;
-	case 0x22b: samsung_kbd_mouse_map_key_clear(KEY_SEARCH); break;
-	case 0x22c: samsung_kbd_mouse_map_key_clear(KEY_WWW); break;
-	case 0x22d: samsung_kbd_mouse_map_key_clear(KEY_BACK); break;
-	case 0x22e: samsung_kbd_mouse_map_key_clear(KEY_FORWARD); break;
-	case 0x22f: samsung_kbd_mouse_map_key_clear(KEY_FAVORITES); break;
-	case 0x230: samsung_kbd_mouse_map_key_clear(KEY_REFRESH); break;
-	case 0x231: samsung_kbd_mouse_map_key_clear(KEY_STOP); break;
+	case 0x183:
+		samsung_kbd_mouse_map_key_clear(KEY_MEDIA);
+		break;
+	case 0x195:
+		samsung_kbd_mouse_map_key_clear(KEY_EMAIL);
+		break;
+	case 0x196:
+		samsung_kbd_mouse_map_key_clear(KEY_CALC);
+		break;
+	case 0x197:
+		samsung_kbd_mouse_map_key_clear(KEY_COMPUTER);
+		break;
+	case 0x22b:
+		samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
+		break;
+	case 0x22c:
+		samsung_kbd_mouse_map_key_clear(KEY_WWW);
+		break;
+	case 0x22d:
+		samsung_kbd_mouse_map_key_clear(KEY_BACK);
+		break;
+	case 0x22e:
+		samsung_kbd_mouse_map_key_clear(KEY_FORWARD);
+		break;
+	case 0x22f:
+		samsung_kbd_mouse_map_key_clear(KEY_FAVORITES);
+		break;
+	case 0x230:
+		samsung_kbd_mouse_map_key_clear(KEY_REFRESH);
+		break;
+	case 0x231:
+		samsung_kbd_mouse_map_key_clear(KEY_STOP);
+		break;
 	default:
 		return 0;
 	}
@@ -128,7 +142,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product && hid_is_usb(hdev))
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE && hid_is_usb(hdev))
 		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
 	return rdesc;
 }
@@ -139,7 +153,7 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	int ret = 0;
 
-	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product && hid_is_usb(hdev))
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE && hid_is_usb(hdev))
 		ret = samsung_kbd_mouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
 
@@ -158,7 +172,7 @@ static int samsung_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product) {
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE) {
 		if (!hid_is_usb(hdev)) {
 			ret = -EINVAL;
 			goto err_free;
-- 
2.34.1


