Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2614D7E1A63
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjKFGoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFGo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:44:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17476100;
        Sun,  5 Nov 2023 22:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699253043; x=1699857843; i=w_armin@gmx.de;
        bh=OhijzaFOCs/gLtWXwbD2ow5r3VEm8U+868KlplYcQ9k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=CbpM3GxVcX3u7aXFmR8eUpyiGl+bOziGpNdRnsCqEeUZianZG0QcdgEvlXQv3QoW
         ifQLBtPUfaqJD0J0eTAoh/10HyobiwUCShTZF0gMQkILmbF9vCXolyGS+82VOQkzu
         ygug1mjMiCz3mvf81Yhp/XSBdobFkJKDVOfU00fSAdtFOQIbeEg4p4JcWmrXujtMb
         fhpupyaIdDrzLt3s+StFfylfkSv1L9U0xknX1RH3bQK1GhriMAynTzYE8qyYgnlDC
         uJJmWBP4osdLbxfCGNmlz17ZhxRieBFYFE1l9SW3z9oxDH4oSGMlj4uPbGNR48T0K
         frhoSvDk8RgOVGwQ/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MFKGZ-1rBCvq1OOH-00FmxN; Mon, 06 Nov 2023 07:44:03 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] hwmon: (dell-smm) Move config entries out of i8k_dmi_table
Date:   Mon,  6 Nov 2023 07:43:47 +0100
Message-Id: <20231106064351.42347-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106064351.42347-1-W_Armin@gmx.de>
References: <20231106064351.42347-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gdmVdfJi8uuewITbBaXijTVv85AB/+HxHI9FAZ62DAc1MGYQHUp
 5mJs9cCVk9tEUQr5cjM3Q5mBn4AsF8lNTT4cadZPRv34SSm117Jo82/JvT0pP/NPlqKXULe
 5N7niZaRzjQ+BO0NZyEtG+Zo1VJcNtUD1EqxA6qQWQUuIAMO7lR9nH/SoV2TArwUp07Yba1
 fWsUPn4zqbZyLQVLcuEZQ==
UI-OutboundReport: notjunk:1;M01:P0:bPMIlq86rjw=;vZMpUn/Uw4fh0dHqHuTvMLp1Q+i
 F06S9hocwEtnxnw8VTthfnOqc54tJDy/norpRegOy6xjM6+9WVDeo6OljMUC1MRKJgXOM+8XJ
 0lALn2KrOq3Kb+Y62PJfu+kptUfQQMYImdJOfnqTkOvHprdycyRglCYhmKtN4ZYJNYsUhtupD
 0FE1Ci6+O7APU02jB1XoTZh5kjzVGp139EvubLe43lvUiJF0ftwkMH2LxnfTWmedRTmC7zSFl
 X2U42xhzhSUxXdEiA/MJG+sEXQbshE0NBFepBf9BtU7Wj1fnnJVm4JsNn0vn+TQf0I9XyeJ78
 7WZM56x9G2zyhFZqHFx4lJgHfDkmajie1bx6Yik26O/eC3NDM6N8WSrHPfltXyzQLiYImws3b
 hBVk+lx0SnHtAT887YPUkbCe6bdp8bGRgEogHp6eGoKDPEFDLQ21BfbkEecI99jUJEOb21yIh
 wGDfpMocKXlc701JrdR8Ps1EHSLdYXg6M356RtwPP1OaH4cw0laXjA0RJY6lmXua4eSEDYWSZ
 8KrguqNx1POW6/r1ShNIyLvV1RaZjYEehIN1Zhnat8sJiikJVXI++goTO50hxqBJKamHINpPS
 pvRLoyH35hRGARq6HstnTI1Vi9gpg7BJLjwaEvGpY6E4AI9bzC7MVlYBKnr6QIjaCvqOPl6cD
 sRP1b1tIguKgrzl4Yd197C+gs/TpCKrckRD4temvVeylZE6QhZN9ZLYWw+SDT8c17ZdFJQfdR
 kUZHeyfIh/OruJ2v37HGC8p16e5secihEreoCWDq2146nkop8A7ENgrjd+xirn3Nw1P3B/W69
 0A+mDoQ5Js9lodpe8h9QcyA8ywbdxZ64xQxMm6Vqq2vy7vDxDIcVpHFGcHr0lQ1lp9pvwQaKO
 EvVaYqsFi+jYd3kpA0xO2c6Ktk/5is7HI03iFtxikUlFWEpagcLr8mDY+vVWl9XYXgEj3Cbet
 wGPnJ+Rr6V8GViSRw4Nbh7vvnFY=
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

Currently, i8k_dmi_table contains both entries used for DMI
matching and entries used to override config options. This
does not allow for differentiating between "its safe to issue
raw SMM calls on this machine" and "its not safe to issue raw
SMM calls on this machine, but here are some config values".

Since future SMM backends will need to differentiate between
those two cases, move those config entries into a separate
table. i8k_dmi_table now serves as a general "its safe to issue
raw SMM calls" table.

Tested-by: <serverror@serverror.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 129 +++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 56 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 3d14a3baf8e4..4a2c0d1ffa5b 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1078,42 +1078,6 @@ static int __init dell_smm_init_hwmon(struct device=
 *dev)
 	return PTR_ERR_OR_ZERO(dell_smm_hwmon_dev);
 }

-struct i8k_config_data {
-	uint fan_mult;
-	uint fan_max;
-};
-
-enum i8k_configs {
-	DELL_LATITUDE_D520,
-	DELL_PRECISION_490,
-	DELL_STUDIO,
-	DELL_XPS,
-};
-
-/*
- * Only use for machines which need some special configuration
- * in order to work correctly (e.g. if autoconfig fails on this machines)=
.
- */
-
-static const struct i8k_config_data i8k_config_data[] __initconst =3D {
-	[DELL_LATITUDE_D520] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_TURBO,
-	},
-	[DELL_PRECISION_490] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_TURBO,
-	},
-	[DELL_STUDIO] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_HIGH,
-	},
-	[DELL_XPS] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_HIGH,
-	},
-};
-
 static const struct dmi_system_id i8k_dmi_table[] __initconst =3D {
 	{
 		.ident =3D "Dell G5 5590",
@@ -1143,14 +1107,6 @@ static const struct dmi_system_id i8k_dmi_table[] _=
_initconst =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
 		},
 	},
-	{
-		.ident =3D "Dell Latitude D520",
-		.matches =3D {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D520"),
-		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_LATITUDE_D520],
-	},
 	{
 		.ident =3D "Dell Latitude 2",
 		.matches =3D {
@@ -1172,15 +1128,6 @@ static const struct dmi_system_id i8k_dmi_table[] _=
_initconst =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MP061"),
 		},
 	},
-	{
-		.ident =3D "Dell Precision 490",
-		.matches =3D {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME,
-				  "Precision WorkStation 490"),
-		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_PRECISION_490],
-	},
 	{
 		.ident =3D "Dell Precision",
 		.matches =3D {
@@ -1201,7 +1148,6 @@ static const struct dmi_system_id i8k_dmi_table[] __=
initconst =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Studio"),
 		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_STUDIO],
 	},
 	{
 		.ident =3D "Dell XPS M140",
@@ -1209,7 +1155,6 @@ static const struct dmi_system_id i8k_dmi_table[] __=
initconst =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "MXC051"),
 		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_XPS],
 	},
 	{
 		.ident =3D "Dell XPS",
@@ -1223,6 +1168,78 @@ static const struct dmi_system_id i8k_dmi_table[] _=
_initconst =3D {

 MODULE_DEVICE_TABLE(dmi, i8k_dmi_table);

+/*
+ * Only use for machines which need some special configuration
+ * in order to work correctly (e.g. if autoconfig fails on this machines)=
.
+ */
+struct i8k_config_data {
+	uint fan_mult;
+	uint fan_max;
+};
+
+enum i8k_configs {
+	DELL_LATITUDE_D520,
+	DELL_PRECISION_490,
+	DELL_STUDIO,
+	DELL_XPS,
+};
+
+static const struct i8k_config_data i8k_config_data[] __initconst =3D {
+	[DELL_LATITUDE_D520] =3D {
+		.fan_mult =3D 1,
+		.fan_max =3D I8K_FAN_TURBO,
+	},
+	[DELL_PRECISION_490] =3D {
+		.fan_mult =3D 1,
+		.fan_max =3D I8K_FAN_TURBO,
+	},
+	[DELL_STUDIO] =3D {
+		.fan_mult =3D 1,
+		.fan_max =3D I8K_FAN_HIGH,
+	},
+	[DELL_XPS] =3D {
+		.fan_mult =3D 1,
+		.fan_max =3D I8K_FAN_HIGH,
+	},
+};
+
+static const struct dmi_system_id i8k_config_dmi_table[] __initconst =3D =
{
+	{
+		.ident =3D "Dell Latitude D520",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D520"),
+		},
+		.driver_data =3D (void *)&i8k_config_data[DELL_LATITUDE_D520],
+	},
+	{
+		.ident =3D "Dell Precision 490",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME,
+				  "Precision WorkStation 490"),
+		},
+		.driver_data =3D (void *)&i8k_config_data[DELL_PRECISION_490],
+	},
+	{
+		.ident =3D "Dell Studio",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Studio"),
+		},
+		.driver_data =3D (void *)&i8k_config_data[DELL_STUDIO],
+	},
+	{
+		.ident =3D "Dell XPS M140",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MXC051"),
+		},
+		.driver_data =3D (void *)&i8k_config_data[DELL_XPS],
+	},
+	{ }
+};
+
 /*
  * On some machines once I8K_SMM_GET_FAN_TYPE is issued then CPU fan spee=
d
  * randomly going up and down due to bug in Dell SMM or BIOS. Here is bla=
cklist
@@ -1438,7 +1455,7 @@ static void __init dell_smm_init_dmi(void)
 	 * Set fan multiplier and maximal fan speed from DMI config.
 	 * Values specified in module parameters override values from DMI.
 	 */
-	id =3D dmi_first_match(i8k_dmi_table);
+	id =3D dmi_first_match(i8k_config_dmi_table);
 	if (id && id->driver_data) {
 		config =3D id->driver_data;
 		if (!fan_mult && config->fan_mult)
=2D-
2.39.2

