Return-Path: <linux-kernel+bounces-49342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C68468F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763701F25A05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AB17C6C;
	Fri,  2 Feb 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="ZEFo14+Q"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2095.outbound.protection.outlook.com [40.107.128.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9D17984;
	Fri,  2 Feb 2024 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857463; cv=fail; b=WBtvf2s2J8NYDjSnMibMq7TDZm+av02qrwnwjN/kUQQpXmr6ot7Wb2SVsbkODr1TmEJHO2kvrwCe+8OnXELLBKe1mXXBcG9gpUl7Wnw+ATqMC6Dven4kZmaWRlVmyO9kQfRI2OSN4UK/nZ0m1WX5kgrRrezemq+mdZdtQEI6koY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857463; c=relaxed/simple;
	bh=X0yfwrshsp8er0k1tHV5dMdkLO32f9I0607hnZSGlLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcaz6VVb0oe8LtRHKNd387UvvOQ9qZl+BchkhjCTl3iDine2yB8EzluucL6xayiIW//PvB7QiiX7LcZjjEswMlMDvdaTA7xrWj2Pv+BPVsnFjvL8+mvWp2OxPegbZEg7623oHn2OoAsRFuyU0V1w3SLbHe78pLkvxeCw3lzt4v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=ZEFo14+Q; arc=fail smtp.client-ip=40.107.128.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwIY7ByWz8XToe2eWtJjMTfjrFnA0v2RjqKFGygsYoPfAvCgH//Qjs6+8OvNnFQEZ8It9FdbFHgCAMP6Z8n59O78Nt6qbM0mAYH9ILCw2+kKEGvY7AERlXxwwzvb6KOtqW2ZHm3B8p3KM0RO8HokblfqENaCSdTRbhwnGUAfTRUwaFSzhK4tawmNtsiNMamwesEQUEEP8PG2W+JRQvJoZOiBqvjzcbFxAogSvRCIuYnehrJbq2tKuQBxUmyn8EXpxba2Bc9ODqD7DaKGdUU+12Tux8inNPZ7dvhkGvI1zDFb4p7v15l6TKgHeAbz/7HxtdfFXnAc535aOHAb5jlj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8utOFXxbLDEr2TD58UTmf2jV6OeoYkStHv59ULoeMxs=;
 b=ageIZhaAp9W42WOMuvQn6hN2euI0aFHbjwOIA4CwMgDmhmMn6nFVKai92u0Qrh4NX8BZzEpK8mDHHJ+N+7X7xgQ11m0NsmcxtaGV1+pxoeCLjMESl72WtLj2c4KvHiHGuqLWd+8sMOPCjHr9x9KaOGwkirko2VpDJ0pkSEfZTor71zg3ajnznZ9xX9r/773r2dWJxKWH+V99yX5qyxVUR8THLrETeSDw2jbQQo8Y5fyTUyrrE7HnAMLZmm9ag1rLDsOOFvnYub/h9vG9/Gwe9hY+3g0IhGZFODtEhot2k0w8Wv9DHNRrGbpXQLc40zl/nzLe2mL8xpN681IbK9f0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8utOFXxbLDEr2TD58UTmf2jV6OeoYkStHv59ULoeMxs=;
 b=ZEFo14+Q7EMOczCHnq/gBvbQ2a36TeorWpTkV6dRZH6tY7sLPSeiglbDwwFxZP9tTmv8YTcUxAvX8Ca1HlXD/1Pti3CRP9kcjQDfcuMguZPkv3xJspSCaVvWDXrT01pVfDAiwbVAC8rmXmTKBkJ7llRyexE7ui2tcNQ1bn/CKHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE2P216MB1425.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.26; Fri, 2 Feb 2024 07:04:15 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 07:04:15 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com
Subject: [PATCH v1 2/5] wave5: Support to prepend sps/pps to IDR frame.
Date: Fri,  2 Feb 2024 16:03:49 +0900
Message-Id: <20240202070352.14307-3-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
References: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0112.KORP216.PROD.OUTLOOK.COM (2603:1096:101::9)
 To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|SE2P216MB1425:EE_
X-MS-Office365-Filtering-Correlation-Id: b684db14-bf8a-4ff8-2d7d-08dc23bd2a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z9iFqT+QUBPdDXqYJi73bLopT5JFfJu1E7kK9OxIIFw8onOWMpyOcAXjb9jLco2RAz2InqEBbVw91tZrqWtQqvTTDlykY9nISDguCIXfg4C35z2lAHK5OMyWVQDHpPKAPuCx/x9u3hVi0/pF+rOGDCb0Znwdjda3qZIJ5PqkWKgksd6aHYkQnG2PzupTv9rAUMsPIeCaRbAqVtDoVUve3A0vxKqJo6H08+Yg+P4Xu42aEa+7uQqQ/bum9ElONragkayhuECHC41NGzEIWcV2qKBNuyRqPPQDeE21eRuE/rkTeA6vzGdrCKjBJjldD+z0cNhF2wf47aXSppK3SFtWO884N7e54FNgFJ1gnAchdd19Kgi+HY8Qo82NIv0DCn1lTKXPt5cZiyxy9mrCVQ1HVIgyFv0vV/3sVt1mWM/SSVHcO39bp+6buuGBSMBZco06c+zl50VrO89N+jD2LZVQzhnzOL7/ZAIx1i6zcIBW1uyKfKckGHtqA7uf7MNLJioo2z9dRjnbNrb0Xwp1ozoyr8LNf4x/2OY8GG6tz8sQK3PwYzh4P8iion7ixnSpRsk7hLdhc8nJ/19eH2xGK1ujXbEfD4dZDW7nG1Z/i5OvHyedU79ZBttxDQyhXSMfjruY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66476007)(41300700001)(66946007)(8936002)(8676002)(4326008)(5660300002)(2906002)(86362001)(6916009)(478600001)(38350700005)(36756003)(316002)(66556008)(6512007)(6506007)(52116002)(38100700002)(83380400001)(6486002)(6666004)(2616005)(107886003)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uqd9SLV4/ZhgsMKr2vyD/0BCyjDLlu4T+MvotsYTofibK+qtqlVkAOHyWBZm?=
 =?us-ascii?Q?zkQNsG35GsUfKcXZEjTYpAFdRRXN2m5Sp9RnYaOVPtQZqHdObJI+UCtsL5VR?=
 =?us-ascii?Q?uX0atl83AzQCSAtnY82xkgxWEbJugM76dewLvoYzcnruQ6CdA8zIf5BkkIV1?=
 =?us-ascii?Q?B+AmeiAC4SNiNhCpzaU0yyjMtCCBy4QhV2oAZr1pb0RmiGHQdHv2IldRS+m2?=
 =?us-ascii?Q?htYPKx/A+33JF9Wlfi6IcA6RNZ8Q3EIH7fWRZrM7m5EmGi2O7OcuSERnrR4z?=
 =?us-ascii?Q?XUmdTykeJ7kg2ComHjzvjCiT1Phqwxv4zZ+qrkShbF494LOJ4W0TPUcbMZKI?=
 =?us-ascii?Q?3pv6mUbboPuZBgvqodof+lKLtQfIedt5yW4ou8zp5ah1Zgpf7EeHwZSwzFTZ?=
 =?us-ascii?Q?H6YpmGXFodXwHYDr/ZnQxN0/1XjWm454udxV/W1/AjNx5B1588Sev27GUzuu?=
 =?us-ascii?Q?UvX3J4jHFrDyn9kpgG8QrOng29D1ZBs853QZOaBU56FkX0ivLgBl43YpkOtC?=
 =?us-ascii?Q?4caq5yuih5l0jH9QXo8HZuIeiTMAOZgHOk0FQw92rOwVnETJhzeM1HqWb+cU?=
 =?us-ascii?Q?Tm59S3KMWw/JGGQoGEUNFiAj0engWgdGd7kXk3cNzFl4s66YM/u1MB8Rgnjp?=
 =?us-ascii?Q?WkK0FjZ/KykowJHV/Gb0FuWzMEAwKS7mVK3JDG1JlFDFqJpz10B+9r+B08zh?=
 =?us-ascii?Q?0qhk8u3yLCnZP/PtGBi4zHzMILS5JKmp4tsIWHFHAxzvGxA6xaJswMP99LCU?=
 =?us-ascii?Q?vAih20/OCHnUHJvpt69eJtJ/4nhwaDlWl3YcbLGjP/oRJBTRUWKxVq7GQ1bj?=
 =?us-ascii?Q?buU3HFGvpaG1FI+vz96Q+3ASgQgk7ldfvQpSX7TIelrWeMcdr9TVN9g9ErBo?=
 =?us-ascii?Q?RY7lJkb1rzIQLdWude5WnJIZdIk3aSRs4sODJN3lvzskfqfJngRFZ2KhbjvC?=
 =?us-ascii?Q?FG5CD79m8bfUoOEss4SI0K+0JKsZIpWKX/LWOKiNWvPI57fKqObeTYLpWty4?=
 =?us-ascii?Q?iaHzscQYg/5sckgpoSiV4f/e77qEKxA0Ra86pzmK1K3Af+jJzD73V4vxEim9?=
 =?us-ascii?Q?C0iWTNarQ0V3jHxX+/M6YcZQ09fbz58STqKhSE0kr/S+mBlxgL2HkTE4wPBy?=
 =?us-ascii?Q?x5bizJeOvoworqmRln48Vp1jVFKiqMyCNEK+TkW/fbjjDUJGajUAdaXMIIpi?=
 =?us-ascii?Q?ECp86IiaJvXfwtUCK6msaXoKAnrPedRa8sHoP6j6QPstzV1GTTcbeBMOFWOU?=
 =?us-ascii?Q?+NjLv/e8++hlphPCkh2AVlTdWrXWdr/zdtexXpuLaYTNo/ysDPWxqcAzx5Rg?=
 =?us-ascii?Q?R7bpZ4RgzMkQDSfjODM9MH1K9+nMl9SQA5ER0ySWIABD4rVSXSR+ppiLxyrw?=
 =?us-ascii?Q?kmg1lgTzazS+KvNcE6VxAnQAmxnCMyeIlHIRaOdQapp8plVJLEvnTmblYyTh?=
 =?us-ascii?Q?3otvAikCnHGWbjyJxWoMp4bGhRVLuCgHVVQVbuXXmKQhV7KW+h2Fgm2tILp5?=
 =?us-ascii?Q?IvEy7nlMkcuo3xKqPGwfFYm47Se4hs38mXV3DOhRnPAxR3Cnawkcu2jYHhpM?=
 =?us-ascii?Q?ze/Au1IARZsS/3mU7X75UzVrIGcfXZF63n9YCkyg89d7GYowef48L98HCfSI?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b684db14-bf8a-4ff8-2d7d-08dc23bd2a8e
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 07:04:15.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaVVwZzRphel5FC8jeP0I7vn9elF4ADaN56Rw+ZKTLUyUP2Io+ORxXuvecqysfYCYZ72ri0g1OWK4UdjSk/aa8/KNHFH8ONnwIZ0/+9VLfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1425

Indicates whether to generate SPS and PPS at every IDR. Setting it to 0 disables generating SPS and PPS at every IDR.
Setting it to one enables generating SPS and PPS at every IDR.

Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 drivers/media/platform/chips-media/wave5/wave5-hw.c      | 6 ++++--
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 7 +++++++
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h  | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index f1e022fb148e..8ad7f3a28ae1 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -1602,11 +1602,13 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
 	if (inst->std == W_AVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp |
 				((p_param->intra_period & 0x7ff) << 6) |
-				((p_param->avc_idr_period & 0x7ff) << 17));
+				((p_param->avc_idr_period & 0x7ff) << 17) |
+				(p_param->forced_idr_header_enable << 28));
 	else if (inst->std == W_HEVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
 			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
-				(p_param->intra_period << 16));
+			      (p_param->forced_idr_header_enable << 9) |
+			      (p_param->intra_period << 16));
 
 	reg_val = (p_param->rdo_skip << 2) |
 		(p_param->lambda_scaling_enable << 3) |
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 0cb5bfb67258..761775216cd4 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1125,6 +1125,9 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE:
 		inst->enc_param.entropy_coding_mode = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
+		inst->enc_param.forced_idr_header_enable = ctrl->val;
+		break;
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		break;
 	default:
@@ -1292,6 +1295,7 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 		else
 			open_param->wave_param.intra_refresh_arg = num_ctu_row;
 	}
+	open_param->wave_param.forced_idr_header_enable = input.forced_idr_header_enable;
 }
 
 static int initialize_sequence(struct vpu_instance *inst)
@@ -1775,6 +1779,9 @@ static int wave5_vpu_open_enc(struct file *filp)
 			  0, 1, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 1);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR,
+			  0, 1, 1, 0);
 
 	if (v4l2_ctrl_hdl->error) {
 		ret = -ENODEV;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 352f6e904e50..3ad6118550ac 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -566,6 +566,7 @@ struct enc_wave_param {
 	u32 lambda_scaling_enable: 1; /* enable lambda scaling using custom GOP */
 	u32 transform8x8_enable: 1; /* enable 8x8 intra prediction and 8x8 transform */
 	u32 mb_level_rc_enable: 1; /* enable MB-level rate control */
+	u32 forced_idr_header_enable: 1; /* enable header encoding before IDR frame */
 };
 
 struct enc_open_param {
-- 
2.43.0


