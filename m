Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145D7F559D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjKWAtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjKWAtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:49:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50CA10D4;
        Wed, 22 Nov 2023 16:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700528; x=1701305328; i=w_armin@gmx.de;
        bh=QU/fikrXASrkJJFGObsA5vw2cS6jYRUC5rQHjgXzBWY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=b4YZg92rZpXgWJwHyQaR89wsr6f1h5YT6xXq9koJ8NUf2t3+yNv2Ee4mVbtS4Boq
         swCa1tA7lUof4Gh+I4x0wBL4JPMGFSm91JyD56H4Kbo6VuzYLGW3m0Zy9gXA0/iwa
         NnQ1UVfSKP8++1mRS+oyedZw2JfgYZnSvjNCUdKtXsmU2z/QHK3r3n9YH+RsRP29Q
         c46zL1Z5/TXyOB7NSQhfGqRpemP56qZCguceI2pYG3R2Iv4LUOGKv5gFgyDjCdXj0
         C2kdU/W/FbvDNiUmQMToL6YRwqfibHJq+yEIXOxOHkJjF3iG/ILl5sKVKYmyBGE8G
         Ajvq8HvG6yhX2YqGSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N0oBx-1rII7B24mr-00wjHn; Thu, 23 Nov 2023 01:48:48 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] hwmon: (dell-smm) Add support for WMI SMM interface
Date:   Thu, 23 Nov 2023 01:48:18 +0100
Message-Id: <20231123004820.50635-8-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s1fMuo2wdlUW/5cyisDKRKTpMoW1C50KaQRYjugB04Y38gSWsU8
 7P8sq9WhM2+3rsbHCb9g8lZwBM2WEI3ZRjLHrtfyWAtDU38RKqBso6u3m4kswo3f4RAODp0
 TQ1hgfwwAzkvGGqJRon3F6edzvpmUQ2YAaemBcjjHlX8S8vLoBAbNSgaLXc115rcpTyhPS7
 GHPsrxazmZoSjTSpLIWVg==
UI-OutboundReport: notjunk:1;M01:P0:3vOS++G1dgY=;wy8NRIj7z5aVgjPDv0vEW0b2w7C
 PuVP5Z5KzEDM8xqt/F10e02U6GeOuPqeJycaxqr2e/V8wrsyklQgzs9boVgdRdNgEi0JawhaG
 jJfnZy9/b3B501rxYtyBmVNH1ljouadUK2RAJinCrJe3tWkHcin5gw1+3Ubo5adSjByO7QNEE
 lcktU1SNkbmIsYq6zDUhmhG5s4juRX6DptcROQMcA0IoCyuFU71kJZM1nGZf2SqWOVYqbiEmL
 urPLvxyUV0848KU0cxciKeIYjS1odUI3gF340MjAWIVASRkxpmyMtJbnwr9JiMDsjAqsgz8q6
 s1qcaCwWP5qtVYXkEC6FiG17GqQtb3QptSV/6TSMmLipwAgh0dBePAv4dm1r5+fdBF3g6rNTK
 99pKhOGb+1PlinjNmzzkIefQwuHtc5u27cVk9dDm0+nsAzSieWNiNIlnhW6JkC6Cbm8KdHTGG
 TM9ru/R4/DAOu4F6Alwv+868WA4EHJmoJtityBWqZ7DmehXBV05iiVkH05GtiAHDw9QE0b2M+
 KuJkObNNParkwB/EdBcRw4JaGifrR5/n2gPJs31D5IPXqcoZLD1j3kuXrVS4IodxlZlaO21iY
 h8804gZmiOIONPg27DMZ0Jo9tsn5YIevsRzm3CTmcu1exV/Wk64EXrgK6aJpkYRCGCC8Qdrx2
 fo/cH6WKruvVpNLCfNcSBCP+KRsWE7xy4VsV0Y8C4jT0EbTsxIZObrMWI1ZxxsF8eh3635jOx
 f4kJulMvWUg0gE3XVp3sgWY5mTXgXRvlfA+FROA1//uymtK55BC7wGpHXcudb3SE9ERxJPD/R
 Sv0k2Lr3bB+R5XqwCsTx3IDq8GZLCpA3klFxATjLpi5Y1FfiPbG3Nif+jX1TZo8zmQgDkeUCk
 QGk8jZsO1O2swo/1KsAdfqKC4bqGdChcR5quyUYQoyLJEp5plJK7VU3umIJMvncyGuVMRbe0d
 k13ylPMSjClPR2K2OLsoDVJmEgM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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

Tested-by: <serverror@serverror.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/Kconfig          |   1 +
 drivers/hwmon/dell-smm-hwmon.c | 199 +++++++++++++++++++++++++++++----
 drivers/platform/x86/wmi.c     |   1 +
 3 files changed, 182 insertions(+), 19 deletions(-)

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
index a377cd08355f..95330437c5af 100644
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
@@ -66,6 +69,9 @@
 #define I8K_POWER_AC		0x05
 #define I8K_POWER_BATTERY	0x01

+#define DELL_SMM_WMI_GUID	"F1DDEE52-063C-4784-A11E-8A06684B9B01"
+#define DELL_SMM_LEGACY_EXECUTE	0x1
+
 #define DELL_SMM_NO_TEMP	10
 #define DELL_SMM_NO_FANS	3

@@ -219,6 +225,103 @@ static const struct dell_smm_ops i8k_smm_ops =3D {
 	.smm_call =3D i8k_smm_call,
 };

+/*
+ * Call the System Management Mode BIOS over WMI.
+ */
+static ssize_t wmi_parse_register(u8 *buffer, u32 length, unsigned int *r=
eg)
+{
+	__le32 value;
+	u32 reg_size;
+
+	if (length <=3D sizeof(reg_size))
+		return -ENODATA;
+
+	reg_size =3D get_unaligned_le32(buffer);
+	if (!reg_size || reg_size > sizeof(value))
+		return -ENOMSG;
+
+	if (length < sizeof(reg_size) + reg_size)
+		return -ENODATA;
+
+	memcpy_and_pad(&value, sizeof(value), buffer + sizeof(reg_size), reg_siz=
e, 0);
+	*reg =3D le32_to_cpu(value);
+
+	return reg_size + sizeof(reg_size);
+}
+
+static int wmi_parse_response(u8 *buffer, u32 length, struct smm_regs *re=
gs)
+{
+	unsigned int *registers[] =3D {
+		&regs->eax,
+		&regs->ebx,
+		&regs->ecx,
+		&regs->edx
+	};
+	u32 offset =3D 0;
+	ssize_t ret;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(registers); i++) {
+		if (offset >=3D length)
+			return -ENODATA;
+
+		ret =3D wmi_parse_register(buffer + offset, length - offset, registers[=
i]);
+		if (ret < 0)
+			return ret;
+
+		offset +=3D ret;
+	}
+
+	if (offset !=3D length)
+		return -ENOMSG;
+
+	return 0;
+}
+
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
+	int ret;
+
+	status =3D wmidev_evaluate_method(wdev, 0x0, DELL_SMM_LEGACY_EXECUTE, &i=
n, &out);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj =3D out.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	if (obj->type !=3D ACPI_TYPE_BUFFER) {
+		ret =3D -ENOMSG;
+
+		goto err_free;
+	}
+
+	ret =3D wmi_parse_response(obj->buffer.pointer, obj->buffer.length, regs=
);
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
 	unsigned int eax =3D regs->eax;
@@ -306,7 +409,7 @@ static int i8k_get_fan_type(struct dell_smm_data *data=
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
@@ -349,7 +452,7 @@ static int i8k_set_fan(const struct dell_smm_data *dat=
a, u8 fan, int speed)
 	return dell_smm_call(data->ops, &regs);
 }

-static int __init i8k_get_temp_type(const struct dell_smm_data *data, u8 =
sensor)
+static int i8k_get_temp_type(const struct dell_smm_data *data, u8 sensor)
 {
 	struct smm_regs regs =3D {
 		.eax =3D I8K_SMM_GET_TEMP_TYPE,
@@ -401,7 +504,7 @@ static int i8k_get_temp(const struct dell_smm_data *da=
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
@@ -986,7 +1089,7 @@ static const struct hwmon_chip_info dell_smm_chip_inf=
o =3D {
 	.info =3D dell_smm_info,
 };

-static int __init dell_smm_init_cdev(struct device *dev, u8 fan_num)
+static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);
 	struct thermal_cooling_device *cdev;
@@ -1017,7 +1120,7 @@ static int __init dell_smm_init_cdev(struct device *=
dev, u8 fan_num)
 	return ret;
 }

-static int __init dell_smm_init_hwmon(struct device *dev)
+static int dell_smm_init_hwmon(struct device *dev)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);
 	struct device *dell_smm_hwmon_dev;
@@ -1083,7 +1186,7 @@ static int __init dell_smm_init_hwmon(struct device =
*dev)
 	return PTR_ERR_OR_ZERO(dell_smm_hwmon_dev);
 }

-static int __init dell_smm_init_data(struct device *dev, const struct del=
l_smm_ops *ops)
+static int dell_smm_init_data(struct device *dev, const struct dell_smm_o=
ps *ops)
 {
 	struct dell_smm_data *data;

@@ -1409,6 +1512,9 @@ static const struct dmi_system_id i8k_whitelist_fan_=
control[] __initconst =3D {
 	{ }
 };

+/*
+ * Legacy SMM backend driver.
+ */
 static int __init dell_smm_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -1434,6 +1540,47 @@ static struct platform_driver dell_smm_driver =3D {

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
@@ -1485,33 +1632,43 @@ static void __init dell_smm_init_dmi(void)
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
@@ -1522,8 +1679,12 @@ static int __init i8k_init(void)

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
index 5c27b4aa9690..d68a96a2c570 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -106,6 +106,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
 static const char * const allow_duplicates[] =3D {
 	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
 	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
+	"F1DDEE52-063C-4784-A11E-8A06684B9B01",	/* dell-smm-hwmon */
 	NULL
 };

=2D-
2.39.2

