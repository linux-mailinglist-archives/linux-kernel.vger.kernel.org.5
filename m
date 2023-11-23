Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43997F5596
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjKWAtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjKWAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:49:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2841B6;
        Wed, 22 Nov 2023 16:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700521; x=1701305321; i=w_armin@gmx.de;
        bh=V0YTO8SuhbXFllpMUpGLmImayJAGwiYZye/V9QjFzzU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=BTUdNJ0libzzPYhGTGfyiPHCmP13YSDytd77NrQDdazgGSvV8dum3u9GHlCAxEAi
         AwWKCSQjiwlMEGDSTnq/9ABTstng3jePMAxIC+owDRkON4C5vhEa7qbAsVGzqiiuw
         j2caZDqKu7+pZumE2d9HhscMryujg7GZscxOv950U3pn3U62DCT17XbFYQWmkJgmz
         NPPD/bpxtUCkqJL5flv94aiBtuB64G4GCCeKqZV/508Ff3LYYj2oGl71sOZ9/D88I
         pqZyPkRgM6NMVifMu/ZzIcL5q4tIptQicmhAFq/nsVUbFHtfVFR/G3U9fSYk7pM0M
         p+4qhji6nwODZwLtxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M26rD-1r43161wPR-002YQT; Thu, 23 Nov 2023 01:48:41 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/9] hwmon: (dell-smm) Move whitelist handling to module init
Date:   Thu, 23 Nov 2023 01:48:14 +0100
Message-Id: <20231123004820.50635-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sLZEVJEQ6YFGZknxrKfmcCR3R5oC/Vc18dLepzqElrW6tyI+9ns
 6CoEKi1sItTiElnJddM9X3sZod+NwulAcAI2pMGcDeU/dnN17T2DSPjWB2Kl7xLr5Uxlx5f
 7mFv72IPYkWe3LjaK35hwwmDzkWN8KBplTZLC9leOc+APSr4MacrF4meHrSYJc5DdjJx8B+
 8lE5EV7d37BoYkWA6YuoQ==
UI-OutboundReport: notjunk:1;M01:P0:aD226kWhsiE=;dizW7S46DR9LjAKbC0E6GAHaNw0
 IdZ2Rf0Qw6fn0LZL7kTyBz6FttjBc1Vb+4S8s8m2ZFc2vlABF76Zqb9a9SglVKFbaD6tP5F1U
 cjf4LDzq0pWeMMLHfFgaHNy8RNYMUqVO9t/woI0EUCH88LiqTsA3UZWbsyEgbP6mR9bYIZY2l
 VU1QqnHpLgmhNYnfp+hy6YdZx1cnGclCP3cJgz97rUXsKLogsHAJx3qZkvoMaRMXw98f8gpA7
 hp5IPP2/YKPjRRL0OJp7QyZUr/KYJgjeXZd9GH3U+NqXEA5hlhwsvme/YNoWZhTgDCSBNXEFm
 EUpQxoYTxvipypauKG5ikHU16FqXbSHSiJwe3w6mXA8Vhtf8u8yt1+3SCE8ZyDnQGU52SMQ2G
 9Ib/G3ha9U+tXao4aGUjijiFgD83lGCaA5X8rS0MsbmzEAKW+n2h+okIYary50kg4oVBfvUCj
 1lPRCUSUUhWoxdwJgjQrvHfSrwFyYwWwvcFbPhkF/7UvEbfcIh1XkPF9YG89rmW4Xo1dUCtBo
 DY4WoAHNj2HySv8WeoTfj0t0fRy6nb9OXQNw51bEehjGbXkuuImHmpP1CME5ldkSL2y/kU+5j
 a7fI+NEgHSgEdtKYXkSLzMn5R2rnoFgGxIibpVqP7I+FNdJl5+/y4wYy3paRTH9sWpeaVEdF1
 wx/UZszwWMzJGMncr7IcxnW5Y7y8Ma2yNnmy5pbupUPuAjmO6ffg97f1zh0yvghQu+49KafQy
 qAVlJhP/0HP5s7Kq61shy+BSp6+aWI+QANPK1jG2jqnycnIXjB3LhYVmaZt97/RUWP7KwsO2w
 8XuUDYp+DVUWhjrTZFxVh+8ZYp2B79Tt6f6emCuEH/BOr4zHMwh/kg75y54/uvhnhpC9F+EeW
 gtQ4rGhqJP32o5UT+XCy7mxv2nIclO1sMTtiCtJj2xc5E/OoPSr1RvDUFzsjE6/9aclA7myQ5
 Lb+2YRRXUSXX4BmIUwHJ2uWwaEw=
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
module init, meaning the DMI tables used for whitelisting
features would have to drop their __initconst attribute.
Prevent this by moving the whitelist handling to module init.

Tested-by: <serverror@serverror.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 87d668799c9f..1cbdfd77773e 100644
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

