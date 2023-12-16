Return-Path: <linux-kernel+bounces-1944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B74A81562A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D966DB22F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA92F9D0;
	Sat, 16 Dec 2023 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SoAz1on/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092516AB5;
	Sat, 16 Dec 2023 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702691781; x=1703296581; i=w_armin@gmx.de;
	bh=/MhohvF8TRYvk+FPSFys0uF+3w0OFNsfZhE+kMD1eqw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=SoAz1on/5wOIK6SKzRJATKOm3k8y9TOldKBa8O3th40YVLFk1DHFpO5VhzpwUW0q
	 VKXQ6HQMr9CrFaJVMQt9yRSVMWb+ISP3riBe3CGFhJ9y0FXzF5NFW+GR36V1jdlXH
	 0jA60i34oe6feXHX1dFqbndJc65t8XEq1gc55jmHavuSYemxpk9YMGmki7iyHobxT
	 feRnrW9RCsqTSBv2+6eqLd2KcflSoEMsqqUH7vZRum4+5UjRkExi3RFw2YdY8yvNO
	 YdFbzp/ec+vbDpQk7R8SW9q/9Jn/U9/KXeVKiWB8juKnhpZoGNEfhsgfCOCseVk61
	 Z/bVL57ozheCA1NdhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MNKm0-1qqlQN2918-00OoF8; Sat, 16 Dec 2023 02:56:21 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] platform/x86: wmi: Simplify get_subobj_info()
Date: Sat, 16 Dec 2023 02:56:01 +0100
Message-Id: <20231216015601.395118-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216015601.395118-1-W_Armin@gmx.de>
References: <20231216015601.395118-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bWxW7rvFUAutgp583r1H0Gnsol5oonDb61FGbvLT6Bht68uZlZL
 LgQXYJS0p4ucDMVjEhHOpF+xglh974OEbVZrChJABiwI+WPkzGNP8eUHBeYJ29/tLTcK5kW
 BGIBkClepE9znGtY3yi80ur2zCBHzlRHIc3jvejIjEJpLpnIeqmdmmiTfItfpSFYkaQ+YIl
 V7Ns9/ymG2/AXCemZJ0Iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4tZSiVp8bpo=;hfdclQIFVzbEihY+PvUQUwCJW7N
 cpag2R3FvvCSiuogGvCdkU+b0b//3feXBDatN/iCCHyjftosuWgocwU5E4uxSU8wBULtQkong
 OluUt37ujakTKqKjD2Q3NhKTwx0peWzCv72Q2BrURJyGPb54UiNT5Igys4ryqzk7bU2bqFet5
 lIxyQ4yk/SXXVxbsbhrSCSAYq2lJM9eWHz9+UHzUDpukbGjyjOgVRtD3k4mqQDlfG35/OtPVy
 kTUdOukGSPgCA117X6pEQRYAIvv25LuU7XJhgp46ocjvQ77a0KjcxccXo3R42cSYr4KPIoglA
 O9ZY7CZ4fqxuedDTQLkF2gyRP89C6pdq1PJhiIBMAjwCN/ctnV6WG3eW4XMYVpc6jbDIG+Ac8
 uKdslPFsW8y9827QRJSgtphSZZ78f2+k5FZZUH0UMTpDmVc5I24arlqHVRtph7m1JWAWYdOG1
 joFx2T/Qe6C5+JBoxlQqW+5/G8rvDfLnvlQoLmSgrCeZs51bEPFvfOMTERClafBCXlBvmuORr
 5OkD3xZxxV0YT1cJdNyFcXl1MIrH6oh7wpg3/ooKGWwkQ76uJssv0zebbCeosfyTEZnJrOJhn
 SqEf3WbDmpWk2bMEqfA7M/6HRGPGffnlgIRrJIGdHXiYbFUYl8cdUY1eOISqxSADQbCDbH2YI
 ++ZpKfcAmVNfi68rA4hAgtyA2NjU2JL57QMCPULBewcUM5A7bAH/oI1BRmCDhECNona2KY6Ra
 ULHPtA1PYSqlP9eJXpRdjTYz5mkBHKFMkvqToyL2IQG8WhGRpCeNOZP68iZY7pMZu/JvKQ02P
 vKygDrkzrdChPzjBNoL9qfVY2G3FB0Qj0X3Yw9Adio1TC0rVTfQ5eb3bFtHxF6srbvZXaXFpy
 uDUCMIoO33x1nCf8XTvTxYcBed01PwYucATagclUlpogxBBRptuNFeaW6J4S9ByBO00IDplgd
 khtMtgUxli5zWImt/49nWrDCgXk=

All callers who call get_subobj_info() with **info being NULL
should better use acpi_has_method() instead.
Convert the only caller who does this to acpi_has_method()
to drop the dummy info handling.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 6b581c772fd1..73570744bc33 100644
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


