Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EC757876
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjGRJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjGRJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:50:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B60B128;
        Tue, 18 Jul 2023 02:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4txJXoxhh/9Ppywwse6QlGvgwj5xnCdG0J9eRpTm+agbr3ARbqn+NGeod/M9DZu90MNJlEntRkyQWlzrUl3QVMXIsNEkmiYEq3dgG4+ZVVRh2WGB3+ZC7v9SqpM+fwBD7NAGa6lMMPQYjazcMfLR3I8Kw5Dk304vvpwdasQdPLuic59xCKM5Lti/OYDyRNc1xVvIfe22J2qP+HxKK8OxjBwtFlYGJ5UcffnfuM29k68f2KeA+CUQsdMvZqHQtcdFvZj5TIyR4FMdi5YgrWDc4AmasF5ypCz4MvzFga5MJOhnpo0cuPpfsAmL64g2k3zjMPlLlZuHKS37yUPqaM6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMPSaVrTk90sPU+BiEdPKlljJs+HqKRNWWBHYcWnATM=;
 b=EGdLcyF5Xf8oNB/mgvbIvH2x9UPypSqyLFsm2OYW2/EmSTdPZZmqC2pw9Fe5JdRNPn+P7r4mG1pSW1Iu+nJg+xMcqFbj1k+ohcvMiDq/R8oQ3dBfZCnrJJz6Unqj68e1xpPPhJ38ZAoKiyWhEmMtVvCvYpovO/ceb5epKmnUvajDumJrjStdoRRWa9dWJ/iGqOfkDckmSjc56c2QVCzM6DyimnL9S5Ud1jK3yowEFZfobVF5P9567U6DsKmEvBbooYko3OVTv9YNMTiwf1fkoWGGvJbKqrEs9jAwelBRbqH5LlM4dYV4Tl4WfHGV7zt+PjXIe9LsQgKz7f9DDl70kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMPSaVrTk90sPU+BiEdPKlljJs+HqKRNWWBHYcWnATM=;
 b=XNBExj3bcW0mHsYELRQi45CF6+5RL9WKqUt+wFtlQzxRiSOq+Tgh5Lelzo8pFzM3Rq3niKGCMmfv5+tbAwK6NUlUyQiihDhM3lm0dzCFiBZuOqb7uBiVKboGE5TIj3uGmXZmO06jqtrbqDkt+DGoaCfApxGO82rV/aljf4+Ncok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB7067.eurprd04.prod.outlook.com (2603:10a6:10:12a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:50:51 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:50:50 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/5] media: amphion: fix REVERSE_INULL issues reported by coverity
Date:   Tue, 18 Jul 2023 17:50:10 +0800
Message-Id: <4dc65b83d866d91062e52d7caca88663f4934a56.1689673395.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1689673395.git.ming.qian@nxp.com>
References: <cover.1689673395.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB8PR04MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 66445956-5991-4de0-aa76-08db87747840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ej7Q5wPSnEvqtHdbnnEf7/ifZbkOSR+6nNHgzf3jR03rNQXQq3mLAWouuzQCE8Yb3NdsdvWwKSAtyRXSUkUvqDab0t5JUdbgk8ILsIfhCUU9l341Zr5aX3Tuoa5CHL49QUa6BU8MA64r00pFvO3pEHwi7EN1ykvO/Q6TSqEXEt3kBNKl9t9YDwbw/bqRhwgDonW300ErtZQ+/EPSzagPNgNlZ8HpmiDeQi1U/pgbMYbJOTXUyTIDthfjjwa/6YyPyYGw5vE0siHSO/0U7RGg9yrUHaBgy+mQct60qXgB9n59dEpZp4A7L1uKXogEsFGDtrQZJ4MNK7QYno7pOancRoPsnTHmzdmgGqN/xVOJbwrxSUccSembYik+WBiEAvG1awOb3kAnVpxv04dbV/UOtdnLq/TcMNgQDHqNfhJUgTEz9T6iwsWf7RJ2TSP5bbVGKMixP8QWTkkafDvsqB/WHOBg6DZJ9lV0wxJerBXub1okgCcNEHciDBg0PuT4p0Mw4cySVEZ9n7ZMVqtHPTraltd207Wqv7mEhrzTlisufCAU8HwZShTvPkioSCStLedBZfzl9eNB8VbHkTVNO/xnUzY8G8vP1KCcV8jwbXEUGZD507+yg+eSyu7jx2Pe5A1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(7416002)(86362001)(2906002)(36756003)(44832011)(2616005)(6512007)(83380400001)(186003)(6506007)(26005)(38350700002)(38100700002)(52116002)(6486002)(6666004)(4326008)(66946007)(66476007)(66556008)(316002)(5660300002)(478600001)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V2qhLGfTL0aQeWHhOv9WMX72hDAw4RgpaW8ErfnLzdAd/zXXCchQXNNy1/tk?=
 =?us-ascii?Q?WhEwFvUdHauGkBNNVBoNQ8XGhjcYTrEfrLmBq1zOx1Gwsnmdpe7P34ILSgW7?=
 =?us-ascii?Q?zJjmTDT4HbehpSyMSDuh3Z2J46BAyJgeNaQbEYfyoxIF6UccvEPq5LdW5BTh?=
 =?us-ascii?Q?qcvwfdVjYB82Ia2eXM03xZuRFSsiz6RSiqAtzGDl4unaSRdLxINs2nQAI+XI?=
 =?us-ascii?Q?h4+j6SnOVZPlZBeH3ShF51dNETr/l11HoMyouGlnvRsF7Gb7fLjZQzgfFWvW?=
 =?us-ascii?Q?zKyP0Gm6NZzOozl8lZFJPdffFVGWP3f/AQ1XFDShI5C4hBBs3njjpYMfBAkL?=
 =?us-ascii?Q?6E8H6KPUxqnY2POj5OEFd2bD5ruxesT5XI4pYIr5QZxkeY0FoPTVrFIaJ9yj?=
 =?us-ascii?Q?5i7BEsLgKQK3EOF3OxcEbs84tW8ussO8BYoNsCKXOrL3+xtZLLi408gqVSpJ?=
 =?us-ascii?Q?jAxxbAfVxBDn4snjWdPogizIB/YLnCvObfnQLuWbS0hp85vf6Ar3Y3PNrZkd?=
 =?us-ascii?Q?BHNzlqcOAJV+FCgy5EmE9dmL407h4qU7lqGSZGCSb5BPyswyaQZ021r6/+nt?=
 =?us-ascii?Q?9v915wY/feg3QCUfV5FD21zSUqnerIotD9ixXjihpFrdmCIGYvHxEAxeDhdC?=
 =?us-ascii?Q?yIsi1UQcPOXjnxvwNPLCiTixv4cAxmzyGsjLzHe6Dc6tmvnUIj5eD2C3jstB?=
 =?us-ascii?Q?eT5N6zqddOS1MtNWyWa6pUusXX8qzQVxRrcguOyJnyrBv2BzSumGQMEBS12t?=
 =?us-ascii?Q?eWz9LzuI0RUi2w4f299GNVNxJanqO98TWYzykC5JijlmURi/lxh3wkVXGMZk?=
 =?us-ascii?Q?slpnueK14rjjpz1EjZ6QvAE5CQfTEFkKFR7vXMjZEHzMC2GNNadTplKPgWsY?=
 =?us-ascii?Q?uZSyBmYbHuub0dO1dyTmFwMKiSSuIGvHJaYwuhbTqt04aZUaXHvDpBdK4/Vs?=
 =?us-ascii?Q?+8RtS4IrNJ3F6w2quCIEJm13guzgYjGhhWAGVKus6yaJIKMqOlwJex6j7XMo?=
 =?us-ascii?Q?4n+evhoUYVbjVzw9/HTGdTL7jQOfXufturKwwI0tTL8RrDHaz1yzkRKTY517?=
 =?us-ascii?Q?Yz9JnuP/txhC25AQnW4m3VCE6PGqDqD8iVJrHrnWk1KSYCuj+8rKeNfd7YPV?=
 =?us-ascii?Q?MVH8hQZfi7o5so8OCc+8OcdO3KFmBEe/D5SsLCYhESp43RS3iM87oF3udb9k?=
 =?us-ascii?Q?Kp+2SQ/KrZv6hYPabZJmadWtF7nYMIcg6IUCoUbqgoX1IYSULkHaPk3hMuWp?=
 =?us-ascii?Q?Q6sxVnyAc3tfrXR6PCwktH+r0nOhbXicqeO0MQOBnSXNULuKWFuZXoerQr8g?=
 =?us-ascii?Q?FUSa3UJBiFJxysvJWZvC2FtUp+F6EVv3oBeDcssI9T898CjzB/UDz9V7W1NL?=
 =?us-ascii?Q?Xw0o4hR2xgGSVw5HwGpGE7T3LhvERrQsYvvP/F7oTfnQKSJ2rHTjwGgLwTHK?=
 =?us-ascii?Q?b3+skWd0UDGG5gPkuXsLpd1qczQqOTTA5qFHPFrXI9Jx+HoDC8f9GJtXb7ry?=
 =?us-ascii?Q?g4UDUYLYwHT9SE15/VzGedSf6lC3I8V/H6/E0XPNG+a7DNFu0dCfZaM/ko55?=
 =?us-ascii?Q?Dvb2mlkcm69IJpOFc4MgLGZ5gD2Aqlm041s1iiAO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66445956-5991-4de0-aa76-08db87747840
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:50:50.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5VpRAqJDFxzrMGH0YKsDklJb/5STbgJ4p08R3OjXE9lWYA9rc5F74e7pvwKGMDmbPLnpFYk2GYQiJcbHqB6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

null-checking of a pointor is suggested before dereferencing it

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 58480e2755ec..4eb57d793a9c 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -268,7 +268,7 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 {
 	struct vpu_inst *inst = to_inst(file);
 	struct venc_t *venc = inst->priv;
-	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+	struct v4l2_fract *timeperframe;
 
 	if (!parm)
 		return -EINVAL;
@@ -279,6 +279,7 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 	if (!vpu_helper_check_type(inst, parm->type))
 		return -EINVAL;
 
+	timeperframe = &parm->parm.capture.timeperframe;
 	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
 	parm->parm.capture.readbuffers = 0;
 	timeperframe->numerator = venc->params.frame_rate.numerator;
@@ -291,7 +292,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 {
 	struct vpu_inst *inst = to_inst(file);
 	struct venc_t *venc = inst->priv;
-	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+	struct v4l2_fract *timeperframe;
 	unsigned long n, d;
 
 	if (!parm)
@@ -303,6 +304,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 	if (!vpu_helper_check_type(inst, parm->type))
 		return -EINVAL;
 
+	timeperframe = &parm->parm.capture.timeperframe;
 	if (!timeperframe->numerator)
 		timeperframe->numerator = venc->params.frame_rate.numerator;
 	if (!timeperframe->denominator)
-- 
2.38.1

