Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC77F5597
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjKWAtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjKWAtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:49:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BBAD49;
        Wed, 22 Nov 2023 16:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700524; x=1701305324; i=w_armin@gmx.de;
        bh=KqV/DIBXCzRSkmf9e2rBEm8mBLLViY5v9BapnVCJN2w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=HufgPuPvQ+OH+9wKX/1SNgVsXkXWzfakRC05woxXYG85ERO1kos68e59qq9ukMK6
         6uqHjAmMfqGnfFdyetXBtTjxiRvniLG9IMcaT13XutDKIcOVGOzjkYz5khilGkv7c
         xY+OsOAgXTbK0fhxaj4xBY3CH5bn/57osys446iAI2MYK56r6Jk+ntU916v8h0mQW
         +oJezp+nvfP51VWzN6YZ2Qf2Wq9sW99Gpr6xNn9beyIW4qIXTTiPJ7ekj8Nn6DksK
         jagSHAC8Ppm/OA7jNaGFI3Uti1JiDq6EUWByC+0uuuBk5HTsXd6VeKdEC4bLaC0Qk
         FST1Z/bt/eiMYXlQ8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MHoN2-1r8hiM0cAo-00Euxp; Thu, 23 Nov 2023 01:48:44 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/9] hwmon: (dell-smm) Move config entries out of i8k_dmi_table
Date:   Thu, 23 Nov 2023 01:48:16 +0100
Message-Id: <20231123004820.50635-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vaaVo1hflMoDX+hdoZg64NO9l9Ixs2VdyVbtRA4JehMwp8kbgo1
 fnNzscXx26CWqDAnG8zXjXnENG20pTa+/YkrsTBhLMI3g0iZ9pDM7kArxLeiHMGoOPcg+43
 EpAV739mPt2XZqWXcmA8zfnlkkQDeJkokPrrrwV9jNznStdLKxD8DvW7yNmqmHLX1mXR/1S
 Q1dk7u7WWjZKWLWP4PR+Q==
UI-OutboundReport: notjunk:1;M01:P0:cXgHUFJvHjg=;ssyJA5TsbMaYyg5RejCI3ITcZKz
 Q9jWMG67xGcfirRcSo6WvCA84powdaT15cEiOeB8rGidrGhHe4xQ5wOHaF+LprdGLNh8K8Cog
 rtjMQ1WnFxCD46P6MzjPB1TKL7nz0JkIz4YxR+J6TX+mTKh82V1CXRQZBj9NJxUrzG9eWqEjZ
 dBoEl4SO2a41knTVZrTpP4UHyE5PP1ky9fTnNuPRIDB3eWXfwY8eeKfPFxHfrn4Piu1uFo50Z
 cxTAu0BavUhRZZh3JoXZ8+gXrNw2i/XaE5KfYWTPR29lVTmtTnbZvDE+EcBEUOmX1VS784Qg+
 TTdqUiRLWJcZriQNj0cjW75RmHrpOzBhYZ0XwM6p4jZQ0GjqeGf1NCoYapC/eITQWB+8lunJI
 NCOAXX+gynSQrPFvXwxpc/14H0znOloSJE2/ajmjlQAHNaKqsJw4fN2Pnlh2UZdA2PF5cpl1v
 m4lzffugouNOr6V8MMhEh/4aE3fVX8U6rHtaIZgG+t8EOrVP3f5kMXUTQVqwD7oWLawUibvzT
 Qv/vKKZyP9QRieeoMUAUpyAeBnApOrkEZsF+imHRIApLAadyzeH+WYIbNx/+dao/F07SBSHsC
 GG+lbgrHyRF/H19I2i9d13RTHCCU0JgJKPJIBK1L/v/hCb4nGu5W/UnGk70q3iTHRt8CbuKA3
 +Ev4nPz3ASEhko8V6PBIJYzT5SdooYewhy5FcPAbPF/V1cTxaQKjKLCKv5XkPA41FWjB/EgmW
 w806ooAydhAjlieYim2Q4Q1QiQ66CpityLi+tNMvULqYg4yEE7wTwtH/NKN9/wPgaQP8BkT8o
 lqyGneX5drq0RbDBxMhovy/qLkJzZlK4MCg8Rv1ldr/bTow8brXLEYNOdCRsFcZtA38IBaJ8h
 EeSpGtC4PjQQ3lzz1jaW1A2ahvCAzcZysHSX4FnX6tf8VZfCKRpWgaickbtrw97b4uRn1llNM
 iOyZgb61Vxmg00D4W6kloSffx4U=
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 129 +++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 56 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 158b366b0329..b60755070d86 100644
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

