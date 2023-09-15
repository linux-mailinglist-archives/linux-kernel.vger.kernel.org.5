Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3917A167A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjIOGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjIOGwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:52:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A18A2716;
        Thu, 14 Sep 2023 23:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo+PgHGr2ph5y/kZYeBvwZcj0rydPuyysN6FDcvOzcn8LtGJkzSUgJivQvk0fV4SqRgADRCMqUKK7s3v/VcdxBj64auxhb+aX+qzJ80Cd9nqvR7lkQemRLfm/XbixTAxaGlS9eJaxp3wk8r81ys2Ka/0QZmRt0eOomghpzseIWmMyzF+ZCD7rw5myqLSCTnUBGjXsJcenUaetB0DVkS24aTiJ6ydDqTpTgkktMqEMXLlvxW22aNKe1JybcQS93XTH0m4dVTLsIZWwRg2aYJaSiOTPMXYVE6RmAm5em2HhXqXDvtrI+d7tBImsSbUyJWC3aGvWLjHjeXtbDRTECVhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vfS5YpyxmiD66WrZrkniGEVIkCVjT0hD8nQSQTqroc=;
 b=CP3QYdtfJgZ2yjf3IUVkNRU9KP4cvwMSUEmnezQDQIu8/iunOX6O93eZ+SLPFqtFPa2oW1ZG5e6ZzkjJ4vdoSmm40x1PZek2ZaI6lWqcAppB/n7owUOgmazPKzxzAjA54wF7W4t8bN4ZWVDI7+da8O8S5ldh1WlVsLAbLYUKGY8/I+0QnfvFekdanlRDqS68RMiP+bynRPtGMuDKhreSmzrD85MQsgyE9Ht1lD+qOUsfvDDdWotO46jo6SuRqqumcChMS0hzAkK1bjUgaORrqQUTyIicdDFuihHpBn6/mR+ufO30h1qCy9gMK3nL77FvLoomcHcjMm5op6QHDhFNlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vfS5YpyxmiD66WrZrkniGEVIkCVjT0hD8nQSQTqroc=;
 b=kXxj1PNhy7H50nXuvmtJ66k9q7lnfh6ZUcxC1/zAUnkC1b7+QB3Q1F0Hf8NfU5Izt56Yp1yjoO9jFQH9qaSGPz0NK5QUyXGtgyMYPXibrWvGeXzprSNN84qOgvQNY7bREPDBNW50culUQd4jxL6ffP1En8XSlIwl+u3/OG4T45g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB9322.eurprd08.prod.outlook.com (2603:10a6:10:41d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 06:51:54 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 06:51:54 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 15 Sep 2023 08:50:52 +0200
Subject: [PATCH 1/2] usb: typec: tps6598x: add reset gpio support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-topic-tps6598x_reset-v1-1-78dc0bf61790@wolfvision.net>
References: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
In-Reply-To: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694760668; l=3283;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=gSmzjlh8KOJx1IoqMs+6APAdn+wiS1ECkMChs9brKfw=;
 b=b7LUIm/08xuhK9YkTXoxEo3spOKggkmRoBC9vYIsJb2NQxTaNnKub/OBGugwgUlRV6cOG6imI
 EBK2fzFGjzsAZeUAeOyvu71yIGY9AvTWij9XYH2drw2vag2AAjHVWID
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0296.eurprd07.prod.outlook.com
 (2603:10a6:800:130::24) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a7b4bf-0bf1-4a5a-3cd5-08dbb5b8252c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLDYA+oJSxopnAODPCfxazJkSoB38z3/Q737IqFiVeWeAWbGkFsZwInOu58/vRR560C2b1/KHTVYZKelUaYVMj+AhkGcTHeF3SJPISHWbTRdKROHM/Pyg9McQqV2oCBr8R2UNaclh1q2TUum3BCthMbbjtpChNlGRVIK2BI5WYpt/jMErn9YrQ+A0g7ATzDFoAeVL3ZcMSXqSLI8dtmJbipDsdjHXTv5gnSmNPfIYH6+VkgEaw0WnWBrRrr43vBGKU7kKP/f+T0pNziO/UKYk4mtNN92bO2iifE3m/F5JEK82jLZQE84l6EeHDTaH3mt8I1MgKk3m47CxBwstFJLY6u164udHCUa/g4Waj1mf3bxR50iVigix+nZg2+ZTn7T2A6O2qoTUQeAshx0R1ufg/AcWDpRe2LEOMnmWG/Djz+TqwzYKoZ+Cbv/eMJG39mbEP0dSRnMreVHEFaHXf+LCHEbR59VxK4SOCMR4sdHOOxpXKK+HyNJ5Oz9Fa2mEyVeq28TmWjV5UBm17JTeT36R5LILupwyk4Ria797gMKj+i4XawU9neorNTaN/iFxp9WGJbBlHmqr/UdkLlFWo37hXJTY4qs7PN5okdtMpuzj2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39850400004)(1800799009)(186009)(451199024)(110136005)(44832011)(316002)(26005)(66556008)(66946007)(107886003)(83380400001)(36756003)(6486002)(52116002)(6512007)(6506007)(38100700002)(38350700002)(86362001)(2616005)(66476007)(966005)(478600001)(2906002)(4326008)(8676002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BiUkpmSC9WSExnWkZ5c241ZDU0Q1p6QUE2WXpRaWZCaGJTY3E0NVRaYTlW?=
 =?utf-8?B?cnl4Z0pObWxqcFRldEhoVnRaRS9LTk5pVzVWYTFsNkpWOHF2VVY1OW1vUzAz?=
 =?utf-8?B?ZExGU1JNRmxNRERlZDd2R1RCK0xNYmtjdGxoNjBKODVSUXlQNkJHMXBtTzhm?=
 =?utf-8?B?eFdPZDU0U0hqb2kwTnpQay9pNVhVV2dYQjE0dTFOUlRXMjRNajU4ZGxnWXA2?=
 =?utf-8?B?LzNKRTlHZVM0SUNMMXpuUlVoNjVCN0gvYnB1R0EyaC96dWFQSHZ1RWdnL3Rx?=
 =?utf-8?B?L0NHMllFTW5paTVqMmROUGRtazBLT1c5WnBoaXNWOTVvR0gyb1E3UGtGQ0hJ?=
 =?utf-8?B?ZGl6NE1UaFlBWWQrM2xpNEVqc1paZy80Mzc0cUlIVVRWK1VIM1NiZkt3TVNO?=
 =?utf-8?B?aHZrWFF4c3RleHpZMHRZR0l3dnNRYS9jSStVL0htamZROXJTWlFRekpOREdr?=
 =?utf-8?B?bkdYaG11NFBaYnpiWUdKMWtsVTgyMGdCL3pCYy9GUzU4Qk40dm1la3NtNDUz?=
 =?utf-8?B?WmpjS3lOQ1l4T0ozVjF5cUNmMzVLNEJ3MU9DSHNmTU1EcWhINEwrSEppQjVR?=
 =?utf-8?B?K0p0RTR5UXV1K3dCMndYeXYyeFVhek1YVXBNS25XMzNzSHU5dlIrNlVER0to?=
 =?utf-8?B?NktLRDVoVlczbFZtcnpDQ3pRdzRUT1hvSk03WUdpMkk5WUJnWUxRRUs2VTlO?=
 =?utf-8?B?OXVZdzhTWkZmalJEMTI4S20yV2dLaGhBYTNIM3FhVWMreTlLQkRTajJkaWxE?=
 =?utf-8?B?dExxQWJiMDVhWDFDZWUwZ0FMdTlrZnVqTkJFbTBaak11WnNOMnRJRE9WZUJN?=
 =?utf-8?B?c2JjUEY1dUZLcnd3Z1BKZ2hkQ2FXallmZTl4M0xtZ3hRcmtqU2Uxd2dFdTJo?=
 =?utf-8?B?RUgvTnJwQTdDWnFTeFROYm1wblQ3VHJMK1A3bDZNb3FlbzJqOUVNdzlPaG0w?=
 =?utf-8?B?NkgvK1JKVU9qRTdrSDRmeVlUNWFmbHhMTm80RnQvNVR4MG5sUEtvOGhMdjVa?=
 =?utf-8?B?eVNMeXVNVTBGSHpYTzZlblZKbU93RXM1RE5aOVA0WTJ5M1lHTGVTZzMvOGx5?=
 =?utf-8?B?Tkp6RWMwamtwMktXM2gzYnRsTitwM3BsQWVZSnZZWFlqdERlZk9wTHQwaEtz?=
 =?utf-8?B?NU04UWpDa2drcmVDdGwvdWI5eFdjZnZsWENyMGU3d011akZEQlR5dXJYVjVr?=
 =?utf-8?B?cnFtd2tWZzJCUUhScnEvdld0UExqSWdrZ3NBbk00SUdiTFNhdDJZSFFhR0ty?=
 =?utf-8?B?YUxlSXprdDF2TUpTVmtzWlh4b1JUQURxaDRvR1ZCS1JWMWJUS3QrTzJ5dVQ2?=
 =?utf-8?B?Vll0eklQZS9DS21ZT0xPYjkvNGVqeEYzOXY1dFBsQjdXZ2tWcjZNMTg1MDNO?=
 =?utf-8?B?MWdwT3lmZ21FZ2Q5VFJrZmNpSkRiVkxjbWdVdnc2algra3d2YVE3U1lWS1Bo?=
 =?utf-8?B?ajZLRXRWYURkUkk0bUxzQ3ovTktMOU82UCtKQnNBR05Bc0JQMDRwaDhXaE4r?=
 =?utf-8?B?UEVNRlVBbjdkc3luZ01PYi9ENzdJTXFmQjJya0FMSEpXZGJmTGRaZkxNNjZK?=
 =?utf-8?B?WEdrTmlZTFJMYTNqVDhwMlVseUoxQUM0SEZ2WFNYaHBQY0tNMVdXSTFiRkVv?=
 =?utf-8?B?Y2hpOU9lOExVdzRIWnBidHFpdVhiRlRCOUJwWEp1Y1N2aVBSb2VodHFiRFZz?=
 =?utf-8?B?eXpYNUZ2THZmUDQ2c1NOTGlObDRNUEFZRnlWRDN6cll3N0xTZ3dsZ0graXVk?=
 =?utf-8?B?UkY3ZERpNEFWd0xHcjZaUDRrcUVFNU9TT3NkTXV4ZlRIN0VOTFBSU2ZVNUc4?=
 =?utf-8?B?R2l5bVBRVU1FaS9CUlZCbWhONG5DMzdnVFlJNVNyam1CTzA0R3diSmJ5VVpF?=
 =?utf-8?B?SVVCNWVsSlZLUE9GVjZCMWdwSUZBclVJaUlEMFNyVHF2ZVBsamV6REl2UTBT?=
 =?utf-8?B?OGZQc2RFeHYvOHJURFNyRUtEeDRScDZIVm1YYzFsaW5UZU9uWWRmbkhNMGNU?=
 =?utf-8?B?dUhYVnJ3Mmx0MUE4UUJhMHZ6WkFveWVDK29XRkcwL2lDMGNIVTEyd0pvSlBL?=
 =?utf-8?B?YmFmWHB2S3RrVzZGeTNEdmtXcmtZVHNMTk9uc3M1RmcrVUE4N3gwTjNicnJB?=
 =?utf-8?B?cHM1OHduNE92VThYQzZpWnI3cGZXRVZTQmVXTzVtY0Vhb1dKaThYSkpZVGkz?=
 =?utf-8?Q?m7GB3iSYQfrqBoyTdYTrjNU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a7b4bf-0bf1-4a5a-3cd5-08dbb5b8252c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:51:10.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63arxPl/sUn2qCkSU2V/IkFQ7xSl62F1tE2vYm4HoqebaxdKRiokQhLr/YuQr5poJutKXZqRt1/9psTrcqOBVsQmDlraX/z2hlT1OUmhWvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9322
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
---
 drivers/usb/typec/tipd/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 37b56ce75f39..550f5913e985 100644
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
@@ -902,7 +917,8 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
 	if (tps->wakeup) {
 		disable_irq(client->irq);
 		enable_irq_wake(client->irq);
-	}
+	} else if (tps->reset)
+		gpiod_set_value_cansleep(tps->reset, 1);
 
 	if (!client->irq)
 		cancel_delayed_work_sync(&tps->wq_poll);
@@ -918,6 +934,9 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
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

