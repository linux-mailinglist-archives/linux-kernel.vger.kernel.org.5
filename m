Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B357E1040
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjKDP5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjKDP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5CDD48;
        Sat,  4 Nov 2023 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113375; x=1699718175; i=w_armin@gmx.de;
        bh=KzTtitQlUrweVrr5QpGq17vU3ttU7nbis5K8mH0T98M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=DWotbEIAxLNdMlJsOFjKM/gyPKqaV+bpABpQs9MqIqx+RgFwTp8cnXb4ekgDNRYX
         0q9BlPKuPtV9TvDSW2UK60vgPCpsgI4j/CN/4vTPvh3XPiw+hYEyeoWLswYHAfALy
         bd7XFRYuvw3DRHBsA8PfXulETKC8oFrS9Bzy/ScfJCnvYvXGz7IW+A0VGpkjG2Bn2
         XKAhHyAkN1Woi8SsP5XunFyZLGO+8PRyBElGuCGH81Gt1NZUmQi8twk48ur2lejZo
         RHyQeP6xeqgm1S/A3F3tatMWE65MkQ85Ci0nNdJECSViIv3XWGcI103NzGv833Zl7
         MnBJKM0yfU536gvtUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MmlT2-1rflIv0gb8-00jsdk; Sat, 04 Nov 2023 16:56:15 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] hwmon: (dell-smm) Introduce helper function for data init
Date:   Sat,  4 Nov 2023 16:55:56 +0100
Message-Id: <20231104155559.11842-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104155559.11842-1-W_Armin@gmx.de>
References: <20231104155559.11842-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IGW+Zf7o8zLl/z8q4IGAVyRHvZ1Z1fKCMJH5xOqbSSmfb9oW7NW
 L5OVq5DeDyGHd+x4D4rTuSEoDJsK3yWm8PrlQyCRJv9xhoSik7G7RwQYlBC1NRSRfX6la9k
 0DLtad1u53AziYHj8otKxNOMU8ndVfFGrpCge+y/NOOBuSGTh5nqVMq2fyW1xz8V9ehdB3Y
 xeg9p/68QWdHV7Nmlzidg==
UI-OutboundReport: notjunk:1;M01:P0:fj4C8uLnVVk=;/EXtlkVw7waSM5BAb9t17HcGE+M
 ZIeUI5tczW8f5bertWsuS24awCEksfY05TSn4iY8yVXwX1z1KDuAMGEE1INAwQDiCXiXu8fpU
 cJ7qQ1zBn571GElX0Go923ecfE4CGYTlU0A8QQ54gGkB+4uk9PIx8YNJuKJFkhz8kNALZjvDs
 Ibgez7FY8b9P9nY3bN+jfGIHErnTI5a6kt9jQkrFwu6yleCiFdZdlTfe3rwaLPSPnfd0AfVTH
 6VJu0VjzJlWm7LFg2Mx3ZUQVpY9H/evNc1LFVYmLc1ElNNv9UsvHvyJ/RC+kHoYyB+D01BzB3
 zxY7nUHkFWCCaoOo8EU+mpzgOTabn0H9R4gBDbudcPU6v4lvQgKL6XvU6QcYaX7kGmqGCDnXf
 hlLNSx27zxdVuhhHQ2eWCUAzwe/GdNra2PNMjwKcxiWJh2i8aV5i94yety+QyZHZVoYaBZ3zF
 lcxWEyBeEZhqonJfyuGFnKYmDBREj89HA+wAydpLOLsYUWKm55hDRbSbL+MNEqIXi8/QeaUxz
 ppqMwbuxCl5Jnap9V96zo6+LvOJS7LrkXBDAH+bDYvNU0wUEg5/Dvxy7x2p/qDH7KwbqXcnrh
 OQS4HuJVeDVwtbRj1DE6TpsqsWV/hmaUby/m9FzinuMkt2UHWuX0EskVZExqK8yFKIzaniEJh
 iQ2F72wYGndZ6EbQrKTXhjesLYRDQt1it7sXvBv/HrIo7VPjC7DvVbBsg4nuZBk/IvR+F2I5y
 6eh7ZFnnv/00OX//EA8Yshg22NBYNzUldilcmTn87AQe9DWqQQMIqIfviuy6z4g8SL3VMzZcx
 7vo907DSwcdPNV7f7h2yKyxqDta9lkO5F6/ng1pIfkdw6LSvqVDqNgUJDntn2H+7g1Iwf8Oyp
 RWRObeVY8cA0Ah3a0U2g37MSWszjjBulumtXBS4jteDJzRWS7oY1AO/SFlV7/lcv30cM65/ED
 2H0OXkGo1kcdgR7Qg4GK0BzG+eY=
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

In the future, multiple SMM calling backends will exist,
with each backend being required to initialize its data.
Introduce a helper function for this so the code necessary
to initialize dell_smm_data is not duplicated between
different backends.

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

