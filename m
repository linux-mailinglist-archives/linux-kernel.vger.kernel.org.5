Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8940A7DEBD6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348470AbjKBEad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbjKBEa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:30:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8BEA6;
        Wed,  1 Nov 2023 21:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698899405; x=1699504205; i=w_armin@gmx.de;
        bh=W4B0/jqAT0mG9qvqiZcdwhhjqLpM1eXEuYdH9nlUqoI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YjGpkVcwOes3MNUqfdIqCjt75tzhue4XdsKZgA5/1bkpkqE5lkEBvnkDaXjCvceV
         zNEXbs/SsH/V1or6m1l1mv0mlgaYBIfB+BQmgfWtLFnrX0wf2cbcOBF7eIIOuqgOq
         RUlIv520Ej867YqUUanN1PHdT0BTyzK7+CkwJApibyQZGBGNpgqQw2XjUTMtsVedS
         l8G7i+aVWoEwMpzTujdAbqmo294Biw2vHuD2PzgOyrZJhKPWXod/VcWijt/r8KYjx
         Kt0qTOOXATCHWH6T6V/TRpmj2wpKSBsRpC8uwzKaInupH2sr3IeROj9j3BC/hyLF8
         3XMyM5R3hBj43m88hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mgeo8-1rfSnR21Zk-00h2Pq; Thu, 02 Nov 2023 05:30:05 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, maurice.ma@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: wmi: Add wmidev_block_set()
Date:   Thu,  2 Nov 2023 05:29:56 +0100
Message-Id: <20231102042959.11816-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XUq3aH+BNWmIXtVY0WKlkqDGfa9N9Xb4+GfLszEwWuRSBoyF+1g
 eaVfN2R8nMmoEKzcck5CFE1HzRk96NSOqCI7jT9b8Jqs8xyAYdU8WuBR3kapeNMBC+jh6H+
 hYRMmkaXRc03GXp40T9/NVUEhmsy4dHBLfEjfZmfvlESt8lx7qGd0Qx6Ch1QjRBUoGZQkhe
 o3deLAqqRMSOLHwGe0uJA==
UI-OutboundReport: notjunk:1;M01:P0:ctTt8npmtVE=;/bcXEZn99yiTNgrrOe8Iv14hYy/
 SFfuAIYwg8DxR8f54rqrjzQDHpdrzjjGyhw6Ey10hR3Lx2txTWp1xts7oYCJII1LjsP/ui6lI
 lDWn7VqztfQV0puAp94AYujm3LfgVF7XoWGCUM8aUT4nk0tMaaQyenzNgdbQYdcgUAeiGkzet
 /z+Wu6UZLyvigprupve/lGLzn0UVo8VibSz2icD6oxuzFtUOgk6io/GwvndYbGa2XVqGHlZfl
 NujwJIKyO+MhiVof94c+xi/7BwhGupge5zSMuRIt3c2jaMb5fBuLI0emcBXTzkxRpSJfRoXZm
 c2FVNZzuFwA9ixeCThRY1jyGpPjcYfJ9cmL+7b0litoLTrMcX3fyk4DgDRVUc4lDj22CCXVkX
 +UA8Bss7aKkGhlqHvQgOLmNpa88toq3Vk9FjeFAt6TiBCFfutoJPX6ucnDuhvPb2bCHNTUpBc
 QeRqZxkkonIs0zYT9KKpYNtIPNlfrWBie0fsTdnlXJwqzGZ3C8oyS0oL9ZX38xauPxvgI/kGX
 zMr4isbJ48Kf0Ehqx/d8ZIAPBQiu7TWzFwyGFJbzbSONLk19eRUj+r6drNW1mEBFr1FJCBfR2
 14rkKNepL7lheyZjdp7CXDXuCkTw/LKSXaFuA6nCtPqKlWHDp3+6LjRUPVo0HHRH5lDSOCHW7
 UF+kFjDtDCHVVlzWuF26pqJaS/xU8kNauvBPNjlpeUeVZJeThRKDRwaDl3WYHFqG5nO7RVrAt
 G/xYi8hpa3IVC6VxS1/ITMwn5KsE+71KBXel4spjAms5sbw6qX90zSLhh7I2yUZoUO3WL7YrP
 79SyVERpI+xH5USG5VknfUdrr5EZ1RIo2EG+/GzfXMUGYervSgdTEGsYKA5ObODVAQbm/ZSmJ
 kREVoFTRba3JGc4SjED8v/AlJ6MlIOm65/ugfuhNO2wQfwBqsFQbmwDODCGm4kJ9XVdDrzB1W
 2wnW4A==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

