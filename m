Return-Path: <linux-kernel+bounces-45592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AA18432C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A21628A13F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF1FBEA;
	Wed, 31 Jan 2024 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="ALxcm9Sd"
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2119.outbound.protection.outlook.com [40.107.129.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72CF79ED;
	Wed, 31 Jan 2024 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.129.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664670; cv=fail; b=CFBZ79QNoIsPxj6BJ4HsxzUq0XCTQp9coX9uFxww97S5BtZlFPIaiq+V1n8tTm121VNWIvz7aV6NRW0YpVNK60bAoNZmAu4dGH+kaCz3i6ljJ+hxmmLO1osnVnajcAUj05WZPHxcWT5yrCdd5TXvWLFRA5OD6ki6JlbX/E5ldC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664670; c=relaxed/simple;
	bh=6ddaxAQD+4sMxQ8F2S75ufc2/oaDz6ish+U6S4vf91w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOmyUD+I9JtCDcAYAjxsWdtmFPcZoa+TAYzdhK2F93hINmjXj2d/Fjpofj/ZMMs10L/7hhRk2N4G0Lk/474j1Rejk0+vGv0jTJhWG8xMeO4P0Iv1wfPBYyUIUQL/TyhdM3ZC7VpyyLfB62V9VmmwfAfXo7/8r6Q+8MU1NuOLWYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=ALxcm9Sd; arc=fail smtp.client-ip=40.107.129.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKn9330W62TO4Y/v10GxOuPb9AnzM52gIevupnbxQ2S0zgdvBVJ8G9Gyz9OQ538jobjnDEt9S/MjNuBDyTchzk8fDRkIoIZmemYBnEBenEgRqqH8YW/VC78Xl7E+ukwfhAum5hWkgkGX5Zun/QQpD4RTXEguA0b3j3MwpsmXH5QPmDuTDYHc7Nc7s4NksHcX5q2qa15c19Ars3B6EIVKCSHQSnmU7MYt7z1OoIPMa0rzEFO71SICvgutj5MkPa7DobLcHGLX9C0OuVEZ8MbwmjHzuV4FRhOxXe1JwcfUMvikamqNGAr2uaW/rK+0JnC1ZRMC4Y9Cr1H0Tqnd0GAcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj+2VmOeefx5Pw89ofh80JX8+KzzWrIoW692daLpmUE=;
 b=iCCF9hJdr3VcfEIFQIdm6ZFg/JIK+9jPuR45jmA0W0XqrB6nBN1hDUmPasPQk4hiC6yTVfIItMjLIQPBHlkmZviwLLDrNoS1FRNJnWB1OOqNjA5UGueSD9mjyuOrR3MSa5hS+/4XNWmiXq+zQMn27qjgXtECHzDwpZwPhZ+UtF2+52fKyvG4W4pluPa1csowIG2iUWISKhfoB6iB56GRPD7cWxqpSus4WV80tww9kK7VoDIqCSOYcbxkC/EGx2ataoYFh82gCWyEb8Sdzk2S9N0B3jm0P2J221upE/iHcn+5PnxENbp5j7GqklsDz6kQmD0jhs1PL0WOMItdA5m0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj+2VmOeefx5Pw89ofh80JX8+KzzWrIoW692daLpmUE=;
 b=ALxcm9SdDHMpBDXZgPjgIwC21ZCbh0Z72kF57GzkK676/y0sEy1yZvFcdBd/Hc2aS2GskJG2NUVQ2ZyCMybkdLMOfms0Itq9I9+c4QUdkmVcQyAW2bo4dA/7ef1TQgArjujoQym10klgoD1y4Q/52A794mcsayVqMR8AkDBhuMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB2229.KORP216.PROD.OUTLOOK.COM (2603:1096:301:131::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 01:30:56 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 01:30:56 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nas.chung@chipsnmedia.com
Cc: jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com
Subject: [RESEND PATCH v0 5/5] wave5 : Fixed the wrong buffer size formula.
Date: Wed, 31 Jan 2024 10:30:46 +0900
Message-Id: <20240131013046.15687-6-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0224.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::12) To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|PU4P216MB2229:EE_
X-MS-Office365-Filtering-Correlation-Id: 46241c42-de4f-4074-5efd-08dc21fc45a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AAK39TRug3ApHIkTXL4TEIT6xHUYUn6tZMCm/hPbvlSZJn2ufmsuUsc0SHm1aNeM1WiWZ2gL3hvh7Js7asYBFdb8nqk58Yq6CKn8BMXBl3wCa588GFSqRhBZpt/qK1i5zc3fLnpTGEoy9sW0PMeVPKF01sRVDy3RA9BlFPWKIVhKR1t5jqhKxkBMcojHZYnny+DuG+QfQVM2CqHK/oH2dKmCttLXhSHgi6sZHB8RRFhEhb0rB7aXaz9LkE1DPRhdw8lmrvHBouI1MxouwyyyTnMUd6qzkp4WhXOBgQq6B0QgZM9L8XzQktwYSxbqljkdP5sBj7Cv0A3m9UUOZ8lFB6ImcbHmyPqFM/Kxgip8BKWyMyd2kakFz95fi0lLEgiwi1o+L6d5u/BwjtndStb0BXN7kSMqiNDxph2hAtKImm/LKBjgoisYVeoi2ut/zAQtqmQQgP+JYZJR/qguDA7XIcfLAia8U8VFOXk6CltejZi/JISLoHiGk2a8hZujdqtgEnE4wwlhIMRwh+DNW/yIjpz5cfAH0c+GiWUyvrUbfWFh+PftJZjjp/pqlgjX8zJeGfbnxLIfOm3FFyWQQcqrPPE509chtYD0ZdGqEeRnJnVdgksFcHdOfdYZwfSyCruE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(6666004)(52116002)(2616005)(6506007)(316002)(6486002)(478600001)(86362001)(6636002)(66946007)(66556008)(66476007)(41300700001)(26005)(6512007)(1076003)(5660300002)(8936002)(4326008)(8676002)(38100700002)(2906002)(38350700005)(30864003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ud/cxG1F3rZPrmrlUJYrQCIPTkOl918MDxjbh20oswqcNK618xUoa+Y1urjA?=
 =?us-ascii?Q?bbY+B0OaoHMZKFcvqJa2EM/48EoEXQQXMy7Q5EhFFzbRQn8PYB2RXT5TTh4U?=
 =?us-ascii?Q?68tNXdpyI7JEJY5K89Rt7gxrf+ebUgijHOk37YcelBrz6WFydlfb54f1YVnh?=
 =?us-ascii?Q?KL83BcdRfDXYfQLu31g+e8EdwMvi1+EyeFs5zjDUt46/zyTyLkO6oy7RL/mT?=
 =?us-ascii?Q?HgFI+GT4DCyGUwGUQ8aUvmYeb7UcqWectz9pvm6nKsZNfR7CAUvZKaxMPFNv?=
 =?us-ascii?Q?m5J4dO4R2p132iv5N/VF47U+G5ST88360hR2KrTm37VBtLLpYqnNajzB2H6V?=
 =?us-ascii?Q?P5RrFgF2I1h7hWQGUL8lh6OaMMbEoEY4obdlhoDWvwkv316Sdf8AvRyfaE0k?=
 =?us-ascii?Q?/BcMmkJVNiuIvQurf0FGWv9huJ8lnt/peWxKq7+vVBb6MSE3h7WPEqqPvWDq?=
 =?us-ascii?Q?2OIoY2dCzgrC4EWZ6l9/AREsInExfS4fpKe/FzhGrEJLg3OD6AabirTcYVWk?=
 =?us-ascii?Q?seDAZg5XHdVKJ5aABn6PGRjubCveVRi1t0GP3oP70XkoSi2uJMd9KBihn91y?=
 =?us-ascii?Q?qrojKMajwFnbXX2SIwCBdNTuMrXKFuDUoTxzYKKPUmriA+rbZxaQy4QJYqh6?=
 =?us-ascii?Q?BQAzGzpVgoChcExN0kAXxKsk1BjC0GOjM4fKpJ3PgYeBMfjKnk8EeMjD0y28?=
 =?us-ascii?Q?wTtdBGg7VSg8OQQIX+9OLYJb7ntgJ7uH2NWxxjTT8lfrWB5tNmPB83wQNLgw?=
 =?us-ascii?Q?p/qmiksdNOxmoRYC6v5i64XOAX+0b4qKqNsfbAZQawTLPYt3C4fOVJ3M1Xx4?=
 =?us-ascii?Q?ahy1I62pfNIAfjVgdBYh+3CB0Fbo/PJcTcVn31u5FYrJT5nNf2M9b5LDYFGs?=
 =?us-ascii?Q?JVIVSmY/I6rB6/NQ0uSDYHI13o3kIyQVJyluzje7IZQtTUSd45Bkz2kwtNLg?=
 =?us-ascii?Q?uBSIjkIoRE089ewBGPD/JIgOyvjiPwfwx6QKy0er+FpWc7cZYnHxoJD6rsia?=
 =?us-ascii?Q?LqCjPMrlmR+UytTm+Zx597mc+Xlthb4y8yTZNWZ+amY4WKGp0o2eFYS8r4Wb?=
 =?us-ascii?Q?e/8vvyE1QI8sw1sclLSzMtW5G8vUqi/5a6m08Nau5gqox5yfoGHgkkc/+Pm6?=
 =?us-ascii?Q?rkUJDE/9f2lEmVbLLGv9h9WU32RG1BIDOUCdxSGiQHvHqYlpEVckMqB+StBP?=
 =?us-ascii?Q?Kq0McvIebHP4hOMswjszHlg7Lp3j1NYYks2NZ5fTwQiew4UjWbWmKcPgsvF2?=
 =?us-ascii?Q?pWIk2nK+HKihnCETs5pP+bstBRtyjwKg+5nbxoZdBxODrVeFVy7VmojVAvpN?=
 =?us-ascii?Q?vv+yyRuoBu2b+cA10GJNDyXwc2GofNVikx/by9j7ShD1GLT1mZbfaLx/xjol?=
 =?us-ascii?Q?y5Tgypxvg6IzfZ3xdICioPnqDPCiYXpP78cs+aldhybOT/8pQLAIhdFz9LSx?=
 =?us-ascii?Q?lglR+xOLj8Xz8ScxA68fCRhqm1lK1cR3CJdN95Y18BjbhNMKxNLsJv/ajmoB?=
 =?us-ascii?Q?hUPyUb01Zb3s44t5Sz3Q5MBXljAFqXOZbXxZWBE0KTOBrzMG+deOauhnW3Ov?=
 =?us-ascii?Q?yJLuECvpshvywhOpG3th9G0mvf1TlXhhy/RFoIZurfzh7/OoLDiOfqgKyvpA?=
 =?us-ascii?Q?Xh6kd7bg13gip2qL2OtugcM=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46241c42-de4f-4074-5efd-08dc21fc45a2
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 01:30:56.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xcdOcZMR3/h7de+uqZjKdcGfajgLsmTroSInJviyjOzNwCn5tFRMHPx1WPAy3qL9839EiaJV5MauQl8pJRLcb1mxSdBTYCZx/IhdQvvx00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2229

S_FMT/G_FMT should report the buffer size based on aligned width and height.
And, Host can set the real encoding size through s_selection and g_selection.
So, Driver should use the conf_win information for encoding size instead of size of S_FMT/G_FMT.

Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 77 +++++++------------
 .../chips-media/wave5/wave5-vpu-enc.c         | 77 +++++++++++--------
 2 files changed, 72 insertions(+), 82 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 328a7a8f26c5..fb9449908ebd 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -243,54 +243,54 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
 	case V4L2_PIX_FMT_NV21:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height * 3 / 2;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * 3 / 2;
 		break;
 	case V4L2_PIX_FMT_YUV422P:
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height * 2;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * 2;
 		break;
 	case V4L2_PIX_FMT_YUV420M:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = width * height / 4;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = width * height / 4;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 4;
+		pix_mp->plane_fmt[2].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[2].sizeimage = pix_mp->width * pix_mp->height / 4;
 		break;
 	case V4L2_PIX_FMT_NV12M:
 	case V4L2_PIX_FMT_NV21M:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = width * height / 2;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 2;
 		break;
 	case V4L2_PIX_FMT_YUV422M:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = width * height / 2;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = width * height / 2;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 2;
+		pix_mp->plane_fmt[2].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[2].sizeimage = pix_mp->width * pix_mp->height / 2;
 		break;
 	case V4L2_PIX_FMT_NV16M:
 	case V4L2_PIX_FMT_NV61M:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = width * height;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height;
 		break;
 	default:
 		pix_mp->width = width;
@@ -1003,6 +1003,7 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buff
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_pix_format_mplane inst_format =
 		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
+	unsigned int i;
 
 	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type: %u\n", __func__,
 		*num_buffers, *num_planes, q->type);
@@ -1016,31 +1017,9 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buff
 		if (*num_buffers < inst->fbc_buf_count)
 			*num_buffers = inst->fbc_buf_count;
 
-		if (*num_planes == 1) {
-			if (inst->output_format == FORMAT_422)
-				sizes[0] = inst_format.width * inst_format.height * 2;
-			else
-				sizes[0] = inst_format.width * inst_format.height * 3 / 2;
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
-		} else if (*num_planes == 2) {
-			sizes[0] = inst_format.width * inst_format.height;
-			if (inst->output_format == FORMAT_422)
-				sizes[1] = inst_format.width * inst_format.height;
-			else
-				sizes[1] = inst_format.width * inst_format.height / 2;
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
-				__func__, sizes[0], sizes[1]);
-		} else if (*num_planes == 3) {
-			sizes[0] = inst_format.width * inst_format.height;
-			if (inst->output_format == FORMAT_422) {
-				sizes[1] = inst_format.width * inst_format.height / 2;
-				sizes[2] = inst_format.width * inst_format.height / 2;
-			} else {
-				sizes[1] = inst_format.width * inst_format.height / 4;
-				sizes[2] = inst_format.width * inst_format.height / 4;
-			}
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2]: %u\n",
-				__func__, sizes[0], sizes[1], sizes[2]);
+		for (i = 0; i < *num_planes; i++) {
+			sizes[i] = inst_format.plane_fmt[i].sizeimage;
+			dev_dbg(inst->dev->dev, "%s: size[%u]: %u\n", __func__, i, sizes[i]);
 		}
 	}
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 19018ace41b6..762973d0677b 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -152,46 +152,46 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
 	case V4L2_PIX_FMT_YUV420:
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 3 / 2;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * 3 / 2;
 		break;
 	case V4L2_PIX_FMT_YUV420M:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 4;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = round_up(width, 32) * height / 4;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 4;
+		pix_mp->plane_fmt[2].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[2].sizeimage = pix_mp->width * pix_mp->height / 4;
 		break;
 	case V4L2_PIX_FMT_NV12M:
 	case V4L2_PIX_FMT_NV21M:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 2;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 2;
 		break;
 	case V4L2_PIX_FMT_YUV422P:
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 2;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * 2;
 		break;
 	case V4L2_PIX_FMT_NV16M:
 	case V4L2_PIX_FMT_NV61M:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height;
 		break;
 	default:
 		pix_mp->width = width;
@@ -638,6 +638,8 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
 	inst->xfer_func = f->fmt.pix_mp.xfer_func;
 
 	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp.height);
+	inst->conf_win.width = inst->dst_fmt.width;
+	inst->conf_win.height = inst->dst_fmt.height;
 
 	return 0;
 }
@@ -653,12 +655,17 @@ static int wave5_vpu_enc_g_selection(struct file *file, void *fh, struct v4l2_se
 	switch (s->target) {
 	case V4L2_SEL_TGT_CROP_DEFAULT:
 	case V4L2_SEL_TGT_CROP_BOUNDS:
-	case V4L2_SEL_TGT_CROP:
 		s->r.left = 0;
 		s->r.top = 0;
 		s->r.width = inst->dst_fmt.width;
 		s->r.height = inst->dst_fmt.height;
 		break;
+	case V4L2_SEL_TGT_CROP:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->conf_win.width;
+		s->r.height = inst->conf_win.height;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -681,8 +688,10 @@ static int wave5_vpu_enc_s_selection(struct file *file, void *fh, struct v4l2_se
 
 	s->r.left = 0;
 	s->r.top = 0;
-	s->r.width = inst->src_fmt.width;
-	s->r.height = inst->src_fmt.height;
+	s->r.width = min(s->r.width, inst->dst_fmt.width);
+	s->r.height = min(s->r.height, inst->dst_fmt.height);
+
+	inst->conf_win = s->r;
 
 	return 0;
 }
@@ -1229,8 +1238,8 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 	open_param->wave_param.lambda_scaling_enable = 1;
 
 	open_param->line_buf_int_en = true;
-	open_param->pic_width = inst->dst_fmt.width;
-	open_param->pic_height = inst->dst_fmt.height;
+	open_param->pic_width = inst->conf_win.width;
+	open_param->pic_height = inst->conf_win.height;
 	open_param->frame_rate_info = inst->frame_rate;
 	open_param->rc_enable = inst->rc_enable;
 	if (inst->rc_enable) {
@@ -1806,6 +1815,8 @@ static int wave5_vpu_open_enc(struct file *filp)
 	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
 
 	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
+	inst->conf_win.width = inst->dst_fmt.width;
+	inst->conf_win.height = inst->dst_fmt.height;
 	inst->colorspace = V4L2_COLORSPACE_REC709;
 	inst->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	inst->quantization = V4L2_QUANTIZATION_DEFAULT;
-- 
2.43.0


