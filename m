Return-Path: <linux-kernel+bounces-4293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33945817AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A5DB22EED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0F74E3C;
	Mon, 18 Dec 2023 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qHQ+kTO+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961B74E18;
	Mon, 18 Dec 2023 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702927480; x=1703532280; i=w_armin@gmx.de;
	bh=8xcRS4toKnQj2X27ThuiST1cF613b/lRiEqma2uezJw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=qHQ+kTO+138KHKZMQD8j3zmW9TQ7RaND+tLp54ET91nuGKkc75pFVJL/OWweRIHb
	 8t58GaeTcOC86MCBsEfhgShtRv4DXJoZj1y4hnxjGXFJxTEp/J9TEvWY0s2V4Ly9a
	 rOLqsunFMOSHkLzsZt9CaNYn0SZk2AWu7EBMM+HwlhuH1mxt6qw0G+4NttRw630KI
	 UbWqlollhIWAnwbpd2Hdf5MaThJDIDg8ikGzJ78JN+qIizYOWqjbLzsdB55+cbL9O
	 uzAmYh0P1SDIAKAjJ7RiDYPr6v0/TqhS0ODwrCclGyKd/d2Hqu/fRoIKdfZsFzCCF
	 lVMOf/2uf+UBYOY/Ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MV67y-1rhSSE06kg-00S7zN; Mon, 18 Dec 2023 20:24:40 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] platform/x86: wmi: Simplify get_subobj_info()
Date: Mon, 18 Dec 2023 20:24:20 +0100
Message-Id: <20231218192420.305411-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218192420.305411-1-W_Armin@gmx.de>
References: <20231218192420.305411-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JJpqrj7iaYiG8Q8VKBhDxjgqXLmD4e3e1HfFdXhL8oifTZUsq40
 YPW/znJwDNgKUd8QoBmCMG9Mbs4EaBcQ2w3i5V0l1CMx5321qfmWx/fzOzTSAjLIHVFLfEa
 SDfUbR1xivK85813OouVHTk9kOCSw45BSFkxyIyFvqA/sRRVkINhb97Ibfhgq9c/z0Z/FBi
 0BLazZeG6gb0CuqTAwlIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8DBsO9zt8vE=;Lgts6BU2rDjAkv83v5ftHJbk1cq
 3TdBM54kTm9YSiom/AUBfOGkFkFMhXD1v547LJZkl1Omnst2ScFBICd05JFUYhya51bkp689L
 TAWvtKIx807u4r4CNeX3K5xuHjXV3csijd3fcjANXyq52bhhGN+NmxJdzNCdSqATrCFQ4JOTO
 dUCy0WlHaUQAlBG0WAnwbal7xVVfqbd51dwbP2mQ17xuVk77Lu7UBKzn0MxYWXTsiQUuJBZks
 EaQBOIyh2f5r77fUvQ/vmZCSlcm3iK6m1J5JOAokfMDejyGzbidkdZJ0tKe4rMzgbNUrauN9E
 VgPYi2c1nfbSuKkth9sy+naRVDqkuCGY2ZM8hjRnDLEdAgsQz4fxtokBcT+HSW33QWOJLC1jM
 VBgNIqCPXNTOmjzsrb6q7HwgsxlHvcrHvBlYncpRisdbeo66q67WfJJJt6qiARSGfKpk2LMXw
 N6z2oZqbx1QsglWLjKHHz3f3SPHZ+T0sBNZY3u5NKxjd9+GJxLNTo+Rz9Z/SpNdx0v+U96b41
 kMq5K4C/3CZ9ywlJWQ5VXK1GmI/VbLWs+u0JMVjDEniKIy2m2POrp7CM7wY8yEVazbWCOhwpt
 5mc8j3tlPfKU/axjvskRyPalfnfVlTRjFpiRgPVpucvprg2RL60xlLAj82CAsRbwEs7zLJ0d3
 QZojCWlTn1QNlB7v4C9vrsrauzSQgzuH0RDo7cbNI2eOP4vFF7UuS6wiqP9KU2AP4c06pvtck
 Rbc8Hn+o1FtT/RT+aZbpWYuQjQAsgufI11wtEMn2C3hw22aUycdrjPd+palL9FJzpYTnOVqx/
 Z9VvyiODsRkWM8BwHY/Gmp1nsnYDD5JqaifDsO6ffrHoeVCOTFmgrH5ewp0sEG555PewTK6P4
 YHTcci3BFsalIxPnPULM2iplxXB2uym4hUGy7VaPVZ/puU9CQ1t/mGn0i/bsqX+qvyiMl3kTn
 02bbnA==

All callers who call get_subobj_info() with **info being NULL
should better use acpi_has_method() instead.
Convert the only caller who does this to acpi_has_method()
to drop the dummy info handling.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 559a99ebc624..a7cfcbf92432 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -132,23 +132,19 @@ static const void *find_guid_context(struct wmi_bloc=
k *wblock,
 static int get_subobj_info(acpi_handle handle, const char *pathname,
 			   struct acpi_device_info **info)
 {
-	struct acpi_device_info *dummy_info, **info_ptr;
 	acpi_handle subobj_handle;
 	acpi_status status;

-	status =3D acpi_get_handle(handle, (char *)pathname, &subobj_handle);
+	status =3D acpi_get_handle(handle, pathname, &subobj_handle);
 	if (status =3D=3D AE_NOT_FOUND)
 		return -ENOENT;
-	else if (ACPI_FAILURE(status))
-		return -EIO;

-	info_ptr =3D info ? info : &dummy_info;
-	status =3D acpi_get_object_info(subobj_handle, info_ptr);
 	if (ACPI_FAILURE(status))
 		return -EIO;

-	if (!info)
-		kfree(dummy_info);
+	status =3D acpi_get_object_info(subobj_handle, info);
+	if (ACPI_FAILURE(status))
+		return -EIO;

 	return 0;
 }
@@ -998,9 +994,7 @@ static int wmi_create_device(struct device *wmi_bus_de=
v,
 	kfree(info);

 	get_acpi_method_name(wblock, 'S', method);
-	result =3D get_subobj_info(device->handle, method, NULL);
-
-	if (result =3D=3D 0)
+	if (acpi_has_method(device->handle, method))
 		wblock->dev.setable =3D true;

  out_init:
=2D-
2.39.2


