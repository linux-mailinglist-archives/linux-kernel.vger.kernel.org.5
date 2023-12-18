Return-Path: <linux-kernel+bounces-4323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3091817B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992B71F23518
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FC273477;
	Mon, 18 Dec 2023 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jbBqZXc9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BB740B4;
	Mon, 18 Dec 2023 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702929344; x=1703534144; i=w_armin@gmx.de;
	bh=8xcRS4toKnQj2X27ThuiST1cF613b/lRiEqma2uezJw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=jbBqZXc9Fm79pEyNs39kyQOUq7iV1cgb3v6jxexwGyeiTscBEi1bOcDP3UXeLJRS
	 dY+tIHWI+ikGrZt+MmT/WjGZNC9ieOvvSmRKAbzllsQcA9ZeVEUG9NRUY1ASIxhGO
	 V1I0Zd5yM0w4EcnEsPJgq3+qJkOoWbHa2FXPF8jwTYGD7nVt7Bsup6aiwOAynFIjW
	 jJkEAe31nxDISQXV//XFTloO9of5DHVtTw+7FF+Ms1jrQsXOOmWPVI3RDlE0WM45n
	 6KuDmCzwONZPddEyvPPMis2hKnHD/DDUdeYeJjkricAU7gT2Ujo6whItjSPnW451B
	 u3IrODDU70qziUyGpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MfHAH-1qnQcd12N9-00gtMg; Mon, 18 Dec 2023 20:55:44 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] platform/x86: wmi: Simplify get_subobj_info()
Date: Mon, 18 Dec 2023 20:55:31 +0100
Message-Id: <20231218195531.311179-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218195531.311179-1-W_Armin@gmx.de>
References: <20231218195531.311179-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y/Bdzz5LQ5l5DH6SFsP2N/veEnWbKrmkgn6CIDbxPduIi6hazLh
 UuiTS1T+DL5GydIrKi57aoR9hruokDMtH2VKiyVtJGZzIhfxul8fIbcSbt3EMbWRd/W8UVJ
 5MpzSdJsCRvtaSwdi+VXG0dUbqfipewjIdfR1v9U3/U5z2u8zDn0FRWBXVh/taVRTq46L3E
 QgCvZlqMUvTE7Z5rLo1yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HbMWm1LXyxI=;ZMhIXv2exx6aSMr9mmjEsbuvd0Q
 oeY+A/3BgWhQ6uyTAvqYSlHnBXcouVqEz74re3YguoqtaP30RKceTuSVxoo3EPh+mROJ7XS7D
 /kV6OuTWMfnslAojWuQaZTg++/Pn/PmTeq1bbQhWpj22HhqxsYN/roSQQEyZpiwSqIVBb2gFz
 LOJbH3ow0FZ8LSOIiI+J6KGwmu1Ag5stc3Sw9iZdaHNvFZvJAzqAC8LTVMN0S8P9rJb597XQY
 S3z+p7vpsNxxYLEKgS1DCFDSn655zg230UAs6qaPX8vvp5mByUIV5B0b778QDSwqAtwRnTFaJ
 5wROdlo3LnOHnJHDvVLIG2d27Yr+8zRrGcYzb9QB4zpbJWbE4pqvWa1TTF2Ld0FMKzw3fCvfs
 dPd8B8bnR6FTlkmnFRu3lBOjJE0IARP0KPB5v0aAUAoihtQ64WN9/FzpnVcShvWYQAB+eyFEM
 6Px8X4Az84qDocwC/KUWGhkSMO7M9TusWS+3rsVl3B19ra0OamG35frpzD+NS00UJ+jSSLypJ
 L6R7VEGJJ/t+9BQsL2XNiIJGuX8rGhCiNLobV5d8zRoQPgVdzeGfjsr1ke1w7kV5PexQ/RPN4
 nXwFtTw2VIsdt12UiyknyfWgir+jKKV6q3e6qBQxoK33XJnAqGKUkzKROxNgFUf43N7OGXCIh
 MURmClzMCbZjHjw4mqYoASC50OOJ67qnSnYE9foI20oyJm/5+eRXueVxC+eo4Wuav9jl/pCSy
 bEx7YH19Bx/2sZqdrOnpT+xFbmO3vjdgKVw92SJTN5E+B0wBz9WJ3yL4FoeOBSjUtpLl/2P0w
 IgVrfectfMbSkb3xaZw6/9QlZ2oXo0L9vZ0+uNuiL0pIIrAGj7uLVUHdWt99CoAM6cFkj7mBZ
 lZMM3ScpD8W6D/oY2/TSwDeGAhn1+gwqbY3xELOP8iabRJdyviJ4DaGmEOAk/m+esmc/CEknL
 O1pffGWm/FSARtS/pXhLyZyi6SM=

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


