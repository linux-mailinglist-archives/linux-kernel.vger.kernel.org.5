Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9817A1E99
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjIOMYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjIOMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:24:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7A7A1;
        Fri, 15 Sep 2023 05:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ4gM4ebM0Xvbuy2+ynWACA2XYwHS+ezSvLS1uxAkkkdk7lAybcy/9rDnDEh2lUv3+i9HVbFP0IKBtlbuyrVNUyFfAGG5mELVGFQClv0iToatVFnDB4Unv7yfy409Pme4Zn5RNGUZ7E5C/NR+7HjpqxMzmiaJMQgEJ3nnPJMYUnmZgGWpsg2sCCam/wtFfaLRl3FOOSssq0hzrKYSFrhE4r5Fk4LrO9/z8RMUiGtlWRpRq8Ui7VOCbsnoMsubJOplMudZTfMdVYkTTU14bXcqGqkdmtKuTY3DkCuo5q8naXGvCr3shKy3orQyQott9Q43bDeoaFaexISVq8xGYrIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTTQT19L7HjRJKYntCtQprFIpS9KlOu3/TE7GC4ctpE=;
 b=Qn2t/5PCO2H98piZaOSggOjn+ZH5WfmNNR/qf/GUtp/krXRaxS5qbqCgSIKzgupwFEXHIR/eymO5C/UG5ue9M0SNLnL5OvvWLTDO6tN3uvOXUgugnZgGkdWz4oCPNUvNonMvWFxA+OjUhdbKRU9iCBqQXDkxrVWNFDPJWZfJLw2NbBKeQVDxKesdrI5Bv3ZJuvyXZ7CnwSMgIFKr5AMx+PivE1OAmR1lBqQy39J0y4hJGqnaIyX0XRqeZgl1y8i7rgppMZxEW2b1JlollGyiU52BOVaUjKtcZvPttgOToOChKw8GhEyWXmLLTBwPT0WohClmNzY2aVnOO2MhBxkLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTTQT19L7HjRJKYntCtQprFIpS9KlOu3/TE7GC4ctpE=;
 b=EMWnHQaX2+3d3ZYgGta9HyL6Iyz78m1WmT8xqwL4jajA8K7Jyq53TcBWFEulyjpok2s5IZxcCpr+fns48NZLsfIyuhE4O1oeX0m8xjXeZumTxqBhS1okN54A6XMHGmW6zahU6Gm2EUE3eVnyxO8aMzbkKohCS68mNCYZ3VDyMJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAXPR08MB7623.eurprd08.prod.outlook.com (2603:10a6:102:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 15 Sep
 2023 12:23:57 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 12:23:57 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 15 Sep 2023 14:23:48 +0200
Subject: [PATCH v2 1/2] usb: typec: tps6598x: add reset gpio support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-topic-tps6598x_reset-v2-1-02a12e2ec50a@wolfvision.net>
References: <20230912-topic-tps6598x_reset-v2-0-02a12e2ec50a@wolfvision.net>
In-Reply-To: <20230912-topic-tps6598x_reset-v2-0-02a12e2ec50a@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694780635; l=3284;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=Mb/s2zUWSB3Ay1wXUJgJKbRyivb9+MCEZzgkcveh3no=;
 b=wm3IV10vWkFbK8tTb5MikBcIZZnOvss7xjpvxQsbpOmbt3/UPv4Y7oGWqqxbuNAqV9VfbIP7P
 6q+kA5Zs6kZAdCwYd7fEugBoAq+N8DQlg+iP1PKrFSqXhciEIxtDiLL
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: AS9P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:532::7) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAXPR08MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: bba0bb76-63df-4d70-30d3-08dbb5e6a208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltlPmHCi5bNxDiuP1RTOS8I2gqLueX1/7wY/EgZ2asMEmBTJDMWXuasJqMVUJTKo/tWaeeLndEL9Su88tHjdKZyMEoNcdYvF9BayGSiMeFezoh3N3HdHUXa9NgCd7KK4QfOKJISqnOgV/u/MrlrVmmp5EMCCEeGRy490gvZiv4AURnoBgFZ8ZzhjRVvMFOMCGeAqFjMpvv1s0ltP0PfYhWmgWzcoxEmpMqlJPb1S78b8CPvzjNRSji0+AuBtje4TPDAw3zjfaLkHd2jJ34DloKIPFv5t5wWBWDghClDrSrFjiJg+rVnUz9EC5WruDmUzkZXu/7Hbh9mV7aNdoxtRVO1l7EgGfg+TeqFcEpTiTyl0sjmY3q92tef7dO9KV2+o1TYmsGFdPopheUeAntO1M1B5tUEhFxCG261IEpCyBCIhJkx/8gLX9cTzmrpx6s0Wqs41Ek3bAJOjE4WsM/NVEr8lKJ8ulETf32YV8cNj4Q6CXA7V4YYGC2ggQQzS9n5NMraJPyAGaC8gEp9/wNtEWPlkAJO7uSuCMz4wgsXrwJnj4EjS0YhSdVaXYAcxMTl19O5yyDCg9vAkCqkP43Co0MXD/FqmiMZL6ckwTxIZk0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39850400004)(396003)(186009)(1800799009)(451199024)(6666004)(52116002)(6486002)(6506007)(44832011)(6512007)(966005)(478600001)(107886003)(2616005)(26005)(2906002)(66556008)(66946007)(66476007)(110136005)(4326008)(5660300002)(41300700001)(8936002)(316002)(8676002)(38100700002)(36756003)(86362001)(83380400001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVwaitoRzZoUVA3N1FOUHplRzJpQkExSDkwLzNONFJ2WGZrMS94bmx6TnBm?=
 =?utf-8?B?SW54ZVdUS01wVVVnUVNkSnJXT1FFWmZwcHNqZnM1MC9EYThrbWk0and1ZEgr?=
 =?utf-8?B?KzloRzZzVVhPZmtCWm1UVmN6TnUzODdWbk56czNLaE5GdzNWWUY5bXYwa3cz?=
 =?utf-8?B?cGNtSE44TzJhQ3NhcTY4OEJBbVA4ZHpsZ0xJTUN5dE43SDBhRjlaTkVPWTlM?=
 =?utf-8?B?UlJZeFE5b3M4WDJKMTdOQ21uaFk3UjVKM0R5YmI3TFNZU2tBSEdKMjhacy9p?=
 =?utf-8?B?ZEZLUzJmMXljVUZ1ako5VFN2TWNya2d3RGJKaU1Ga0gzMU14dk55cm5uek1L?=
 =?utf-8?B?SlQ5SUxab1N4Z0V5d2NTZi96alBVbDJOVXl3YU5FelNiOCs0dUtFLzFTN1U3?=
 =?utf-8?B?cnAxc3ZUaXQ2MDlGbEtGQk1lMDNmSzRjOWlHWFloLzZqTC80TVY0cklNa1Bj?=
 =?utf-8?B?aTJSZ1hrZ0YyNUJNN0hOOUMxSnNEWE5oNm83a2FCbkF3bUVGeG9nVW16aE1Y?=
 =?utf-8?B?NUxsSUU3WVRtNVVzcFhWeVBsQU1naDNRZXRWUFJ6NW1IWmhBbTdkYzJ0bkV0?=
 =?utf-8?B?NjBPaHJINUV3bG4zZkhDd1Z3MG9KQ24rWVVyZE9JdFVpYmdteHVOOGg4STJK?=
 =?utf-8?B?R0dacTJiZUViLzJ6V1ZEUmVNT3RxVGdmTk5zaW9EZHFrSDJYR1lpTUdxSU1o?=
 =?utf-8?B?THhrcFFYcWNSQkdZR3RlWFVEckRtSk83TTc3YmlqQVRTeXpWSDB2cDRnQlFk?=
 =?utf-8?B?dElrc213NWkyMzdhYWZOR0RscHNaaEhMa1NzQUR5Y3pDRXFCSGRYUXdwN01U?=
 =?utf-8?B?eFJKZ2pwSEhqdjlUeHhrMkRrdFlqY0Vpb29yM0dCRkl2Wnh0VjhnMmlqdFNP?=
 =?utf-8?B?N0hVTFFBbGxXQXlpUkxxL3ZCbnVPelg0YXNzdFh6cW04NjJ5MzJTRXZHWXpV?=
 =?utf-8?B?UmJUOTBUSnB6dlgrVGM5bmFmbENiQ0hQMndobFl3U0JBSVdxc0VMb0RMWmdK?=
 =?utf-8?B?bGRXTGh6b1dMMFdkRzdQeFd5OGhvQmRYcmtIM0V5bGtxUjk4ODhackFxc2Zx?=
 =?utf-8?B?OTJidDBJMGdQY0NJZkNpczJSMU5iV1VjNGJmK2JJSTNqTkpWYVNzb2lxcXdw?=
 =?utf-8?B?OUk0c2NFSTZaMVV5aHFkVW8rNlcrbm1ONWZ6blpwK0UzeHMralBMT2s0cXRJ?=
 =?utf-8?B?bVRhSHRnNTg1QXBrdE9PTzBXaDBsNVdwdi94Y0FiNGplcmhzd2lLbEVlaisx?=
 =?utf-8?B?bFdMb3RrTHdJZ0ZYZHRPMmpRNlFEdElUR1hwN3phN2NpR0ZzakNPcTY3M3k3?=
 =?utf-8?B?UFJnYjhwSU9YNTRDSElYS3FMZVBDYzJZOTAwejZqTzNSMW81Qm5HNndMdkFO?=
 =?utf-8?B?OEF1elVaeFVMN0hNdDRkbWlpOG84bEZNZU1IdmxiSzMvd0tPSnpqbmZ3dDcz?=
 =?utf-8?B?UkloRVdlczBlZTBFQUU5TkJQZENuaDlHeXBQRkYzKzFMa3JmVEhUYkEzSGJ2?=
 =?utf-8?B?bkVENkoyOHJQRGFjeWxzcGJaRUFweExZcm1ZNVVySjU0SGZxcytoYWRPdTFI?=
 =?utf-8?B?dGxYd0ZXM2FsQkl5dWtXZ201M09oanMyTW9hbmEwUGV3ckpTY3dWeDhMUklR?=
 =?utf-8?B?TEp6TmNnNVZnNHNOMDhNWlkxKzJ5d202U1JiZXNVa3ljYVlUS0JwRFVsK1h4?=
 =?utf-8?B?d1FoS2NiWGZJSktMaHVzSjZSUTBJTjJPMkNibzViOWFSWDRIbVkwcWFUSmNz?=
 =?utf-8?B?ZlRhcWNJajJuM1VNZjdqZ3JzcW14L3pndzhYZno1OXZQRGxRQXNtdnZFbmFl?=
 =?utf-8?B?dTV3Ty8vQlNzd2JGMHJqRGcwUTZKQTBOamYzWXI5cW04RkRXM0VFeDdBNGJ2?=
 =?utf-8?B?U3ppY1dYNXMrY2dSZXN1QVNrd1l0RE82TXE3RHhQMGYzNDgrd2x3ejNoTE9Q?=
 =?utf-8?B?VWRDRUw5WkE1bHJaN0NFL3hteE1GYzZ3anB3Z2JVYlA5VU1jeVlFM0VrT1Qr?=
 =?utf-8?B?VFZnNHNrTXZRSDE3NEowYzBMdWZscHFkRzJmZmhxUUpoY3hySmlraURkdk5u?=
 =?utf-8?B?TTRWWFBxd1RJTWVoYjkza20xODVtd2RPYXJPYVd0SVFFRmFLMjVFWlJxYzZl?=
 =?utf-8?B?TitPRkliZVhTeDFHejVOMnFla0JPaWlieUE3MklTMlZwWkxvUWpBVEpZdEZB?=
 =?utf-8?Q?L3puR0Cv4WuslbLiikuyx4E=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bba0bb76-63df-4d70-30d3-08dbb5e6a208
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:23:57.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zha+vLzhL8JUincvRGzlDXsnq29TcgX3lBWhzcho0uDqiute4qsFN4QcNMHzNp3gSl6ZkGhS+zfOhWwLl7UgueoIpzGKapYLdV4cc73FIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPS6598x PD controller provides an active-high hardware reset input
that reinitializes all device settings. If it is not grounded by
design, the driver must be able to de-assert it in order to initialize
the device.

The PD controller is not ready for registration right after the reset
de-assertion and a delay must be introduced in that case. According to
TI, the delay can reach up to 1000 ms [1], which is in line with the
experimental results obtained with a TPS65987D.

Add a GPIO descriptor for the reset signal and basic reset management
for initialization and suspend/resume.

[1] https://e2e.ti.com/support/power-management-group/power-management/
f/power-management-forum/1269856/tps65987d-tps65987d-reset-de-assert-
to-normal-operation/4809389#4809389

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/typec/tipd/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 37b56ce75f39..3068ef300073 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -8,6 +8,7 @@
 
 #include <linux/i2c.h>
 #include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/power_supply.h>
@@ -43,6 +44,9 @@
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
 
+/* reset de-assertion to ready for operation */
+#define SETUP_MS			1000
+
 enum {
 	TPS_PORTINFO_SINK,
 	TPS_PORTINFO_SINK_ACCESSORY,
@@ -86,6 +90,7 @@ struct tps6598x {
 	struct mutex lock; /* device lock */
 	u8 i2c_protocol:1;
 
+	struct gpio_desc *reset;
 	struct typec_port *port;
 	struct typec_partner *partner;
 	struct usb_pd_identity partner_identity;
@@ -717,6 +722,13 @@ static int tps6598x_probe(struct i2c_client *client)
 	mutex_init(&tps->lock);
 	tps->dev = &client->dev;
 
+	tps->reset = devm_gpiod_get_optional(tps->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(tps->reset))
+		return dev_err_probe(tps->dev, PTR_ERR(tps->reset),
+				     "failed to get reset GPIO\n");
+	if (tps->reset)
+		msleep(SETUP_MS);
+
 	tps->regmap = devm_regmap_init_i2c(client, &tps6598x_regmap_config);
 	if (IS_ERR(tps->regmap))
 		return PTR_ERR(tps->regmap);
@@ -892,6 +904,9 @@ static void tps6598x_remove(struct i2c_client *client)
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
 	usb_role_switch_put(tps->role_sw);
+
+	if (tps->reset)
+		gpiod_set_value_cansleep(tps->reset, 1);
 }
 
 static int __maybe_unused tps6598x_suspend(struct device *dev)
@@ -902,6 +917,8 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
 	if (tps->wakeup) {
 		disable_irq(client->irq);
 		enable_irq_wake(client->irq);
+	} else if (tps->reset) {
+		gpiod_set_value_cansleep(tps->reset, 1);
 	}
 
 	if (!client->irq)
@@ -918,6 +935,9 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 	if (tps->wakeup) {
 		disable_irq_wake(client->irq);
 		enable_irq(client->irq);
+	} else if (tps->reset) {
+		gpiod_set_value_cansleep(tps->reset, 0);
+		msleep(SETUP_MS);
 	}
 
 	if (!client->irq)

-- 
2.39.2

