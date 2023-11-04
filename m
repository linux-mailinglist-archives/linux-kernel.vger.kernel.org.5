Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C767E1047
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjKDP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjKDP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E308D45;
        Sat,  4 Nov 2023 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113373; x=1699718173; i=w_armin@gmx.de;
        bh=IzbgwTlVYWXpH84K69U34Vi9QBqWC1rRdQikBmtjfWI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=RQCLeT0mIJj95hMKQo9y6AcYApsAwSl26bZTcAa0Kr8Wk5xBvgBg6Kjjw/c4biMm
         JneVC1GSTszGPSbFs8WlZuZmywNYEB9wfagCCQYmhxczseM99I19AoEssh2vFTvgA
         +OaLydVkbi8pglt0Wm7J8cVM0NTWjcw9Xy9JBJHwIYCbfaiPJnmfInjSncRSNLyGi
         3H4J36vTPlTdFrLa4BLQZJILa+7DAjk+OLDo18jNgQPWCX5aIqCSLShve033ESU/c
         YlCAHR4CisxDrlbWK3WvXwRK4ye6vf9yIiTx7avHPVNBFdjbWibrd/sjzLu4a9hbS
         +jsCVUFd37q4OMW+3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MFsUv-1rDJEg2Y3D-00HRbW; Sat, 04 Nov 2023 16:56:13 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] hwmon: (dell-smm) Move config entries out of i8k_dmi_table
Date:   Sat,  4 Nov 2023 16:55:55 +0100
Message-Id: <20231104155559.11842-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104155559.11842-1-W_Armin@gmx.de>
References: <20231104155559.11842-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:amrR2pWXKaPGJ6mi0euoHpy5+vKeGrVy9flIlAiglOq8YABd9cY
 LpR3PwROd4+HUF74PRponuHXouoGHHZ6rJoy7jtISRenPojwOIAj7x212VQPa1E3iyIZeDo
 Iy3GMSYgIRZuveduD7LV48Cfiep0VCITDY+LXsnpnRa9oX+a9U9RS2lRh2MBTMysl5Up7j2
 mig9n5pBnAQxH0+/6Ng/g==
UI-OutboundReport: notjunk:1;M01:P0:R7SWzam2xMA=;WdxeEWnWwTqmit3rCCelgHsDHrY
 ONtB9m7cjE4uzI2sdhKPqpdmcDRZZX2HJxS1kSz9JF7BkMyHyuRGCRFHZfvY40ZX/kfO+5Z/i
 G3NQZwN9HvlxgdG58KP0wdMQTUljjbKPCdGimX7A+QDj0ggq9lfmW2J+CJ64ON7po1QJlOJRR
 I9Oz3pPMQGdC23OUouxRX9NgHUCf6F+F9binAoAS1TxP9M9wgSMINuCO3DNmRunlogQuqyQWh
 ynWu/xmf20q0qBcgD7irhi9mnnXDTAAB0WzaAyJgwkm0JCtlzwWUI3U3lW9ZSceJWoSGg+4HY
 D9Q0udtnCqyMlc44GJvA55oOeURC50Mvsl7v9aOKeuoxbLEq31Py/cD4QP6rW2y7gCjk9xTj8
 We4QucMrBasn+UCajnH9KKmFsH/LL/12of4EM3mjzwZhGDd6sZo84/C8Eoe3ai44aJfGQeGs2
 JcLcWONKAyAS+t02EU4Y4a93wM+ZZsWXHAIOUQKlwDXTAMcxBwb361HePfeVUshOdyJw0+PAn
 5CjJeGUvxmQttsBp0c3uDTsLkYRs/gELOK6gmHnZ9YFkdtkfbBNWyff5r7F6zMLdu/IpAUemR
 i1rRQRBtvOZdD/JvYQq+NYuoe7fVhmk2Syojl5ylypkiapggg0cndO4vGiwWHlnIdctb8Us4m
 3Rm1T7lO3zv7+McJFeSTYmOJ49bw1QHkSkACTG/70gU1eeNIWTC4oWfUSIgse9sh6XxSs5swX
 rZvE4wA94891EnsLXUKjgxdiuvgoCzY86zHBYgjXAXrdrTEDqoeGZV5I9eI2vXL27ojOncZ6D
 WLbIHpfZ6ZSD1VILlH12sm883GMGgqdqQZ+PlnOztjM9gJMRGG4fnNcjm5OkbTnZYlf+eDTfr
 DyozPjckgqf/X52TQZ/NWhKz68tIUWwlbLyRO07WxQrRiqPgU6zoIpd/sL63tBguFpnmg3+mH
 YG6NDi34b1D1fRHUAnD7wGtIV1A=
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

Currently, i8k_dmi_table contains both entries used for DMI
matching and entries used to override config options. This
does not allow for differentiating between "its safe to issue
raw SMM calls on this machine" and "its not safe to issue raw
SMM calls on this machine, but here are some config values".

Since future SMM backends will need to differentiate between
those two cases, move those config entries into a separate
table. i8k_dmi_table now serves as a general "its safe to issue
raw SMM calls" table.

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

