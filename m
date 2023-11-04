Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859CA7E1034
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjKDP44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjKDP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF0D51;
        Sat,  4 Nov 2023 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113378; x=1699718178; i=w_armin@gmx.de;
        bh=E0zIFDIJGnBlG8u/9g+iTGRmgZ57wIRy0eOPDX28wDc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=HxSpKYYzEdbLw8ExApSJAtY3fQS+6n58kAp11C4CSY18QYpIIX3zqgrNOw2qOfSL
         c9Omv07qJVAcmUpr+uWWW1LRt3cHmlXba37VBOJOXMLAXW+MIaNHqATBbFbG4e+yI
         g9BKn/Z3MVvw8tgKTagY/QXabxOt+QiGUQgphYQgAlkHnad8HC4djmm9BJ7HJpNZd
         lsCrDi5SUzS6o1YXF8u9SwC/k1xbHPNMPrpSySiHOqjv4a4uu0xvhLcSY3zgnNJpR
         JD7E7z94O3TuCMnRu4JuXhx309sKUAwr9nWu8E1vv37iMVSBjmQY2rTvrBaUWS42Q
         JOw7vQITuLAiDHwiMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MNsw4-1qoFLO0huS-00OH4Z; Sat, 04 Nov 2023 16:56:18 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] hwmon: (dell-smm) Add support for WMI SMM interface
Date:   Sat,  4 Nov 2023 16:55:57 +0100
Message-Id: <20231104155559.11842-8-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104155559.11842-1-W_Armin@gmx.de>
References: <20231104155559.11842-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jzjesbErgQnhElmaxvyrwzxWR8GZuHa+dwzmJf76bQhSTAoN6O1
 NyHEr58FkL+t5P5syOw7DQ8m/wnLnUrArDZ89EjL0Vbhe42tSCS56wjdGTSequBrI5cn4X6
 x63v+Q9s/auVdf2YWRTyev0u1irL9H2hyUO2cl3p6CoueI0Xw742SCdmXMp6J5mbFEnqc+0
 8UmwHVPIfpmuSIQVapaWg==
UI-OutboundReport: notjunk:1;M01:P0:WA2aNQ9YhQs=;JqDnJim8pX+j875VtuGeeMrzw+a
 0+ab1qXdHs91gr7N3MydwkSZk5no3OT1cz8Ht3io1JX2/4IODmqu2EBnh4xpouAMjH5VqyZfE
 EZvCBw+qNdory0J9vKryZmXijBoWrizlHK6u8iTinPfkyR372V7g4Z9HKClyBQWd43h+EjTN6
 03WVaH5l37wp7Pts3gtBJO4jNSkrXU6uTFWly7VJgNRrOIdMFM5iAu6iUMJ2wareYG7SpBEVF
 694Al5kmy0bZF9oryIHfh5PDeZCRgoW9lpt5PGJEcCYqVq1b3DL2oW8iL9MonBir62Q1pJFAv
 ptsrBpdslr+QKD7+z3nHICrABbJWpJKwJi2C+x3vcLsNi9y2fqlzMRybNVHKvhHMm5Ga9pgbH
 3FlKQFk12nU/kASXj/uIqnHt/Kd3G/K00K0xV27ok5yDmsgtxtHBonzSR9Xnxt6b1uT1igqDx
 8mwlLQBenT6OgMjSYLjn93U2amju+W1Zk/J+fLw5V2lFUHCKH+wQRDQ7BQT31SMJYnpIkLJTH
 gVTVwgFS51OyHsTp3TCZRrhXEGx5GIC6e/iNcHQG8TEt6wPpUBwXs+zBfVEOJdGhZXqJ7hTU+
 OZY4lvY4wls6DFpaDn25LOC/YPmRcjHvM8+jCOdTJIqosME37uYU4E2MNPNo4BrJZgWymO6Ci
 kLAj+yusHb2zeUjzI6QyaWA4GDWM2wyneCUHDUyHzElkh4SEXLgx8ByTozFJQPunI4vL6lsNg
 A0pRaxgbtMw/gjGm90dmhKcjkOkif76wExxz7gXHwJOhnCbwCxYYmwVBUtDh2+5vmV7AF4VGU
 8BfOjBdBbqBJz17z+7cpNcOM3X423dmkqNVA1VQ2Xi/SUJrJQyo9JuwkjbKOhB3hn5F3u2CSl
 Jj3U1dIyyLz+qxQXjhlx6LFc6VXw2YsflRUVJMglQXEB5VmIxGbybr5f9ErioGGiZ2xWbNpZ2
 1OgdNKhC56ocsR7j+9OVt9MF3fg=
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

Some Dell machines like the Dell Optiplex 7000 do not support
the legacy SMM interface, but instead expect all SMM calls
to be issued over a special WMI interface.
Add support for this interface so users can control the fans
on those machines.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/Kconfig          |   1 +
 drivers/hwmon/dell-smm-hwmon.c | 164 +++++++++++++++++++++++++++++----
 drivers/platform/x86/wmi.c     |   1 +
 3 files changed, 147 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index cf27523eed5a..76cb05db1dcf 100644
=2D-- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -512,6 +512,7 @@ config SENSORS_DS1621

 config SENSORS_DELL_SMM
 	tristate "Dell laptop SMM BIOS hwmon driver"
+	depends on ACPI_WMI
 	depends on X86
 	imply THERMAL
 	help
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 2547b09929e6..36d41262d579 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -12,6 +12,7 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/acpi.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/ctype.h>
@@ -34,8 +35,10 @@
 #include <linux/thermal.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/wmi.h>

 #include <linux/i8k.h>
+#include <asm/unaligned.h>

 #define I8K_SMM_FN_STATUS	0x0025
 #define I8K_SMM_POWER_STATUS	0x0069
@@ -66,6 +69,8 @@
 #define I8K_POWER_AC		0x05
 #define I8K_POWER_BATTERY	0x01

+#define DELL_SMM_WMI_GUID	"F1DDEE52-063C-4784-A11E-8A06684B9B01"
+
 #define DELL_SMM_NO_TEMP	10
 #define DELL_SMM_NO_FANS	3

@@ -219,6 +224,69 @@ static const struct dell_smm_ops i8k_smm_ops =3D {
 	.smm_call =3D i8k_smm_call,
 };

+/*
+ * Call the System Management Mode BIOS over WMI.
+ */
+static int wmi_smm_call(struct device *dev, struct smm_regs *regs)
+{
+	struct wmi_device *wdev =3D container_of(dev, struct wmi_device, dev);
+	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	u32 wmi_payload[] =3D {
+		sizeof(regs->eax),
+		regs->eax,
+		sizeof(regs->ebx),
+		regs->ebx,
+		sizeof(regs->ecx),
+		regs->ecx,
+		sizeof(regs->edx),
+		regs->edx
+	};
+	const struct acpi_buffer in =3D {
+		.length =3D sizeof(wmi_payload),
+		.pointer =3D &wmi_payload,
+	};
+	union acpi_object *obj;
+	acpi_status status;
+	u32 *wmi_response;
+	int ret =3D 0;
+	int i;
+
+	status =3D wmidev_evaluate_method(wdev, 0x0, 0x1, &in, &out);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj =3D out.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	if (obj->type !=3D ACPI_TYPE_BUFFER && obj->buffer.length !=3D sizeof(wm=
i_payload)) {
+		ret =3D -ENOMSG;
+
+		goto err_free;
+	}
+
+	wmi_response =3D (u32 *)obj->buffer.pointer;
+
+	/* Check if register size is correct */
+	for (i =3D 0; i < ARRAY_SIZE(wmi_payload); i +=3D 2) {
+		if (get_unaligned_le32(&wmi_response[i]) !=3D sizeof(wmi_response[i + 1=
])) {
+			ret =3D -ENOMSG;
+
+			goto err_free;
+		}
+	}
+
+	regs->eax =3D get_unaligned_le32(&wmi_response[1]);
+	regs->ebx =3D get_unaligned_le32(&wmi_response[3]);
+	regs->ecx =3D get_unaligned_le32(&wmi_response[5]);
+	regs->edx =3D get_unaligned_le32(&wmi_response[7]);
+
+err_free:
+	kfree(obj);
+
+	return ret;
+}
+
 static int dell_smm_call(const struct dell_smm_ops *ops, struct smm_regs =
*regs)
 {
 	int eax =3D regs->eax;
@@ -306,7 +374,7 @@ static int i8k_get_fan_type(struct dell_smm_data *data=
, u8 fan)
 /*
  * Read the fan nominal rpm for specific fan speed.
  */
-static int __init i8k_get_fan_nominal_speed(const struct dell_smm_data *d=
ata, u8 fan, int speed)
+static int i8k_get_fan_nominal_speed(const struct dell_smm_data *data, u8=
 fan, int speed)
 {
 	struct smm_regs regs =3D {
 		.eax =3D I8K_SMM_GET_NOM_SPEED,
@@ -349,7 +417,7 @@ static int i8k_set_fan(const struct dell_smm_data *dat=
a, u8 fan, int speed)
 	return dell_smm_call(data->ops, &regs);
 }

-static int __init i8k_get_temp_type(const struct dell_smm_data *data, u8 =
sensor)
+static int i8k_get_temp_type(const struct dell_smm_data *data, u8 sensor)
 {
 	struct smm_regs regs =3D {
 		.eax =3D I8K_SMM_GET_TEMP_TYPE,
@@ -401,7 +469,7 @@ static int i8k_get_temp(const struct dell_smm_data *da=
ta, u8 sensor)
 	return temp;
 }

-static int __init dell_smm_get_signature(const struct dell_smm_ops *ops, =
int req_fn)
+static int dell_smm_get_signature(const struct dell_smm_ops *ops, int req=
_fn)
 {
 	struct smm_regs regs =3D { .eax =3D req_fn, };
 	int rc;
@@ -986,7 +1054,7 @@ static const struct hwmon_chip_info dell_smm_chip_inf=
o =3D {
 	.info =3D dell_smm_info,
 };

-static int __init dell_smm_init_cdev(struct device *dev, u8 fan_num)
+static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);
 	struct thermal_cooling_device *cdev;
@@ -1017,7 +1085,7 @@ static int __init dell_smm_init_cdev(struct device *=
dev, u8 fan_num)
 	return ret;
 }

-static int __init dell_smm_init_hwmon(struct device *dev)
+static int dell_smm_init_hwmon(struct device *dev)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);
 	struct device *dell_smm_hwmon_dev;
@@ -1083,7 +1151,7 @@ static int __init dell_smm_init_hwmon(struct device =
*dev)
 	return PTR_ERR_OR_ZERO(dell_smm_hwmon_dev);
 }

-static int __init dell_smm_init_data(struct device *dev, const struct del=
l_smm_ops *ops)
+static int dell_smm_init_data(struct device *dev, const struct dell_smm_o=
ps *ops)
 {
 	struct dell_smm_data *data;

@@ -1409,6 +1477,9 @@ static const struct dmi_system_id i8k_whitelist_fan_=
control[] __initconst =3D {
 	{ }
 };

+/*
+ * Legacy SMM backend driver.
+ */
 static int __init dell_smm_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -1434,6 +1505,47 @@ static struct platform_driver dell_smm_driver =3D {

 static struct platform_device *dell_smm_device;

+/*
+ * WMI SMM backend driver.
+ */
+static int dell_smm_wmi_probe(struct wmi_device *wdev, const void *contex=
t)
+{
+	struct dell_smm_ops *ops;
+	int ret;
+
+	ops =3D devm_kzalloc(&wdev->dev, sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	ops->smm_call =3D wmi_smm_call;
+	ops->smm_dev =3D &wdev->dev;
+
+	if (dell_smm_get_signature(ops, I8K_SMM_GET_DELL_SIG1) &&
+	    dell_smm_get_signature(ops, I8K_SMM_GET_DELL_SIG2))
+		return -ENODEV;
+
+	ret =3D dell_smm_init_data(&wdev->dev, ops);
+	if (ret < 0)
+		return ret;
+
+	return dell_smm_init_hwmon(&wdev->dev);
+}
+
+static const struct wmi_device_id dell_smm_wmi_id_table[] =3D {
+	{ DELL_SMM_WMI_GUID, NULL },
+	{ }
+};
+MODULE_DEVICE_TABLE(wmi, dell_smm_wmi_id_table);
+
+static struct wmi_driver dell_smm_wmi_driver =3D {
+	.driver =3D {
+		.name =3D KBUILD_MODNAME,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table =3D dell_smm_wmi_id_table,
+	.probe =3D dell_smm_wmi_probe,
+};
+
 /*
  * Probe for the presence of a supported laptop.
  */
@@ -1485,33 +1597,43 @@ static void __init dell_smm_init_dmi(void)
 	}
 }

-static int __init i8k_init(void)
+static int __init dell_smm_legacy_check(void)
 {
-	/*
-	 * Get DMI information
-	 */
 	if (!dmi_check_system(i8k_dmi_table)) {
 		if (!ignore_dmi && !force)
 			return -ENODEV;

-		pr_info("not running on a supported Dell system.\n");
+		pr_info("Probing for legacy SMM handler on unsupported machine\n");
 		pr_info("vendor=3D%s, model=3D%s, version=3D%s\n",
 			i8k_get_dmi_data(DMI_SYS_VENDOR),
 			i8k_get_dmi_data(DMI_PRODUCT_NAME),
 			i8k_get_dmi_data(DMI_BIOS_VERSION));
 	}

-	dell_smm_init_dmi();
-
-	/*
-	 * Get SMM Dell signature
-	 */
 	if (dell_smm_get_signature(&i8k_smm_ops, I8K_SMM_GET_DELL_SIG1) &&
 	    dell_smm_get_signature(&i8k_smm_ops, I8K_SMM_GET_DELL_SIG2)) {
 		if (!force)
 			return -ENODEV;

-		pr_err("Unable to get Dell SMM signature\n");
+		pr_warn("Forcing legacy SMM calls on a possibly incompatible machine\n"=
);
+	}
+
+	return 0;
+}
+
+static int __init i8k_init(void)
+{
+	int ret;
+
+	dell_smm_init_dmi();
+
+	ret =3D dell_smm_legacy_check();
+	if (ret < 0) {
+		/*
+		 * On modern machines, SMM communication happens over WMI, meaning
+		 * the SMM handler might not react to legacy SMM calls.
+		 */
+		return wmi_driver_register(&dell_smm_wmi_driver);
 	}

 	dell_smm_device =3D platform_create_bundle(&dell_smm_driver, dell_smm_pr=
obe, NULL, 0, NULL,
@@ -1522,8 +1644,12 @@ static int __init i8k_init(void)

 static void __exit i8k_exit(void)
 {
-	platform_device_unregister(dell_smm_device);
-	platform_driver_unregister(&dell_smm_driver);
+	if (dell_smm_device) {
+		platform_device_unregister(dell_smm_device);
+		platform_driver_unregister(&dell_smm_driver);
+	} else {
+		wmi_driver_unregister(&dell_smm_wmi_driver);
+	}
 }

 module_init(i8k_init);
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index a78ddd83cda0..0b3e63c21d26 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -106,6 +106,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
 static const char * const allow_duplicates[] =3D {
 	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
 	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
+	"F1DDEE52-063C-4784-A11E-8A06684B9B01", /* dell-smm-hwmon */
 	NULL
 };

=2D-
2.39.2

