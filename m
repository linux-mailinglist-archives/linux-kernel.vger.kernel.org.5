Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F57F5589
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjKWAtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjKWAtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:49:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA666D46;
        Wed, 22 Nov 2023 16:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700520; x=1701305320; i=w_armin@gmx.de;
        bh=0V3bzfnMuRNI/HSKvd9H3yajcogpKLc5fz8Tc5YYU+E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=RlVRdU5hrO810MAZ5l8slJAU6xEjGmxBj81/5DEKCgNmCZW+WUSqEfJ1v7dGfSiA
         wlLoFsbVnXcIBqmLoLqH+AiI6390+ha7jRDKF+rz3uIwsO441F1q7WMsoOmjJQa1g
         fSvr05chP625v/LbfFnu+l2tq9oJlNaHGOrFvuEx1kbRZzmp0+E0aBF7MYUk7ZjWc
         AuP5Ux8rM/btC3b3rOE6Z0Bqg6qY4k1dkfIWIHULK1RIlvwojC93WIonoNzFq0Eoj
         OkRIfwCWk9Z6VZpZTqdskqWxRDmROtVKkaEiElOKOGnQ8KaaI25VU92iPkAJb2YQD
         1zI/hQ8giuVdUmsDiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MDQiS-1rD5QP43c6-00AYWC; Thu, 23 Nov 2023 01:48:40 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] hwmon: (dell-smm) Move blacklist handling to module init
Date:   Thu, 23 Nov 2023 01:48:13 +0100
Message-Id: <20231123004820.50635-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a/fdW2dy4yeFSAYerlCeoKCs5X20lLxsnjkJMe/xNOw3HCPoC0b
 XCdVWBKQNBxshBIX/abhURkl1ldltxDRzeB6YV7+y4wL/Xfljrkz/a7aXCq1dv4FUAIeatt
 YjDeqm8e+AD+XDAOIyZDCYI1QDxXOX/RICSzBeWaCKm0HQboZLJekwbo2sq7OEe4kpx9OE8
 IcrImgBvEclY1pFxyPacA==
UI-OutboundReport: notjunk:1;M01:P0:KJkxZR1bsD0=;EoBxRaRiYzt2O2djAy2Wczj9GZQ
 LBpLai+YmtYELmJKjvZveB/lIccuz6d4iYMiGCbpAg5Vh7UQPNt9TG1RbEJKOgCAUh5nA7HyK
 rcfzRTE9G0ksxJktUcGClPoPUlDXL9TNtz0Ar2AzDH51EShgVWs9dmjpGa4SqA40NlisS4CJH
 khNcdHBV4EqaLtjiYjgQmmqPi4dJKGbjwqMZfBpZPNKnKIjM4gzpo4oZqwbNFcTp3wViT1Tv4
 7X34MHGNOkfA2SGbrZ9DXDFI7mCdb639shxgQclk6E7ujNTUXmmEhDX11UWpPcOP2K6d9adat
 XpYFircMd35CQO/8OtlLVioAosncJeeOI6E6SJ0pZr+eccilQ4g2ijFM2XJ6v2dwEzPalrf6H
 HmKAcm+2K+Chmd/D96z9dM20wfhdSaBO4d9w88M62kdQNuCk6lZp4sgPnyv2OL74gG/dzgfkl
 wj5+hJ1p5XTvvlRPRy+qvro5asKaFkhJQrGJaLe8f/h2WjWhJ04fptHADH8Nb+VqoLT/ijLx6
 s0KTvsNy3UmcFFNALoTt5wuz4UicuXNmNmPUajQeKAeWq3rWVxgnJ8FsmOrFxkRnLcE1Cs8S+
 jErCmYFqCNuZXLWR+Gz5xUKc/vYN+4fTePc3hRxgDqzhimfGLKpiGHL5qwYlPS7n6iNOt6rCX
 AlWR7C1QXfY7q9+PwlLzC7xGjg2pM/L1Flc/i0y9IIk0mgbNyhgLKSMI5S+WKrOFiEjAu27tK
 0mXHMkhjh6wDbaXE01B4exNu4DbX9BiW6EJiOvsR6XB0a+lZBKPqMFK8xe3VhpXn0Y1E2pQGp
 r+29viAxMLELNPs4SU4N+2mafJ53s12xZGKHvl2/0fOJzh5/NkXhQhco0qQnLFYQWL7PiReo1
 QKP5hmGvZQyF5yXK8ovHCxU23XUMhrcn07DqBfleAXVjrvqDvb2BbodzD4xeRmkot+L6pwIfS
 N0H3dA0w5+Emyzkw2SvNXTwodvk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future SMM calling backends will not be able to probe during
module init, meaning the DMI tables used for backlisting broken
features would have to drop their __initconst attribute.
Prevent this by moving the blacklist handling to module init.

Tested-by: <serverror@serverror.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 63 ++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index f66bcfd7c330..87d668799c9f 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -90,8 +90,6 @@ struct dell_smm_data {
 	uint i8k_fan_mult;
 	uint i8k_pwm_mult;
 	uint i8k_fan_max;
-	bool disallow_fan_type_call;
-	bool disallow_fan_support;
 	unsigned int manual_fan;
 	unsigned int auto_fan;
 	int temp_type[DELL_SMM_NO_TEMP];
@@ -138,6 +136,8 @@ static uint fan_max;
 module_param(fan_max, uint, 0);
 MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: autod=
etect)");

+static bool disallow_fan_type_call, disallow_fan_support;
+
 static const char * const temp_labels[] =3D {
 	"CPU",
 	"GPU",
@@ -256,7 +256,7 @@ static int i8k_get_fan_status(const struct dell_smm_da=
ta *data, u8 fan)
 		.ebx =3D fan,
 	};

-	if (data->disallow_fan_support)
+	if (disallow_fan_support)
 		return -EINVAL;

 	return dell_smm_call(data->ops, &regs) ? : regs.eax & 0xff;
@@ -272,7 +272,7 @@ static int i8k_get_fan_speed(const struct dell_smm_dat=
a *data, u8 fan)
 		.ebx =3D fan,
 	};

-	if (data->disallow_fan_support)
+	if (disallow_fan_support)
 		return -EINVAL;

 	return dell_smm_call(data->ops, &regs) ? : (regs.eax & 0xffff) * data->i=
8k_fan_mult;
@@ -288,7 +288,7 @@ static int _i8k_get_fan_type(const struct dell_smm_dat=
a *data, u8 fan)
 		.ebx =3D fan,
 	};

-	if (data->disallow_fan_support || data->disallow_fan_type_call)
+	if (disallow_fan_support || disallow_fan_type_call)
 		return -EINVAL;

 	return dell_smm_call(data->ops, &regs) ? : regs.eax & 0xff;
@@ -313,7 +313,7 @@ static int __init i8k_get_fan_nominal_speed(const stru=
ct dell_smm_data *data, u8
 		.ebx =3D fan | (speed << 8),
 	};

-	if (data->disallow_fan_support)
+	if (disallow_fan_support)
 		return -EINVAL;

 	return dell_smm_call(data->ops, &regs) ? : (regs.eax & 0xffff);
@@ -326,7 +326,7 @@ static int i8k_enable_fan_auto_mode(const struct dell_=
smm_data *data, bool enabl
 {
 	struct smm_regs regs =3D { };

-	if (data->disallow_fan_support)
+	if (disallow_fan_support)
 		return -EINVAL;

 	regs.eax =3D enable ? data->auto_fan : data->manual_fan;
@@ -340,7 +340,7 @@ static int i8k_set_fan(const struct dell_smm_data *dat=
a, u8 fan, int speed)
 {
 	struct smm_regs regs =3D { .eax =3D I8K_SMM_SET_FAN, };

-	if (data->disallow_fan_support)
+	if (disallow_fan_support)
 		return -EINVAL;

 	speed =3D (speed < 0) ? 0 : ((speed > data->i8k_fan_max) ? data->i8k_fan=
_max : speed);
@@ -705,7 +705,7 @@ static umode_t dell_smm_is_visible(const void *drvdata=
, enum hwmon_sensor_types
 		}
 		break;
 	case hwmon_fan:
-		if (data->disallow_fan_support)
+		if (disallow_fan_support)
 			break;

 		switch (attr) {
@@ -715,7 +715,7 @@ static umode_t dell_smm_is_visible(const void *drvdata=
, enum hwmon_sensor_types

 			break;
 		case hwmon_fan_label:
-			if (data->fan[channel] && !data->disallow_fan_type_call)
+			if (data->fan[channel] && !disallow_fan_type_call)
 				return 0444;

 			break;
@@ -731,7 +731,7 @@ static umode_t dell_smm_is_visible(const void *drvdata=
, enum hwmon_sensor_types
 		}
 		break;
 	case hwmon_pwm:
-		if (data->disallow_fan_support)
+		if (disallow_fan_support)
 			break;

 		switch (attr) {
@@ -1381,24 +1381,6 @@ static int __init dell_smm_probe(struct platform_de=
vice *pdev)
 	platform_set_drvdata(pdev, data);
 	data->ops =3D &i8k_smm_ops;

-	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
-		if (!force) {
-			dev_notice(&pdev->dev, "Disabling fan support due to BIOS bugs\n");
-			data->disallow_fan_support =3D true;
-		} else {
-			dev_warn(&pdev->dev, "Enabling fan support despite BIOS bugs\n");
-		}
-	}
-
-	if (dmi_check_system(i8k_blacklist_fan_type_dmi_table)) {
-		if (!force) {
-			dev_notice(&pdev->dev, "Disabling fan type call due to BIOS bugs\n");
-			data->disallow_fan_type_call =3D true;
-		} else {
-			dev_warn(&pdev->dev, "Enabling fan type call despite BIOS bugs\n");
-		}
-	}
-
 	strscpy(data->bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION),
 		sizeof(data->bios_version));
 	strscpy(data->bios_machineid, i8k_get_dmi_data(DMI_PRODUCT_SERIAL),
@@ -1453,6 +1435,27 @@ static struct platform_device *dell_smm_device;
 /*
  * Probe for the presence of a supported laptop.
  */
+static void __init dell_smm_init_dmi(void)
+{
+	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
+		if (!force) {
+			pr_notice("Disabling fan support due to BIOS bugs\n");
+			disallow_fan_support =3D true;
+		} else {
+			pr_warn("Enabling fan support despite BIOS bugs\n");
+		}
+	}
+
+	if (dmi_check_system(i8k_blacklist_fan_type_dmi_table)) {
+		if (!force) {
+			pr_notice("Disabling fan type call due to BIOS bugs\n");
+			disallow_fan_type_call =3D true;
+		} else {
+			pr_warn("Enabling fan type call despite BIOS bugs\n");
+		}
+	}
+}
+
 static int __init i8k_init(void)
 {
 	/*
@@ -1469,6 +1472,8 @@ static int __init i8k_init(void)
 			i8k_get_dmi_data(DMI_BIOS_VERSION));
 	}

+	dell_smm_init_dmi();
+
 	/*
 	 * Get SMM Dell signature
 	 */
=2D-
2.39.2

