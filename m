Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2F75A4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGTDKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGTDKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:10:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816781FD8;
        Wed, 19 Jul 2023 20:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFkCI+n8ndcipi0hArLTw/Rjp8QIrkaS+P8cj8cngPLjLsL3N+4vPCzClhYgmBcZ5LyutYEU1/fuHSR1MUE5krVxHZRywxX+Pg7EzJITNEjTFLXlhPYjukiFvAhdMHDCtp4ZhOAlN8SyCCAfyJSR36ta478V85R4uK/T7p+bXa+zCPcc8PIjswzUzZX2GFaD2VTrkZH6Zq2DvNMM7hJcICa7vtgpnAzE/DZfHrKECeyVz2IR34s8jTM4ajHWg8zUe7zvTqyNmNVw40XtFeGXxIEpUzYEv7vsySTfoRUHJMajsojg7gue01spOxYk0BfujZKjXy4cK5n+jGU33Iv44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbSQ1YSYoaX+Dnb2hXqGeDYajoV+ilzMnjdpHmrPkrk=;
 b=kcXL8AClkAp7XqKUNfDmoek36f2OxM6qM5IYixhfR99H1eCiHaAdfPOh2/Zz6J7n7UziBazZkDU7NJJhPTooDBPMnAE3VvGCYoGLjWkfyW33hFLZVAd+jiKz3FPqJ1HNa/3Ch0JBgHaxHrdH8EwtGlrrtaX9NaelCXjwxc35rPcVMbXORFbbnWYnmSBDGZQhrEL3f8yiQmay3L3Ozg1whRM0GBKzO5OS390VHcr5A4x0u+F09Aq5QmnDJtgxGxPIqJwsUP37xCWVYjJazrPt6Vry0Fsxezn0Km5mD3VePKRC2r7iZ83o0xU9Ebwg9H/m2k1wONB98LMh4R7Xypn4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbSQ1YSYoaX+Dnb2hXqGeDYajoV+ilzMnjdpHmrPkrk=;
 b=l4UVURfAXyYUx/uzDiTAX3jG6ojygTLCTh1t6BRfyAD/xA4l1gFIhkqKD8Lc9bXONcvelASFZRTrSjqrDNwhKvTArzncqsUoEpt/7vDgwadIMwKzlP3bwuL2zcR4R3Af6nolg3tpOF/Xndu6KL75pkr2vrUXtPgNTQHPV8JfUGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PR3PR04MB7308.eurprd04.prod.outlook.com (2603:10a6:102:80::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 03:10:17 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%5]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 03:10:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: update amphion vpu driver entry
Date:   Thu, 20 Jul 2023 11:09:52 +0800
Message-Id: <20230720030952.13549-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PR3PR04MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: d54539c9-784e-4c5d-147d-08db88ced7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYJtyIq54I7vu0MJRgjclKn/0SnXhj6Cmzfvw+tBwzJFnYOJUzitgNC7wwywHdPPuEvf+VgMqDx/mhXEXzFWx43GKaiuHfcdsBWXqsaN9Tvtj7pjBo+CojIa0tJzxZYOQxE03SKexgnAJUzAb7kL09yWpKYyHQqCSr7vhS1Pis4ABv2Qo+mDo2M5gCF7o5QSmqGmhEsVoVCM2aDWUE5/XxK4sqObtnK7ANTg4rzsxkvlaDdOzDI/HVe5If8LEBEZlhxvY5yn+85O1QGW50eQC8bkKG4WrXL6tHkuwPpOXOIp5ua3r3jcq10ZgcrmgekNLLIxq/WdCGtsuymu0rlfGykh66g00L1usIq/h2hT7CQKvDgIWj3ICagNNIMU0MvZZICHui4rQnxCMdocoTgRHSZoj528/PJlA0UPn+syXx8m7WNj/WPbY/pfremhYNfDONFxcU0A5PjeNZbEGWA2RsMwg3HOg1E/pyPVdYCZatymUHIpLX3GfwUTHpHduCRYzkNHVqpTxZH2fqYe0EeXoiku+HgolXmlH+zG5RYLqaAo1FOL/oXF8UiIdeMh+7+IGESmQneF7IvF6vpx+n6UkHXSHr0agpC1XryBFf5u+4R/lGZ/SWw41bBKZoXiAqsr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(6486002)(2616005)(478600001)(6666004)(83380400001)(186003)(1076003)(26005)(6506007)(6512007)(8676002)(41300700001)(66476007)(66556008)(8936002)(4744005)(2906002)(316002)(4326008)(52116002)(86362001)(38350700002)(38100700002)(36756003)(7416002)(44832011)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQHmN0/PJRFPKj1GBurg9iBIFo6+jYRTiXraI18qV/h3F/+nV6tZ8cE/C91s?=
 =?us-ascii?Q?zsZJS+AMjvw/LSbhVi9yxNxKCc4R6B8P6TrQ4Yw2fCoM4qDdnXdi29+jK6Wd?=
 =?us-ascii?Q?3R6WfxsN6OGjCfhR/rrkahvQf4Cd0OWAKR/YoMYDvZn8PSPpzZt180WsH87w?=
 =?us-ascii?Q?te2DqrwIobWmovQG8xL5TN1h+1v3+thdUi+Mf+Osd8ts8CQmopYEDR/kTrH5?=
 =?us-ascii?Q?S6AsjBk4J6dzd4UzoORJ/TL9HLs9nLqjpjJQoNgW6ZTxvFZwmSU7Bew4o3dM?=
 =?us-ascii?Q?p5U4LMJZRYzFi2qURAAxUAQdZReQzxAYWjjNjGsUqJu26FMoYp42P/HyqRI+?=
 =?us-ascii?Q?dC6Rps0M6xq0TbnKNmubVFjjmrshSpUvq0aYksE4+FYn4djQV0arFNJCsQa4?=
 =?us-ascii?Q?nPm/akxAK6yTkGawUd6m/tjKHp4qi5hnK4+TakRLKIJuBNpTgiim45X/Y5Gd?=
 =?us-ascii?Q?34XfPsGFLH13Pv71LM+o+4NQ9BLqAGc1N4tAnMWAQzUFuyxUV5vZIuP6Ti6U?=
 =?us-ascii?Q?9acTOPmLh7Gctd3vt7L0l9Vbd7xNdJ60HkyvwMsYgZ9uKvnl9p998NXzT6T7?=
 =?us-ascii?Q?WNTyeYPciJ6lKEpmw7jrDACVvf86ZJL5D9uAinILUzhg2qf6FO6ea8f/h8rs?=
 =?us-ascii?Q?AmKoV5gP8rwSWkDig7dueP3qy/5ggMErhBar7V6NpTlR8YLdgdICqRWOPA9c?=
 =?us-ascii?Q?Hc8+2DR9KywwUsSwFsBYKiT2V9tape9GQhyFvtNPCeYaEYn9PPJi/36E4Lco?=
 =?us-ascii?Q?W0+TC3S44XoSmYik42hvMFYVgwWJAAFM9vasbuLKo/Cwp482hzUIj10zvDBL?=
 =?us-ascii?Q?UV+9EN+oT10795EYJbVj1iy+MMutqvC+suPDoU24o6N/N8sYC2Ke7fTiQ0X9?=
 =?us-ascii?Q?7rw44BtpkBrs1MoOwt74AapZmTgleZaaIvc10PkK1BdUyETDli3fQe8PwgkV?=
 =?us-ascii?Q?06QBHK4FsUP1bk32+biY+/IRoFCZm5nOtPePK3iLx6cSJYF6r5EiMwqnfwnK?=
 =?us-ascii?Q?+iZo4Ha/cSog9wxYTVMoja6l2skU+l4G7xHytpkPteCooglMS7qhma+Qo5Zi?=
 =?us-ascii?Q?t+VQHQijnHKfIwLFj01oanT1ZCalrRC/+G7EnNrBcWvDRXMaihWVrXnNK96x?=
 =?us-ascii?Q?8BkQDFFBK2BsZOPeuorWuAVTDhbdd33i57b3AoF6x7fecwf2+C6zyzx/usQ4?=
 =?us-ascii?Q?Q9FNaGQ/oo0yWQHUcHyI5EpfSvDow2PobNwywTGehAM0oKO1Opoh6PN1Cvjk?=
 =?us-ascii?Q?kyVm3xlKng/OBGIrZP5dRCRgy9WHvzAE+eg58iwTk4qRlHlP9LFMA14ldrqV?=
 =?us-ascii?Q?XQlH798Cf6ieqDqpINMxYZHSndErG3WIHIcETeZWeegAG26oKv3+nZpNyxFr?=
 =?us-ascii?Q?1IHKvdpxepiqnDEqHBph6t74k+239gztwOvbdJqBT/Yw1Kht/Op8OK3x/dMr?=
 =?us-ascii?Q?IQB6recV2/b5XYnJOJ+UyEX7Zt8y/WJE6ucO6ze6GfBoB3FmenoPXJD/VpR2?=
 =?us-ascii?Q?LgEzgH1aeYdiqMzgfxGwna2F4lHIzIZ52Mv+wTWDfvNQl+W/lvAM8Xim23WI?=
 =?us-ascii?Q?7Z4F2DQ5m2vExQNmAmv6BUvXMS3ceGj5tO5WBuQi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54539c9-784e-4c5d-147d-08db88ced7b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 03:10:16.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8HvUhQTJNjMuWNTjXOgY40V5DKqgseWNddwQU16wyx4eCWG+xmp5uqHOvE0iR36s2FFpwL9G1PxYf0Dar43vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shijie has not been actively working on the driver,
his e-mail address is bouncing for quite awhile now.
remove him from the maintainer list here.
I do want to thank him for his work on the driver.

Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..d7d1a1865b4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1074,7 +1074,6 @@ F:	include/soc/amlogic/
 
 AMPHION VPU CODEC V4L2 DRIVER
 M:	Ming Qian <ming.qian@nxp.com>
-M:	Shijie Qin <shijie.qin@nxp.com>
 M:	Zhou Peng <eagle.zhou@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-- 
2.38.1

