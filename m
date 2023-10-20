Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74B17D17DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjJTVKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjJTVK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:10:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576F8112;
        Fri, 20 Oct 2023 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697836215; x=1698441015; i=w_armin@gmx.de;
        bh=kFgVOLW+XKGG9Dulheyn+xrEGtWuwccHJv/X261e87w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=oF08p2AQTIHOWJIgWlit3N2rt74aIraiIs3Uvwq76EKVcbfe68jdrNqqZB/khtPV
         1qcBcKKT6UA3XUw33wddSnHcbn5Cp86+amTqBwAHOph/g6PUMEz5uGPLKROm123J3
         0nn7Uq6ogQuVNRrAHz6wUwH4Z+BRqvv0IuH7NdrviHGadPPTjUBZ+AR5JFoqJ7EeY
         L2Ks0l+VMJ01X+D+Xx+4mp8rgZXDJ92/YmqI5OjdZ/jSJISbFJ24oyHKUjGyyGSb+
         22yevMiDwsK9I/IJbFEa8U4ToYtnFXC9zvIuI1XBzuOOJ+pVf2aXjqU+U9pHrfDLt
         PmXLHwoWtIRen6SDQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MORAa-1r9pkH05gU-00Pz4b; Fri, 20 Oct 2023 23:10:15 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] platform/x86: wmi: Decouple WMI device removal from wmi_block_list
Date:   Fri, 20 Oct 2023 23:10:05 +0200
Message-Id: <20231020211005.38216-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020211005.38216-1-W_Armin@gmx.de>
References: <20231020211005.38216-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:upUz/s9hYkGaaetVpAZiTov/Dp6BZHRY9u7NNsKYG7ZsPneSYaN
 kME8qFo2oFWNV1icG+l8vgEWvmCLw+N9F/U9yhDgCOx9N8ajPePy5lBbyFo/CcfwlczOeS+
 9Y+moiM3hwxCZvXpyqjgC3zf8Bn1M3r5AFSxUWuoTDcj3xGZMRn1OKZeXZWQ2G5gi29w3Bw
 tReZ3vESZ9jJESGeFeMCg==
UI-OutboundReport: notjunk:1;M01:P0:uRYRACoYQNg=;xJ5zlELhxwZnziIgQaehFu6ytf2
 HQ0FxqEdXu93Z51O0juNh54QHy1xunaclvigTJ5UgUGlO6I85mafj1t1YebP0Enfi2lZH3/WA
 ofXjOKaIvfNM6VseXzheZLYXkreZUplT3n951nJDs1UNdZXtifS1F8v/nWGa709+1NfJUqrIp
 f89xcxz6L8kBB2fw8HhjZRgqbNxBTE+c1KLEsMG4ISxMUP87yHyBhwlQvxqDd+1SieVQVdNtE
 TJP+gkVTqLYEgFbU5T29i5pvn9lDNEKaiFbIoXWLjUFx7ZF0qb77wuO1Ffvvj0O57oiProqI0
 dJUjbxGAAnOJhxUME+Dvu/4bCWrVXscf6zLmNJHkcN+PMUifbow5HFblT92DrwR991tNZNf62
 1OHoxdR6yNZNXO9g/7Q4tRfDIUJyc3tjVRvy7X8c/F0vNarIkWtms20XiT5orqrxsTabnyCCi
 SOXJFnbVChsHaAMIsvUbmW7/7X3V0Pk6dwa2Dg6M04TtLsfEUYA5u293MQNjLAvZvbCS6tZGh
 dM4h4LP7u0q/DxF8tY9r0Lq4d4iL2vQ9zanJATo5LBm76AAOaLimYCHOSznsLiirbvCaXXbus
 yVwodVY2fSVAPTuNkkVfz0UadAAyZdqv0h5o/PDoWO2odsgK/h2oAHZPpM64TRlX+8NYDcQho
 aS9KlBzDtu8u1fx1eYvXQ1rKlxMBQSYM4DrX2TySoQSVkntjt6UMTpqZETJ2JvSCLB3Y8bABQ
 js/dcukxoHGnrtiebHokoghBFiYC1H4DHwwQmwK5rt6TpyWx5lReUoHUE0AUA+Vo94GmoI0Vo
 pNo90t1URQO1xS7wfkAEdaW3pdyQsuPB7qnRjpKmyg/MF/Oa3M3YsQKSsrKFskwtvUMkZt098
 S2fkks0mwQYsqszg0n9Rj0Zjraask6IR0fha7HlAU0/C7Z5qNClYPkUwW2QLxAhFkcJ5k7nBx
 92vDKjSAAYpAwnlJhtJjFjuRMak=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_for_each_child_reverse() to find and unregister WMI devices
belonging to a WMI bus device instead of iterating thru the entire
wmi_block_list.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 6b3b2fe464d2..5c27b4aa9690 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1280,19 +1280,6 @@ static int wmi_add_device(struct platform_device *p=
dev, struct wmi_device *wdev)
 	return device_add(&wdev->dev);
 }

-static void wmi_free_devices(struct acpi_device *device)
-{
-	struct wmi_block *wblock, *next;
-
-	/* Delete devices for all the GUIDs */
-	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		if (wblock->acpi_device =3D=3D device) {
-			list_del(&wblock->list);
-			device_unregister(&wblock->dev.dev);
-		}
-	}
-}
-
 static bool guid_already_parsed_for_legacy(struct acpi_device *device, co=
nst guid_t *guid)
 {
 	struct wmi_block *wblock;
@@ -1487,16 +1474,28 @@ static void acpi_wmi_notify_handler(acpi_handle ha=
ndle, u32 event,
 		event, 0);
 }

+static int wmi_remove_device(struct device *dev, void *data)
+{
+	struct wmi_block *wblock =3D dev_to_wblock(dev);
+
+	list_del(&wblock->list);
+	device_unregister(dev);
+
+	return 0;
+}
+
 static void acpi_wmi_remove(struct platform_device *device)
 {
 	struct acpi_device *acpi_device =3D ACPI_COMPANION(&device->dev);
+	struct device *wmi_bus_device =3D dev_get_drvdata(&device->dev);

 	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
 				   acpi_wmi_notify_handler);
 	acpi_remove_address_space_handler(acpi_device->handle,
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
-	wmi_free_devices(acpi_device);
-	device_unregister(dev_get_drvdata(&device->dev));
+
+	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device);
+	device_unregister(wmi_bus_device);
 }

 static int acpi_wmi_probe(struct platform_device *device)
=2D-
2.39.2

