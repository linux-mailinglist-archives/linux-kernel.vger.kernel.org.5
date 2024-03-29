Return-Path: <linux-kernel+bounces-124327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521F8915B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6ED51F22C31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42E45951;
	Fri, 29 Mar 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i1dilrej"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2118.outbound.protection.outlook.com [40.107.8.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308B40865;
	Fri, 29 Mar 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704271; cv=fail; b=DUxKLVOEFd2AXSCxkW4a2ZrbsWZ9iVfAJ1FgMi48mr4g38xaDHmhyykzNGYUXB25sDIamGf/GkbBkKE0iswQYvBtbff9YdBGStcusehTfGZJEg5tHyBKIOgBEDhunWEJ96LXuPTDstxOJoWnjdDP0lLPUADM2m3SQi4/QFKRvkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704271; c=relaxed/simple;
	bh=1rWgh4DUFok0j311Cc4kHC7/Rn+5Ck5uFzeGhhJG9zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2p4JfqDa96CNtqcWVbg+kZiWkZNuvGiYsKgcnBzWlNWmJq9dfE6FPqxzg4VlsIxLDmgyG72VRF6f+2hsMZ6m9UukZjHPh4zp/vSV2juz3NLwtKgMT45O0DkYcQlIO9JveDjOm0QMizskuQwxWr3rNvVBdRk05CsOH5ygWfO8qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=i1dilrej; arc=fail smtp.client-ip=40.107.8.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcfXqcFwYgY0doAcQxjboTbqXgFV8K/XlpGfAMB7iNL/KTtu/tF/yMjRrMQK6BQ44jZkYYbF7tfSWUrkOAI97GISixtNcB+MMwHF9Wq/ENZ3SakYCZlfjmdaQyYFTckhJ6fMUF1NGpb1JRW8W9EFov3uQBIIRP08zg85FVr6ouIaYPebo+PGN6ClKQuMwZ/hy7xcVCO989rLqbQ3lqaTealt5bLSmDVuZp2BxpTfr+PhIheBmJIFiSC+nb65Fxdift6KXJu7ANRw3W2l9Q7ueoTMpomb2BXbUvD++gJfr2LLIpEee9o5QhJv4rRPDxnyUFPB/mfb2FdgUF1nD/qJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMFaKvUuHX+1VHJEEM6NLZqnsucukjMHPwV+vSOhDmE=;
 b=F4wiK4jYLBRXKZ+2us+t0oex4jpc7vYurMAUAqo1w258W7CYP5hYBREqTOhrX/0UB52fBsBnX7NeTqWLN4Ri/0/X2eR/a8ElOEWEuDZpQox6KF7sJ5i7JY/VkqXCQLtYtmurVLIgHRlUK9/5oiZzLLWo00OssOgkiqrCexF4aiLQZJPSua0ZY7WPgIHQetoT8ZeASPrYaSBuUZVFmRNLvbQoVKsLJYaxx7RuzBlcNsXlcw47tPcEzeDiemRjYPCoef40NDbVquyctUd6DI5+/8zjTRsX9dfdR3EkelRIFyUkwNm58bQjkWPeOHxVqQtTNHUSKB/yVtdXkSENPp8GSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMFaKvUuHX+1VHJEEM6NLZqnsucukjMHPwV+vSOhDmE=;
 b=i1dilrejmTpbroqAHtkmrEElJz3U7VRng703jVVxplkDHWow2nHLBOnk95cvOb/N/PK2KeEkdrnRx5mKsYVBPtWRMWl2yHoF9CJPakV22M2fRxuixPLTcXYaOGB7K8CK26Gswq06QSQSVWwIJyPEjAlXaFhML2JC26vH7jUqa60=
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GVXPR04MB10475.eurprd04.prod.outlook.com (2603:10a6:150:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 09:24:26 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::da55:641a:a6f2:6e4e]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::da55:641a:a6f2:6e4e%6]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 09:24:26 +0000
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
Subject: [PATCH 2/2] media: amphion: Report the average qp of current encoded frame
Date: Fri, 29 Mar 2024 18:23:52 +0900
Message-ID: <20240329092352.2648837-2-ming.qian@nxp.com>
X-Mailer: git-send-email 2.43.0-rc1
In-Reply-To: <20240329092352.2648837-1-ming.qian@nxp.com>
References: <20240329092352.2648837-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|GVXPR04MB10475:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wYY2dAIIrcvbQRDZ0D2z+Hj/BUAt/yx1AKXD+Fw0+MiX9Em4adm+vhrHrIq6PMw2Ssfb4ojC0qUggCLCUKfQHPbFTgu/Xzbu2iQftxWuLwdrGYZ23mQTdQqo7rFDZbbvwkweES+OHDyTGPILpW6kpxA2K2ubKEjGPwXOcSDn7VWX7bOSre8BSAFBbLKnrr9YuT9NykqxdcnRTRcjmXCHpQJUwhry1jAQvoJj/WOfTtnnXm6OXortZNE6kMBPv8p64xONKkKKuH7S3GI+BhKjYqhJnRDqc+WN0aTNK1pVzNn7JsJZSn9Thbpgck+LMq3mF7ZTbS18JRqzIVkBQrcmGqxvNS9FRod1NFcFzkaXwxZFIVT2Pp1oZz8KM2xhvx4YZQh3AIa7KIp/OSOdblzayHDS7El/NjO/SfgXoxJwkUVX1S759UDv3KRuwrrIlF8ALpbA+exeZqp/j4m5R9J6vX05MONyX8sQzHvp9xvuasPbJsk/hEQtjylICQhfNmfzJYQs2SGZTkTH7BR+3DDEMSXIIuLxlQ+oy9LAO4eZn4IwZbCFASmM/Gq43XKr6nVcGz7CxKK+K+y2zD77b/SvUqhnwQyanvSLH1hW+DQOuxvZFrp2rxztnYzVKOSXqz3nXOPeZKdivcVFfz2AkKeRPV7ikTCfqrS3d/WbSwfMJeoIX8R8d4hrDJMr/HmQvK6yS86esK3n12aN7MaECUStqe9Ma3uHVizSXwyexd8MnVI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKRv2fp0qmv6HnHzti7+GhX/xxx5t920aT8WMO/Garnm0dPNRYrkCtykNlfJ?=
 =?us-ascii?Q?M+YEPsppsUae5GzyPSXTjzH5dCLWb9VMzmbuM6mYP3O93qPqvb5yqSlJh9qZ?=
 =?us-ascii?Q?R9YmSP2+25GPz7xDzZd92S/+35JUR/9tgUYqmCGnsFLhuHRh3e/+M6dK8GK+?=
 =?us-ascii?Q?1V3R7UGehYT2asHobE3ef45ucnxI6ZNmX5BFl5AsQr0rqz2fh5LnLS8kN4w4?=
 =?us-ascii?Q?FefoGZ2DAl4rG00MYrOMP0uSkP1kliYCi9qWA0HGi3/Q3+n+v0QtthaTnyJY?=
 =?us-ascii?Q?lRe16nMX+ejKVLk3JCqg4/simGr0weO5//6CPjr6u2ArEBB6mtNICdBRxTgF?=
 =?us-ascii?Q?ZxHMYdWi8bZiWiqykuqV8ASDyfJ4tTcHQW4xLMtcCQCpi4CkXx3eYBivoCGd?=
 =?us-ascii?Q?IsnTULXuST4SzS1EiV21jisdivqWR7ktlsLkVvlyNlhTIAksVYSO1l8LPmLq?=
 =?us-ascii?Q?drVz3gmos+av4WkhCU97ar+9i5a5QUAhYNDosNBwndU/DReJ9QhztjUiusNo?=
 =?us-ascii?Q?UHMrElea+wXa8ouonOmEzABvKW601Y0gg24mtFDVmRqJ0HZHBRCHp9veYIdO?=
 =?us-ascii?Q?KPSSD2JSwbfpoCyV2xPr+eOIonDhlFsg90fmSSraNJ3bbaw5uvCFiACWsWBt?=
 =?us-ascii?Q?E5FykTZVKy04qcL1p8g1cQs+vzKYr6P1phjEq8u3HR7RC8JwqYoWHKr0woB9?=
 =?us-ascii?Q?u3C98KLMaeOFJ2bKm6gsx7Hx64ai7RFr6VpV5hQkNMVHD8eXz7DDmKjq/ODQ?=
 =?us-ascii?Q?v2RIADrpr9V4ApGhvxlriA5XnmE2CIYJPY+xFWBYIw460zLtK50bovvbnqRW?=
 =?us-ascii?Q?wIqt8nK17AicUuHJMNpm4rhR7g2WYTaPFuhBdmKrYgF2a8SeggTGD/LgSKXy?=
 =?us-ascii?Q?kgD6f3hcDNCuQ4KjpgUOSYJiytq4bvAFMerIOt8R5w2Gb9Mps33e/rSgUr+X?=
 =?us-ascii?Q?P2td0jmjq7SpLMx3LyLAAu8/Z2/qDXrZEs8QFN7ZLOJzRod4lPKn49oMbilR?=
 =?us-ascii?Q?dJZI8VOGerKmCYy7zmQmukvA225jxGqDVSZvsjBNyN0QWv42Hovq5T8Cgi5C?=
 =?us-ascii?Q?/TDR6Zb7fYOYcgQ2doOi9jQCjMCDFSranY12aAVx1HzQkt1TOgZKHsWeolF1?=
 =?us-ascii?Q?7Lof7IZPqBglj+28AM9270r0omQFM7kB4+/+GOykFzpmNKz/ChHx148Sgisp?=
 =?us-ascii?Q?lSNsvSXNc6hrSOJwaCTah26FXQi4/OrG772oGSJs7XGTXq5EftEl25qeK2mn?=
 =?us-ascii?Q?ckFs56lTEjOsbT3DIyomEdGdfwOSF7c73pa6BPSmyFjiDFbsKV6JxoHglBVY?=
 =?us-ascii?Q?zQGD80dgkq2ZvBdhCXROsRVUwL8ufMY5MsadpOjPigqhjxW06aL2JpHlg1VD?=
 =?us-ascii?Q?YFZo6w1Fvu/BOeuZGlJOER2HBlVJFFEEL3M/5XnK4BEIjAtcil+qqURtEmK5?=
 =?us-ascii?Q?BKISsrc9OzvUdvUVrGtEyrUljl5Gflrywn5HIov3UeBSO8EAzMS3/fLjehVL?=
 =?us-ascii?Q?q1oMJrPe1AIWGZWvMk62lv+MMg8mWVVk0EapYWQT8DPaw8zS2dWL0te7gdH1?=
 =?us-ascii?Q?EeupikromafSGytKAfjjQ9UwsttggflW/u9NTTjV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6a1c81-7b9d-4492-9bed-08dc4fd20767
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 09:24:26.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0hzS9gnAHO/Cb8oTI6a6G9Xm7UmgKr7FqfFZMvANtBLZL3RamDkjLUezozyjGN+CSo2JXHPxvMhcVt7Hdjuhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10475

Report the average qp value of current encoded frame via the control
V4L2_CID_MPEG_VIDEO_AVERAGE_QP

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c        | 4 ++++
 drivers/media/platform/amphion/vpu.h         | 2 ++
 drivers/media/platform/amphion/vpu_defs.h    | 1 +
 drivers/media/platform/amphion/vpu_helpers.c | 3 +++
 drivers/media/platform/amphion/vpu_v4l2.c    | 9 +++++++++
 drivers/media/platform/amphion/vpu_v4l2.h    | 1 +
 drivers/media/platform/amphion/vpu_windsor.c | 2 ++
 7 files changed, 22 insertions(+)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 4eb57d793a9c..12cebafeaf3b 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -680,6 +680,9 @@ static int venc_ctrl_init(struct vpu_inst *inst)
 			       ~(1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME),
 			       V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME);
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
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
index 0246cf0ac3a8..d21ca6bf2459 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -270,6 +270,7 @@ struct vpu_inst {
 	u8 xfer_func;
 	u32 sequence;
 	u32 extra_size;
+	u32 current_average_qp;
 
 	u32 flows[16];
 	u32 flow_idx;
@@ -306,6 +307,7 @@ struct vpu_vb2_buffer {
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
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
index d12310af9ebc..59139302cb1d 100644
--- a/drivers/media/platform/amphion/vpu_helpers.c
+++ b/drivers/media/platform/amphion/vpu_helpers.c
@@ -378,6 +378,9 @@ int vpu_helper_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		ctrl->val = inst->min_buffer_out;
 		break;
+	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
+		ctrl->val = inst->current_average_qp;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index c88738e8fff7..893f494ffb0b 100644
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
@@ -536,9 +543,11 @@ static int vpu_vb2_buf_prepare(struct vb2_buffer *vb)
 static void vpu_vb2_buf_finish(struct vb2_buffer *vb)
 {
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
 	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_queue *q = vb->vb2_queue;
 
+	inst->current_average_qp = vpu_buf->average_qp;
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


