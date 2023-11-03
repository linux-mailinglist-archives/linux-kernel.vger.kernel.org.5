Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E37E0892
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbjKCS6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjKCS55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:57:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D610D47;
        Fri,  3 Nov 2023 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699037850; x=1699642650; i=w_armin@gmx.de;
        bh=Qq9RFdXKmIkJl7Ufko8TNWgUSGPjbcQWTneMlaRC8iY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=j/CppXQ/ooPrH/y2uvRUIaoO1McUJQbj/kY2VzgKuTCCT5j67+B8a11Hw2ogqnn/
         4CETbf1KFnUDIYN3ofR3DSlCpzHjWGZgFEgO1msKJKsSoc1vUftCgjaJP6g3AaMx2
         oZW4G0GteGkuUbRmuUYB6ehV2D42ZL0EQKDOggwrvr7YDfheZMyM4aMW8QTBO+u1W
         Quk2iA1TiopyFvAnN1K4R2jmCO1mAzsRDIi96M0SD2KGVaDl6Xl77L0hzwJgWarVS
         cbDAjkC7w3GRF/QH/STfJYl1UNEs5TKCe/N8nzAMzkTGdfoWPZUUpr5BXzhdRw8OI
         OYNT5PpE5Z5DxRTbjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MS3il-1qsdaj139v-00TWPx; Fri, 03 Nov 2023 19:57:30 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] hwmon: (dell-smm) Move whitelist handling to module init
Date:   Fri,  3 Nov 2023 19:57:10 +0100
Message-Id: <20231103185716.11007-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103185716.11007-1-W_Armin@gmx.de>
References: <20231103185716.11007-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e1ppz+omkVQh7JmnrDz7v6mVci77jWJQ5GkEj3dIHj+GT7ZzRSL
 TVOI2rO53XRaYdq/Fjeu2rLeJabEQx0hxHy9iDaQ3QR+VcdfwY3ZcFMmgkxpvAJAaI2fN6j
 xTWxpVeFhqB/VfujZ6P2Wsk5bbFIg6+lhyd2T72kSEpMpGT/5jOfvZvNfmxXHRcuXvR9Hty
 EphYKQPf9dE1NRX4oKJ2A==
UI-OutboundReport: notjunk:1;M01:P0:NQB01dzgUQc=;3ZR2h+jyXa2ZUw+L/CV4Ja1sd3v
 XKReCEH01jrWdXT08AaM1w+sG+jeAPLAnBF+eS2tYeX1HeFb0giuxG/u+ZxwpIt0Vdk0Kl13F
 5uLLRs9dDFP2CYqAT9cpyTgMJa5ayYDe3SZvblKR/6tz5kYGlrKJJ6Q8uzHYhE65OrX27p7IJ
 vCVi/v5CZKt2pW8uuYpPqqor1m6W07O+ueDp5Sb+ZypZSUDXNpJOSve3eIgupw48BT3f7M+sw
 tuwxQAtPgnzpdsFdpT2Z3YpvzeIn4nHtKGMfogf8+1e8GUdJO3szHg00+IDLclvUZWYM4x6az
 lWdypfHUcyZ9MVMmT9B7BlGfyMN0Yiq2hc6yxEwtY9bycM4+zjG0sVzviXZTy3z3eeIi+TB9D
 fK+/9G/+/K7Goy4pzxv0w/IlMVAye3AgtyAPPKp241JxHNJABN0TwA7A3mRkwmUkNgI6lHIIH
 O0XpKgQ3z6q7VHaPy3EVp5wzuSAbKA7G4f/zqi7hDr5huZiPxkUt2gVPqQ8ZUEgCCYMS7YJbA
 2OQL7vP0QOau6lJ8boA+6Mnc6VD8KlUapOhxfTIDCEuXVxOpnGmrqDHgVCZsHaUOuUAPNoXIh
 tF3832UFX/+3WuBSbktEoDLcpDlwo4FDRQEGgqUkhwUoNlBM6wf7NIoxE1/fkDNN8zUhsxFJ0
 yOFys1QKwp8p8s/C8DWt1ZFushKHpHktxUWlo/8wgzXfmkfpp8hUMViavGZUNpU6jJPJO8huX
 fqEszT3RpeWCEKELURCtQD4DRNQmo4SCp6YMHV/5+Z59k5WziydDFysoCc/mfamTizCdDsKix
 8hpXqHx19Ph7BXNixEN1Jz3iSOxr6+mKyDlzAnsIF2fdw1MzvOg4ZJoNtR2n2ZAKJu4pKo1rb
 6hx+7E/zjhhp3Hral8ID0RDLXj5yyCKL+VsqFE85J38YS5c9vvlEhm8srzq/haN7Tj8Hshm/O
 2ON84WbNfkbSYf15Fx5LqqEo9Rs=
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

