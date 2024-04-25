Return-Path: <linux-kernel+bounces-158085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA08B1B43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEB11F21AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2357D6D1B3;
	Thu, 25 Apr 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gWwwiK0x"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DC6BFD4;
	Thu, 25 Apr 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027850; cv=fail; b=cPcFCr/dmXdCfCWw9A3VXo/J82Su5hwuih0j+/H9oOnBJMEepa8h7+QBS2R2ovEnkIiiMpnuHDWBs7py3dNpnX2H6A8/GEJr5oVl170bzu32R4oRhrMowx2XOHfpFF0b+5QncyLPJWBCIKaDYYKNLjZH8h+iHSt9JSKk7BUQZLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027850; c=relaxed/simple;
	bh=D30yGpPmVgCnnlBDsy0nJXeTSgQ6INrC94CaUA36n0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ag/cjIqZwmRKg4sKdhoXWqVdZtvdbH61RqbA5CqimQP7YzL9trSWcRN1k8RsRQd8aj/dBwp6ZpG9o3oqgAvz3eZP5PfkipfH2+fOeECmVXWxWz8T7QsidRWVX64lWfdRLa3fSNfneucNLAiNKstzq4wJKusD3qvCffatz60qO9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gWwwiK0x; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTik1O3MCohT2OM5ecup19PJnKIrM/CinijtilC+9pjE6jBloAWwZgTJou028ej9ffsl99rXmSc9TpnM8NmxUS++Hb+k705N25Tp5j6VSzTBCnzXhbU7ZBxgCJeuWGP7wMw10gguVi1Y8qkTwPDe7otA/j73RDfTvVyoQkV5Y+/uI+SytnN2qW4Frg+BVsZEzb7uAXaDx3pXZUr7AaSizbvKfiayYh5GGFnJQL71aVa3HHnnzhhLV9hy1WMh+zrvlv2MMcOOfEGu4LQRD918FUjF8b+FHL1SdyP1+cJheN3CV0og2ZBuD5P15FXuSzoGKt8X+x80evkq/6qi/W15zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKO7USvgcRpf8ZtjOwhMKho+dhIGOBV2S4yWRg0mIdQ=;
 b=B7kGdkmuU1ytlAQsy6KTM3Iegy0Rx/fVkrXDym6eeJpWyiecHWSDy5mu7fcL6bU+AXgVDDSu5r5PCarIOmn5KLIvnsRFqSq/C3cOekGPvUYIlqwQcRztEP6YKW3fHx80ScVRpUPL44SaCcvBcKgKbkACi/OSI/1+8WC1Hjnt0H4wE3t0EVqk0zRDysn1jwQbuoE4azOQeuEipbbS5fwPYvTeU/ZyS0coG1IsRydwRsxO34nnk+KyHu1XfBDkweP8ujDCPg+dtoZTQ/BGtHkyFTy9LEgCckI/3pWq1lhDS82ZnAzKYlsV8PEaOIaMKTNUSS2kjBgX8IQt214vgwtI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKO7USvgcRpf8ZtjOwhMKho+dhIGOBV2S4yWRg0mIdQ=;
 b=gWwwiK0xv3q1OpYzfviqeIQxRFMG52BEqZDOBlfKGr/BNiuqQ59pxDedBhwdeQBA12es+8sABiUGCp/96bIYK0IvzYiLOkjOC4ItTN3ZIg+38TAl4luVFMSe5YE0CRSD1gC1FkCtvG4CTAZbSxb88Nf096f4xNb5h5ruRDSwVjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 06:50:45 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:50:44 +0000
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
Subject: [PATCH v2 3/3] media: amphion: Remove lock in s_ctrl callback
Date: Thu, 25 Apr 2024 15:50:11 +0900
Message-ID: <20240425065011.105915-3-ming.qian@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 69330978-63b0-474d-919b-08dc64f407e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HhqIhHaTA3hhTyr0Jkf++OuXmaBB9c+cbiBk8XC0pxgSEVIwVJotDb9DWYOM?=
 =?us-ascii?Q?eZeWyaQPqnSi/7zrhc86c1iJFJB39M0J9z5BHCBMzqS+pHTGlz4BuAavKSB0?=
 =?us-ascii?Q?FA6kaSvEIjsj2fg1B38kxSVldkt0vv75VkDyP17XudMwqual8rIdN8AGV8Zq?=
 =?us-ascii?Q?GAFkr9vFwUdKI7srx71VMF8BCy90xwicU6r3yMyTHNgM5twDIQRTguiaX7wB?=
 =?us-ascii?Q?+r9sZ96MHw5c5BVc4QEK2K+BwsDL/bHRvsgYXr5Kfb8m1Z3/HYnxbNVPI9Ph?=
 =?us-ascii?Q?5TMxMLgs6PYueROlK0Gt3u4HsmseN0hay1iStCQqmUSrcVix4gjQES+RM/Yg?=
 =?us-ascii?Q?Dd156NOsn9ztZRfadwo0Krg9CKWRAj2g4dOqnXnRNy4hkdQwXw6s3IagQbyq?=
 =?us-ascii?Q?j6YYSxTWbGzH4s/3J8ipxQTM9mtvgrgJTXKLuyEjPySx+crl7z0d7Ho0keTG?=
 =?us-ascii?Q?HErgql1atAlGCHyFLIFWObd2VvfuhsMAZlolupAYKHpJIhTsEYkwUGn7o0tX?=
 =?us-ascii?Q?EdqV4WuW3aQ0CfsfMluRfEOSYZ7s0Nke3mCj6uV4fk7t3GDeH2WA8JuzKPLZ?=
 =?us-ascii?Q?VVK/Ui9bHfFYjPlNDdB41mvGSjJGBhKiyLeFW9SWObS4zPJtua2pdSjF+1bY?=
 =?us-ascii?Q?WENl0YdPsxrpOTAPiMdkuFMkqxJs6hcP7aB3RWLM6R2cUOJxpZ+jpUwXD8R2?=
 =?us-ascii?Q?lVHOQitfcPslIy4p08Vd2dyFBDRMwnhKcprTXsrOLHAybBKo4nHn/T2kPkOQ?=
 =?us-ascii?Q?x4T9twGw0aF475Hr9FVlHoGiwDZl8/3VRcARJBfUSVDQswARjdSrcNRZbs1n?=
 =?us-ascii?Q?iOV7l2YNlXOX9Ou9a3YhQMmujSPv6Dysybv9jM8YROxcStu8Jr+muTT4MROR?=
 =?us-ascii?Q?WJYRa7UUWVZ09/uA8lcW2DDxUXnMi4T31vKIkYF2xY5tr3cCbedQ1P/qNb8F?=
 =?us-ascii?Q?WCeVCgrtYeyUM5zE2Jiq31Szob6woIsuZjRYKIg3rIDw+Rn9ejRuxnm0FH6j?=
 =?us-ascii?Q?l5qUVmOx0ouQ50w5qPBZEYlO17GKDE5xNS53hJE8pn3ioBle+Vyz0xW87kFm?=
 =?us-ascii?Q?haLWydKvu5fFUbsW+3i0yGCLZ/o6Ux+lZUnByB3juFcPMgEMp3a0YkVKm/ik?=
 =?us-ascii?Q?lZAVFwcet688tkSSt5gPUlge4OVzzi+Lu5Dnig6E2XPR4mGt8lt2gxyPqs0O?=
 =?us-ascii?Q?oK14oPjHrh4i2z1kjfsw8haLx8FWH/m4hDqrEstF7EqGgFhe17CggYvxxcd6?=
 =?us-ascii?Q?Tzhz/X8lINoYGo1fORewiGmxIs//OtslY+9mCAoiS2tXtml/8Q0MRYLFi39t?=
 =?us-ascii?Q?Zi5KY2uMQRrH3pMdGsTbBVUSJ3BYnSzpI4YSE6c5o+t1vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?doSxjQKkZGZq18Y98sAjyxEuonUECT7u19kWVzzl3cvRYto/6oUi2uT5tkRc?=
 =?us-ascii?Q?3ntS7mjhZvgZjtSt5E/U0GiKnjMGnH5Kwy8V/FmRXFkEPc8kS0f5q/mZwAFp?=
 =?us-ascii?Q?XsygYCW1IdfgwrWhrf2U6R2tlj9pm1C+LlqGPhFs7qLauT/oyr+Do3GijHCw?=
 =?us-ascii?Q?ELljnRFOB3OV0mtYCc7mMpsJSulE2s8+yU3CoeCNXZQ24TlBk9XAWoK+WKXa?=
 =?us-ascii?Q?HzO8UNsQFcWBtioQGXqdcN6s33Z6awgT+Dvzrom8HSe6nnnjDoXTd4hLe4nc?=
 =?us-ascii?Q?s0tRWSGBrrNs92phYZwDUgYWli2LgUvh6MJfmCE2fE3+CY+aVKPER3zUkRJv?=
 =?us-ascii?Q?Xn/8OMhi8IzanC5fR5dOSgPtdcwr8/xKsGaXPCzR2hwbP4xiwWY5tqZE2/B/?=
 =?us-ascii?Q?cbpO1wBllu7AmA2fs9U4DaoccJONX1tS/BSuabv7uVKlmDEa0uYEK0nXDSRL?=
 =?us-ascii?Q?Ajue8tZdTCk3iSE7Jj/JIr1SFFDbR//l4ndrnkF/laJf5qigk5zCoTbAIq2d?=
 =?us-ascii?Q?q8p3cIBjEoxi3EefVXtzCi9uSNQMfky8zQwafQeAsKPQYtBM3UQzQWqOY8LM?=
 =?us-ascii?Q?FWxrDEDveop9Ht0Xp4YS3LbkV8Nbl2vr1tVD8AJAE1vk/xOYv02nbVlrDPMB?=
 =?us-ascii?Q?VVfQrmXyHhbiCrmSsAvxQvzvcVZr75sOSJRURoKtcFJ9Kt478ORsuITeBlrC?=
 =?us-ascii?Q?A+4Mok+snMBgy/OYPj9jp/FsN/FwfEi6iBtg/xw/wkfpHVkzhFRtwj0rjkxQ?=
 =?us-ascii?Q?Vw8pS0SiuKmlap5gcGEwbnREPEJW8ij+V0j1dJl33HSRAj857fU65woA8o3r?=
 =?us-ascii?Q?NdSTxUTdBi2S4lRUbyzbwm1c1ghOpdgnArWfa5Pire49gUvhCtbaJUnxU6kB?=
 =?us-ascii?Q?SDcd3BamkhY1a2nbq0+wrdD0vjWTr5n0Rdrjf/qcJev49+H/HvBKonkRoToq?=
 =?us-ascii?Q?pZKu6hhy+u7mgpO9LD/BJg5KC9/JWWSgiJ5CWrh5uTJT5bKXqvK1h6KSSvyc?=
 =?us-ascii?Q?aWnGoeGUanqwpyhwGDq8YijM91VPKJLIH2H8eGblRUMHleystIzhaTvxhSZH?=
 =?us-ascii?Q?hthNAniT42bTKausvBAAMe82cewTAxD5ecM4urtdmQ7TLaiW73POWuT0Zktd?=
 =?us-ascii?Q?vgcCbwYc81tpu9fFBZAhOhNzv1n9KOyJ/ahd1xa3ZvihJXE55eXbj6KIiYHR?=
 =?us-ascii?Q?HlnE9+RitJOLozTHgWmefdleFEwjd3S7W05VZxzDQGmFUdDkNW3uZVC1dFfE?=
 =?us-ascii?Q?pKg6IblNdIJVMUylS8ObqqLwWZKbv8F+bHG/p53LVg37++xWt/LF4UbOM7vY?=
 =?us-ascii?Q?6UHdifXYYmPcJ9QIc28sNXBvHJv0gzCIF4kAmJC4vUuRHZTUzB7MqKUOS7HY?=
 =?us-ascii?Q?3YMx/Wxk4ICxiqARHNSdkoVA3CuPMKQyANY+SpoLmGwkYVvtYYG4l0x/s38o?=
 =?us-ascii?Q?boKpwIa+LNFiWBYWDon369swaOqu2zMbXJ9AVaznB8BwnBFc+7qXn7bQfohz?=
 =?us-ascii?Q?RepY+IrPdEUBKwMrhLn1Di7ILQCtS965EjblmpUzPQukFGkUN+ulsR2IWSmm?=
 =?us-ascii?Q?Vy9KIP+0Yn24dlHrZTtriY9qUUmANniAcEfDqJep?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69330978-63b0-474d-919b-08dc64f407e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:50:44.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNDMdHRUTm4vGvbJ0xhqrfmaoNUVXyYGK0KH3HjvBotEulBCsWyAC2aZS2uK179lbb/RBHnSHzsiXW4UmNLuCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564

There is no need to add lock in s_ctrl callback, it has been
synchronized by the ctrl_handler's lock, otherwise it may led to
deadlock if driver call v4l2_ctrl_s_ctrl().

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 2 --
 drivers/media/platform/amphion/venc.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index a57f9f4f3b87..6a38a0fa0e2d 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -195,7 +195,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct vdec_t *vdec = inst->priv;
 	int ret = 0;
 
-	vpu_inst_lock(inst);
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE:
 		vdec->params.display_delay_enable = ctrl->val;
@@ -207,7 +206,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
 		ret = -EINVAL;
 		break;
 	}
-	vpu_inst_unlock(inst);
 
 	return ret;
 }
diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index cdfaba9d107b..351b4edc8742 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -518,7 +518,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct venc_t *venc = inst->priv;
 	int ret = 0;
 
-	vpu_inst_lock(inst);
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
 		venc->params.profile = ctrl->val;
@@ -579,7 +578,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 		ret = -EINVAL;
 		break;
 	}
-	vpu_inst_unlock(inst);
 
 	return ret;
 }
-- 
2.43.0-rc1


