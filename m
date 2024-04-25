Return-Path: <linux-kernel+bounces-158084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC58B1B41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6687C1F218AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83B6BFAC;
	Thu, 25 Apr 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r02bg8/2"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C45A11D;
	Thu, 25 Apr 2024 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027846; cv=fail; b=p7BCRkvbx+Gm4M21WUTbG9CLKzBXh5gJ4evcv0Yg5PgYtW3hLzJIXGg9O6Fes3UEUh1VZHUL/yis9bS2JIaoE1Ud/eWCGvUPd5cN4gb5hkHCvxs2sH57ms+m9iym0MVLckbAv/cx/ovnqwYkvYTZErkeUrltIZjRyJvXB2tssfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027846; c=relaxed/simple;
	bh=mmU+zePcFxn/lN3MmcMQNqBG4EyBouGvTCjErT7lQyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fb4WHqyXfaoMGYM+lv+dm63mvSFUIEaV3wj+YR0lTBTLUSzMXAQMZ3K1vwEfxl9DlG2Cw2/0ZvzTf5khZHA2D+lCHpS89EBEUO553+5BRJZhbgYmEIJ8zG/3oMZXrHTKICo8SeK2z5Q5jEAXR/UGROiR9fFfa4HfOS1us7H0miY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r02bg8/2; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdHi1qMrrDbKZP1sDKeuKiSyJfTK+HeOJ9ncFPCgnKZI76NbPNjJfOciVHMbkEW+YFl8RLGVDHRuhx6G/WZ2M20TEaUnLG9+2ZRfAgVbPIqD4dwSXWlIYjLeY4dawNqPqNbh5fZU6pxWPYpOQa2ioL2wWVM/2rVcWSwit4LQTFNN3fV0XN5udIRJIqx3xXWopZrUuBR7E0mumsMFm1xEG/te6nBVwk1a8j0I08ssL0R1Af+yeBoZYrz5rqd5dlhiiNCt9NkT+1Vxcm2Lw5hu2QI+7nSnl7Xud4nuUsHMbdMoFisemHQVoeqpJwYWHbgDP7Etfn/XbKyXqC5oqbIcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0noLQq/4KoXdHGux6YiTKEv0yPUugR/8h3uespzAVc=;
 b=BRvJdfSbmKk2dGmF3lPgTxTh45uo72adDOgsK6VI0+tmOmuzo3yM5lP6Q5Ec+8iH12pwh2Yzge/dk1/82VlOFWnQoblIOR1YjFyCdkDQv8wxmAsKJZUUHfCdYq4ugaOMcjHUsEoj0jfvKNlB/GpqemJkyGAk5EEOD0gXYbDXFF9BFXvTVt1FM0BwJd4be/KoiX+ipF/k/YKeGgDa5LjB7hYFJH9Mp+F6a1g8WLFDOtwFSL+zd/GVvwSXbBLQGWQgB6K3bgFN0EOnHkxSMFjbOvogbdhekkNyW23713QLmErDPTv7h7F5xi7F16B+58J6xbifcoKww5cdw/2oabvQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0noLQq/4KoXdHGux6YiTKEv0yPUugR/8h3uespzAVc=;
 b=r02bg8/2C883uGMYEQSqX+/fzU1dBfISaa/O79ES2VDM8UB2YSxCyhrxXSM8u1cn5a9ZaWRpzbRbCGqxAXF749Rv7AMnpeVzPaCWDAiEns+1k9TjLOO3Im3JRAoY7t99sU4lAVr46paK8imBbOTr0y5Ll6DtwgXK9jI312z5BJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 06:50:40 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:50:40 +0000
From: Ming Qian <ming.qian@nxp.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org,
	robh+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	xiahong.bao@nxp.com,
	eagle.zhou@nxp.com,
	tao.jiang_2@nxp.com,
	ming.qian@oss.nxp.com,
	imx@lists.linux.dev,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] media: amphion: Report the average QP of current encoded frame
Date: Thu, 25 Apr 2024 15:50:10 +0900
Message-ID: <20240425065011.105915-2-ming.qian@nxp.com>
X-Mailer: git-send-email 2.43.0-rc1
In-Reply-To: <20240425065011.105915-1-ming.qian@nxp.com>
References: <20240425065011.105915-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: aba0c73d-e875-4e67-0f5e-08dc64f404fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ofq/ajAIPpYBZg/4Hv4+V+v2Cpowy85Z0siiqHoQaFcue4ZSrwmI7ZAx6UtN?=
 =?us-ascii?Q?tW3i2NbIBTG3aOxXf1t2LFmr5Oyc4maEIE+vbRQpbvvVyiKbHcGCXEFNnc7c?=
 =?us-ascii?Q?DsNvnxw4wtI6feJAgEadU4QsrVAdwU92rjHk2liOY4HcrA7s87kuf3aDQU9R?=
 =?us-ascii?Q?Nqqpmmxl4ASIzYmreVy6dwJC5hUGQAPTKKFBW5zEP9DHjlJ5H7rI6JVHVJHH?=
 =?us-ascii?Q?WkxkkLOtFB4b/5Zq6FH8ZjSXhr7JyioOhTQJZTTdISvFhb3qSZ14nHUwxNWB?=
 =?us-ascii?Q?hR6BoTh+ZrraNWlUvxnJfQ2cLmeQKcRxP0LlRjgHR1aSgTsPBZ7bIzZPqv6R?=
 =?us-ascii?Q?wZvNtKhXiFzqlYqVb3+9oa0ukVvdBKnsetTKs1E2TGHrD30t8zFLxap212nt?=
 =?us-ascii?Q?doUoHBQqo3ohBkRHgBXaD1a2H9tKcCjjLGtoM7xl8ECCkbpiY+11xxs2r2II?=
 =?us-ascii?Q?4eGSj0cDNnpf14mPmXqjt0bWyNAK15xz6qgUDPqbJheBCg7LBu0NoZZLU40E?=
 =?us-ascii?Q?joGjSlSToXwuOkq0gUlCswxyRiMAF8ZqnJurjg5aVS/7uzmbsVZaGcfj18Gx?=
 =?us-ascii?Q?+P0PNDHFOJTvwEfZYEAeP0KkWw5R+WFqVWF3gr4LDFJWXseAok/Pk1A1XpDQ?=
 =?us-ascii?Q?vTIXWDPW3CAByUdFX8Dyvmr7GBKqk2JmqGk4FTeGV9vo4g+Sm8zOxE3OEg8M?=
 =?us-ascii?Q?MfarWl1xABLWXOoEHnHLI/Ko1Oagdtpngt85/v03KawjEiYSOwHw8zE25Ghu?=
 =?us-ascii?Q?60f44vJNk+B3WlGytmPfbqigobyMm+dS4a8tPbfZYAfzF2WzCTHjLW8mtXi/?=
 =?us-ascii?Q?GWFp+gNZTeJQSJ1KEBmv9JDKrUgXOMwjvNj0cjFppr4xHBzvOLGxxSD7IiU0?=
 =?us-ascii?Q?jmyA2uy0AnkALgCXgm96tsFKOKJ+vob/yd8iNavS8lKN4gs+b9bgCBZpY13i?=
 =?us-ascii?Q?yhwzHIvh6BFlYm2pV27syv+jDF8JmEo0bi4MRg0ThCCrDdeTfqzg7TeE1Sh8?=
 =?us-ascii?Q?17KtAEyNhSnEDLJv/jjAnAKNn0HNdon/rk6yspbXE0rT/r25O4hLRlV8EH7T?=
 =?us-ascii?Q?q8taRy/neDMXwdSFRuQuIwLFRgB/zmuqYrEIxgw+wU48sdktGdsmG6hlp6v+?=
 =?us-ascii?Q?HyV2rGZYnhaRVr/NC/5J/CjSsYSx00EMi1/xzbX5qGB+OP5m0E5qDsysxaIa?=
 =?us-ascii?Q?+urWqLzHk9ttfyA2UATGnKnRVf1YbuDJxIan2iH033NAUyZhN/8YFrS+JNOj?=
 =?us-ascii?Q?ssZ5wWH5t9iwKeoBaU2gr+bUTpnmbsp2ZDeg5W+20SCIfyaJUh1MJK9ahFaf?=
 =?us-ascii?Q?ieWR6TORsv2hu3ZU9tSElSOasyUxw0rhhDvawhWjfIeJ2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+aI73CGegqJ08xGflU/eQJ14I2H9/Z2rd1ThRoYSaBnbYregdOnJdjRc/a9p?=
 =?us-ascii?Q?D8miyVnoaY6suKXt+RXjyyrx44jR6U9cYGXYoBUNrA6XQujXQm/DsNHeYPUT?=
 =?us-ascii?Q?TU2mHAPOoFMPXtqDqeeJ6Rnt0inDg1Bl7dH1gVexON7pjR6ZhaBp/DMSl0v1?=
 =?us-ascii?Q?0lmCCJrw6QO0jsT/aEnLehJ2ziLlQ7YBCxuoBubyGiy1PVLfvGvF0F5ZEGbZ?=
 =?us-ascii?Q?z7YG5ApgkX5T7LL6vQTJZesTEVbdAY9f8KShoieYghBoJz6HuEsJ6xO5OCDw?=
 =?us-ascii?Q?7o+DVeVL3iqOj2/CVU2Ic2N6+oz2y65na8TLrLkbsJLhUBQnAexO8cf37Qwf?=
 =?us-ascii?Q?tsp7qxZlmZ1VIQPXZuVFpCNlePe7extfsrbv4EtiEUSqBb8o6wm7MXvq/zNe?=
 =?us-ascii?Q?ndlvTUC2j2KkznbtoeWYApQsI1HuF+bPX7ih+XS3RUqhgzwfoH5vhi9irc5D?=
 =?us-ascii?Q?vCxvNWLqDCi4IiVgTs63uuow8QyGsDleTYlAE8f0jfizSMP47Z1jsqmLifFE?=
 =?us-ascii?Q?0U4U7Oq+Vkh23AjX5Vuj71lQYZZOznXnlwvMBajeOqlT9rjS7Bh2tLUVf2yk?=
 =?us-ascii?Q?jBH/nol3qgeNKgAZ3e/5dAkjf638ILnD6IyXlZt61Fok3b4G4ww+wdfygvvV?=
 =?us-ascii?Q?dqydslY/382jm6XZQM36f4KjjxEDKzLbnz+ZnyqdDtttz2welPmEzwL53sFw?=
 =?us-ascii?Q?5Mq06K0COMkTXYUQFDaKgFnMQxVblAfHn0ScsCiZM4Ih3Cf1RWv3AYGFCaDl?=
 =?us-ascii?Q?qyVUN/LsvuCrIIMbo6EOZ5oGrW3zjCNr9s2JHt+HJmLfolXiJSnxL36WVkjt?=
 =?us-ascii?Q?Xo/QvwQDUMfbHL7HJPXjQlLmhn9EO7xkDJ7yfeD1WLKk+JygGY5s1eDMr75p?=
 =?us-ascii?Q?9tepWlATei/bH2wr5OYCDstfTTOH7PVXUTJqhSwEdcg6UNmVF+K1I/MG6lCo?=
 =?us-ascii?Q?QfhBhvMizgJFsepxQL2U3r2eJMt68grSfHQRAMM5argT5CHoiPfMoGVfZie4?=
 =?us-ascii?Q?JtQ4+gBFdtY4bSkRa+do0S8PcvRVAO2V1EPuKCpUY3L8esDxk91/ktE94Q1V?=
 =?us-ascii?Q?IrXzQw8+6Cv6X9g7gZzWtA13J/fyzFy7ukWlq4oZ7cGHHx7elRIuxcCcYCcQ?=
 =?us-ascii?Q?+tgWES1yIFOjbJWhL3a/OXepZUUWN2v/p4/NPC+AfSm5xHmjEAM0HhCcn2l3?=
 =?us-ascii?Q?GuFcNhPDht4tyen38Ug7SxjrkE02NYXHU35099/F658tXcWbQV8BWZYJHWzc?=
 =?us-ascii?Q?bRGWNzSVk+kftjaOXkjDDoAs7HslIDGMhPgfLPBgYGLIWEJS6DSNPxEZ7gA9?=
 =?us-ascii?Q?vWcaXCiPAAonDzMEXm0fEtPEjHktFcPZvmeyTE90o9XaJTSaVj2aW0gydbQI?=
 =?us-ascii?Q?V7Y91ySsqiO/8W7cpDLUl1g53ykkbxF6qoNj5oL6GxXaRZ/oyK5civGXnnNV?=
 =?us-ascii?Q?UQJA/bBPBcIwWFyqpJI22Rt1uJtn6p8nTmGZ4r76dt65S+cZVNc6V48YwgQb?=
 =?us-ascii?Q?Ll+9fWNXZjCkf3x4QRTbohXXgZDv/rGyPHTpjJ29DaWuMWVsYYDW6VicAo7O?=
 =?us-ascii?Q?qaXscyrzxtcUvzHUkugN6XapDEEu/sbQcspfvBUY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba0c73d-e875-4e67-0f5e-08dc64f404fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:50:39.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPuDYc4seZGbU98uf9sPSYxZABeA3rzT7jt5m+mLcBKMOIOiTBFtqnTvBGv4RYXZavDECCmaYSBYWPAg372l/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

Report the average QP value of current encoded frame via the control
V4L2_CID_MPEG_VIDEO_AVERAGE_QP, the value applies to the last dequeued
capture buffer.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
 - drop the volatile flag

 drivers/media/platform/amphion/venc.c        |  4 ++++
 drivers/media/platform/amphion/vpu.h         |  1 +
 drivers/media/platform/amphion/vpu_defs.h    |  1 +
 drivers/media/platform/amphion/vpu_v4l2.c    | 16 ++++++++++++++++
 drivers/media/platform/amphion/vpu_v4l2.h    |  1 +
 drivers/media/platform/amphion/vpu_windsor.c |  2 ++
 6 files changed, 25 insertions(+)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 4eb57d793a9c..cdfaba9d107b 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -680,6 +680,9 @@ static int venc_ctrl_init(struct vpu_inst *inst)
 			       ~(1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME),
 			       V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME);
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, NULL,
+			  V4L2_CID_MPEG_VIDEO_AVERAGE_QP, 0, 51, 1, 0);
+
 	if (inst->ctrl_handler.error) {
 		ret = inst->ctrl_handler.error;
 		v4l2_ctrl_handler_free(&inst->ctrl_handler);
@@ -819,6 +822,7 @@ static int venc_get_one_encoded_frame(struct vpu_inst *inst,
 	vbuf->field = inst->cap_format.field;
 	vbuf->flags |= frame->info.pic_type;
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
+	vpu_set_buffer_average_qp(vbuf, frame->info.average_qp);
 	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
 	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 	venc->ready_count++;
diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index 0246cf0ac3a8..22f0da26ccec 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -306,6 +306,7 @@ struct vpu_vb2_buffer {
 	dma_addr_t chroma_v;
 	unsigned int state;
 	u32 tag;
+	u32 average_qp;
 };
 
 void vpu_writel(struct vpu_dev *vpu, u32 reg, u32 val);
diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/amphion/vpu_defs.h
index 7320852668d6..428d988cf2f7 100644
--- a/drivers/media/platform/amphion/vpu_defs.h
+++ b/drivers/media/platform/amphion/vpu_defs.h
@@ -114,6 +114,7 @@ struct vpu_enc_pic_info {
 	u32 wptr;
 	u32 crc;
 	s64 timestamp;
+	u32 average_qp;
 };
 
 struct vpu_dec_codec_info {
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index c88738e8fff7..83db57bc80b7 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -63,6 +63,13 @@ unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf)
 	return vpu_buf->state;
 }
 
+void vpu_set_buffer_average_qp(struct vb2_v4l2_buffer *vbuf, u32 qp)
+{
+	struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
+
+	vpu_buf->average_qp = qp;
+}
+
 void vpu_v4l2_set_error(struct vpu_inst *inst)
 {
 	vpu_inst_lock(inst);
@@ -539,6 +546,15 @@ static void vpu_vb2_buf_finish(struct vb2_buffer *vb)
 	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_queue *q = vb->vb2_queue;
 
+	if (V4L2_TYPE_IS_CAPTURE(vb->type)) {
+		struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
+		struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&inst->ctrl_handler,
+							V4L2_CID_MPEG_VIDEO_AVERAGE_QP);
+
+		if (ctrl)
+			v4l2_ctrl_s_ctrl(ctrl, vpu_buf->average_qp);
+	}
+
 	if (vbuf->flags & V4L2_BUF_FLAG_LAST)
 		vpu_notify_eos(inst);
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 60f43056a7a2..56f2939fa84d 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -12,6 +12,7 @@ void vpu_inst_lock(struct vpu_inst *inst);
 void vpu_inst_unlock(struct vpu_inst *inst);
 void vpu_set_buffer_state(struct vb2_v4l2_buffer *vbuf, unsigned int state);
 unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf);
+void vpu_set_buffer_average_qp(struct vb2_v4l2_buffer *vbuf, u32 qp);
 
 int vpu_v4l2_open(struct file *file, struct vpu_inst *inst);
 int vpu_v4l2_close(struct file *file);
diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/amphion/vpu_windsor.c
index 5f1101d7cf9e..e7d37aa4b826 100644
--- a/drivers/media/platform/amphion/vpu_windsor.c
+++ b/drivers/media/platform/amphion/vpu_windsor.c
@@ -499,6 +499,7 @@ struct windsor_pic_info {
 	u32 proc_dacc_rng_wr_cnt;
 	s32 tv_s;
 	u32 tv_ns;
+	u32 average_qp;
 };
 
 u32 vpu_windsor_get_data_size(void)
@@ -734,6 +735,7 @@ static void vpu_windsor_unpack_pic_info(struct vpu_rpc_event *pkt, void *data)
 	info->wptr = get_ptr(windsor->str_buff_wptr);
 	info->crc = windsor->frame_crc;
 	info->timestamp = timespec64_to_ns(&ts);
+	info->average_qp = windsor->average_qp;
 }
 
 static void vpu_windsor_unpack_mem_req(struct vpu_rpc_event *pkt, void *data)
-- 
2.43.0-rc1


