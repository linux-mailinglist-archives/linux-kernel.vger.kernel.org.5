Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF77BCA85
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344207AbjJGXkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbjJGXkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:40:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB830BD;
        Sat,  7 Oct 2023 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696721990; x=1697326790; i=w_armin@gmx.de;
 bh=kFgVOLW+XKGG9Dulheyn+xrEGtWuwccHJv/X261e87w=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GsXNuWD1th1B3DclPSFXXYBH3X0ksEIpOHcAegdNjDqGIU200drq+An8esFiOlQhelNKMFDWMHr
 PDGFn+XXzcMbaKsv0xgNbc43R/fWPReHft1vG5BTzSgOcWR50+/+thVY9RcCp5KbuIOItRziscJKw
 1KhBA3E6xaTHS81k3f8ifE0nRqHZfEjijVV9Ba+VpFMEPx032d+pnMwjtgXElhJqqPXrsFKc4gDtp
 3/joaloJgUpwIK7he3dNMzAZcrfKV0YuSMgRZ3jwKuYz/UbI4YCvymrDjzfW74tSjlhfWomCEGyYg
 SQ0TLXKL1MNzZW4DYc6y1AdB3KzuYwb+Gckw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MfHEJ-1rVDd042FH-00gsu3; Sun, 08 Oct 2023 01:39:50 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] platform/x86: wmi: Decouple WMI device removal from wmi_block_list
Date:   Sun,  8 Oct 2023 01:39:33 +0200
Message-Id: <20231007233933.72121-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007233933.72121-1-W_Armin@gmx.de>
References: <20231007233933.72121-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b7G/rOePCi7x7e+1VGql32FHdfHyPGQTQhoLJXjPsL31nV+soFc
 DIf+GTHg0IKHWmsL+J4ZgeBR+7HEyuc1CLIiXrMgenmfzK4dTO0FGsLcAh1uoCdfs7uqHfu
 0qwL5m5rQwfbjMDL5U002nnYCrws07p8cCl5Hws098bk9W5yWTDUxRjjVTWexr9aX1XpYNW
 tKWTTkgapVN21v+5/wXDA==
UI-OutboundReport: notjunk:1;M01:P0:JH0FVov/eNw=;OMvzziTvm5YQUyk0tojZy1KxTb9
 8lwOtuVRotZnzKIiJQcOHBQ9c3lAWj6Zzm8m4vC1t2yhwwbznz6fRjZgDH6hmUogJ4vW80Xvw
 YS0G+9Uvxp9G5xvtpMQNuuEAevPHk1bfYchI2w+WqeTjzhROkVU+jcrf4gztAbAtS/V+v93Ll
 7BZ+m53KvkbordcXwiJ9Ti5noS4bzP03v21+VkKggNojkDcXjWfaF6lPGZ9x1riLzwylxmGp8
 QURRh0T33OJtCIya0jS4VhV7dKKQ6AP6F9XQPvcm6KjhPLp+zRdmZJzJenhyGES3DfXcw4u2Z
 48Om3SFH66H63ZeTbVtIKIB/PW/nQcJv/cwj9I6qzEmg1pLGLLLCxhS0L6vT9KKPfKH0JwiGr
 BgemkFLWsABlsFsbK0ETj8W0Ej6yHn014QRXeiiKRr2FKdfo3TeExGpgko8YfOwPuEqzjKQ/2
 njMmrmvkEcHWSXDichxcGvWLWgRGrXolhpuPTBp0kD5qJt46kF+rtF2umI9lSKXtrUyj0i2kX
 dYlLDuqlmkwwjnQBIC8O04iFXZ86HfxNUL6HyfAqCHwFlfO40yhcc0ScNDqpjnp/mzhFTX/7i
 SMq+cb+PmmKir5XsZesZkGuQ+SuOTC9plCA5/irAqUYuRYAboKS03kRsU2MVgLNx3MuajULeJ
 H8XqNCie+YRynU9r1Z7mmVfi3K3Bu96GOxkC+zkl/QpoydHeXw6dM8xQZmmbS1gUsGfxz+daB
 VVDRMGIrdL8UztMvz8CdzWz9x4Aevl9QCcc1ZkSP9Li6PPIwUV2kfhKKUcG3gOjpphsR1I8kf
 snyEJfXKPM0X3A58SjYeizvhEhPi6n1qBhXsMgi40RxCMCk2KV7KXTByXfM5BJsphGioTuQIk
 Kh/a9CkB463s750Eqh2i1koUj1HXFw4XDQzT9K0FgOxGBCOVv3ravUukytqro7qJ4yoBtQCz0
 UaqEdg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

