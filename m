Return-Path: <linux-kernel+bounces-91359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A704C870FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D926B1C21AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E267BAE2;
	Mon,  4 Mar 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Sf8XJOJh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58679F2;
	Mon,  4 Mar 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590665; cv=none; b=MwweOR4cRZUj09xChYd65GC8V8sXN/e47Acgc4WvROioYize9NEzdu10v9wt04xwDEQthm4//EKALsz9IVrtFQXdOFcWdIk7v+m7Yfv+iSWZ9lwtP5C3g+zfBKmE/at5F6QvwfiSy9+NKFx8IZLDj9sc8cxUOIB8DYNZaVKPbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590665; c=relaxed/simple;
	bh=VlKZ9o+29/hqwaDeqpj4LAI4vgvn2/j6rxxZkLe2GW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oE4CVVCNfkl1cZ8LZuhgdHcJYA6+H6i4DovmBBvpqNh4SvaEeIKH8XWg+5bKrCnHaE1ftoUYq/rhhY1yzi2ywU8g2LV3e9xH7pKlt2Bq+IIN9rprcRsJiusxvnHyA5cPGXTKuVen1xgpNq0avwKVcpiEMa901T4SCAmH4ZxKbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Sf8XJOJh; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709590655; x=1710195455; i=w_armin@gmx.de;
	bh=VlKZ9o+29/hqwaDeqpj4LAI4vgvn2/j6rxxZkLe2GW8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Sf8XJOJhNAbkpyCTeruVMgLTUarPwlB7X3g0xz7YC4I2kk2qodNOu1MSmEVUQ8Wa
	 +ZGLg3QjgGLW4JLSUqgXcSx8ON55CC5ugw+k6HCnPEzjYNqZ7ueeDhFlxP+nFSN2R
	 w3J3fxA7wHY66LodeFOe9czQZxSnNqNvLVlrgPAkM2PUiy7YKRXGn3ZDuJvbi/nyJ
	 oI2nJFWLsDn/7z0LZjO42JsNsKXxjDgww/nWs6CeO/FTOAHOIXyigYt4OOVPx1fGB
	 BntZOfFero7qrXk6cOWsHo2yX2t8TCpJ/1zASgPUjgoaCIVLn2cD422taScfljCSR
	 18/6HMvRGIk8Tf1OmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MulqD-1qqGfE2T1X-00rmzD; Mon, 04 Mar 2024 23:17:35 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: wmi: Support reading/writing 16 bit EC values
Date: Mon,  4 Mar 2024 23:17:31 +0100
Message-Id: <20240304221732.39272-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I+7jPpRajvJM716BLeMFIOzhm1SMpshI6DyrrzmcEaYxpSEnuK7
 7pFzHeZuV5rSBTkXTlw/WcPKYoteOGsC/GjD4FvBTvxeilr7i7M+T66RuzQbzsb7uck0HN0
 kx3mMx0SbHatDoN3BZOWnap4FMF5m4ITmVw4eLxITykFgB5Gh9EuG3IesvLAhEBzhih8PjN
 QsW2PHfVFZWje+Z2sv8iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dwn4bMpLiuM=;owKiHwRliBJnz2ulk7Icj0E2Mq3
 yK7cI/GxTALIIsJc72AM+ISjGPvWxxbHqD33EMXYz7LgrFN9jRNcFTG4oB/H88wdGv35edB8l
 STrZu45GeyJxR8ruxS+q0BygUIhryjJOpwCDFesX5BcCcwvLIMQrHnkyqoX7r5ZH3aCTY4eq+
 E6eYB2iUTkeTv9+nAq5bnheLhmeaWJBdXkI3c8ncGKy4fASDG06a7/XBCpxG3MPTCX6wIR92J
 jq/GM1sZBar9fBsZIZ5HVY94oCCgKXY/lmcStkony/xXqEjz+z255OKR4khUhJHc4vxtvXvqf
 DX2vxHlqMHJP83razOBLj3J0+BGrKLxj3OfrnHbEvB1TjfJ5dpf610FxuQdkynS4bgJZv1yRu
 1hy7jQAb9axTBjZQrGzWQKhuuFLBEyVmLNTokkgU6jkpXszu09F9wSyTSnbUkP+FAp8KrX1pr
 vXx35dTQNkqnB6dOLZiu9hr8n1bRx8wtOkSDG7/uFFIImX4QSEuvEqAYaP8mZQbIrGYCqTmBA
 eV2wCxv4mNytAfqQesdT3tHF/llXbNY5k+bXkIgcg8ft4ZVjVLGjxNnWXK+IVj5FKSgKBHRzR
 PAquodzbWHlEHXFJsOO4YSkRaTsbtxggC0PGcUv8OWMnHFA8QLCS+Aj2AfDuSN/sL1oIk7LFh
 7o6eh98/llduwKOjiag0Nw2QmJBs/aRycTx6BrFJz4KnZUedI10w4YVF9sTvS4NW1gZZj94Ve
 YIqS7LZ+AgDnraFJ6Nj7r/5Ny0bntNefeRM56G5N9couJxcb0J2rIrYsuIZB2lUsCopdjQw+L
 dKucIy6Rf50vDOFKycz5d3q92uolBZsKHF78SmrcGdVkk=

The ACPI EC address space handler currently only supports
reading/writing 8 bit values. Some firmware implementations however
want to access for example 16 bit values, which is prefectly legal
according to the ACPI spec.

Add support for reading/writing such values.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 44 +++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1920e115da89..900e0e52a5fa 100644
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
@@ -1162,27 +1188,25 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physi=
cal_address address,
 			  u32 bits, u64 *value,
 			  void *handler_context, void *region_context)
 {
-	int result =3D 0;
-	u8 temp =3D 0;
+	int bytes =3D bits / 8;
+	int ret;

-	if ((address > 0xFF) || !value)
+	if (address > 0xFF || !value)
 		return AE_BAD_PARAMETER;

-	if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
+	if (bytes > sizeof(*value))
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


