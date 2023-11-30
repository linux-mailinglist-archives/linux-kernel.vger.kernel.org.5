Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1F47FFEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377202AbjK3Wor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377196AbjK3Wok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:44:40 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15C170D;
        Thu, 30 Nov 2023 14:44:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocB+xAJcxM4hzsfwx9o5xcy0MAIh1rtir9Qqttt5uBJqlF0m6BiLrmsl119VbZpsmJdzZqu6F5kJf4BW4645MI9BSTUtIPGoT759dtJZ82WQfiPNPtWhLn2n8N+YwoLzMgfX1fDTE0Ht3qWTWdcGO34u5f33v5AzQfgWP0bwFQ1H36c8gUKbhuI185UD1Ky41ROda8+i9pChA8aILHcpdsTYQ3ybncZVhChIezDhcfEoJmYlp2fqS9pFx+crO8F0s3w6p7KhySJOiW22xvtis2re9jW5eowdkErtme+B62Hc4EHVtuF3CvPFFc/RqDO4bKKDgCvqydSRhIk3Kc5WEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZK3nbhXsExbv0Znn3D5HF/BW5CgmYGvGvpxgFhIT0s=;
 b=MLKtNdPvZsQ8qcMJ/lEU03gmkOiCvytyZaYZJTVXX5k1grYZ0+VeuEX8keoT/HDx30yk4AuAsDoTf/3Cj1FkY5trdkROS4pwtKWER1YkqXbQRQIzavY3B5g2ZmKnDgA0f/Yl+q6nWHGVLFuC+PXDbJz27q8/2qcsrVK/kBIxzw/rPgpR+Ai6lQb3V8zb5q0ErWbCTiaacsfigwSwTIYlK4FA80n8EYc4/Dc91zUGpRXMjvQ8sCYyMr7wHx7HExKDTlsnBXoSy1kGPdkMDN4KbWDDDVbMuSRycioOKs7SqMAJOvOsiPCgOjBn26AslwEmtmUbwmKKWwdCI2pAbaqXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZK3nbhXsExbv0Znn3D5HF/BW5CgmYGvGvpxgFhIT0s=;
 b=WRW9meVa5S90wj538VwkGRKL5J4ne4SbYDyEIONAm7j2LcaUdZWDnKRIGkpjf/okXIQCZo4iVZjTkUgc5dUUODF2GlAxC5YiyAxB90BB5+GvSe9RBi0FkdOKUmTn9TORlaN+ZNOh4bA1+DfGHqNUe4WuRHe9rActI6LZZOy2yq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:44:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:44:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 5/7] i3c: master: svc: return actual transfer data len
Date:   Thu, 30 Nov 2023 17:44:06 -0500
Message-Id: <20231130224408.3591288-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130224408.3591288-1-Frank.Li@nxp.com>
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: b3114018-fa4c-405f-5e02-08dbf1f5f264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rqcs962DLN/vmt9CWY3Op7uNistBs8i8kBTmsEfAva1b+LqIJG9wff/6s0ZT8rK01XPKBaysGz8pKwfWZjraE0BAfIA9m/QylBWLgYRovMZRv0+iyOGuhWm2Y1wqY6SJ5TpaULeRR51W67E2RkJMLys7fQPOi3WBcEpIMO476uckWriIgHm1uHjvMDqDF0R6Uhs2b8hUP7KhRLMzhbA0FF1UOVwFriXoSUAAo89P3mNv/Gf3tgXObWZdNpPy29pz8dCkAnH07qyWUT71REPO8Mtjx/29DxTo5PzkExIcAAxzCfrCWBiHYNfga3HiYQVTr+DFx6Mpy5r3ASeerADc57hmI+1qV8X8lV7SWJUbVuyXf4bi6w17tSVaNx6VCmoAZ3MDKn8F1dOWB7B1nmldSA1DXPEhvRuuhUocQhxshISHNKYqxe2gI49WF2drOjjAqK2hFRAoalkhSmCna9ZL4A5RbziXumw1BT7KC2Tk3T0CikK5ZnEPFXsZnLSmKRa3gD0r8aRmR9gGZwQbk/+sw5l91ekT5o70A6tcbWmazj9ujynDl/4QqCpcQ1aXY2NwqyctmLNdY19E2qjQOUixdNCRmpgPH1fccOPBUec4xz58MC1vxAou379klt7q3m6F4tLxg1XVn99a0JPDXZ5jamQpQulWEegeUTYKQ8jaToI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(6512007)(5660300002)(36756003)(41300700001)(6506007)(38350700005)(8676002)(52116002)(478600001)(2906002)(6486002)(6666004)(26005)(83380400001)(7416002)(2616005)(1076003)(4326008)(8936002)(66946007)(6916009)(66476007)(66556008)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmPJ1u2oMHj9G3BfoED7TQuetp34mhMogwkt4z8NL9rlXL28uPW+M9gIkuXP?=
 =?us-ascii?Q?Ve2pEybKHcL2Al3Vf+O74pUdkZpLN4i7Xeihx5ytGg4UDD21wNkudVQhBYX/?=
 =?us-ascii?Q?ogs32DxYodCEzpjznNj9+8yo/bEd7JAU750TZaEJb6Laz6b/jr5ovszsAqUE?=
 =?us-ascii?Q?XI4Lk/lm/Fz3O6yXXD3GbrmwrU7ocC2Ty/J/2xReq3yATcnb4VfJQnFZcFZN?=
 =?us-ascii?Q?AU35Tw6S87DvVOuRnirlwDhhJCE9Vpo3A947dHJQgrTQy6Jp+nYvdfluAYBy?=
 =?us-ascii?Q?CRCEyyoqIo6su+xntkQOEhWl6cXuU6o/x3yuM+SRd/3JC7cu9ld0f4B1RyXJ?=
 =?us-ascii?Q?qvLwfP3f+7ZtmMprAMIrIKSgjCwBAUn/wbO1uRhLQnb+tIuzSERAgUikqoPb?=
 =?us-ascii?Q?2XSQp+q2dxZUYXnaGkxby1kMSEN1007I63TvfRNZ2EvAyqOdzk58nwTxx95L?=
 =?us-ascii?Q?zi/RXwE20UDr37uxwuHs7zXKYBqAR0Vq7CD/Ff1ZNBrgnPypuJTIrFd/jC8y?=
 =?us-ascii?Q?1GjU1DSPrEOjQgWmQUcmJVUtvPAL41+Y4c3zeh78jwC4qQvedI5wC3pQeb/U?=
 =?us-ascii?Q?BO0/YP5LeSL6PSVZEIC0MC9s2WdWJg0FHQCYKu9cgtFN8euV5tv5goCZShJC?=
 =?us-ascii?Q?g9BZuSb0LoB2wVL/OHiToCtwhCYK0W2F9tin2CJUmp/fcDu2KWqhunGh/GS3?=
 =?us-ascii?Q?593BNR0+yvpaIr4pXmONqU7D6+41XVWFVnyFWCXp5XjDMSrqOYtDp5gdK4sj?=
 =?us-ascii?Q?YSvHS5oWDTfN344F9YttnTC+UwN8Y6ZndcPzlBlq32FS6P1JnDBOgnN6053k?=
 =?us-ascii?Q?nDHakoas7JHPVRpKjKVz0CfjjVtVsixlyd55Yu/1THXLi6VSHV33OM62qOQL?=
 =?us-ascii?Q?J9MHEIomPmL+w+rOGtZYqYBWUj/DVXhb/t3SY3njId1G2h9IFOjWHwGtMmH1?=
 =?us-ascii?Q?fbcv9YvF7jtS3fGH4yo3Y+QTEHZKcAXX42JbN4v9Ilrv/PnuxMCWOIIzoR7i?=
 =?us-ascii?Q?e+Hk/LazW1hHwKVAhOfvCfpWGdZBpK7XocLX8yvWbKNzB3Q905GSxGVDjo4Z?=
 =?us-ascii?Q?E49/bhuVYcL/3KQO2c3FvE2/6s0SW+MUz6s/GDO2sH184XzwLddOPMR9q03h?=
 =?us-ascii?Q?Tr3SpPaF3Dw3NZXoB9mIGm5Rcd485SiN+ZQCvSxyJhFmeLHlwN4GjI/YWU/a?=
 =?us-ascii?Q?zVh2j+TDsz7EWmZ6RIGH4AiKaRMUh5Tgv/saBVmXcLhmaq2YnvzFQ/hOtnJ9?=
 =?us-ascii?Q?T2RO4ZYLb98Y4RQ1iZCT4YCyqvHDH1UdraMVyZyBeActV8SbZulNPzjUYySP?=
 =?us-ascii?Q?W8RRvOeCk8VOy9OfLibvEORU8kqMWpUyukqtHSF9qKD9i8fKDJiHMzX+F/zU?=
 =?us-ascii?Q?jDJ25DY/Crr/oRA2ybEIxQayfj7MiI6b73rGbXcfNqvLuy7YbdS5VGPOHpqV?=
 =?us-ascii?Q?dA39z6UlkQLI4ay2W8JGsc8EFd37Ygr0kLcFMZcoLgvFwkVHrjJlDU/u5ivu?=
 =?us-ascii?Q?Vi6U+L4h30VM18U6aw2n2BIcp7SnxOoC1s5dPJPpGiDczGdJRZxW3zBNMyWU?=
 =?us-ascii?Q?407/d1gdGFmqIlmk5zKJxywQeboq02PYy56ygjy4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3114018-fa4c-405f-5e02-08dbf1f5f264
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:44:44.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aScZNCBXzj0Y7ndss1hDHQ1we0uG98m2Mw79yHDPjUH42WE1oOQYbkj3KvlUcajRPLti21yCKCphz188pDI/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C allow devices early terminate data transfer. So set "actual_len" to
indicate how much data get by i3c_priv_xfer.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v4 to v5
    update prefix
    add Miquel's review tag

 drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 13a8b3c2aa541..bd10bb698da0f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -138,6 +138,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
+	struct i3c_priv_xfer *xfer;
 	bool continued;
 };
 
@@ -1061,6 +1062,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1078,6 +1080,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	 */
 	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1173,6 +1176,10 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
+		/* cmd->xfer is NULL if I2C or CCC transfer */
+		if (cmd->xfer)
+			cmd->xfer->actual_len = cmd->actual_len;
+
 		if (ret)
 			break;
 	}
@@ -1360,6 +1367,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
+		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
 		cmd->rnw = xfers[i].rnw;
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-- 
2.34.1

