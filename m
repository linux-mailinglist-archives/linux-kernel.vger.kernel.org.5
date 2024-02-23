Return-Path: <linux-kernel+bounces-78730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6848617EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E931C23BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249BB85621;
	Fri, 23 Feb 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XJIKuRy6"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88883CC4;
	Fri, 23 Feb 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705762; cv=none; b=ID5L/xe6ZRFZ95op/CTbe11ZuORPiod5b86BNpsBIhkJLavmTmlGp6MDy295tTTSwoWyrDJedN8YF1JjwHmkF68hc7F6ConUtE9WatiQM6Y3tMSwS3nRB/jM5cUS75awKrpFbbAObT431qP1pnJnStxyhMaF1hHjQ+un54DB95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705762; c=relaxed/simple;
	bh=uQcQYf3+Y04XG3bF/6l4sxBLO3EUjwoVOCfO6HW/wv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LI3P+UtYzq8oi6Hlu1a88W30fwm9GI5omm7xLrbCHWYQ7JIXYkxFofliqtWLu22roxbhSu5ELOWkojVHRwEoApp4yLHwuJnSvwPDV8mMbNptCgWXtXSxxtrzcCULCyfmpNgtE5QSgrkAmQpm1zNJuj3+DY2lQcrqJEUU8zNFf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XJIKuRy6; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708705749; x=1709310549; i=w_armin@gmx.de;
	bh=uQcQYf3+Y04XG3bF/6l4sxBLO3EUjwoVOCfO6HW/wv4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=XJIKuRy6nBe5Tfwo5DEPUnD5bAAo1w4Stmae3Bp9nJyNkhzLbc6Rsc1rqI5WTZ0o
	 rwcMelUgDpYjcv74rLTKSVGyu4j6YFf3BajEFz/pv0bHVq4yT9ELVlRrNiRfn9HTr
	 3Mel752n2ShUlrb3QKFm864D/V0+JAOWch8W5OfpMOL/igaYE+BYRAenG3r+/NFuR
	 Pwp4PkfVvnX6lBKbT2288y2PSMmtO3XIC9FtuxPprLECbBEoRc6s3RT90No4GycZm
	 rE1NVCwXqUBlQKHMsqj0jRNMlC3+TBZjcDldAS4181kw16Tetj8ffcxTcmP4FPCKb
	 6fuC+3aezztTwWzpLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MeU0k-1r5JWz0LHI-00aYCd; Fri, 23 Feb 2024 17:29:09 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-privacy: Remove usage of wmi_has_guid()
Date: Fri, 23 Feb 2024 17:29:05 +0100
Message-Id: <20240223162905.12416-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W31Q1xxw6jXnVTOqEdojWBofCqyiUiFBhm+rj0sZnzWrPUQrymx
 z6EGkveFeYfUdywBR1Jxxuxc0oDDEIUC1+5jSbVVDproEW4cWekMY6zlvPpy2aFu+V7QySW
 EE6v0voljDCnCIIGN17nJcaiRZemLjqLFXb2qUEAI/yQGswCWY9fzc35Dckmm2lOdC6GWag
 KdsDOfX8FHGO+y3LEftCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pltGP1Gs7T8=;D5njLxhepIlSGQ8twTVRINaMKSy
 Y5N/DAIk7XQn/hTSlV7XF7ij7qw/CngoQWWYM8gyuS4choLdt9OS/QzxUft6ZDRjGo8MDdVHS
 hfUSC1LY2hrMhzsceoydZmZkjnV3+FGGftSuMkYOWxNUHm4qb/ZjlrPOM/J4RL1M+H7wY87ow
 71cSlPIib3egh7J2FcygEOug5YP9DpG9Qqtv4nRogKc7j0SLeGQSMitD90mli/o3SRw+gJJhe
 UyTVya0uzatwqUx9JapWIjeTz9j/L7uE7h1e5k+Dc6DOIzjjmQBKPYc2h5Nz+q9J9u37J992n
 +1dFPDEl/pTWOTdZDprnN3RjCKzZpyHYcdcC7JPn2wZYBSt+KACCLOuvMq+5ByNVTXoHYl44k
 DzwI2wihGewRIo47HO60JTMm7I6FkpOQAzu3pq63BOukHj74smYgWXFOeNp+9vo86+GVW8OYx
 wh+0pMIqTEgQUPApugutzh0CJEYejfL8ykYSTitmEFQ3BVXYrvysVEK8TrOnwEgqvZI4QUdyC
 IV1QQ31FU0415iQhEfU13SuDuMAM4vcWk7tGS3zw//UtThtRqY8YqQTrsIDNx9OvWkByWiHnd
 kUTEI4v8lqpEle59bdkZGlV0j+U8XCrtAwfoYiSjvW3GbF1NuW/Mo1WvVBZB6lf3e8Yx3AKAv
 sXY8HB7ufu5YpRrAL0aZOo8KQ+aMJJ6QdcJXATKXh1EmLWeL+8Cv4N3hkopUk2hSyCHMXNFvS
 W7/alJtESS6nuwysqJusW7BrpOxkiBZk3uWEbZziDRt1AchuTm6Ra1TVALxLmbJ4A5saPkl5B
 s9ztEvzjFIQxz9jszQLV/tQzc0eMlfcTw9HXNJVTWouLU=

The WMI driver core already takes care that the WMI driver is
only bound to WMI devices with a matching GUID.

Remove the unnecessary call to wmi_has_guid(), which will always
be true when the driver probes.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-privacy.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-privacy.c b/drivers/platfo=
rm/x86/dell/dell-wmi-privacy.c
index 4d94603f7785..4b65e1655d42 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-privacy.c
+++ b/drivers/platform/x86/dell/dell-wmi-privacy.c
@@ -297,10 +297,6 @@ static int dell_privacy_wmi_probe(struct wmi_device *=
wdev, const void *context)
 	struct key_entry *keymap;
 	int ret, i, j;

-	ret =3D wmi_has_guid(DELL_PRIVACY_GUID);
-	if (!ret)
-		pr_debug("Unable to detect available Dell privacy devices!\n");
-
 	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
=2D-
2.39.2


