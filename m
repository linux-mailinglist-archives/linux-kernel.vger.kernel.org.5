Return-Path: <linux-kernel+bounces-37309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794CF83AE15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF5B1C22287
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940E7F7CD;
	Wed, 24 Jan 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XthGBVfE"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB367E788
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112701; cv=none; b=H1qFbH7XO3vltbnEsmtetLaTeX4QZKr9dK5maSyBsXcq0iXPIHV8i10/SEZIftIpLr2H5RjWMB1wmiM4gNUMZmG1EFfBF726wNM17iqpwBaWjoipIkSaz50adi/PN7G2wxFwGOp3uP/gPNaUgjHi6Bwi29Wq+0GyP3ZbtNaRu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112701; c=relaxed/simple;
	bh=zmxwR3tFriZfm4Dig7g39jI6oSlOl2huvgOi+JZztTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MnZ1oLZ4XzLcxOJ3HA9WCkTmXnfIm679lGvewUSfaNsRHmy2a/VQ/xelERFilpvT4xc8Rn/gIj0S4KrBgo+Uj3WbVCQnQzAVGoWO5kG5KF4ErNVUARv101sm/pO9OCFFGApqUiUtQh/Z6MN3NfhGvOjivGWdn5pJPMpIJLMo7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XthGBVfE; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240124161137epoutp02613ce396e0172de47ef2e1ed1256a45a~tVHWH7Xpd1032110321epoutp02w
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240124161137epoutp02613ce396e0172de47ef2e1ed1256a45a~tVHWH7Xpd1032110321epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706112697;
	bh=bX84pGQ3NKqRyrB/DSbccXAMgFgpL5V0Zu280XLcWUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XthGBVfEJde09MRcORMzkLXapweoM5koyfaIokcz+nvusEtNeY05LED90HbOhoa36
	 ldJzRxjudI9pGMig5aUAag0KPdCTcu6aRDl1TTQUnZuVa2oeD7E0CAD2QYeozk9QwA
	 x78w0za6VNQGpi+MUbuxJZMZvDQhATN2VGSHj8M8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240124161137epcas5p1ade37693ecdfd5bd9e428b116c6b7fce~tVHVxQuUX2559125591epcas5p1f;
	Wed, 24 Jan 2024 16:11:37 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TKpqW3zjmz4x9Pt; Wed, 24 Jan
	2024 16:11:35 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.D8.09634.7B631B56; Thu, 25 Jan 2024 01:11:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240124161134epcas5p3f9f50330015d1d80d31087dac09d26da~tVHTh90KT0932009320epcas5p3-;
	Wed, 24 Jan 2024 16:11:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240124161134epsmtrp1866e03d88b3055b69f5da26c4f0036e2~tVHThPi0l1601516015epsmtrp1r;
	Wed, 24 Jan 2024 16:11:34 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-74-65b136b70d2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.E7.08817.6B631B56; Thu, 25 Jan 2024 01:11:34 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161133epsmtip1b9c19d68ca44d373901d3c653af16b30~tVHSAqKl31266312663epsmtip1n;
	Wed, 24 Jan 2024 16:11:33 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v3 5/6] HID: Samsung : Add
 Samsung wireless action mouse support.
Date: Wed, 24 Jan 2024 21:40:27 +0530
Message-Id: <20240124161029.3756075-6-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124161029.3756075-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTXXe72cZUg+NfJSyuT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xt/3L1kLVolX/Pgb08DYKNLFyMkhIWAiMeNqM1sXIxeHkMBuRome3inM
	EM4nRomlt3cwQjjfGCUu3NzDDNNy8/VtJojEXkaJzysXQDmdTBKHzuxgAqliE9CS6DvyHcwW
	EYiQeLdgEyOIzSxwnVHiwcNAEFtYIE9i//UP7CA2i4CqxIdVK9lAbF4BW4nezllsENvkJfYf
	PAu2mVPATqK/7x5UjaDEyZlPWCBmyks0b50NdreEwEd2iZMbvgIN5QByXCSeHVOCmCMs8er4
	FnYIW0riZX8bO0R9N8ifx6CcGYwSLTuvQv1pL/Hz9QQ2kEHMApoS63fpQyzjk+j9/YQJYj6v
	REebEES1isTTrt2sMPO/n9jIBGF7SPz7dIIVEkATGSWenT3OPIFRfhaSH2Yh+WEWwrYFjMyr
	GCVTC4pz01OLTQsM81LL4TGbnJ+7iRGcLrU8dzDeffBB7xAjEwfjIUYJDmYlEV4T042pQrwp
	iZVVqUX58UWlOanFhxhNgYE8kVlKNDkfmLDzSuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8s
	Sc1OTS1ILYLpY+LglGpg2rY+dPFjY4/zZsETdjst/NS44rjM4Slr/PPmZ97V7pniKaRsN/9k
	xooFxo6fv9y6rK5ev1ZlQpG59pdZjxJr7tSE7Er/Oqkn6I/rlq35lpxpFaZR0Vf+VCzgfOe5
	Ktvu5mvWzRc19gXt8Z4nwPfDQPSnRt0vA+UHn05rdry4/bvMgH89/wp98SZ91c2uQl9SbLi3
	B87eKu3g9eT0l9aI1w9+SKWav8rXcp8cOlVikQHDZMeJkY8qi/ofTZulO8lR0ilPZcFilVCP
	05PeJEnd3il96SC3kH331wvuX5+WdU3K7nh7YpGh3VO+FbHJKVvOh/AJPnb5fSqguTtR8I+V
	m/6c9pUx1/gOZ6f+XSjSpsRSnJFoqMVcVJwIADoDZjwgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnO42s42pBjv/a1hcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG3/cvWQtWiVf8+BvTwNgo0sXIySEhYCJx8/Vt
	pi5GLg4hgd2MEtvmTWeDSEhJrLp+jxHCFpZY+e85O0RRO5PE14Y/zCAJNgEtib4j35lAbBGB
	CIlp/9YyghQxC9xnlNi6/yrYJGGBHInjG76CTWIRUJX4sGolWJxXwFait3MW1DZ5if0Hz4IN
	5RSwk+jvuwcWFwKq2fO9lwWiXlDi5MwnYDYzUH3z1tnMExgFZiFJzUKSWsDItIpRMrWgODc9
	t9iwwCgvtVyvODG3uDQvXS85P3cTIzjQtbR2MO5Z9UHvECMTB+MhRgkOZiURXhPTjalCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MIkc6f103dMl8c1l
	Df3+S2tVtvgqHPPN3lc4Le6yap9N1fs9jSExRxKqN1Q1OjVv/VtxIPzNH5v1F+YcmW377MRT
	B8k33Ewxk55O7A+r3vnPYr2PSYmaRTTfAxmDqbfd4t+t8nhzaD57qe/+vtaQkJgg1xUe+Qsl
	Nul9XH/meNRG/p8zQt4xFvFzB/vvbb8Xme1/sskxJOaP+bY6u39SnQrNc9qf5PC7rg1cI1yd
	sFtnR5HxXuM+r5znLCvOBFVPVt04ezdrifSE0tUuvRtYt1S++/bpiO0J2asZeu2qSWsZq4ue
	q5SuWc70LLr//dyPyvtO2nhLpPit0GbwlbRYOcF3W+kWLdH5XX8Y2ncUK7EUZyQaajEXFScC
	AGR/CfTjAgAA
X-CMS-MailID: 20240124161134epcas5p3f9f50330015d1d80d31087dac09d26da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124161134epcas5p3f9f50330015d1d80d31087dac09d26da
References: <20240124161029.3756075-1-sandeep.cs@samsung.com>
	<CGME20240124161134epcas5p3f9f50330015d1d80d31087dac09d26da@epcas5p3.samsung.com>

Add support for samsung wireless action mouse with input mapping events.

Device a004 (Samsung wireless action mouse)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-ids.h     |  1 +
 drivers/hid/hid-samsung.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 621853b21923..43a990086225 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1148,6 +1148,7 @@
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE	0xa004
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index b786888ec077..df0de72062b7 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -334,6 +334,29 @@ static int samsung_gamepad_input_mapping(struct hid_device *hdev,
 	return 1;
 }
 
+static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+
+	dbg_hid("samsung wireless actionmouse input mapping event [0x%x], [0x%x], %ld, %ld, [0x%x]\n",
+			usage->hid, usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0],
+			usage->hid & HID_USAGE_PAGE);
+
+	if (((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER) && ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON))
+		return 0;
+
+	switch (usage->hid & HID_USAGE) {
+	case 0x301:
+		samsung_kbd_mouse_map_key_clear(254);
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
@@ -357,6 +380,9 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
 		ret = samsung_gamepad_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE)
+		ret = samsung_actionmouse_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -401,6 +427,7 @@ static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


