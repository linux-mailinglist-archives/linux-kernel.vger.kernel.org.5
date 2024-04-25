Return-Path: <linux-kernel+bounces-158083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60228B1B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFFCBB22F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB8F5DF1C;
	Thu, 25 Apr 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bCbP1y7E"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2895A0FE;
	Thu, 25 Apr 2024 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027844; cv=fail; b=TQ9WfVkHi8mdhuMNJ7kF7GTpfV77LgfR/1JmFeVI8VkuACKx6B9cKbo1eQ67SH4O9is1cn4sNebBAeu56D5OPndbCDeX91ZEYqy4cUjlxOo7ao5yxJnUMi2z7QfRybBDm0HztkmU4dxrdsr512Hvv/pEEfwKHHxbruugf6lFZ0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027844; c=relaxed/simple;
	bh=PCh2y4lk9VdXFUYXgfFqT0jif/eN/c7URkk9y9K1NGE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q7gIjhXPunuG1ioa5Xm2O14YlaeVC/oD9uYERtdZJeKivvxo0/f0OYFQmNk8ZwLihn7X37HYmxTgNHgeiygYBYxzdlqRrPBD+Wp4IJ9Y0O/Y8qQdfPztF/dcoGvZ+MWqPAwYTxLJ79kv8Noj3GvjuqUdSl9gTc9k5aWoLVRIB0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bCbP1y7E; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rjp1jK8UUO00q0sqTmxn/CYbu/MJczMdyYyURm01JYWtIc28z1NIe/vJy1w1xxtba2WDsVXrZcWnE5J6y4+LbYzSElkua/pYUG62Ie0v8K+TzFXe+YrUEE5pCDRVejL5x0S2ckl2OC6b4Qoe/xz5NHLSYN8+aMdZq+6iMJnhLscHaaeiFeAlAYuYRzlS+cHVKI5WhQmKKg+7vyqrvxvXzZR4Orq4JxMb8FQ5cMUXD399ENIYFtPcGlFb93WKIGXfhmuAhZ1f+QYRqbEf5kzaJ0J/0+ULuY+pHQFiafhcDZoSz3xgoDQiU4IZbc3uLWZxbYdHidqtpDIklWOm2EDvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvGgJHNKtsZsUR4Sb2tsoJuO8jlu/mfjnKWRw3saWmY=;
 b=IUy8c1hPl1brxO12Yc583Y/FlRIZ/rag4D51df1C2OD/cj9U0XRITMLNqvjT48w/Jp5FPawu9qOe9XUGfeGJmay3j3Hc0gy7J3PsXRlTDdbrhv42nG62UkdxoRP6u4HxVuDaQqlLScpfnGAdCbOgudR+fRTtuj4WIjvp1hu4eYZv3WibkZyf/Nsnp+UaURpY6gBL318Rp7uxhGpSNrnz0Qfo6HjhZVEKgvRTW9RQe7W7XSZDJjyuyGYbye2iMRKbwzZK34cNhUjUuKDTWCJSQdH0YHMzmSHmRJHtEzv8hQuQJJKovPaNQa01+fVdbdlyGSZVFGD+P2xdmXMoeKTXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvGgJHNKtsZsUR4Sb2tsoJuO8jlu/mfjnKWRw3saWmY=;
 b=bCbP1y7E5ORyzSnFRrnpGfYqsn9fbU0HHGJeYmPxKZ6zjkM4dFwOXyVrcUV7m6UQZxNjsNdRyDBM8HMtOinBVhWQmgXDYUuNv/1k4V9Eo+CHZ4Bi7thMSLHMCsxypezz5dOtSybAzxohM7/R07JhHfhnpwtEZv/63akJrmeDPp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 06:50:36 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:50:35 +0000
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
Subject: [PATCH v2 1/3] media: v4l2-ctrls: Add average qp control
Date: Thu, 25 Apr 2024 15:50:09 +0900
Message-ID: <20240425065011.105915-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.43.0-rc1
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
X-MS-Office365-Filtering-Correlation-Id: 51a33c27-e91a-4e1b-4b10-08dc64f4021b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?moqUoB6AnNibxhvxHAmL94Xv+8r0kifS2/S00FGFL/19XaYOFJ/qNaOkiI+A?=
 =?us-ascii?Q?Yo+3mqAiPYEo2y8iGekt4OBIOqP3pd/4b5QOxWxHrjp5WaCCvAMFY4Ca3nNO?=
 =?us-ascii?Q?YdVOrN/RG1WbQY4zJDi/GUk08Bj8i+r5WNtT33AaDh6L/WCHRGqdNMHH7Dhy?=
 =?us-ascii?Q?U/X4r3SyaW5HRSdGynH7nWoxOb8fGa62sHsJSiQlFiTDnGPU9PgfZsHDFql+?=
 =?us-ascii?Q?YmXJ7d4QCLVtBaCIL/RL6iat4Q5XUCpHiOrJrIZ+Ptq03cKKbsh9M41cK6cm?=
 =?us-ascii?Q?LLq6pngU0eji9wcySRTSUV/y5saaTB8MCR4wvxE4//OL/9K/T9r6OAPTrSnm?=
 =?us-ascii?Q?kMJyOPlYefYLbO1FG5CXs/pVfd2NnlCWsuQmaUBuNABCrPxJbXIC7kqFWi77?=
 =?us-ascii?Q?kLiL/3UR9WHeIZt7k/cHXzR+Ss4pskJsyYBvae0hyancjFsVtWSwIt2A1kbj?=
 =?us-ascii?Q?wwc4jtceQQk4KZB479dTXMdLzHJhiS2Ihc3v8oAartKfK9pWMl0PoYEb2IZb?=
 =?us-ascii?Q?EWbCNbDOWDxmxSjBR1CClY6pDKd4K5vAMI6sN6K7WfJyDRAMQWEXNNQmKLg9?=
 =?us-ascii?Q?BQPPm46cU8Vhf7o03wVaBuCs+HnKcre/FiGIkTEvWW5/YYTwIVdZTKcuKfGS?=
 =?us-ascii?Q?QUAmUNXvak2yRm9pSclYOPpuHzNUNSCoUmR+GiJ3lrD09SNkn4Tqx0n3s047?=
 =?us-ascii?Q?jsXlIynL4JIntTNzWFU19URl4Sz6zymo1bNNjkGpNzNHlcAQWeThPd3h2JMp?=
 =?us-ascii?Q?dXnE7kpUnCcbISAw9uVrz31WDrXrFMLkxrq58QDf8R2Zuuye9tTrgECkSab+?=
 =?us-ascii?Q?+uhSPLf0rbZoZYguBWkRa02MnVxCGBwr3wEVvJl+KRrOvNK8ZvlX3Gk13UBR?=
 =?us-ascii?Q?/fIwlh+B/8Dlb3uR6zOfaOkO9U3pa0pLoZissjXtrYKB/PfLuBw0zr/hh78U?=
 =?us-ascii?Q?u43iDFpOjEJ2cUsrzCjANl7GQgEHH7y6EfEkk948sjBg51J//ynwJsZc7qnb?=
 =?us-ascii?Q?G5rSyD8YOJ4qzhuSGyz2YVBgeW2gl3CdXeFukjEn/t1x9/ctDRfIkcWW7WAq?=
 =?us-ascii?Q?fOF5KWQt1472Hz1Yjz+V5bpM3V6BjYIVxWcuDofzrlPOmuRxGOvbWojmgM56?=
 =?us-ascii?Q?qnOyAdCTr98p+zqHYE+K12KuSIvYIs5kRlPexbvU/eotfGyUgTEiJj4q99AT?=
 =?us-ascii?Q?aSzzTjNcWRT4SvaMlrZ4wBRBzOv8X6wLMeOjDw39ta9I+ZtY+T/WwXopV6cs?=
 =?us-ascii?Q?Bj42mMQYGkDV/DKLE30v222yDKNEi1VTPSkNj9ZSvyTAr4uYLtnMXfgytyaI?=
 =?us-ascii?Q?Sz4uC9VQLn1pwEZT4W747z/NeG7whc+iatwfFKgxY+iZ6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A7eEG9lWoTu8E10i2vSDIdnNOMSih/9qAWE6g/oG1BD8KhRSG8hGt9dQvvxl?=
 =?us-ascii?Q?CfaODpDMKiUnZwuVxMFateUykEb1Nh/FaSAa++RsOMFN6C3e6Z3UOCEr6GH/?=
 =?us-ascii?Q?Pzb/HZ0r6yGecl3/Vb0y6xmz3bodIp8wqJwD+BzZARpW6lLYG1B27qI2pWE3?=
 =?us-ascii?Q?8zMOMHcpSs1ok6kZ8HcDIX/BGMICcZm+x7jlNYHMw0xuTnxy0q22yLzmGVqY?=
 =?us-ascii?Q?Ne/LwenX8BD96OH04eMcbYqjALUbHiVvDID6988F1U1ah/D7BOsC/sd2JdVQ?=
 =?us-ascii?Q?NmOgVEFG8ihOk5/rhbf4yHLE3TRzev+oz2V1CEav0ocWyWUhqSOcd97+pcFM?=
 =?us-ascii?Q?Vi9tZqgbrXq1M/NFdz2vGsM/QVZfNYe2U3cxzVn+cyaYWbSvANX/VRi1FPaX?=
 =?us-ascii?Q?7RzjQg+gh8eaGzT8OwJRWjUntBDhwh1//MViZ7oRvgBBrMskpbs3TioniBLa?=
 =?us-ascii?Q?OiR3uoyhXQmouLY31STvVYcv1pFRR2nIDddJ2HFmEw9NmGgMWcaWLG4dn/3r?=
 =?us-ascii?Q?kUCxn+q9sNCw3Z84fsqX8CYb6h0oXXrTQpJdbMlcqQ5Osws/E2Cs75OqMxtD?=
 =?us-ascii?Q?G9WzD2ejUQ1AU45N6vaGntMfZmrvrmSXPDoh2aw5FLjFy5GNf4jC3SqANnlO?=
 =?us-ascii?Q?3P92UPNyX6p+dwdOtbKYWz1rVPW9ENClCLkV6KgNUL6YVMn8F+x73ZaFGmZG?=
 =?us-ascii?Q?U2gKfe7KmhxXxwQHDjvGYR9JHe3sE79l+XJ3+UD9FDvRxOOhE7KTCe2otUMx?=
 =?us-ascii?Q?VE6ST5c2T3K7TgSeJO6ktX7TeX3JCeAPnaNsSH8wH308tUeKRf2JKoDx5LEc?=
 =?us-ascii?Q?rL6OIr/U4rbWXtxy9mgljt9iA2FIG9F+BV+XQBL0UljzgFVSTpiGuGwxjWIH?=
 =?us-ascii?Q?SYALU0sQoC7mjpBTWcdEwGK7fgczbXxN2nKTnG/FizBo0UrZv51PGOIKjIgg?=
 =?us-ascii?Q?TLSXHNqh1uuVNjcxR4DnNm6Cq+O7h1js+aAFKXA9S3U/eFp7ragwJrzvwYmt?=
 =?us-ascii?Q?vWfMkgBTPZc/VjNcXOwHY8nmassqf+51ZjQzmp/0SmsgqgZQ/H4TsYyIfgJ3?=
 =?us-ascii?Q?DqTf4pUTjLc9VvFGBHbdypQsK9exDiU8GqLbKXHvJHR5pwAn02i3YfKjZ7Fw?=
 =?us-ascii?Q?sU8CYqhWkaYmDpzcLE6np4lmQ4GZRocvBAV4lMSLEOjnILojoRv6HW6Zl6Cr?=
 =?us-ascii?Q?MeHQhZRqJPem0t8j4olGtO/xvoJgXhGz871qsTwCfpK+nheopfP7ZrR9yY3P?=
 =?us-ascii?Q?NW9uS5TW8BVsiXdpjUt8zfJ2cpxibuYkaEcUzuRDKF9EC8Z0d8j7mTEuzlIS?=
 =?us-ascii?Q?At2RccArYzREYrDvM8HeRxWZbaloGKM/7ZjYy9fLIMWKEf7HjNgupSHXVw80?=
 =?us-ascii?Q?zfyFofe3aQnTH8+7sI0Z4YgeUA7vyriCz3yUD5h7leFhC6LMzLx0LduAF/yH?=
 =?us-ascii?Q?BS1S2IZKhQ0REFG9DSaxvLvhfALwCL9+xg7ChXp9WZw810QoPDAFh+lSRoou?=
 =?us-ascii?Q?fjVVFXisx7e/sYZ9QN3pAtdvdXKE0ulnf74gSsc6ghsh47/Wj2twrv3FBVgJ?=
 =?us-ascii?Q?0xPe5v/p2tadAhQ7BPzvwVxLhByWxix00cGmZhQj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a33c27-e91a-4e1b-4b10-08dc64f4021b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:50:35.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TsM83956d+JVOaUYbe5Ohq2Ca58CuZdUTRJhoM6pXimwqG9xXOYJrQZX7CiasOvvszs8IBePfcCa/dqsSPp0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
value of current encoded frame. the value applies to the last dequeued
capture buffer.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
 - improve document description according Hans's comments
 - drop volatile flag

 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
 include/uapi/linux/v4l2-controls.h                        | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 2a165ae063fb..7d82ab14b8ba 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1653,6 +1653,11 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
     Quantization parameter for a P frame for FWHT. Valid range: from 1
     to 31.
 
+``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
+    This read-only control returns the average QP value of the currently
+    encoded frame. The value applies to the last dequeued capture buffer
+    (VIDIOC_DQBUF). Applicable to encoders.
+
 .. raw:: latex
 
     \normalsize
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 8696eb1cdd61..1ea52011247a 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -970,6 +970,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_LTR_COUNT:			return "LTR Count";
 	case V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX:		return "Frame LTR Index";
 	case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:		return "Use LTR Frames";
+	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:			return "Average QP Value";
 	case V4L2_CID_FWHT_I_FRAME_QP:				return "FWHT I-Frame QP Value";
 	case V4L2_CID_FWHT_P_FRAME_QP:				return "FWHT P-Frame QP Value";
 
@@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		*max = 0xffffffffffffLL;
 		*step = 1;
 		break;
+	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
+		*type = V4L2_CTRL_TYPE_INTEGER;
+		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
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


