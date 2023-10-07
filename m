Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F437BCA86
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjJGXkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbjJGXkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:40:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A289107;
        Sat,  7 Oct 2023 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696721983; x=1697326783; i=w_armin@gmx.de;
 bh=Y/qUsDiDdVUWMFMwXVZBHFFUAPNEIq2aEjhb47CVHzI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rgbhVzcKBhZVzUQ7AR+KSY4IWWHkGmELyTK7wZawN0e43WjPwsT0/mGr0PPv0WeeEPuAR7Ft46g
 O44PKUWQOQAAexBewMYrbrhQ+eiCaPMwCkMmi/tlYGRoxIANs1/qqu1yIuz7yeHhmyOHy3p33UMEV
 3f8cHPpX3kbfUHPcBqHjuweruywfLtST1C4ue2eC+F5y+TTyOxcKx98JaSLItmGfRE/UZUPrdS12u
 47mrvghSJvwZ0uOK9A5YkpqDkX1YLWbUmaL+jAjsIDlvg6n7qcLgPcJwCcSey32k6vObyKCfK2iHn
 Q05mbeFEympJIhCNudI4i9GrWbCeIejdJzDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MxUnz-1rmCGd3f1F-00xvNG; Sun, 08 Oct 2023 01:39:42 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] platform/x86: wmi: Decouple probe deferring from wmi_block_list
Date:   Sun,  8 Oct 2023 01:39:29 +0200
Message-Id: <20231007233933.72121-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007233933.72121-1-W_Armin@gmx.de>
References: <20231007233933.72121-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:flITnas8bY7wHEIbBweiIIBp7vUh6aH6WVAyzKsZgXSytqzEHnw
 ZHSXLk3gD6SBWYtjSNEIjkTm+BqVdrCdsKBjlxHdTmFPJ+S0dmOBWk9d8VXpYN5DjyXKApJ
 FgEWkmqa67JMzNUbKiBfeO7ZCmflxeKaCq+9vtV+GvfwedoFmTdfBevPuOKLXzqD5QAuX83
 qNR6OBV88KGpcnPCdhnDQ==
UI-OutboundReport: notjunk:1;M01:P0:qxGLR2kVk5U=;htd33az+9hkprs0VwE8zAIpbw2m
 gTFQnOOhni7Axcehcdvb7L0J/4cqx6tMudTKUY9ifLENnyfQlU+RyB/BDfQ8Q57oxg9/88KZG
 3pGWCyNVECBfvpAJd6ks3k+2KPqBwFkCFsCKlVdY72O0EexKfPssw1cVha7/7S4HnKzoFogaX
 Zc4F2vhM63LRcGZfI6oUfu+ork8no3wd7+NqNKGdzO9LT+ej48ghzrdXo3hHQMX1K5YyPw9Ig
 19xNJGzDgEJU+1N0DsRVY5Pdx4nlIKalSD9UYFOAC4SKd2vC5UIr5VAYTaR0EJeElGSXjRHyO
 mO0cBnRbDpxJ1X+feAiwAdwHZ7wxHCc5R7JoSGDXjKhQV5/XuyiTNXFXESKShVDf1tHqLiMlJ
 DWGPqE+PBHp0Jvcu91sqWTXjD5SXS3M+EkUlG+E8GZBSnWgrQGYwEcMemfjNOQvGZGb3JD0dL
 pUjZaRMh41vr61upUKOCkYzYnR0CfvbP2s7OMX+CiHc1a1buV/Qj4mmHoB2vOXCQvuybZvuql
 8PU8PbZh99UP9qQv4HUyWxIwP6R6/JDGuPrFs+zJBqrq1y4RZu0QQP9XZH1oFEKHZI4ljCpR5
 uCBmGOiKS1aMqDFIuWESffTdu60P/9m6ItV4hUn5IFCzYGMDt3HxL2McrdhyXr9X7VMYAj3AO
 zNnKsG3kdLOJx7dPPseoSbtFmvHiQS/sUPgUUyCitXM40y9ZGj0skVmk5PeFrOIMxFn7qgsRi
 XYd3UTedX0DjqxNV4keD0ecSRHRLgw7dTHgqX9ZTAle0MYXVgnuwNLAfWVvZ4njL/xI6U4/fR
 JILDiPjs7x8uTUIactdVoKKpYOKaLfTRQ0tYejLkbUKOsUqMxaP6cJH3HlWlkb6KTRy5o0j69
 ychnR8QXggk/zROiQ3EMPJ1jpfFIJO2SVoi7YSqFQWkXld8+atMxyu6pDYlbL8ir9QQ8+eSzh
 BDvjQqy4DcI2ikg7iRU4fA/LoXU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many aggregate WMI drivers do not use -EPROBE_DEFER when they
cannot find a WMI device during probe, instead they require
all WMI devices associated with an platform device to become
available at once. This is currently achieved by adding those
WMI devices to the wmi_block_list before they are registered,
which is then used by the deprecated GUID-based functions to
search for WMI devices.
Replace this approach with a device link which defers probing
of the WMI device until the associated platform device has finished
probing (and has registered all WMI devices). New aggregate WMI
drivers should not rely on this behaviour.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 39 +++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index a78ddd83cda0..1dbef16acdeb 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1221,6 +1221,26 @@ static int wmi_create_device(struct device *wmi_bus=
_dev,
 	return 0;
 }

+static int wmi_add_device(struct platform_device *pdev, struct wmi_device=
 *wdev)
+{
+	struct device_link *link;
+
+	/*
+	 * Many aggregate WMI drivers do not use -EPROBE_DEFER when they
+	 * are unable to find a WMI device during probe, instead they require
+	 * all WMI devices associated with an platform device to become availabl=
e
+	 * at once. This device link thus prevents WMI drivers from probing unti=
l
+	 * the associated platform device has finished probing (and has register=
ed
+	 * all discovered WMI devices).
+	 */
+
+	link =3D device_link_add(&wdev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPP=
LIER);
+	if (!link)
+		return -EINVAL;
+
+	return device_add(&wdev->dev);
+}
+
 static void wmi_free_devices(struct acpi_device *device)
 {
 	struct wmi_block *wblock, *next;
@@ -1263,11 +1283,12 @@ static bool guid_already_parsed_for_legacy(struct =
acpi_device *device, const gui
 /*
  * Parse the _WDG method for the GUID data blocks
  */
-static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *devi=
ce)
+static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *=
pdev)
 {
+	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
 	struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
 	const struct guid_block *gblock;
-	struct wmi_block *wblock, *next;
+	struct wmi_block *wblock;
 	union acpi_object *obj;
 	acpi_status status;
 	int retval =3D 0;
@@ -1317,22 +1338,14 @@ static int parse_wdg(struct device *wmi_bus_dev, s=
truct acpi_device *device)
 			wblock->handler =3D wmi_notify_debug;
 			wmi_method_enable(wblock, true);
 		}
-	}

-	/*
-	 * Now that all of the devices are created, add them to the
-	 * device tree and probe subdrivers.
-	 */
-	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		if (wblock->acpi_device !=3D device)
-			continue;
-
-		retval =3D device_add(&wblock->dev.dev);
+		retval =3D wmi_add_device(pdev, &wblock->dev);
 		if (retval) {
 			dev_err(wmi_bus_dev, "failed to register %pUL\n",
 				&wblock->gblock.guid);
 			if (debug_event)
 				wmi_method_enable(wblock, false);
+
 			list_del(&wblock->list);
 			put_device(&wblock->dev.dev);
 		}
@@ -1487,7 +1500,7 @@ static int acpi_wmi_probe(struct platform_device *de=
vice)
 	}
 	dev_set_drvdata(&device->dev, wmi_bus_dev);

-	error =3D parse_wdg(wmi_bus_dev, acpi_device);
+	error =3D parse_wdg(wmi_bus_dev, device);
 	if (error) {
 		pr_err("Failed to parse WDG method\n");
 		goto err_remove_busdev;
=2D-
2.39.2

