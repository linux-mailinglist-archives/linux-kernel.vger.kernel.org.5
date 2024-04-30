Return-Path: <linux-kernel+bounces-163238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181078B678A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6601C20C84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E68BF1;
	Tue, 30 Apr 2024 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="jMQdILad"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022018.outbound.protection.outlook.com [52.101.154.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482C17F5;
	Tue, 30 Apr 2024 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441156; cv=fail; b=N3KCBfeN9vu3itziQ4nyKV4akU30g+nehX495TRI1DJFgu9027O46YzDv9591j0+XrmNk0Vm2vxs5yZJ4OY0skrbCVmlSMlcKMUk+U4i6sua9veXxBd6L+Ubeomgz8porZRu4C2HLBqOBclsDkK4fhQH04JJoIjcwdjRJkSsul4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441156; c=relaxed/simple;
	bh=LRZ7WFXbHhzipeQ4f4GxVYXrahpPa1ffp4oaRK4ViNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVw7Xi/pAgZoflGTJiio+XYQYiEbxcpdtyXsaOeoYyTdrujRqU4AEliu7lCuGFMYKnp+a+9rhVOtMbcedjMBsuWhZu86nXITSRer+SpInt7Q/nceLeP1Ik3zYThXpR/QCA+scteWMMx/5piUtFPGEJTMqXKiTK46ZWUo5gZDiJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=jMQdILad; arc=fail smtp.client-ip=52.101.154.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAFqCCQc8KWQv62a25TRgoxGXC8Y7hiFllzk6TayMxHtpbo1k8cr/Be075sh7tfNoYTav6jXakQVMLpb2uWyRBu8cjmc5410rynvtunsBOSgrx7h4ISKRm+t+ImOXYaGS3hlafwgMED8+MpoI/L+PxHeG9xTjJISK2L0QTVkYsWUMgIC34IGtSiTEZ4DUaeTr+3j4BK1akx0A6Hk3l8HAiIY830Vfs0SHFP2ik34hcs9d/sDe0syp4P2Bl2GXsYdm8LWzw5e1/zBaUSKsozD3w1Gj1fJD/JkDiA3d6AZr4rguAOTui9qi+rw5uIU/iJZqWPoT2LhiO9hZj40LJN1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZmiTKU+GeUSjmX5LtpCmEnBh4mdQBL3M1DfjwaYLIA=;
 b=hZxPwT7v3l/2xSfAC/+kEejR8SDnOzpLGjmAvWkrkZpTU6+AUydjHEpPp96Eo1iiHk1iRVw6fuiOAdYzpGiZkMoEVwMVZTtKQtIAlxbHyFMNcJxf5o8Lf1pVG8Qthuh1MiNqV1bzP7atsSG07oJ8URFpBE2s1is5A4wUpvGVA2jlDI3Ph7PuQfW7sBUqgH5xWChFJUQfbgQcfUNzEyCicVbo+4n0ed5R6nDKaAEnx6A2sT7ja2PF8yJYojeYMBIVKNZ5JPOSSuUEYysj5L5S5RK2Hyw/I98ymb/+57TmGTIbFGpytTdqbAgG9hdMQ1hN38PaKFPvh+WD37Z8zXM4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZmiTKU+GeUSjmX5LtpCmEnBh4mdQBL3M1DfjwaYLIA=;
 b=jMQdILadD/ENoVehWGL4C8y2A2lyian7Uj+XSUU2EXAFcNzfwFVLmQFOx6FXaB2bg14NkLO2r2NvXEFNW9rr5ml/oFxW4c3NBjjTSNXG1AUCARUKW25lkOUs3LSwofUnRhxhS5N+H1cH4dxZgeW7xbzsxyP7CPBrUBwBT4qT0Lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 PU4P216MB1324.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Tue, 30 Apr 2024 01:39:11 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 01:39:11 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	jackson.lee@chipnsmedia.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [PATCH v3 4/4] media: chips-media: wave5: Support YUV422 raw pixel-formats on the encoder.
Date: Tue, 30 Apr 2024 10:39:00 +0900
Message-Id: <20240430013900.187-5-nas.chung@chipsnmedia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430013900.187-1-nas.chung@chipsnmedia.com>
References: <20240430013900.187-1-nas.chung@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0211.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::19) To SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2P216MB1246:EE_|PU4P216MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: b39bdff6-ed38-4a8b-7be6-08dc68b6559b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGpZp02/u6iXNL9/Mc6jUVPKam4xZ1WEBmAROEvgUl8Y1Rf/j2snMcEmvWhw?=
 =?us-ascii?Q?JDuR4tbxMuYA6lo71yFmsN9or36yIbKcKgcL+JK8axALTKZKboKrxa0WVv6L?=
 =?us-ascii?Q?n2LIBtwwWsO2QoLs1RR3WJwW3UVITl4lS80jkkV9K1Xn3WWz7BXax3FYajy2?=
 =?us-ascii?Q?tb+qSBDB9Y/BVv5Ia975ETo5exA2k9uPQ3Tz4HZ9fOo+YGCa2twesfRKgJOh?=
 =?us-ascii?Q?v2DPJuxgEyG/dInQ3BBmCIh4ih1jAY22CC8CfbW7f9tAqQfUkaL5lccU8CNc?=
 =?us-ascii?Q?Mcii3aq+QMt3D59C9w5RLEwE1juA+s/y63gM0ztDUBYUasm1rpVJ//OjsjkD?=
 =?us-ascii?Q?QMR0CQHppoyDek4umv2ZjJ0PsKu5rDfK4QiRoJLkgvVmyGev7Sp2TS82cxM1?=
 =?us-ascii?Q?YJegYqqmR/dS4ObfWVmWPDWzdcNzYkHhCUQmENGUHZNbsAqAeUab40pI610I?=
 =?us-ascii?Q?5I6aIBWukNDpWcc8YrkSZ2BHPWTkBc//o0NBADwFmG2vrXwBwXFyuQtdAuzH?=
 =?us-ascii?Q?8LtfErxgS+olJHFE6Ow6J6eKemar87FWKC7hzVu+iT2/wKDdSvJaN2ma6Kev?=
 =?us-ascii?Q?SM1NaFmB9OMCggBI4cjE7++4kl/du+2Lu7IcDM5MU9WP7LiIvcIEgWn53LYI?=
 =?us-ascii?Q?tzwWAIYMDG7XJDcCuS9CLd5EfMRUChCc9z8fAiTIZ+QPPwZ9ykZE2iurtT3J?=
 =?us-ascii?Q?lOxiDYMfR8K5FsvrvVZWEPVGOMPJB9ylczd9UFxwMXI1w0HhtewfxhIp9apa?=
 =?us-ascii?Q?/fe1OfcFS2l/V87Oo3TE1EFcEsFoV+DkBbRENxFOTTgVKhtvLy9a+eXVEQR0?=
 =?us-ascii?Q?xBq4j1sVvXcbr8EP4JA/39zKUIr8Sw2uYMxC4w4f23P544XZTguVVSHU8AWF?=
 =?us-ascii?Q?wNzDEPjsmEQgJ6E0MCqHO3qYKnKP7GEGj22IOVOe0W0+gGWdgb+fVlblAjLO?=
 =?us-ascii?Q?w0NXCWEX6WVWoiPvXEGZwz2JaCJJC765bJsBGidWSmkHzQxu0G7SyHEN9HVE?=
 =?us-ascii?Q?AgcHQClhloGqrhf0BLmNr5qT5+XpIurIhvNN46MDtvz0BfekXMPnKok0Oqym?=
 =?us-ascii?Q?I7P4nYvwbES3wxejclcNjoWWZrcWWd3qFJWTlvX9eR1VsyYG++AwFRtbcE2/?=
 =?us-ascii?Q?Bb8hPCg9iSKUSUH0vkh2dn0kTYQUPJEX0LAb/fmz2KPhioYlEH5Ilml+yD0d?=
 =?us-ascii?Q?CSe62HlFIQBB/A4P1d6ekv21JN+4JkKEd0dbvqkAgI3R8GTukKv6ugTCdU4w?=
 =?us-ascii?Q?vems5+n+FtOF/9q68ZjHzsVfS2uewE7g2QvxAor3SmUaoTQoUhxC5NidGPYF?=
 =?us-ascii?Q?7/QARZYtK3GmKkBPfCy1Y1qtA2xny9ASc9Tr6I/VIPmIsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?blG7TrdS6lD1kcatld35V7fEtt5gIzvvy7YmM167Cpc9wR3gA1y9tW3fFdRP?=
 =?us-ascii?Q?hSLc1GFLdG47W/18IpipYzXBL8hAqMJUxiseHkJhYaqy4GmqN2WoZMgZ3TC+?=
 =?us-ascii?Q?xvzwJCFPeGG/ezfabPNcm2b0j7nzsodnpNVRafF+U5Bf7l/U9KOOQrRzqdaX?=
 =?us-ascii?Q?+EuMOz45Cs26+qMdyFMRFGSsGWWxaMILQV14+bT5BLEwXreyV1UTZFEYYkCI?=
 =?us-ascii?Q?ZBc2NU0iqabYPkp5rGYdELW3DNh3Ya0vFVZU4Q9EPsTGywe90udo44eIyWwo?=
 =?us-ascii?Q?GgY/dCklYDuOLU03GVQ9VZZo+1asyKna0JKkLVulnJaSqyaldZZKU1VXr4R0?=
 =?us-ascii?Q?yphpcJM/6IbaC2bcKcFJjRQ+ogHl/fLQY4LSmwPk7OhRK7Uls6gb0fSmdVRr?=
 =?us-ascii?Q?RWsJsk6/0vASrYRV3z433o82EGmhdwnacDTeyfHe4KyKtKAUe0X3X233YAnK?=
 =?us-ascii?Q?VFaajERjIchKrYuff+keNiBJXbTU+Cy+RDYXRNup07j+jxH6UfFhLj5ODg9d?=
 =?us-ascii?Q?GgDxmBagMbtAOCm4ncdzXhgPjm6eZBcIXPMzwkMaJ9YZyhgB5dF06p4kF2Mc?=
 =?us-ascii?Q?XZ2yAJ1jx63XSUn7oz0POgud0oOCUg6syAeHSn+8HNymmzOZyGFrp9s1nCwS?=
 =?us-ascii?Q?x5fTZBdOUpd6PM2R5NOMTOCbzluUHuME1qrzgzPwgr/k09atwYDGaV8vq+3F?=
 =?us-ascii?Q?XMXnOo8CWiKGQD+IBr+usnANsLmSYCshd2fVBKBlt41MiRxgjKKWz1IWj00k?=
 =?us-ascii?Q?xOH+UE9WwmVX4TZfOU77NtFrxoQk4SIf4tLhAfdEVJTpUhm5Svog4tuU/gk8?=
 =?us-ascii?Q?QnX9c3o/TBB8l7e8qBWaMF58+f5feJct96COYrSdqUug9ApNHR6lgU8ggFZp?=
 =?us-ascii?Q?jq6F2meljBau2CQ0u2OXU+qVAzXBGH3OJwhRszhZFi3aBFz33oYzY7Oxnn/L?=
 =?us-ascii?Q?3UjAlgfBjiBYAQI3paeBoBWwTqcrEzDM1iQ8Vns0xx3ysyVSvxiJEviZFCJm?=
 =?us-ascii?Q?EFMnyIau3X+/RtzXipMBgzPLWfxD1VkKILmU0b6uO0EhLj1tYVelLrlUxs/8?=
 =?us-ascii?Q?zfFP1bO9lyPN93nRLNA6evWnj6RsGM3wVJGnrqAniuKVQKCW8ds0zLfpXPv9?=
 =?us-ascii?Q?LVX33R5QUnbInbny6/lsGzIcbMwWtWXFLZSOD1Whr+mxKh8Q7PoDUpr01s02?=
 =?us-ascii?Q?8z/2kvSITljosKni4Oadklew9lOEVRMv6A2kq/yyBa1z1XgCnroBoWMgywHI?=
 =?us-ascii?Q?vwxuSdc5E/8EpMYMUwCcJxSk/JzIP8y6sF2B5tSsH+lprEvAoNpFdW0kL/20?=
 =?us-ascii?Q?y6ZPsZVgpoGJ/cKcTcjDxbqUxYtoxccwhxp1VwFrjoiODMbnOoJ56tkhBL8u?=
 =?us-ascii?Q?iP5EP4ivJGHwbLuI2RJJ5ICUYx2VL7wkI8IVTiqzY7wQo1WCzloghR1H0MD2?=
 =?us-ascii?Q?SRA92yh6Sb9lI+WdaHBVb9ECXWwylg5yu9/HGmT4a0cgyEM4qylCfuGdpDCY?=
 =?us-ascii?Q?izBVlS9Ug22qcMRVcNr33y3h4Za7XwqLGh5sXXGrAbGS0w/cQDA1X7cuGjv0?=
 =?us-ascii?Q?Dl2m5P9FW//bOCsZNtSeth5y7xKt1cuHTrPVNdlcbg3KIyjc6frV89gmJEZv?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39bdff6-ed38-4a8b-7be6-08dc68b6559b
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:39:11.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQFBL71WBWljVz/IkDdFLdsxsix/xJr+Tn0cIvrwNwBSTl5UG44d8vn/sdmswrGcADdmHzqyml65u65j67UFmp50n42Qah8ZRK4/YJPwudg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1324

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

Add support for the YUV422P, NV16, NV61, YUV422M, NV16M, NV61M raw pixel-formats to the Wave5 encoder.
All these formats have a chroma subsampling ratio of 4:2:2 and therefore require a new image size calculation as the driver previously only handled a ratio of 4:2:0.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-enc.c         | 59 +++++++++++++++++--
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 75d230df45f6..0d6bec4e28d1 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -66,6 +66,24 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
 			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_RAW],
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
 
@@ -109,13 +127,30 @@ static int start_encode(struct vpu_instance *inst, u32 *fail_res)
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
@@ -501,11 +536,15 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
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
@@ -1102,6 +1141,16 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
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


