Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9757F5594
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjKWAtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjKWAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:49:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3FD1BD;
        Wed, 22 Nov 2023 16:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700522; x=1701305322; i=w_armin@gmx.de;
        bh=t9QD/ghz7nbpurzY8iozN8tJI1kzOnEist27FbYvSvQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Mtles7EzSVqQbMszQI45nuo00qd3BXj/exg9gcw0HcqM3e7qM204uNFuvhD2tDnU
         8J0YEOxQyncetRcqJX1Jx//9jT778n4OVK6IZFHwWgDKJQrw9wTBR4Mmz1RGKDz7y
         QSDLGDB9a1x7FxX/oEZrEE2znZKSvVopVapAFCEEwkbm43aREFIo0PpVqX76hUSPw
         olyUCY7nBKYtL1YYrtVFNmlFCY0OteEu934JhrploaulIeDQ6KAdiq8LPBZatrc3w
         hvyQPHDTumtPBQko6D8U5mUGqvY8FYE3P+fykYOiBOUuqZ7Bn7DU00qcr/YLkU8Im
         P4bymtvi11UF2RApDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MI5Q5-1r8yhJ39wV-00FFXA; Thu, 23 Nov 2023 01:48:42 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] hwmon: (dell-smm) Move DMI config handling to module init
Date:   Thu, 23 Nov 2023 01:48:15 +0100
Message-Id: <20231123004820.50635-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iGBciax+Bq0YhlreLfXl8VR+gufHlqPxt3aCT4NPCNzfLE/EnRU
 tJ2zYv/6Rd7+eiO94egjYakqLp6k/sbAMbZW69FcNf/qsiHYMOaeUHRi3XIvT2nKPPg7xFI
 mexHc2WbjW4g1/zn/bRKxI2Y37tzW5EZOmR+trqefsPjNk9i0B9jgQwh4/q3fSTKXAAbGT0
 04lQrwELuUlr+CBwjNO4w==
UI-OutboundReport: notjunk:1;M01:P0:LURS1TZZexg=;Xk8aLUbEZPsvU5bP3yS16K3cs0y
 b0jh/32jTbk512DJomOF3zTySYAqkVK3RQevOqb1gzFRecUd/NJFe0BeIPJlSGN429UvoDchx
 qQb/pTO0PIm+oCidY7yW+DfTQyl4R/U1MLjccfHfbnnQM8jvCiyjsWMSTzo//Lw5rZWlk6s4W
 J54u2BcpiwNSW22Un4Qrgy48341YqWDAc+rsiW6k2tgVsUZMa4v2nhp0syNBYukMrWZyN0k9a
 BgMikMYkK2pHiykJJ1PdKnn51FkyvZ84dPMJ/H9kaMjjwPxTr9Sr2UNhLRvB0Wgnpudj4geVS
 hGKzDe+lsVk+IwdAV6zA+ANUEyo82UOw+IbX81g7fYCCx+Jy189fiO0YhFSVeHzYYFXsqwlBS
 k8ntf9JZgrTe9QENHxMSY2ZoOTcHVOC1tgGN/sbHqnyZKzOXbhMOMX6ihBrMoMMycJnPEggxH
 jf2vYODb/pBOzQsSyRriOvClKMcWftMAAosdacjWwP2YvRU821l10NPJTnbvZfJoAyvTpBSS3
 RF7Aw1oi27zv2MHWf2SqVZamPo4iTdnpnviSQN+e0Ca5GvOtkRH//RKYrBHliO0Td7VEMc4Vc
 +e2LxZa4oQEvL8Wun/DZyI4et8nDx4o87JCt2lykaM0rGdZwbZWNtV/Ap4DtPlxOc8S5U+3Eg
 UPepw9zV80ACVE/nM9DdefvDIW5H86PF3eYo9dWh26qqOZzoYkDbVug2fJri2Yqyr0tEyO/1O
 BLZgNLwdR/7E9p1vTDxGw9g5E/PVhQkkK6ffkCHCbY/z7tvVS9IrihDpXcFpicbFp7+clwK9c
 KCTAg5o7qH5IOJx/509BrVPnrRv73H6QK3lUea/PAknTWemOFE1ghnZFmO97nQvFmuOutNP22
 coIYj5CwCyvojlAAQvLulj+QTytQqd6KnX4eTZAkRCcZG8Sv81MVZL4PXEQ3NevbSZRe/MXPk
 xmeS3Hmc6+iV13O6CjwOh9K6U5Y=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 1cbdfd77773e..158b366b0329 100644
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

