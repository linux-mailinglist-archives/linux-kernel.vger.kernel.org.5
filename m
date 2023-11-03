Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00007E0814
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjKCS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbjKCS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:26:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E2BD4D;
        Fri,  3 Nov 2023 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699035934; x=1699640734; i=w_armin@gmx.de;
        bh=87/6Z3GDCuuONgRARk2VNGy0KZIfFryJJ5Sgbd/1RO0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WVyd9C4jYmsIHwQrA80qciR8Y1qyAO1meHf226IrXYGv6j0OwnQ35DbAJLLtebc3
         XAsZNwrd55nutucwFIqViZi4gVrmRtrKGMToTkqwz6N3bSiEk5CwqNjydgnaO7gEc
         1XLtlMDbiGXNRsUGnzoF0+X7BfhI2Ug4Jjbq8rqfwjH5aESmKIHayvURyylJmG4GT
         YOHFmYgnEejbQ4wYPZFk95iz1B1uIc/1lmjEZkGk/bMpHNfKR7Qb0bmiim7UPyszq
         LCKYUtuzx42FXHMHBIDxE1+031AZ7Kux6+34CyYxFXXijQ5Dnt3T49lY5RXA0M1dU
         cC9LiIxrRtXsIP2UQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mk0Ne-1rjGyc13VY-00kT1u; Fri, 03 Nov 2023 19:25:34 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] platform/x86: wmi: Add wmidev_block_set()
Date:   Fri,  3 Nov 2023 19:25:23 +0100
Message-Id: <20231103182526.3524-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYZiZr8I1iEnWabFYZyuNzae7HyUJaA7e66F4OBa48ofukr5/Oi
 nRfeyeFC/gbwhksR/SFJgys6/wZ80EvppQMKtnfwipXNK+pCLhP1ukbo1f7ihp5WD+AexMC
 VhjAXu82Nky9+8jYOCx+34bPe/7pxWKHXEXoMOTeDBsaAqkpodD32sn4SDRzlthtXafmqmd
 ZF8UxaNkHHzp6OUP7No3g==
UI-OutboundReport: notjunk:1;M01:P0:AO80qY1xqck=;mwIb49Y7ZM/H3DhA3/huyU3Llpb
 y2Qxn7rrnlSrtySjpWGH/NolzUUnPP4OcVF5YvVjg8AGkCND8++dQgqwf3Ns+aTtlsvaTqx3w
 64WKB7dnprdlpsT5cwtG3XrawLA4LE8ppWlTHAYzNOvvf3q41KeZxFiFCC6+B0XymXpYjZxLY
 ot1EiK4+x+LAsyEy8K+Ms1ktdGMHOdMqrWFhUbMy9Mhn+6skBS4VcaV8Mu1Rlokbyn+Sqt/tP
 ULOpGeWYWvMXmLK5W2vh9k/ynWGl6Ex2Hbp3crPjsLnYxO6LQrRwmKKTLwXXta3f3KzQJ62dK
 Tw25PgdKsEMDrakJRf3/zk+mkP+/UNhxHIWqDBRRxpILFk8qKx9vF6oV0NLUNWnv1hfmDDeod
 /qgv6jrPjEfV8iTMbvnj8dA9hV8dlfx9WV9Ka4Te5IoMFrjHqL5DiggjDbiCTD8NJNhRzg3tg
 sHgqFcM+27xj8O3TH/5CsafICilY3o06nKYBKjSjuO9WtuQSIyXyLwkJqaXmrlByQeBuoIFkI
 1tfOuVR9Xv0DQ1FjLa5vmoDHPiOXv4UgV0nPA2iLdoLgL3CSQSFpmzvH1cpDE16H8NARfgDee
 rc/SZl1+nEpoUxNsb5Uie6Uy5v9EXKDEJw0cfB9QO4IsGAJRwxdiyNyfht0EhwliQOCQV2XDU
 d26bCmxy2LU5nlf+UEjyZldFIWoT27b9A+4vp+DaiLesbZpCvAlZZeplQU5oEXxZiVGplz4xV
 azshg5yxA6yRI5UlnIaoYroBgKbVy+BsxojC1g5tNZITK6imJ5SjdLkqkKdfWl+dEhLh/Be6+
 ccdMWPFNsXJEQtbAdxFvdWFVVt5mZCVemC2n+38RhLiLsOKfJT+iq2nJMwYyhk9HvUjZ52pG7
 t+AnTSl56yttvs3Nw4Qay//2CKWfBRHX7vUNYi/ZiS2mjl7+zqdVrEvHS35z/n1f5fN0B6zuC
 GZCLjbVs7tzuM3n3Bq9aCOITGaQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, WMI drivers have to use the deprecated GUID-based
interface when setting data blocks. This prevents those
drivers from fully moving away from this interface.

Provide wmidev_block_set() so drivers using wmi_set_block() can
fully migrate to the modern bus-based interface.

Tested with a custom SSDT from the Intel Slim Bootloader project.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- applies on pdx86/for-next
=2D--
 drivers/platform/x86/wmi.c | 64 ++++++++++++++++++++------------------
 include/linux/wmi.h        |  2 ++
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 5c27b4aa9690..9d9a050e7086 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -536,41 +536,50 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
  *
  * Return: acpi_status signaling success or error.
  */
-acpi_status wmi_set_block(const char *guid_string, u8 instance,
-			  const struct acpi_buffer *in)
+acpi_status wmi_set_block(const char *guid_string, u8 instance, const str=
uct acpi_buffer *in)
 {
-	struct wmi_block *wblock;
-	struct guid_block *block;
 	struct wmi_device *wdev;
-	acpi_handle handle;
-	struct acpi_object_list input;
-	union acpi_object params[2];
-	char method[WMI_ACPI_METHOD_NAME_SIZE];
 	acpi_status status;

-	if (!in)
-		return AE_BAD_DATA;
-
 	wdev =3D wmi_find_device_by_guid(guid_string);
 	if (IS_ERR(wdev))
 		return AE_ERROR;

-	wblock =3D container_of(wdev, struct wmi_block, dev);
-	block =3D &wblock->gblock;
-	handle =3D wblock->acpi_device->handle;
+	status =3D  wmidev_block_set(wdev, instance, in);
+	wmi_device_put(wdev);

-	if (block->instance_count <=3D instance) {
-		status =3D AE_BAD_PARAMETER;
+	return status;
+}
+EXPORT_SYMBOL_GPL(wmi_set_block);

-		goto err_wdev_put;
-	}
+/**
+ * wmidev_block_set - Write to a WMI block
+ * @wdev: A wmi bus device from a driver
+ * @instance: Instance index
+ * @in: Buffer containing new values for the data block
+ *
+ * Write contents of the input buffer to an ACPI-WMI data block.
+ *
+ * Return: acpi_status signaling success or error.
+ */
+acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const =
struct acpi_buffer *in)
+{
+	struct wmi_block *wblock =3D container_of(wdev, struct wmi_block, dev);
+	acpi_handle handle =3D wblock->acpi_device->handle;
+	struct guid_block *block =3D &wblock->gblock;
+	char method[WMI_ACPI_METHOD_NAME_SIZE];
+	struct acpi_object_list input;
+	union acpi_object params[2];

-	/* Check GUID is a data block */
-	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD)) {
-		status =3D AE_ERROR;
+	if (!in)
+		return AE_BAD_DATA;

-		goto err_wdev_put;
-	}
+	if (block->instance_count <=3D instance)
+		return AE_BAD_PARAMETER;
+
+	/* Check GUID is a data block */
+	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
+		return AE_ERROR;

 	input.count =3D 2;
 	input.pointer =3D params;
@@ -582,14 +591,9 @@ acpi_status wmi_set_block(const char *guid_string, u8=
 instance,

 	get_acpi_method_name(wblock, 'S', method);

-	status =3D acpi_evaluate_object(handle, method, &input, NULL);
-
-err_wdev_put:
-	wmi_device_put(wdev);
-
-	return status;
+	return acpi_evaluate_object(handle, method, &input, NULL);
 }
-EXPORT_SYMBOL_GPL(wmi_set_block);
+EXPORT_SYMBOL_GPL(wmidev_block_set);

 static void wmi_dump_wdg(const struct guid_block *g)
 {
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 763bd382cf2d..207544968268 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct wmi_dev=
ice *wdev,
 extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
 					     u8 instance);

+acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const =
struct acpi_buffer *in);
+
 u8 wmidev_instance_count(struct wmi_device *wdev);

 extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
=2D-
2.39.2

