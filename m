Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E67E1A61
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjKFGon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjKFGoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:44:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442010B;
        Sun,  5 Nov 2023 22:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699253045; x=1699857845; i=w_armin@gmx.de;
        bh=crjd0fdGfmTMPgr2YiAk3gnA49LR1woP6H9fXrLQ3lk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=C3QyV9LR2+TN+Yh5YS663M0UkJrol0QELhV3KJHqq7++2VR7lCZgdmO9/71vU2Yc
         4yiJu/AYX0pap+pQn9MISK1JHGHmeTYVgC+4nn4GlTvFma/sWCxRJ3hw3bO/ZbYpJ
         pI2iT9a9/NA2qFR4EIdhR8TjKBbPJDncN3GKvj+Y77vg7q9PLa1UnNI8da6TeEh/U
         xeCbSUV+qpztA+LjCxzNP1x26Wk51dgMsvb+cSDvzTlJRd4E+8tJ1Q+NmWBcRRO58
         PYTiwR8lfGjSVxD1hmeFs5/UvD/sloXGjwV5TLsFMyIwbmPX3aXQq6sRp8JxPr8OD
         eAmxBn68GH5W/u5Z4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mq2jC-1rmkbe3NII-00n6Jj; Mon, 06 Nov 2023 07:44:04 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] hwmon: (dell-smm) Introduce helper function for data init
Date:   Mon,  6 Nov 2023 07:43:48 +0100
Message-Id: <20231106064351.42347-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106064351.42347-1-W_Armin@gmx.de>
References: <20231106064351.42347-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9mZDn1dlHOY5sSAXE9D5qdhLG4MSZeT3dhclNx/FqQKzIMGq60u
 EY5y/u6Rp/TWztKcvXw22dX5jPZafysCRR94Ksv5m7vJ257v0x6c18ysO3FBeYf3rVlP/EH
 nHGkqeqE53swkIRJCcI9/i8Q6b7TNYCMSUYvEJapTi9wm7NMii5lMmj8CDBp3VZMVh0QnZU
 U+7cOvMXjyRIS3H6rPJrw==
UI-OutboundReport: notjunk:1;M01:P0:39oMOm+oYYU=;skS4UWkxI61rJgx8kwLO1RABumR
 rtq4pCH0UeXl8MwHg9lI3yOCifa/HSBXtmOI4E1fkPf52eQVRIp2HOk7t78F6/p6Aa13w4EUo
 3IKWVc3dW5Vo/tV3Pa01UXTZziaev3k7QEJaq+Wq46t9htx+yNcI8B8aZHk1wUyboDv18Y8rZ
 kbAtXJRsxSE1pbPE0O4S8xvd+Hdi7SInv4JTkcLqu7pN/C92xJ9zpgzmscPPX3oEYz1v4MCyy
 rrx1IAoGZ54T8+6z+GobueR+wLx9vwdasRsrbtME1JXNE/mep9ZqAvS/e+X3iAEZFSSc6MB0x
 nOsDDARoxWpUC1VYf6pYvC8yScXYno4CvDv5u9mOCwSwFQopJWJwA0eOknVOjIEiHrstnTcL4
 i2kDIXij+gBeYYoQkIaNLOWEabwRxCgaYKmaVBgolwRtVGp5R1G+WDG/4O0k86cTIHIvpado+
 knoEBS+30IUo6eYgqD8lc2Zr4iytwUNEcBa8WK5WhZLZcpq33lZGpoiI3m3ygedH1Xq4rVXaU
 LxVF4aQv7zA59CHOVlQ16gPBm45xZlTQD5erRWOYcV2ylTNLD5RH/G15cDqlzjnGJ6/e0sNyb
 eI4ye/HTZFXZk3wdde+Kf0EyoDuFlR9/00743qjGXdLTuUrJjwzXOLKYZI2d6gLSnf5r0v8uJ
 VMwTmGXtli9fHXFno4u+3Njj0UovVBRv7QJBpZoCKvDvPQdCKGovH6m5sfuVynWlInqzm7PyM
 QqofJPAm+Hl+h5cy28fBAY6ogZYoJHUVeb+6JxxooeQCgHub3CMTk6LO0OfRBWyk09CfNp7hB
 o5bqcmMlccWU0RpRIFY4uXF1I1Yb5gPyd6bk+alTjZYgKf7uvwadqT3lFYO7npHLDWBHeJW6G
 q+BkNh5aj/LiLtYhMNo+SaYbTRl1JjyQPgxOpILPbmvSvtoWhtBuNDdhqBweJnWzHdzG3S/t5
 BUd1g9j+eJVjLXLFG5c4iwhKGZQ=
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

In the future, multiple SMM calling backends will exist,
with each backend being required to initialize its data.
Introduce a helper function for this so the code necessary
to initialize dell_smm_data is not duplicated between
different backends.

Tested-by: <serverror@serverror.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 46 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 4a2c0d1ffa5b..2547b09929e6 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -623,6 +623,11 @@ static void __init i8k_init_procfs(struct device *dev=
)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);

+	strscpy(data->bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION),
+		sizeof(data->bios_version));
+	strscpy(data->bios_machineid, i8k_get_dmi_data(DMI_PRODUCT_SERIAL),
+		sizeof(data->bios_machineid));
+
 	/* Only register exit function if creation was successful */
 	if (proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data))
 		devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
@@ -1078,6 +1083,26 @@ static int __init dell_smm_init_hwmon(struct device=
 *dev)
 	return PTR_ERR_OR_ZERO(dell_smm_hwmon_dev);
 }

+static int __init dell_smm_init_data(struct device *dev, const struct del=
l_smm_ops *ops)
+{
+	struct dell_smm_data *data;
+
+	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->i8k_mutex);
+	dev_set_drvdata(dev, data);
+
+	data->ops =3D ops;
+	/* All options must not be 0 */
+	data->i8k_fan_mult =3D fan_mult ? : I8K_FAN_MULT;
+	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;
+	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);
+
+	return 0;
+}
+
 static const struct dmi_system_id i8k_dmi_table[] __initconst =3D {
 	{
 		.ident =3D "Dell G5 5590",
@@ -1386,26 +1411,11 @@ static const struct dmi_system_id i8k_whitelist_fa=
n_control[] __initconst =3D {

 static int __init dell_smm_probe(struct platform_device *pdev)
 {
-	struct dell_smm_data *data;
 	int ret;

-	data =3D devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERN=
EL);
-	if (!data)
-		return -ENOMEM;
-
-	mutex_init(&data->i8k_mutex);
-	platform_set_drvdata(pdev, data);
-	data->ops =3D &i8k_smm_ops;
-
-	strscpy(data->bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION),
-		sizeof(data->bios_version));
-	strscpy(data->bios_machineid, i8k_get_dmi_data(DMI_PRODUCT_SERIAL),
-		sizeof(data->bios_machineid));
-
-	/* All options must not be 0 */
-	data->i8k_fan_mult =3D fan_mult ? : I8K_FAN_MULT;
-	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;
-	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);
+	ret =3D dell_smm_init_data(&pdev->dev, &i8k_smm_ops);
+	if (ret < 0)
+		return ret;

 	ret =3D dell_smm_init_hwmon(&pdev->dev);
 	if (ret)
=2D-
2.39.2

