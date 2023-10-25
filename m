Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687F87D71A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjJYQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYQWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:22:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BE691;
        Wed, 25 Oct 2023 09:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK8zV6UM7/b0uD/de1z9Q9Ol3fuyQam44pj4vNTsl4OD7bo8tpbNHB2oBeTFrLSnajPLK56hJnpgUQvTYyfHIQxjmWjEMU6LWJGcDtBGnDi2mO5GhwAc4jHFv12fXJ8GRBYBfuotuuiPiSPD9+diqHi/N2X/67lcsuJUuDgc/53jUtFepqlA+MeOuxBmdnXQ5BjmIKtlagK9ptP6RZTqSBdQSMcHNxpM3CaGa8g/4cSd06LTdmIFke+xIvORucLvc7N2zD+pAju6iaHP+fapSHPOcyGdv20rPc6BbSj9Wgplw7gYS2anDUPR3ovFKces/dazk8ccOBGVe0f0OeByEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhnIsREnNliGjRhfvQxTajFTEWoDQVcts8ho7zL724g=;
 b=jAWD+7fF5lzc0GlqhKOcJJA+hTgCwLhNizr36XMjpdsy3aNPpc2J9zJcGVayNqamrKF+F+kWf2SOArIbyUxs9JRhO2Fz+Vug6JatQuJffP8hbS/rfmheJKpu3A62/NJJqvdCX6bz0uX3ONzZATrjoUOgPQzm4/nzYDihalqwjAHhxxXmX4bcMYyITp3ZHhYv/m1IB/gMbiXg9pEayfA6K8uWRIqFxOHAFNcwmSK7E7qvLRxPC1R7fSFj2kj5W30oE77h6RDDHm6Pbx2WuXon3yVbTHrYApY92156lx2pkI9FlU2vysY5QTEHQQsvicqSuY9A6XcuSaTAW61GQJ0P/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhnIsREnNliGjRhfvQxTajFTEWoDQVcts8ho7zL724g=;
 b=SGAobYfq1kMFWIOD30ZM3Y3SWc3T+sYwjN1nHboWkZRTQ0CQAz5UDNr5FW1U1Pc/NQK9twAdBezqTFzp4Jo5OjDNtUKDTABg4LY3aPjqdaKnRuYOhJBnC1YWVIxrXgoaITgfzGKC+Dwu7oPen+TWm8GnON8ZK9fjAaD6CQij+c8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB5376.eurprd08.prod.outlook.com (2603:10a6:803:13e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 16:21:59 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 16:21:59 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Wed, 25 Oct 2023 18:21:54 +0200
Subject: [PATCH 1/2] rtc: pcf85363: add support for high-impedance output
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-topic-pcf85363_hiz_output-v1-1-50908aff0e52@wolfvision.net>
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
In-Reply-To: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698250918; l=4421;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=FF2xr2kA4qsEIO3Vzgxe9YV6LCFr1AZBTHkk4R/7HSw=;
 b=NL8dEBmMmFEa4v289RMS3qED08d9Bi/PNAHgRlAgMm560xhjgannG3JAEDYQksbycB7EpeQ8j
 hlUnaI2kB/ECNODS+DQ7m8sHctxJ4H4LsRTmEYmU7SFc0YocF86r7+Z
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0639ebf5-d03f-4861-eb3e-08dbd576835c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNPU7U4Qokf4T1lG2mY4jY88P9ro8Kb0SVymhKYqMnTG0QG5vR406H6Za0eCFFYJSRaVRwGT/SoVDv40l/hanWuvVMFctjgTJocZlFVWj3B+KlaN+RXsJRSg1Pwcsuzj+4R2FE4w1rKob9jQjj+mE3x0MZJwgTCUkZF8Mk7zqSk4q9nrtIXe+2dDRsg0qiXGeHIcFn2loZAeRS6RnbLAo3AL1xIq86NMXdB8CsHuJr+03DRSpjGa7m/XEW9HaLcI98I/VsMOeWfRsOTTIjDHIr717WV+0BoRCFAxzUy2qV9BMjJgQ23FsWBWXJxMLDiIPlgaTmvoek8esbyY2/ULla50MsBOMMbrcy3DRXlTFACBre95oVfe9mVZpfwFx0+y0+mQ3RZ5q2xbOEyaHPD7MwxK8D3d1uP9eGPV6/2ePa6J4OOnCGeohid0BuX53ATcfs+VCpVOMDwRm59kfHHPwgH+DPme1VN9CmN4B5hpfI+SaopOPh2RkMtc4x+Z4GbmMVq8RMk/naGuLFm6FGHKO1rCzBReITGNRcVW95CyLfLagEvvhYyC9bRgzTAHrY/yZqNtphA8LEvV5rIwr+GvsdeuWt5yiEc/vjH68XNztwwc1TgrbPzYs8xIiPsv40U8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(4326008)(2906002)(8676002)(8936002)(44832011)(83380400001)(6486002)(107886003)(52116002)(5660300002)(41300700001)(6512007)(6506007)(86362001)(316002)(110136005)(26005)(478600001)(6666004)(2616005)(36756003)(38100700002)(66946007)(66556008)(66476007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVzb0tGb0dVWUdvZFFvcSs3cFcySVlqUE5wYk85SzUzUUd4WmtTbnZxN2hO?=
 =?utf-8?B?NGdRT3p2ZHJGOVNGei8wT0FIT2hUQ2VvQ3lkdzBzZHNTMTZDLzEzOCs5Umsv?=
 =?utf-8?B?NGNKM2RNQlI2OEpnc0FuTkJXNzFoVEwzUGVJV1NySmVrQVoxU2FrbWdpem44?=
 =?utf-8?B?aUVwRUJnVUk1THBCV2l2eURJRFFYZ1kyekZHaDQ1emtMNXFnYzBsckVoY0hz?=
 =?utf-8?B?ZlgwcGNRcHVHRXBubmNpaEQ0b2wrcFluaGQxcmQ3clpkTDRVbEhPZ3B5TFI1?=
 =?utf-8?B?VDBGNXdsKzc5dlVrVzYwcDBZQllNYzFoRDlGR3ZZVE1PSkJFNTQ2alJQZlJM?=
 =?utf-8?B?b3JoK21ZaXl3eUE3NStGbVdqNTVpQlRiTThGL1VvbC9lTGtEcFJRdTVKU0c3?=
 =?utf-8?B?S3N1UkFxNGw1UzdRZXAwOVNsOFh6TjFCN3hDbVN3bzNJaXZ2WTVGSEN2U2Mx?=
 =?utf-8?B?T3M1akVBOHhKT0JTT0V4SmREdTVKMEg0SlFJaUQxRkhScUNsRTNIeFFlZkl4?=
 =?utf-8?B?a2JUNGdQNmhnQVhCMVlya0hUUTMyU2tDV0FMb3BWWXFhUG9RbFhGaUt6QW9V?=
 =?utf-8?B?bDByenJxMWJtZzNZYm5uaFl2a0hCWTlXQnJvYlJ4cURYNzg2NWFWMmNma2Fh?=
 =?utf-8?B?ekRvOFJZNlRPOFVuOU1pRVBuR0tNS2ZBbzEveFdzQStNWjFvenNnSHNiTjlo?=
 =?utf-8?B?NktyZDRVU1NsM1RqcUxCV0I0bW1RUGd6VHFBWUlmWGE0YUVtRGJlTFdZU0Ux?=
 =?utf-8?B?WU5VVWJHUmM0bFYzbndyRnVZNzA1a09NenkwazlEaWVhc2tyZzRSajRyNklU?=
 =?utf-8?B?U3drS2U4Qkl2ZENnWFZ1aW1tRmtpaGdqaEs3b1RNU1NibnNGVU4xSDNqSWt1?=
 =?utf-8?B?bnJHL0VJeVdDUjkxSlg5Y0sxQ1NzbTZibTZXM1ZBZWxtY01NRTJ2Y0FtZ0x5?=
 =?utf-8?B?ZEFRWlp2MjMwU1ZTVmxVZlBYSnM0MHRqK3FwZUFhUTlRY1d1NDNRQitKM0tx?=
 =?utf-8?B?bGkvUnNxbTFkUEI0SFUyS0tyd0ZacDg1Zllac1lYMHhpbEo2aC9vZXlZeWxR?=
 =?utf-8?B?VFlPKzdiOWw4VlRXaWJTVERHdkNRU0pNQWRYdk9SdWU5V3dLQ1h0NHZEMVY3?=
 =?utf-8?B?WlhFZGUwWmhwdmZHckYzZmRiV3RzK3dDQ0t1SnoxUUZicWVuMmlzZlpqbG93?=
 =?utf-8?B?R3JQRVd2ZDhXWGJTM3VYV1ZIOGFQZUp5SGcyTnZFTlQ4L2VUejNEc3dXNDRH?=
 =?utf-8?B?RE1jdlgwQUZsYzZWandBT1BPWFpFaHhZUUV4ZmlsTGV6SGpCNWM4Wlhjdzc5?=
 =?utf-8?B?MFdzdktFalRQNHB4Qm8yc3Urb0VzeWY0NTBwWGlEOWpqcjBtMkZWUFQ5cXly?=
 =?utf-8?B?cHVyZGxZQmdjdDNLR2hsT2RDUHc1RmdCd0ZWQlBsZmc1MFl6UkREaVl4YWIx?=
 =?utf-8?B?RkdDa1hqUFZCS2NYbHdkaUNYZnA1eS90KzFQRzMrWkpGakFuaDBUK1RZQlU5?=
 =?utf-8?B?VENEdEFXV1VpclF2WWJLTnFBeWZ6YUVYUHRubUpvUTVZeVhRMWwzeVhiK2ZR?=
 =?utf-8?B?RUVFZVYxQWU3ZVRyY1JGM1NKZkIvbkhhcjk0Tm5Sb3BmV3N6NzUrZ3Z1RXNX?=
 =?utf-8?B?R3BaYUJJR2ZnSy9saFRKcno5MWpESzRnRldiZ3BTcm1HeUFXUm9wWDh2U0NW?=
 =?utf-8?B?Yi9jdEJld1lLTm1jY3Fqb0tvUUdjTEdJaGNWYXJtWEFsVmMwMVpPQ3NrYVlm?=
 =?utf-8?B?blVoV1QzOXRHTDFwR1BCdjhzdE5ZYWxEb1FnS1FhYUpmSmhTY3VMSTBKRDRY?=
 =?utf-8?B?ck9ENTVHTWMvSmJaeTY2MFlGQU5ycUxZVHNuRUt6Nnd5TUFValpuVkJDUDFQ?=
 =?utf-8?B?LzJSZ0lSWEl4Q0FrWFIvUnpqaDk3b0pyQkl5VmFOYWdhM3RCaVRWZ0ZuOUR5?=
 =?utf-8?B?d21Sc2ZqeU9aSFhxQ0phL0x3WUhXMi9iVFJObzNsS3R1M2xaWDJQaTRpenBw?=
 =?utf-8?B?WFdmUHJyN0k2ODVkdWRrbmJydTIvSUdXMXZQMEVDL2hocXYyMEtQa0Zpc3Q4?=
 =?utf-8?B?aUpGaE0yR2ZHZEFLdldxc3RhRjREaXp1T0JQQ1RKSjlKbng5QXRwTHZWUGpu?=
 =?utf-8?B?R3V5TzVjdUpzTjlWU0lxODFGaFZvM1VNNnNKcDFGLzBLbnpjNjFya0hpUTVx?=
 =?utf-8?Q?ZDWIDpBbj2xaJSSgUoDtMgM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0639ebf5-d03f-4861-eb3e-08dbd576835c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:21:59.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qdMebzrFqtiDZjmdTNRqaaZ86wT+56JpaeffBw2ebfgfIF/3t0LP7JD82dKN10IWGa6Mb7pxkTaLDHngqZs1WYnfpI4QOe1fbeKmpJUc/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcf85363 provides a high-impedance (hi-Z) mode for its output. This
mode can be used to reduce power consumption in applications where the
RTC output is only required as a clock/interrupt source when the system
runs in low-power mode (i.e. serving as a clock source for a PMU when
the system is down). If the output is not needed, it can also be
completely disabled.

This implementation adds support for a hi-Z output and also uses simple
pm operations (suspend and resume) to switch the output mode from hi-Z
in normal operation to the required operation mode in sleep mode
(currently either clock or interrupt) if the "sleep" value for the
hiz-output was set.

In order to make use of the hi-Z output modeling via device tree,
check if the new "hiz-output" property is defined and set the hi-Z
mode accordingly.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/rtc/rtc-pcf85363.c | 62 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 540042b9eec8..82eaf8de8b33 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -110,9 +110,17 @@
 
 #define NVRAM_SIZE	0x40
 
+enum pcf85363_hiz_output_t {
+	PCF85363_HIZ_OFF,
+	PCF85363_HIZ_ON,
+	PCF85363_HIZ_SLEEP,
+};
+
 struct pcf85363 {
 	struct rtc_device	*rtc;
 	struct regmap		*regmap;
+
+	enum pcf85363_hiz_output_t hiz_output;
 };
 
 struct pcf85x63_config {
@@ -403,6 +411,7 @@ static int pcf85363_probe(struct i2c_client *client)
 	};
 	int ret, i, err;
 	bool wakeup_source;
+	const char *hiz_output = NULL;
 
 	if (data)
 		config = data;
@@ -433,9 +442,32 @@ static int pcf85363_probe(struct i2c_client *client)
 	pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85363->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
+	if (device_property_present(&client->dev, "hiz-output")) {
+		ret = device_property_read_string(&client->dev, "hiz-output",
+						  &hiz_output);
+		if (ret)
+			return ret;
+
+		if (!strcmp(hiz_output, "enabled")) {
+			pcf85363->hiz_output = PCF85363_HIZ_ON;
+		} else if (!strcmp(hiz_output, "sleep")) {
+			pcf85363->hiz_output = PCF85363_HIZ_SLEEP;
+		} else if (!strcmp(hiz_output, "disabled")) {
+			pcf85363->hiz_output = PCF85363_HIZ_OFF;
+		} else {
+			dev_warn(&client->dev, "Unknown hiz-output: %s. Assuming disabled",
+				 hiz_output);
+			pcf85363->hiz_output = PCF85363_HIZ_OFF;
+		}
+	} else {
+		pcf85363->hiz_output = PCF85363_HIZ_OFF;
+	}
 	wakeup_source = device_property_read_bool(&client->dev,
 						  "wakeup-source");
-	if (client->irq > 0 || wakeup_source) {
+	if (pcf85363->hiz_output != PCF85363_HIZ_OFF) {
+		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+				   PIN_IO_INTAPM, PIN_IO_INTA_HIZ);
+	} else if (client->irq > 0 || wakeup_source) {
 		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
 		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
 				   PIN_IO_INTAPM, PIN_IO_INTA_OUT);
@@ -474,6 +506,31 @@ static int pcf85363_probe(struct i2c_client *client)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pcf85363_suspend(struct device *dev)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+
+	if (pcf85363->hiz_output == PCF85363_HIZ_SLEEP)
+		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO, PIN_IO_INTAPM,
+				   device_may_wakeup(dev) ?  PIN_IO_INTA_OUT :
+				   PIN_IO_INTA_CLK);
+
+	return 0;
+}
+
+static int pcf85363_resume(struct device *dev)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+
+	if (pcf85363->hiz_output == PCF85363_HIZ_SLEEP)
+		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+				   PIN_IO_INTAPM, PIN_IO_INTA_HIZ);
+
+	return 0;
+}
+#endif
+
 static const __maybe_unused struct of_device_id dev_ids[] = {
 	{ .compatible = "nxp,pcf85263", .data = &pcf_85263_config },
 	{ .compatible = "nxp,pcf85363", .data = &pcf_85363_config },
@@ -481,9 +538,12 @@ static const __maybe_unused struct of_device_id dev_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, dev_ids);
 
+static SIMPLE_DEV_PM_OPS(pcf85363_pm_ops, pcf85363_suspend, pcf85363_resume);
+
 static struct i2c_driver pcf85363_driver = {
 	.driver	= {
 		.name	= "pcf85363",
+		.pm	= &pcf85363_pm_ops,
 		.of_match_table = of_match_ptr(dev_ids),
 	},
 	.probe = pcf85363_probe,

-- 
2.39.2

