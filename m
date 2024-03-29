Return-Path: <linux-kernel+bounces-124326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C2F8915B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D6DB22935
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112A3FB2A;
	Fri, 29 Mar 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xq3Iy/Mp"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2117.outbound.protection.outlook.com [40.107.8.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63A29CFB;
	Fri, 29 Mar 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704267; cv=fail; b=oNNgnW7L4877joWsDlLHMx1Lq4kHRjDO/HDC336OrrybaM+aqhj9FGwlamK3tu+uwtOCv9s/7hz8oQ9VIfhwOPxmI+0KFWjXnj869BB2ni5xVYxPIq7OjsWZG7H74WALOeed7y2ca9KX1OxRBzG8TwPImfG//rBy31nVWyWdc2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704267; c=relaxed/simple;
	bh=+sqFE4H1XUBoUXtziv7SmjdGz4p0LNe8Tc/9/2iuKd4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fnpp54yxpwtrW4Ikf0nPESGa2ShPsuHByIy/92eSMetLdTKuNVQACrLr+SkLbuPoW92Nj9hBBkGc+TEegxDavbXEC0Ewh2rRr3CeOv2SIjAN6a4/SU4wSVNSUc4e4rtCZBWMgYb8UQFWffQO/JPesuVEje0NFR9s1/0SdI/r3eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xq3Iy/Mp; arc=fail smtp.client-ip=40.107.8.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1bJtM2jVYSc5m3H0aYXE3sY2PIG2bL2z9VVLFRi3RpmejVnFeWOFIdZTGQ8XPliTbglQ5WtMHUw/XTL7I21cxiOJb7Rp+TIvFQitheQUdrm60g1aBHati7CCQumUS/NsfH+2QuHuVVyqqjG94jvRYJ0mxicdKEbCCJ/Tc1b5GgLtt3xJ5TLULGZRzerkBCXTdWpwmtKg5gtvRwjWvd0W1CqGcPTbuh88nvltf7HVGUTeS4CZw2rbd0TVnzc2EhMthP432/EWit0DU/Wi08z6/09dk/AMezQw0P5S8H9QVJxSsYmO1HCJBYixtR2UoDCIApQCW4pYsZaD6CR1vgrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JDnT5nTIUgOckyy9oY4LIf24tUGpA9APVeXCVtyg+g=;
 b=BCtd1MdDUZBwRdLyVzCw8C22fewJ2feUlzr2JDvxRGDWxOCMNAjNBdWdGvvg2rfivkaHjtDs8+OSMWk4DKE0bHKQYekpeKeK7qtT3PXszvN/e2u+dZOm0d1k0s7QIvQRgtFaNAA6UBvhE2tmpfDA7IVIau1wQAttlH1dSjj/2NkOO5OljErOOn7XAQcZeXkgOFyl2p0YXjngnTOQd342fCmhK/1Zam7+Qzcn+kWXh8tAJka7ezx8Sgjqew0OpDHXIXNW+T3poqAuKivSCFCkSP+SZezhIdocCdGHZWGCQRXM93OncwTqvSmGatDgLgaEwQ4DH2ZEyUiu8bvoPVAPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JDnT5nTIUgOckyy9oY4LIf24tUGpA9APVeXCVtyg+g=;
 b=Xq3Iy/Mpw0EB4+LAhSQrex+oaqNvlY1EhfuJnIddg1htdd+HzoEd/aVUh3SzKmf7t04LUuisuOlnxpEIVFhQ2tgpWhXMmoKc5wlznqrq+SjqCWJQJDpGC/t0OXIqtxO2xtjWDVKJScyGT7WMb5LroHuHmOMnA4VoQ2jiYFipbm0=
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GVXPR04MB10475.eurprd04.prod.outlook.com (2603:10a6:150:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 09:24:22 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::da55:641a:a6f2:6e4e]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::da55:641a:a6f2:6e4e%6]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 09:24:21 +0000
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
Subject: [PATCH 1/2] media: v4l2-ctrls: Add average qp control
Date: Fri, 29 Mar 2024 18:23:51 +0900
Message-ID: <20240329092352.2648837-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.43.0-rc1
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
	s5y9iJJgmJjZnBGt8As8zlicRSan3/AskYTJSHOcH7/Fd1eHut0BvUvaD3aDadrz8RhMJEDRLOoRY4ryxILUPJA+lKIb86HGhq6pvvzExnWThJuLqTvH9qUP1ji34hOlTcYLKsRspYPrJE/FmSh6xCsxuOnjEUQlQPy1wjIP8DqUox/Ja5ycPPji+jjkNRf1Ji8PHZcpIg3e39bskDCyI0WIOdUbG6p9bhu082RSoN+sXUt3rpZWYa+OlqmNUxQd9WqlRxbuB/FOXfRzLo+Pntoffa7rWxtgXWteMbFTmROAZGCWzfBQF2JfiZiNv4BvgyVRmuTDHtYMjvEDVRCPB0/S0qWRNMXvOGIx52ttaKkRw0pk0lr8vR5qmE27Odw7c1/eft8eKTvGwvhJIZC5hqTK49sUGw5lreWKGDBWbidiH82R5atcmPe/fnF5o9LEKiMS9UJbadKRTiUTO4tR7jr+FLVMS/yzq/QXVYtbok6kxZOJk+TY6ahuv1fYkobXca9IxdcWvQ60Rh3K0a/tdCCbSy5hDEpKMjY+ucPRU7tYIOIetdXIYxbZ05jl10in8WcFeBxUOi4fyeFRfJP9eSLGGQ96xSQY2NHeUJlwqZHmY6XV2ujj9Tb3wBmuRNZGaLkXqplrrq3tUiBS5ODSwgqwBkCpQG6/UwjGeMAOWtJinuYFMDTixOSYW2cQKkotkZ9NSwEfZdLIoNEjv4LhIPOD1YheXI3WD8zLD5Z2fhE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n3/Q/GL5QNgo5crE1i4catwdy5AwPe7CbJsRKF7FhthrP9ix9K9NKo/0XrMy?=
 =?us-ascii?Q?JzMcr68gvarUosFJ1JRGU1urkkKeJrgnILUq1zyue0OX9R2nH8341kG0iQzS?=
 =?us-ascii?Q?OZS12S5cGhAeFAYOdp2JI0IWdPWVEktSJ8TutxUkkuhOqXBrqIGVSWTcphcL?=
 =?us-ascii?Q?m8orihJvp+xMipxMNVRBbmr27imZK3X3GeTEDmpSrSiWQ4/pN6yjMrgmxxCl?=
 =?us-ascii?Q?VdHGWznS+kYo4qynah6Iy+x30tmpuqPrOjGTXm5iOnD33Wf1lIum6thLulJl?=
 =?us-ascii?Q?KfRB70spf7us66VeA3M/qPdNrBCdNukfiobhXxK9WCUrLSsCKHOsNvwxzRPe?=
 =?us-ascii?Q?VLKmflT9DFs6zP+KtAuNzqTO8tXkrS/s/I2Aj1hpheB0Yr++EnSl3yQpup8S?=
 =?us-ascii?Q?5mSeM+mL7bFHXGgjHXt8l2xcrDcnsS1AZe3DnMmukr6tli/XSnBify+WZ6D1?=
 =?us-ascii?Q?e5ik/+zi6Ba5yR8RvapPbq89ZNUCpogRFzKQEb2QxH1uK3XO5ZivsyGNHn2n?=
 =?us-ascii?Q?wyLBaks8pNVxr3otG7fdNIODIn/9EHXnWlOYUdYDkAkwUHFI/jdg8LfRInQU?=
 =?us-ascii?Q?HVc255IBjZulg2HJ4r9miNLGzqZmcAiP4QvXkhfqOeuAjlSa6VXXI6Y49Riq?=
 =?us-ascii?Q?esLgP9JDMCS03BvwzMlWVfejFN+k5ENUacT4FUdGs0AkyOGdYFW56wnLeuML?=
 =?us-ascii?Q?DCUD+Kq9alxYJmxhU+hCjYw2u4ge0n15YPrFQ9tnATZhAQ12i8IYYOdRfE9q?=
 =?us-ascii?Q?aaYtL/1ytvV1D6DrvYP6gzlLbc1ZCJWi/qnU1tSV+j7gn0YIMw63dj2DB+Yh?=
 =?us-ascii?Q?iRjp6S1eDbSWOBZFHFZpeGk9BlRd0Z7X7lqNxR6buGIV8TUR0IV7OayY5Ofv?=
 =?us-ascii?Q?ZJCBvQVWGbSLqhvpdkfBnc8SRqv6Yb2NmD3yqmKHi6HK8pSmpbMaFkrPDlBa?=
 =?us-ascii?Q?pBmtFcrDKeokpmLHVG6ZyWS63ITcPPEkM3pjWa2SRF3ZNfZ1AVoWDEV6o7+h?=
 =?us-ascii?Q?aa5HRRnZCPuvfsQiWBUp3VNPeAq/3CXoC6V6hZvDigTnzUgkt9PhIt1n/HWf?=
 =?us-ascii?Q?d1qxWMU5hvvOPftC6MB2/Udbwr0Hfvpby5lYNVfzX9xj6Q1c6HLJxr0qtZMh?=
 =?us-ascii?Q?vuMhKCw63RAGtI4tiXVNWh9hP0XcUYywqnk5Aa+xJhH8OqvzxgTRjSKaRj51?=
 =?us-ascii?Q?N3791JBgFY6+S3T2pSEdpXfyHWnCYy8lkArTEekocW4K54lFmiuFvt3eigb4?=
 =?us-ascii?Q?6kIhPRmq9DIys3Oa19UwImMUMwg1lNgWM8LESMfkNeABI2m3AfU6IBX4dhbE?=
 =?us-ascii?Q?JCJ8G6dStOxLpri1q3xEylK4AS/pVg6KQQZPa0wPHNQEyRAxm/W3Fud8Dc+o?=
 =?us-ascii?Q?3GkvP5o4SzJ6O187FHmXwMbvvd6BCQ783kO7nmBdpNvRGHWI/JepB0MxKoXN?=
 =?us-ascii?Q?9ablzxfhCuz4l1L2/v4Fw2vPNdIUsNh4ZhxljTrHDS9r8ujZ8mzAwUZAEkQv?=
 =?us-ascii?Q?Uz0KFkT7mCtwcgA2cdE1OhqxBnZYKK/2cGuziQfSE0feWIKnM/XjPd/9R+4L?=
 =?us-ascii?Q?/NI+0T3swqRc4wFGU20cj3Q9ZlVUGus/rBxxTA73?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b86d86-89c3-4983-ce3a-08dc4fd20482
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 09:24:21.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDxB4tHz9u8RkYToCrNERj05kPABMuZnK7Z9pjGi7cfaMvzZfBhsAh9o/QIAjXrM9eWEUNgHUCZm2yQIvLdKEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10475

Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
value of current encoded frame.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
 include/uapi/linux/v4l2-controls.h                        | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 2a165ae063fb..cef20b3f54ca 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1653,6 +1653,10 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
     Quantization parameter for a P frame for FWHT. Valid range: from 1
     to 31.
 
+``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
+    This read-only control returns the average qp value of the currently
+    encoded frame. Applicable to the H264 and HEVC encoders.
+
 .. raw:: latex
 
     \normalsize
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 8696eb1cdd61..88e86e4e539d 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -972,6 +972,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:		return "Use LTR Frames";
 	case V4L2_CID_FWHT_I_FRAME_QP:				return "FWHT I-Frame QP Value";
 	case V4L2_CID_FWHT_P_FRAME_QP:				return "FWHT P-Frame QP Value";
+	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:			return "Average QP value";
 
 	/* VPX controls */
 	case V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS:		return "VPX Number of Partitions";
@@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		*max = 0xffffffffffffLL;
 		*step = 1;
 		break;
+	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
+		*type = V4L2_CTRL_TYPE_INTEGER;
+		*flags |= V4L2_CTRL_FLAG_VOLATILE | V4L2_CTRL_FLAG_READ_ONLY;
+		break;
 	case V4L2_CID_PIXEL_RATE:
 		*type = V4L2_CTRL_TYPE_INTEGER64;
 		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 99c3f5e99da7..974fd254e573 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -898,6 +898,8 @@ enum v4l2_mpeg_video_av1_level {
 	V4L2_MPEG_VIDEO_AV1_LEVEL_7_3 = 23
 };
 
+#define V4L2_CID_MPEG_VIDEO_AVERAGE_QP  (V4L2_CID_CODEC_BASE + 657)
+
 /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
 #define V4L2_CID_CODEC_CX2341X_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1000)
 #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_CODEC_CX2341X_BASE+0)
-- 
2.43.0-rc1


