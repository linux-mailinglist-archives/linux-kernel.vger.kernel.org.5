Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE77E104B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKDP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKDP4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4419D;
        Sat,  4 Nov 2023 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113371; x=1699718171; i=w_armin@gmx.de;
        bh=ifOYwAxjzP5mj81yd22nPAM7GrmUV1QGSVAX6g3Ytlk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=aeNpnhMe7UEn0GC5HmgFu0ZvtJC9ulUuql3yJUbh5sMwt1nB8xDJbt8Dgzpjo2XS
         F9yv4I3+ao486wgJbhXzfDQlUyeBe9ZEFWjgB7caQX9dFrQ9NNEc7xZTClPgUvvy9
         9DusNKxgw7xihZhcP2VkkWyA5lPMbZFy9F/RBitOhUXvPU+GdmGyFsBxAa5m0YOw2
         dTBokE/vV8FXxVzATESGNsQw96hYP6oKGnF4627IGIF94afHdezC+A0/cLYejO1ev
         0hTZhyuuVJTp2Zg5oyzv/EgYj7LC1OIYWqMEcQ3Fd8AtQflZkGRdGy+b+3+ITtYxL
         RcsMw/DeFTyllM6dsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N7QxB-1rVWZr3clR-017mVX; Sat, 04 Nov 2023 16:56:10 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] hwmon: (dell-smm) Move whitelist handling to module init
Date:   Sat,  4 Nov 2023 16:55:53 +0100
Message-Id: <20231104155559.11842-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104155559.11842-1-W_Armin@gmx.de>
References: <20231104155559.11842-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fhnBU4BVWsJWvd3qaltsAgfCTlgrwgdwK7Yf2Rw17jIEaLL7td5
 OSTF97H6a1ahaJjm18ySO8fVix7nGOS2l1Wft3E0nuzjZP3DholsFNnwfHwN8rgFBO0yrJc
 LDBhyHY+dC3nID0wZB3TIHl0+Gvac7UDAYxUWy9Yb1n2AhSvOn3Lo9zd9+dQ4NCgOgnaUq6
 QLBya7NdlB7J+yIquDb4g==
UI-OutboundReport: notjunk:1;M01:P0:+GB79O5BKMA=;eht47skEnIL3mo9I9LYAA0vmFtU
 4MqDLnLLRPsu4ogYQUR4zTagHWlnwmUTRscC8HoFLXOMP4WITHZEmVR6YuzKOndVFB6vD/Scv
 HZqhIyVXU8f6zQ/uAVc5LwsNqm8iR/yJqq7URzmSg4wPTYDEGgMP4zvHpv1v3vcHZD4hhpnQW
 y3iIb1jH+IZYHlC19QYGajvO5TFdluEFQKFRQaX8n9uehw7aPuw7YXH5HtvQg4vtq6oZi2/tl
 IYHLmyIe1RdK97uc5OmlD4uJoCOWJ1JBWKxSRjSqObZwYHUUz047hOqFotEK8sV+vcKz4d+VA
 m6XKfQU/sWfJj1xqnIy+OfJ21Q9EanDaKSkViVclmHLllrmP7yRDCOwIpUouG7aqkbwJqvZKs
 bf17x9E8ZlhjIbjV5a+LdekVw7uJOUZzuEUeCfJHOCSp1j6DyVTwtnCl0AX23qW/Lya58yOwi
 4ApeuV+rVBk47ZjzyOJEnKwKFeCeT63x3PdiDp4BP+VV05Agf2cAmpsv5KLgxAkY9419sVHSz
 9BjUq1g9DqL8EGaKAWgIz72l/tsAWkJIAARDCLJC5O+jZIQ8AyX6DmZF6H3YWVH+Zsqlpz5RH
 HgKupE+2CmZ30o4uFeQ0OhAv/aknjzhpXMi7sZhcDPU0R3hzrv95WUTAHMWVrUVOHAaUC/a9p
 McjNC0fy4Jf6TcsWKPSfUoN7Bq6hfNdpDwE59icfdoSxyq6jUJmltvJK6uy9aSVKloCGDKOvC
 l1DFgul4pLgUFvVKRyIEe54DD8AU43z8IeQtNvsKoKk7CboOxosLjy987UIh6KszAGKTjxsVJ
 2n/JRpnkkXgHKkkrpeusXmM/Zau6DGFWsf+anULWklmfyTcJ6cvz/eDVsJ96vs17WoFNLmLhs
 p10TTEyMYO9EYafllwQwFCFtcLvh1hvUD7jk/rLSJnN3DWUr5RgiX09nn/7nvRjpzyLtmYKIc
 VTOB/IpVh2FclSx+Nq0yKOkcvnU=
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
module init, meaning the DMI tables used for whitelisting
features would have to drop their __initconst attribute.
Prevent this by moving the whitelist handling to module init.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index ccb3fcff4f60..3a792faf2369 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -90,8 +90,6 @@ struct dell_smm_data {
 	uint i8k_fan_mult;
 	uint i8k_pwm_mult;
 	uint i8k_fan_max;
-	unsigned int manual_fan;
-	unsigned int auto_fan;
 	int temp_type[DELL_SMM_NO_TEMP];
 	bool fan[DELL_SMM_NO_FANS];
 	int fan_type[DELL_SMM_NO_FANS];
@@ -138,6 +136,8 @@ MODULE_PARM_DESC(fan_max, "Maximum configurable fan sp=
eed (default: autodetect)"

 static bool disallow_fan_type_call, disallow_fan_support;

+static unsigned int manual_fan, auto_fan;
+
 static const char * const temp_labels[] =3D {
 	"CPU",
 	"GPU",
@@ -329,7 +329,7 @@ static int i8k_enable_fan_auto_mode(const struct dell_=
smm_data *data, bool enabl
 	if (disallow_fan_support)
 		return -EINVAL;

-	regs.eax =3D enable ? data->auto_fan : data->manual_fan;
+	regs.eax =3D enable ? auto_fan : manual_fan;
 	return dell_smm_call(data->ops, &regs);
 }

@@ -741,7 +741,7 @@ static umode_t dell_smm_is_visible(const void *drvdata=
, enum hwmon_sensor_types

 			break;
 		case hwmon_pwm_enable:
-			if (data->auto_fan)
+			if (auto_fan)
 				/*
 				 * There is no command for retrieve the current status
 				 * from BIOS, and userspace/firmware itself can change
@@ -1370,7 +1370,7 @@ static const struct dmi_system_id i8k_whitelist_fan_=
control[] __initconst =3D {
 static int __init dell_smm_probe(struct platform_device *pdev)
 {
 	struct dell_smm_data *data;
-	const struct dmi_system_id *id, *fan_control;
+	const struct dmi_system_id *id;
 	int ret;

 	data =3D devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERN=
EL);
@@ -1406,15 +1406,6 @@ static int __init dell_smm_probe(struct platform_de=
vice *pdev)
 	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;
 	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);

-	fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
-	if (fan_control && fan_control->driver_data) {
-		const struct i8k_fan_control_data *control =3D fan_control->driver_data=
;
-
-		data->manual_fan =3D control->manual_fan;
-		data->auto_fan =3D control->auto_fan;
-		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan=
 control\n");
-	}
-
 	ret =3D dell_smm_init_hwmon(&pdev->dev);
 	if (ret)
 		return ret;
@@ -1437,6 +1428,9 @@ static struct platform_device *dell_smm_device;
  */
 static void __init dell_smm_init_dmi(void)
 {
+	struct i8k_fan_control_data *control;
+	const struct dmi_system_id *id;
+
 	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
 		if (!force) {
 			pr_notice("Disabling fan support due to BIOS bugs\n");
@@ -1454,6 +1448,15 @@ static void __init dell_smm_init_dmi(void)
 			pr_warn("Enabling fan type call despite BIOS bugs\n");
 		}
 	}
+
+	id =3D dmi_first_match(i8k_whitelist_fan_control);
+	if (id && id->driver_data) {
+		control =3D id->driver_data;
+		manual_fan =3D control->manual_fan;
+		auto_fan =3D control->auto_fan;
+
+		pr_info("Enabling support for setting automatic/manual fan control\n");
+	}
 }

 static int __init i8k_init(void)
=2D-
2.39.2

