Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808547D04C5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjJSW2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjJSW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:28:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0ACA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi5eWBuv64A0+TjRYvqrpy0xsMI1Fl/Y2L7kAS0scTyLQsCVmJxo0bKAWgoyCUmLAk/DfgrLrrHMVZGaTp5h1goiAV9j0Ww2ylFbjzlwuJnoPnhUs6F8tme8ZC459pVyEcPdswa6YIDsCPa2oD1OVJQzZMbPNjOfkxjZVcxAXbBzZ4hPsDizqcvjKKP9kdFG1T9+E7GtZSsIt2KTKkpdMWsh6tioyIIjxFaqLmETMbe/l7S82aYBDmv1oN+Jyk45M3PN7ChKCi9TDWJMiyYInvG+sY1A9zK8npT1+A5EFNCbfny0WYgvJh3E2nngLjIbK+XBrtVdbHVgEZdK1ifmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1zxEdHosjsiGCuea9j4jS7nMFZLaSVEQbKLdH8s5qY=;
 b=k0FgBOwIp9recCF7kFOPhS4DlhXVqNo8qZNtPSrRzw1bcT3fhhisuD1niEnu/HD7sKfQO3aJkfFIXpxcU1su4srSjwOTBfRUnkvuX6a/rW0sV9b7cNRbTc5LvsQlIUHv0mvU8eMtapzh3t3S+cvUAaxi47EJhoA/uzHQr/Pg1QUb8Y+CsX/ydHJDOEcfT82Q2a8EsbLGQIvPV3TM1ZTegqV78Y3LKcIvfjjsuZl1sCnmhBciTTKGDW0/8fpEz0/DEHgtHDSsE50Se8Cm+HehEor7wZ99Ivhsld/HJiiNcN81DnH9KzVl8SJjDqMZQ7wFWPKgwIuDJ9LRvEQKt6XpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1zxEdHosjsiGCuea9j4jS7nMFZLaSVEQbKLdH8s5qY=;
 b=rW9ekDCUyXCpjsr5wK/zMNAyBNMChnKeEvNqTE+DNacDjyOG89Yu9rwys9R2q7RyYpEFxJKh2xBTCVbpCEyFm5I6LEPJF6lfxwioDGcwg1a80q55JkACeQa6PldGxLNkd2UK+pKyFPRQjv0V0ts9btjKeGcJV6MmpvZI6/AT9hY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 19 Oct
 2023 22:27:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 22:27:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
Date:   Thu, 19 Oct 2023 18:27:24 -0400
Message-Id: <20231019222725.3598022-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019222725.3598022-1-Frank.Li@nxp.com>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d4e91a-a88c-4151-87ea-08dbd0f2a28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikldhn+JIeVUfEJ0BAnRb+HZpVdnCvHN32GGqmTdBelBXJVAfNlFEzbrgG6/P9OSUMtpvH9KwcUaXwny+8mVQ1vYKWCNYujg6BxhBHBsLhS90x3jUM1XUNIXpLsNcC7bT3hc11hS/0i5XjT4jRS+ILTavARC4KjtIiyN+qAa868gYI0AXpFKM8IILHm5wEygLEk7c+N3vWRLJmTlSFcGuQnFHlh0057oAfr9hNdEDHgqRnjPy0toWvdOwMpwIoMZ9Aw+jowb6n9HB63YmdusnoNOayVA2Vj6x2aOVJWuocjj8U8d7aubRTQjf0xZF6dN7hmK50+IhYQIf0zv0XdLOOfJTyKILoUHqqb/UglfxypjCnSbeOK4QHnvkfys5wpCB2WHLCPI7VJiObn4zYMXTY+Lmx6/Hrv2Y3Gz5+CuIlpWKyT6i4i/p1jd/CP3X/MBk/ggA+2b0S82yiSKzeeLk0a4uRQ/wFGRerZeRt16hVKGLMV/SgjrG8fqiB9lPaOVkUufgXDlDJOZEni7osRFrFJpEvWwnxZetKsUIZ/PT/QARPzo/7OWJ6OcDs8TKirQj1HrVStAN4x0wsO/sv8fbLv1MzELFX4LXnlEthPGIczRcx1+xmLe6jRQhji5jbKYccKKu3ptdLZC1jMabQZ0kWGMc+KFfCghWS3Mex6G2rs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(83380400001)(6512007)(38100700002)(478600001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(86362001)(6486002)(52116002)(2616005)(1076003)(26005)(6666004)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErqE0XaMBw9cFm5QSlr5lTfj3RxFJrAIFQT0kIFac7XnUFOa0caLuQQzaHEp?=
 =?us-ascii?Q?aSqHD3hTs8Q5BCCmPsbStpWGMPelR/mC1Dlh3I1mlOxGXiIGeiM7unWMHJrf?=
 =?us-ascii?Q?WeDGmNSor/f7CVHmWhWGliMSzLnXDP0UegEZDRkojDohb33QI3SgO7IjdhEs?=
 =?us-ascii?Q?73qAPBwXw5KzOXKqUIY/r+1WRvtm7vh94r2nge815V8YDz7s4Wf5HwDFCmYJ?=
 =?us-ascii?Q?uz7nuEJTSLbZRHav+DFgVXKwUXNcbIc4ZG759Dsr2HQkmp+6/uniUqhheVlF?=
 =?us-ascii?Q?r533mq3jOiwzwBNfzHS2slRUk3XJtqj3ahUEXvY5i+yXW55L0wA/wwI4pjgL?=
 =?us-ascii?Q?jNfzrECRqjqgoJe7nCEjxT6ONi7srEpjHWmfsuhe8oIjpLhm0e86gIsfqsdp?=
 =?us-ascii?Q?qJnVmodvwn8d1TVddFpXnhsOLGQ7gPa35M2sh5tx0YEb/g9DiUXExpllB5cu?=
 =?us-ascii?Q?WRThgRk3e/Ws5pfLSZBroRGpeGfcYww/4e5APaBCeNa5YpmsVxLtXtVUc6jv?=
 =?us-ascii?Q?pxKSRfd/Eb39JgEZYwKiKot767kk0g2D1LV6S3YjHMRkygNe4LWI3OWBVuZn?=
 =?us-ascii?Q?iwnDKAXoxYqOqC+Gi5uWt0OE0sCfJBfKuCHb6bYXfor3QAY34Fx7m7xfDGLE?=
 =?us-ascii?Q?s41s2nB+afNH+ofHUs8YPtwxlUMG/5cQdc5+L/v/03wPyKakzQjFJnt/x2R4?=
 =?us-ascii?Q?9FwZ/YAUedTwzrg75osJYcEWGl6r8Es9ZQWKmP+df/50qllfk2MBw+J3knm7?=
 =?us-ascii?Q?F5c81GtIJrKIh+QzLNOmGaHABGirWqGX1LDzirTjjBzz6vh+rCiLGBEXbjTW?=
 =?us-ascii?Q?6kncgqceonbLWYaZYmcQLwHabw4NkL1GokxGsFbAiaOUv+UPtpE9wb7WAdfj?=
 =?us-ascii?Q?PePMNVcwdtXmbBWsCNLtwhaoo9zIDCbSUNAAH1Jjg+S52RucAXucCpG6Dn1O?=
 =?us-ascii?Q?96sF/iNKobXzUW8AzbE3Ptnp+0bhZ+jP3deix6DWRoSoqsPcdNJVNxSh2fCa?=
 =?us-ascii?Q?kXIB6gPgDeccADtUT8588vhXFm9K8OowT1U+Plxb0LlWjOUl+MMf3r2spuVv?=
 =?us-ascii?Q?Vcx+V4fh0NBg2deaC5BIiKjbB46Flsyw9PksGy7kfnYCfVavpzVOsn7dDhKW?=
 =?us-ascii?Q?c9urSpvPrP9y4DnZtVE7eq5SlOnlb/joJW/RU5rTu52eQxWh/43uzEMfAMwD?=
 =?us-ascii?Q?SK6Iq3EGLL/lpNHCGWujai39O8MIOMVbSqtSw+qHD/2ITgjYxtj3vwY9EGmZ?=
 =?us-ascii?Q?00zCmBXR/mkfUq4nd1r6ZvA1/zSdYYezMw9eTupscrziY6mzlLkfaYqMWY01?=
 =?us-ascii?Q?k3yyLAVFRr+jk5qWT81/ygDwY192N6j7PAMwnUCwk7hV2v+lW8CM5zrwkvwQ?=
 =?us-ascii?Q?vd1fpRvImwE3qyXaX0TRYLrF8xLhb75N2fKGqp+mDg7w0Z/EhUUL7/8q/4GK?=
 =?us-ascii?Q?MI3LbafKf22OR0GAvFs0I6inHcnSxHl+w/uBp3iybWWseenOZZnT210+hRAD?=
 =?us-ascii?Q?9PuOckmVPIIMPnYi0+5Cn/JAVxSq8EjzwG+42wTrJ0sDfCB9tt0ikjUMgCSP?=
 =?us-ascii?Q?B40fLFEOxw/JhkeqkLA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d4e91a-a88c-4151-87ea-08dbd0f2a28c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:27:53.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4I7Vcp/zs56ZyYrMamEaLGlwx/hv6sxlTJXeX7a7LW0jfvmpsrHknwltANfH4iv4E7GwhiyvD82RMAlQwgchg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon IBIWON timeout, the SDA line will always be kept low if we don't emit
a stop. Calling svc_i3c_master_emit_stop() there will let the bus return to
idle state.

Call svc_i3c_master_emit_stop() to let i3c bus come back to idle statue
when IBIWON timeout happen.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - Update commit message and add review tag
    
    Change from v1 to v2
    - Update commite message
    
    Change from v1 to v2
    - Update commite message

 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index b113460f059c3..1a57fdebaa26d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -404,6 +404,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for IBIWON\n");
+		svc_i3c_master_emit_stop(master);
 		goto reenable_ibis;
 	}
 
-- 
2.34.1

