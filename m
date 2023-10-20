Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB67D17DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJTVKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJTVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:10:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BFD60;
        Fri, 20 Oct 2023 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697836211; x=1698441011; i=w_armin@gmx.de;
        bh=5+KayTNVHXGBHiTso+VMux4gCfCpCNVmo/W6eOPMdjY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=PVeR2YEU4YQ2DzZ5aj45SHhXxFIvxxBf2FjI6WmYG4KRWIFIo1gavGSEwqr2M0Q/
         CDCrFXoU9PWeQUdIARqKi06jM/iEF1l+QJcsY6z3mjuH0ni61tfWTGIpORPAXrHI1
         qjeM+yDO/nD5Wt8CtRvV896yuxGOc7L20DfBv71Bu6E0asnTihkLVCSJcUIE/uP5Y
         dm3k5LF9tXVtMXyqmbsWM5njsbGJ4dXwtXeezRZwoqRxJjDLzVU6nhEHpIkLUZYTP
         1LFbHSZR6Ns/mLKlGbYE1JG3cO3Tjq36xORlll5swJnDCe/VQLZ2rysR2Wrr43Xns
         Pj7dICCwDjGNhxabmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MacSe-1rUeM52uiI-00c5sO; Fri, 20 Oct 2023 23:10:11 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] platform/x86: wmi: Fix refcounting of WMI devices in legacy functions
Date:   Fri, 20 Oct 2023 23:10:02 +0200
Message-Id: <20231020211005.38216-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020211005.38216-1-W_Armin@gmx.de>
References: <20231020211005.38216-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6t9SJmwYpBTxg5P1YT0TNeoGsgs7G90fLTolst6l4r4oJ86DkOc
 oonmB62FL0dpPcefsz2CageY6GpCnUudplq3pd4vtnMfmzoCydPZELsekH2Y0fLg+mn0L6T
 8T0y67Eo+BmxsGjzNKxdfSujh0oiTsd6AsMssuONyQ3tscZnmtnAYREoX5EuHYgynKRB8PS
 vqV0ENaWzLQ7NaK4vtg2w==
UI-OutboundReport: notjunk:1;M01:P0:7aSV8AgSRcc=;yT4C6ANUKCKF5/5krY2EANKw5up
 IE+5iuvTy2iLkJKl1DpyLlnUjHMf5G7mssO+oLslwJfrRUs4BLX36I2I7WKVYi3qburUj9kjr
 bdymva/CyuQboOpqjH/qQmFH2i/iEG2rnWBNvt/gdn4DJaaNKUXQhM0PED3IeNOCazUA0nGhJ
 VpPj1vtpy65BVlwjAlRhmzuP8HO7J95A9BoeU4Z7qjO9lcMCAHJpQufbSm4Qh8229YFtCOYZP
 qgyUzTeDg+FlSjzesmijy/ZvyHAICIHvvIyKH2APRiac9gtmF1rU+kpMKnZ3WIznroZ1LOOqh
 8WyKbCF/7qfTVudvXKEl5ke/Hf91UwPy8u4dM/wpgANIjBLZUkeiFPEVW7mWv+sDEefZe97Ej
 TReMmho/ZkwGiVnLwF1/bdnHHi62ZY4gPH4/pCbmQzeVsJD96goEVS8yfCcFERbyLklc4KRwD
 lg4z2lIpygVBett4NrjY2dn+yv+K64sifj4shz6Hr84SxgfUhPCSdgctCR+uca4NTvvVRN72n
 nwmAD8R4rI46c/gsX7iE+6q+AoWAGD4DkYuPbenNDwAX4sJbIjlbSuJI3KYJSLd7LSB+VOwts
 Rx9/mBgMlBTuIBmhLJ9pHH9p2iWCY2O4LK4IOw0Jt0CQqBDtjBrreb8r2IcPQv7QByjKfnFDd
 Xy6sD2ZxBvw91MPsjr6OA5/XlyA5UklcWIXW9kxhgwDO64MVU7ZNfyiDCZgcl/wefsyGr8FaE
 NkVzDZsgUoJl997uTzGkrHkYSjXkwrUJCIDvZUlMFl6viUizwlax3+4mCZZ4oAbKBGTMVEGgf
 kzNXkEks1obfpq7qluJ6o4uMYQeyBb6V45ApY38+4KmpxLLUVdr/8NJ2Q7oDWjjldDN56dLPU
 4wkORqwHTamKBLuEO5P+LYxLf2Ptop9tQ2UQiHKWWY8gDtzNMQ+MuusU4UIp7/xz/KUaVnm14
 Z5a2EifHyDRa8qQOfXk0l2d1fWg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, legacy GUID-based functions where using find_guid() when
searching for WMI devices, which did no refcounting on the returned
WMI device. This meant that the WMI device could disappear at any
moment, potentially leading to various errors. Fix this by using
bus_find_device() which returns an actual reference to the found
WMI device.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 167 ++++++++++++++++++++++++-------------
 1 file changed, 107 insertions(+), 60 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1dbef16acdeb..e3984801883a 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -109,33 +109,13 @@ static const char * const allow_duplicates[] =3D {
 	NULL
 };

+#define dev_to_wblock(__dev)	container_of_const(__dev, struct wmi_block, =
dev.dev)
+#define dev_to_wdev(__dev)	container_of_const(__dev, struct wmi_device, d=
ev)
+
 /*
  * GUID parsing functions
  */

-static acpi_status find_guid(const char *guid_string, struct wmi_block **=
out)
-{
-	guid_t guid_input;
-	struct wmi_block *wblock;
-
-	if (!guid_string)
-		return AE_BAD_PARAMETER;
-
-	if (guid_parse(guid_string, &guid_input))
-		return AE_BAD_PARAMETER;
-
-	list_for_each_entry(wblock, &wmi_block_list, list) {
-		if (guid_equal(&wblock->gblock.guid, &guid_input)) {
-			if (out)
-				*out =3D wblock;
-
-			return AE_OK;
-		}
-	}
-
-	return AE_NOT_FOUND;
-}
-
 static bool guid_parse_and_compare(const char *string, const guid_t *guid=
)
 {
 	guid_t guid_input;
@@ -245,6 +225,41 @@ static acpi_status get_event_data(const struct wmi_bl=
ock *wblock, struct acpi_bu
 	return acpi_evaluate_object(wblock->acpi_device->handle, "_WED", &input,=
 out);
 }

+static int wmidev_match_guid(struct device *dev, const void *data)
+{
+	struct wmi_block *wblock =3D dev_to_wblock(dev);
+	const guid_t *guid =3D data;
+
+	if (guid_equal(guid, &wblock->gblock.guid))
+		return 1;
+
+	return 0;
+}
+
+static struct bus_type wmi_bus_type;
+
+static struct wmi_device *wmi_find_device_by_guid(const char *guid_string=
)
+{
+	struct device *dev;
+	guid_t guid;
+	int ret;
+
+	ret =3D guid_parse(guid_string, &guid);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	dev =3D bus_find_device(&wmi_bus_type, NULL, &guid, wmidev_match_guid);
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	return dev_to_wdev(dev);
+}
+
+static void wmi_device_put(struct wmi_device *wdev)
+{
+	put_device(&wdev->dev);
+}
+
 /*
  * Exported WMI functions
  */
@@ -279,18 +294,17 @@ EXPORT_SYMBOL_GPL(set_required_buffer_size);
  */
 int wmi_instance_count(const char *guid_string)
 {
-	struct wmi_block *wblock;
-	acpi_status status;
+	struct wmi_device *wdev;
+	int ret;

-	status =3D find_guid(guid_string, &wblock);
-	if (ACPI_FAILURE(status)) {
-		if (status =3D=3D AE_BAD_PARAMETER)
-			return -EINVAL;
+	wdev =3D wmi_find_device_by_guid(guid_string);
+	if (IS_ERR(wdev))
+		return PTR_ERR(wdev);

-		return -ENODEV;
-	}
+	ret =3D wmidev_instance_count(wdev);
+	wmi_device_put(wdev);

-	return wmidev_instance_count(&wblock->dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(wmi_instance_count);

@@ -325,15 +339,18 @@ EXPORT_SYMBOL_GPL(wmidev_instance_count);
 acpi_status wmi_evaluate_method(const char *guid_string, u8 instance, u32=
 method_id,
 				const struct acpi_buffer *in, struct acpi_buffer *out)
 {
-	struct wmi_block *wblock =3D NULL;
+	struct wmi_device *wdev;
 	acpi_status status;

-	status =3D find_guid(guid_string, &wblock);
-	if (ACPI_FAILURE(status))
-		return status;
+	wdev =3D wmi_find_device_by_guid(guid_string);
+	if (IS_ERR(wdev))
+		return AE_ERROR;
+
+	status =3D wmidev_evaluate_method(wdev, instance, method_id, in, out);

-	return wmidev_evaluate_method(&wblock->dev, instance, method_id,
-				      in, out);
+	wmi_device_put(wdev);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(wmi_evaluate_method);

@@ -472,13 +489,19 @@ acpi_status wmi_query_block(const char *guid_string,=
 u8 instance,
 			    struct acpi_buffer *out)
 {
 	struct wmi_block *wblock;
+	struct wmi_device *wdev;
 	acpi_status status;

-	status =3D find_guid(guid_string, &wblock);
-	if (ACPI_FAILURE(status))
-		return status;
+	wdev =3D wmi_find_device_by_guid(guid_string);
+	if (IS_ERR(wdev))
+		return AE_ERROR;

-	return __query_block(wblock, instance, out);
+	wblock =3D container_of(wdev, struct wmi_block, dev);
+	status =3D __query_block(wblock, instance, out);
+
+	wmi_device_put(wdev);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(wmi_query_block);

@@ -516,8 +539,9 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
 acpi_status wmi_set_block(const char *guid_string, u8 instance,
 			  const struct acpi_buffer *in)
 {
-	struct wmi_block *wblock =3D NULL;
+	struct wmi_block *wblock;
 	struct guid_block *block;
+	struct wmi_device *wdev;
 	acpi_handle handle;
 	struct acpi_object_list input;
 	union acpi_object params[2];
@@ -527,19 +551,26 @@ acpi_status wmi_set_block(const char *guid_string, u=
8 instance,
 	if (!in)
 		return AE_BAD_DATA;

-	status =3D find_guid(guid_string, &wblock);
-	if (ACPI_FAILURE(status))
-		return status;
+	wdev =3D wmi_find_device_by_guid(guid_string);
+	if (IS_ERR(wdev))
+		return AE_ERROR;

+	wblock =3D container_of(wdev, struct wmi_block, dev);
 	block =3D &wblock->gblock;
 	handle =3D wblock->acpi_device->handle;

-	if (block->instance_count <=3D instance)
-		return AE_BAD_PARAMETER;
+	if (block->instance_count <=3D instance) {
+		status =3D AE_BAD_PARAMETER;
+
+		goto err_wdev_put;
+	}

 	/* Check GUID is a data block */
-	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
-		return AE_ERROR;
+	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD)) {
+		status =3D AE_ERROR;
+
+		goto err_wdev_put;
+	}

 	input.count =3D 2;
 	input.pointer =3D params;
@@ -551,7 +582,12 @@ acpi_status wmi_set_block(const char *guid_string, u8=
 instance,

 	get_acpi_method_name(wblock, 'S', method);

-	return acpi_evaluate_object(handle, method, &input, NULL);
+	status =3D acpi_evaluate_object(handle, method, &input, NULL);
+
+err_wdev_put:
+	wmi_device_put(wdev);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(wmi_set_block);

@@ -742,7 +778,15 @@ EXPORT_SYMBOL_GPL(wmi_get_event_data);
  */
 bool wmi_has_guid(const char *guid_string)
 {
-	return ACPI_SUCCESS(find_guid(guid_string, NULL));
+	struct wmi_device *wdev;
+
+	wdev =3D wmi_find_device_by_guid(guid_string);
+	if (IS_ERR(wdev))
+		return false;
+
+	wmi_device_put(wdev);
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(wmi_has_guid);

@@ -756,20 +800,23 @@ EXPORT_SYMBOL_GPL(wmi_has_guid);
  */
 char *wmi_get_acpi_device_uid(const char *guid_string)
 {
-	struct wmi_block *wblock =3D NULL;
-	acpi_status status;
+	struct wmi_block *wblock;
+	struct wmi_device *wdev;
+	char *uid;

-	status =3D find_guid(guid_string, &wblock);
-	if (ACPI_FAILURE(status))
+	wdev =3D wmi_find_device_by_guid(guid_string);
+	if (IS_ERR(wdev))
 		return NULL;

-	return acpi_device_uid(wblock->acpi_device);
+	wblock =3D container_of(wdev, struct wmi_block, dev);
+	uid =3D acpi_device_uid(wblock->acpi_device);
+
+	wmi_device_put(wdev);
+
+	return uid;
 }
 EXPORT_SYMBOL_GPL(wmi_get_acpi_device_uid);

-#define dev_to_wblock(__dev)	container_of_const(__dev, struct wmi_block, =
dev.dev)
-#define dev_to_wdev(__dev)	container_of_const(__dev, struct wmi_device, d=
ev)
-
 static inline struct wmi_driver *drv_to_wdrv(struct device_driver *drv)
 {
 	return container_of(drv, struct wmi_driver, driver);
=2D-
2.39.2

