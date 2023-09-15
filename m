Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5027A201E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjIONrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjIONrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:47:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEAF199;
        Fri, 15 Sep 2023 06:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRMw7YXGkhWLBoItlGrLCosjgKQjB8sBreBTg2mxxxViJkS8R98OFvIUvvPaIAB/bZH8YAOZpxwHRgxSNaMDV2V/kKotE2UKa847/hy/mEbJNmrdvY4MG/WkwjcBa8D04DdFfgHIXK/gkn7882LFRc8NijumDDoe9FD9KW2tEpVbqa4xKQPhsifZFZX8Mf9oRRpM0BFrYyHLWXfc4FzsuyVg07sTxxB6W8Q/0hLyr/KDYziBWXlBHaPqg6PO9AAfhUvaEa3TapIHIFATP9aGARF23S+nnQTpOauED4em6LTptFKePTaaWQhwkChGxZhkDVawDsOgdXox8IOrUxDt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lReSXGbbC34JLXpYp7jXhMtGRLzpp5PiAqJ8/ESOhf4=;
 b=KlVswHly68b8ed+5ELwA3tCo6TBLSSS8uBknhgiq3Lvr1TmQNCKdiH+bi7x0oGosjyElgGJf8FwbW5HL3cFyvzL0A9sliZ0rYEV3CcUInn7DnPcAYnsVgkwpNPly6CF3lbAcFzBtq9I7o8OGSZk95f6MMWK0ZStZc+iqmm00H/7rsUHHw586IqdBorYV5kA2bCVuDR36JkYgf8U+wZKzzSNQ+Mqqh1pGcsRxBX1YyICkPncHpFO/GLu10KMpNKtWlpWzhWKMby6PRBd4zz73S4HcPQd09yi1OVT4GVANlDfnCN5mKWdE07vJgRpqBWhSluF029ptoNQmhAqSqXg4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lReSXGbbC34JLXpYp7jXhMtGRLzpp5PiAqJ8/ESOhf4=;
 b=fKM8bPPGWALHW3sYPNQ/g1vK5NHPttcAp4xKhf0dPWwqsItyklxqhFTX6r7TRfb6++kX/SNK/tpIBOayqt6kxw+KQyhlT7bOMssbZRyoF8aGrYyjz9QH9D3Cx2XxTQJ5A42ANm+jhfzdwbAQEDvn589y97UvJZNQRFqCnv4Evbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAWPR08MB9783.eurprd08.prod.outlook.com (2603:10a6:102:2ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 13:47:37 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 13:47:37 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 15 Sep 2023 15:47:24 +0200
Subject: [PATCH v2 1/2] Input: st1232 - remove enable/disable irq if device
 may wake up
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230826-feature-st1232_freeze_wakeup-v2-1-29ae9f747137@wolfvision.net>
References: <20230826-feature-st1232_freeze_wakeup-v2-0-29ae9f747137@wolfvision.net>
In-Reply-To: <20230826-feature-st1232_freeze_wakeup-v2-0-29ae9f747137@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694785656; l=1728;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=T0v4Wv4A2+43BzLQqP9mZexzHUuL6xkE8xQU5IvVaOw=;
 b=7+iMu8hXruiEi6dDzXUMw+fSEUPneE3Sf8nZVaqebPZuIcl1SCyg25q1YLnRb46BRyYU/RHk3
 asjKjgZR/sTAEu/5/EETgUJm8K7ECh3N7gLSTMXXLtak0bGN5bVz3JP
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR08CA0233.eurprd08.prod.outlook.com
 (2603:10a6:802:15::42) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAWPR08MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 645c98f7-a2f9-477f-f67e-08dbb5f25213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDJoauZN2qYn5DGZzNuCJgA+4c6NvaAqihAHY69GqeeZkADeuL909mV7nU5m2YSGIATl/1QAxBABd0wmtGIFlAGNJWL3jyjI/aQdt5B9a3k/jmEhjBB3E3kUtmSqerDbdileNtGNCr5AWSmGGpoIsBayzfgKmSKdcmgAj+tV+QRGA962Ryrdh9tyu8QFUAfteP4BpfisvnhLYwW5Cju3C2LYxNHoPL1YxYaG3GmJVw7RNWSKae/FLxSTf5C+ZD+arNHPruvmA6XYn+bN1x9dwJIGNNz0wSJKbdkmCEBG2NwbAxjKdA0hGDwmBFvJB/hLPQ596CgmdKlY2dSqHitqMherBJ89svawRs8066YwA2pdMGvvNUbI2TqC5bRVmS7Y/w7k5tAhR0nv+u7zEeMdkow/QERHXwtNOFd6vwbZyIzhp1Vd5ZrdlY9fvvOrSaAhoKcpnpP2jyjcGawpCsvb+mqqMt4DOheFXeuxa9SyhTbCU5oFAFWfBeQ6uStSFUgYSnSYGxM+jc1k/fjbzxuSgzEAOjMbvWuvyR/28JDv0+QM4ih3uwIlLzzH6xWiJ/nUE+AhW3RYFk5X7R+8j6BIC14LP+6VBpY7NsOjdiUZFGKrbne9/PELQ/6Emx4roX0p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39850400004)(136003)(396003)(346002)(186009)(451199024)(1800799009)(41300700001)(6506007)(52116002)(6486002)(6666004)(38100700002)(26005)(36756003)(6512007)(86362001)(38350700002)(2906002)(2616005)(83380400001)(6916009)(8936002)(8676002)(478600001)(5660300002)(66556008)(4326008)(44832011)(107886003)(66946007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZXQkx6VWRTV0xjWUw3a3J5dnozOHdKMUorTHFkUENBZmc2cE94RVFhcTJN?=
 =?utf-8?B?WUJrNitBTjV2TzFheHIwYXdzMUxOcjhiUmNqb0ZMUXkrNDQ2eVV6dXFKdjJU?=
 =?utf-8?B?Z1d3Rkc2MG56TzBWcjhETmthaTNyVXZOL0g3NkRka1JSemg3R3YyNjAwQnZr?=
 =?utf-8?B?MVBOVG9GRmx5aXRTUU9lV2E4Qm8yM01JQnI4WmNMQmVUeXZSTGhlclp3dDFw?=
 =?utf-8?B?bVR0KzFvRjI5dVVzd2hKQkVDOUVTbE16c0xseGNCVVY4TDEvcmIvZERhcXNv?=
 =?utf-8?B?clZyMG5ZT01LV1F0Tkhsc2o2cVptUWpseElENmc0ZG8vRVExMk9SVStDS0w3?=
 =?utf-8?B?Yk5mODlMYmFBTW1wY2dvZVJlR201dTgxanVMbVN0RndTR3ZrRDFIb0tyd1h3?=
 =?utf-8?B?eDA2ZVpOV3NaWjRjd1RHV1h2eU96TmFJOGFvcWw2MEhBODhORTRMYmgzMk1Z?=
 =?utf-8?B?d0RTSFMxQzBycTBwaUVtOHV2UVhDUU9jOEhLRUYrc082YXhUQ2prU3NLTVVW?=
 =?utf-8?B?NXFreDNOTnU2ZDlTYnJqektTaEZRekUrbkJNcWtUbS82RFJ6aGdyd0F5V2Zv?=
 =?utf-8?B?Y1BGT1JjRlBoS013T3MxTXc4cHBQMmZWdkZlMmtLb0VIS2JaTWF5MXErZWZi?=
 =?utf-8?B?dHd5bndhQUxaUURjUmVIeVo1ZnpDRHdRUEtkRXpWMmh6NnNpalRtdG1HZ2Zt?=
 =?utf-8?B?WDkxR1dob0FHd3h1dTVwa0h0eHZ1d21DV1ZvZVNwY1RyNktHV1NsTGNLS1R3?=
 =?utf-8?B?MVV1MXdzOStjN1RpVFFPRjBxd3Y4UXJmamRjVnVuYUhqK2o2cU5mWTNXd253?=
 =?utf-8?B?a0tYZkNZVG96R3JoNXY1dlBBUXpRV3VQRmpoaExWVDA0UW5KTFY0bW9iN1FN?=
 =?utf-8?B?SFpTVmJVUFRGZlU1ZzFpWDhMN2E0RkxCT1VibFZ4ZmRzdzh5bkdkU2NsckZI?=
 =?utf-8?B?M3RsdDU1bnR6SmF3WDBVWEV4OERQRG8raGxxYXVQNEhFZVFqVXJ1UDBDTEIy?=
 =?utf-8?B?Y0hrcGMxbERnQitpSWREOE5UaFlHOXBLTUhIMFFPcFFieVFuL1g2VCtuUVYz?=
 =?utf-8?B?ajF4VnJrbEt2SmtlR01GWDJ6WDdoNzNXekIyVzE5ajd4S0FWbFMwVW0vZjEv?=
 =?utf-8?B?Tm1JbG5XVjlpZ25RbmxGUWpNTmE1ZnBuSEJGTGZ2NkR1TlBRekRiNGxKRUpM?=
 =?utf-8?B?NTNrNTdjeGxLN2JwSGxOYUo2cFpZTDlSc0p2dFptbjk4MmY1WnVPQnBIOEs4?=
 =?utf-8?B?VS9Sa2RCdUxFQm95MGg3a2RwVG1CQ3l5enZUMU4xamdVam5uSkdIbm1Sc0Vr?=
 =?utf-8?B?YVNpKzZvb3h0VXRYMHY3UXd1NnFnc3d5TzdoS0s0TlQ3R0NIRGhRSzBxN3By?=
 =?utf-8?B?VmhQL29uWjZ1eUh1UURoS2RnUkZ5Q29BNFhGTlVEQ083Kzllc3ZlQThyanBC?=
 =?utf-8?B?aGFPRUNyZk95N1BqZVo3NEp0MUtJb3pUQndaeWIreEVPTFFvTnBZYzd4R3E5?=
 =?utf-8?B?Z01IdHVwZHJtdktXTHRwUjhzaG5ya09ua1VPQ1NkRndiWXo2UFpEMThWajBQ?=
 =?utf-8?B?UHlDbUF1TUpOMEpLYXdLakhVZVZscWI2NmpDYmtINU5ZcmxYMlpxOEpNOUdK?=
 =?utf-8?B?L0VNanBJNW9uYTdwbG5OSGJnbkJ6TEFmejdIdDlFT2tjQnNHMVg0VXpWbXF1?=
 =?utf-8?B?RGJhUlVhbmxRMnBlaDJYWEk5K01lUVVjenNUcThiTnNuTzdvaW16bElXemZL?=
 =?utf-8?B?SUpzaDNQNjZtU2lhUWRjbGhUa0F6K0twcmZUcVV3eGxiTzRtZVZDTHdQei9K?=
 =?utf-8?B?SE9peFpyUFFYQVoxaUxrU3lJeVRFUjhDTnNCOG9UWlRMTEhpbEY0TldvdC9O?=
 =?utf-8?B?bjV3N0RFSzhUREhqOHMzVlJ6RmpvbFhXM1dnNXZRV25KcGQyZmorc0VaYUdH?=
 =?utf-8?B?VmRvTll4aVZuTnNHSnZpUFFUQVBxQlV4azZnWTlWY3J3UXV2WEVDWWRneEhu?=
 =?utf-8?B?aUY2Rjd5Ny9Od29UYkM5SWlJckg5WkxFOFBDdVVqQ1NSUkNOM2pUb1U3SWQ5?=
 =?utf-8?B?TE9qYUhlMERFQmZlRzY1clg1MVRLcWUvNXFQZDgzeVJWbEQxcEdsU3B1aHUw?=
 =?utf-8?B?YXYyU1ZrTDhvSFR1cXRibEJhZGJMNXNxV0JEV1hGZFI0NHBzblpkMGFxejVD?=
 =?utf-8?Q?racvnOKA/QyU+bzWwQLeBbc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 645c98f7-a2f9-477f-f67e-08dbb5f25213
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:47:36.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWwXTtpu8NFI92WDG8azTnSbQSuE8omhDkm5RqZoFFyUY7mIOrBYrG9vLFY68XrYM5Zz5ljt0ul3EvS/qSWGjVnbgr+RQvM5avrfXvTsWvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling the interrupts unconditionally in the suspend callback leads
to a loss of the wakeup capability in suspend to idle (freeze) mode.

In commit 95dc58a9a02f ("Input: st1232 - rely on I2C core to configure
wakeup interrupt") redundancy was removed by letting the I2C core manage
the wake interrupt handling. On the other hand, the irq enabling/disabling
became unconditional.

Revert the general interrupt enabling/disabling to its previous state.

Fixes: 95dc58a9a02f ("Input: st1232 - rely on I2C core to configure wakeup interrupt")
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 6475084aee1b..d0ee90abc293 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -345,10 +345,10 @@ static int st1232_ts_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
-	disable_irq(client->irq);
-
-	if (!device_may_wakeup(&client->dev))
+	if (!device_may_wakeup(&client->dev)) {
+		disable_irq(client->irq);
 		st1232_ts_power(ts, false);
+	}
 
 	return 0;
 }
@@ -358,10 +358,10 @@ static int st1232_ts_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
-	if (!device_may_wakeup(&client->dev))
+	if (!device_may_wakeup(&client->dev)) {
+		enable_irq(client->irq);
 		st1232_ts_power(ts, true);
-
-	enable_irq(client->irq);
+	}
 
 	return 0;
 }

-- 
2.39.2

