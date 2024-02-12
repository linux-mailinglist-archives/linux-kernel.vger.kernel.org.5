Return-Path: <linux-kernel+bounces-62227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16F1851D51
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8755D1F245CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A3045014;
	Mon, 12 Feb 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="g4LAiLuL"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28CB40BED;
	Mon, 12 Feb 2024 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763835; cv=none; b=oV6nT+x+f3bauhtrA/+l5JCNKybQwcM9bQSpllWpQLzwOkLf1D5M4DO7qnjV47WcQTlk8vhTqis34KM0YsfYcm4DvTuVXudfsag5a1mNhzrhDeOpxzA5VMlFJ3FKw0huOIbjSLZtkgsBcKAE3tjeW0tZHLmao1jRx8bcnkwgzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763835; c=relaxed/simple;
	bh=OaBvBiTGUiwCLcN4iX8qbX37EqEth2DdHe8eZKM6cz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=npSHWsxp/A+jovMn0sJotAdmL1NiR4PXvw3li7kbOVvbmAdKN2ZgxWlwbOlQYYYdQ4n6zB4YFI6VUtAuZoJz3GVe26UeMsq1O5+s0gL/+Fh4/zfsIfDviD85kR8k/BFHupQo40btG+nOTo0LHe4bQxb1OKzUChEr6fqKxGj6aRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=g4LAiLuL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707763823; x=1708368623; i=w_armin@gmx.de;
	bh=OaBvBiTGUiwCLcN4iX8qbX37EqEth2DdHe8eZKM6cz8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=g4LAiLuLBDH6uWyyDFZ3rG3IROL/AER7xFJfapfPEM+CTatqxcTdlcjswHC69EHJ
	 5hZrRJBXH34o20MxHgWvNxToAbtbH6343GvHBOD3olTHRlyE4Df/ka2gNgdYtZwvF
	 sC17gWMUopfLq0yYSev1r6G350758vqjBZZDelyA15q461H8NV56MQbMkHGVB1O4L
	 PdSOx5/5vtz1mMrk2f6CANrdrjRlQ0dZbZXlaicD9zZ4LXzGdQSPohJ9AXso7Zahf
	 CoILx6XRsdVfv1RTBj/ubwKcPqHJWa5pU4340KPu45UA2SNjgQHBETkQG098GTNEB
	 1EqI44tZfgWD8yDqaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MowKc-1rC4Wn1rrS-00qTgy; Mon, 12 Feb 2024 19:50:23 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: wmi: Make input buffer madatory when evaulating methods
Date: Mon, 12 Feb 2024 19:50:16 +0100
Message-Id: <20240212185016.5494-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O8IROVyt86Fl1e27xS7q23A9N/P5obLbpJxwBLTdsAk+RTWY+uu
 vlenLHJNVfpSiPDsPPVvMAZWa0hanQ1MFhTWSQtuJaUfR6MWLAkLVE98KadxYa/giB9KJ2i
 XdlzQtV1N7JcmzaXRT1id1Nk3//TT0q/Soi/rdxNJcAhP6wiL9XKwn10IMBgUkBaQ2qv1HN
 vsvmotU5lPtrq1Jr1toJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TZE+uP34Amc=;PUo8oRdN3+QqLhxqNiCHyiVhK1k
 /bhA5QLOcZngE2fZMAxmmaPOrXMwNyxMTV/qnUFFXIO9xXCXPxegJJIoEjdmRvbCloe4t+cvf
 owHHNLhfu8nAa36RROAdwNrm37APuyKdRgw5MrNw6uxmOrEeDwlVLVinqz630r1KCZcY8NLtz
 aedNXHHelyuox3zF8he3Ro3z3vqE93OIhJiT66HKmqkTkk8xa1t66hc/ZmUXJL9NqTVSsOxwL
 uZ0kZfQ2D7oZeqkZGPeqNmNMZ+nziUStX4mjVM12ZLMQvoehN9IxQyfh4mh/YsRE6poeEnZw9
 16C8+9pc7536PBfiprpqsjUSE2DvJWPRji6zFvbhIIXtcH6c8cO8z3uy5SVYHHNmm4j1hpyTS
 zzmCN9NZS/nMC66N+GnREDETkoYjHSspE9SXccU7sY/9MjKOmRvEps37CezKxMljh0rEduWfM
 x1Y1mJkc0EPKnlN4wkiJC34BwMZ+oeus6pO1tq2HCo/X0fhQkTBy4Hnf6O5JnZGEvTSrleNip
 7GIq/hKmyUBd/JppcZLc1zxLpoHidpiKBVw+JJxlDO+o1TI+hicg7Tx7fRzjoKXbkN5pGh7kv
 ZfktqNhbXDBBhQe4LmLTaldZpuvLQZg2MPuKl6ECKbagxuzHg0nuVusLd3bTJGHu5ZZtAaU34
 eMwq9BMwOmmcTMlFEb1FRqMnS8UM/EuqE6qw33FoKPgGWPa8WDum9rRhock13nU2yp/am52Cm
 de9elkiE3xFLFcRgO2/z2bbuCy/bRa6cAoodaS0tfoXDjG8PRNyhLU2bhCuT6Nfkiuq+nFoc1
 k8S0sOlTgL6fhZ95JmNuSVTOAirGyvO9fbp4mrjveChO0=

The ACPI-WMI specification declares in the section "ACPI Control Method
Naming Conventions and Functionality for Windows 2000 Instrumentation"
that a WMxx control method takes 3 arguments: instance, method id and
argument buffer.
This is also the case even when the underlying WMI method does not
have any input arguments.

So if a WMI driver evaluates a WMI method without passing an input
buffer, ACPICA will log a warning complaining that the third argument
is missing.

Prevent this by checking that a input buffer was passed, and return
an error if this was not the case.

Tested on a Asus PRIME B650-Plus.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.=
intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- add section reference
- add Reviewed-by
=2D--
 drivers/platform/x86/wmi.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 63906fdd0abf..f9e23d491dd9 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -296,7 +296,7 @@ EXPORT_SYMBOL_GPL(wmidev_instance_count);
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
  * @instance: Instance index
  * @method_id: Method ID to call
- * @in: Buffer containing input for the method call
+ * @in: Mandatory buffer containing input for the method call
  * @out: Empty buffer to return the method results
  *
  * Call an ACPI-WMI method, the caller must free @out.
@@ -326,7 +326,7 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
  * @wdev: A wmi bus device from a driver
  * @instance: Instance index
  * @method_id: Method ID to call
- * @in: Buffer containing input for the method call
+ * @in: Mandatory buffer containing input for the method call
  * @out: Empty buffer to return the method results
  *
  * Call an ACPI-WMI method, the caller must free @out.
@@ -347,26 +347,25 @@ acpi_status wmidev_evaluate_method(struct wmi_device=
 *wdev, u8 instance, u32 met
 	block =3D &wblock->gblock;
 	handle =3D wblock->acpi_device->handle;

+	if (!in)
+		return AE_BAD_DATA;
+
 	if (!(block->flags & ACPI_WMI_METHOD))
 		return AE_BAD_DATA;

 	if (block->instance_count <=3D instance)
 		return AE_BAD_PARAMETER;

-	input.count =3D 2;
+	input.count =3D 3;
 	input.pointer =3D params;
+
 	params[0].type =3D ACPI_TYPE_INTEGER;
 	params[0].integer.value =3D instance;
 	params[1].type =3D ACPI_TYPE_INTEGER;
 	params[1].integer.value =3D method_id;
-
-	if (in) {
-		input.count =3D 3;
-
-		params[2].type =3D get_param_acpi_type(wblock);
-		params[2].buffer.length =3D in->length;
-		params[2].buffer.pointer =3D in->pointer;
-	}
+	params[2].type =3D get_param_acpi_type(wblock);
+	params[2].buffer.length =3D in->length;
+	params[2].buffer.pointer =3D in->pointer;

 	get_acpi_method_name(wblock, 'M', method);

=2D-
2.39.2


