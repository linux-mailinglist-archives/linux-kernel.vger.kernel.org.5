Return-Path: <linux-kernel+bounces-97590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BEF876C41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC301F21F0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354355F578;
	Fri,  8 Mar 2024 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BYluXopi"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4317745;
	Fri,  8 Mar 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931941; cv=none; b=jLZWaxyeYCqY+RoEm0xRmdghniL6L+xkwgZzkC1W6Y7KBDcjchMJ2faqaRlQ3C9vzu9uNTWQHCgLYbezU8DgVVBDgy12QZ4pwfTDFHzTOEeKVs1OpdRBrBWrjpHTCvrGmmSQn2e90GeqSWYU+PicGsWtMJMxrMcBbNPjSUF+r7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931941; c=relaxed/simple;
	bh=CJpU7PWKIrFYOOqFWndohMTjLNyEZPWygUxPokaxCcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0YF8CbXnZY+PjrGbqMIi/VNOLmdcuSH9ehDsF6yy9/n933kUF7BoU7uI0q6g11becQWl8610kKLRdCCnjn4SwwAtlBfUdJ0oYM7B8bvWPrsmpbzB6IaG1XOnvSTSp8zxDKvMjwmjOhU7bkrac7cqrbiciQumSOM7nu2THg3ppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BYluXopi; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709931923; x=1710536723; i=w_armin@gmx.de;
	bh=CJpU7PWKIrFYOOqFWndohMTjLNyEZPWygUxPokaxCcQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=BYluXopicfKwxb4kNRBAZGM+7BqLtW3izs1+WvcRuPX3kRljpM41EJZ6sWNzZbu/
	 2O7r+iF1aD2426dvwm+IxQawEF+gpPZZswwVfAORqk+ZpG5Vmg+niLdzGtS4UbL4+
	 ltYNoH4Dc6rOd3C07PrpxbB42NYgPeBpqLZs508RFdViseBg/U8ldytS/cJrGD4E2
	 Rx1LVY9PEwfpFzCxKuDTcKKKRCCiKuOykNIdiMbiMYtXZLKqjRTtJ8VrZDY2TaIAD
	 7B7rt0+V8TCphu/EwMuY+krY0iuujAy0+r4n/sDs50COVB1CipF0lpgXFA94aHo2O
	 1HQ2YVM3sdzBVxlblQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MVvLB-1rJ19i021V-00RqXc; Fri, 08 Mar 2024 22:05:23 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	mario.limonciello@amd.com,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] platform/x86: wmi: Support reading/writing 16 bit EC values
Date: Fri,  8 Mar 2024 22:05:18 +0100
Message-Id: <20240308210519.2986-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mtu9WjXr40WaZ2ID4AXRXUusZwL9r7IBbaUfGB7C3QwidQdllXb
 lJFb8UHCwQAT5k/dx9avOSubQuFGgfSuPq+861b1tMVB4qP1TtMSkaPnrfMDp+Pzd4uKb2k
 DR3zItvG8MBcHwhzeI/JnLo+qxadtq3MFk90IWByj24XuD4mRxXklSBMjIk8Eyrv1Sr/4bX
 uHmyzoQ+p/tXj1I6w9Z+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4NUKyOK3Rx4=;G11GCJfi82Dmn84z8Oo9Twa3FU4
 MsE4DPtcljrVZChUY+iZzezsOLEOS+f7ONKrNrt4RVHkYVeD8+lI2h7rSZTJPTPP0w0raE08Y
 csF12pKVBNxt8ydffMoBssbHJeZOE64nSv9IPFYFbSS0ui0jUoFE4xJMtQYsleYckihyr3RYE
 SHqQBoyTW5cEO1HlgqsbxtuuYpfLfpsXJA0ZNAYQwX1QJlJgJ2LRyjID7TPwVqb0Hxvwup59n
 gnwBW6R5xhtX6XAgfuqKTNxB1qLqpjlVDm54LkR2FJGaG0Y5WIOFb5l9VoudRepZasuCeWNYq
 VsCK0oivqMg5xRDRh+GspcxheU0/cKMxh1Rfke/VNo32g6115FMmYbC4uv/Qu4xPZh+9/N8Ue
 G8vo/5fvJkIuqXBBjHF87UNLsvI2rLqEv3NVwypSww8crLJF/o6M0UjOwJIV5Dm4Z3FcMPn7s
 Hh9LWusoMfCB1/BSUzATggyZo1Tu10K8ZgDLYvOGW11otJIdlRYylLEno1ni5ADe5Ev2komJc
 0/FpOtwOku4LKXTJXpaf2+ujaBDgNp40y0LGKMJDJdvKsfj4DO2eQjXugls8TWEpgq3sOF+Zv
 UHBkLae8zO+RYuH537dOvaJ34MabSmG5f7uKVQM00iCjOno8qEgLQ9uldJPJHHAM2W0B7cBJi
 QXxWGBOohi0mp7rPLrhxZ+vyzVBkiDpJqc+xMtv8SOzWj8JSoeqSKPKlC6HhIB64hEPKijv1h
 zEJXILT5EIFnt3Ner4gf4ZgF268/3vYQLK04lQ1XVDGODqOd6oY8jIF8Ajvkqb/UFLNcOByGI
 VM46RCMh/AI+WEAolS3M2SDbY7pcWnZ8322BeKvPTodQ0=

The ACPI EC address space handler currently only supports
reading/writing 8 bit values. Some firmware implementations however
want to access for example 16 bit values, which is prefectly legal
according to the ACPI spec.

Add support for reading/writing such values.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v3:
- change type of variable i to size_t

Changes since v2:
- fix address overflow check

Changes since v1:
- use BITS_PER_BYTE
- validate that number of bytes to read/write does not overflow the
  address
=2D--
 drivers/platform/x86/wmi.c | 49 ++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1920e115da89..d9bf6d452b3a 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_dev, st=
ruct platform_device *pdev)
 	return 0;
 }

+static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
+{
+	size_t i;
+	int ret;
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
+	size_t i;
+	int ret;
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
@@ -1162,27 +1190,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physi=
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


