Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F97E0898
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376382AbjKCS6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbjKCS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:58:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526DDD52;
        Fri,  3 Nov 2023 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699037849; x=1699642649; i=w_armin@gmx.de;
        bh=9LvlOmhpH9iWfMYNosm+bGwGYKTCP/LSNJ3DjhwmrYw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=gp8l9nRw9HIBL91ke7K2XxFYdV1iy069yo0NlLYqaKPH+o4PwkLAtA3YG2VSaQwp
         TQWQFMtQOMlrykdrXXiiSV33vAv8HvSqir3d+hp8pYe37XWZ2YXCThoZtcfwWlOh8
         eKqes9MvkpnMHlGf0P4zZFAoCWNqa2OIVib1GyT43OaIiZUD77HU6XsYIIuXCd5da
         TfCurRnb3WmNNZ3WXu30UGUMnNdy+JqxJ8bAqudHg3YNqGHuhMe5a7E+lVtGpSef8
         DDUAk7ECDMXIxSRsBZWewS6kkVQsb70/otfdUPeqQ0cUInRW3TziUX876kECIwtEm
         BkssIIF5GTN9NvXG0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MXp5Q-1qvgWa3lBk-00YCJe; Fri, 03 Nov 2023 19:57:28 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] hwmon: (dell-smm) Move blacklist handling to module init
Date:   Fri,  3 Nov 2023 19:57:09 +0100
Message-Id: <20231103185716.11007-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103185716.11007-1-W_Armin@gmx.de>
References: <20231103185716.11007-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mb+wmDPk0AzjISxjlwcGeMyqMbPhPLEZsDJx2saCt1eWWl6hxPC
 94ExnuMZDtfRigzH+GlzR5GM8Hk3ZpeZSRV83ou4aUIqmdy4tUVgCa9GeCUUh77+riBjK6a
 moKl34kz755I5oCs2c6iG2yqgkW5nkOc1NWKa0rRnbpKV3jFK5eEdrhMHP8W5pKKTEBlvld
 96AYwNld97aNPxe8Y+sdA==
UI-OutboundReport: notjunk:1;M01:P0:7NOZs1Ec4Vs=;5QENkHsv8I+EvYPZG/YmGYKeamy
 keI4e+h0A8yJusxPTxbO6LrYbg2kNiWXYV6qs19ZLygwWZZGaxD++vbCh3rDWoNpbakVEHNk+
 3DyTw0KEw7V/Whk4pZtwV3NXdHGkIbBlaqGs7148dA0bXry03ZZoiRfzmcrmdwojjYP+BrUEA
 gR8+HTU/Ar6WrjrQJ9JD/R5z0wrLI5OqEdwc32IsAKU8Bm2LN2TsaU/dZX0sem5ykWUafBzM9
 YSyAcqEmQGXGS126TrkzgKfP3JtxVnbSb3sp2ISP4RFLgKKKnxaelKOmWK1t/GKyu4pB9PJz2
 Y2+A82n8VCKEuSSyiMxcoZr4kWZqPm/ssz2/nltoK6Ycv2Yu9mIF585dbhGn1ZVUN2AZ3fsA0
 zaDNs3wtEYfaE2aQ5hMcmc+0d7hf3O+u795KYreId3OEYoPVJrn/WKuMu4AG6KJmiQ9R2RCFF
 BrkwxmdfkBHDUw1KFfpbJ1B12bivkeOs24T0ldV5tqk+tqgoS3pGJPFJ3b35fPFmZQsQ75mWf
 CSI8c9Bk2iG2pWPbwUVPBQ2y+CgjsBP7SSQaj+4auZbGqXJI3EX+35/N2Dg1xcgIMZCs3pwi9
 khzYlOETJXtnQ/kBiid5lWHmkxrkqY0aljPmr1PVKpaYKpDzULoRpfFMbZXf5SZNDGI2xWTqy
 vCa5mvmL5zpa2LglG1URXucMItbgRLLi2viq6sUYWsnfQn4fHqeCXkz+w4J697GSBcMxOJxy2
 FhP/FZhRK1xaj5yHCS9yXnecQMPC8cdMAPbEWxWhICYggDF+QRMlb/UDD+SMmUwNVwz/u6Roq
 a8LNH8SvQfmcGWG/cj0Gen5aCaAylPEqE4AiCw16eKOtkmCrUqjvuVyWNUGRai+ZixVizbICP
 iIsIsYXOaZCdZnh4nV/rcbcyc2XKpg2cypqQjQF4mgMEtP2oGqUV5xZRQXGXmIUyOwts5bwXX
 Mey0pxlmKNkIbEdno/XCyGGeotQ=
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

