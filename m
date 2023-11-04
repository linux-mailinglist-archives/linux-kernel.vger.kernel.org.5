Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D657E103E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjKDP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjKDP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E63CD4C;
        Sat,  4 Nov 2023 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113372; x=1699718172; i=w_armin@gmx.de;
        bh=h1b+qI1DwuXjAP0XrrB6EkWVEvalXVcaQqX1+xZYP50=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=BdEh+QAhm9CJdLAgX0bNBL1TtKOEOSX7X/KLaNARfjvj6/JQmr2Q2xkP39BN9upX
         so4xBhrjLzyIY3c2fy9VB8uq0+MhetdDIzubo7TDzzLXdHeMpgwgWLu5LjOv3Yo0Q
         trhNqV3vLQha7LTmoQhooCv2eiFb08jyYKFxOIH9pQvyOmQd1+8XtSdMXCh8aHsZP
         inmCXOTx5+gG1QagIRH/Eubap0zNdHiHen4vH1MG4s31siOfMvmHUaXxf0PVWdQ8k
         A38iqD2JrTVjZcm5+XYEXcrPvMzkygD+G5ZS+SFAfSvW1FjVQb+hjbNc/9pSuOaFb
         cHzpws0OcCIewf9mCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MHGCo-1rCUI80wDY-00DIsy; Sat, 04 Nov 2023 16:56:12 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] hwmon: (dell-smm) Move DMI config handling to module init
Date:   Sat,  4 Nov 2023 16:55:54 +0100
Message-Id: <20231104155559.11842-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104155559.11842-1-W_Armin@gmx.de>
References: <20231104155559.11842-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bz7/ryikIYg2AiEcGrXV/jQkDU/cC7KLoivKsCXJ6hqnvRV/2w3
 0NR3L3BklSJPu/8JVZOshTQqGd+Vza/kzYEfOnkajc9g075SEuI9tE42sEss61cQcHOKHlK
 cFZ7n4onJYnLiK7alWzeTqd819sTqMsH1u8WxYKnzYDfSSfgthx1tyIEkO9EUNrcdo/bVHJ
 /JF14U1UjwyVkl7FrZf3Q==
UI-OutboundReport: notjunk:1;M01:P0:EsyBWgDtB+c=;RxGT5+Hul98rdC8JxPhAeSvizIJ
 vznHvf3ZUWj3lDgqOMEyqjCL7Ez1WIKOX+yJdFFdG7GGhEmV+np2WvYrpdtHDHphz1tTLqoyM
 CbS2pwQld2sC7yUd2hCRFXVH6j68dCLLMpV1rxEmtZ2U0d8y9Nw7ayU4hxNcWaxJgLTNzdOgD
 U3OHRpAaUGITjZ4iLJEu3NFWVezXqM9oR8khrYOaeTIuN1P8v8/tTzWWyjLB7oZx8pam+5+QZ
 Ncx6LsPkHAIcSp3DS0Swu6MAvuJs8Eh/Wybs8ShCPGhrZu1VxdNmFUoxWAqxE5DfMIABHPmFc
 dpQTncbWTwab7NnPTPmZKWR04Nr+eyncEUyUaTh1wKWo5LM8/cUFFBW0WzHm0QuwRxy2xsnYu
 mFM8WI1klfVNhNCTn9DI/+SR4/4B0FnvW+57ftYByD79Sgh8KJ/5QDYZILwTsiN2yGJEaxse1
 Sw2jgtc9sJ/8VKfiwnc3+69Lful/n+6e4cLrt9+Jh4ZXz0e6YEqAT417O3fkJHJDgQ3GiyENV
 +Jl2rDETIFJVYj+qxSxUFW90q93AzTGTfJ/GQecX1s7ksglHfcxx3oQro9DtLXNjqhMx18xi9
 UOt9WYkDfP1WFIyjoS0Kg23bG9xwtU0V7FcPkGBfc3prsDB0SD2YQ0ckUWtA9D35M84mwNtee
 FqogdWFxPXhkvYJYXFIc/Jjp39wYEQ5jOUFmuz6nOSEFb1/wBLM421nGsc7PbPbEFIX/1CPoc
 gtGmpEOhpFNyofDkd8gMz+gZjqRKRN3MnAvjTruG6p1bEqR2Tum6aXSl4rDVgZmY9PCh0/LhP
 fjtqFiRuPNjZI/hr58YMxj+F1wm6niKRJAY9uDZMJCnZpj/pKWtTwMqZ/AToJ5y7LLlo+SGQX
 19FHNWNYa8VU8RhXanSuj+3f6D0oUQI5k1HSTHVESHbpmFxZXBSzP9ZHQTTefOZf0qAJ1MUm7
 2/mdU6/Q/icqKwaC9yeAwqtI4/4=
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

Future SMM calling backends will not be able to probe during
module init, meaning the DMI tables holding config data would
have to drop their __initconst attribute.
Prevent this by moving the config handling to module init.

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

