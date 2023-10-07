Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155487BCA7D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJGXkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344271AbjJGXj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:39:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66087C5;
        Sat,  7 Oct 2023 16:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696721985; x=1697326785; i=w_armin@gmx.de;
 bh=5+KayTNVHXGBHiTso+VMux4gCfCpCNVmo/W6eOPMdjY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gSnJSyX9Ibk6x/ndbg8ujWkebzaViSf05mNiL6ZkYUp3wIlGvYwmavigKMOlRfNuyW85ZBPOo8F
 3YqqJl3x/JDE8pSw07AJOyAFjIvsE4F8JqEmYueE1t3RCOynDiqrnpQM5qOWl1ZUPi4lqn/LxqM69
 y99Cq8eE6xylBxYw0C0E1/mSS7weshURtKaudf28G5Rqz4slmDOH7GY1iGk/b+7pa2juK13bCLeOH
 OMBKoAhC8yDYNNaUWlCQY68nSnujNcegJo4ijfs1e/w1ioQ0gmlGTFlsy3BN4f+9V4/otOsGplk/V
 1evQDhK2LtnFPK2FwP6UTSybxogrd/wic3pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N7zFZ-1rbivj3Yxv-01511s; Sun, 08 Oct 2023 01:39:44 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] platform/x86: wmi: Fix refcounting of WMI devices in legacy functions
Date:   Sun,  8 Oct 2023 01:39:30 +0200
Message-Id: <20231007233933.72121-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007233933.72121-1-W_Armin@gmx.de>
References: <20231007233933.72121-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oUmKFfwaZPonOyzvnKYLhZG9Mytu5LUhXeEZncVF//yvowmzt4L
 6WEnh4lVmcyIDbqA+AfDVTaayQqmcSy3Ah+r0Yd272OfkHh1qzSJyxD5CWjJH0zaBiEodts
 ol/EbyVmvCyXJ3jZLG9AgWdhE5gp7/JMhjgMSBua6e+bLBqg6x1/0pwUMJDZmmjVwF2tgBD
 MTjZFR/AWYXFucfqbSkVA==
UI-OutboundReport: notjunk:1;M01:P0:6iM16qMGA34=;nAEvTbdvkI7SsKfY8YFJTIJfHaE
 OPXicI0tokqZ3xmMyx/T3q9/fOdOmQQNnd5efB4YBUzUWQpIjFwKx6Mec0ZIX7bHafAyBAzI3
 e+guMQXXOoCcew21TOc2t0k8hcZRiDRpHcnvemqf9K0ieX6c4PiwyKTlmcLu8v+lwKYfMcLW4
 +7dR/+/wgIYrdEwNGlCDWQwUQQ/c9K9Btl/FA8Uwwuy2AILhM9DKkb1S6XWfA425koLQ3t6XJ
 BMt6SAmmAKHPXQv7OBP30+TRlPINi7KjLoTo0J7SOkE8qxu+hTJuWm2WwiRvQhKPnt0UuIWud
 jE3pJogG5rAfD2jiH9/MUV42SY/67dgWtHCSjDCQxlcr5SGvide32C0Te9+RUyEyvWYJXhqMq
 E+gZr4GmV23Xt47MqjwNfYOyIhHVYmAUhZNNS0Q1p+ticfOTmcjNBiz49CnkrQUU9J920rF4Y
 Rnsx8Vd+ai0O5glzQx1C1gZN8JHuwjwSHI7n0IkKXTLc4yP0ATJFl3I99zvkm0mkhXdLrUbLr
 M/YHr5kGhTLpEkwcCXot4//C+fvVOKd58PTZEkXRh12DijK5tQIBoc1Qgv89dqt8PtPd/likj
 s8TLmI8r7p7JLYPt1ToipQQz8E3clMWGhMvdcNJq4ns5JmwnOhL1frmw43lRvQ3vVD0ek1ccm
 sgtW2AR7bCSVaBFDNG/cq8zZvaNjNYP2AaAFxNxNEX2Xw9Vn/SS8vaCGwnh8rVY+CYV/OwAuD
 42iRUzol3ZDfesGeC0BIJSAvwFmWINS4TG8ooiKlT2vdtSp+hty47jCRtK9106fn2qrMsbX8Y
 AI/1isweTBjmmTd72Q4LwG2jBgxURnPOj+qgwqZkx9jJIYSUUSs4AP2Yhcz6b4oR3t1Bel2C7
 EqzkWAcjSKex5Bdy7uZMFrRNgAbqknUEEjkTuHRlBHz1cv5dE/x+EE7c7m5Gf8vUZH0eQAvNg
 YTyGoIRtsUjN0ojdQybCkFE+n20=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

