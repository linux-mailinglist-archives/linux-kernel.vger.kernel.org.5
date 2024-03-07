Return-Path: <linux-kernel+bounces-96150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E18757BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0792E1C20DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61413848F;
	Thu,  7 Mar 2024 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lTw8q/Qd"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10444137C37;
	Thu,  7 Mar 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841496; cv=none; b=WL5TD3lcG0OS1gIrEbXQtbMs9ZJLP4o82TFhbdEQbwxcpTniMC35JNhMgt/ydq4bi7uROqfLy2LA+Iw1enrvf7nHOmcoWXlVvlvKK0vyUScFjTCxupdPLFDn8uvkCmB7f4IP4/wUHUti6uxq8U9aiX7SgWeZ7wtUsLRD0Pcek9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841496; c=relaxed/simple;
	bh=SfL6tjOb05/VPDRBKcHaN0jfguu2f2ZuyXGBWNiPbMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UL9zw7YdVZd/6M2Tvm5W1Twljd+VXGTUM8xAHupg/4mgnprFxVbku8TvyHUu8xykKM2pF3alO6RzHKIB/iwDLf6XfiwOb2y4U1QNdrIAI2Z/QuZy4v4Imo6X3220xEs5kS3zNnbZABXGnwb0CjpWtyGat3nELQiMS3aUDPhgcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lTw8q/Qd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709841477; x=1710446277; i=w_armin@gmx.de;
	bh=SfL6tjOb05/VPDRBKcHaN0jfguu2f2ZuyXGBWNiPbMM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=lTw8q/QdTtLoH5EcfrqhI4muZHFRSXfsMeyfBHbc/8P6vcRK6sa6m/CCjMNTl3Lb
	 Y7psyGVgtYTVNGPKgKEdGs45LHcZBar+RmNUsrBjSMkCcxmJmS3CaovhF2ZReNe9s
	 NpP8dFJU/f+09JGK/khA8HToudbCBY7wOeInJlm+fsjMsiUz7VlODsu7cvbtAsB9a
	 5X1cv3odKdV7m1wq14CroJL2/0IZ8ioS/6jJzr2eE14PeoXaDT7c7zuJZNwIHdbDG
	 FjHkIOJGIso1/Zpcx3eS567OOaQ9qiz0ZjE2vYA7qKmPiUPy6Xgeo98Umc6t6cdeL
	 BuedyWSvzQ4U/6OvJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M59C8-1rjPnt2qDU-001Dm1; Thu, 07 Mar 2024 20:57:57 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] platform/x86: wmi: Support reading/writing 16 bit EC values
Date: Thu,  7 Mar 2024 20:57:52 +0100
Message-Id: <20240307195753.2961-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IgIGkb1CooilHWRWBcwjfw6/swGMCO/qvBY2LaJ2FDTkoA4lRXC
 QZx8TmYGGFQa+8jpXHQRt29yplfLUKlzJPB71qqkdxgHcLOl9i+Fym/FIOpgzUr/EY5iMke
 Fh1MibgWUy6aFyPhEebKmXVHOaE7BkkjCFAp085bTLxa9qWqP3B7kplbkWxyNVARywIKNht
 /+5+i09xbNPZANIjPl6eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FK4KqCJSjOg=;d6qdQdkCMNfCLDjOKaRTBFFi+u/
 oMV23C1f+VlTVlIkRfeD0T/kDI7GOYf3ODbwf0tzdeGi1NmIL+z61yym+8pCKcnFnZz9f8jUU
 0srfG6RqUoQeY4FlE6JI1Qr1ywuCGYlkMvM+h5ux5/JSGDyDEt3B8LYRqrD3pZvVmgNIrDD9g
 J0njNBvbI2EUHZZIF9y49tRGt/fep14cnD055R0xSbo2CqMsJZ9tN782CKUXo5ov10pBfBBI6
 aIK8j33AY1d49lnUBmoEtfYycIqXT8tr5XG04y6ZRGTGErFo38nATlwkWQemN6mE0MI6pObL1
 1Ub7jbOYl1XV/erJcFdzihojbZZbWA1cWwgGuC4+qx/qa7QMaQiAseeZgSi2JdAXXb+r25JEx
 JsqPjs6COkrQiojmXpQPiKgheaIfLT2L8Bec4OfUNtkJJV04r4d/UAF88hrkzKL6wthCw/Uot
 zf5UKSNdHCGpwpPnqYFSviinIGpbhmmaYvNzWiVPs1McWS+feZHuS+UT9CsTMPBnD9dVi3GtO
 S7HCFOh57gwupy3DffxiYf8QGPxL4Oz9hd8hIPOsasZP++X7guqwl6dgbcvBTxS5VhVjfs1hu
 Mrv+2OPotr9auOPWXtSzG5gfNWFnXeVVIIKka3iofEeaxsnReU1lpMT220TFHj+/xEVWHdA5R
 dHGLy1aMST2O5GNXbJbZ1xGlqyNcae9Pr3xpj9Vt4e4+6yH3AazG0S1+KdiOCgakv5MfL5j+z
 YjDti6cV5mvupgKniPniJXaraDpNCg0F2AuJvrPGazcFFQFG0blP+BcgTFaRPHSk/bWBmyMIz
 u2T9GPrCaFRFThsX7SIUBlWFZXn1uRONuRLLpQTeJRoYk=

The ACPI EC address space handler currently only supports
reading/writing 8 bit values. Some firmware implementations however
want to access for example 16 bit values, which is prefectly legal
according to the ACPI spec.

Add support for reading/writing such values.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- use BITS_PER_BYTE
- validate that number of bytes to read/write does not overflow the
  address
=2D--
 drivers/platform/x86/wmi.c | 47 ++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1920e115da89..e542aef825a3 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1153,6 +1153,32 @@ static int parse_wdg(struct device *wmi_bus_dev, st=
ruct platform_device *pdev)
 	return 0;
 }

+static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
+{
+	int i, ret;
+
+	for (i =3D 0; i < bytes; i++) {
+		ret =3D ec_read(address + i, &buffer[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
+{
+	int i, ret;
+
+	for (i =3D 0; i < bytes; i++) {
+		ret =3D ec_write(address + i, buffer[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * WMI can have EmbeddedControl access regions. In which case, we just wa=
nt to
  * hand these off to the EC driver.
@@ -1162,27 +1188,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physi=
cal_address address,
 			  u32 bits, u64 *value,
 			  void *handler_context, void *region_context)
 {
-	int result =3D 0;
-	u8 temp =3D 0;
+	int bytes =3D bits / BITS_PER_BYTE;
+	int ret;
+
+	if (!value)
+		return AE_NULL_ENTRY;

-	if ((address > 0xFF) || !value)
+	if (bytes > sizeof(*value))
 		return AE_BAD_PARAMETER;

-	if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
+	if (address > U8_MAX || address + bytes > U8_MAX)
 		return AE_BAD_PARAMETER;

-	if (bits !=3D 8)
+	if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
 		return AE_BAD_PARAMETER;

 	if (function =3D=3D ACPI_READ) {
-		result =3D ec_read(address, &temp);
-		*value =3D temp;
+		ret =3D ec_read_multiple(address, (u8 *)value, bytes);
 	} else {
-		temp =3D 0xff & *value;
-		result =3D ec_write(address, temp);
+		ret =3D ec_write_multiple(address, (u8 *)value, bytes);
 	}

-	switch (result) {
+	switch (ret) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
 	case -ENODEV:
=2D-
2.39.2


