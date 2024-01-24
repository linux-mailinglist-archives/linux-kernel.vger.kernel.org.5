Return-Path: <linux-kernel+bounces-37303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6025383AE16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A40B2DC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637F7CF29;
	Wed, 24 Jan 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HLPHKUNq"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2437C09A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112672; cv=none; b=M8n7tNCMa3ygMx19vvEFNl9UOwkLVgN84wSUNteDSP9gb5oUt+JzRJDjLnE7xuGYf51S47JFPQlB/UbaAuabILL+vqzsRH2J3vUJ464x+/jntF/2pBcFUv5rQTVq+V0GEpfD+2CKPba3qgLK5ELKxg+L0E5lJmThuK2WBYJydGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112672; c=relaxed/simple;
	bh=xfsQLJ/2vU+01sZsEX/6QiGDSwmC4PQVvgtOhSVA27M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JsZf6ujQoC+h3pK7X7F+Qlw8tfEvkJ3wO+evLRe/1qWFeymjAXMhgz2jG+bdTfiWjKKA2VZZ+vuXNOoC0zfGSiBYPnvzR0SourIbbzSVCYgFQE1EB1r6ivuRAAAzIn8s0nsL/J/SheP/k7/JgCJa2e4zS9YvsnpRbkJT5ZpzMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HLPHKUNq; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240124161108epoutp02dcc6369e6c525b8c73618d4a5d370123~tVG7CDN5F0913409134epoutp020
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240124161108epoutp02dcc6369e6c525b8c73618d4a5d370123~tVG7CDN5F0913409134epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706112668;
	bh=FxRt1IQQ9RC5YoH6B7ssFdDYXaY2b2Jj8AIgAplcqlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLPHKUNqcOeK/qon2a+VP2TsyWxBCyBCDoWtKMOCJ51qKvQAWvNz3vYBD+dhCK27I
	 JBOHP85nc9NgFzSgWSjClNFFjRQivJsrbm7Bop/HScFA1USeF+qrXlQIk4VtwJy2O7
	 MFmrEHi32LEySt+R2aCFVdHGkfMdBx6oKxsrFylk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240124161107epcas5p2108f973d053b8339a151d2c5e078493d~tVG6dKweF0409204092epcas5p2n;
	Wed, 24 Jan 2024 16:11:07 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TKppy19PMz4x9Pr; Wed, 24 Jan
	2024 16:11:06 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.8A.08567.99631B56; Thu, 25 Jan 2024 01:11:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240124161105epcas5p2d1ba581f56e7c0a401a68790202f663b~tVG4N_HCq0408404084epcas5p2o;
	Wed, 24 Jan 2024 16:11:05 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240124161105epsmtrp201b5a3a3c70eeeaca80295120925d3c1~tVG4NB6Xn1827518275epsmtrp2O;
	Wed, 24 Jan 2024 16:11:05 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-50-65b13699244a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.B9.07368.99631B56; Thu, 25 Jan 2024 01:11:05 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161103epsmtip1f2e8dd42a52f89bcb4b9d8eb3efa7597~tVG2v_SPy1251112511epsmtip1g;
	Wed, 24 Jan 2024 16:11:03 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v3 1/6] HID Samsung : Broaden
 device compatibility in samsung driver.
Date: Wed, 24 Jan 2024 21:40:23 +0530
Message-Id: <20240124161029.3756075-2-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124161029.3756075-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTS3eW2cZUg1PbmS2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xs0vPxkLtghU3O5cx9bAeIK3i5GTQ0LARKLpfjNLFyMXh5DAbkaJJXOe
	M0I4nxglLn9uY4dwvjFK7F/wkh2mZfWjXiaIxF5Gic6Fs9ggnE4miWWr+sGq2AS0JPqOfGcC
	sUUEIiTeLdjECGIzC1xnlHjwMBDEFhYokli5dwMriM0ioCrRemkqG4jNK2ArsX/rMlaIbfIS
	+w+eZQaxOQXsJPr77kHVCEqcnPmEBWKmvETz1tnMIEdICHxll1i6exILRLOLxJ4Hi6FsYYlX
	x7dAvSAl8fndXjaIhm5GiaW3j7FDODMYJVp2XmWGqLKX+Pl6AlAVB9AKTYn1u/QhtvFJ9P5+
	wgQSlhDglehoE4KoVpF42rWbFWb+9xMbmSBsD4m+w4ehITSRUeLq0ZlMExjlZyF5YhaSJ2Yh
	bFvAyLyKUTK1oDg3PTXZtMAwL7UcHrfJ+bmbGMEpU8tlB+ON+f/0DjEycTAeYpTgYFYS4TUx
	3ZgqxJuSWFmVWpQfX1Sak1p8iNEUGMoTmaVEk/OBSTuvJN7QxNLAxMzMzMTS2MxQSZz3devc
	FCGB9MSS1OzU1ILUIpg+Jg5OqQam5u33I3RumuoJ2FkzNvgtuVpbeTrFpeHozvvfKtjnvFP6
	oBt35JW4K4/p/rT/2ybdaWz7lfYw+vvetmrjPw94ruxPemRjKafoZnatJqVIZ2NVo6Lq8xsB
	Pn3HpQ/KvpBKeii288Ox+9zPV5o2KpbMLZuftuTe14VT73+8cz4sNnCv4UrLsK3/FnCwHDl1
	8cX2pNinph6c/1ft/mF7/0RgqtV0c2X5XAOdJU+jHU5GRb/+ME+tJySDw/Sbr31gwbut9zN4
	ymN8Wn2b/zyIfMYRfjI8NbwlLI+ZQ1o52iM97VZVfO9n4W0+d3MZ3SZJznGdP2N/7oRrZbH/
	Jxh/PO+yzamX5aFwdtS9Bxn7twcosRRnJBpqMRcVJwIAUXh1+SIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnO5Ms42pBjv/iltcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGzS8/GQu2CFTc7lzH1sB4greLkZNDQsBEYvWj
	XiYQW0hgN6PEpeWiEHEpiVXX7zFC2MISK/89Z+9i5AKqaWeSuHpzHzNIgk1AS6LvyHewZhGB
	CIlp/9YyghQxC9xnlNi6/yobSEJYoEDi6JJesAYWAVWJ1ktTweK8ArYS+7cuY4XYIC+x/+BZ
	sBpOATuJ/r57bBAX2Urs+d7LAlEvKHFy5hMwmxmovnnrbOYJjAKzkKRmIUktYGRaxSiZWlCc
	m56bbFhgmJdarlecmFtcmpeul5yfu4kRHOhaGjsY783/p3eIkYmD8RCjBAezkgivienGVCHe
	lMTKqtSi/Pii0pzU4kOM0hwsSuK8hjNmpwgJpCeWpGanphakFsFkmTg4pRqYHnXUfTB02PHV
	Lf6sWfiez9vv6v+sd/qfpWeSI6TMKn3twSSlr9wV196ZzbmRcuXTZK/uqSvdufXfcV2MsVKR
	DVC+cUgjwkEkUXD3O4fA3Qan+lZUaT2/7nfNMo1tdvmLTz1pEh9KYhkMny33yuDlKb+25JtL
	4rmbn1W1lnxc/2I3L7/o3Cnqk6epVCxaGBHut+WiEKPcxMJT+pctAq8dX3AvdKuTS9grj+XH
	1SYu5fI4Mktn7XElx1UBRw6f69iQNHdSVfaM1n+laxX/PhH8lyhZX17n9TV6xn/ux/ODXq5x
	snjXKlKxe3agXN855Ttbrr05zrf3mIf26/2haZ3ib3jNAw+3BK5/5XBkpnSErxJLcUaioRZz
	UXEiAF8UCVPjAgAA
X-CMS-MailID: 20240124161105epcas5p2d1ba581f56e7c0a401a68790202f663b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124161105epcas5p2d1ba581f56e7c0a401a68790202f663b
References: <20240124161029.3756075-1-sandeep.cs@samsung.com>
	<CGME20240124161105epcas5p2d1ba581f56e7c0a401a68790202f663b@epcas5p2.samsung.com>

The USB validation check has been moved wherever its required.

Earlier Samsung driver only handles USB HID devices and returns an error if it encounters a Bluetooth type of HID device.
This changes improves driver compatibility and extends its support for a wide range of devices.

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-samsung.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index cf5992e97094..3a8756232731 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -128,7 +128,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product)
+	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product && hid_is_usb(hdev))
 		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
 	return rdesc;
 }
@@ -139,7 +139,7 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	int ret = 0;
 
-	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product)
+	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product && hid_is_usb(hdev))
 		ret = samsung_kbd_mouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
 
@@ -152,9 +152,6 @@ static int samsung_probe(struct hid_device *hdev,
 	int ret;
 	unsigned int cmask = HID_CONNECT_DEFAULT;
 
-	if (!hid_is_usb(hdev))
-		return -EINVAL;
-
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
@@ -162,6 +159,10 @@ static int samsung_probe(struct hid_device *hdev,
 	}
 
 	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product) {
+		if (!hid_is_usb(hdev)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
 		if (hdev->rsize == 184) {
 			/* disable hidinput, force hiddev */
 			cmask = (cmask & ~HID_CONNECT_HIDINPUT) |
-- 
2.34.1


