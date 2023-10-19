Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F317D04BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346660AbjJSW14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbjJSW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:27:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E947CA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4nPIyTpL6vRNo2Y8YKMwXTmAuODuCsK1o9fzmDLscEEZ7/2jReIcZjlSlWy9eOiE0HZwRDLkqeZveH3jwgh0kD8fCM2/4mrlBDWiCE7gizJjEaF41h3A0+CLwUdlJP7216CQlmVc6RMYOffF0mmP1O568NCuSZSJafsGJYlExiLZ/Dqyxn3u6ap1HJ2D3RNAXbPubUKQzgb99lE+HU9Vg1nPXr7pMhlrWTbIQ34W4Vvh5P87DVGpX+cPKVVm9UrpfK3uNYt8weiA96U1cLl7Hkgiui+SgKwGoDtpOCAzDFiBuWK+CYntXdrMkOO5X+gd+adXzBiV9cDinL+ik3ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaaZQlXiW7kkseAwbfTJKJ8ZOrlWG/SQe5iwfmixt5k=;
 b=mwg600T4Kj/zxFtOijBoxOv9kNcHd63xsJJDKYm9q5+Igfh05w6ntcjt59WpSZXWtdWOYJPldn67NCR/XbrSZp9wwiDFqC8i/s8AaB82oDQSy/Uq2ZGKNs964fspXoJrXn2dlyIMJqOrzcM92BbTsIQyGEjGWRSwTgX12DZKe1QrRuvTqYIiUcHqEy5xsgbIONEHUCKmESnuw879cnGViO6Wadz6VqW5Tu68De0SChB00Ab81aVqKFDkoalBJvaPa9kLlf8sgfXARV59GBV0E0XQTA6LuzQaabbbdA8PgRHmQXs2iRRMHoicTrrbafUDUTbpYwu8fP2k2s7IMzgntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaaZQlXiW7kkseAwbfTJKJ8ZOrlWG/SQe5iwfmixt5k=;
 b=jmzsJVZwcY0ck00JSHY8yKuue9tROLhTp/8KbuGIwI1xOw0kF/aTMDo4ALVRUFsXVFsZtmRueJPsCJIGCAFkqbdGxn0pmljVb3ae6hl51vzbfBENkuB4wqRENYKivE4u2C34TVS8U4JbZmYNytNachgruIhlB/2gM2SnS4kR9e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 19 Oct
 2023 22:27:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 22:27:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] i3c: master: svc: fix ibi may not return mandatory data byte
Date:   Thu, 19 Oct 2023 18:27:22 -0400
Message-Id: <20231019222725.3598022-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 115c6ed1-1266-4c36-9333-08dbd0f29fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2cYcjdrFfsAj4hiBkXqd3HO5ayqP2CdB9/CAbOwZmfdT1R0N7SveyF75QY5Rfedmll6aJArFhjSYyUNBWiuHspUIBsKJSfIht5NhtEU6okbQbsSzAbcud31hRZ9mboK6YU1a815quzYSFu4TW7qzPhrarpMtpoKcOpJsJEAu+PFutJSN/uAg+lNCbDqaJaMHZtbZ9VO45f79lqZaYyXBAMBi6LaWC74erTNX3iEe9IWUyLoJZKiJCPMycUwGBxINN526SsH73w3ZIsidHKAlpKbjQsN9Th9SRBuiqI1se7pLtwaPNN3HmofKmJvPRgdH2slVdGLJD5ZRG2tQZXPILCA2PJiZ37mUc9nxMQVWgGrrePKxsehfYxBeTrXCdIHYZ/WUo9GkWJ++lEhfKy4cBJ/A9v1p6+3yn/0EDBLzSj335nVxz36KxbHVqSghIq039DdLf074spbXulHDEQP0xJxZXrGKnUoBfQqeMQUbZoOQevv2y4H1nL82EcCWYMT65PJVzl0rYRzj4ZforAmEhoQRV5eqnRKBwJ9Mhb9OQeKcSC7IzDvnnThKgLT/46kdgLFObsRNLCosH6+xmDLGAHLSJGeahbSMUnLi7OZIr2BJWC6acUEnciyPWJxsr737WP7OJNvLVe5PW/S6VxSF+T0a/EEG1fk20z0HAk051U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(83380400001)(6512007)(38100700002)(478600001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(86362001)(6486002)(52116002)(2616005)(1076003)(26005)(6666004)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DLR0ZEAy7inq/tfBOC13tKchDd4vxokzqAdbfDuOrVdusaWrNzlWWjyLdaks?=
 =?us-ascii?Q?c7kivxlKDktE7FqlLb1kPUKLnJasi2TeVSmO8/i2IayGKdirL/ZpPRDiR+7v?=
 =?us-ascii?Q?xAWC57mOOPvp5V1//9vEVvTtERhQi0FqFvrBKxvr2Im1XDGtjoa0UcxdxTbL?=
 =?us-ascii?Q?XAWEULsVizRaiH6dFa4d8jCYdDz5EO+3MacTyuJvTmn5eAE+488lDmVaJdln?=
 =?us-ascii?Q?RIfcmibec5MNPFnRqUTOahkEgOUK2u0CEazjWi1B6pfHChpMTRGWLWlCRLbE?=
 =?us-ascii?Q?2SjCfC1M5L4hkcGVfDuPkQYsEsj/HkoTVudYvF61Z2hGcUigdzoNcbwBIAKb?=
 =?us-ascii?Q?CGgA5llMyjSRKk+wln86Gxfq9oml0c8TMNIprZmjXEhqbIVhjeygTDZBIJ+u?=
 =?us-ascii?Q?RxOEQiMEY7CEFC+gCVnqQ60k/PU4G4A6SoS4TSEc1UnNcF8EsIe9eWgS/bIo?=
 =?us-ascii?Q?3NmUyGXVrKZSL8KzSpPJMhp2haAoeVrVl+Z3ubJ0vdYHLAgK8/4fhdhSfRtZ?=
 =?us-ascii?Q?aK1HwRTqsnFj2fdzEx/wq99/rJNnKkwTQcxjnGJfF6FSpP6PRsw7uQAucOek?=
 =?us-ascii?Q?vMuA4HFgMZoMxrrMpiLAjcTtB2HPbQTUZM7AVwW22I8qWTtTXc2o+udZtpZ0?=
 =?us-ascii?Q?XBD1fGgXv+uZ/WwhO65Ny8/qs3Dwk8HpABE32dXwjhtCP/N8FPBp2kH8lXW/?=
 =?us-ascii?Q?K1M2r5MYu8WaPJjt5BtOiqCVqrU9any2/FIXi3/DrBoIj/TC/D83c1617CqI?=
 =?us-ascii?Q?p2N+A6KX9IY8g24KLPEgq2M2XxXAuQjDYVkaAyxAsNgZbLUGOt57Iy/SL6/U?=
 =?us-ascii?Q?5tl1Yh3sAJJhNmogQKx+m/r3GmNQ/WoLH39pq2+s2lnj23fCfHqk8BFxfxac?=
 =?us-ascii?Q?SOZl6Ixy1jiH6Qmf4/Ee6Ow7FfNQnZ56jOhPCrtp9AQApDV8WZvOCRzlQtre?=
 =?us-ascii?Q?XVqEkCp7zaN+A4T3tP8oRvaHPirANLJ9485Yatf67g3TbD91qTGtGJZRt7KP?=
 =?us-ascii?Q?Bhsd83zG55Z3NaLLLYDEV6iaJnkLZMlGXCGp2DWM5wAtO32WjCLrnJWf7xni?=
 =?us-ascii?Q?eMLrqQCaw7ORKz8E1rBisEAGuIcIABc7R9hk9qFRT3xXB35lfT4Ji8mlwjiZ?=
 =?us-ascii?Q?loLNVUFZiZuHTFORUcj5oCxefyxcyskQpTUxG/RfN+yXYzSD7Jo+pTt34XqR?=
 =?us-ascii?Q?aSIDscfOLXUmlUuXCXmeurSMGmaPB447NkFnr4nEueAHKMi64y/BRr/o2TFk?=
 =?us-ascii?Q?/Zbw+3OcdsYMenCNLkicadDzU4j/TktYk9btBqVTpHyGIdvOGRgoBYHcgcq8?=
 =?us-ascii?Q?TZVghxel0YaasJBeOG5TnH/KF5qllxMO6HI7x/bG42O5AbMrT5cebFUBXaqq?=
 =?us-ascii?Q?f/M5lHpBeA5mlBwecdRm9ZHUuGr7/CtNUlKLbOcqGRC2BAQSzb/XtL+4OGk0?=
 =?us-ascii?Q?qTWaaUrLtBQO7HraYoilElq5+qshBLs4KJkof7SSvhLTLSSAK+guVT3XEMRr?=
 =?us-ascii?Q?g8YW0xTPy6gP3DISxK5F2okJunHQKRlsaVXInEPS7BNMQSXIk9CKZAv8XMvt?=
 =?us-ascii?Q?wN7HdkcOdlZooih75mw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115c6ed1-1266-4c36-9333-08dbd0f29fee
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:27:48.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d0qLjDjdqwt1obCtePu8p7W17LBtjxdvZFxvQgo23yrMvC/iGNiJsaT8e+5PMpnhtF32UvIp4n/pyvZBNWUvQ==
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

MSTATUS[RXPEND] is only updated after the data transfer cycle started. This
creates an issue when the I3C clock is slow, and the CPU is running fast
enough that MSTATUS[RXPEND] may not be updated when the code reaches
checking point. As a result, mandatory data can be missed.

Add a wait for MSTATUS[COMPLETE] to ensure that all mandatory data is
already in FIFO. It also works without mandatory data.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - update commit message and add no mandatory data in commits message
    
    Change from v1 to v2
    - update commit message
      it also works without mandatory bytes
    
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

