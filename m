Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602477E102E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjKDP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjKDP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDBDD48;
        Sat,  4 Nov 2023 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113368; x=1699718168; i=w_armin@gmx.de;
        bh=wR4353YnrKhD4Of+t0tLDfA0Ba3QrBQXXpZeY1nQ7TI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Xt9qGUNKYxtQruWat4nuciRCpXb9Y+RH+ogtAxaThSybCFxONRz8HgG5wUakpWgy
         QsNND2N+CM8VSBFFs8BYeGcrHUodyL9ij84zV3P2bUUHeKzNZK/9/Jvr7gGUCBtW7
         7fRo7o5QNZ0pJkfdRmWBo9/FrZxHrT8O30n10qFSmmt37IdKuxyhTIjWs1Bp+Obwq
         73BPuStEhFy44/jL566pw32zgCxrvFATMR0DG+pVNxR3NhYQ8eBjvy1QXy/vM2ePx
         P3pCuKSnX/fmTpBpM00mEIWTOZ9cqBCNQwnYC3DnC8hs3uhWwfbphVlu4MjpzfcjH
         YJ+hLCkRDjKXVYWDdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M2wGs-1r0Ovz3QiK-003QMM; Sat, 04 Nov 2023 16:56:07 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] hwmon: (dell-smm) Move blacklist handling to module init
Date:   Sat,  4 Nov 2023 16:55:52 +0100
Message-Id: <20231104155559.11842-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104155559.11842-1-W_Armin@gmx.de>
References: <20231104155559.11842-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hupyRLrGZtrbi4TPfjd+dtUKNv2xlwdnm7ix9rCqT0nN13OM5Im
 BtxhDipc/93Ly0KSZbeNZNRLzOERtzgeLBoCNc17rFKZog2hHQ9rTQ6zcNWxIOR316+9Syo
 EX3Fs1MnJ0FfBZTgcTgMFBFvExIRg12NnBxL7mGaag8+skj+TTBp7W04gA0yAHkjGXMUOQ0
 jex66Kr7Fvmpo0BF17VWA==
UI-OutboundReport: notjunk:1;M01:P0:LjtWrzpUyhg=;rlwpm0mFvdUe5sZ/W++GaUodZ2B
 RDmwMuyn9iMIIcQ2Fe+RrhAAFeHeTtVU5gHpEeYMqx98mdlwtF16tP+r99B2lhr0+rzatDPdO
 yDO1eAl296BEpzBPWkRvxxfBBViUbFJAEXIETzLexs3bCJ4TmYhEmdXI+AmaQWQZk77pIwR83
 YDkRoT7GGpP+SHxRwqMovEN1uy5GkNNtMjwLBJyBqDzHhapXoYctW3TmVojLq7SQm+yJUBYBw
 P5NOn2R9KYLIEa9Y3TxhF7HLXPZ5NRQj2H/blVDo44x9h8+KJvyQxKpQT3nQ11tenPj8y6QXH
 rVORM6/fRpP3CtPtE6Cv3EOf6BWZemlzdcdIIajOgHLziLkaMovf8qS7jRyi5roBXae8QyRuH
 cJIGOSWGm+HTGjLrL1LYX8IWr5qnH6paUuMFmv4FTO6Tlh6vEal1N40OSE5vuSklVtAyMj+DL
 SjL5NkVeMimJ93rELhkjsg3IY4EdMPLo2JXZnMGGEOlY4fCJMkM6KUahVnEjtXGfZhubZYNBS
 ELndHRoUNcag2/6eomraNbAozcF4EzxCQhM1n/dDRUx3BfV2krbgi33+aNQaphazXmRpegwV6
 8XomA/sYQzEeDLyBSoSr7OnBzFLlN63b/dbLS5pE8xgebqIWfWm8n8XG0DEcfJuu2VOW5nMQo
 gi+AR8ry7Lt2uTtzGSaXGzLXA1B3WIJVV1jBrRm8PFyAvLPzaeV9W6NX7nkcNv9cIL5OL9ZdA
 D1VeWP7E/6/E+RdZ6hoK30keROFAaejXf31v56d3yqTxf+MPx0HAPwXKvzB+6tpCMCmHQM3rb
 ezYS8EwJORwz/L/skL/xkwicHh4qF2A7FNaxpvItcWIUMQFWTHWJFoxmYRjXpVD+2OSVsfcfv
 BRrCjTqJeqOWj761G6qIEld8EY2hLxyhjkm384Y0d2IKFQVpeDW0ZOldBAIqrGyPQ0rnuijkt
 6XlR3pCdnTH+WTSu1fI5ovwK0Sw=
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

Future SMM calling backends will not be able to probe during
module init, meaning the DMI tables used for backlisting broken
features would have to drop their __initconst attribute.
Prevent this by moving the blacklist handling to module init.

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

