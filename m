Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE157CE1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjJRPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjJRPso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:48:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9435F12B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV3GhGnX77bCWJDXtc+GBx/BQCalJ0WBQJYLVUTS1YG2aZ22NwWD2fPYJYd6a7pwb4jTVahzNikIJmLMR/S8FXc3FNC55Zc0BD6ODOmeRmUqpHeEcpj6KRvRlb6WfVeVJwWIYEJaJIvKqZc7/R7zh1xsmrL7QIAhtzLqTeVuVEkBpe215B6MSwVFDXc8zTZvcxkntE8EuK3K/92X1LnR76EwGpqwLfQQw7oTpMQKTCGtUxHAKwPdXr90HZA7krKuun4WKj4lTreWHPuNK9Us8PbYKsxdjkoiDUo7H8QEB7KdEAHRTVTH1XSbhrLnUciY3pFu1b3cUDtI3tYitfsdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmA0TmfYW8MJ+DqQikfItM+khhjIvm5K1uwmiII6AZE=;
 b=lStxfRtmJbGx8B55Y7Ik43+YdQ6g6LH3gZZDz61mbus85+21+AylwHfCXoo7vOkarzz7Qi3JznMfmEU7uI6lqHeCkUDWcIFd0vMVD2zszXYkT1TSlTbJGl2Pz+XdIEyddS3jcKuY7kv9zSysP+DpbNAf+7PZ9UfApUqv69qB2erVlblXTER/8w5R5QwtyceHbe9lSmugVn99gi51K4/ZhXQjZRAfinIMMDGUOGxDBFSjFpHs8NU3+1wU62HSGyVL8P1S5b85VB5TNaHFmMlq6v3dT3xHeiLpv3QP/7oWS2XMsxKFdOa7noLTGXHdxVh/wBI3nCD0PWwcZBDlnBmLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmA0TmfYW8MJ+DqQikfItM+khhjIvm5K1uwmiII6AZE=;
 b=BEaFHAB6VDbsMMlUgo69cCkGE2ySfMOXEGRVbxSovR+vH47CTMfZFlNadOu2vtqcwQuTWtxtt/mR92bTKv4Zlbrp5GCndqIzS3enF5l7E1dfrzi79jRJjRr3EVDYzSktWyxNsmhU80/zARJzbY2A5ETLTRk5IFmdfOK+19iqKk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:48:38 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:48:38 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] i3c: master: svc: fix ibi may not return mandatory data byte
Date:   Wed, 18 Oct 2023 11:48:07 -0400
Message-Id: <20231018154809.3304558-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018154809.3304558-1-Frank.Li@nxp.com>
References: <20231018154809.3304558-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deb1180-91c4-4248-c2c1-08dbcff1b1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbe+w5H0apfWOZZNQ01OrziD8IaJqDRL8hba/zyUqCkirsK5Cu9nKV8MiYCKE4SoT5peguTEbqI+I6mI5evgK5KXeGh/fBrg+PtAfHuRdp/e4uRlNwHOji6tk1V8YUGLViZVBjUdnkjUyrDYW0QRze0EDf3XerNZpksGeRnVuSZqJWWXsAuQTKqK2WWicMaJN6QTn49ppaUheG4AsbhStMM5pDXvO2Q/zki3kP+84e5x88QSaEezWE2ZI/HBP/oNYraxBFoyVGjNbwo0jyhKfH38KE/VgEnp+UDj9jmiWMn93Xjr3H8i7OjRYi70XelSFVvNxm0AzbPxlb2l0/EsAFA3tEe5fM5y6YAyU6+hiE2+1RjMBCnqT86UZqyZXCTx7In0HGlU2ByDUqKh57SbMnKtnydh9ZKxo0vzmKV+9I+8kITCCu/314AEK3HIWyUc8PnXVbh53k+d6pOQAyeicgwxBP7WOt20mZaEgMTbh8mhsZj2VWwiBkx2EG58GmGLY9nyqm+CbQ3yPPvWP3M57BL/13k0Tx7dc00XebiaVGwxGmP0IVjw5XZZL1L2CWi0smjOx4iFq2uT21CzenLnIL5F0xbUX77shGBb8k8EEeUT/UW/HMpb3EBema/lZN6k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38350700005)(52116002)(6666004)(6486002)(6506007)(6512007)(478600001)(66556008)(6916009)(66476007)(316002)(66946007)(36756003)(2616005)(1076003)(83380400001)(26005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjuaCyS/KmCK38k2Ppy9tfk0XizCa6ZuomtOKMGfaE/i03sLPDtbyTnt0+tP?=
 =?us-ascii?Q?PQ/gGYUKnaj4267R39iD2z+lMt4SJtU/dfzhv91t/5Qve6WwPVtIJOdGMR0u?=
 =?us-ascii?Q?TMDi6xZmYu/+BZgAe5wWlAprO0rHyaBDNbMli7XimCK1Es6lQY3bp25xOX0Z?=
 =?us-ascii?Q?sdZ3cCIXsN1KbqRii6MMxVWwmHYBH2YIQnMKGyL5cJM5qwAWnyyYNHmK6IqB?=
 =?us-ascii?Q?E3Cd4RFGdkYyYk7bdiTKT6E0eyx4nA6qOA0/X4FlqFrnJ7JxjVBB/5wGuJGl?=
 =?us-ascii?Q?vpdgMzM1bMzkpc+l6PH5f8Ab/vpqzK6d0dyywCGWPuqjb6gLD0uN3++ilS0a?=
 =?us-ascii?Q?KgrYMJ5SxLaxmKTIjtYeo2t3Ltoong9g9S80TBb2CqTmp7zPuUcvqnOxFAjd?=
 =?us-ascii?Q?7zf4SvNWFEH+2+Bequ1ktAEPHMvV/1tHMtBUlcZlakkv+9/Li9l0kec1+7Vq?=
 =?us-ascii?Q?mEBxmiyH7UZRwfb1Ag+0mtXEtRt+tBMB1tH5aJM5t0Y5lRAdVc5JR4NXfFoo?=
 =?us-ascii?Q?cBh+y6dprEFr1lAsUMQmm7/PxSecjxKsoxXmx0uFx6my5ALJJ6dsUYvIC+BQ?=
 =?us-ascii?Q?ezfo2mygBvso9rJe2bYIZCnFpZrF/7uhLmpPVALM6LxRhDR6w/qgamIxaVPs?=
 =?us-ascii?Q?QQBNkB6HDHHX/dhhtyTuP2ZymnS5CBCNYKld23YST8BB8Ttcbf9E1jQOnumi?=
 =?us-ascii?Q?N1jqghgZPWcHDcxA0Qba6hAmdojzhrWwUAGuRHenT3gFSkRowguEP+bbuedD?=
 =?us-ascii?Q?NJc83hBUJCmkQ6T37Zw8bGjp3uqVer5nqj+vO05/PQ53tmEj3c1GONAPw6Tj?=
 =?us-ascii?Q?5M1owAInqNOAUrSAG9Pk2hCbKuXDAEYlrYzErBx/dtaUHISmNdmqbv/WaLc2?=
 =?us-ascii?Q?ADm7iGhdKDV174C9PrBi8LBE5BNh0nUOJo9bhIbAMkJLbS/c47y9GCvPqhbW?=
 =?us-ascii?Q?RswKR/y/mI3yVcjyv6sY34xFbkdrIHdBTfNTx1XpXJraoXmAdW7cE9TihLgf?=
 =?us-ascii?Q?G3fgSYI6N5dSZA4QrqMjzp1v4Hst9HGLATiIkl+zdgRjsr6T8JzN0NCMy7G9?=
 =?us-ascii?Q?+NMQH4okKkmliDGriILapnLuUmSQTjkx1BM1dOsHkZBlfDxH521HDj2pEjiM?=
 =?us-ascii?Q?/f1IoEcLE6TvF/rk44HH1Rn4QxXbEKiM3GFYGwoyuJb/cxDGgMoQG1UGDKX2?=
 =?us-ascii?Q?pxAt0aXAzgLl7AhW3fF4JsX9styE0u90+0niJjcQ+oPSI87ZCXSXcidzEoDX?=
 =?us-ascii?Q?yeUnxvUWAv9vkIO0QEcT+cz4RI5ALGaJwD8heJlOqfywxcgTKP6mKLsqQpWx?=
 =?us-ascii?Q?CWlE2W5xBAOBnE9ROufABGTwlkoL/baTkKK4Np+JyiKJsUoPAQY20U/pqUfQ?=
 =?us-ascii?Q?fkv09SlUACRFNciAopUUIzH87/ur+bo3a8zoZTTCiU8dPKMJ7NkcTFFVcWIj?=
 =?us-ascii?Q?F9rTaWpeaMXMKceQasUEul/EDx6/2EGbXlInX4yUwU56VbLe/Fnf5DTPPwLA?=
 =?us-ascii?Q?V9mHOfFixaP7ymd5nZa/RZc6RCkkHlXEehSZhM+9AfYNkNk44Ipzy4rBZpNo?=
 =?us-ascii?Q?kcNeLBjFN5A48QZLCOfT7D+M8d1m8ki+JqDm1QLC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deb1180-91c4-4248-c2c1-08dbcff1b1d4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:48:38.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogH19tpNhtZkONen2isHhbejKbKjlaM+yO53avLYa8F2Co9z5/rxbVBqscv+CkKEXTQ5HRLXE3thw4NaM2cw1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSTATUS[RXPEND] is only updated after the data transfer cycle started. This
creates an issue when the I3C clock is slow, and the CPU is running fast
enough that MSTATUS[RXPEND] may not be updated when the code reach checking
point. As a result, mandatory data are being missed.

Add a wait for MSTATUS[COMPLETE] to ensure that all mandatory data is
already in FIFO.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - update commit message
      it also works without mandatory bytes

 drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index abebef666b2bb..dd06b7c9333f1 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -332,6 +332,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	struct i3c_ibi_slot *slot;
 	unsigned int count;
 	u32 mdatactrl;
+	int ret, val;
 	u8 *buf;
 
 	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
@@ -341,6 +342,13 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	slot->len = 0;
 	buf = slot->data;
 
+	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
+						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
+	if (ret) {
+		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		return ret;
+	}
+
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
-- 
2.34.1

