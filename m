Return-Path: <linux-kernel+bounces-19263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363BB826A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA701C21D35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33F13ADD;
	Mon,  8 Jan 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mWxyJa3K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7311707
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240108092002epoutp0455b4e7167e0cea4e1175b766644b91a2~oVLakPAKg0595605956epoutp04z
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240108092002epoutp0455b4e7167e0cea4e1175b766644b91a2~oVLakPAKg0595605956epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704705602;
	bh=CpiTAUIjCffO8FsyEJ+Hs/0pW8pQa7U6hHyxRCcPq3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWxyJa3KneWp1vNqbvmW5ndnuIRCV8fiXqUeVdEVpXHQCwXO9FOZIDKUITWlLRxdd
	 PrK7lKthbI+4Vx/R8xhD+/rdm1eBAWw8Ex0k8flxtihUFiklY5RKJZwlvTBINYFzJP
	 S8LrOR6jFcXNd39pcB9khCvcUz/8G/TXdDpG0Bt4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240108092002epcas5p36ee1c90d1bb977c054ad1d3b71f2abc3~oVLaN3d2T0530905309epcas5p3K;
	Mon,  8 Jan 2024 09:20:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T7pS02932z4x9Q1; Mon,  8 Jan
	2024 09:20:00 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3B.3B.09634.04EBB956; Mon,  8 Jan 2024 18:20:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f~oVLX-fuBT0997409974epcas5p26;
	Mon,  8 Jan 2024 09:19:59 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240108091959epsmtrp12a170f12ee8ff622724e51edbe959e71~oVLX_BxSH1893518935epsmtrp1C;
	Mon,  8 Jan 2024 09:19:59 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-d6-659bbe40e2e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.A0.18939.F3EBB956; Mon,  8 Jan 2024 18:19:59 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240108091958epsmtip2983f17ab6845702dcc42be0caef7babb~oVLWi8qvW2117321173epsmtip2r;
	Mon,  8 Jan 2024 09:19:57 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v2 2/6] HID: Samsung : Fix the
 checkpatch complain.
Date: Mon,  8 Jan 2024 14:49:12 +0530
Message-Id: <20240108091917.1552013-3-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108091917.1552013-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTU9dh3+xUg+WtfBbXp2xmtbi9wNNi
	65K5rBa3jrcyWrx8sIHdYvPkRywWNz99Y7W4vGsOm0X77GeMFo9WbGJy4PLYtKqTzeP9vqts
	Hn1bVjF6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE749XVG2wFZ1QrmrevZ2lg3CTfxcjJISFgIjHxwWG2LkYuDiGB3YwSt89f
	Y4VwPjFKTLrXwwbndM6ZzwjTMvlwJ1RiJ6PExnVTmSCcTiaJfxsnMoNUsQloSfQd+c4EYosI
	REi8W7AJrJtZ4DqjxIOHgSC2sECCxN23q4D2cXCwCKhKLJwTAxLmFbCV+NvwhwlimbzE/oNn
	wUZyCthJbHuykQmiRlDi5MwnLBAj5SWat85mhqj/yS6x+Y44yEgJAReJ7r+VEGFhiVfHt7BD
	2FISL/vb2EFOlhDoZpRYevsYlDODUaJl51WoQfYSP19PYAMZxCygKbF+lz7ELj6J3t9PmCDm
	80p0tAlBVKtIPO3azQoz//uJjVDne0j8/7GCERI8ExklFi58wzqBUX4WkhdmIXlhFsK2BYzM
	qxglUwuKc9NTi00LDPNSy+ERm5yfu4kRnCy1PHcw3n3wQe8QIxMH4yFGCQ5mJRFeyRmzU4V4
	UxIrq1KL8uOLSnNSiw8xmgKDeCKzlGhyPjBd55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCe
	WJKanZpakFoE08fEwSnVwDQxh12r0qhXvEyAU/BrnPaKtNntPSm6fqHtBZuery4y/rpwVVzt
	5WJNK81eSx9h7gT9JqWOfb8ksuYWHtnk90X/EV+p0cXPH3fYGKVsPOJsvbxsaURRupaKHMuP
	iO23w1el2q39V79TMvdBkYG02PpfnlIOz4rveT4vYdx57OkZWcuIwOsx8WWO1d08oSvWOu0U
	rip5OauWXZrl9OyjjzUX7pyxSq4w3uCTSWyKjeTGGL+n/XZfWefkS2/s1DwTrhi8Y7WarDXr
	pw0TDmre6r0+OZl/yumuZE9+D7al51Tr5z7XmNOVsOvZlxLGE9zvEjdFL7jCbXhl1Q/FbfvM
	Je0eO6+vrDLczNWxaY6tEktxRqKhFnNRcSIAQYeCix8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvK79vtmpBlOOKlhcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGq6s32ArOqFY0b1/P0sC4Sb6LkZNDQsBEYvLh
	TrYuRi4OIYHtjBJtU/qYIRJSEquu32OEsIUlVv57zg5iCwm0M0n8+lgNYrMJaEn0HfnOBGKL
	CERITPu3lhFkELPAfUaJrfuvsoEkhAXiJG6+mczaxcjBwSKgKrFwTgxImFfAVuJvwx8miPny
	EvsPngXbyylgJ7HtyUYmiF22Ei+mfGOHqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKt
	YhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAgOb62gHYzL1v/VO8TIxMF4iFGCg1lJhFdyxuxU
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6pBqYZl1/a3Z28
	m1Ve/BL3X4/fj6r3fwjOcyxYF6W3JZex+75WV+Isy+DFu//5etp8d97JJGzH6xuebjrjzNRj
	W+/dOZuUf09I/B1nyZE787aJ7qqVfGGmVa9yYl51pybj83N9L+VXTEwqPp0o90XKMOI3n4uW
	y+49ZrlC31KS38vvnPjt8iW5fua5Z1wWVD4wv680K6nnfNfi3zos666n7uae9N+Yx37ug+bT
	ewqs8lx8Ujdpecko+TF/nnHf/nHK26U/ppTOdGJhS/hb7bpP9Z/b5pnmL5pyV95eynAmhcEp
	9dqj33O//uvqcPhgZ3NHmOlljo7lg1O3Fq9+GC4u0VX7a0PPjqNhTGrHI1xecN1VYinOSDTU
	Yi4qTgQAMs6Nyt4CAAA=
X-CMS-MailID: 20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	<CGME20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f@epcas5p2.samsung.com>

Warning found by checkpatch.pl script.

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-samsung.c | 61 +++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 885657531607..33cc92337394 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -67,20 +67,17 @@ static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		rdesc[178] = 0x08;
 		rdesc[180] = 0x06;
 		rdesc[182] = 0x42;
-	} else
-	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
+	} else if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
 			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
 		samsung_irda_dev_trace(hdev, 203);
 		rdesc[193] = 0x1;
 		rdesc[195] = 0xf;
-	} else
-	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
+	} else if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
 			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
 		samsung_irda_dev_trace(hdev, 135);
 		rdesc[125] = 0x1;
 		rdesc[127] = 0xe;
-	} else
-	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
+	} else if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
 			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
 		samsung_irda_dev_trace(hdev, 171);
 		rdesc[161] = 0x1;
@@ -99,7 +96,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 	unsigned short ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 
-	if (1 != ifnum || HID_UP_CONSUMER != (usage->hid & HID_USAGE_PAGE))
+	if (ifnum != 1 || HID_UP_CONSUMER != (usage->hid & HID_USAGE_PAGE))
 		return 0;
 
 	dbg_hid("samsung wireless keyboard/mouse input mapping event [0x%x]\n",
@@ -107,17 +104,39 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 
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
@@ -128,7 +147,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product  && hid_is_usb(hdev))
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE && hid_is_usb(hdev))
 		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
 	return rdesc;
 }
@@ -139,7 +158,7 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	int ret = 0;
 
-	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product  && hid_is_usb(hdev))
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE && hid_is_usb(hdev))
 		ret = samsung_kbd_mouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
 
@@ -158,7 +177,7 @@ static int samsung_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product) {
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE) {
 		if (!hid_is_usb(hdev)) {
 			ret = -EINVAL;
 			goto err_free;
-- 
2.34.1


