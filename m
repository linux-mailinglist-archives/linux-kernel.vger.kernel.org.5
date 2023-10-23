Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC537D3C12
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjJWQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjJWQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:17 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2210C0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/1w5bFUn7h3Abw6NgCbVayHbmVtoB1StE2/Hd0A8sXTsUgXMtb5NgiohXs33LRDwdHw06JyaB3C8ICSWQ9g0q+45opLd02+Z7X+cjoJxHeglCAwvF/a/ex4DQN4zwoptsXsBLSOo+5g69mP+gMVxzcMIppmeyAd/INmn1icXJ8lOlrFiqFo1PM4AhO7bQfu2lcaLMgGQPBvL/cvZs38NdV1OryumpecC78LmR6nLwSsyejxuxJ/PESysZDAvHIL2d3rqQjyr1F3pi+OwywwwnlpFmUxNNn3MrB6cSvLgXNAugOVE+jqMEMB+U1JBfITEeLWmal2144KMYNZDrIBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExP3LrIdBogJMWNLZdsnzTy0LA5wrJnNcksZEDpF1Ic=;
 b=MkusML4OyhlLVqARpcRpBVI/LANa4IXSpUa3ngFoIZ56LQNonkeiUfdMLV31S0lXgs3Ra0AizH1hgnWQmhzwCW73R0duy+yPne+BS1dOgiYXsv/+8cMIYzt8RRNb7VMGYyfiqb+jSAJ+GQdjhZdEOUzOyP2+3Hbc9i1jJkutXhER/zlcRUkZQQgGN3ed7RLzWAK8pFL+d4xwJmD6lGjNN78oYmFMdsTsS5iUkSPoH/Wa8o2xyBHodgOzmQWdYlaGbFwkvT0opy03GLVq3DaJP7yg6x+/1yReGQP0h/uhJpITCTdNcrwMnhjORJKi0eKPAbtShN6eIlGCuc9tTAEQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExP3LrIdBogJMWNLZdsnzTy0LA5wrJnNcksZEDpF1Ic=;
 b=RydqhTpCPA01PPmdfgT56Zzt5fePUj9oI3lw5k5ATwsYQ+CJPgTZ42pX/PD7jcM+1aWge7LQrAak8XWh6bIhjQfVD3CwCF70+zOPhuoFWUzoU5hD2K3wTY6Kv68ymSXTQIpYNN4CkVZrP4Q1VkaIzrDjKiz9PrUDRkpnVC8qdVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Mon, 23 Oct
 2023 16:17:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 16:17:12 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] i3c: master: svc: collection of bugs fixes
Date:   Mon, 23 Oct 2023 12:16:52 -0400
Message-Id: <20231023161658.3890811-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: c8441ce2-d48f-41b2-26ab-08dbd3e38341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s82lZ3STj/nZzL95PaXBPe/x5mRskej6CcvqZZPIsrO9Ob8PXh931VP9pDCx4sT9/RXIUGBToJZQRDmksPcgN9eEvierIIDa3/6KpPilQvRsfVvNRwXtmDOaN5re45skqdUTmCU0/5wuTQIetAahSRe12sjIh9JFpe/Q6V2QOt2K4SaLwNAucvlQ4vcTxRw4r+p8g0qP7fTnonNzX+oENql9OrPGngKVSmRY763wNX0d78C9n+rpmYTlzgUok5xp+gONTUyqYFI/hOqAdub9XEuAXVo5kHNAxCE4Hw7vKBMQ9WEI8OkBjc1DoH4SRnNdd5yiR5WOQ+wZvHwCk1h9yIMooC/tzzy9JDK/7ZmWx/s1RcuKPjmwn/1xN4wAuxgqmEx8BsrH/ueYTD8+eOEWxkaIlFutW1SpfAf8jKn8kBlwpead86MrvbQHfxHGxCF4sdgRawBjo2mG5/mfvkN+L3N/Q4CjVjNJX8fPKSAwqtGiMIPAeVvx3Xp/0RKNn6im+XY+Hky5IIiqWcQOETDWYdBQu/FSNKUbO87LJQX4bd6R9FE23PUQgfsj46JuRxTbNQRzV1JBUI8mzRfUJBOvkEOFkgNGD7ndPfZMrjhSAsdBITacHu7c1saOKWJw1+ni
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(6506007)(6512007)(6666004)(86362001)(316002)(41300700001)(6916009)(2906002)(6486002)(5660300002)(4744005)(52116002)(36756003)(8676002)(2616005)(1076003)(26005)(38100700002)(8936002)(4326008)(66946007)(38350700005)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFoMktQRmZwR0Q1Zy9VLzNva2JCbitIRUR0d2F3RzArYTJIRlBocHR3NmNw?=
 =?utf-8?B?eHdKWDFIT2c2K3psSHlHMVBtdUM4VWNNc2pNZnpBK3ZJWXZNc05zdnhFTFpr?=
 =?utf-8?B?UlNKRWJEZFVieWxBVkwySjhxNyt6MGRZNFJHYUZXVUlJNWViQllPcThrWU9l?=
 =?utf-8?B?YndRa3gyRnRjK0oyMSsybVVrS0h6eTczS0wyTmQ3dFNBTloycWZzV1QxYUJm?=
 =?utf-8?B?ZEtPblBTUXRvdXB1WXZnTTJiU3pIQk1McUtRN1ZNZ2tmR2FBMmZndGFYNGk5?=
 =?utf-8?B?dEJUazNuZjBxR0JKOGxKdVdRc2Fka0pjTWRqOEdkSzNtKytwR2paR2NDazNq?=
 =?utf-8?B?dEoybWEzaitxVGxqL2hLbE9sbW1TYmVlRUJmVjJCWkJvWU1YV0NTWjBhL2t3?=
 =?utf-8?B?eFUwdkZLNXVaaGZrRmVuVlhjR3FQUnpkMWZGNUdSK2RqTlF3OFJPQUZGN0pw?=
 =?utf-8?B?ZGx3UUx4NVdJRFRWY1dySWhuayt4SEJLM3owbGUrTnRGSHQwWWI1eWVRbnlC?=
 =?utf-8?B?RDY4bE9zRXZsa0dJaVQ3VmdNNGhTNEVvVTVRUHNrNFlwaFpZK01zeWRlRTE1?=
 =?utf-8?B?dFRtR1dLVzdoQ1crbFovUlh3SEtFb0NHRjdpSm9ISXFFckdaMklMUmwzYXlG?=
 =?utf-8?B?WXYvWTc5a21GT2h6bG1mS3NYNlkzWS9lTGtYRlhzNi96RDAxNktMRWtVcEpF?=
 =?utf-8?B?WlRaUjVNR210enRWTFMyai95RU1aZlVMWldaZEg1R08rSkg0dzZ3S3JnbWdK?=
 =?utf-8?B?YS9kMXkzUVo1ZlZTME1GWDB0SHVGZUNIV2Q2MHFQRTIvVFhzZjk2RFdhQ3JE?=
 =?utf-8?B?bVcvdUwzWGdFUlZheTZBaUcrdFF2MDA4SDdwQ1dwMjhsYXZsbm9Fd2xpNDhl?=
 =?utf-8?B?VWNrNU8yS1Y0eXhlY29yWmRYRlFkRC9qbHBQdFJrMnR0eUhBOUlMN2ROSW50?=
 =?utf-8?B?U0h4ZUEvU0ZhRG1aY2cyT3VIMk9LTWVCUk9Fd1dEYytjQmZsZFg5NGJUQUZL?=
 =?utf-8?B?MTl2aHNNSEhnOHpGZ29ld04zTlZXMFRydXh5d2ZvWWd3b3RIWTZBUFpPYmJB?=
 =?utf-8?B?cHpqNzByRVFzMDZ0N3h5SW5LU0FwNkFIWldsb2F6d2hpbGpISnVWNTN5ejNU?=
 =?utf-8?B?eUhrTGJNYXVFRm9RcWFoQldkbTFMMmVXVURaVklISU9sbXA4Zm9ucE9QWnRh?=
 =?utf-8?B?Y2ttRkg1UmQyU2RHeWRTMjVET0xxRjRvTU5kVnJ4bERKNDlHUTduMXBlNEV3?=
 =?utf-8?B?YzY0K1ZGSHdjZlFKYzhkMGNpZlNCVW9Pd2JJdlRqa0VxN213UkVkNVNJU2Zj?=
 =?utf-8?B?UjVzRk1tR2FERE52bFRqOGN4bUUyQ0dSUGtoMllYQkpYVk40RURZTExtSXlw?=
 =?utf-8?B?aWtDaWxlbE9EbGpvVTdrYzFDSm5LZ2Nkc1RDejhOYXlkVi9HQmtET0pibFFn?=
 =?utf-8?B?ZEkweXBLaytiS01TdW1nV21hdm9DUU0vK2ZvaXdnTktzeWtQanUxYXdhUXhT?=
 =?utf-8?B?Uk9aSWN0bFJmVEl4S2VOVEFhQkJXekg3TnZoMlhyU3pkMHBiK2Ztdk13cGdI?=
 =?utf-8?B?eWZ0b01nWTYwMncwRFBWTDllVE45TkVGRlBTWHk3SmRaTkRFcFljaUFvTk45?=
 =?utf-8?B?cUxFTWtjMFdndjZPSjEvNjdMaVFPRnJ4YXpheVMvTytVa0RSM29tRkhrQS9k?=
 =?utf-8?B?ZDJkUnRsSFhmMmpjdVF1NGM2cUFEczVRUmo2L2N4cng0cGdhaFdJRTlUblFT?=
 =?utf-8?B?dnVsWGFGWGw5bW5WWUhOM0NnMTZHQVd4bGJpRHVPWndxR1VHTnZBenpobDlr?=
 =?utf-8?B?eXBSWlhNRW1hUS96am1iN1NkcWI3Wjc2S0d3MTkvMThqN1oyMmV1d2o1QXFC?=
 =?utf-8?B?OHJMbXQya1lrbWpWVUpXRnE0VXI3VklEYndPYWNHS3JjQnowcEk1ZWZjdVlW?=
 =?utf-8?B?RlhXdmd3SUExSThlSHJORWlwVkMrMVdtNWhiR3BVRGxKeXJvNjRIbnB2dUpk?=
 =?utf-8?B?L2hqTHVCWnJwMkFBMUFJTjVVNCtsNHVUUitScTIvelR6TEtsc0E0TW52RFp0?=
 =?utf-8?B?QWJsVGNEMjd2V0FENktyakVuSEY3c0paUytoTEdYcVp3bmNqK1J6emxlYXor?=
 =?utf-8?Q?eRZyzr/ZNlUSG7iuPo+OboMfC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8441ce2-d48f-41b2-26ab-08dbd3e38341
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:17:11.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+M5j5irfsmvF1izcxSWff6ZhoKQXag3zUxgmF0lPtGCPLCG+F2PWYTGqj2OUYQtoTnj/AaAJys57VRksnlD9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each patch is indepedents. See commit message for detail.

Change from v1 to v4.
See each patch notes

If there are not notes between v2 to v4, that's means not change.

Frank Li (6):
  i3c: master: svc: fix race condition in ibi work thread
  i3c: master: svc: fix wrong data return when IBI happen during start
    frame
  i3c: master: svc: fix ibi may not return mandatory data byte
  i3c: master: svc: fix check wrong status register in irq handler
  i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
  i3c: master: svc: fix random hot join failure since timeout error

 drivers/i3c/master/svc-i3c-master.c | 54 ++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

-- 
2.34.1

