Return-Path: <linux-kernel+bounces-122269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A788F47C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E93D299294
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02D31CD13;
	Thu, 28 Mar 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="sYYo2Cnb"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4313C0B;
	Thu, 28 Mar 2024 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589032; cv=none; b=NIVn2s3JbRubycKwpjMChlosp0V+FtMADlGC6O+QCKhrqGPXeliIHMwbKSbLIpC9Sv9JqpCXTaUzqKy383h2aQCIldhYRgUjl956egMIxI4mI8maUorr+PYi+9OxBJqPDdzwbIcDjQQnuB7rb9aZuePU1HEaEgSgoSFTRx+LYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589032; c=relaxed/simple;
	bh=T0T9YUccKe5ykxrxiRSJ6xLuvwRieLVLUQyXUW6FCUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l4edyFiYwxe/9U9FX53TG8Yo0OsGbXXriGDc8Ib/DmXHYt5FnGvy9GmyPYUtmxfspltmYTjS4Qw9LqLsbhtZz/gX0VtUBR96DJC3kdeUpPfnpvE3f2xKAXVjRl4ARTdsCVW61Y7Q1i1OUNvEDoNj07T2SK9PL9d9tRo/cnFMC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=sYYo2Cnb; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711589019; x=1712193819; i=w_armin@gmx.de;
	bh=r/peN7AGjQutxOUwkE2P5/6QxGbI63sh41gzdDoKsO0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=sYYo2CnbaRKXq2r73+imMB0pQvK1qdl9u3+yK57ZZ5Iztz8KlK+mpbo7FNs1FDyv
	 xMiBCwCwUSMarCJfCAmd7DZv3CQRM7OJ8YTNkZyNCz9eXs244GVILBBkkgC4bkz0w
	 5RkP8YQsMEFT4wEYl3RHoMtsn387PMOyRAC5SjpFxGRTAt2LbXTbZA7V2amNuCkvh
	 IlQCeANRmlfgck6vL/w4mEmtUMRizGmVfoVkBDBRIrwbutlQKBkPiiDdkunmMJzcT
	 MC/rfM2dMs0hIkzvL75TvCfc0hOe4rnN/SYmhs036X+qEvtVaUAmw0uRZjWMtt/PD
	 ZZPAhsZHFgyBtq2dCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M6UZv-1rwYN943HF-006sgJ; Thu, 28 Mar 2024 02:23:39 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: wmi: Mark simple WMI drivers as legacy-free
Date: Thu, 28 Mar 2024 02:23:33 +0100
Message-Id: <20240328012336.145612-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yC2vVWcihw+Nuk8DKQKmxXdwbrFyFLV7FIp1sxxDiQCIrgF0qFK
 wBhWyK+m4gdeZ/HJBolj+PHKbOX1WKbN78gWBq0B3DlNx4TMJKMd5aiv8X5gnCBpV9cE9BT
 gJ7aVAJuZEjxb4f+AbW+9WLQT4eYPfRtOKHah8Dv1WfgFP23oAegW2XxZwmAkJCMsD3PO9p
 icB6aYDCexZ+MadwUmf3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iwDdzcEEZO0=;D9eUlUbAWlGlnijVtbOo4cbm+5q
 Whv1Ima8PmkdwvNV16SoIyIMuUAzQLqWeKx9NiQpwKg5e4kjSBDicSn3VyS2lgOs0quo6VQVL
 RO6ed5u6YMD2pDFOlh8MPAFWroO7GDsXSK06E6ssK67GXz5B9/WjEnEUm2M+7k5zQnA4eynJe
 Pd5OLJ/MLMymefPz6CeEWBM+97dyYmwDpiBIPKgIXatOmeaKMeev7oFUXdwKVi2Aq6DpHavao
 nK4/WgLqHzfcIMooeHuLZTa9y57Scei06+xBqdTzaEOz6sI500i5Q6m3UqX/jNSOjmjYof3CG
 80ifpKCLcqsNt6T4YItxB1qBhsxhK/jsqWRE59UGCYu4uR5+DYGFbZ/lZ0gQoJ+E4MqQh8bIB
 xTX84f4NIz00JxAuz1o4azJKDwMm1bTy5nRhnljxhcSVftNxiBfIpvYpswG489uluITexUxpA
 N25OaArHnX+4SP5BwNitlqhT2CKI0AwoeDUSaIAuBr3PM9YEP8pViXolBmlQAqJ57mLI8rVTD
 Ba6LPksi7xgMT0YX+s0mnj+Ou6KAy7AZNePBnyGGB6tBjpX4vFThrgyesz/H9a0Jdsp3AX9Vm
 3A/9aptnP1SI45d0DCFkvvUbREKSJUGj8LG6aetLszFAIUolr5ptvRhByVwD9sejwak5gzAEU
 /ynpxVPC9+ZWJ4jPqOQ/It/qZYPRNZgziqfOmuVNpj+GEmG6IJlKOco8qJyErsA6gLjX+EMP3
 BxyTTpPki8Bml7VjqLcyZzqW1muydgLUYz/oY/1P4eFpk8i4jGxcyW9am8JM7WDqj7MG4c3UF
 esQyLV2lbHn9fFDhdaQ3k7b9dAx7dIj9kiKljTqzoCMto=

The inspur_platform_profile driver and the xiaomi-wmi driver both
meet the requirements for modern WMI drivers, as they both do not
use the legacy GUID-based interface and can be safely instantiated
multiple times.

Mark them both as legacy-free using the no_singleton flag.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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


