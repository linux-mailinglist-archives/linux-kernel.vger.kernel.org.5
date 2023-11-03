Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02717E0896
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbjKCS6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbjKCS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:57:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47CCD4D;
        Fri,  3 Nov 2023 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699037852; x=1699642652; i=w_armin@gmx.de;
        bh=yby7QfP6v7gwS0o8J0rP+60CpZOmUkz59NSuTBr0O7I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Jg/2cXlG5b529xD5ftzLw8JrREx6m0Bo3wx2hpr9wVrutKYiRK80IjYXJBg5ykOF
         Qd9gSOZfNW+J8ecqAHIY7pHBDu5MFKmTR+ltwsU8bUHrdZ7FZhojoOspqP+pjFup1
         CIn1H0sQ/TeCKP+ThMSxO0UjRXU8A5DJVzymWXtv25PrPIccd1i89BuUqAGOr4HXE
         5wK2gx8KZI1Ql/tPM4S10vKpclznBZK7kDVvKh/y8HbCyoPyMENPLyo0qaZ37dFNo
         ZQmcNRhBgo9k5UOwoWhK345rWt4NXFGSsC3EPjOBYcE5Sz6KX9Ffm2XTesKuFS8gq
         0d83ioUaD/U3S8tfIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MOzT4-1qmqoq31MS-00PJXR; Fri, 03 Nov 2023 19:57:32 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] hwmon: (dell-smm) Move DMI config handling to module init
Date:   Fri,  3 Nov 2023 19:57:11 +0100
Message-Id: <20231103185716.11007-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103185716.11007-1-W_Armin@gmx.de>
References: <20231103185716.11007-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FjD0VhGMK/IvDEbomadXhlvckbeIMypBhk2Rm4f7+pRtVUefStC
 jNyM4sXKytDZfYVPN98FZ8wgJwxbY42wou5wkecC6tw+cviKrbteXfkIe54iEdzrhB6RDyG
 AWCT1Bf10nJGehEbGHb5SDeOvca9rVpyPdzAjIWWPC5uhD/2uFEZkh/9XGOuLK/9vYJrh7u
 n9RqA+MqWGHWs9KqK+HKg==
UI-OutboundReport: notjunk:1;M01:P0:eOqffFKqppA=;9s8wBS2MSQNX1eD90KUchYyhmIp
 giE1IU4Ze+pK2moU7XawAt6s78YRJlDHiVdN5Of47Ini6pzdCU92pCra6Biosu+jmWbFs/dtT
 YlvJfraslIEM9EjAtRPOw42BXWGdaOK8i8aUek6krmIhA4i3dVG42GvoeHxwg+S/mHX5sYg/U
 RfkiAtM3U72sIUlgo1dQBOPQJn9OAR3X5JDliVVY26J2cdR6Q6bKo+zWY9CEudhmzrZmiMhvp
 /Sw6jNsdV0dygNdo5Pf2hNvcIncCLN2qiBBVdFq3VPLsUU5nU0AnUc2VJFYJzmRbNXiw+x1Su
 btgGx9453dfTbezXR4vLfE5/hIE0ym1l8V27W2lpbHpZ6uCi2D4+JcooeDmrtbctnOSl1yIU7
 HUU0QBh8qY/bU+XHPZNh7yOahQQpSCd0PEuwmf4VOZAk3HR5WPZmiCaEpWjCo7xDPbswGCII3
 Waw4Rwnox1Me2Z0CSHA6YrV7ssOGPm8ryx15s0faG3HkxfGkmP8Kah91nkHfHsiSLljavmXX5
 oSjSFUdrEEeoEgSl546ZVESGICp0A4Wr4J7PzluQ3ZlnFX0Bhip+XXMhsxoPZ5rtO5EVrkxEi
 +Am6+Scl2I7490Jo9ztsk0+GuxKwrlu9HkUOt10UOHlY0F10lmBvVmSeopB8ebmf/eler/GJl
 xac9PuE01ey4ZYe8iDiDplIslBSqGRr+hoYRTGkHvpr1PCtGiePsLl4ERHkV4FKagSTQfEfDZ
 M3M1RoeFC2OAMlz0+tMnB1J506LD1BLWAg4DhODpWogluGIBaWmkPUEvZQpD9bLH8uCaGAuJv
 g21iX+5Li1br6O24ecpKMt7Ycb7zu9tqaL0pIOkeuAM1BAi3kxOolFXxt1kBCrvJniGHlBhQA
 G8I/WEB6QjLBmLlqP8MfQrYnCflW/wvMYy0Tao+UXnIHZOUUlTw+JZqX0JoCm5wZZ7oohVK9C
 W+D+xSk4YM2iOm4LcTVFeBaL20o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future SMM calling backends will not be able to probe during
module init, meaning the DMI tables holding config data would
have to drop their __initconst attribute.
Prevent this by moving the config handling to module init.

Tested-by: <serverror@serverror.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 3a792faf2369..3d14a3baf8e4 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1370,7 +1370,6 @@ static const struct dmi_system_id i8k_whitelist_fan_=
control[] __initconst =3D {
 static int __init dell_smm_probe(struct platform_device *pdev)
 {
 	struct dell_smm_data *data;
-	const struct dmi_system_id *id;
 	int ret;

 	data =3D devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERN=
EL);
@@ -1386,21 +1385,6 @@ static int __init dell_smm_probe(struct platform_de=
vice *pdev)
 	strscpy(data->bios_machineid, i8k_get_dmi_data(DMI_PRODUCT_SERIAL),
 		sizeof(data->bios_machineid));

-	/*
-	 * Set fan multiplier and maximal fan speed from dmi config
-	 * Values specified in module parameters override values from dmi
-	 */
-	id =3D dmi_first_match(i8k_dmi_table);
-	if (id && id->driver_data) {
-		const struct i8k_config_data *conf =3D id->driver_data;
-
-		if (!fan_mult && conf->fan_mult)
-			fan_mult =3D conf->fan_mult;
-
-		if (!fan_max && conf->fan_max)
-			fan_max =3D conf->fan_max;
-	}
-
 	/* All options must not be 0 */
 	data->i8k_fan_mult =3D fan_mult ? : I8K_FAN_MULT;
 	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;
@@ -1429,6 +1413,7 @@ static struct platform_device *dell_smm_device;
 static void __init dell_smm_init_dmi(void)
 {
 	struct i8k_fan_control_data *control;
+	struct i8k_config_data *config;
 	const struct dmi_system_id *id;

 	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
@@ -1449,6 +1434,20 @@ static void __init dell_smm_init_dmi(void)
 		}
 	}

+	/*
+	 * Set fan multiplier and maximal fan speed from DMI config.
+	 * Values specified in module parameters override values from DMI.
+	 */
+	id =3D dmi_first_match(i8k_dmi_table);
+	if (id && id->driver_data) {
+		config =3D id->driver_data;
+		if (!fan_mult && config->fan_mult)
+			fan_mult =3D config->fan_mult;
+
+		if (!fan_max && config->fan_max)
+			fan_max =3D config->fan_max;
+	}
+
 	id =3D dmi_first_match(i8k_whitelist_fan_control);
 	if (id && id->driver_data) {
 		control =3D id->driver_data;
=2D-
2.39.2

