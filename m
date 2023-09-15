Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F617A1679
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjIOGwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOGwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:52:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3E2270B;
        Thu, 14 Sep 2023 23:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNeB0ywPHHhHb3GK2bkbRZ8p0xZLIVr04tB/9BaRWYXlYGDBkFUludyfAxaimw+028CyiIqaxE8/AnUoV8azIs49BCmSgUgNegx0JTSY20ZuQci8niFvdRQpZGn/aqrXwH8g8ushDktReLkij2ZqFWeFJVgYUMTYNl2jyXU/cJOtTdMzMrwzmJEFfHoDAxURWVvV7AmQ6jpTqV4tArCzc9Wp4Yjyn8JgTdYH+vZIexdRTrOJFepSm7dWCdcR3ZR3K3v+tD04o1lt2xjUqzvasMMZmxQKEK4mvu6sCKbvG07jqkDjdDuYRUTg01kJ7inegkP5iWi36FXdZuwiXap91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06Qw5xdGcO/UC5alSDHlWEZr6yTViAvG5vKwUZ+yPc4=;
 b=bPldFwtOQa4/CqeYtl+zK5JXe1J8lpDqdFLtkDfJuOkbc09VR9MWFxWEZ6AiiCyNL4JZlx2V2nuSDgZGNEnEaMXrMiaTYrOBP+ghCeoEMuI2vw5jAq0RHB76AFKNGkYfkoCNuTC+VZBjI7T8ILu2ytOb901xDWxC/VdQVsmQYsMQdhmD4zyivIgCSe3/dE2GEkKhaYnPsvwdCwNkSzFuTbYxJYokF4YBQWpHUUI+WFy7im8m7ekISW5lKti6TuE2SLwKi028ck9G0tLPRpTLvi46Er21nsc1Yz6qdwPEpm5rLJaRuYbpkEWFbRlCEJigkI2px6NFKFiHFQ2YJR3KIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06Qw5xdGcO/UC5alSDHlWEZr6yTViAvG5vKwUZ+yPc4=;
 b=td3y/t9kDv0s525jS79DHW1Bhbit7MQ8HNU5Iq4fcJzColNkFJ5epodUEOWgXsXr0dF0OWiCl28EK623lE3QO17l8nKcHFaKSGg+C5ETOQSDkzJyd1Yyn/dIDnwi4fp9eNcu0aSqt+4zWSqbEr1oJoZob8HEFJDMiFMB4ChWIqk=
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
 06:51:43 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/2] usb: typec: tps6598x: add reset gpio support
Date:   Fri, 15 Sep 2023 08:50:51 +0200
Message-Id: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMv+A2UC/x2N0QqDMAwAf0XyvIJ2rdj9ypBRu2wGpJakG4L47
 wYf7+C4HQSZUODR7MD4J6E1K3S3BtIc8xcNvZXBtvbehs6auhZKphbpfRi2F6NgNd5jcMHh0Ls
 Amk5R0Ewcc5o1zr9lUVkYP7Rdr+d4HCcpHBThewAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694760668; l=973;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=iQmX0OdqwwB+yIEigJ6kQ4BxGjVPOAZgcoF5Grr3QxA=;
 b=/EuhuPu3JZtbDZj1CDkJ9Anvzz7gaXloO5esJ9CZt3vsveoTzAfUB9ga5QQQvMts4Q4pJ60f9
 SGsUdRm4e46DVNgml5qV26VPWfA0ie/4kdj393Zaisf8UVYaEUfFLlh
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0296.eurprd07.prod.outlook.com
 (2603:10a6:800:130::24) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: ad73ac01-6888-4049-4914-08dbb5b82472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2q52hktujNvH1xCD3JP85NTTcv82JZlTzZrlTjxoqHmTXDg0TuJetlumje+uFx9GRaTSKNDqY62IyZ5pwsC2BnoWtJZ/UmNnavUsWYawG2adOBLLuISJIJi8IOqiYnOpUkovRji2lHeC1wLt6aO+HZ2qjGI6R6d/39PpaSYKFCU7e/qS5Dasw72I6ZDeZDHhUBe88AarPoaYVVWO/xdwtvp4j4ATTZDqFW5wQIsi04koH73Ewbf/cqc692EymKZ9KZok9USro//BCPURaFuZmnLYB7JbrnnYpPXZW7pKg726ANVQc4xceOnu8zEg0ld8k2C1xK/Gg6JdHXCf2wNF/lMXD/QF0q/7SU+BgNQPBvMJZDm9YkUiTQe2+79o47k7knL3NmySHGXSDVj0rxTvFVMzJT+wwaKOZroPU3HuVUKRgw4t06yq+zX1Bo7iDm96B8Xq7oBk3Wushbv2mMrlK2iUCry039ji1qqFx3R0KP0qoevR4KnsYnuKsanZFhQ6nHryG09cdPQxCjl3JRRvPnkvZZSb3T1lBUP2lnFjp2uV5d4qH5yBsuOVnaWvKBiXFigOJPqNQBX/Gb+MNS1tvgEHUBlfU6gyry/+FBr9gCYQ9ZfPxJRNONxrgXpNNTH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39850400004)(1800799009)(186009)(451199024)(110136005)(44832011)(316002)(26005)(66556008)(66946007)(107886003)(83380400001)(36756003)(6486002)(6666004)(52116002)(6512007)(6506007)(38100700002)(38350700002)(86362001)(2616005)(66476007)(478600001)(4744005)(2906002)(4326008)(8676002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzVwTXZwSEJ6U0tGRVJwbHlmZFBlUUJ1dU5ISkNFeURrbkE4YWg1UDllTEsr?=
 =?utf-8?B?SngrK1pBdXFYNkYxUjZaT2U4OGcySm1ER242TXdqVklRQmpPa2pqOXVSaU5E?=
 =?utf-8?B?SlMybzNnZVo1aS9pNkwzR1ZjUnppWWRlL1lGWThCcC9qNXBGdmp4Y3ptRnVj?=
 =?utf-8?B?N2lna3RnditlWEZxSEE4Z0M5bExYc3M3VmdOWHpLNGFreWtrSDRLMDRVNmVX?=
 =?utf-8?B?QTNDN0ZveTZnSGNsd3hSOTJ0RlNVREg1a3Y5eElYYitibG9EY3ZnY3ZpbzEw?=
 =?utf-8?B?QjVhMmtGaHA5eEFPVTVxa1ZZUWZpV2d1OWMrV3NsUXRVRjFaN2dtcStqNU1D?=
 =?utf-8?B?dEV1bitIU0Z4S0xRaC9vOG9iZmhxYTdEM0k5TmZCMjBWYmZGTnR2Y2tha09J?=
 =?utf-8?B?ZHNwOE1sWUswREtjZGlpSGZlQUpIVysvOU1kZVo3ZG5oT0tGMUwyRGFPOFlJ?=
 =?utf-8?B?Z1FJY3Y4dE9LUHNnQm1RajA0UHVlUk9xVlFyaFZLWjFXTjlrSTVwVUQzZThN?=
 =?utf-8?B?TFBlQ0p6VHlrcUR6WkpGY1RLeGFqSFJoVVJuRy9CWm53VEdkQ3NrVThKb0hv?=
 =?utf-8?B?MEE5aEFrUFRuYnd1aC9VSjhLMEd5aGdHSitwK1NGSmwxRktuTzc1YnpWbVhS?=
 =?utf-8?B?UnpQMDhidFlSOXY0b3dXOVplVWVna0MyODFFcDBNQVU5YTZ3L0NNMi9wdEZ6?=
 =?utf-8?B?bzVXN2VaeW15WW95Y0J0SWh5WHdlems5bUo0OVZQK2x6bE5IQzdiRjVKM1Bt?=
 =?utf-8?B?VmtVdTlidHVjaWhWSms2VkMzOWppTTBESUNoUDRLMUZydXYwNTg1NlZ5MnBZ?=
 =?utf-8?B?REdkMkNPdm02aElKV1RzM0xTZXk3Nmk2OFgzRnBudHlBM0V0TXdPOWZKY0JB?=
 =?utf-8?B?N3NxejZkbStSRlFoa0RZWVl3R0Y4YmRIalp5WFNzeDRRT0pEdWF5MGlTam8x?=
 =?utf-8?B?N05IdEgxalltQVJaaFByNXZySlBicDNjQk9YalozN0VXNUFlOFlsbkJmc1Jr?=
 =?utf-8?B?aUdIZ2REekZMOWttamVZSklvQ1hBYVpnd0VLNVl6NkVONjFRUDBvY0E2Vytj?=
 =?utf-8?B?K3hoSFFaNGVRblg1cHdjWlFWVzJFamhTa1VlODBoTnAzQm0yZEIwN2RITGpy?=
 =?utf-8?B?blJnNUwxRXdkejlGSDV4cDdoWVFMNkJvOWR2ZEl0dHBOM0Noam5mY2Jjbnh2?=
 =?utf-8?B?NWdWU2lwVHJsTVFhSzJ1bFU4STY5bkhIQXEzRlZvazBwcHV2d1krWFpadHZW?=
 =?utf-8?B?MmFKNEQveVJHSk80aEpReWVLZkhsSTJ0TlZGNzJHQ09vdjdYS09ES0kyb0h2?=
 =?utf-8?B?ai9ZM21ac0FvQ3cwZ1dmbWN4V3JHd0hwSUwyWVVnZWFnYWI0RC81T3B3QTZm?=
 =?utf-8?B?a0UrVmc0SitMTWsvalBaemxwNlMyK3Rxb2RJOExJM2VlM0pkVG10bzVJNDdz?=
 =?utf-8?B?a05qSFAxSThWMUVPVmxYNTdpMWZydE9sN2NZMXkvYW9LOVVpSHFWY2tJb1Y1?=
 =?utf-8?B?SUtzV20rWWNDVjVWYmEwQkFaTE9vM3VlejI0MEVvd2JoSk8xK2I2UjNYbUlQ?=
 =?utf-8?B?MWtOdnltOHpoY2RWY2UrVUVxNkpVVUhqS2QzaXpTZ09TV0YyUFl0U2hrRE1P?=
 =?utf-8?B?RUdtbGR4Q1A2aUlheklNRm9uMVpGS1VxcXQwejZjbW5lZ3NnVDNYU0VJWTJs?=
 =?utf-8?B?M3E3T0kyYmtNMmZIQWpBM0xXdXdIU0NhV0ZwaFlsaDFIcmV0dytia2hDWU9w?=
 =?utf-8?B?R1ppR0l1TzZWRmdaNlY1MXJZdG1DR2cwbUM3Mm1rdzNtRk1RY0YzTjJ0ZDJk?=
 =?utf-8?B?L2xPRXAvUjI3U0hTOUxObHVrV1BURzluSnc5VE5qRk9qdHk0ZmZuVXI3Z1Nu?=
 =?utf-8?B?QkkzalZEYUN2YnBnTEh2azhGRDNoM3VzWVdLRjBQclQ4eGRtaUlMMU96dnlP?=
 =?utf-8?B?V0ttWDBtTGd1WGkwQ2orSmpqRWFBd28zOGNrOFo3a3NtcUJYMGFCazV2aTZY?=
 =?utf-8?B?RkxySStsaUhVVWV5azZOTkNPZEF5R1NiaUM3Q2RpWk9hUXNvdTFidE9tOW94?=
 =?utf-8?B?Si9EUzBIdjRoSkpvejdGVlAwQkJBY2hCbEJ0TnBHeGFzRmxKZFEwakJNRFJs?=
 =?utf-8?B?Ymd1QWJwaGRQVFZjaE10elZ3NVFuNUhSdHdLSW1iUTIyY2R4eXhvdndzWXdF?=
 =?utf-8?Q?eWywVPNxdBnzILEM98Xdvm4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ad73ac01-6888-4049-4914-08dbb5b82472
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:51:09.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLNFfrRBDHL2C2cOiqLEc1YLE5SSI2k22YVr6mzBc12sKw2CNLdsPSdqsW/s/6GvDrrZSAr5jJ3M8lgYZU5VzoXvKj0uAQ3Ey94q9zb/y9I=
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

This series adds and documents the reset signal management. It also
includes the basic reset management for initialization and
suspend/resume control.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (2):
      usb: typec: tps6598x: add reset gpio support
      dt-bindings: usb: tps6598x: add reset-gpios property

 .../devicetree/bindings/usb/ti,tps6598x.yaml        |  6 ++++++
 drivers/usb/typec/tipd/core.c                       | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230912-topic-tps6598x_reset-55e9494e8649

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

