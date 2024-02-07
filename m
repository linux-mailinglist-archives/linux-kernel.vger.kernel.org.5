Return-Path: <linux-kernel+bounces-57007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7F784D2CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A010281B78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6991272B5;
	Wed,  7 Feb 2024 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qCwrbggk"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06F126F01;
	Wed,  7 Feb 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337225; cv=none; b=YHAoZ4+kenQGZLQppLXuI9fTRF82uXVDoQ9PsjzS1tnzrYAlSSnU+IyTdngQC5gBEtefnWEgIXGsayVnWC0J1colicDGvgjNbSPi4DbmnmzPZ0WecBZR6/AvyrxoT2Yajj6TqMxkjhfc3Naa8+OiVHxGQqx52l6+bDBocOHLXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337225; c=relaxed/simple;
	bh=Y20V3UzkaqA6wx/OLf/e4o3IW92eIo5mtjOtCYkhvhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GLGabYfPYODpRuLJMHk3PFoT+VAIAnRlmhIiOZri96bHMuJuUq7PHzbKQtj4b7j+e/M3cAAIt8aPmNTJqwCeicakbstpdGT+Q9Y/YQGwQWlCxaFJ+1sN4o6LBi+KW/9nqJtVjEKg74NsgmpQslJe6/3xhnuH3O6pTpfcbDMfVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qCwrbggk; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707337215; x=1707942015; i=w_armin@gmx.de;
	bh=Y20V3UzkaqA6wx/OLf/e4o3IW92eIo5mtjOtCYkhvhc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=qCwrbggk2YaiVuLiD/45AxLNkorhXfpC9zoSqP8otrLlYGp7Y6glF8jNnsV5mAxr
	 CRKnX9QVmLen1HVs28a39fwRLmx6qTQnbPx/dipWdvb3iqZhnuiPK0f8Ym09KHrfK
	 THiNrgT0Lk7HnQ/BoLgFTlKSZYUgXn/6Tr7bfRkFhyuTDNKoH2XccIIP2q1XdH/eq
	 oVydlJ1JNTL50eKLYGIGUkQfLUkrwIqrZOsnr229wneTepykQ6Tnij/+VOxYPY5oZ
	 w1kLvcyNsqYazDScIQ9N5lepiZq9xcUHlK30sKFWXQoODheIXdEP3izCbkwJqZUax
	 SpqzKHzpsj0Sac43Xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2f5T-1raIAi0gYh-004AJG; Wed, 07 Feb 2024 21:20:15 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi: Make input buffer madatory when evaulating methods
Date: Wed,  7 Feb 2024 21:20:12 +0100
Message-Id: <20240207202012.3506-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3aVsqHOvhZZkL6tEUxNKYoS/mZgb807r4CifOkC1PmJXBmfOLIF
 uSuD2lAxXWIZPGhsXpt05mD7PY3lHxm3bui7IZsT1uzl2AWOfsV29G+plMBaGBg6YaEJHtF
 fhsT3O5awtDDOHmymg4da15+1RqLBl/zW9+ebQQqHI5BkWbDUIJQtR8OnImvxxX1Qda5sKD
 c8IkMiq0zVQ2vSb927mvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GB9CGCrhmE0=;DXg19GSNS+0KObxmVvH1qe6KNi0
 w1YRx2K0dQMj2Eqn8ohC+8TTRuNxg6625L/HlejmZWqPW8OH/4e0hoT/cEPkrhfKkTXaRrTiR
 GfRB1lOkQxjYdMv2zV2rUsCRkNRlrhjYT7H+2lcJZJZsgQWRuczQGMq9PlWUTpWIsCLy4v4Bj
 xjGbCwWdsZ5IKLQa3EaoEA9Ca4/G/JBdXtI8oj1ZBAKkSryF/OGostwr2JSCga6JOdLzgB5wV
 FEYYaotfAKAp8EG4glBuY9/UfWSrupvhiIVH2dqJ22zP5+pOo8Zy4nt0Cnj7TcglGn7HJZ4KF
 v2hkE980fRdUkxZKQJnmeX+jP6WfKLuWYYIS3HJtrK4BEhwyodbQBDUSMIqeX5Zinxc0dKu+w
 KyL2MfmAq36L+fAkl2flzQjzsU2JG7Bp0h44WGtYgRJve+Otm5ad0p2cuzDBKqHEr5fouNrZP
 ifpJ6whl7NDHkdzvfxm41q75WmK4GWEJ6SFPm+5x+08Ao8ZBE9qBnqCDeO+qS1Rh3caeXsVDI
 LywdfHERYfq6+SFk4KOYfoF15dyyTwkcd0nL40WRLizBsZe1CpGAZaNqo492Slsj4zWpr474V
 kwTX6ePzj5e2jfxkRhyLcSFypykko57Vv7QwriEqxs9NoffaMomaBqOq77n7CiuR7Z2s5Nhh3
 jWq9tU02z0ZgS/L651+wF0tVrVYEGtjD0ThVOdQ0rlqmdJ6DV90kYAkZY2H1HYo5hDYyyeAnu
 dDOen5/6ioapTjhpxn2Vy11qH4leBzSCpCPdce7bfvBqrYUmU8uKnHIM84ILPsbS9xvM2FeGT
 e4YQN5gBnJTKc1la06+/I2ReLuvQbOOo6BdmQfc/H2VoQ=

The ACPI-WMI specification declares that a WMxx control method takes
3 arguments: instance, method id and argument buffer. This is also
the case even when the underlying WMI method does not have any
input arguments.

So if a WMI driver evaluates a WMI method without passing an input
buffer, ACPICA will log a warning complaining that the third argument
is missing.

Prevent this by checking that a input buffer was passed, and return
an error if this was not the case.

Tested on a Asus PRIME B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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


