Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649BB75EC44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjGXHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGXHMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:12:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C9A137;
        Mon, 24 Jul 2023 00:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vidi7HMTL2aLToeoBTlsAzH1zpbtWTgnTLT/oAWY2ows01+8rnzpIvNX8NQwpjESxVk73SCiXz8W8e0GxjgId0frWLEgf9gcghW7hEUoccYJ3DE9BOSnsrBYBLOVt0vzl98nFOFrhdmEYG5z2/j/3pqPUowy23Sa6BnbKJ1axsS3CVoZ0A2FvRRCzU/f82QdqjBh6WuqO0CV1Ek6HQx0+xPS8uEZDw/a3nJJRy7QQq2ioMH+VhjUsj9GJ27gD1SoQpdECcBsIy/2RfDBnRUVZ8DztIqMv/JpE6n4SEJhoeyCoYDI8bJEfGo2E8RROI9az5IrKirFvX5zNKYf03L4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBiM+nbo4w2Nxr/rHQEtgLsUVUeBjBAl2vsI2sgeJIY=;
 b=LIgytFXnsWeID+LRJ8mATn0lWp0MaMhvGfZbkZ3gr0Ks2iIcmfCN6qAozc7qQVYsN7gHtqrDOTh0XRPhdndyjx19tjAvxvthJcuvcniaq0YLA0d9hgZRurVvnJQvMHf8uYchdX6/IandvmLobOjj2I6HbhY9mun7tr0iCa7BlaO1A48RLur/WE1JaUlCSnm+hB9+p+H3lwqKAPx0ictKFiRwI91r3ghl4mHxyx3p6Jsz6ExHbuiiWKHQ3F9AY6Z2w4/dBJuzWNHwHXnPe7+i6x13SRn2blaeThu1Ox+qCIVzNT0ARGfAEZuU/prygt3oGmulLPxh78fDrakZ6+lFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBiM+nbo4w2Nxr/rHQEtgLsUVUeBjBAl2vsI2sgeJIY=;
 b=Iy1fKgZPfi7uqd4lVA4yzzq60t2Ahz11URKcBWcq2Gq4IFKXIQdxbgKaUpcCYI2IZej2MjgszXO3Zg0kVsK0R6Tlv81sX21TBmfL/sNJVFJ01yIpiB0fUmvOkfe8BSxLjamcUsJifAHIdlNUqjmILr8KMXgKtQCG3zaM2GkFADo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 07:11:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:11:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/2] thermal: fix two coverity reported issues
Date:   Mon, 24 Jul 2023 15:16:44 +0800
Message-Id: <20230724071646.2744900-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b9862e-59b1-4744-63ee-08db8c154554
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ka8pr2Xfnqi7FtfATAYp+HpJ8scjx711iqoD8d3Kqks9plKrx30USTCRIFxjJYPAC3ojekDNDs/mfgk6+Ax5DZORVUoD0HHW+YeYA9wCjhjGW5b0qoWFHd1FS5+cWRNY4eP0Ji6zqzWlCS/msPLQapzyV2QcX682sP6mV3oxE+bqEo2MirgsgGaQs3WAjyNvSfiMiJ0TC6ChQQETU77qtRHlm48SklXi/Q2CNp9Tw5eo3gNuq08T2j3oMDEerOvnoZQVhcgJ90/eOJoOW14kvYmwt0ub3Z2VMsrL4Ps5RPvnooNwM1K72sJsy6Fhh2+uvoLPdjdQU7ywACscgYnOy4N40JWO/HhmBbR60aVIjCBqDE2gujyC4NcYN9iPlCmgGccYw1S66WXD+m3Bin9gE7VIqJeAukBZ8uc2Q4dmTayz2HML0wBF3YPqqYFNAERAwosSngUynjM9R+KW9YhEpXyl3YYx+WmkXIlkemhhh1xhlKBJx9eOx+oHGpLqEO7GWLCVoKcPMMEefHsHuZ4BTh3x1ZaZhbU/99AbrwPBivQle6U/lWlbL7p9XgMWFRSViwEKTZI4sDAYWh5TdRE7Y38m9h9lG3ksMJocbiUXq7G4gcsfg7/o41HnJpg7J57F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(6666004)(6486002)(52116002)(38100700002)(38350700002)(26005)(4326008)(66476007)(66556008)(66946007)(6512007)(478600001)(316002)(86362001)(2906002)(83380400001)(2616005)(4744005)(8676002)(8936002)(41300700001)(6506007)(1076003)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ViduhjS6Xk3+aoYfu0ma02tVTOeSunNmDuAwI36S0i+NN2mSNbvM8Qmd8+u5?=
 =?us-ascii?Q?dD7hu9h4Ilgr+mqDNttX6EcHg1hyENFHeS/S3B79rHLm8fFedAg48LqHu07T?=
 =?us-ascii?Q?pIS9FXXP1qmezOidzuWtH8DPpSznwbI/kv4Mad3DFvcy4u9d5whxBurfnkip?=
 =?us-ascii?Q?gpoKIZMn8QTNBrarxjzg5s9CSIxYMAeL+GMa+l1PP76HB0qU+ypdZPVGrz7u?=
 =?us-ascii?Q?Mp821WtAek/PTYf63kaZifwcRm9/xIV3s9MXSkJUqS/K9GRhTfJKJNPuFk88?=
 =?us-ascii?Q?ut+QqFpvGDDckJ9vSpoKeF4Gldh3rdzL1HBeaVBGZvzrBicoxRNLZULwJE0M?=
 =?us-ascii?Q?S9R0tYHN6MyOT5rpdtAPZNLLIYuLGyxPdTUvb3SBrhVRgBMznup8eyVTQpBM?=
 =?us-ascii?Q?L63UW1tDRUrQWcvcJbpiKffNvZMO+iw6sEBN68CRVeGiLDywGz3mLO2zu9xK?=
 =?us-ascii?Q?uXYVh01fw8UlZdQdWmnEbKtL7k5sPC9BSpfeITi7BP5miybQraC9cpu4CNUo?=
 =?us-ascii?Q?o5jsDulCkddGTxACgjPKl+WT98eq8uV8LTQ8ZjlV/IE5Lb1b2RdDGu+TvTEp?=
 =?us-ascii?Q?cq6unch93UEYpXhOWlBGaWNe4xXQh4hqdhSzATKfvgj/S0lZGNEcI5J9R5A6?=
 =?us-ascii?Q?TDYCz+1Wr0QFP1jcOjg/DopCFnOQkll+g/Q72F8yMAxgKo9/+iexZvl2eEYx?=
 =?us-ascii?Q?Tp7YuVo9IpSVApDAUOU0AwSOS4C3iAZczn9YLR+oHBaRtnHnilLGJ9AVt5X9?=
 =?us-ascii?Q?uM3PZvW6O+85Ov/o+uebbDC7icxxJWIAY4LBEk9sJAcgo66a5a3GAa0IOhNG?=
 =?us-ascii?Q?sED2DF0NE6g01Zqn9PtwCCinnoFXJ20wWyOt69snnj7NgSFuxgVpfyu9IZj7?=
 =?us-ascii?Q?pHVTH9tngtauHEpzKc6w7ymDMiP59S9vJm1r3FPBZ7u59O1AgVgtKVUbTUSQ?=
 =?us-ascii?Q?XT0Gb6W6WRg7cWWf5AIH/Fcif1sOF5MFA5n9aeFnIDM/zW6D/dT/uewpdMHB?=
 =?us-ascii?Q?377YfYQnj7WndcePLi5pYd75tgiCqRwn+PD2pFSzvo5p/GB/e7nLpHED8sNp?=
 =?us-ascii?Q?kKOFZ/5qF8u3qWIKTWL1bX2qS4mfWbNIJiTnNsdccx1TjBXdWHG9FtHTfDXb?=
 =?us-ascii?Q?e+939q9eU/CFYCHlNRWTZ3x4aFVlocr8d5Jp1DSVaqjEP+wrN8b38G3lhVHB?=
 =?us-ascii?Q?qLqk2zNHoR+84xYfzXxam0ZJUdgzCsqJDrr5D6gn4jSrUfpddEgvNNAQARlt?=
 =?us-ascii?Q?KPMnktM3fGWtP3eCT3IP3i3BjurQ2BpME9IMiqAmt0L40BWm7O1vENurxB5Q?=
 =?us-ascii?Q?fF+HiXGGqS/7YFwDorIBAB8gfZ76kKsu2dEx4ZYLDvZfvGfXDJnXIF9/7+fa?=
 =?us-ascii?Q?LhDKGM5wNTTRY34/oU+vzKirUVYCAj0ZVzZqrybx+/81+gWxbK/bOgUcIVhf?=
 =?us-ascii?Q?tGiLQStpEvBZtuuI/rGP6tAeIP26zFakl8r/fEhyLjqgJBkebByX9wngsA5q?=
 =?us-ascii?Q?K5KBo5zEjHQf9HqKGtgmz6F5QcdqGLUH9vffVHm96KPojyYuWYekmY/1soQP?=
 =?us-ascii?Q?bkl7UtS+oTdy2kk68nkXPxgdztYJSE/AEbVI+bS3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b9862e-59b1-4744-63ee-08db8c154554
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:11:59.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeEd9SjNjl9FVeVo+OemJ3K91hqKfSijNMtJVEFBx13idqBI7KDGXyBJnX+0yjD+QgpyXDpiTpuCt65VUs5BjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8567
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

 Fix two thermal issues reported by coverity.

V2:
 Add cover letter
 Add Fixes Tag

Peng Fan (2):
  thermal/core: fix potential memory leak
  thermal/of: accessing potential uninitialized value

 drivers/thermal/thermal_core.c | 3 +++
 drivers/thermal/thermal_of.c   | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.37.1

