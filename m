Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC67E089A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbjKCS6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbjKCS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:58:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48B6D60;
        Fri,  3 Nov 2023 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699037855; x=1699642655; i=w_armin@gmx.de;
        bh=crjd0fdGfmTMPgr2YiAk3gnA49LR1woP6H9fXrLQ3lk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=itdz12JPTqhLyQbY3KSuebIYNJp8Pm66zJ9uiYV3+a5sV0ZSJO1ArN240dITWKs1
         qoBMR1qP55e7t36cLLuRamN/GcLcDuf3PC4AHIbUamvhuOaLTKg8ZvqpxOvaXzrnz
         6ut+dHIICyQXoL9ud82LRkrBF2PQxav1OCzfeoNt7Lcy8v8uMkkzU6rg9T4wx7j1c
         Z3JK7tOoI46JCt8EBHKrmACpMJTiwDRnEHIU7+z0GTFBsgZ1wTgLza89EmhZeRiZG
         k2na6v+jEfDdBZkUgmY3Q4gspWK5zjT2AWBBL5176ZKHu90TVIxRvVHdOR8a7NbEu
         08EdMThLTNusDWG9aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MowGU-1rnEcD30Fq-00qPzR; Fri, 03 Nov 2023 19:57:35 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] hwmon: (dell-smm) Introduce helper function for data init
Date:   Fri,  3 Nov 2023 19:57:13 +0100
Message-Id: <20231103185716.11007-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103185716.11007-1-W_Armin@gmx.de>
References: <20231103185716.11007-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gY4bbZFrcedFAAvxypYxQopmhkCS4BccMx9PQDXnwgLhDmdz7a1
 QFAQ+scgz+YuYvzo/bzBYgUZy3ZwZIpwG64YVhWc72tCt5PLyo8jnhecRf8AKSOAiPCJ1VQ
 mj+mpzB2nwNfzOAL1SXo95iY5RlmK/0nqgjq4K55LZTDV7nspiLdRh54WbkD5qgur+p/awp
 DNpFPgrQkgvbDUMKR+xZQ==
UI-OutboundReport: notjunk:1;M01:P0:RxhdxOFe/O0=;0MI+IggVXSYaqppV/AlpLmTvsfO
 xVm7YhTL4C2A0hlgwPDz92rxmMGaupBfXK03KxPY4SJGRpyCI9xzVQQFKfP3AQ7d3OHnUX3xM
 HUIM3BkUpODkgtL7AsZi9jErindHo8au7WVoua6EEa9C+VmNXfPM7SNpcgaGmLj6n2ckThh3T
 +H8shnWcyA9K0d0MxnCH73fePs99SjPYgU4Z8LaObGCEtGyTRSgILwnylALFJe+6foseNZx3c
 eTXQ8aYe7Izbj9P3pqwewZIPwWil6JCXHIWWgvp5J3XUnPyxeTlA9xVS92ml6gXwQkUeMdOfd
 i1ZxZpirJaonjiLfStsP5HUCwssF56aIUyJy0iAo/4awaZdY4vlHKe9i0px8WGwcfjTjpI0Jq
 i3Q0VEJKZfubg30jc9UFL5vD6IVA+vc9QYBsk2w5KbUp0zfFoVlIH43xDeYmIp60IASxGr3Zf
 npU4E1jbW4XC5OVvoN3gjn/mU6vaIArTu3Y7YnjPFb+Hc8dRYWOAQ9gz6cUrE982G4N3Qh7fv
 ePnx2Sdz7jbVaLokXgjmnyn+b/NAjnN/T7nxEq8xOlmF4EqRO36YJFZvULvWbQErC33SkkymJ
 nEinfIPQpgyIwwZajG49HnoszN7forVA5tydJMi/QZn6QA4csn8wTISAYI94eyxsN2fdndFrJ
 J7R9xVMiUYhApJAvUQbVEhZrOdoj2vDKrcrJzWa1r4NlBqwtXv5vy6sGTHBH7RuI30wUd1/iJ
 6txq6QiJH3fguiblZUQ2ndyZs1thBcpmiyPmHJnjMUkbf00FPkYvmFg/6TDD7qO1XtO+m4uZu
 +hf3g19Q+d5uGvoQe+hlrqH9ceLXgeHi0SnPUhQrGaE5kxa3nmIBeHVgHJFskVTaCiT4x9BbN
 a0BaI8pK/LQUyp6FLi88rWYTgRwg2q/fazQ/Czb0cWsRoecNDgMZSiJKr70m6clbP22xh0P0S
 fXgA5PCsRtd/Gx0n97FVjMqAJCI=
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

