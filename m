Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE7A7BD338
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbjJIGRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbjJIGR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:17:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B4BA4;
        Sun,  8 Oct 2023 23:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUytP0jPASNhaWShYPQpNyAPiF/GYS2RBSDbrsZcRSLf6vOWK5UteUqyRRzv9LhMuYmBFc2T79XjeydFhp2knaIXNywHxflJTx1Df0F2UN4Ejc9313vycliOB3216DOQZzpj8jQY8sxu90uJS+mOUR0Z5zUJZtjxOyoOZ2ASI7bZwRgQNBGHc2OJhNYvaTl6J8/mNyVGwq2HNXVjJyJoC0hFMH0OnBxOCX60cJhW+Yv3HruZmphfC14lYheWwsdu2nEzaUbgk/dygWHQLQMlovyUQLJkFgj6nERwnSl4XSEdLSDYNhjxd+eASM6idGGR5cnkb7F19BMHGpsrT6GrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQE/xybe27mioLAKdciL1Y0hNRpYPvKtGZ2NdXL5CyI=;
 b=KT1L9xDqogiULAZTX/4eCREWtMyCpZX/CqAuXHIeHmXZH/wA8ddxAbHedKYY4klpneIcRlvdxI8K7IMWpVs6GsKSL3uH0LQZ/5j2u67XTk7u/7pu6qml9GjvZlz1XU44euJyONIzqA3u4Oz7qVRn5N0FbtPtDEc8+dcqfwfCMWG0soqFEFIB433lOHkYHrLV98oH6IJJiX5yzPCPAj44Sur6AHyvtN1O7NRcJGPGBiPV1zfKdRp2w62YuohHPx9k4lQ/y3ts7ZhnQRqjw2mA7HpD6PSj7KfwFTTmQKaKacWgWVD8Gw7qk78UONfiDLRjTFHdBjQMi1u9hSnmEJd3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQE/xybe27mioLAKdciL1Y0hNRpYPvKtGZ2NdXL5CyI=;
 b=DB/xiqy7mE2xzkRNEgVR0e0IHOZfXaeurX4yt9YNAPh8si2NJiIdM82YQcGIcMB6qm4aPvrXO0DtA0Bof8ctPmidN5WD5fTAy//BpPJHaTe2O1Y98C8HnprAoCl8oxEB/R78j/ltBOs/qkyFo6icMpydFF2/CtAVBId0SEMNN30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 06:17:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 06:17:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
        tao.jiang_2@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: notify source chagne event when the first picture parsed
Date:   Mon,  9 Oct 2023 14:16:57 +0800
Message-Id: <20231009061657.15319-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be617e8-1cb9-4b90-7de9-08dbc88f672a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt4YF070bQ+rUydk3MX4HXA0Cm2mfaSiOFXWql2qrgEieuKf0+r7aIvhdPhzRfMgdx/yYXwLIulfBSSUNqR5fKbZ05isuHngYRYy4kNxtFHFR1l+YTL3dZQ/ODwSr8cCVpSk7ctqlopL2/l8anvUP4jmC8UEcT/IovRsTLgN4RAO53klFm5aGvA/hQiUjR278h2lHZSvt6AGGqvYs6iJ/ONDJ/0vZCYelnlNkEdz4xGgLbkHXojssuImE/iYOJKmKpkt54tLlsnvXEdfQ3lVWT0fzEMFJ/9hAtYqZhTa/EBqYO6s2gOdGOcHCjvBYckMUBtTbFEvKCzWqyvK/ajCiy0OA6WY6LgBtBflJ4PunyE9taGxXdCPJHLMk3HtOVVJGXlyuasWScCwbel3TCkIzN/ZU1NM1mJuYrq/jt45swulcyLQGk71QIWF9pbe4UnMX/5d/UUocc2xxM7xAgfYbhDUMtwH+7JMqIBkvrphUvyssjnIFBhMzLDRUrjvdmizsMdWHEImN/+W7GLlOA1DMdA7gTOZuOr5IU24H5D/uqauzRUU0fxarSKqDc4gzzDDD0qxIchH9x3kyT6AqxDsapUZXYK2DvUJ9g+Z4eS+J7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(1076003)(2616005)(26005)(316002)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(5660300002)(41300700001)(44832011)(6506007)(6666004)(2906002)(6512007)(966005)(6486002)(478600001)(52116002)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o7iVxsacQQTZLGYyq7UIKFdVwvZmTaF0R+Kw3bm7DrB5pM4CDMrtcW1Foisx?=
 =?us-ascii?Q?JpkZhxtJU787wXZmG/R3lUSH4Dj4DKtOBZcJMx4CO0C6+AC5T988GRbq7l6L?=
 =?us-ascii?Q?4RkanaSZlxU/ixDzToJXclJwvS+xQ7eO4t8FEI7R7zRJQCuSRpMOJbD6JG2Z?=
 =?us-ascii?Q?ohkhXOpQ8SePvNCI1b2BBVUWssqzHK+Pe9vxNnp+WanQI+7DRmSnbFoBf9nS?=
 =?us-ascii?Q?O0tfiAixXtnKCd88Qr4HnGRDOGdvxCx1M4+UpCVytFoFDDMZG4QSs1fOY8bh?=
 =?us-ascii?Q?oWCAiZ/hTsBm31i5DGR/SJlwhdZ4d5SLXDCO05/xh9rAVndn0d0PQDWc5mFN?=
 =?us-ascii?Q?bow/MeAXZT1QiiB13LR88xHUKm8R5Uxjw42zRHCNOLBL8SWVHXK/sAcNIWUS?=
 =?us-ascii?Q?+wlrD0UsgdXnXiVjj9hqsJsttpKc4XZPX7TlhihdZDElyd3wUsSDbYJYXGgs?=
 =?us-ascii?Q?FmwbOBAi5ay2ugFx7XCvbjGzhBw98SnSMAqLHmKOizMFgmVPWKUQ44njRtAf?=
 =?us-ascii?Q?pmfq9FXQlEIgYlE+KZTaer2AXQcH1lUC73cRU13uY60ESf9Y3tOA8FHSxuaQ?=
 =?us-ascii?Q?VYcvidpg4NaBKmONzDYrkJI2iD1r4Zq1c7ahu8IDleGyRVae962xp3Cqy8UR?=
 =?us-ascii?Q?yKTB1VTsXDbn6HTXdsF+ppPgoAVVBpUWFKTGatt6DRNl+soiaJ3BfdV6niE+?=
 =?us-ascii?Q?6GbZmb2wyDK+Bhe84CxVKqRVa1R8aquuSAz+c4ff9pURvMnJEg1DsfCLfVRo?=
 =?us-ascii?Q?B9Emn8v7As5slyrEkKvS21XgUiRMqfUZtZl26iX5kRpe63lO0ksyE87BVI3S?=
 =?us-ascii?Q?AJiZEpWiZjBEn9/IeYwaHvqLEVoAVZMjdmiIYZ60yDA8aI7wlDDpwUjuM0ZI?=
 =?us-ascii?Q?v7/YhL6uFzuOHHrMr30592w/I4k1bLA2lDzv0gQh9Nq3aA1pNfoAiJ6SUJ/d?=
 =?us-ascii?Q?DkiZJyIW4pUmdCpzO9C/RMLzl3Yj9ZD3FHOwYqCht4zhZ05A0WkCROlDEzIJ?=
 =?us-ascii?Q?uYBDs/FVPpsMqXEQeuKNzT1Z0btXKqMO/zJ2O55RVdVU9UVE4vKAudhXZUjq?=
 =?us-ascii?Q?T4YFPnCeQT+T+7N76J5NUvB2esOIT0Gc95e4LsflsWkyIYks46KkPXqP9bV+?=
 =?us-ascii?Q?ZLBZ+jD0Xj3RGn/tuelKQtWBgnA9hG2tp5L+22yeZawtYXOzxuFzq0iKfpqa?=
 =?us-ascii?Q?3Bt4nw2Z9UjG9x/135VkoHDi92CZlBUOjLMt2QNZSXDwU/twiymCIXlHeQVQ?=
 =?us-ascii?Q?NuVyMXHLLihJrCv/+lVUxvkQFhBE4rf5mXBd54RQteSz2kFzW3ZRXkYxq10/?=
 =?us-ascii?Q?Gn73QKATzGSkVXT+eWwbfRxUV33os2JYE08AztkohVkhn70M4XO8AqKOn8FC?=
 =?us-ascii?Q?5viqEmNjNM2vQ+Fu05fINMcVSWeJo3CBK0eU3KBOcyouHD3uGU6CkAKMRfMG?=
 =?us-ascii?Q?DK/2bZliA7UdE/DPZSzDwiSxoi7gZ42jncmpySwhyXM0mtdM3aTxDrPPSMJq?=
 =?us-ascii?Q?M4PMlF2TqiNlyRasVht7xuYD751dnrzhK4iFwPf4KNme84Mgr7qACaaNcmhr?=
 =?us-ascii?Q?lVFJW+MeENhpBpLV6hiUFVy7MTaRNNNiQ31DpTDN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be617e8-1cb9-4b90-7de9-08dbc88f672a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:17:24.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PyxNZ5Lld3UoummkS2DmMtzgm45gZRw1kein6sxAQ0xbbswXi7pW4aGa8AeQgjDQ69sA0qQ32gbxDNvZdaplg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After gstreamer rework the dynamic resolution change handling, gstreamer
stop doing capture buffer allocation based on guesses and wait for the
source change event when available. It requires driver always notify
source change event in the initialization, even if the size parsed is
equal to the size set on capture queue. otherwise, the pipeline will be
stalled.

Currently driver may not notify source change event if the parsed format
and size are equal to those previously established, but it may stall the
gstreamer pipeline.

The link of gstreamer patch is
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4437

Fixes: b4e1fb8643da ("media: imx-jpeg: Support dynamic resolution change")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
- rename a confusing field

 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 7 ++++++-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 3af0af8ac07b..c538440abe8d 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1348,7 +1348,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
 	if (mxc_jpeg_compare_format(q_data_cap->fmt, jpeg_src_buf->fmt))
 		jpeg_src_buf->fmt = q_data_cap->fmt;
-	if (q_data_cap->fmt != jpeg_src_buf->fmt ||
+	if (ctx->need_initial_source_change_evt ||
+	    q_data_cap->fmt != jpeg_src_buf->fmt ||
 	    q_data_cap->w != jpeg_src_buf->w ||
 	    q_data_cap->h != jpeg_src_buf->h) {
 		dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
@@ -1392,6 +1393,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		mxc_jpeg_sizeimage(q_data_cap);
 		notify_src_chg(ctx);
 		ctx->source_change = 1;
+		ctx->need_initial_source_change_evt = false;
 		if (vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
 			mxc_jpeg_set_last_buffer(ctx);
 	}
@@ -1611,6 +1613,9 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 	for (i = 0; i < *nplanes; i++)
 		sizes[i] = mxc_jpeg_get_plane_size(q_data, i);
 
+	if (V4L2_TYPE_IS_OUTPUT(q->type))
+		ctx->need_initial_source_change_evt = true;
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index d80e94cc9d99..dc4afeeff5b6 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -99,6 +99,7 @@ struct mxc_jpeg_ctx {
 	enum mxc_jpeg_enc_state		enc_state;
 	int				slot;
 	unsigned int			source_change;
+	bool				need_initial_source_change_evt;
 	bool				header_parsed;
 	struct v4l2_ctrl_handler	ctrl_handler;
 	u8				jpeg_quality;
-- 
2.38.1

