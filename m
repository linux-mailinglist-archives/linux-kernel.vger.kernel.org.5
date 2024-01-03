Return-Path: <linux-kernel+bounces-15907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B182358C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB3F1F24EF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9CB1CABA;
	Wed,  3 Jan 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fhOtqFKA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268A1CA9B;
	Wed,  3 Jan 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704310048; x=1704914848; i=w_armin@gmx.de;
	bh=jAvhRAuLMwF09z0O8Wn623XKzZ4cT7/lRTptfGH+3Uk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=fhOtqFKAv2PoS6Maafw2sTf6l9E34RHPHZqxzTgojSHcUpPWnTQ7aKDJK+jUA73A
	 S8H9iMqiR1caQMCpeLyjQKpdAppOtXT1R3eN1xkuq6hcSmECHRcNRfOy0eSIPCkEw
	 vQErM2wWyXd44urs+qc2sgP5eM3QiTC6HBnDxBHSIKEPQssK4Y1MEm4hNtRLEBQly
	 4/FmPDZWp108zF/3UBIiEd6RXRG8en4tjSrLJSz+uQYgjU46tZgVukYuws6/M040W
	 RPMQRT7XC6HSEVfPZr9Ink9BBd1BAIlE09oRZeG6Fl2heS7zp1lpRf4AWsx5hMLjj
	 tAblxA+LjPBEdi7LTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MYeMt-1rhP0m3JY3-00VioH; Wed, 03 Jan 2024 20:27:27 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: wmi: Return immediately if an suitable WMI event is found
Date: Wed,  3 Jan 2024 20:27:05 +0100
Message-Id: <20240103192707.115512-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:nsG8TD6g7FOddttMBLCBlXgejchclXT9ya4KHwThGTHhGNTwYjO
 anFyyUkbQ8i61N+DYCiUQ3AYlQe+AAGehQoxeqBiRV2nC0O600VcNp4DX24SvojF3MwfcKV
 w3mJAlDeciZfrImy13RGEntPxB5RVzrCTErGg8Jl1q+1xak7l6lhJbpQCJgZDpzmLthSXvj
 BwkMPRG1jtHq9xTKk04iQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iie4OV3hTjQ=;jZ2SeOqr0+Fgd0b4+6YAAy5mNVs
 Uzk3W7UJDA5Gr/T4MIi/wDDEas7qJXqlQOe1zhlMHYd4KvZhlfzKv+TnQWXIUZcVzvG1i5fKJ
 bcg7JzawjtQ0n4EgC3jnu+mebW9D83pHOuY8UPJ6DO4epvgN++bsVB66o2y66+2b2AOwgvxK3
 cxZHnkhCa9BCwEOAUaUJ5fq9O7boJlQyZAqJtqjP2sxCtkEoEONBSrHLrKulqbiBloSa92N0K
 AYuTGnWb/zxPTPLCmMST96ARlSMb589F+2A1sBQRbGID8zlZJ232AbeY0gSFEz/MNMfLGLkFv
 PvO23D+aMjhYd9bpz78a2aUY2P4+DVLPyA/gWkOC0NDm3uwazi+JBv95JkL4FyjbemnoAy00V
 M9SB2paEtGkSHevdcb1WfglbjGiDEz5za5sklUV1pwzmYm/LIDfRQhQTfX+0OaYP638L7cqWL
 v2Z9mG8z14lVE6eSpPmpCSJ9TWqnFX5LiVX4uqzrnpUdEaUQkMb6pzWRTazV+wB0kMdq7SjTt
 QPVeEbrS+011e2c8XfMxOx6QXqZgkc/wzgWqrld31SuDCVaHlAOVB9C+ovOZqE/fjDKJ1lIek
 /CVW2CzTDhSI73fYPvJ87TxO66YmWklW83dD28Yct/O5WZO8Qtv+HelfPVy49+dqM4+wxJnZU
 YJghW8YobLVaDjL1hIQvNixnvSY90k6Sggz+hdtl0XsVtxYFWBQrdK3yTy9RHPbJLE20WWbxK
 6StGhq+NeZGcQxgbBf/RyuUOLXKrvXknKt58i5Tzd3ib0Dwui7VrTJSwRMZD861Sqz7+V7wj2
 c+RnwK/gj9nd62UrnQkZoyWd+U/1c1LJZ2mwdYWSHKUzVOieJz5KeMNrvC3rM24tKzsYE2Nd/
 DIhMF1+gjBOby/TV4JxBsPvmq7RgKcKt+js3kh2oYKif/+lj2pMO9dTBX2WqpsCyU29Ae1VYW
 nlrBsA==

Commit 58f6425eb92f ("WMI: Cater for multiple events with same GUID")
allowed legacy WMI notify handlers to be installed for multiple WMI
devices with the same GUID.
However this is useless since the legacy GUID-based interface is
blacklisted from seeing WMI devices with duplicated GUIDs.

Return immediately if a suitable WMI event is found in
wmi_install/remove_notify_handler() since searching for other suitable
events is pointless.

Tested on a Dell Inspiron 3505 and a Acer Aspire E1-731.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 3899a5e3fca7..7470a149b254 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -572,7 +572,6 @@ acpi_status wmi_install_notify_handler(const char *gui=
d,
 				       void *data)
 {
 	struct wmi_block *block;
-	acpi_status status =3D AE_NOT_EXIST;
 	guid_t guid_input;

 	if (!guid || !handler)
@@ -595,11 +594,11 @@ acpi_status wmi_install_notify_handler(const char *g=
uid,
 			if (ACPI_FAILURE(wmi_status))
 				dev_warn(&block->dev.dev, "Failed to enable device\n");

-			status =3D AE_OK;
+			return AE_OK;
 		}
 	}

-	return status;
+	return AE_NOT_EXIST;
 }
 EXPORT_SYMBOL_GPL(wmi_install_notify_handler);

@@ -614,7 +613,6 @@ EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
 acpi_status wmi_remove_notify_handler(const char *guid)
 {
 	struct wmi_block *block;
-	acpi_status status =3D AE_NOT_EXIST;
 	guid_t guid_input;

 	if (!guid)
@@ -637,11 +635,11 @@ acpi_status wmi_remove_notify_handler(const char *gu=
id)
 			block->handler =3D NULL;
 			block->handler_data =3D NULL;

-			status =3D AE_OK;
+			return AE_OK;
 		}
 	}

-	return status;
+	return AE_NOT_EXIST;
 }
 EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);

=2D-
2.39.2


