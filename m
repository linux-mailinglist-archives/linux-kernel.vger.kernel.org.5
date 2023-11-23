Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB17F559A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjKWAtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjKWAtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:49:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFBF10E;
        Wed, 22 Nov 2023 16:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700525; x=1701305325; i=w_armin@gmx.de;
        bh=bn+q5ZaW7DBuObgEvkg4DqcTvbTPc8wECSSSUW7q3qc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=hzMHr8NRdHa1XgNt7TdS7AYuPbWXl1BIGhh7KM940XIC9r23DhPiaTBjhuj5ySqv
         j1LcjoAq71sSDDFi32x0Ev9aG5cFquPzQmFJ4Lm/wXgtJyYrTIXzv7ZgMKg05zUL/
         iAgEITsSXmMflFcsOltRdcXIfO5VICoOksPSdjnDIqaDAVcmrzFMZmgjhjUAWakb6
         N+cIm4I3C0/TO/YGugqTlRU9L5xT3BF61OScXGS57TQUCWpJ5vl23OjMF3nfR8mFN
         //PDHXzvBQEm9q3Bc9Y+bopMcrBOMawPvv2jhDnP2QvCBtSXqE+FE0pw+PC94Tgd8
         1414lU9C+RVO4fuhoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MpDNl-1rfqba2ZgN-00qjnu; Thu, 23 Nov 2023 01:48:45 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] hwmon: (dell-smm) Introduce helper function for data init
Date:   Thu, 23 Nov 2023 01:48:17 +0100
Message-Id: <20231123004820.50635-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vcf0J2iT2zvplx6m71uOti3jqZcS1MQKls5EiHE+rPPi6SUsF3k
 Qv/e5W5ZBISkybcNkfg3HgQrIjapaOmAvmsJjtHXkIktAmXTdqa6E5kcIjdVLO1OIER0wYq
 6I2zzK0ZocF5tQ4cg19TFW45RoB38EOekR4VyC76MVOLSRA6ooOebXSsU+xuqLzorVcOFXT
 o0czVPRT8N9pM3tBeWjag==
UI-OutboundReport: notjunk:1;M01:P0:UMjR7NyAJrQ=;i6RXTT4XhJmVipp51KjbpYL2s/D
 /wT/BNi/EZOWARTFTlqkjybpwakkhtaDoRyI16V5YViYIc4e+nd0Mh+xQF9A/CRXWA8QX2jW/
 Sjp30ZhubHq7HNHMb9BCTQVUDBCrMnxaKLgnc3KskGPvgIIJyIobRNLS42L/2D4SI3VP9x2dO
 5NP72/WaoMaJmYrz7WUxgnF3f97VS2uK9mcXh7wct3jNOOR3fdwWKeTfP7/vHYOnIiRZYS7K3
 FDU3J0Js7TwDBDBgC1l2oLCEQMgNVQHyHvX9cSJx6J58RzndAHU314YDPEth/+F/O1dwGKbwX
 7cX+B8XjHhxWVoZjflSykjGUbKTZVUmMwuNpkg//4na2A7BXpEYm3Jz8I4VcHW5GEDEbrHX4p
 0JHkujSUOxT4OpAX6mK+Mt17qsKcOJJF5XUq45daAdM/X4xy5exUeL3rS4MbIJFKG/eCkfXaX
 uY+Nf8XtnOxp3QWm6F+vYUGmmRg3He8xE0zRFEObKzxeSNGP9c5UUCkPf2yv3IGRuXPHUHIgm
 ufb7al+TOlcrWtcHMCeYgvQxDMHnLHJiUpMsfl2/zcbMIXiEbSw6uVQtHQa0/x3cgQE43VP5R
 X6NgabU1rbqkiTnglP9of+Eac6lAq4jocvicL+D9C0zf0MIE0n5lM0xl9f/evCpjxJ+Wk+6dz
 JdwLH7rwIXmWnyKclPxBVQtYtiuipYyyLERTr58ySJ4mQmVLkco0pNQ/+QNQisvyhd09TtudN
 YTZjHYMjFtgYUNID+KaG9TW10JQHuMe1B+p4adABnf+dvLDHxE3zIWH+p2wl5VrTE/Xzk8mU4
 fV/nKoQ5RJ34hRZMiCWNAu7jPp+KZ56BRGvNVC2/uG82MJ5JWjtg7MwAvrToO2xtguXeOJZsT
 Fe4oyQVoYcCY+dsoi7p/ZfQd9RLQzQOD/J9yVQACAX/qhOUyIBWB08DDO7eW9yL6erXNvXiT4
 2YVHU5JBYWQ8wqYgMzwxNI7oAl0=
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

In the future, multiple SMM calling backends will exist,
with each backend being required to initialize its data.
Introduce a helper function for this so the code necessary
to initialize dell_smm_data is not duplicated between
different backends.

Tested-by: <serverror@serverror.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 46 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index b60755070d86..a377cd08355f 100644
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

