Return-Path: <linux-kernel+bounces-72719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2A85B7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E770B26426
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6160F664DA;
	Tue, 20 Feb 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="nBtK1IhD"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8098664AD;
	Tue, 20 Feb 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422023; cv=fail; b=hO/QP+ubFv5vL865OfRiTH/NGzpgFvPyW6/8ZvjLkJb4EBO2bVPStQDa6LMyxvPnZzyfnD4F84HacbIvcOP7/4FkSksiVx1hXG0SRaEC3FlbxkFrMW/FP9gxlneSkkiDmkhMfqQQ48482qakUJUvnvHWScNb3S4nb608affNYSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422023; c=relaxed/simple;
	bh=GB4WBeer0yHTCcaF3Iic4k4romkbTfe6QlJh2+daQM8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=u9FS5Dj59f3biihsepX8ndNveHawzrtBHiJtpDIVtjoe2Pg88HpgOVcBYJieJXyvxyedfOToMlmQcsRcAz/wpMkzTS/byChoFoadZtlyvsHWDueucFLN2TOYJ3rCph/6Tmrh7tjo6NGu/FVVGMmpPixAeDSEagDmERVupVlt1Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=nBtK1IhD; arc=fail smtp.client-ip=40.107.21.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN47JydzJbdy2duF7sLkmZW/pB2zGe30Z2UC5hp70tixoBiOxnuRqnu3JY/sW90zLyQdjQ86/s+cnKKcxz33UM5Eu+VBGLj/cVGq5NoV/YChppJOKkny10ebv6pWPTwtM/R+ZVr+Np3wjXfFSH6ykPD2NKrRCO0smvAm3pjtT53vDsKgDFalkcD9WM8EXHItTyiXDTN2lZwLT1lCeU2/kdwiWliJJaZPJ0IKag0sfuoGaatQ1WQ11C4rThJcXJeP4sMTP3+tiCoVetTcxefwAKr3508CWvsZccMWFAarZKMjyZ+UYB66QIDBjhYHJKn7f+Bgp9/OJ6hExDDLDlIV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svcCWEqKTdaOLj7tlS28oJTep61vaANv4eUsOEJStv0=;
 b=c97x8K6rlKmzzV+hqBwR/rxXtwkXczHiV5pXcL9Sq/Fl86k3POcJ+WBYI2GLjTFzJ6Z+hqlED1SXvHSopoNERLXZLvpKBWlscrny88oVfcLp/XlbO+g+B5lNAacPVZP9kSf59vVPWmj0qqZpLfbFO+XyXnJX2K6MlBuV5IuR2+6uXZECqlvaqn+EYRIsUPdfH3Qx9khxVDcEYvUQ4MmVdFs7xPnDcr9SRCaoL6vcEYkow3G0ZcFvMnWOuPqYnsY6zbPgLO/CPdRE7wvPVpr0zqnZ7CULKXbf3dsebE9foyqHgSSd2f00sIXy0qP7RVEkju5wM/i5G6V4gJZLl0SFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svcCWEqKTdaOLj7tlS28oJTep61vaANv4eUsOEJStv0=;
 b=nBtK1IhDzsWkevBeMa1QI7aJBH1ciEIIGlR6d24I+QhovXVhK1/OExgsD1H8Mg/cBlr/ncLg3e6kshSlRL0bwod2ihcs7s8B65vp5MyPYmz8ulQjHDfVOyAYEezFe/l7eDWyr3gKGwgCD1NJwD/FcVEWazxmVVKIDEm76UKDjws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6763.eurprd08.prod.outlook.com (2603:10a6:10:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:40:18 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:40:18 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Tue, 20 Feb 2024 10:39:21 +0100
Subject: [PATCH 11/14] media: rockchip: cif: make scaler support variant
 specific
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-11-2680a1fa640b@wolfvision.net>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
To: Mehdi Djait <mehdi.djait.k@gmail.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=2344;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=GB4WBeer0yHTCcaF3Iic4k4romkbTfe6QlJh2+daQM8=;
 b=SHZ3lQBcHxWUyTWCGHGvLKxIwBok1VxgYrIGqHAVLuRY1y4GwI0PJHWEm1IfQXJaDX0D9YZXe
 i1ZfP/BQngWCxEWU7qdqcFsiY/HgrxawsbIi6uch1Kk2YHQjeRK2TX7
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=9ral3sulLe95bLcbaiNXTgUTRiBayRBEFZ5OVIEHp+0=
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a234b08-1930-4e5d-6b24-08dc31f7f2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b8JWzBPt2mAa2u+z/mMufM0zRJ7Py03CYd/Yc4MAHzTXnmziW3+ZjaFKfpY8HopE/A9TuoGJHz0jNwlkImv3R1o7onN2+NL+VTraO4q1KiumQM4oeoJqQDZ7Jy5dUK2b11tk+7mr6ey7dDHV2ZKFyV+HUyeW6xex61tpA6mUC4L1XjimlAXdX/R53Nhe60Ivlc0Kc6kpxaRE5rId3K0gAeJyV13WSGyeJgqWO8vkHhy99SmOxSfG5CgbUirhsOTBBFRFs6XGHk1vFJ1xP6JAA8+KcnoWxkCaWoJi3JpPgDqFu9jSfadVxNtnvDn21yhlmvyk9GyVrmPTKbfEY+synxcYkfx5IPNzwIod8PW9aPIcrhTZ9DuLL1pNC+cL2Y2bJFoXiqihzbNp3fNbZTuSAQhQexzVXrIBV/wMqGo6n1ev64wtiIfhA+Oxj+N3WrbhHt55l1YbpUL5rVKHE+LNDFnzZr7bgtbkjOai9NbJ1tAcViD7COvpvAj3PVXJ5qE87Fiyw5k8X0yebi7xhCxpODReg6yi7uHwkYdH+7f+DbxxyjrTotgPdSpJEXTia7bxDNtQN4jfNscDSGMzgPilhA4Xah6sg+MvIjOn5YBcNZbBoDs0PY/Uvwh9YXtnh+J4x0XMqJUci7JhaApRbeWohg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blpaT1B1TERZYXhDL2pJTXlOUG00b2hQeUtxQTNrNzNCRHdLdFlFN1E4dTk2?=
 =?utf-8?B?cmtZSDFhTm82Sm04T0RPbFlnM0lvS05kRHNpMlR3eVNncTAyTFk2T2paUlJz?=
 =?utf-8?B?dnhod3lpYStWR1dyTWdaOEVVa29OSUJ6aXBYclB1SVgwVWxyT2l0YXlSUnho?=
 =?utf-8?B?eEZQWU96WERFT1FYeU10cWUzWHFDVUdZM0NHU3RhWFNtdHB0aXNVbnVSbXQx?=
 =?utf-8?B?ZDBjNThYblM1NEpqTXdOTHdjK3BUYUQzS1lPM3hvRW14WXN4TUdScGJiZzdi?=
 =?utf-8?B?bVFTUlRHcVoyZG5icHNaUW9kbHJhRG9aRzcvZzRWSFl2czNxeG5BTUt1ZmFk?=
 =?utf-8?B?ZHBKc3Q0aWY4aEZPcVhxYTJjQUcxd0RBKys1S0lJVTVIVEdyc3dVcDhOdmdC?=
 =?utf-8?B?M1haZ3ErWHdVNzIxTU1wdEZNcnZCVVdLOHoxZTRoOWZTRjVOK0Rad21LVmlG?=
 =?utf-8?B?ZzFpZFZESjkvazRlTkh5L2ZCVFFjdENwZm9qU1BwOWlVTzhyRytXTDBsQnpK?=
 =?utf-8?B?c1BlNHdEQ3MwdGlzR0hpS1JmRkxQbkkzQVR0SFNZOGtwNW5TbTh4czQxUkNG?=
 =?utf-8?B?WlpNOUhRTXo1dTdhQ3F2QWNka0VyL1hDM0xNSDBXRURWNWZQaVk2eFd0WUZW?=
 =?utf-8?B?Mnd6RE8wdEExeFFhMThwOW5qU1VKdFR2WmdGMHN1VTI3Q1pTM3QwRGZOYm1Y?=
 =?utf-8?B?cnJXT2gwbmU5dnc0dEFlZ3FGT29nWlZod3p2L1kxVWxnWTJHbFhYZTIrZUNy?=
 =?utf-8?B?UmdpOGFUNFFTK0paK0xRTDQvcXpxWDA3cUVuT0Ztc3VtcFBnU014aThrTXU3?=
 =?utf-8?B?VTVFQUNuVmFRZ2k0UUJjM3NUdkZ0eDFRaDZSbFdhcE04MUIyZzJvL040aDkv?=
 =?utf-8?B?WnNPWFdDYURxdHhUYktVSVZKYmxFR0krS2pMRFpwT2ZaTW9xbFZLQ3JoanVn?=
 =?utf-8?B?SVF4dUZEbTdMYldkUDAvanZnMDRib3VSekluVlo0QXM4a1ZDRXFPaE4vN0Zl?=
 =?utf-8?B?UGhMY1c5b0puMm1nOURLYmVyZGlTUjJrdHczeWt2dnpOeUc2ajBWQjNGM09F?=
 =?utf-8?B?U1VENVdoQ0Njb3cwUFEwY1ptd25qZkc3c3Bpc21hamx5SzNVOFFZRXA0aWFl?=
 =?utf-8?B?UXpmWTNRWUFUKzduam1mSmt3b003a0xyYXg1VkV4cUthUElPREI0aUVtcVlt?=
 =?utf-8?B?eDZRVnBVNi81RjRtSjNwZzdaQVZnbXNDZ25OSzcxTzhIRGxNSmhNcXlFNTVy?=
 =?utf-8?B?YzdFb2I0V1RIR1pJL0lUaG1keW45V1RGRmRvSVVoTm5JYXNsNzR5K2p3WjNN?=
 =?utf-8?B?Tk55cTBnUVFoWVBHM1BZZjhsN3FNZGVEd3Vlc09oTWE3SEN3eExFczgvME02?=
 =?utf-8?B?azV6U0QzblJoVEpLQzNnSWVhWEJnN0NSQkRLVEpwbmxpTnVxRDNkL2Y0YStV?=
 =?utf-8?B?SXFaK2xNZ0NrcWFScW1LZG5EZ0RSUVpRQTNHeE0wS2dOZ2h3d1p5d1dvUjlI?=
 =?utf-8?B?N1NEZEt5NFgrS1Z2QTQ1bUlETmZ2MjgxTE1DSENJclhvZVRRNHlXOFdUYW1x?=
 =?utf-8?B?bVR3WTNMUHBESzgxeStzR2dlOCtBWTJRblIyTGtydVljN2VVa1UwY2FrRzN0?=
 =?utf-8?B?YnJPMEY5b3dEaUwyOVNRNXZrQXlFdlR0OEg3OVVNOXVPUW5wcEkwQjVSNWt4?=
 =?utf-8?B?Y0FWdGJzaGsya1grellVVmRPVjUzV0J4Uy9nckxBQisram8yWkNJMmptalYw?=
 =?utf-8?B?bjdIWlFBdFErRWhPUW9tZUtDVmNEUnV5VE0ybHl1SDgyemE1QmxRa2dlcm1q?=
 =?utf-8?B?aGI1N1NzMWU2M09XRnhaQ2RoTm1HN0VzZi80SEZVUlNKS3NxbCtpOXJmMmdT?=
 =?utf-8?B?ajN4YWxOeXhEU24zb2tqTmhxblNsS3BJYUs0UXBZZjh3L3Y0MVFnWmtXblcr?=
 =?utf-8?B?Y2s2b0pnenJ1SEhFR0lNNTJoRnd1VUJWTFl2bm03eHA3L3NwYThOMXp5Y3VM?=
 =?utf-8?B?bUJrVFdic1NXWDJiMENOUlpTWHBjWG9wRVlxbzRVVXFmNWlMK3VHOEtOblla?=
 =?utf-8?B?d0pnamVrZHg4L2VXTlBIUnAyYUhtcitCTWo4VFFucURyVmdZNjF6d2ExZTUx?=
 =?utf-8?B?MUYzeTNta0piTjVRbmY1cHAwYW5zUkloUHBmcC9WR1dtY2ZSUG91SmRPZmxu?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a234b08-1930-4e5d-6b24-08dc31f7f2fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:40:18.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv2d/9lCYFsPXsR/cp93EfQWyJrewqqE0Tk7TR35KsNYshZq5YvHSH6YzoU/lQ2pB6znpVbhMMVPm7DaKd8xr9rT2fvhiZwBaV/472BMTeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6763

Not all variants of the Rockchip CIF feature a scaler unit. Add
variant specific Boolean variable to account for this.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 drivers/media/platform/rockchip/cif/cif-capture.c | 8 +++++---
 drivers/media/platform/rockchip/cif/cif-common.h  | 1 +
 drivers/media/platform/rockchip/cif/cif-dev.c     | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/rockchip/cif/cif-capture.c b/drivers/media/platform/rockchip/cif/cif-capture.c
index b26e6023c2b0..dd5c45f28cdd 100644
--- a/drivers/media/platform/rockchip/cif/cif-capture.c
+++ b/drivers/media/platform/rockchip/cif/cif-capture.c
@@ -365,9 +365,11 @@ static int cif_stream_start(struct cif_stream *stream)
 
 	cif_write(cif_dev, CIF_FRAME_STATUS, CIF_FRAME_STAT_CLS);
 	cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_CLS);
-	cif_write(cif_dev, CIF_SCL_CTRL, (fmt_type == CIF_FMT_TYPE_YUV) ?
-					 CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS :
-					 CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS);
+	if (cif_dev->match_data->has_scaler)
+		cif_write(cif_dev, CIF_SCL_CTRL,
+			  (fmt_type == CIF_FMT_TYPE_YUV) ?
+				  CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS :
+				  CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS);
 
 	ret = cif_init_buffers(stream);
 	if (ret)
diff --git a/drivers/media/platform/rockchip/cif/cif-common.h b/drivers/media/platform/rockchip/cif/cif-common.h
index 84a7545422e1..e5500705eee2 100644
--- a/drivers/media/platform/rockchip/cif/cif-common.h
+++ b/drivers/media/platform/rockchip/cif/cif-common.h
@@ -100,6 +100,7 @@ struct cif_match_data {
 	const struct cif_input_fmt *in_fmts;
 	int in_fmts_num;
 	void (*grf_dvp_setup)(struct cif_device *cif_dev);
+	bool has_scaler;
 };
 
 struct cif_device {
diff --git a/drivers/media/platform/rockchip/cif/cif-dev.c b/drivers/media/platform/rockchip/cif/cif-dev.c
index fb80e8f8dcab..e7b5ae5804ca 100644
--- a/drivers/media/platform/rockchip/cif/cif-dev.c
+++ b/drivers/media/platform/rockchip/cif/cif-dev.c
@@ -282,6 +282,7 @@ static const struct cif_match_data px30_cif_match_data = {
 	.clks_num = ARRAY_SIZE(px30_cif_clks),
 	.in_fmts = px30_in_fmts,
 	.in_fmts_num = ARRAY_SIZE(px30_in_fmts),
+	.has_scaler = true,
 };
 
 static const struct of_device_id cif_plat_of_match[] = {

-- 
2.30.2


