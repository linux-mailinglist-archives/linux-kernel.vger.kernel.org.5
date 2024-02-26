Return-Path: <linux-kernel+bounces-82249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C1C868128
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A131C22138
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4BC12FF93;
	Mon, 26 Feb 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SGvkgFAv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594412FF72;
	Mon, 26 Feb 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976201; cv=none; b=ie91luTRM3uXrKO17vQkfzOtJEgp9/xDs1qVIuYVgtoL8WLTdmrlE1p54IpZRl7BBnDr5P5KWDKDH5j6ML/+EGPxcahLmyT69+FfsAIM8QwdDtPuiQJ30cG2JYUvtgHNyyjDg2XgesbgMKuOs5wbga3RTNWDQg2ScRbCb01WHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976201; c=relaxed/simple;
	bh=b03pH+DuQDWIC35gBC8LdNNtRJ8KK9qgtTD8+axxS7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdqviuXGWInqQdCHlB5MaB6h5j26qTh0dOs1r1pgTwPHzdC5QS03buhC7Sw9Kdl5m72FAbJu9laExtNzQvoIol4VH6Dig3u2mo5Lcvw9QfXzjNPCXVtV57rwwktQhEnoG3mG/xkNU9z7Dh4wtuFpPnLMZhkLtazCZYV7A5xBAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SGvkgFAv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708976169; x=1709580969; i=w_armin@gmx.de;
	bh=b03pH+DuQDWIC35gBC8LdNNtRJ8KK9qgtTD8+axxS7E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=SGvkgFAvlxPM/XtYmTAu2aLnE83LuJ/D1V7/hPTO80jICiLJld2ugQJg08nyhCH5
	 eucewbtEpabOKs5e/hqKMepDbWln/XC5ey2KbnRPm6LxBTA46F2CUIDNZhMOGnuLc
	 WMhxirUk+N+IEGNmUN7FQFZTUn5rkH141su0N8tN5xcd0xgaAXbvAJbi6UeXw9wiN
	 HGeTyLYIXajl9tysjR4UpgznJpeabMSWYMPO5RPHhYvFybu5IdGjUEYCxUmLtA12t
	 8GQrrPqMM8uUUTMOfnF48kfb0JcVdsiaIPXs1OCxGR5vKMlf/kN/zuEb2ubqjP0nq
	 CaHQEjzysPGAjcPX0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MQMyf-1rIunQ2ycz-00MHKh; Mon, 26 Feb 2024 20:36:09 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jithu.joseph@intel.com,
	linux@weissschuh.net,
	pali@kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	Dell.Client.Kernel@dell.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: wmi: Remove obsolete duplicate GUID allowlist
Date: Mon, 26 Feb 2024 20:35:57 +0100
Message-Id: <20240226193557.2888-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226193557.2888-1-W_Armin@gmx.de>
References: <20240226193557.2888-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5KRjlReq0fUexESOICqZ+Xej/Gta7WKxFfE0Ds/Mlh22gHtyojb
 9VONNU70xwTckRreWpwpGXkREsMsetPt4c5tsxynAt/YcLFArqkucDCEFNHixbFNPvQapl5
 8TFCySMfsLjuDwggF5Diqx24p+/IZyA6pRSJ0lfRyteaB0mVFRKQbzfRyzHUSbQBMvqmMEK
 cA5QHqGZ3xtpzSq9IwR1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tRB8kEeCnaQ=;jDuuCmLA9Z3dqQrHys5c5LXJQrO
 R5MjHi7B/aGDjLBXXPU6prifwZ+3MWKyCaSiAAZZ0M9chpR2QoJ6am5RO0bnh0Oa7fhqNXWlW
 h/pt3i5Hoao94ZDEiK+8jzPLjRom9M9/+dXUigwUikkGFXmAIHGD9zaQD4pV+kMXzRkeM9Hfa
 9CA5Bn+D/vEUBKpuXNXkfGtMA6Xi+TodiESvOs9FESdsPTAOCJq7Ng7+D6YtLp9rBtAejuz0I
 GAu6VNbY02tZMAAoxibX8rq9a4XANDWAlhZX/cqfDPSJKXgtHBVze3rFh9YnMG7CBeEKjO+nm
 2Tx+02GuBM4hsKRIK9qqoapSauUR3yQ7cjoKCnSH5KlLBXfj6xNQH/c+KADx1BOh5U0CbOA23
 oG+imYSjeRWUwFtuh778IaLKX2lmprL2h53AVoen/kMZgpYBlAAcNk4LR9bpUMaU3HJoG7V8X
 wSvJcMyFE+IgQH/k0qpSV7cb/unUH75PCHBCaw/WnwMDX5EDxFayIqeeIFiL50bJ2VgPctEVn
 UyQyGcLjbVa7cdNsfdymP4EzVURTnh5CU/0xc9Sm6CuhHdUlLA7qdSsa+ByS4p6TjetHyJ3go
 K03vsY+VxBvphUMmIBu+88xGf5YZteR2c3nd3MVn7CE4s/fx7WWXTf3P1ufp0zkAE1ydDPUSV
 3RtcSa5tKFp1asVNfhPjRo1vv4A6uxwkrY3PjDpD/cvQNIrLjHlez6GPyhrGoOZIxj38wqHIc
 RoHoklokTu3nrSldl9OUkuJzD9OGARLoI3u9ToDGtly7BKWS9Lj1Op/wwCkRXuMgd9v304fQs
 GVQM3hCn9NDIHBiTLCrSHSS6BN07I94hCOL9IQp02rABk=

The whitelist-based approach for preventing older WMI drivers from
being instantiated multiple times has many drawbacks:

- uses cannot see all available WMI devices (if not whitelisted)
- whitelisting a WMI driver requires changes in the WMI driver core
- maintenance burden for driver and subsystem developers

Since the WMI driver core already takes care that older WMI drivers
are not being instantiated multiple times, remove the now redundant
whitelist.

Tested on a ASUS Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 39 --------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 349deced87e8..1920e115da89 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -90,16 +90,6 @@ static const struct acpi_device_id wmi_device_ids[] =3D=
 {
 };
 MODULE_DEVICE_TABLE(acpi, wmi_device_ids);

-/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
-static const char * const allow_duplicates[] =3D {
-	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
-	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
-	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
-	"86CCFD48-205E-4A77-9C48-2021CBEDE341",	/* intel-wmi-thunderbolt */
-	"F1DDEE52-063C-4784-A11E-8A06684B9B01",	/* dell-smm-hwmon */
-	NULL
-};
-
 #define dev_to_wblock(__dev)	container_of_const(__dev, struct wmi_block, =
dev.dev)
 #define dev_to_wdev(__dev)	container_of_const(__dev, struct wmi_device, d=
ev)

@@ -1093,32 +1083,6 @@ static int wmi_add_device(struct platform_device *p=
dev, struct wmi_device *wdev)
 	return device_add(&wdev->dev);
 }

-static bool guid_already_parsed_for_legacy(struct acpi_device *device, co=
nst guid_t *guid)
-{
-	struct wmi_block *wblock;
-
-	list_for_each_entry(wblock, &wmi_block_list, list) {
-		/* skip warning and register if we know the driver will use struct wmi_=
driver */
-		for (int i =3D 0; allow_duplicates[i] !=3D NULL; i++) {
-			if (guid_parse_and_compare(allow_duplicates[i], guid))
-				return false;
-		}
-		if (guid_equal(&wblock->gblock.guid, guid)) {
-			/*
-			 * Because we historically didn't track the relationship
-			 * between GUIDs and ACPI nodes, we don't know whether
-			 * we need to suppress GUIDs that are unique on a
-			 * given node but duplicated across nodes.
-			 */
-			dev_warn(&device->dev, "duplicate WMI GUID %pUL (first instance was on=
 %s)\n",
-				 guid, dev_name(&wblock->acpi_device->dev));
-			return true;
-		}
-	}
-
-	return false;
-}
-
 /*
  * Parse the _WDG method for the GUID data blocks
  */
@@ -1157,9 +1121,6 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 			continue;
 		}

-		if (guid_already_parsed_for_legacy(device, &gblock[i].guid))
-			continue;
-
 		wblock =3D kzalloc(sizeof(*wblock), GFP_KERNEL);
 		if (!wblock)
 			continue;
=2D-
2.39.2


