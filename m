Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD87E1A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjKFGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjKFGoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:44:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60C2112;
        Sun,  5 Nov 2023 22:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699253038; x=1699857838; i=w_armin@gmx.de;
        bh=9LvlOmhpH9iWfMYNosm+bGwGYKTCP/LSNJ3DjhwmrYw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=qyg9ibjxlHL6YPCsuuQimY7Hz1Bh35dHrC1ueoUMEOdKFfklhJ+5yrt8lp4svMcq
         8173SUrsTo3sMlQWoXUW2PZ/1PUOr/Q8RIjrGwDHsulj/G65EJgCRc02oRGbN/OFY
         zNq1nzuhkE6w3zw1Bl/b336sbpaqgImGwSfTqFACEib8KnfXTVqwgbjdpwrDq6+4V
         LuAdklf4KwkmfMfQps3pk4udF+iCbGnEboCJ52ke/sPngsa75iajV5M2rfmxkKss+
         a8NWWTWLw4kp2AIOS7VTxuamLL8sEK3eI0XSQNEEzq5rGibhEQW1yRs+PuOf84M2h
         amyIop3mSiz5tq5qaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M1Ycr-1qyVMM3ZN5-0037sN; Mon, 06 Nov 2023 07:43:57 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] hwmon: (dell-smm) Move blacklist handling to module init
Date:   Mon,  6 Nov 2023 07:43:44 +0100
Message-Id: <20231106064351.42347-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106064351.42347-1-W_Armin@gmx.de>
References: <20231106064351.42347-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JgeqTCtJMTk2yEjBNKF1oQ0+BnZ/05FnQJqkSbkUc6ycPoYGSjz
 sb5L8p8kgPFjc3nlsFdFJ9bDqJjkRpeGxqvLUHZo8yUVz8YiX7H8tl20Sb+951BPd8RMoWa
 ohFOju2d6tSKCYcMMY+VDePqwvP4mXyZ96OM8bqM7aHsEJ/p0m2p3NYamRXDqbHoq8zpi4V
 OdvHjhdRScoHRZJqznTYQ==
UI-OutboundReport: notjunk:1;M01:P0:/PVZ9O1eW7Y=;oP5s6H6VPVRUeUWhwvF8LSr8g55
 je+czHbobRQrSYAkzAZxI5+baEk/wo7jZcx1e2+DCmCr0omyYjGrjCHWO0XdUmdPnh15os2GN
 8hX+Gg5O3g3uFQrIICkfqjybKKe7fzDu1JtaUxzceHauhuLLmXu3fEY9vd4qfKwPdZL2iMR9V
 +afd8iBtHV0OERKsvuW1pKFDenNO2uYj7SnJkHfRCzpO65r8O5Xd99ojxHwnpVrYrSiFCfQJE
 m9+qyZleG1kt4SGwvgSVJmW21twigmHCw6F3Ivv7HQ+jNdQ9xTrLgBl4O2MQ+jrOLxmyXxSF3
 WxD1ULw+wWn9nfUAOADdvtNlNAHr1KjVPNcFjfXWcXzstyGrYC1TgqYBfxG1Rgts3zdkP/6JF
 XhDsqr+plPt3jgtoIJGN28ilRcb7TubW2oxcWxhkWehvQiq2On03Tt/iSCn9Ocb5Vvv1iEU7S
 BPegf+nUl9l0HC0EQYN5F7MS5STed2A2VvDkTISBa/s5xMC11hOxr84g5IuNB5mzp1QJMSBvO
 H1w3vKXrdamUw1S1o8mDAP4RfLfYDzPPjfR/8nEhmUh5+ma/QXzVhWqfXLS1f4wtCFaq8IVQJ
 ZyvJqmTffV+nmJUEPGz72bTAqmiuU01bCB/F3NwSLiFeHgy0LZAAxUqQFImHzTiJJ1cELU0cF
 b4cUdKI7CD0yyDttGeXPW/znQ93lUe+fG9MA1dOBy4JgtTGRuK+2OgCX9d8vJXxJIKvSAvcGw
 xlD0j81BBxuOJGdRSKAx4fx4EyRa0lVyvuNUCCpUESIqe2jWgLJeFF3kufrvVCeBmWCs2lfBS
 H6RBzXONUv0b+g+K8oCsNdKCENbPTekHfGb4PNmpGqR31GjHIE9q5uI7mZUhjM9f8vsWCwFOT
 WAZrv9yxKPlxKbmqgpH0t05NJQZzHgB408AEc/ZEbf1/dS9ZGHOsljHEA4fl/YbvgHCpqRYM0
 yUHm/1LZxO9WpL4QmrFaI9oumK4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 63 ++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index a3273780f7c3..ccb3fcff4f60 100644
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

