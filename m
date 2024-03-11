Return-Path: <linux-kernel+bounces-98451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33981877A50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83837B210CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A573232;
	Mon, 11 Mar 2024 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="fp1xuzKV"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022019.outbound.protection.outlook.com [52.101.154.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332561841
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131100; cv=fail; b=JXD9efUbzgjlWQND62a3ttAZlg2KFRASe1s13zhJQa50CF8L8ydkIvdH951j3MnRdq/qPHTPCz+r3tG61oaoAEo+1yfTAjjQRrSf6JChoSQrBnyUb3J1aNL+JRSaquAQAj4HCYhEWWMI371eRaFL7cADY4qxRoOU5QQw5+0zGTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131100; c=relaxed/simple;
	bh=l2wUCmHDK8MzOelGsKM+UYRm9Vter11l6pl5SdW3fx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5PcS4d4dspd+UBWIQqcWBs0CND1zye0Gsdygnl9VVYU4nkqSNpPaE7+RltZkdtq6i7No0atsbzZ2dxvdkr0gjDOLq/gs0mokrPX9Gc6QnPhlbbFeDdbJWkXz1HNJgRUbICQxxDmkIgjwNXXxUse/I0IHgh6fHqNgJvxAjTjJC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=fp1xuzKV; arc=fail smtp.client-ip=52.101.154.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMG31LGGsM3/fXo/0Om/RzZHKeLEbUuO8b8z4gx9RaueITdaFoYGha/CiZF7SP5zuT8mV3twwv4ANslR27KUfjOiMDc1pj/MpxbTKdf68gJYFOqEJFVLNnWfP+rZHs1PVz4QMf5rVXEbFCA2tGLP0jQc2VnFSx5dqVEJCYfQfj6GRXP4DsTds7CGfSAWw34Hf+fXobJw71yuEQLqhBr3cdsP9UFurMg+MZu3DcekEMeLirs6zyBV12wsPEZHn4krZoHBKK56KZkz6dYXzz9GIkHpvKiXxXnwwg06R/hx7aFeEkRXuc9cK1gYYon8GN218hwhhlUlsXt75AS7l9Ixsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLpqCFd9QlagKVmdqGgrlC5upXeqJ3Sr5cHld6DJd6E=;
 b=RLibPV70RUkWwa2+wtRsTRJDFEzmqRlQfGUx9tCySkmcJDAAx9AW11QltyxzQnEq/Y1QqF/n0xhmVXRdWx/08/kOPT5p5p5WDR5lctSAINt2qQd4Ec/SvxwPJesWkowztQijhlmzRitCg6xKlNd/E42lxBkbwMYaxo8GlJJdwlLaKJRPtmT6teYjBB0NOsKSitFrbdtnTnC6qqOYoZz0tABzb5USP1qAwe7ymUocy+JOikklEDUWghs8ASFEqBsGAiHFAingqbIhRU22wscFFGaEaziP13FXLG9kRHX6gl6KPRMSKq/tH8pWdw/2dyPklw0Gl13AS1jPdof7vijn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLpqCFd9QlagKVmdqGgrlC5upXeqJ3Sr5cHld6DJd6E=;
 b=fp1xuzKVNS51ae1a5TSYmWdhxOQneV0JfHvLECRBzRz5ljU26kHyGn96FkbbMt0pIcTeOEq5G57sSQV9x/VXUxusq0zOPlQI66sQGgJK07PGKK2hwMWyEP+2bhINBal/LVeHEVV7j23B5ZGwC0jtfzHnBrgvlpjQY8SJZSh6PA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB1997.KORP216.PROD.OUTLOOK.COM (2603:1096:301:12f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 04:24:54 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 04:24:54 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [PATCH v2 1/4] media: chips-media: wave5: Support SPS/PPS generation for each IDR
Date: Mon, 11 Mar 2024 13:24:39 +0900
Message-Id: <20240311042442.10755-2-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>
References: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:100:55::29) To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|PU4P216MB1997:EE_
X-MS-Office365-Filtering-Correlation-Id: ae762367-2e63-4b6b-ce80-08dc41833367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m3SBtMQgQXGfgyYP4oMfSgoFHyyGEUQB8Ch+RKJ+fo4YbCTrMLeZ/tB6nrOkS5WCePIMCkkWbPPe+NTmOa+7Ffx6UQOXJB2J57eqCbg2Jnh1QpN8bX/8kwF1DBgatuoLCoB+TViCCu+6zxRbEO3t5b5cKx4OisbPnaKmnOc/zSShh0O7q1mwEygnXNs8Ef9HeDuDYh9UoNNf001kkrSimgi21HW0LQaFREYAD8qUqm97mSaFXii1hwjaPuWrcedEa5kC0pF/nWQqorpffV6WgopZXV9whHosVpNdbst6c9qvo6n8QL3ZJKLH9s8AsR0ZYoPTEyIYmT02iK2K0EE/9WV1O7mpPJ+aolBF7Znzdlb/c4oi1UPSwN941RiBKZrlMXag7Bx6dKyMMuRvYSF+3vLL87v8mudTmqU6d8siBYpaeh+vMy/37BxJhCbPbHOhmgG/1s8xdLyNwQfx5deyxV7yI42zNUf0ELu+3i3nJuv8l2Oue8SUhExHPAkFXXbaBZl8JuYA0CTV/p0VfOx3l9vd74r3jgiCb8+O+Qwd6Z+0QlQXgjI4HZfKYWEQ4RWHlpQRZVgYG797KGH6xr4yO6JZYSdz7ooHhRj0kxPS3xsN/+/gDiFrZuWtq0M3OKpFHrQA0L28VgPIn9FN0wZ+Aw7upjgt0IRkYZcetCqQ55PxOhgQqPXNzPc4CUO+jOUzeM5e41jbvPqlwrYv1oSIw70+v8+QKI7izxjdyes0QmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxaZoS0eo7ywJZgb6LCM0MYtLKLkSGJkAvNH7IVv3UmOq3Nui5oj00WCGOqr?=
 =?us-ascii?Q?egXpHJ66iIrv0HHe2rurypRhCeSF9UaR6iDigTO6gAgjZvnPawxG5SJo+U3w?=
 =?us-ascii?Q?b8KreJCRo4a/3Xc/De95EUAohMIIiDytIR/vV4a0mKQMd2J7Qn2XWGX0VvKL?=
 =?us-ascii?Q?nzpP+G0D02ZP7zf2gABbdb5ZB2fZapSUGrfrA0fdsyi/t4CDw1ezh63fxMDQ?=
 =?us-ascii?Q?WuJ3PP4YLYdO7KBLf+SgmRRqkf6FoY3b1pRcwOZ5tjUldkwPqLUOPLgkpgUr?=
 =?us-ascii?Q?9GpUf+G5IV7wsny9IaFnSZfOGC8MXFt0+YAGfQuKefg/XE+tQ1XPCqSfcAm1?=
 =?us-ascii?Q?0wPmNriLNw2izHHKbWvHVOW48gF9W2laYcqbuTH3zYfRDo+pqrh9nUaGY8JS?=
 =?us-ascii?Q?5HWFb/89ElEIrtY/ncBv2GBrJxFHbTiBDlWhW4abv7/RBvhu0E2gDByqIJIK?=
 =?us-ascii?Q?3VgpLErnInta4VnEa+2SHhshx2t22Qh8Cs9dgGOYuVNmB/BwFe0GXMqO/tmp?=
 =?us-ascii?Q?tGwabNoL4hgW3ESqJVlll8xcE9dTrHJ5DKcQn7GVGEGzKsv/1iXHYaQfq+VY?=
 =?us-ascii?Q?mkkzjYm1yHr/snETOmbjlKzRTV/BqqSxH7DWGCdIQYqqgEoBGlJ5yL9kZbK+?=
 =?us-ascii?Q?HLbADAdZ6cWlxl2CTtDjCS7owLZo72Wv6romTayfHhFVdN6aj+qv1Rz3T923?=
 =?us-ascii?Q?Nc9RZ5+j5N9ugZC7ES1zZ7BuayEBnR0OPD5sb2WtIpvY9C68JBXv91qHDaG5?=
 =?us-ascii?Q?o7z99L6y6fszjVXqSFPF74b3yqefGIT/lrXZM8wC9sd0s5uJzDOdL+JlNqGT?=
 =?us-ascii?Q?zDqDQ2ywSpM33Ity1I/PX6uMxq3VZgg18qPDSnEr1MQsFEbAzm5F9tY1e1Vq?=
 =?us-ascii?Q?wTsS11U0EW3DZo73IfkRwVvDNNwEaeBKTYSC1PXa+hQPd8pppNPL/6mA9Gsn?=
 =?us-ascii?Q?PgqU9Vb34TVcyONaBDp1qvWG6TjDvr/KqOGJnqvv3Cf9n1Km6HNaeJyWOBcb?=
 =?us-ascii?Q?8Z2Wh+WV40yppF02Hv6+J9mepZz1TJIgDu42XtYgRADw4+RzKl16Kjh+2tdF?=
 =?us-ascii?Q?DU2W1yJG0xk9XTAv7+st8lkrBd6FRasRdfZp32Qx6ln38EDnpxVUIUe2S5Ly?=
 =?us-ascii?Q?TEvMs3TzCXf0Ag6JCau7ui4kIBnOzC7grvJGoK3Gz7j+p8pkc0JRFGJt1qIe?=
 =?us-ascii?Q?d5h8hYT9NFQ/YFbbwUGGbf2NvlKft7i6B+NktQ8yjT7p5QUrjonNXkP9caD5?=
 =?us-ascii?Q?p0KyxlfSPQFYX9r9VW75i8IR3qKzAFqlLKNPDteuctgJW7A9R8Xb2imO6cMZ?=
 =?us-ascii?Q?EKjndDBss8a7UcLsSV3iEbcJQ8Cm+sH+Mzq6hv8uDn09rF+ZoGvqIMu/EC6P?=
 =?us-ascii?Q?xnv3a1vlFj+5Ydg9s3ily4IpZQ+8griUIn7w0u4+NflE2Q4SpkvHnWL2ENNB?=
 =?us-ascii?Q?3wdckV+oDrdkvhqKMkFgVLOiOEr68ZxQF6MsLPCB96V2ku6TJsHVlp/wSrfr?=
 =?us-ascii?Q?vI7Bg7IZsJC5KtmxhfnOnptERzl0SNBMNLDhjvrQW6HntruTolyBSk8W+txc?=
 =?us-ascii?Q?Apwel2dPvOeiQaPETaAjLce1TXqyDkwjWxVMbHjTJBLigPX0kijxMYQZg9mS?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae762367-2e63-4b6b-ce80-08dc41833367
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 04:24:53.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UITrS74QEQ6q6IkvMAp/dAojFo/5kp4+9N68Esv+nNjs5HPKHVjMBAECaBFwvzOgV5soMFFLkoL3Glu8ltv3VAGCmXooVoNIDZd2BgXqyqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1997

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

Provide a control to toggle (0 = off / 1 = on), whether the SPS and
PPS are generated for every IDR.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     | 19 +++++++++++++++----
 .../chips-media/wave5/wave5-vpu-enc.c         |  7 +++++++
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index f1e022fb148e..4a262822bf17 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -23,6 +23,15 @@
 #define FEATURE_AVC_ENCODER		BIT(1)
 #define FEATURE_HEVC_ENCODER		BIT(0)
 
+#define ENC_AVC_INTRA_IDR_PARAM_MASK	0x7ff
+#define ENC_AVC_INTRA_PERIOD		6
+#define ENC_AVC_IDR_PERIOD		17
+#define ENC_AVC_FORCED_IDR_HEADER	28
+
+#define ENC_HEVC_INTRA_QP		3
+#define ENC_HEVC_FORCED_IDR_HEADER	9
+#define ENC_HEVC_INTRA_PERIOD		16
+
 /* Decoder support fields */
 #define FEATURE_AVC_DECODER		BIT(3)
 #define FEATURE_HEVC_DECODER		BIT(2)
@@ -1601,12 +1610,14 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
 
 	if (inst->std == W_AVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp |
-				((p_param->intra_period & 0x7ff) << 6) |
-				((p_param->avc_idr_period & 0x7ff) << 17));
+				((p_param->intra_period & ENC_AVC_INTRA_IDR_PARAM_MASK) << ENC_AVC_INTRA_PERIOD) |
+				((p_param->avc_idr_period & ENC_AVC_INTRA_IDR_PARAM_MASK) << ENC_AVC_IDR_PERIOD) |
+				(p_param->forced_idr_header_enable << ENC_AVC_FORCED_IDR_HEADER));
 	else if (inst->std == W_HEVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
-			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
-				(p_param->intra_period << 16));
+			      p_param->decoding_refresh_type | (p_param->intra_qp << ENC_HEVC_INTRA_QP) |
+			      (p_param->forced_idr_header_enable << ENC_HEVC_FORCED_IDR_HEADER) |
+			      (p_param->intra_period << ENC_HEVC_INTRA_PERIOD));
 
 	reg_val = (p_param->rdo_skip << 2) |
 		(p_param->lambda_scaling_enable << 3) |
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f29cfa3af94a..f04baa93a9b7 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1061,6 +1061,9 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE:
 		inst->enc_param.entropy_coding_mode = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
+		inst->enc_param.forced_idr_header_enable = ctrl->val;
+		break;
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		break;
 	default:
@@ -1219,6 +1222,7 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 		else
 			open_param->wave_param.intra_refresh_arg = num_ctu_row;
 	}
+	open_param->wave_param.forced_idr_header_enable = input.forced_idr_header_enable;
 }
 
 static int initialize_sequence(struct vpu_instance *inst)
@@ -1702,6 +1706,9 @@ static int wave5_vpu_open_enc(struct file *filp)
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


