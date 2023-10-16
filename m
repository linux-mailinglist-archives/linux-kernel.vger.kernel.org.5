Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD97CAD94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjJPPdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjJPPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:32:59 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD3FF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmC7We94+7hL4bCAfvFTxmKhDQjf597L1h2l7xaIz96qN8zbSbn5DhXaovLwBgj+7BfC5bDv+Dk1BQL4iSIFqyfG3CZaeMhiI8U4TkIsdj1qI1JZge5YCr5x7+CgYuIUadW4LrGedDy5Lb66dVN/2BgRHeH00FEDQzIbNqUi9n15PX6qqfiNVjJmzPjEobl0SdzUUzGc5Mq11UFaGJCeYcCX3gtiORm8DNOjcNCNpGf/gDNN4Gj4XfHPOg5W5LiQQdd4pTQZyHv3WodhjvlxqRoQbhRjdyJfMPfKHsBntcq1ZR09JRGPjUjWA7JM6qdIYWOBwx17GZ2a8vUb+UYxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pkwx0UMNI50CmR+xgaVcJ28Fsm+ChWROSyDoeW267Xs=;
 b=mWAKQJCSfP2rL0HC9WYZ0dOlhNVbG/G/G8E3fN14Rh+ZE8xTPQ4fMK6bVlvsRpCzINKmrRp/c3fZG06/BenZg85FbIjxELnD6RM6OmPVe9sLKg1yvymN6p5PRuEO1itGNCkIYZCh+O+AV85fkL5wulOKwKfaed+m9+r7H6HN/VCpkMACVwDcvekFvdLPFqlxSIT+cRaid/8m+efq1we7EaTMvu+6OsvC/7Jxc1wOZGgXhYNV/hwH5u60exKirKMMi6q9E0bxvKfKk2xJoJI+Bkmdwvp5FC0jtl/hWIO7nn6O2EnUptHuWV1KdgCN0YcMYI6qpEk+aycx9/qs5pQj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pkwx0UMNI50CmR+xgaVcJ28Fsm+ChWROSyDoeW267Xs=;
 b=S19mgDaQjfosE1u4yCHEYBHim0Lk8UVm+DNfqJGKImpYY06pW24UaN5CLRVkMSe+G0sOMTkfaDbajlwUjrc4Hm4nlRo8C6q/tQKu2Iti5B07g6D7lYtkdvfHYjrBsUXbOYKveotgW4TsayYR9kEVXZMisM79fFW05ZjVm/WNvTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 15:32:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:32:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 4/6] i3c: master: svc: fix check wrong status register in irq handler
Date:   Mon, 16 Oct 2023 11:32:30 -0400
Message-Id: <20231016153232.2851095-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016153232.2851095-1-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 958d9ac9-255c-4b13-75bb-08dbce5d2ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AklonxF0IOuaSK2EjHqFsyVkmMVH8hR0oPnavOguDnuEPcqXborvhO+eyJiu0p9JOxfs+0vT2wcBNSbQpo6LTkGGHPQxg58SIE7BErt4Qdy6GpJScW4bji/zJotVhQ8hsM/yhlpGClF5f8nHX3w+nFLV4P+vRupDxH2tTGZbnlfWMpq5jGGBpkDQMDcqGqwn3RdcQmoO6AJ6lVr0d1QKln5WITxNMOxHeLdCrEuvrP1xYg63r6HR+0Q4UpCVfcNIOL/Y3BklMv3CS4lAoWznlrP+l0Zz7AsKvE4DzK/JPJ56kGB6ZnnzDuRKjS+rf+m/fr3r6q9L9xdxOC+w+HsWD2zX9kCnFfhE8ENTAX26Eup67UTZo9N952Sk769fW0CBR6slQ8hfxPuXI5/39hljd4Y39FtxFGA1XeufEYpCkDgAON4NocaTZFWsYpTiedRGUroigBhtxXdiyGLigcgZ8Q/76SqbKw+dbCYvuUmnG234L28dv2ggryd5hpbb5Cf8uK+kYJeXr1yaOi+YNE2HTMD2vRbrcUBNYFfDSdKGZyn+q+Yk502ubKtgI4xPUH99BWfW7CBIuHVkeDqJJ2ajq8J/4nT+Js0Gd+lOuzaS0PM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(38350700005)(36756003)(38100700002)(83380400001)(6666004)(6512007)(26005)(6506007)(316002)(66946007)(66556008)(66476007)(478600001)(1076003)(2616005)(52116002)(2906002)(41300700001)(4744005)(86362001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lL9nJCaNBMiAiZmDrLSExmgDbVk5kNZIGKh+DReo98rM3GhTegQ2pxcll6Ul?=
 =?us-ascii?Q?wtcKVmpEr8aq2muDMSzl1uPdrYLIsKiyQ20J21gduummISRSAuW4WS0FamTs?=
 =?us-ascii?Q?8J+xE8s3r5q15F0WnbylMctO8CVbmY8+2o5CH0iyOD5FIgtdQg/1KlWpzuCp?=
 =?us-ascii?Q?GdrqgMPK5EStsu2KUOdpawwBQha5MmQ8taEdYBA0ijcAJGJQfgVnLH6zaYn3?=
 =?us-ascii?Q?QScVbfRSQp+IKagRidRktf9KG94crRikgqOQFe4Fh8xKUMmMERfJpG5AqhmB?=
 =?us-ascii?Q?0lEJfhB/vZXtxhj03jWt/y42lb3bUhB77HhWFDl1AmCF6tCvfONCahUVJE0A?=
 =?us-ascii?Q?L/19Sw5UYJLzO3ouMDVaVLL7SaNbm/2t4SEhA8pAsf2zp/oQFQmi9evQ5UQO?=
 =?us-ascii?Q?YZfKDGnVp2Wb9GRe2lamdRRJEJm2HnAsm840C9H/VYAHWo5u858TSPYcHc2G?=
 =?us-ascii?Q?8BZHnTEF7WADgDUmAE0RWBJF/qxUczF+/hgjyOcJ8UZYOSHtxucnBVNFiS32?=
 =?us-ascii?Q?trQmoQUyr4t3pKAK/Jlp/ObWGu+v0Nq5cF4MxdhpIUrFEaoLGi58rw2ifcTN?=
 =?us-ascii?Q?+kR1y/GXiENjFPeQk9ZlcRDa7h0gXJPOJOBE35rqYxItlqoJ6TFKdjmd3gjT?=
 =?us-ascii?Q?HergQmLRgmanlErxfjAqyE5b34F5fhNylVRsNIEmXKSLO6thrXaixYqqsMIA?=
 =?us-ascii?Q?TcDofUa4Of+6UUINxv3vDfUyu2zHt75CQm1J1tKOwwsU8I1WuWzNaOdfb7Mr?=
 =?us-ascii?Q?vw/7Oa8en/wMN3VYEDIfVcGP6Zj9QbxP7kgHiaRCepsiUSr6LwyFsUVHFg+R?=
 =?us-ascii?Q?uC570XGtxZ5u8GoFba/pOQNchLM/4FoZ70rfP11iaQSjcQ+woZDQDsDrlIqj?=
 =?us-ascii?Q?a3RZCs6ojSo6eBgDJ5JUqpcn3w3e2QwmEP2Abt0LbJ60mrKdx/oe4bxwER9+?=
 =?us-ascii?Q?OEdjX58hFgW/Lcvz4PirgTVlvsc95e08fEV8EcKDJt4C67aATV+WXNuIgPct?=
 =?us-ascii?Q?W5BNVNugIyZaQPktgtMSTVF8QZKCcYAL1khjDnCLVENnU/48hGPPBKY69uiF?=
 =?us-ascii?Q?DlahmamXM0CeyPQnAHpFYqzYRkqPAvNF1irr0j36zf63lC148wIPWoyJOB6Q?=
 =?us-ascii?Q?wpbuJKAkYAAIHvBRItsB9OpKIW8Tx9F6VhJLbBZ6rS8MVdVOxCnm7A+3+ReE?=
 =?us-ascii?Q?uEGvzUUK8PpgexMSwSiAMrrcBCZUmUyoGOmHpWjCFLQ08bxQ7KYMRN9aePG6?=
 =?us-ascii?Q?BWAI6+Zki7i49vkHRMLsWy5KJJu9E/fiWsQrUnA5gxb1R7aaSENSfaG0MYKb?=
 =?us-ascii?Q?PDnLM7UONEHh8N2LKqumndM4nEqd6P0keTIh2FybWKKks/4JKl3mEroSFYDh?=
 =?us-ascii?Q?xVqjB1XkEecZnWWk1SriSXresQxhVRwL9I8PoseXAJWUN8xf9RS4KRYekJFF?=
 =?us-ascii?Q?08ss/dJWveQJgnnuxRVxPEUjoTIUOzGJZ5fQev3/0UfD/KYQtmFShk+svPsP?=
 =?us-ascii?Q?fUv6IaNK9Swc7rxEhwhuELOM6etBmufCTkm+ZmGsvLvjMX3RTi9rGdmQfBjJ?=
 =?us-ascii?Q?6UyIxK0ieNnETYUBVS0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958d9ac9-255c-4b13-75bb-08dbce5d2ab0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:32:54.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BOtF7WycGyecc2Dfcew75vgAOWUtH/EnHsxEo0uhrCqGi4+kSv/Ye/59Sz5srvnI0PNtTVm8VMPCRmumKbPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svc_i3c_master_irq_handler() wrong check register SVC_I3C_MINTMASKED. It
should be SVC_I3C_MSTATUS.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c252446b2bc5..5ab68d6e439d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -475,7 +475,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 {
 	struct svc_i3c_master *master = (struct svc_i3c_master *)dev_id;
-	u32 active = readl(master->regs + SVC_I3C_MINTMASKED);
+	u32 active = readl(master->regs + SVC_I3C_MSTATUS);
 
 	if (!SVC_I3C_MSTATUS_SLVSTART(active))
 		return IRQ_NONE;
-- 
2.34.1

