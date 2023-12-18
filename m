Return-Path: <linux-kernel+bounces-4338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B549817BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00281C2283E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48D74E25;
	Mon, 18 Dec 2023 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uL0peQ3U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038F73498;
	Mon, 18 Dec 2023 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702930802; x=1703535602; i=w_armin@gmx.de;
	bh=8xcRS4toKnQj2X27ThuiST1cF613b/lRiEqma2uezJw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=uL0peQ3Uqiqlqao3InO3XuoWoxUQbHmSp/eyBrfh7tFQu0MlULUwP/fk1WInLWd7
	 r98Hhh215lnJHNLf2LcvwJj7pAwsgXwU82cYrZ8mIcLvztUESbCGFTKQOaOcXhVOA
	 olS5tvYqcaaqhCHgUVVlxiphEuM1u70qZN7Pqj7os2pcTYcJthSj41C1UYDddJII/
	 UCdi8lbF5IuH3Rw0teUdptixAT8vjJDkfzFMy7OzSat1A/FPfNSDdgYkjGxqy+Wlz
	 oZRqCT1ayzHgwRxGm5sYZOH63MXdO6ErDNgJrpWJ39saB/ExmPxwZTCqQ1NXFuy59
	 tD78M1e1VmrjArQS4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MSKy8-1rhwks2dei-00Sh7P; Mon, 18 Dec 2023 21:20:02 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 6/6] platform/x86: wmi: Simplify get_subobj_info()
Date: Mon, 18 Dec 2023 21:18:51 +0100
Message-Id: <20231218201844.2860-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218201844.2860-1-W_Armin@gmx.de>
References: <20231218201844.2860-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zs+GuJiftyA0nnelVgmKabbvQuVWX7TvoSequC+/aE+iM9ipxF2
 fm/KCsrl9IPIBVmsJU5nThDQNH2x2X6uyNTdT2r7bwCfAVEaFIi2DVdWEjVI9W5uiO6uXm3
 ji6cGMS0HdNj0Gw6LXSluBfUe3tj3+NouOPwHKWlL0gTpPwrLUDDTMCsvm7At6mXWvfGaDm
 UzBF7ehceEl+PUHbvUWHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ONT9f25Y4VQ=;v4Wwlg73iNkaNaCYoB8QW2jkOXn
 ZgVJxZnRFE4PP1PPL0ANHccqgOZRJ0ek6KZup0QiKw/aDaJ03eeo3D+my8xn++Ef1mm9S91XT
 DEMfmFvHAIlvR2mf8A/NeVsq0kHI+QdVeqvPGmQ71QZieVRwtTRJY6UuDzG4xf6unQekK1oHN
 NrY0NhzQ+EpNDiMTBQu7oqneVVcHh4yka5BJcvmWsqo1tM5/5QgL3y4lNa7KX/NFiysv0T21b
 pFg5iy3RFXhGgt5+K7ln92Ha4ZIi1IZ/TUr7A/lndmj5wUznkxZql8I1MRK2Yb2BzOr3IEXnU
 C+rebKh0+O6nggYSYIBDSrZhAWuyNnbDDfMAlqgrRwgWIkc7FOEAem4asSZxQ4ajNPPA/4aqL
 zY2n2QPU58haLTcLAv/govCLcK1Se3uMVUVyX40TGb8VZGWgQq2sNlWxQVrbLpRrRIb2wK3Mt
 DUq4+5Mot6r5LKOasb1QfuM1B1TJ4SOQcBpuiHmru0Dm7NRNfb7MFDSPi02953FTVWQd2DeS6
 b9ahfofTrfdJbxJrN2Wn2UtNwW0hCLcqlq1ZCI/XkN6EjrClFTABQ+uuZ0ESs2moF2uRVMqof
 ZP9wUpSNqNnZfDTu6YDygNHOohP4p47Phfdj8rI2JfQlAr28mqXQvyZQfEmKNx0xML49VcpA5
 epVL45d2P3r2jrkPieYnrG3FOjcVRZ9Uu2ibhUoK9VeDRVzjLcaXV1euSeitZqv8j7qEhuPoJ
 BvxVISqKP/QJ8PKNyWxkijHgKKs+eSyL+J0U9n9ftWYzdKTjo+JS+RGkLkd9unj05VlKBQmbi
 q6K07XGWa+nJ7lSrigcsUI2vayzCqvHo3NgVwXRkWlHyATt+UspI6ZEgGM+QbTaWK+Uo5uwXe
 aeh9keAp+g6558QF6PCmD5+zqgE3eUXsnVYHYWfvXAjClOf8i7K+B0XKRy7+npUmaWduB7NrE
 xzmCuJdejoRu8uVQjmMfTk4f5Lc=

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


