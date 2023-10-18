Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8B7CE200
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjJRQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjJRQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:00:06 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B2116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXIvC6ZLfNB+KGG0DzU8M85j5GIWB56VpQh6c4GPAf3BCF7gjkq4sS/OovCn4OPZvnhwmpxfju1qwYnXfsMj++JqXfeytijqP1tyqfMbYTQJSdc81uHDNlBTNJCXzH0KTnpIFcOkE8sVccj6Lbc/3hTewP8n+sKSNg6ZkrqonZFiBY4dnNlNO9P/s73BAGwOzZeJXOxvnOvGUx9fRNCIbP0QPX+200aSZgFZobtC64FhZQdB+/HOqnj2UX+c0CCUGZWjpgcVw1sTkjj/beoTlquNg5Ywu+sEppUFUfmN4vyYgyot0sv4jiRMY0aXZ5Hp6wzoCUskUckBAW/kC728xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=478803QczRFFXBUKZoVGKqPgxQF91oUCRqBqSsaRd+c=;
 b=QWeViCOLj9+yWPPu9X2ZaQjBd/Jj427tpv8uOkPEIyJjkQqpTile/Ogeh9282QquzXgDgdmCRhxQJSVmw+7afrBZikW2ovXedm4vXR5j5UVa0IKemmdegdYg//gMHkop68TFjJrewccgz3qFCZg7wLrxZ+zPW3c5Sk8CbiP5zss95ZCNuDRh/A9bv4uR9xHZPLvUdmtOlOTIEtbwpXlZUkwnwOtEI3LffRbjpxIGDz3ywwnNoJDyw1+0mzh+EWoFhCi014fuW3mp74WVgTCAl9pouv0+vgc+UwUqpfTjj2u6HnhR2WMZ9by6WrbehYjpJM5VvsePro1xBmP2Oomj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=478803QczRFFXBUKZoVGKqPgxQF91oUCRqBqSsaRd+c=;
 b=I7lSfk6mpf4kco4xiOh1PzN5kobl9au2hHtcGe69DWXLY2mE3VQOrIitd5qc6peg73MI3eN+VrWVMuC5f8leVdxiwtQyC6aN3wyd0qSV6owNX3zRcs3e8D1qYIbA4HQSvCh1hIsdB807ZDfnwlBgdYnTGCBMAilUdYalThj3OZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6966.eurprd04.prod.outlook.com (2603:10a6:20b:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 15:59:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:59:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join failure since timeout error
Date:   Wed, 18 Oct 2023 11:59:26 -0400
Message-Id: <20231018155926.3305476-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018155926.3305476-1-Frank.Li@nxp.com>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: c2be9190-f7fc-45cd-6d61-08dbcff34751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Smkj3gwC3HUe66vGSDimpNAsvQlq7DV5p1MyVAdR7X+KEKe4PZSZZEj5/VnNVMKgxkC1ozjDt4VaK3YQjPcn37OMmUfFlkzj41AU5k5An8cGQOE5V/Jl4vS89JULr/fdYuXA7NOF5ct6H0nSyPm5wxSWfthKLaPdT5bKPQuFP/SGuhVJtfK1HuLwgIgVCjRXw4t/1sQnWuZogYXKKij9rQ6Q7BnX+VB0pLZwJEiOFEcmxwhN1Y9eh4wHTqj8hgaJWcl4Ob1WUkD5vtGaSG5rccTBGyr1RE30VZQSnSaN8elm2w2Y6fDMPW+0SvmTz4XiK5tSXfz2gIKw9YrWsXDNw6opudtkzNmXxTT5mOl/hc88IEdhqRr1NPzuZo6DcxJz+E2ZNNNp/bUmNAzl9qv1/Gh/I58Kyyp4hsWmM6R6pNbICtflNmFHSfmy/JHws+m2WuCs3Ohv8KsFPUy7hoaAPfFRd2gNrqsObFP1LaqFFn2pDaItddkDveYuJcH6GfWbnlzHO048918hk3yO7A4/8i/OLY0yRDJ8/E5/TL0tnCYdcAo40WlkCHxSYGmJ/pIL2GpUul+kuNf2m0VtW1BEcXiXvfyueL2dE83ZagKmuOiK1rpfJoJb8Z3HWOpwdoO6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(478600001)(6486002)(6666004)(38100700002)(8936002)(5660300002)(8676002)(66556008)(4326008)(66946007)(316002)(36756003)(66476007)(6916009)(86362001)(41300700001)(6512007)(52116002)(1076003)(6506007)(2616005)(26005)(38350700005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGYzVUdwSlJJUDFkVWw5VjB1a3RONUF2UCtYREFtdnpGS2RjS0tPK01jaEpI?=
 =?utf-8?B?c1djekpaWnBQZnZqNWlyY2NOdXJSL252WWxKaksyU1dReWxqaUxWY1E2dlVB?=
 =?utf-8?B?djJSMGlnM0ZCS2tSUHRsMWNyMHMraXA0anA4QWRXQ2RoaThVVlhKNTFMUUFX?=
 =?utf-8?B?REY4QXN3dVMvY1lHL2ZWUVp0N1RaUEt5YTU2NDgwcVN4SFNCcWFmY3U3REY3?=
 =?utf-8?B?MFR4OC9VVUY0TFJTSHJJNWFROG1VaC9OUmVaeFlVaWQ5Y3QrU21nUURrRVpy?=
 =?utf-8?B?Q3huQjR5TmdWSzRLTmFHQmt4NkZmZlVwRUZaUFZyL0xyZUg1WENTN2kwQndy?=
 =?utf-8?B?NUpoWHJmOEJDZVFJL3pKbTBpRk5yc0k2QnF5UHBjT3NHcGNSRGd4cUR0bHIx?=
 =?utf-8?B?a1MxMWNqT0NldTFxSG9pZXZvcFpuSFNLUzB6VkdCUU95SVFYTGM4Nms4TnJS?=
 =?utf-8?B?eEJydis1NzdXeVdnR0psN0dGQStkSlFQQUpHaHJUU0I4aVhDU3BtbmJCUEw5?=
 =?utf-8?B?am05WFNLbkJYU2ZwTWhZTUJMNzdDUnpZajBmbVVHRkpIY1gxR1hYT0xweWgr?=
 =?utf-8?B?ekpSdHVrZ2ZvdDhSMU1hMjhqT2cwNSs5bitqSEduMUtGNnBjdGZGdG1pRmFP?=
 =?utf-8?B?QnJBazZaYWoxem84UEREU1FIT1c1Q3YxdTZKbjlIL3l3bGV3N0g0L3ZRT0pV?=
 =?utf-8?B?dVRIdFNGZEZwLzZKNW12NU12dFZTRnozNHkzSEVXbk55amxESElmcy8ybytK?=
 =?utf-8?B?WnVoNzhQSnZsMTdtdVQxbUNDMXZMalduM0RRMlhsYVRmSXNLK09ERGN1UzA4?=
 =?utf-8?B?YUhiMHhySGdtUk56S0hSeEVoMUtKNURlcGQ2cml6NHc2VlJlNXFFTmM0aWRu?=
 =?utf-8?B?aDdQSU1ILzlBTDdrTUFlMFZkVlhtU2FqeEJBUmNabVR6d29FMUJUSHBSUzRo?=
 =?utf-8?B?Q3FkeGdQditKQUtUcXVOQXZvSUhuSS82SG1pL2piZmhuTmU5NnFTSDk0MXFh?=
 =?utf-8?B?TjBMYUtDTDVtOTNqTkp3NGpBWGJvNEtUV3E3ZlExdWFKcTc5SHlpNU1QWm4r?=
 =?utf-8?B?cnlsWEUxZ2d1eTlObXpLZVIycDBWTi8xOGRWaGdIT0ZHSWl6ZHhWUEJZZ3lJ?=
 =?utf-8?B?VTN3TGZZK2RHcGlZZEZNbE5NelhLbG8wM2ZxcTNESU9rcThtL25JWmZqSGRv?=
 =?utf-8?B?NEgxOEcrSGVKL2k0MmY2YVZlaG9HMXBVRGJUcjhBZlZJTFFHQldGOUVJSXA5?=
 =?utf-8?B?SnFUZnY5VEtNdUZCR2xQbXhzTmU0U1VJQzVaTDUxOE5pZ2tXYU9Qd0FuS3pp?=
 =?utf-8?B?YTl0RFViMmVuVE96VXYxS2hDTHViTlVMT3k4ZjdMQWRoQ3VvVUFESGY4TlJ4?=
 =?utf-8?B?U1JrRDBtdHlqNjV2bWE1UVVpRDF3SU85bjRoYzl3V3pudVpiWmFqdUFwcnV1?=
 =?utf-8?B?eFc4SysyWFBsNHd4OGxTQkdRbUZnKy9CSGs3a2RhZzFtQjZwcmd3b3pVb0Jv?=
 =?utf-8?B?UUJqcWhSY3BWTytoV1FsZVkyYTk1Y3JrRklhSTJtN3NrWHR5TldNZEh0cWtp?=
 =?utf-8?B?MXc2dVRDQUZLR0lwU0Juc2VCZGtkS0FNZ01WdTBRc2ZIbEZqN2tBQ0VDY2xC?=
 =?utf-8?B?Rkd6ZWFyRU9aRHRTMFRJY3pVekd1dXpOVGtscG9kRkIwZjBpMktidk5WemVZ?=
 =?utf-8?B?TnpSdWxKMW5KYmozdEtCaWQwcmFpcE9naXRlUnU1L0lKUkQxNVdZblVUNm04?=
 =?utf-8?B?RkRZa2s4RUtpUWtHUUIvQ3o3eURHd1FKcXZ0ZUlWelNmRFVJMXhEN09KWWpl?=
 =?utf-8?B?SlluMXlSNWFrdjZvd2pqd3FYTXU5OVpFQTdTclQxeHpPenJwQnVGVW9ENVBk?=
 =?utf-8?B?amFoZXI1MzNHZW10UUJxZXFNOVVsRmlzQjlKQ0VYY0JxV3k5VGFsc08zWnh1?=
 =?utf-8?B?OGxtR2NHbnFJc2ZoVWNYcm02Wlp6VVcyME80b2pMRGkvVGFvVllCMTdNcE5L?=
 =?utf-8?B?TVF6SExiaHdOdUtkc05FWTlGRXZXWkZvbmtmK3NZdW5iMVg4ZE9xeDdIVUcx?=
 =?utf-8?B?MFVJY3hDeExlM1JoR1BMTlBiazFGSG5LaUcyaFd6SU5SMGZpWDBQMyt4MThj?=
 =?utf-8?Q?GKqPKpgYhS11pSc+BGHyCDWml?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2be9190-f7fc-45cd-6d61-08dbcff34751
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:59:58.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I63UuGnjXmXnwy8MxQis7lE52/x2VZWoraOOvtBb+ac2OVVWOFq1FgDitYaoM1rPLMYGh/QX9lhRt+GEq1sPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

master side report:
  silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000

BIT 20: TIMEOUT error
  The module has stalled too long in a frame. This happens when:
  - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
middle of a message,
  - No STOP was issued and between messages,
  - IBI manual is used and no decision was made.
  The maximum stall period is 10 KHz or 100 μs.

This is a just warning. System irq thread schedule latency is possible
bigger than 100us. Just omit this waring.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    -none

 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1a57fdebaa26d..fedb31e0076c4 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -93,6 +93,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
 #define   SVC_I3C_MDATACTRL_FLUSHTB BIT(0)
@@ -226,6 +227,11 @@ static bool svc_i3c_master_error(struct svc_i3c_master *master)
 	if (SVC_I3C_MSTATUS_ERRWARN(mstatus)) {
 		merrwarn = readl(master->regs + SVC_I3C_MERRWARN);
 		writel(merrwarn, master->regs + SVC_I3C_MERRWARN);
+
+		/* ignore timeout error */
+		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
+			return false;
+
 		dev_err(master->dev,
 			"Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
 			mstatus, merrwarn);
-- 
2.34.1

