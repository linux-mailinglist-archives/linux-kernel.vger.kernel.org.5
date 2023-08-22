Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244EA78378E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjHVBpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVBpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:45:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE40912C;
        Mon, 21 Aug 2023 18:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6NoEt1gjwfKo1r96E8zFlnNS7FK7EXucnDwVyrwhjPkcgZKQuftmf+W6vZVGtPhepQU0j4+sJmEND/TNt6DAuC6QB24c6VkTMNcX4pUJHNKv0Bs6apwF9E8CaLIAEDEbZk7rVLSjfpAYBpDGLUDKmYva/HOC4hhvaUUnvWrkiXAGj6n1bhZbqmQipL4ezhaCu4UBeICqzi2l40UTsgZH4LTdVHVzPnc/d3NLk/46ICoZWmXjbSSlNQw005tR9EhbIPWtucT/c3anqNxCbRIOXO5vC0wjlkyr4T3c85hUwpk7RRNfwu9qiDDV0yWrb3a1ap6v+RsOaGaRyitP3vS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNOBBlbVWEesn9IwQf/G5pK7WbHyGW7OINlz9vG+WOI=;
 b=c1xMMRNtKeOANQMM1nmfS8azRl+u7wfOC4x9fVmJESgwoFgXn1+9zrb3IiFF3pAui+ytdSSUXF1rGQJuxD0I+bHaIXd4k54vQoei7ghq4P1I6fUrUmLG7PWFUlnk+IVUPZSqz5GTqDCWH4lCze4txqxFsrCOjSVP/rG9NQvoOwvAPdZFbJya3ARWDTIg8snZWS5UelYgu/EcTeP4Tvu0fguG7US6NiK9DH5rR64ihhyuVLV/HtWn9SHv5ZQAJkrOdeeTNahq8mYLejfihZaQk14h7Rcvlb0Lha5zUbXzQP06K1EuddzjjzlEXOd2OF4hU2rpwYYAYx7FhmOtXr2F9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNOBBlbVWEesn9IwQf/G5pK7WbHyGW7OINlz9vG+WOI=;
 b=l0adg6YBFyawAjvVsC37TdXiFGaU6rihj1U/xp1aAkcmcCiOc7Y2Jx6A6vkuyPjmUXKf4gjwl2Ou1hYG0WRV5VPwIu2Zoav+46w93c5JWJ7h16uW7mUBi9bz7bFG5k2VwvdIT+tUdw4hh4JMft1unq1Vth+fZEWAtz4OROqqWuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8108.eurprd04.prod.outlook.com (2603:10a6:10:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 01:45:29 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 01:45:29 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
        tao.jiang_2@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: initiate a drain of the capture queue in dynamic resolution change
Date:   Tue, 22 Aug 2023 09:45:06 +0800
Message-Id: <20230822014506.6675-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f957244-7142-4072-6abe-08dba2b176c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fr4exXAY8NLnk9V9NGCNKOMCSebdIAM261gB9yuWpUGXFgPdejOwvF91c2TJ3fZQjspvOBJ1kvuli66ScPxCyumpotDaIXjPKaSQ3RoDICMqKQFNUtVq+yJBMTZeBtQGxb6v0H3F9ZMOoHgGN+nc2ddDbH5ewAMs48iryvSd4Q9Do/lhbZjxkuDYOAzX4T8muiL4pksAT5UWiSrt7DDU5lJQ42FUPvl4MirtYH2mKWlDL5P2VktWkfvM31Udqyi4tYrqj0SdAh+mEYPhmRjkjXz4a6tizeamXMg7y9ebVwjOp/1QQGBkfEW1PB8HKv46h0ogHfEQRrLmlmopha4Br9T00UuQmXMtEKu7dIWwl4mA/NUVpO4VSRoWWKH7hEtcu7U9B16Mqbcjuxm5wmILNAyadkaana2ArLLSrvu8u8q5MIK0cI04R2iIolVkGUBfUwiyhIaA5gO6k37jF2i0ZK9o5XDRqYU8iF7forZOxkzvTgl7ZC55jnUHqK5nz2vGknVhqYqIRyoVtB55edYBC1h/rg+s9WXGDbvBx61E6jNz8qPJWNxSqTcNEBE2uErQdvl77Uqjb9eZ4ELbYQKL+DwHJQj4oabtuGrsbBubysiFX82RpiuzJDwMqnoQpevV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(1076003)(41300700001)(36756003)(478600001)(6666004)(38100700002)(52116002)(38350700002)(6506007)(6486002)(83380400001)(2906002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3rW5NQpq5YqAtJ/5GPgJCNezHwlnUU2HrmjJboqXo7YXJ7ahiatcG+SukCSk?=
 =?us-ascii?Q?dyHs13PtoblvrVlvXCXR25HXepqnPHj7hKCa2QjM3VGVBQv6RrNTO0Xqu8tE?=
 =?us-ascii?Q?ldMPPQ6yH19XLhRJzcPJfPHhbGXbIWUfDZw34yp2p1JjCSg0ZSbx/RFec0m2?=
 =?us-ascii?Q?m5fB9CeQ5FcFnelUwNM0wtdWJskXCEPHanZfm+OfbVJUuR+P/Cn0GBcDT8wp?=
 =?us-ascii?Q?Y7TmO47EFJvuy4t3iD7LQSK3WT4HQIBRg444bjezkInCKDhScbtgklEg7MDf?=
 =?us-ascii?Q?csQ/7RcPdBCV5psaOet39fXGTSHsPk6NYWJ5k2bESUu2HmpU6g7FsGvCq9JW?=
 =?us-ascii?Q?MGoPuqzrh0L7iIV9am97Q2lJUTMobijx5VNxjX2aNYfhWhdw8JUTUBrcYd9v?=
 =?us-ascii?Q?71v+4FEy7PJb8rb+zMmEqbPck9mOP+eMBiiScty49fmb1bNCHzvORqln6brC?=
 =?us-ascii?Q?G9XgckBGmc2ZxJ0Wrk+Pl9Fk+xKFX1VHVotYONS9DfwZxwJUcZ0ZifBfqeLH?=
 =?us-ascii?Q?e9drUIzCZWLnBjd31a4G7OlJ7RAPTLSI0/yUZYVnnpk1+zYw9KFHzzlA5aIQ?=
 =?us-ascii?Q?he9JEpgaVNaqLa+TrpeigEg8GAVNQAf4PhJ4u2msuE6zH7IWLQir5nitGRhg?=
 =?us-ascii?Q?1k3h3d7NGEQ+zmY6TtUUk41P6OlelJp1KF/Zi01lsAhESR0YYCryMZReUvY2?=
 =?us-ascii?Q?01+XU1wt86WDxaH0CLq+y6BuxM8rUQ90NaSDNX7660RFRkzT1fSsI53P4H8e?=
 =?us-ascii?Q?XM/HdEXk9iCvBpotR6P6vhxQA5C9FD0u6DUeypfucBWprUiRmjzCWjnPunbD?=
 =?us-ascii?Q?bU6bZAUrpyoKvOgqQS/WKN3gDCTwirzie4XHSAEdCRn/3YsUlFB3JyQYOKju?=
 =?us-ascii?Q?UVpMWiCTav3vvM3eOjfg3XCxSjJ4wtJ8L5mChcLGQoWLX/Ten7N3MFPnoP9S?=
 =?us-ascii?Q?5J4J3ML6+RHS1P8wUxg1YhWAQuF8c0amGfkqtz8F8DU0K1b9zaGaq8s+U1xN?=
 =?us-ascii?Q?YIx56ruwK0TgW2fZDxlE6a8F829G+Tyz87/bZw6OoKIt6MMBzLLfUp16rCQf?=
 =?us-ascii?Q?w71fVRVoClcvhPQ8ltVc7E0jMNcbEVqiZdzNmxqMd7H+TZRTzBlUJWqYTrCe?=
 =?us-ascii?Q?Dh7pA9/OE1hCz1B1h1JsWFpbB7crlIpaKtTQJ7bjaK4m4MZHFWn4MjUDhOfF?=
 =?us-ascii?Q?05nievkojS+O/cCXT3snEFFv0xsI6O7T+yuAnVm6xIE3OpOK/3lbbGGYp3Zc?=
 =?us-ascii?Q?a130ME4bPaGpJRlSgwK3QuDI3Pc6c+tGFnC6SX1TyV2q7n8fMOrtHqyG8SzT?=
 =?us-ascii?Q?hWONKoNVL0PszLrnNeZlTg8AOEOuukDGgP+d/Lw61u3T6AX21fqTBR1dDbET?=
 =?us-ascii?Q?t2Ps+mt48YM1LT4MZWaqG/UlbqAsTKz66wxV5f1Vu0oQ/VOuIJFj1wRnYyuq?=
 =?us-ascii?Q?Rej1TnK3PfjkwJxT/qoolpMnkA9XVy1Jl5nt6XzOU2I5dX1rZJJZmI0l9uYJ?=
 =?us-ascii?Q?3+6OMkiw+DGuPFsfh0BEB44a+mnHmENzMKHq6ppHtTYq+SA/J0JNBNt8U0Ac?=
 =?us-ascii?Q?oTEbnTA6zjmiwtvqCNQ6xO4Jbj3Ef3bPb2vxJAHW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f957244-7142-4072-6abe-08dba2b176c8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 01:45:29.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKJDEfC2AWFG4BVYy1dI41B33qqqaHwxtGZeS38AjkZT/eDdmNUsw/15psfOOZrStM3N9CcxiEDO3s6HKL6Txw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last buffer from before the change must be marked,
with the V4L2_BUF_FLAG_LAST flag,
similarly to the Drain sequence above.

Meanwhile if V4L2_DEC_CMD_STOP is sent before
the source change triggered,
we need to restore the is_draing flag after
the draining in dynamic resolution change.

Fixes: b4e1fb8643da ("media: imx-jpeg: Support dynamic resolution change")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index b7a720198ce5..e74b0ed8ec5b 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1322,6 +1322,20 @@ static bool mxc_jpeg_compare_format(const struct mxc_jpeg_fmt *fmt1,
 	return false;
 }
 
+static void mxc_jpeg_set_last_buffer(struct mxc_jpeg_ctx *ctx)
+{
+	struct vb2_v4l2_buffer *next_dst_buf;
+
+	next_dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	if (!next_dst_buf) {
+		ctx->fh.m2m_ctx->is_draining = true;
+		ctx->fh.m2m_ctx->next_buf_last = true;
+		return;
+	}
+
+	v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, next_dst_buf);
+}
+
 static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 				   struct mxc_jpeg_src_buf *jpeg_src_buf)
 {
@@ -1378,6 +1392,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		mxc_jpeg_sizeimage(q_data_cap);
 		notify_src_chg(ctx);
 		ctx->source_change = 1;
+		if (vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
+			mxc_jpeg_set_last_buffer(ctx);
 	}
 
 	return ctx->source_change ? true : false;
@@ -1638,8 +1654,13 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
 		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 	}
 
-	if (V4L2_TYPE_IS_OUTPUT(q->type) || !ctx->source_change)
-		v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
+	v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
+	/* if V4L2_DEC_CMD_STOP is sent before the source change triggered,
+	 * restore the is_draining flag
+	 */
+	if (V4L2_TYPE_IS_CAPTURE(q->type) && ctx->source_change && ctx->fh.m2m_ctx->last_src_buf)
+		ctx->fh.m2m_ctx->is_draining = true;
+
 	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
 	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx)) {
 		notify_eos(ctx);
@@ -1916,7 +1937,7 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
 		return -EINVAL;
 	for (i = 0; i < q_data->fmt->mem_planes; i++) {
 		sizeimage = mxc_jpeg_get_plane_size(q_data, i);
-		if (vb2_plane_size(vb, i) < sizeimage) {
+		if (!ctx->source_change && vb2_plane_size(vb, i) < sizeimage) {
 			dev_err(dev, "plane %d too small (%lu < %lu)",
 				i, vb2_plane_size(vb, i), sizeimage);
 			return -EINVAL;
-- 
2.38.1

