Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663027A358D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjIQMjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 08:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjIQMjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 08:39:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54E7D9;
        Sun, 17 Sep 2023 05:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/sNWJdOXYIQlLINB+dk79ekEaqJZAVEFTnz01xmntoUpiyNOGwktKxgLUkZqv85gQRZfTCgKd7xr0FX/VAqMdVQ+N7CpHZfdQbKCw7kijri65/S+qdMX9fMaLu8OWJTp4045A0+WLsz052BaQvTke9rjp0x+QRz4V4ruEVgTmBB5LeC/ax8Pz2MaVumPNiy/Y50FEoRxdbF31dEkSN0PDTISzWv9pZdOPiKfep7D6RWDBfcUfjy690LdNOereyx+X/3V5JiD4zJgV5bBs+VIp+LKG8cfSC6QqQ1oMEl/7uCHZDA/+gbJc2emec8P7iFSR5UdaP4uzYNoFTh1t5SVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bEwMkXQTS3DhjP11ckjRoOX6VSUYHhrKyes2FBNdFc=;
 b=ODbOZnfWMLphcyHuGAB4rdv2eLat70aMYOjBSTER/5GHHxU3DKmcYqP9sAprAzQputChGbrloYLhnHgrSuk77dJr9QYr10+IC+jaPfEw/bEHytd3rNrxJ7w9d44vdm+4fPCGAx4s3Gkp9Q3FUZSJtA+nHDq2JkR8WHNLdRsQP8PFwAJHR13jaI/hTO9SebarXc4lNhoz98IeOojdZmY/D0jWb9cHQ8uN6zsJSE1TG3xflUcksmb2On38rTSr9S670F0kSEFct08VE0WPxYxw5IED/2TadaS2jqbCG6Gh1+BMh4yPJUWUU3cIq2u9SvihBlqQpnWzogaUQI5/Kir7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bEwMkXQTS3DhjP11ckjRoOX6VSUYHhrKyes2FBNdFc=;
 b=hsJpeaztT3IafXdYHB3o9BJfHKNcISttNBg6Jul84ToKXrUEoJm5a5N+dDs1yr8NnnPl5V9MWTnj0xEntvviqIRTeUpxsbja4s7KVFy3uqkqs7tBBevWQUFvGzHXMDR/aL0B3JsS2+dPp4b8kPdoLj1+1QimwopzXqP+ptbBuTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 12:39:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 12:39:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] mailbox: imx: support new tx doorbell
Date:   Sun, 17 Sep 2023 20:43:49 +0800
Message-Id: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIX0BmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0Mz3czcCktT3dyk/ApdCwsTY/NkU8PkVFMTJaCGgqLUtMwKsGHRsbW
 1AHlnMolcAAAA
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694954643; l=983;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=91XOXouCohHHgJ5iZISAuZB7ik2Ccg9NIqPyzbSXMHk=;
 b=2dPmWkf4wV++lT70Wipd4dEUaLzk3vL2AqrYfMOjbuODlngb7ryofyaRyY87BQ5WOMcTLK+Ln
 NktLVhxfYuxDKw7j4ZUeNc6s6VGOMEzs3pa9fEmy5UOxnVc8BjhgHk5
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ed8868-5dd9-46b2-0127-08dbb77b181c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYgkY3WwJA57no+JQdbsp8xY432//PkhkPSzIRa5hiS487qQvlZEZ50PI5JODAhhUJGWy2tMaxZJ1pWcOzNsftwQB57lOGj7pi4rqJo6mYOA0h5u7UfcpCPGErdGCjpAMjAh0FtwJieDjdxUzg+oOEtgnO9lXo1pyv75dzBkL+8xBom+MLJSsqsDpom6U0CyksxbwBDELTZxNSjvbzT74O88pOIOnNqiobSF7jzXPrNE4Fh8kddYaaGuCZ3ioGyCf5AGKuWIv30MUgRFCh71KZk8HGb/3E8k8vdjuRqa8DkYHECdAWDbexia/LS4nucEYCy1P4tlsGjmhJ9SUB5dPbmX1VmHQWK83o3vg1LQzmawOWJpDZILNHpH81bHNnheF54lnVUd3BjeiOfDNKSVWDtMPbbHQsJidMQOtZdaARkRK18g+E446X/pJpv6MGZQeUc9hhhx88/BAvp08zPWgxkdC/sXiw4V8u0H98x5DywYfZ85Wb/XC3+jg86frThJxJe/NsX/xAed91c2M5jVyjA8mdZSYfOF7O33MXS/y+b1oq7+pV3gqzfwVUcBHMpIpGpA3D1AJ7gPSHHzA4iaZdM8jthufqw8jm1aWi+79V4VdaMn7Pi/M1dbi35wQUbY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(186009)(1800799009)(451199024)(921005)(36756003)(38350700002)(86362001)(38100700002)(6486002)(6506007)(52116002)(478600001)(66946007)(66476007)(5660300002)(66556008)(2906002)(6666004)(8676002)(4326008)(8936002)(9686003)(6512007)(83380400001)(41300700001)(7416002)(4744005)(110136005)(15650500001)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amNXTVBOTUkrUVBlODRtc1ZPL2hpOTc5Rk5nd3VRWURmU25qbjdBdGZaeDBu?=
 =?utf-8?B?ZDhiVXJyV2hKTHhKWURGVTJSUG1DTVVyd2hOWllCQVFUeVRIMDhxR0UvYjJP?=
 =?utf-8?B?RW1RVUlxaTRsTFVSSkprMzU1YmNhMk1mVlBWMHVkWWl0dm9OcnpXYjBiUGJK?=
 =?utf-8?B?ejBGNStUaW1adnZnNFhHWHlvdi9nK1paeVJtOTd3ZXhDV2pCSkZ6N2s5ZEt4?=
 =?utf-8?B?aDJiZ25VdDBrMkRrZkxtTUdaaDJaclVXVXRJRnhPZDlvVm9wakZoTFl6S3k5?=
 =?utf-8?B?bUdSQlg0T2JMT0Vpd3ZtdVBIcUZ3L014Q0VoK0tLYjNERXk2TTRRZklXTXFP?=
 =?utf-8?B?dzI2aW04NzhaRFltTkIvL0F2SnRXT0FnNXpMU2VDMithR24rNk9KMEE5VC8y?=
 =?utf-8?B?bmhFZXkvdWVvMno1NmF2M2FWWDhxWlYybmJKU3FBckZVWjdST2thTERxQjlQ?=
 =?utf-8?B?dW0yOUFSckl1cDd3ZFFPNzhLTEVwZExwNURTU1ZudjJQc3lwVGE2aTdaZGVY?=
 =?utf-8?B?MzIrZ01BT3RrTWNlbVpZL0FOQUFXQ3lCQk9DSVdFejJGb1J1QXJiblVkWjFa?=
 =?utf-8?B?dXlsMnNpaHg0SzBLd3BvUkRoYnE0WXlBMmwyMUppbjAybDUrVUNUdnBtbnBR?=
 =?utf-8?B?eUxlVUlIZjNsS1VQVlJpeXFKZUtpNFEvdjJHRTcxK2dFRFViMG1LVW4zUGtU?=
 =?utf-8?B?VWE1R1V2MGRkdkN6aXJHS1k2YkdIVmtHZmh4UU83bmJzY3ZpVW93dTZTdXo3?=
 =?utf-8?B?ZXB4aW1Ddzk3dEI2c3hlQ1cxM1h5NGcvbFI1L3ZNNjVtU3ZOK1JaZlFUUm80?=
 =?utf-8?B?TFlyMnllMGR3aGJZbEtnSUxoeUpIN3Q3WjJnQ3BzMWR0dmdHWmNBcGp5NkQ2?=
 =?utf-8?B?TGVFb0piZG1EMmRTUDFucFgxdzM5eWRsakUwTkh6MUFidDZIUmlwck43RDdT?=
 =?utf-8?B?QzRRamZ0ckZLWFdsUDJUMUNTb1hQK3pYaHNudityelZpRDZRLzZyRVJYTndj?=
 =?utf-8?B?NEJweDRzWUIxcnhWRmRlYVJma2p4dmJHYzl1NkgrTnlGaDd6a1hUT2Y4UEJw?=
 =?utf-8?B?V3FIa1VTdlhlcDZFYkRwb3V1RUF4SUUrZlU1SVZtbDZ1c1hveHROdE9kdDlT?=
 =?utf-8?B?R3hyMWZFY01zYzl2NWhza0R5WVkvNG5IUDB1MWhyTEEySUhYTGpYUVQvYUN2?=
 =?utf-8?B?UllVSm1VcENUTk5hOXN0cXBtZU5pUENUU2lUSVEwYjV4T3ZTOXFxcE0vbW5K?=
 =?utf-8?B?OEFFaHZkOHdmS2t1NkY2WW9wbEt0NjlkYVhNQWlpVzFIZlg4ZkpGUGxoMkZj?=
 =?utf-8?B?clZJZDdQZ1VQREo2am84b0M3QjROSk5maTVLWWNtWG14bUVEZGp4eThId0wr?=
 =?utf-8?B?TTY4eTFVcTVmVGt6TDNrdWMxSWdla245cU1xTVdLc0tuNVBXUU92VU9GamtO?=
 =?utf-8?B?dkpObmlsQnM5WFZtcjkzd1FDMVExUHduSDQ0QTRFbkx0a3BFaGt0bksxL2FW?=
 =?utf-8?B?elBLN09WUUlJaHVTcmpOSHl2OCs3SExXZlZjemNLNjZHMGJzS2xqSE1NcVlD?=
 =?utf-8?B?eXI3dlluZG9uVTRScXU0MGxRbFI2OXg0SDVjdkxYRHd5S24rR09TNHk0UjR3?=
 =?utf-8?B?eUNGSmNLUTJlQm9wY3E2Mzh1OTNrS0RMS1gxWjlDTW84ZldxZm5WQlhOclRI?=
 =?utf-8?B?YlJub2RBQUtnV0NVWWM0dmVtaW5sTHJoYkErM0p2VExSc2hneVZHRHU3Y1Fa?=
 =?utf-8?B?U016d3dIOFZiSXVHKzVPYWJ4VktISlIxeVRPcEk0aFU5MTA4Q1Zsc3h3SEtM?=
 =?utf-8?B?K0FaTUlVelZRcGtPbi9YWEhJMzIxOCtJaGt3aS9MbUlFVWhUQUdpNzl0ai9T?=
 =?utf-8?B?SFVlSUhFNDl5MkUvaTlsdDUwTmdJbzg2WHJyYThJQXgrbGhiNldXaUM4RXNw?=
 =?utf-8?B?MWdrK1RVQkJIZ2dIRGJRL2FWRHNXb3k1M3dId2dBSjJnM3RKM1RaUVAvL1ZM?=
 =?utf-8?B?RXVsNldNYWpHQ092eTlwU2l0clJxMENZTElOR3JsRVhDdkQyUWxwcnRjQVp3?=
 =?utf-8?B?WjhSWGFjLzVFNllGWGIvdHREL3hWSHQxTXFiS2UyL2lVOGtZTDZjTVBGeXBp?=
 =?utf-8?Q?fbKxoKHZo9dN+zoXSEzSkd0Mo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ed8868-5dd9-46b2-0127-08dbb77b181c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 12:39:11.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tjyzgF7PenlEeovGtIpsX3Bb1Uk2MUbDEogIE3aMZs69euXWG0Mnmx4DCEaNjoT1CagBHO/HgfBZIslEXf9MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new added channel type is for i.MX95 SCMI mailbox usage.

i.MX95 using TX doorbell and RX doorbell for the SCMI mailbox transport.
For TX doorbell, we relies on software reply from the other side in
SCMI driver side using mbox_client_txdone to drive the tx tick.

But the current MU tx doorbell using tasklet to emulate hardware ACK
from mailbox driver side, so add a new doorbell type to support i.MX95
SCMI mailbox transport.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      dt-bindings: mailbox: fsl,mu: add new tx doorbell channel
      mailbox: imx: support channel type tx doorbell v2

 .../devicetree/bindings/mailbox/fsl,mu.yaml        |  5 ++--
 drivers/mailbox/imx-mailbox.c                      | 32 ++++++++++++++++++++--
 2 files changed, 32 insertions(+), 5 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230916-imx95-mbox-88437c51ce54

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

