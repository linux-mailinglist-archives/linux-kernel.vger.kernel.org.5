Return-Path: <linux-kernel+bounces-128134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 577D58956AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4125B23DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236CF1292CA;
	Tue,  2 Apr 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YP+9/42D"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031D17F3;
	Tue,  2 Apr 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068276; cv=none; b=KSuy6UQN3MSfclaLnlqqLAnOQc6vfryMMKQuLgAZzDvQH5rIxdQwBJK/oxhQ65Ui8+J4ey4RNxk1bgtp54faIhP5jZ6Ss4AMABYUajeo0yim3MPwktStIqjNQ0FdRhFaU6CBjo8bPrtnZXnCf+oWmjddWjuPgIho+vsU8XrN4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068276; c=relaxed/simple;
	bh=NYmtOecKlLyzO3nfLMqfP9YJByKvOkIZO/4pDmRw5vg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzrW8M62xp5YytkbjkVarLVPVPQeCRURg9KUAlBYZ7T5fr8FbSOR5iBfqAA/FYHuAKj7PFOU1BvtSEaETpU+vdhphj8vX3AfqVKd5gIK6oIj27xt1QM7DAmNhsfWHRoYMQB7me5MR6g0PT1QcgmuiQd3e6x9MueyeEHLVcNSEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YP+9/42D; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712068263; x=1712673063; i=w_armin@gmx.de;
	bh=RwQaqFwNpLwiUaZNu6AXD2WMwZk2ta/0PgKPGIo7pDU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=YP+9/42DlR6D3HEkpeMMp7fISgGBGI0zbTfhtNIlrjsD8Sp4gslKjbipYxPIRVkX
	 0LfWSwoHR3SUrHF1kLRFgeaT5vn/vtbS5gqZSxUjon6tv8S/c4C6BVUvgwwRaBIOw
	 XWCUG0XLRY+OoONjs3c494f3obdqW5/QHb2IFejMGNWQMWHpK/yUnhBJasGG2TgHX
	 zPp43C6swgXrO+GHmdflY7RLoiydKToaMWO3sIPBLwLjelxuAA0pq9yoi2Al9mcxW
	 l81aJwHTnPmsaz9/Ai2mWPfgYPXs3Aml0yuArDuP4m9vBKH23M9GeQI7K+H+0VYAY
	 9Yds5U+WJppcTGz4LQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N0G1d-1smlf60Chz-00xHS1; Tue, 02 Apr 2024 16:31:03 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] platform/x86: wmi: Mark simple WMI drivers as legacy-free
Date: Tue,  2 Apr 2024 16:30:56 +0200
Message-Id: <20240402143059.8456-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dtSjc7LZamFk+Gy/7gLU9y0Uon9xGkle8LMwgaUZ6ChQ1P1wyFV
 7tSOcK7dc5LNU100bDBSPR0apxI6S7SR64t0AtwnNIdkZU7h3/38hOG9qSN1tK98//2dZPm
 lwhrw2FQ0Z4lYnUvqFPIiSlvMrVWqpdF9FDaXXXilWqB2XmtuY3C0bPNP4xL3YixcSsdzif
 TewC2uk8TFlXrW2C5KaSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RMvd0Pwq79Y=;YURxJ9+LhdA4F4u7rOfTe6Eajek
 0jh1KOSPVrrQVr8aOOOapjQoMc005rzLyFf3Wq5eawD0zjmyWB7KLpj3Xmcpw/zvvtKgC7vYv
 hmACSoqoH8nn97CI/rQFn58UQqFR6bJH/W5WUnL7g999kxG/4LldQTF/YfKbccqH0lxuBSk1O
 SIHj/0EnzV/H7RkPW0Pm9Hm5Ssf1heCAtbCx3LWhvqFhq0Duxfn5vAyzBL/w69DwdgFYuELrd
 ELhFfVIoMhjG4145uFcWbrI/klADQTaULudrlBzZbCYcAfBK5hLozAgvbVd6tGKy/DSlwEFjd
 XrqUBxlTMTHzW0lCL3yUdCewsydDKBsDJ4PcINDvE0NuK6ofbE51QCwQSk/Z9dNDV6qdFA8jy
 G4enrSIODs7yil3O8gu5npv7wVBIo5F753yM9889VRmt4CKsdwT99/gTWokxB4GEXIB42njoF
 PD7ubnkFbFHIBF3w/kjFVkNQPvnqmXfmcAachLP0lAtMO0JIDYaqGZj+WKB9GROyyKvfBC6Hr
 RpdDsKNYmqwGyUU8lO2Uh8e71P9sF4ZsQ+L8KYPtsqXtVYkFx3qTxRFVA9+QUpF6Y6dgpEgaC
 BLQRK5JL+HrBFJTF/5dMiy6Y2JFAR7SQspul+nySzDlvINTP8z8Fs4QmN80MfKjDIHrtS5pHi
 vSsFSODE2t0aBUWoaPkZdb52bTNfYz1+RYGfkIHWBz2EtyD6NOL8Ty7WyHL3xaJl5r0hWXbOT
 6Hy9atdqmv4y9TuQG2r84b3lcZ/y9xfAlFA1JDaOEz+jtzGXUwJXh6WmhQsODxvm3fBNSP93x
 N/Ek1AAOLHUpBhjxMTMJsliXk41o15opng8Dc1247tFC0=

The inspur_platform_profile driver and the xiaomi-wmi driver both
meet the requirements for modern WMI drivers, as they both do not
use the legacy GUID-based interface and can be safely instantiated
multiple times.

Mark them both as legacy-free using the no_singleton flag.

Compile-tested only.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.=
intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- add Reviewed-by tag
=2D--
 drivers/platform/x86/inspur_platform_profile.c | 1 +
 drivers/platform/x86/xiaomi-wmi.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/plat=
form/x86/inspur_platform_profile.c
index 743705bddda3..8440defa6788 100644
=2D-- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -207,6 +207,7 @@ static struct wmi_driver inspur_wmi_driver =3D {
 	.id_table =3D inspur_wmi_id_table,
 	.probe =3D inspur_wmi_probe,
 	.remove =3D inspur_wmi_remove,
+	.no_singleton =3D true,
 };

 module_wmi_driver(inspur_wmi_driver);
diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiao=
mi-wmi.c
index 54a2546bb93b..1f5f108d87c0 100644
=2D-- a/drivers/platform/x86/xiaomi-wmi.c
+++ b/drivers/platform/x86/xiaomi-wmi.c
@@ -83,6 +83,7 @@ static struct wmi_driver xiaomi_wmi_driver =3D {
 	.id_table =3D xiaomi_wmi_id_table,
 	.probe =3D xiaomi_wmi_probe,
 	.notify =3D xiaomi_wmi_notify,
+	.no_singleton =3D true,
 };
 module_wmi_driver(xiaomi_wmi_driver);

=2D-
2.39.2


