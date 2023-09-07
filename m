Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C887797016
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjIGF1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjIGF1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:27:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4A19BD;
        Wed,  6 Sep 2023 22:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694064406; x=1694669206; i=w_armin@gmx.de;
 bh=ZE1f7vvKf+kQRkldYDJVyR1PVo0LRUHCu1/yqa0+JUk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uLNzU/EVrbsgCk89xlVgQ79e4xRsJPcnMnaWOKrW+vSh6RDv5+8wSTOBXueGdI4iZfv7Stb
 /MBn1BAoISpUssA6nKTTdc1H5EPyaFZ80fSah5TG0b2VBKYxA0n8OVkfcoNnalcExIi7j65yI
 rJVg9k0qXyzoMbFPJeSuyobibOuRoL7UjwIFyGiYcaYEkP6/j5oHW2QASZmGpRdihkNZFelPg
 mhquI6aMKUogdEAicJoblaiZZbX/G5BS5z5O/s76oux3G/jmMtQU6ww6rSIgxojl1Y/99rhEa
 RWW6N/oNgEpdJ5dkbHE5CYciEac5QS32b7vpox5GRCPVhql79MLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MmDEm-1pwIPV407E-00i8hv; Thu, 07 Sep 2023 07:26:46 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] hwmon: (sch5627) Use bit macros when accessing the control register
Date:   Thu,  7 Sep 2023 07:26:35 +0200
Message-Id: <20230907052639.16491-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907052639.16491-1-W_Armin@gmx.de>
References: <20230907052639.16491-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJZKdDFPrkwWi3gzEE3ykk5sc9pNH+jwZy9evoepTPk54k3vmfc
 X3PNqxCHGlr6dVX3ZjGsfwVwDW6/GH3PkOyhriCOR41Ks5oUrJpfPdKOl4KnkG8Z2Xnj4G5
 uOaRqF6N4/yB1y+LOw4bZ0xQyM5pcjWYhLNhoXMJqYh3dtJrUS8J0gAUb+JgHkwMkxbBhMV
 b8Zdqy9KH4dJvijYZGzgg==
UI-OutboundReport: notjunk:1;M01:P0:C4qCTuLlA4w=;bwcYVqlziBQ+03jN2bcDA8HxFni
 t6IiaJr63sCwKPo1JCh13WZ9ubS6xCWcQwDLxRGVnBnYdYPPnWchQsFmbevs6noLr3WP8fmUV
 BvACB9JbP58UHj9+olKl243LcWLqjm/gkggZYEY0jbXkmfgvVEoGH1l8ySxABs2VMX0hgTvEo
 dZWItdHZu7nLOvWzB1rt/04IrwRA8PePMQWsshAtD2F5TY/33z57+bayDvhEr4FTKsZALDbUL
 jllooKBVMxqZq8Q2/H2ktp/E34bZXj3ud1ZEZaLEQqel31DV4Ze2c5S1VbEWapsVfL0ci509R
 sY2LmKunOq9JBnEGaFEEIVciHHR7AWrTPCVvPXnnibNnDXQ6xNXhp+wnkz9iBN1Ta2ZRyVygh
 aLQU1hC6vN9VfReMywV9Bh8ZuDM7fSQJvu4N1cGy9y2ybBKhVZmr5p9JQBM1qlqDY0Slh4IXe
 OJeMWHdehkNYrXUJX1tOu3U3jeYlcDtBk1tJJ0dcZld+uhBVhlAo4IxBbx8uqUEIGG4NOWt8v
 8ae5QVWGd3HO4az+oj6ThXoMcuixBlC5upEo8KDCfkarqhA5jYXIZmX9o55FEn9hDamVqU5wx
 ODefp0Mo2tDboY7bZPSpl5g0Cw6uJDDsxqzGR81tjlREWgEu/mAqbx+lTyc8c54KaVU5Alp4X
 iulWI3ksEB/Yuixym/nd9TmpPhgzQMKYZkDqikz8Pa7tUWYn+RebE1XKYwxBUVfRu13b3qChL
 9RGHZGjWMTdGDV09E0Jsl/pOlKykzHwLMWDMZjzHgo/owrRYcXDBILCgiJbiXQXcocZ7pPWfy
 N2BnJnL5dQ8fXyVhFx89QgPB7T6l0YBt3iHKxLo7ZYHc7xslpom6hn5fgp9T/x3Ww29G4qXVz
 9h/ltlKxcb0t438V8kjFGALPYYC8yknm02uCooiEc+83TnQLxoNRQWdKjKePjmy2w7TCvCnKE
 qZRjA63suZQqRqAVwgPb/j3C8tc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bit macros then accessing SCH5627_REG_CTRL, so that people
do not need to look at the datasheet to find out what each bit
does.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch5627.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 1bbda3b05532..0eefb8c0aef2 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -6,6 +6,7 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/init.h>
@@ -32,6 +33,9 @@
 #define SCH5627_REG_PRIMARY_ID		0x3f
 #define SCH5627_REG_CTRL		0x40

+#define SCH5627_CTRL_START		BIT(0)
+#define SCH5627_CTRL_VBAT		BIT(4)
+
 #define SCH5627_NO_TEMPS		8
 #define SCH5627_NO_FANS			4
 #define SCH5627_NO_IN			5
@@ -147,7 +151,8 @@ static int sch5627_update_in(struct sch5627_data *data=
)

 	/* Trigger a Vbat voltage measurement every 5 minutes */
 	if (time_after(jiffies, data->last_battery + 300 * HZ)) {
-		sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL, data->control |=
 0x10);
+		sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL,
+					  data->control | SCH5627_CTRL_VBAT);
 		data->last_battery =3D jiffies;
 	}

@@ -483,14 +488,13 @@ static int sch5627_probe(struct platform_device *pde=
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

