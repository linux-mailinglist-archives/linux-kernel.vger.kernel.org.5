Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3B7D17D9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjJTVKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJTVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:10:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3787D65;
        Fri, 20 Oct 2023 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697836210; x=1698441010; i=w_armin@gmx.de;
        bh=uRnwDf6Of0uAPcllrrMhpGXZv2PanoNd1waM9WBipU8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=l0h0XWVyHecDfmmCe1/+9xVV/wYB2X7OngQFh1C034ncZlU6QrnuVP/jk6TPlMIl
         ZehJh4p0lu8TNL+00DNcqonvOIsFwDauq8fLKkGyoHE5KXTLVMjC+8Cwtdgplfr3K
         tjw84y+O84Iil1Bj4UHYfSCtdoQLe5jwHHZbRb5SLVu+5E4yoS2k2rGAP+iRbXd3K
         Li7CkSCt0L2JDFcGX5cGoMSVQjLlaUyAaHt3wXBwRIluoxJYcIJbjAyaO/9q205oD
         uk7LRqka7SU2SgfQheUyiSxiHX3IFNKoODUCbMfi/eCK9pVhfSYmfrbIgUM+Man1J
         5knDwNEGZIzu7ZOF/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N3KTo-1rb9fs2Lly-010OUt; Fri, 20 Oct 2023 23:10:10 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] platform/x86: wmi: Decouple probe deferring from wmi_block_list
Date:   Fri, 20 Oct 2023 23:10:01 +0200
Message-Id: <20231020211005.38216-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020211005.38216-1-W_Armin@gmx.de>
References: <20231020211005.38216-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6dQMVSVphIRvnujeRXnlY4Qr5ASviy1sLJIfGWzzFdXw7JSRk9V
 8pKbyk2iRglL6V4WT65igsqB8K5Dg2RXvW23LNZGa4om4JUqEswiTvbKrTZHEPi/9o5S+HV
 swtKEaJEoySLrWEjzmnZuVgEB/D3sazAU76kNP6gnWkF6/qDI0vWiBEouEVSY9vGvT6UA/t
 wrtMSMu4Qo4aRHfLGHeAw==
UI-OutboundReport: notjunk:1;M01:P0:wyNBUrTn46c=;IzbI2lINEjrNfl4vkSy6TdZbmji
 vFMO9f17uSgWBQpFD+w0citaQ4cBQOuIbL+9lNB1/swnJzY+tKmXJMA0h9STBaEig1X2pMNVs
 wEHzuQy6qESDUVBq+UXTWR4NAEBS1gIEe3owKQsWGrn0AmOXyn59vZ6HXQLucilIPSPYV8K3K
 vGT7ibo76NhDn8WEHkmDz5r3o8vXfKlXNlBYHhCS5Xmfe1SWXoSHDmNbd+YwiHGTLCJn8Nnlj
 QNSl8ezU+oq0In7Q8nZkAH/nlRsXwSlgw61CfzRyYUDuyVA/UZ9vfzK3BbXI3iTlHcQtBCsWR
 3ltaRQN3XUAxGc6SbOD5SvYVUk0dHGR0BwWIXuFn8aHtN/2pu1T5L7D5C3goGBHyhuY6nmUNe
 4qVhmGpi4Z9dlPX48wDa0EbZO4J5QoO8RuHy0tXdQ4II3JhIJPPO3zNhzbqBXRYW83jU/vCW7
 WTIrHwm7iW/Up5s6ogN7tLE5wPF6VzGpkarKxDqOepuKG/aM+Kf+y8E+ueX+5/f7MjKxS4A6L
 Lfud6UG4n3I0cS97di5r12XraRH/Y0P9RygQkrRXxr2wFekPOUoIZq9Lf5pQGoEYrAaOVOFf6
 p9vMYId2LHdyx1j7VWZI5TF6R7po4tSsv222qFpsFDeSg4Z3qLLGYC1sy15Em4v4T/F6PFPtZ
 0AUG+2j1K8prKdGavVFCV6t4YopNGn7DStrC4nZUbnvcQaUWUtgvJwp5MDDn5riLNUIJdDhfQ
 XBKjG1Nfu8QywlUXGduuINbKGoKI4khABB7WEhDSvIL4DarsVrGHC8IdS8jCRgxHpM9scb9PG
 vZ4PvWmFxCr20m8bDMPj8Xb953hMc0DWeiYJtsbhqUSy8z391/pHLbGRzNTzhmKuf2UG2vid+
 NR2BR5e/NKu+IWcU6ZIG6hJ4mLGmJ6siXCKT3o1vWn2v0f8XNi26hvQUcK1Qvtuseip9DO9WD
 JNA7r8YtUDrGeJAO1AYOPjhF3Ug=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

