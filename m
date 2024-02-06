Return-Path: <linux-kernel+bounces-55668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80484BFBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE461F23919
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790CF1C287;
	Tue,  6 Feb 2024 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="R+CIzvPJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB111BC30;
	Tue,  6 Feb 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257112; cv=none; b=E3u0lXqjoBvYiaicoiw3u0uzUCmnQV6qoPG+J7PnChB0sVlKNRPIu24e1GLUA7Wgi1/Pwes7Ybf0VyzQutxKzKh291/bZ62jGA75yLgE1/zD0SLtDa91xKYCAV0cmgHk6yiALpRqD5HxYspG+Wo0mIx80IwKFsZ4wSFKPpZnp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257112; c=relaxed/simple;
	bh=YBOlzgKtDMyIfKshatb5mZPaRTlCvs+Ik0B0XiYSl0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvdt6BZHm5e8PeEvY/sAzuxnOop+ar7yyVXydg2B7F/EEjdJQyj2QEOTd7U9xj0EYDDABhm43fEdK1ydYH1sYAMEaIaktnWwxDy0Sf7iOJcc1jhp00manr6NxM8tLgEQJH/wiOUoc/jSsbo2X+wPrSythML+uanAEaga3OrgKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=R+CIzvPJ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707257102; x=1707861902; i=w_armin@gmx.de;
	bh=YBOlzgKtDMyIfKshatb5mZPaRTlCvs+Ik0B0XiYSl0E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=R+CIzvPJcnB6k0Ob/X3LYMzXw75VcSoB0fWXvwIWdAc9Ou8/lgk5SRnEozUmc0Ui
	 WXguSi5ihsIb+JbzPPWJ5IXJpW4BSSDjcho2+0GtNb5eC5yEGiNf1QZDfsyPNWgFH
	 Mlf0DZQxpNradPhLXpFSQXWRdnDSt8zX93qSWp+2g75v3Dibh03bgZqaaIweBzCeZ
	 aXeWJ4dlqU2OB7KzMiavVhozySbNYNV7Epl2gsovE2R7F5WTa+08xOZ+MZVKCMkWe
	 OsFxLeDD2zvAaWg8TO9DLa7FZqO5skCydOkQ0oVudCu0PrZGIT5KyMGrNPrfTBFNL
	 B1l6W107z44OYWfpcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MdvmO-1qygm03PHS-00b6qU; Tue, 06 Feb 2024 23:05:02 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: wmi: Use FW_BUG when warning about missing control methods
Date: Tue,  6 Feb 2024 23:04:45 +0100
Message-Id: <20240206220447.3102-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206220447.3102-1-W_Armin@gmx.de>
References: <20240206220447.3102-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xsnmaZxeuG9ddF4HDj+QsOlnZD4yimW1Y6akEJN8yys8VKBUiiI
 4q5Z8t6yeou6Z0msdKhCTRMXG4w+XA/t4t493ZtU0HjS/OrPbxJru18+75IhojepYjCkE2U
 +J9v/bRTKZBVxZuPUDGTiFUhFAwId+gLi9lmDNEO9fkzbE3QKD7XNTm1MBf8nbv/6EcV8Gz
 cIGwF5jMym2UqMUfJbr0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d5RavgR5U4k=;pfOK4XPpO33tSCRC7M9m4bi9kFK
 rPrlyF25/eHhz8Sibr6/q/p4FL4rLAoRb2Le/YPGyelCJTxa5N9j/m+yQrKuE4JFiZ409d9JU
 e7cZA5FBc1ZdpKoeLSKs/pFVF75crO0Huhg5t1kBOjQrPTEl/22cXKp5jz7XMZM2aCc/wfwwa
 GdeWivrKymAC0pxigQ/jZWVB7Vf8qZSgLzKA1srEk8fasm72Jmr5KTDp787ydMRXH0/wfAAVi
 5uXZg5RfHCm/SrOpPykmmaZvQVoCjdUqpBqUMdqR76tT4cYUtm1Uj/9pxgB0Gm2rV5/aXBefB
 SdFk3TLF1j1L2cW356JjIK9aq/39buWAa6qwn2h3ZAGABjsh4JtZ4obe3XEZMgXZdUsmEdKLv
 lBaHn6A76O60IO+5eXcFcU7pmzyGXlasYDGeMDyewl4pxF++eITb8OfSNCPmhVntM/zkTAjaX
 XNO1Ij5EA3GF/4oB7nbkf3Qdiu/6OaNf+zeawVn5mYd+hJU5YvDizQTfCp1cpeSQlH8R9w0sz
 L8oCAIHNzUa9p16VwQOCTJMcLOWgTyFt2uDBE7UtlOYfOWki5eH6ltKaLrUjJ6HHQDCNNA6h5
 V4/wnkutuSf3qowmzP4Z11aQ8QWrlflRg74zqnVqRa7FZxwHU3B1YhLYlfEB4rGLPHayz7Gtf
 heyCtPqXv8tCWHNbwuAh50TNyObEJdikaly3GRVLtPVPs1M+WB6ZLNU9gMBX2WdwyYXXE2XdS
 5A2kAsO4N0NYt/rXYuLsKraoxkh8KXsJalCWky2tTJm88G3GIk3volj4yU/T+cifwycLnNbXm
 SFxTNFax5DgWMagXUV20LKr6O5L5NHRKz0Tvt2+nK7Ask=

A missing WQxx control method is a firmware bug and should be
marked as such using FW_BUG so that users know that the issue
is not a kernel issue.
Since get_subobj_info() might fail even if the control method
is present, we need to print the warning only if acpi_get_handle()
fails.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 39 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 9d544c85e5a8..545d6696d7cb 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -132,26 +132,6 @@ static const void *find_guid_context(struct wmi_block=
 *wblock,
 	return NULL;
 }

-static int get_subobj_info(acpi_handle handle, const char *pathname,
-			   struct acpi_device_info **info)
-{
-	acpi_handle subobj_handle;
-	acpi_status status;
-
-	status =3D acpi_get_handle(handle, pathname, &subobj_handle);
-	if (status =3D=3D AE_NOT_FOUND)
-		return -ENOENT;
-
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	status =3D acpi_get_object_info(subobj_handle, info);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	return 0;
-}
-
 static acpi_status wmi_method_enable(struct wmi_block *wblock, bool enabl=
e)
 {
 	struct guid_block *block;
@@ -979,9 +959,10 @@ static int wmi_create_device(struct device *wmi_bus_d=
ev,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
 {
-	struct acpi_device_info *info;
 	char method[WMI_ACPI_METHOD_NAME_SIZE];
-	int result;
+	struct acpi_device_info *info;
+	acpi_handle method_handle;
+	acpi_status status;
 	uint count;

 	if (wblock->gblock.flags & ACPI_WMI_EVENT) {
@@ -1009,15 +990,19 @@ static int wmi_create_device(struct device *wmi_bus=
_dev,
 	 * we ignore this data block.
 	 */
 	get_acpi_method_name(wblock, 'Q', method);
-	result =3D get_subobj_info(device->handle, method, &info);
-
-	if (result) {
+	status =3D acpi_get_handle(device->handle, method, &method_handle);
+	if (ACPI_FAILURE(status)) {
 		dev_warn(wmi_bus_dev,
-			 "%s data block query control method not found\n",
+			 FW_BUG "%s data block query control method not found\n",
 			 method);
-		return result;
+
+		return -ENXIO;
 	}

+	status =3D acpi_get_object_info(method_handle, &info);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
 	wblock->dev.dev.type =3D &wmi_type_data;

 	/*
=2D-
2.39.2


