Return-Path: <linux-kernel+bounces-98454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506FA877A53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9D7B2141A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8AC2E6;
	Mon, 11 Mar 2024 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="C4T3I/Qt"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022019.outbound.protection.outlook.com [52.101.154.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306718495
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131106; cv=fail; b=rNKE05RiO2jUzKhcpxO+1TJJu7swlpPPE35GgXixxM6i0f9J3LQcWP0cHjCJrV5YzlHBhXcTWphPEETRPo0cp0vPxb6HklwNJXGFe3qcPdQ0HAnEIfTAxBObr1UnK9iaZ1IbfhgsLh5qM8DhmP/dGHGyHMaGPbPaAaXGHfvG1ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131106; c=relaxed/simple;
	bh=yxNFp988MN/rGSkeStJyaW4sORGym2mKJNvRu9JwxrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=enxAL3Pqw91oGK8CIlpXlWBL0Q18b03AMWLTUpYuNParK6Hf5PMLOzKmGoydpE72YawidKCaGZi3iaGdueKc5tNJDB/wI3jxivN2rEiy0rIo0R2jCw3Y4SEh7hSIdsHna+kzZMCpl/tepBIYGLBnBZseSSUj6hb95tbcRrYG5Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=C4T3I/Qt; arc=fail smtp.client-ip=52.101.154.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBLlEC09kSC4OoRmtP3+6tP9V8VWlB5+kREhkEMjfN6jreImOaRhbtdVx2+z/AjG01bSXGRCBK4qvniznRWfdloM7tD8a+UoqIgL1vrKhAqscET7aZ1ID00Le/pqU8GbgntHZe15/lVfFzYu84pqE1rBNomeEJDfx7O1s+35CG15G7n3qKVBENfokbOft0OH5ph7OsP6eNsWXTwwW6ue+Yud2W1u/i3a4OeVkifjI18Y2C5pjVD28p/PIBDYuCLWBdJwCMe8B5LYIwnMMjGoVgJ4R3TLP8qsacxlucs3M1agDBcU3dxGWAnlc/BP6LqcN9KpcbVTOp0KEjofeTSfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AOc2QOAt3qo30Tc77Pm7XC3tlB9nOy+F4lkE4s5kPw=;
 b=Ew45FeTzYm10eR2xKQHpmiZlf5GTLUiiedX2ivXVCdHhFYCiFlZci9t1ZP+R15R1lF6KnOfl0ViQvR1HwwHXgfJlNxS7Cn4jxbidE012r/yHTtcaoZEBjmhWj/vh4ZRi6laq6HIDTA2XfPFRByYApBmyX2wZaG4tshHajWSWvHMbT09AHrZRCOssNfGb3VvT95+/juVyMFzsYAwBO2PufrizOBSbKWSad6q7EvxitU/R2v9YeZBaVv9xQSAA9B2Pj1TE+ALygiwKEovrdUmA6Y4bCQGc4nmXuhI6UXz8J1+eMm266LSb8/XwdiaVIgALcE1GWbl6yHPEW7gWEFMhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AOc2QOAt3qo30Tc77Pm7XC3tlB9nOy+F4lkE4s5kPw=;
 b=C4T3I/Qts5EP+0avweJ+xw/x6rsjJ5bl7xxjr/myucABWqSqfxUtL9BsNWVd8Sxcx5bE+NlyThhW62Y/2zsnGU9FU9nh7IQ8fswBC3m03V5N80MMyLBscuYaibCAhtM+/iNXqlXlD9GiHd1sg0AwUhoh3nzc9kfyv6298KR9Wpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB1997.KORP216.PROD.OUTLOOK.COM (2603:1096:301:12f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 04:24:55 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 04:24:55 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [PATCH v2 4/4] media: chips-media: wave5: Support YUV422 raw pixel-formats on the encoder.
Date: Mon, 11 Mar 2024 13:24:42 +0900
Message-Id: <20240311042442.10755-5-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0fe701f-09f0-4bf2-a7a7-08dc418333ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PhfvGqMAcl4VLHSj9i/AeoUHIC3K1byAnBQ1xm7VXoz4eTdhkAKTX6Hj3exH+BwF8IDcjXP8u05/jp9OyGwiCgNHd2eaIeCJhzupPXDCjQsHSOBPrYy+b46HbJtjn+cV14N4SvUiYma8y2KCiItYgEK17II34TCqg/Lac/tR5GGh2Ltlo/sENMDzy33HQd64Vn8FD9nQC9JJNtUrF9TQd37h/Q0blcCWCtrpnyyF9Y+Se617fAjKxNDaAgYS+7yPvmns3XWj4wp0nu6h3Bs55txb2tXbw8UkaBsjLeNsyIRkDXZb/ciHZYswDo4WigjXfb6mFEVMkxTfr6S8Ki9WG1GCKvyZMl1s3+ySWVpppWIhgLG2hF6bgfp42fjoKb6iQAaGsOzScs3ViJBUhnQRkndNOPHFJnzRuX1f0krrucdfqja+aljBEkRr59ii2hAw+rAqqThdKUpLEiyF8bpuGrJVlipMQGE3Z3j0NCyU476lOEl0v1vVq4gxTYjrjlr7ux2U4VIw+7zt64DGuY0qzXCU/H0y7sokE4ew+IDODOMiCb6pmm+8lCMB15M12icFDCzkz7ZqXllDCj4ZSnKKQzxhQ+YkaodVLB4ms1VyAF9tOB9rW4rN/xWC+hl8lFYE0rLqpYlgCme3ci3QIPoty6m3XrBZANELATTKLX2KfJp6owWmQ81uuhLhfFPQziQl602hfXZaGzJgsDmIcYjEULuc/UnVK/9khgLoO/bUX4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?69MZxIZpubihS06YUJ+KSh+ULbFSDGmY/T+ZGtVsTCVGBN8kyo87bTSGyfxP?=
 =?us-ascii?Q?musKBfbc9q3xDIHkLvceugLnmOemu0TN01priBwDYF8Brtp3F6q0ZxBPIQGo?=
 =?us-ascii?Q?EcGi8rnLfXJg7PO2bLQpkbup6v0xzsiyKWU/fTdT/0phg8ymRVk7fLx4KVUx?=
 =?us-ascii?Q?bo8ipEplcHohFo/fUhouE7RqZrdKjvt/V/vU5j6anKR7hwhALZ1vZwVvUcw6?=
 =?us-ascii?Q?Y2mAEqG40Nr965Bh8FrAbFxyLX4x8Yj4lyAMiTcBSZQK87atEyoOlGy31ayN?=
 =?us-ascii?Q?+n/i8i4RzjnH+aFwHlDapo1cnY9p/5NiQxTlrfFO/JsX3CbBsSYvzEVYEW9K?=
 =?us-ascii?Q?QkG96upadT/ZpSeHHrShnfw4cll0GCWm3HJwkr+/P32Pld26XcQ4i7laEDWG?=
 =?us-ascii?Q?MAwBaqALkNEtRLFDdRFpK5RRCNNMlODDR7NfwuO+rxPYxgSopYGknf/IH7lQ?=
 =?us-ascii?Q?inzZXuMuR8s5N/gbL1FnS7FS/XQQa52CYMFB9wRnDDmdRtDGatv+1cNlqGRP?=
 =?us-ascii?Q?xvFFudNeJdlWb6srZF9h1MGjhSUKa/mZQ7k3PL+ARgvq22uDX5T5eIKC9VjM?=
 =?us-ascii?Q?j9LU1oQyBsCOjGOO288CIBrBFSkn/icnT2e65Jfm3JVnMo5TuGebFqbYzCV+?=
 =?us-ascii?Q?BZ532ihfEuovNq/kBwYCBA9LUSy2CRDP48CDFqU4fsRYEXr1ytNgw+G+u6x3?=
 =?us-ascii?Q?jKgX4iLOeJwXhcxEPTiH4Lcc5/ClLSA6CYQ/ViTdyD/xSI+9a14anM7fHhkC?=
 =?us-ascii?Q?eWEOcwBqMOm+jwAanXRSqLxMM11P4fSJpJriXEjNQQ+sVx6effRD+1Ky6D1S?=
 =?us-ascii?Q?ICDV1vE3JWDBIxrHcT3FGD9t5azD2shkBeK7jA2GcfQOTB7AUsyKg2ACkvy6?=
 =?us-ascii?Q?h1HfDhz7P832l/5O6ie8bBzSHirZP+WVP2CdC986CkEui6YjJwRnTQ2/Bqdt?=
 =?us-ascii?Q?G22BEVJCv4tbpqO7jF2nWqPSBO7nPuAHjrb0jCiD7S0p6MamLsaJdfA6tjwF?=
 =?us-ascii?Q?8blfJCGCocPuxSD6MrhxfAcn92Rk6pHJLUSadgoYsflXVVNzBbgdngVwb03Z?=
 =?us-ascii?Q?R+YcNEdIX158+hvpEeN6EaUrDf8iTqGbdexzzKp+vFJbL+DH49lSt5/Druds?=
 =?us-ascii?Q?ALwbuW/qewrIKRmjCDV51S3nNJa359x0jfc1wT+VQr8DU7FiJfSnk2Bu628U?=
 =?us-ascii?Q?8rHb4KDgRSNd57btb9o0iHh0vw+7FF+PvPzYyaV9sDb8Kp1nLdVbqK+bl7Zq?=
 =?us-ascii?Q?T+cuhSaNeu807U4pj9JS7sqiz0sJQW4hcTYNP0tPUHT2RchLVH+JSmHwvAIf?=
 =?us-ascii?Q?DwRpfIoc/ZH+XVeBIptuVRtOZQ1w9NIcexzDU7h3iZ5WC+tlH5IlvqokTpRS?=
 =?us-ascii?Q?obajB/Mr0beym6hpO2PXoI7q4yR/wbwAxeM+vHwgxD9ym4mQtWYIZ5pnWcoO?=
 =?us-ascii?Q?ZqdHTXiALiy+UNkRgEX8dHj7oIP1EuGO7C7I8D0gCwbWFby/PdhlFVr9aS1H?=
 =?us-ascii?Q?BHyA1/jm7sgyy7/q8u+wYDHp1hjYFVVP0P3eu3rzsh4IOoutCDWjZc65zQn+?=
 =?us-ascii?Q?RAJgJpcz1zvPW0L7hql1SchBhyZw9MSfRkTrg/NUlw+4/exkemCI2ewh7rnh?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fe701f-09f0-4bf2-a7a7-08dc418333ea
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 04:24:54.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //HmS8UV+VBy+wRIrpjhzv7RzpDbFx+vFQoe0r6mIwF2ZmzLaPewAu671OlpU/uvJ6+68ImoQQeD4G4XLMu5dJnavQMoiZJylepY7fSddak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1997

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

Add support for the YUV422P, NV16, NV61, YUV422M, NV16M, NV61M raw pixel-formats to the Wave5 encoder.
All these formats have a chroma subsampling ratio of 4:2:2 and therefore require a new image size calculation as the driver previously only handled a ratio of 4:2:0.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-enc.c         | 59 +++++++++++++++++--
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 5a32bb138158..77657f63a169 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -39,6 +39,24 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
 		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422P,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422M,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16M,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61M,
+		},
 	}
 };
 
@@ -101,13 +119,30 @@ static int start_encode(struct vpu_instance *inst, u32 *fail_res)
 	struct vb2_v4l2_buffer *dst_buf;
 	struct frame_buffer frame_buf;
 	struct enc_param pic_param;
-	u32 stride = ALIGN(inst->dst_fmt.width, 32);
-	u32 luma_size = (stride * inst->dst_fmt.height);
-	u32 chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
+	u32 stride = inst->src_fmt.plane_fmt[0].bytesperline;
+	u32 luma_size = (stride * inst->src_fmt.height);
+	u32 chroma_size = 0;
 
 	memset(&pic_param, 0, sizeof(struct enc_param));
 	memset(&frame_buf, 0, sizeof(struct frame_buffer));
 
+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420M)
+		chroma_size = luma_size / 4;
+	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12 ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21 ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M)
+		chroma_size = luma_size / 2;
+	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422M)
+		chroma_size = luma_size / 2;
+	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16M ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61M)
+		chroma_size = luma_size;
+
 	dst_buf = v4l2_m2m_next_dst_buf(m2m_ctx);
 	if (!dst_buf) {
 		dev_dbg(inst->dev->dev, "%s: No destination buffer found\n", __func__);
@@ -490,11 +525,15 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
 	}
 
 	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12 ||
-	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M) {
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16M) {
 		inst->cbcr_interleave = true;
 		inst->nv21 = false;
 	} else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21 ||
-		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M) {
+		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M ||
+		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
+		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61M) {
 		inst->cbcr_interleave = true;
 		inst->nv21 = true;
 	} else {
@@ -1086,6 +1125,16 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 	u32 num_ctu_row = ALIGN(inst->dst_fmt.height, 64) / 64;
 	u32 num_mb_row = ALIGN(inst->dst_fmt.height, 16) / 16;
 
+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422M ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16M ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61M)
+		open_param->src_format = FORMAT_422;
+	else
+		open_param->src_format = FORMAT_420;
+
 	open_param->wave_param.gop_preset_idx = PRESET_IDX_IPP_SINGLE;
 	open_param->wave_param.hvs_qp_scale = 2;
 	open_param->wave_param.hvs_max_delta_qp = 10;
-- 
2.43.0


