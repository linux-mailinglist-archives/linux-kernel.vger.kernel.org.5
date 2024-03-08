Return-Path: <linux-kernel+bounces-97520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D94876B5D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD9283414
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18965B66B;
	Fri,  8 Mar 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uLSVaJlt"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2E5A7B6;
	Fri,  8 Mar 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927448; cv=none; b=lQg9U5aJ3c9vYj067J8Wwf2SkOgNgQEcf9LUSOBlwVsUI/Pkh1myp88IaiAGU27jsWYpTV+sFxxOlaS47Z2PKhiziygPu3QWO8yV2ZpROvbZZ+NBGWh2EXL+HKNwyBebJc/bLS0wQKn/rWvBBIWSV7da7Zy8D8tuarI2QoY1nMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927448; c=relaxed/simple;
	bh=GInZ2URda4ZR/awa7AAlXa5X3pT6P2FUwC1sJRaJ+SE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K0xtIpfci2r6NL84Ufbk/WKOv9yq+4350nOgJM5O8uN5i+RLLeH9FYeeSRwbCMoccHmwoQUarTb+5H+hfvZSNTzczfDsnAc9yhNNJtOswLWsZicy/c1vwPVqt1A3iavBiXDXRslwfYe8doMSlix2/HkAPTjEOYpSQGUIMtu3Md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uLSVaJlt; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709927433; x=1710532233; i=w_armin@gmx.de;
	bh=GInZ2URda4ZR/awa7AAlXa5X3pT6P2FUwC1sJRaJ+SE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=uLSVaJltz501mreBO38jIJr0ZvO5+be0rmpFBXzDBAuylMG3y3Uc2J/emV24XK+S
	 n8Ih3mBGCKbfXlDhta7NBDypoqBRn5jf7NJNESZOx1c0FbYPup7uUb3x95IGR3SzX
	 rDAGlFOkEQWXzgzRcb6Ba2Mt1BZSKaXwLrI7yMd8Y1ReQBqtOjlfzHHd/ysPOIkb4
	 srGhkO4Fswb+tTW4KpAvnTr92i2oE17TcONxuV3D3+xLSKOfXg1ru8mclpEyPUSYs
	 pcFvaFAVWHKg75fUts/cK99L78Ld5ln0ucF+FKE6lnALvnXUs+lebc2IkgemqAuSx
	 T0AdG3dM5W6Y/nPsVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTzay-1rHdD10Xr8-00R123; Fri, 08 Mar 2024 20:50:33 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] platform/x86: wmi: Support reading/writing 16 bit EC values
Date: Fri,  8 Mar 2024 20:50:26 +0100
Message-Id: <20240308195027.7640-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CtZhcD0n0yHdmdum9rwj1NwZDAGDtI2rhCGhj2/joM0d71v5Q1q
 7P7pnmGPakEDFu27C5grY+kwmicPhNrqDlMfi2S8TF1lqy3x6pG+w7fWdAQjBic28CXCZuj
 9EncNSHFGkiWff6vt8B9PltJbYVuduzyAkw3cw4jLB8cVghPfdwwiPJjTlII0IuCM8R5xHH
 0IMQOeexx/QPH6ClZfMdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7n9CoxRLmQU=;nNIRGz+Uz9smsiJiA1VhCPtFG4W
 elrxO25Y13f7dAar0c8osfZ++hs20CNEFaUN9k+o3A9j3SD0F3vgNS8Z6+RnTpa1iKqRWCSbw
 rTty0DFg6shqYKGk9t2u6xOdM2kd9p/Zmk6wNn7Chrk81XHROIMTBwlvAzfdxm+K5FaOmAt1q
 j2dvrtXRhXhweM/wsccW+vqiZtotGs2ilXASjXeY1SUJWkrzmpYh0TbizI27n8/rZpC/Nidj7
 b7Jpm/wrZolJEbg8c65rWtrVUAixRvS5W4a8u1e78yancVDyNQOCP1Hc5Pp6/IdpjbRp6lw1w
 /hcS+u0PDW2LP+0W1cye2h4ysfbEIW85BTgwkG7tb33l07dADwUyNVhS+VAZOJ4Kt/pXj/rby
 b1tgIBVVtzjbQN7PYQV3JzdVqIuRPLG/ijTBHBXl20k0bPz+odv1pfIb8faDoUSvM3wHlmA/l
 /m/6Kfb0tr3mDX/Q4abvFP0Umb3h7OmplOEDaMBSUdVbE+ng+3DH7+mVng60feGT6O3r6oBDA
 c8+lQMu6zLwk6oxBGPVHkH6FvuE1i5KPfABlhDd4dEtKH3BKC9ZBTz0HAXuU8FuRXr524pziM
 8z3Vx3SsyC9s3m0ymGY1q0rsXNvEb7rAVThz+aMWetWyyfs9E50nLJTbJzx9kk6pUg4LIinwM
 8kQV5r24QchACFohnKBHY93q53sIOrGMzfeNARrWxrIy/rsIBV8S2Z2uOKisomyRz58fo1FvQ
 HVEL4KdTZc8V9BawRt0gbEDJKd/TjDmHCk3sc7AboYLwseYBsaNm0kZ38HaigL5ZmMX7VXkyE
 MHD4XPwbW/jFUJbFBFtzcsNHHhqPpLKsiDueW7t16j7HM=

The ACPI EC address space handler currently only supports
reading/writing 8 bit values. Some firmware implementations however
want to access for example 16 bit values, which is prefectly legal
according to the ACPI spec.

Add support for reading/writing such values.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Chnages since v2:
- fix address overflow check

Changes since v1:
- use BITS_PER_BYTE
- validate that number of bytes to read/write does not overflow the
  address
=2D--
 drivers/platform/x86/wmi.c | 47 ++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1920e115da89..e6cab1cf611a 100644
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
+	if (!bytes || bytes > sizeof(*value))
 		return AE_BAD_PARAMETER;

-	if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
+	if (address > U8_MAX || address + bytes - 1 > U8_MAX)
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


