Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631707E1A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjKFGof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjKFGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:44:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A010B;
        Sun,  5 Nov 2023 22:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699253040; x=1699857840; i=w_armin@gmx.de;
        bh=Qq9RFdXKmIkJl7Ufko8TNWgUSGPjbcQWTneMlaRC8iY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=ieHaatVt3nTxVzOjEi9b90lstmXCLzANYiNH/8Se7slIus2/yLiWHcikE2KJ7RC5
         Gwc4BHJwlZM3oZBZwr+LQnhCvId3zjIeuMC9gGLx78GxMgPmlhi/HcsQDwdqZ+Phg
         WbIZ9Pr7Uu4ddDB2BFBQylQaE4GHOXE+78bU+3T9gH6FXGNmPIA+mp1q+NBmxSWTu
         Qtsj42J9P9nBFL+9ef9+zHXqtNO+0vX9olx49byHk3ZT0blC2OiH4LarL03GywQAj
         RUeSwJuIRJcMT+xrlfwH+CZMBtjZ4UaNIkb/qamFUGQhLgk6H6FF5ENojEtC2cuVi
         3jpKz4EsTN1Pjn5vNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MowGU-1rle9831SA-00qPot; Mon, 06 Nov 2023 07:44:00 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] hwmon: (dell-smm) Move whitelist handling to module init
Date:   Mon,  6 Nov 2023 07:43:45 +0100
Message-Id: <20231106064351.42347-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106064351.42347-1-W_Armin@gmx.de>
References: <20231106064351.42347-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:931Nb3W7+lYHyL4mnGdtdqNKOFJKCygHBFYH77yx0F+881lzBUu
 YbGvr6FZ269SMT6PS4uQpsH0MRYPPIEYyeRuAGUt+IdDHT0IsUKQrWsK9suB8mZyV8g8fky
 iOOeW0F3zCe1mZ7+6TckXG8r1ucYndj6CPvl6vGN88O9Hh4eTmVYv2i/t2OMX3el7PpbnK9
 jI32B8pYjFOrxokGzZm+g==
UI-OutboundReport: notjunk:1;M01:P0:+nNZPN/tGUs=;tcrO94bMQB6vXZErdlGLjJJpTh7
 yoRLjKWRQoa/HzF5NkPyOTGqeXbhUGkPuewxYuBe7RxrvzFrVwT4oYjS/z1661qqJBOOTXEGy
 n3L1RFPAYhkyT8njMwFHPp1D4ZkeFTm3DDxMQRsoh1Sau/p9pNHDlo61pE3X9JHTgsalIwUWj
 1DnKHKeXOLcAd4Ta7CK+dGRKUvea6XOh9lfjbA5N7idU4zQ07YhyKCAOMbu+RAnQFVa0D6/lV
 ohE4ybZtXJuAflvztcgrk2E+b/DrSgS+MK0QD6hc8q98JhNYMlzB0fjGhHgxQeCzcmibplp5X
 apOaPXdJk5arMfm/xFu20vAwiYVI8VEURJAPlWfp4RdZ5bvLAluMjF/0sZA08BsENQQHBvDQ4
 Ly566cTKA6Lh5Ir+KkFDMWGEo6YKnRSBuVnQqixq/7moVe/C6WbjmVxZm3NHN9VphFz7Nu13T
 t4z17xoe73e1Dw83bGKMDJ6JMHW3RZ//hvxSdyg/6mlzWTxvcLfSWuuvLe+0hTjG3UxULxQXb
 64RkN/9DM/47MvL8XZUgAirJdsWBTxUWcDtRarHbCE31hvOHJ/fFrAE1HkHOHrwSJ7c54XFV3
 r0S2yyo8K8QyVyPuzdZ4y0mgT3BrEjZr5ncHKFKEtLecMCHamj2srAgaB2IEu0w3hyiKWkHzJ
 0U0x41HoEIVc1RD1a7DRBI9WK/ZESH+AecdoXuEQCdiV397RquJKkZqNB7bXW47I7q09CHgef
 lqeo5En5Vq0ojHVEyEmUltFYrZ2eepp8ukwUui+7hceFU3Wb1l8S51fBvUvW78dRQOwSkyzKD
 X3WtYQMrcQdkyLYvZAAm8CIjipZjEwsiDpYXCrF6+p0xaOtuFQCQE2GIogf2uetZryLwlZxAh
 rAHpiCgf78hQP4p5Y/6Xz4qjzKFW8sz+sk2lTA+nxZZ8n960rghTj6/jb9zpyjmhXhG7fFTEW
 xr+0/uvT60JsJmc2pHP8h9D9hQ8=
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
module init, meaning the DMI tables used for whitelisting
features would have to drop their __initconst attribute.
Prevent this by moving the whitelist handling to module init.

Tested-by: <serverror@serverror.com>
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

