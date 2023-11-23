Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A97F631C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbjKWPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbjKWPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:37:21 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEBC1AE;
        Thu, 23 Nov 2023 07:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghEmNgZs/7qoElol7KCFVhXtfAGpFfzxAJ37nnEkkOjH9YStgYdZCxGdjKS2TJh7JT6cqoNJLwKtjVRHMs1n2TsqcvtvG2i35zlXhRAyEWHOgf9LM1Z8Qh74v9F0GzkR7/qeH9x9iFOEbTcWX9xiVN1rMlBsoXwreo2CucswF30Vpk4XyAUF3Q4YJwGpiDtD11ejpOuXPTGI4ubuxtksEbofcIS2kNbnp+KQ9GyksRBFXYje+7mYezRg2Kk46H7StMji8S2KshaWbrtvweevW7iBPkgD0PZRDhxhs86vLGYos1EF9amnF9gpvl2oo70GTUGkJVzDdnka7clqt5v01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb57mRET1V1pDQyFNdf1zGBmPIx0e5ZYRlRykQNlJ/Y=;
 b=PIc4Nhbx/VIFJR+mEu+DchUr5YxeT0RET3/eckWgTctHt7nCG+SB4hQ2pYsgHOCAhIL538dMJjm8d5tVZOIvTln+QeLXhu5MpA3dduYVW2niqZ9r0H5Uua7lKz9usOFzs6BW7/ckwo2x2cz9F260jJmW5nLBQsQgK6f/GwktM/AFawx4utCHGmpfkDgMvPTBMNLIUUAUq5g5YqDi+WvRfKGPma3hJgozGAdFOgObWBAaCv1UC8QdP5lwTC3sv/kNtFweUmSfnAqMviKSdCP/bZfFZ51uTjmIEt2W7/oNJQCB/ZFh5MzbA5+WmnQ4Ylc+/P61ypXqXU9a3NNdKtKcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb57mRET1V1pDQyFNdf1zGBmPIx0e5ZYRlRykQNlJ/Y=;
 b=GDI8QPUR2I/pRIJxKVahZ/SAgBjaCC+pTXWhlRceOaI+9m/D2cs0FvDvEi94UrXfMvwLZchlS5Z2zpDnxbI8HnND7A4EcdVkECBVUbc5f81QMaGnILF+hsIpehyYZIM82uwsi+iTSUN6QXhlEesyWQwBGYvTQdyhY83zaKKvsY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VE1PR08MB5599.eurprd08.prod.outlook.com (2603:10a6:800:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 15:37:24 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 15:37:24 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 23 Nov 2023 16:37:01 +0100
Subject: [PATCH v3 1/2] usb: typec: tps6598x: add reset gpio support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-topic-tps6598x_reset-v3-1-0c2873070a77@wolfvision.net>
References: <20230912-topic-tps6598x_reset-v3-0-0c2873070a77@wolfvision.net>
In-Reply-To: <20230912-topic-tps6598x_reset-v3-0-0c2873070a77@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700753842; l=3466;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=N06QjDGuoaMeG5Mg1opmllcR/3CqTs4j2zURs5NjTU0=;
 b=1lJCEp1AIre6yfn+OVNlbWJmafQFtv2Evqqlptj9yAFfoVK3ZzUoa+NIrVU4N6JTHPKD51A0C
 wOb3ysBcosTDxphmdqHl2U6c52X+N8qfngxwsNoRJ89Jmyo+QTh5ZfE
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR09CA0156.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::40) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VE1PR08MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: e365d475-1554-4234-372d-08dbec3a16d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtgfNtNCYkRUfe2l0CTA9cqcgBWfgO+NESsrhn1br4OUJEcHz6JSd/wR6aYBnDO7AkklcJaJ8X/A+oJ6A2s5NmyKJgSfjQQF60DMdBbQj/QxYV52IbdAB2QUWmHRTM0cDlkOLMJlJYb819i5qkqCfURDk0W4vcNATVOj30X+so1lIXAvQh/ypSmXRdI3lKDZSkj8HD+o9Nba+eqMptDUMpnFQwdWwHs38HFlkVctfwNlRqBnSJD941t3JsHjTUpZYGN/bH/AQNvB2XydHN9835xS/jlavudAdtR5iPES8fiUxZ++d6WPrvdbVVZLG2ZFEqW/uM9UJ5HKm/6QsI1cAKakDZ+r2uVLvUH+Fu0nhFHNQpBODFww0hollSyXcp49BkLtMWrtpByA1kxZUjQFFc2nDyn1HwsWei/yuapHFuCzzoPuMmw8LnHNfAttOTCmbtiI7x8cGXRAE4ND1Bgr7DO1UN4RjfPVbSNCUDBdi/odnrGgc7EF81neVEOMewHDANterhEAlvegagqOCNw54zb41o6UCRvQBe6e7aLq8hZlN2mX1KaBtC9W3dnzED6avQ34Ss7tIF7OIlxsH6BxKc4TBhcC8OZjo/Ep7IC9dXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(44832011)(5660300002)(38100700002)(26005)(83380400001)(6666004)(107886003)(316002)(110136005)(6506007)(52116002)(6512007)(2616005)(4326008)(66476007)(66556008)(66946007)(8676002)(8936002)(41300700001)(6486002)(38350700005)(478600001)(966005)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJZdnFTM1l2VGZSb0pubEhQMWo1UlVIK20wTFZnNk9LYXNMNDFtMWcrVFdS?=
 =?utf-8?B?TmYxNitGcmh6RlZ5RExTUzc1Qjk4OUJoZTlaUm9xdGtLTk1uUkVQcnFray82?=
 =?utf-8?B?ZHFiTXZtbHlsT2l3cW9mL3A5NzNPSzdPd2JZdkk4bkx3ZUhxYlVHRVJXM0wx?=
 =?utf-8?B?US9qeTlhbjdhVWh2VGNyVmZDMTRySXEvV0NwMXJNVi9hK1V6Q1VyREVzWUxP?=
 =?utf-8?B?Zk41eTVOaytCRjhTbzg0Y3c5ZFZVYnltNThHNEZwOWw3TjYvM3VHMGxVa21I?=
 =?utf-8?B?Vno0VFpwZTR6dVpjcWM5bmZBVGN4L1pUaEpMeDBDWjh1ek1MMjJ2a1hlVEtt?=
 =?utf-8?B?cDlwRW1ENTdtYkRaREpOejZJem1oVldiNmJITG5aNlBVU2lYcUt3Zm5GUVli?=
 =?utf-8?B?ZTNCMFhNa0RpZ1pOdCt3c3djWXJra0lEZjNrMEVOamk4N2hZN2xMdnZ0anJR?=
 =?utf-8?B?aTZwY2VJNzZOR3JNbHVnM1JBZ3RmaEJzQmNmblRtWFVjOVYvVlZmdTZHRVJO?=
 =?utf-8?B?SEdiM3gwM2l5QVVJR3NlMlVmakJwbjlHckEzalk2MFRNdWtzaDU1Qk84cGRy?=
 =?utf-8?B?dnZ1dWptRUZSQTc2b2dTeDBoakIxL0ZCNGlnQklXZXhCakxxTGxMZEtTUy9V?=
 =?utf-8?B?WnBOWDhzT1hTeWNqQ3lubnRwMFJjYTFlaWFWc0E1QlhPME00NDNqRkJxaFdZ?=
 =?utf-8?B?a0hiQ0VMd0ZLaWtndFBVMS96Y3hLalVJWGNTd0doOUtUZmRMSThQNVRlZURq?=
 =?utf-8?B?N3ZVdmNiZDk5bCtjeXJRaEg3SnJJUU04VzZZYURmemFVbU1mbVVGc2RwaHJh?=
 =?utf-8?B?bmhFSmIxSWg5SndRQ3MvWjV0WFJpamFhRGVWTHRrU2pxK0Q0Wm41dnFSelJN?=
 =?utf-8?B?OFk2MjdkWHZuaEpZSUhaZTBtV1laUHBJMXQ4THhMaEtZWnJBYk92MzN2ZGtQ?=
 =?utf-8?B?SnJrZmpHVnBlNS9BeHdxTWllcXRoZWU1QVBOQzlrczAzV1pOYk40NXVaM3pD?=
 =?utf-8?B?dk1IVEdoSjRLVEFxdmZSMDUyeEdsTzJwR3pXYnY0RytmbHNueTNBcjJQb0cz?=
 =?utf-8?B?THhZZUVyZkw2VHhHbFdCK0F4MjdsajlROEJmdWJONitjRlkxUUduTm14M2V5?=
 =?utf-8?B?UGI4a01WYkh4eFdla3dXQnZzVzlVYVpkUTZWeUVIeHhQY1NkY0Y3UWVOeGRC?=
 =?utf-8?B?MEhtakxJY0xoZm04TTFrWm1VN2UrbTFKOFJMUUNaaEJHajVVVjVlalA2YUND?=
 =?utf-8?B?K2xPaVlQT2ErV2JudEk2dkhVanE2OG04VEg4ZVJ1UjBEeE1pUUhlcGJyeEFX?=
 =?utf-8?B?S3l3ZmFkS05BZWZzTzdianpGWU5ISW1SNzQ1UUpFRXY0WFVXS1k0ZHdMeEpl?=
 =?utf-8?B?bjNBaTFaOS91SVhSVXQxRTdmRmNjSXlYNlNsb2VyS3FEYUpzOEhOZFJlRFJY?=
 =?utf-8?B?eUszdk44UzI0WGd0MlN1Y2VzTjRpQkhQN1NxSTNIR09ETmhjdDIwYy9hdU9p?=
 =?utf-8?B?bEdGa0g2MkxKdVkwWEFTbjZBUHVXK3VwUytTR0pKK1I3bER0M25sK1VuQmxm?=
 =?utf-8?B?eVNNNmdiSzhqenpBWFBJMEdzV1FNRTFBTm1Scnk1aXVlN0xRSnp6L1lCcEVi?=
 =?utf-8?B?ZDVKcmZGZzRYcnFrelRjK3c5Y2Nqblo3a0pjQk9FU0cvdWx2Uk4xbEZUQzNY?=
 =?utf-8?B?R3ZVLzEvVG11b1FNSmZIaWVrSXBuTW5XU0JQU09iODJDU1pDUnJEVzRXeFFV?=
 =?utf-8?B?Q0pac3N2dzE0cjdyYXl1d1dHd0poQjc4NTRkVVJ6YWpCQnVLNHI1SU5lY3hV?=
 =?utf-8?B?elNpQS8ybVE3UGdwRXZrekJzYU4rQUlBcmM4a2RGTXRnVlJuaFo3bEJ3ejg4?=
 =?utf-8?B?MXoxYTlFQ0FSNDk2U2pCVUU2UHdReUtUUVhpRTltQmFQL3VLYWEzT01zUkcv?=
 =?utf-8?B?cCtoclhrTXBrTnlhMkl0UVVwSEgvekRlcTFQY3A1cXY1WG1ML1F4VXdoVlQ5?=
 =?utf-8?B?KzE3VHE3TndScEVHNFVOMXB4YU9vcU5KS3hVRWtiUllIWlBHbC83ZjU3MXJW?=
 =?utf-8?B?cEpBRzhveThNdk1xWXNLQkh4QS9FK1ZNS1ZvVEdvNGF6alE4eUwxTUNMZVlE?=
 =?utf-8?B?aU9Mc2U2NjlHSHFwQVVWMEQ0R3ROUGNxODNEc2ZsZHZ4UVBBdTdmY3VEaC9n?=
 =?utf-8?Q?UYqw8nCqu2fkkmgqs10bM3c=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e365d475-1554-4234-372d-08dbec3a16d3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:37:23.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8elQIEjUyRMlYtYwWlJqNTa8b+53qZ52eOFb7o2+nCBR+Ltu4Tv4ZKqb2A7n2Opk/nS9IeQHQPqh1G8qzdeD/arq6pJkVw819W8/Cjev218=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tipd/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0e867f531d34..014e15f29629 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -8,6 +8,7 @@
 
 #include <linux/i2c.h>
 #include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/power_supply.h>
@@ -64,6 +65,9 @@
 #define TPS_PBMC_RC	0 /* Return code */
 #define TPS_PBMC_DPCS	2 /* device patch complete status */
 
+/* reset de-assertion to ready for operation */
+#define TPS_SETUP_MS			1000
+
 enum {
 	TPS_PORTINFO_SINK,
 	TPS_PORTINFO_SINK_ACCESSORY,
@@ -119,6 +123,7 @@ struct tps6598x {
 	struct mutex lock; /* device lock */
 	u8 i2c_protocol:1;
 
+	struct gpio_desc *reset;
 	struct typec_port *port;
 	struct typec_partner *partner;
 	struct usb_pd_identity partner_identity;
@@ -1190,6 +1195,13 @@ static int tps6598x_probe(struct i2c_client *client)
 	mutex_init(&tps->lock);
 	tps->dev = &client->dev;
 
+	tps->reset = devm_gpiod_get_optional(tps->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(tps->reset))
+		return dev_err_probe(tps->dev, PTR_ERR(tps->reset),
+				     "failed to get reset GPIO\n");
+	if (tps->reset)
+		msleep(TPS_SETUP_MS);
+
 	tps->regmap = devm_regmap_init_i2c(client, &tps6598x_regmap_config);
 	if (IS_ERR(tps->regmap))
 		return PTR_ERR(tps->regmap);
@@ -1344,6 +1356,9 @@ static void tps6598x_remove(struct i2c_client *client)
 	/* Reset PD controller to remove any applied patch */
 	if (device_is_compatible(tps->dev, "ti,tps25750"))
 		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
+
+	if (tps->reset)
+		gpiod_set_value_cansleep(tps->reset, 1);
 }
 
 static int __maybe_unused tps6598x_suspend(struct device *dev)
@@ -1354,6 +1369,8 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
 	if (tps->wakeup) {
 		disable_irq(client->irq);
 		enable_irq_wake(client->irq);
+	} else if (tps->reset) {
+		gpiod_set_value_cansleep(tps->reset, 1);
 	}
 
 	if (!client->irq)
@@ -1381,6 +1398,9 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 	if (tps->wakeup) {
 		disable_irq_wake(client->irq);
 		enable_irq(client->irq);
+	} else if (tps->reset) {
+		gpiod_set_value_cansleep(tps->reset, 0);
+		msleep(TPS_SETUP_MS);
 	}
 
 	if (!client->irq)

-- 
2.39.2

