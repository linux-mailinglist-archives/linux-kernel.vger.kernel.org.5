Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE81B77D075
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbjHOQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbjHOQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:56:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30EEB3;
        Tue, 15 Aug 2023 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692118565; x=1692723365; i=w_armin@gmx.de;
 bh=d/izCvn2UZizEZVbi3BAVdaO3sRXpnlIPV7lvNiO0O8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=QDCgPBh9xK99X4sqLZ+v13QbKneIfjJFTBZOwdhd1f4N9jum+zHZfMcLpKCnRQmhYW1EaUP
 X7LvJiJiWyfdTvMRmLGSRfIjOlaUz0HKXNjamFVF49uf0txIxHcplB/W4cb/aYlax/84dVAUM
 1Suy0LFblNRY8LRCidGidXc7y7hOnmgNAU8lSBBOYTvKZrjTsbLQGi4anSeF9EJrby3IP8MRs
 5ZaJUeA9apwFsLU/hhiQz+36OsVJdhDUcZlYXC6LSbLh12aSXQB3BtSP2rHdm5I5wvv4cdemR
 2tcK+kqKw47Cy+F1DvY7CgS4Wjsfq12fh83quaiJsC9hwIt9ydkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M7Jza-1qQSd70SRY-007o5W; Tue, 15 Aug 2023 18:56:05 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (sch5627) Disallow write access if virtual registers are locked
Date:   Tue, 15 Aug 2023 18:55:57 +0200
Message-Id: <20230815165558.4176-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2oULqiHNdug9VCvmj+Y1WEj0tIZwELrv8UfjiFY1IpkY3obchrz
 Fkd4zd0SZGS8MLoFqWvFaKLxUlwOaanAmhYAL2jR+OCDt7kO9CLt53k4guJG4Jtxl0nn1ZP
 SHkAH24R3ERcesCGw5zIJRcfa4VbrOr5K1pFD7YKMuQQFaeG5eKDodsw6GHdW4uiDAX2OFy
 hitUgdOtIw8pJMZU3IQzw==
UI-OutboundReport: notjunk:1;M01:P0:iGyHKw3EiXQ=;XDHHElRA8z2gTPQolL0EAENoasE
 FKVLTDjz9XKTcxRfpoSb0CHWUiDlD+aCUFQosuakZhSCYpbWrUVSM2ccVlmqb3YWeQyL+x2y6
 yboN8xd8z9o6dN+IQfZxxqy2F3FaQDlwbitVaN2UQaZh7TtMzcv7WUvFglh8354TuOjB3OBmP
 8U2xDQ+WNemPNjO7pNz/hxLWv1v+huwat00OQfIxLf3Ie2ijfMF0tyYUC09smRQcuLlVPAAyp
 dqnGLxvoUNoRZtFOmLrWbFnUsqf+CbGz8bK+xDKGaTiFtcrndA86R3aubYOSYV7I+ASXmYXJT
 7UpfKUcg0YGZe1oe2wSTI6XIdMxyN/olh0TI5gnn/FZO9qtOXAsgWuykdigEWAopXY8UCJWFU
 hkFum0MvNNLxxwIkUYOnbUk4pPUQ9Zd7OvVgFrtxzvlDyx8jwgLPd2/dGBEsd29qXOVLVhSJn
 IynZ4yoaW3XHENmiHy2iiFnNWlEpkrUtV00m1TsH2RdLgxpGqAkhXrnYC566EmyTdCse407O+
 YdwF+s/eW2DnqyY15yKu9up2/+AwUIY+24bly9epb9tLQExHM+iCR3LTH/NAk6vZVDcOZY86x
 GKyrhEIitnfiKtjYiuEEQJggNwFhnwQafxhP6zmTWph5r4CYuOMcaXrsSLZ+veRf63vv8xdTv
 IheLTMjOQG7uwJvZC7Ce/kXqc4OPvaOEUjYgHTKJ53NMWLj3pSz+HvNYsm8yRgpEpHMuSdlj0
 TApRLPpnUEgzdfvxcUgp2eSudrH3Yvfft5G6y+t0kOzDjCpWOIX103ByVoOVFHCQQtCCrXIij
 XY9OpZCBDg+o/ogOrP7xnF5fFkjDASQaI/2o/lVEVQd/XZzI7GCFl0EBeW3XBEj4f+2jI+Zj4
 jkznGR3k/VMcZ81oeMiQvEThWxvHpQ/MBBtEipshPvyjc1Mtgy1dYpfVLfNXI9hmB2SHRC3+J
 5mYFuBftbSr5xLU/RKJofZ1HEHA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the lock bit inside SCH5627_REG_CTRL is set, then the virtual
registers become read-only until the next power cycle.
Disallow write access to those registers in such a case.

Tested on a Fujitsu Esprimo P720.

Fixes: aa9f833dfc12 ("hwmon: (sch5627) Add pwmX_auto_channels_temp support=
")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch5627.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 1bbda3b05532..bf408e35e2c3 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -6,6 +6,7 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/init.h>
@@ -32,6 +33,10 @@
 #define SCH5627_REG_PRIMARY_ID		0x3f
 #define SCH5627_REG_CTRL		0x40

+#define SCH5627_CTRL_START		BIT(0)
+#define SCH5627_CTRL_LOCK		BIT(1)
+#define SCH5627_CTRL_VBAT		BIT(4)
+
 #define SCH5627_NO_TEMPS		8
 #define SCH5627_NO_FANS			4
 #define SCH5627_NO_IN			5
@@ -147,7 +152,8 @@ static int sch5627_update_in(struct sch5627_data *data=
)

 	/* Trigger a Vbat voltage measurement every 5 minutes */
 	if (time_after(jiffies, data->last_battery + 300 * HZ)) {
-		sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL, data->control |=
 0x10);
+		sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL,
+					  data->control | SCH5627_CTRL_VBAT);
 		data->last_battery =3D jiffies;
 	}

@@ -226,6 +232,14 @@ static int reg_to_rpm(u16 reg)
 static umode_t sch5627_is_visible(const void *drvdata, enum hwmon_sensor_=
types type, u32 attr,
 				  int channel)
 {
+	const struct sch5627_data *data =3D drvdata;
+
+	/* Once the lock bit is set, the virtual registers become read-only
+	 * until the next power cycle.
+	 */
+	if (data->control & SCH5627_CTRL_LOCK)
+		return 0444;
+
 	if (type =3D=3D hwmon_pwm && attr =3D=3D hwmon_pwm_auto_channels_temp)
 		return 0644;

@@ -483,14 +497,13 @@ static int sch5627_probe(struct platform_device *pde=
v)
 		return val;

 	data->control =3D val;
-	if (!(data->control & 0x01)) {
+	if (!(data->control & SCH5627_CTRL_START)) {
 		pr_err("hardware monitoring not enabled\n");
 		return -ENODEV;
 	}
 	/* Trigger a Vbat voltage measurement, so that we get a valid reading
 	   the first time we read Vbat */
-	sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL,
-				  data->control | 0x10);
+	sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL, data->control | =
SCH5627_CTRL_VBAT);
 	data->last_battery =3D jiffies;

 	/*
=2D-
2.39.2

