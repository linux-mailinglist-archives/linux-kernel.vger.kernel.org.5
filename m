Return-Path: <linux-kernel+bounces-15910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C1823591
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90362868CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF01D54A;
	Wed,  3 Jan 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KtD4R7Te"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4A1D53F;
	Wed,  3 Jan 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704310046; x=1704914846; i=w_armin@gmx.de;
	bh=oLU+T33MRGFH1YmhPpxr4fPLv3ROA1I32d48VVgdxJU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=KtD4R7TeLMdsAAX/YvN9dlftiLA92xlfDvR7nC0PPgw2qHl5x5bfdpCKkECYjVpu
	 nOYy4lUorNkmvmZbTqnIGDGZohm88gxwP2I4+/rwst6T9w8fpeu180Ic6/atH4JJj
	 AX4ckbYurcCWx2CqL//pZXod5AvLdSN3j9A6zGTan8wxGbfJlnV0hKozJ13eynSLn
	 LRJOje2yqCnJpOtmKi5+HxDDapDgmHun8wPr/K6G7oEOxahjWM+S1GF9OOAVYEe79
	 UwcETLrqJoeUB/SuTg/EoXJSj7pKjfG13orp1zVEa+Xp2yyPhJ9RCYxl1y/CirL76
	 61YwkqT8MVuMo5R+fQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M42jK-1rL6th3QNU-0004kL; Wed, 03 Jan 2024 20:27:25 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: wmi: Fix error handling in legacy WMI notify handler functions
Date: Wed,  3 Jan 2024 20:27:04 +0100
Message-Id: <20240103192707.115512-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103192707.115512-1-W_Armin@gmx.de>
References: <20240103192707.115512-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mbkIzCVdDVj0I3XEnd0DF/G0v9gaqlCCC5JmvXexmD1TsR0T+L9
 cBpwWViyKrKdicyR6IX46+G3ghBXTuJh7fuqEIZVsZpCuJU01DEtZmIZj1SpAxQbKdPJbWY
 8YAyxxz3UQGQRbolTuYtirs/dKN5UMzMXxMpXd3oqdWPjrPlXrzP4xMDYAAV62NH6WG8s1E
 EBXE973D9ObkdCRUZx8+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tpa9/Sd/nBE=;WkFf3J0TnN1/3ytBywe89ZfmqBl
 m629B6yMoyd4UyiCdUzVBf2csBII4HERHGAq9CR25nLt9Nt4esRarFhGCewDnFfUQZVu70NCi
 1AJfB6mUw0ahaJTYeWxRWWkN5NYsW0lC22Rytat8wYtzWh+79/WIDyiQpVmUqWswXJR7apSnw
 xDwF2u7tQOuezz5pj/702N8Fcwhg8gOn4w5FJgLLfXsUbitEP55KpmCWXKOAn4pjc55JZgMjn
 Uo083bTSNl1Vo0sEJ58zcvsub3g5IzFlqaBap4SLjPbqZL16uNsW+YCr/I5WVO3K8Ua0HxTBW
 SwLKg3f9/nRaoBOknGFbv3GOwzXque4s57yECpf9VJq577yy4XDMxDNtewOFdyNGsETQnLdDt
 p93o2o8jdemprILK9MomAm+uYAZV+LF1HnBt3Vz/gJ/CeVrC2uIFZVaeD4OX5FNm60LrMqVNJ
 P2omhJc3/0fi7WmYc8+KOaNMB+x8nW47zEl7FsEQMuVCIm1ipHrcwsf5GoVGglMwVHvtiIiuD
 lLW+4cMuDPkz2dR5BpPzVGDPY0My7kDHFbOzqAP4ExGFWyZfWI2JRvNbRjsWaMdjYHKp/+CBS
 7ub4W2TP4mu7xmeClIJibPA2E09G2XsvIVXFOCXRW1yITbDLkb82T9yF/QI1YAjmUkE/P5Rho
 QOoXu4l5W1Kz+rDmo95NT9n6vF/4iQw+FRY7geUKZ6s8sOlab/o3oRuIBLDZJGTY07E9fQhV5
 dghS9UFU+/oOtzsWiV4Bk4gp+MocVyVPJ6Q5biOQ01N5SkyNQ3WMCRmUi1NxGF1zBtM7C7OM8
 i4y0nQgIV+C6eip3uyu8JwRgNdfoqeInAFLvPJtfofxTYmDBQ8sxQgljpZQRg7dPvp05CpRo/
 BoiSkfYSF1Xi+pG+fGRJKFUH+mm5a5JGM0t1IzeBcpXVoJ7PgPv1mAeo79e+B+5mX0N9ZqxeG
 v5hv3lU/gqu/X7Cih4TVG7PFWWY=

When wmi_install_notify_handler()/wmi_remove_notify_handler() are
unable to enable/disable the WMI device, they unconditionally return
an error to the caller.
When registering legacy WMI notify handlers, this means that the
callback remains registered despite wmi_install_notify_handler()
having returned an error.
When removing legacy WMI notify handlers, this means that the
callback is removed despite wmi_remove_notify_handler() having
returned an error.

Fix this by only warning when the WMI device could not be enabled.
This behaviour matches the bus-based WMI interface.

Tested on a Dell Inspiron 3505 and a Acer Aspire E1-731.

Fixes: 58f6425eb92f ("WMI: Cater for multiple events with same GUID")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index a7cfcbf92432..3899a5e3fca7 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -592,9 +592,10 @@ acpi_status wmi_install_notify_handler(const char *gu=
id,
 			block->handler_data =3D data;

 			wmi_status =3D wmi_method_enable(block, true);
-			if ((wmi_status !=3D AE_OK) ||
-			    ((wmi_status =3D=3D AE_OK) && (status =3D=3D AE_NOT_EXIST)))
-				status =3D wmi_status;
+			if (ACPI_FAILURE(wmi_status))
+				dev_warn(&block->dev.dev, "Failed to enable device\n");
+
+			status =3D AE_OK;
 		}
 	}

@@ -630,10 +631,13 @@ acpi_status wmi_remove_notify_handler(const char *gu=
id)
 				return AE_NULL_ENTRY;

 			wmi_status =3D wmi_method_enable(block, false);
+			if (ACPI_FAILURE(wmi_status))
+				dev_warn(&block->dev.dev, "Failed to disable device\n");
+
 			block->handler =3D NULL;
 			block->handler_data =3D NULL;
-			if (wmi_status !=3D AE_OK || (wmi_status =3D=3D AE_OK && status =3D=3D=
 AE_NOT_EXIST))
-				status =3D wmi_status;
+
+			status =3D AE_OK;
 		}
 	}

=2D-
2.39.2


