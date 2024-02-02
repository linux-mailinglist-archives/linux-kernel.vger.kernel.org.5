Return-Path: <linux-kernel+bounces-49341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20CD8468F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ED11C254DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191617C6A;
	Fri,  2 Feb 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="GrqkZQIj"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2109.outbound.protection.outlook.com [40.107.128.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D61758D;
	Fri,  2 Feb 2024 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857463; cv=fail; b=SojVPvXM26z5fAXk3G1Vy26uClSqGf0E7OEh2tywPH46D6r8wtGqCI0Sr1ujGfeBhMfBkcSv8lWN96AOMq8hQDk1Eu+Ph+v34mHfVV7saQUtlIGxF9Bk78hFodUPE/hJxY13Py5Asnq/z/yfLdPoQlMXe9ub1GQRQdTmIZJ3Hbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857463; c=relaxed/simple;
	bh=JIhvGfNywtwdrHhM1QNneERXxrfgWpuWXUxJ8ff+Y5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inLpfY99PZ3dOjIowKdP7+cr6DK2OgQZkVIXhqIxELvNnsgvKwaeQ0ITmnd3C+W1Fl1rHamcY2XZInb8UnAzv8QFWLCE4evqU+y6rfRZKwfcL6OTZa+2PLv1+Fc2NclHCrge3W85oV9tlb/neJreCjqD6aONDIWEhXgdNVEWXk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=GrqkZQIj; arc=fail smtp.client-ip=40.107.128.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7YinEGEtpePtfJjIsUuAQWoHIKlJoabKB051iaYWhHnl7xcU7uSvbR5/qX2TEn+PjV9KjFkJf1T3fTDST6ikNWyNyoGU/v6i1mq/BwM0ZTSaNzkVfC5vRLW+3qlSME8BQqeI9fDL0vVGVwhFREDHeCAPT7w/fQSBTXEYxeUSRWJkkF14gftpMttbbbwEQ5sppi47WZNDHPxCqthlfUQkDcYLlmdMSdl+FbLl4cRuSCnsJPfWAqeE45HsMaX3Vl6BdELHhlfUNMKEi/po49Gpa2Gp98z54Gv0s8lp5zuGBvYqSvAYrv3L848nYBQ6XWRNGUYJt1gERitLdkF3GNGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJnQ/OS1RAiuGjD1AtU31iFg23nF99Sk/pxQkcLYO6Q=;
 b=CuqyG/8f96fGfFvnMHtjvfX0ChROj/waUEM4zMq26ZXpeSMu3KyErlL3EncY+Oq3j6A0p+i80YwNCF8fYDbdgYa/jrD4JqBMiaRfHPNfnvDF0GxVAhOTHckJ21nEaXloxdZe9kw+1bX6RvDdm2SLpNmPOjDyrWq9TITZaOyz6FtgjYoQKDOvl5UQJZaAjqUp7GlZWjki50NLGCpC38f92U50PxsgxUAN9flljmBG5cUzZ9K9St2RD9U50lCkFCutKi7yUfnwN/PrErpfvSCSGGwt4p7Tg3wxBDmTKMq8pAZa3AF2jrWDhWNCDtStvL//fvxbgz9SLMeRMSuO1YGhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJnQ/OS1RAiuGjD1AtU31iFg23nF99Sk/pxQkcLYO6Q=;
 b=GrqkZQIjHsjaa6FP6qtKeJhd9fdTc3Xhe3x07V+B+lQ93nL5flM66jNBzgDGjnSLboOLaOdQzfXmSwQJUDNaRBXOelA06O/0Q44cIhorrTTrWPkNit3FwXDokQxszE/9g3NMSn01QaMPu0JmlXkg1YMjRgTKTlWmy4okg15UqFI=
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
Subject: [PATCH v1 1/5] wave5 : Support yuv422 input format for encoder.
Date: Fri,  2 Feb 2024 16:03:48 +0900
Message-Id: <20240202070352.14307-2-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59260c35-ed3e-491a-259e-08dc23bd2a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o+7Ao9IJYHKxPRk4jd9PQr7TdOkoNYzL8HlmssnnRcgWE5n1JuEu9Xqgf2vUH6WxPugaH9WuyfNn7/dA6a3vLFCReR4O0ENYj1yXiHour9Z5H6Tl2ZNEHsZiQJ3sXmX7JDkzaWHUOB4ZzA3SNmPw7umJ+ymgZ9EBcQnzlq6mNR9CPtjAMsl01+us+emTPl7LdPLDyQWbGG3h9k/EPEB9V+dEAwCdeV1bkFOdoQzS05PJISWZALJa9O7iviGzwr2YdQkI1GBVFwNe0CQka5Xl+X1MBGkQ0GkjZr7069F1Fa6rb+T8N0TFTk6NrTekyBsKW017mDBTFJdniVE7NzZ/UdNxK/JI99Niua7qHWdsyOzRuRuqQm+JbBvelCYK39UGwAy3nlsRmrBKdSEukQGSoC2unqNcUkvgKw7KySbYcejj9r+1EJ43t6vl7KJk+vc3FHSZ6Jewy8AfQkVO5Y7U42DpHo87EftuXogjUtRGGui18bsXv26omBk1G0+dyJngKxjj/7E49IywXluV7MU0rPjFIswLP2X1CedxB0V988/80FbVEOROal0k2WZvXfHNzCtiPKuWzA4Pw/NbPvziuPyvDLKGkvsVsgx9XSLC90X485uNomnx1LdAiMUlUDh3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66476007)(41300700001)(66946007)(8936002)(8676002)(4326008)(5660300002)(2906002)(86362001)(6916009)(478600001)(38350700005)(36756003)(316002)(66556008)(6512007)(6506007)(52116002)(38100700002)(83380400001)(6486002)(6666004)(2616005)(107886003)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lVbBILO9MPy5pvVftWy3iaTXoTMYV2GCCpKnzMsrA7vRxVnsvWhPAux775sU?=
 =?us-ascii?Q?Qfr/iyo7sh0L1e7AG4by5Rtz2KCP7XB8q5zmXO9S/jAIK51U6sDo5rSV6YhY?=
 =?us-ascii?Q?RCGSwmrLxxOrNxHkTenT2p0ERwL4q6TT6G1vreySbzp2iVY25CxknG2QU324?=
 =?us-ascii?Q?sO5NnMt7+Pw50Oq+NwXDxoyyw/KQPry+wA3FSRb4inxAOn1V/U6OPRGIJJjl?=
 =?us-ascii?Q?fM4E4AKdXAkFVBTwh/KMPxfmLIRILt6yDYg4XbCt8hTnvTePWhS81OmnsIqB?=
 =?us-ascii?Q?IB65Ij3ZES7xqNe/sThKz6ZvmycLX2H8rh5U2CJneJ1zuyqitq1Z/BKeGhf0?=
 =?us-ascii?Q?zIq+R9LnT24p0HX7sPcFlrSUGB8gaxHzWxYlzSrzfiszvcYZFDC6n6lOge74?=
 =?us-ascii?Q?cTIcybRh7wGa1rX8Ne3p4uE7PEGK9JA4bfWlmr9Aiz+7hTJeI6gM7O5h0gs7?=
 =?us-ascii?Q?C1pJGFEkPaaMGRO4yMlqPDxrFtqhKCZS/T6+SS5Gnm6hZundwFH6R0wYWI8x?=
 =?us-ascii?Q?XGQfbfVKpbr+tc+tWed0A2+CHe6sNE5Sn37QQH368ci22cVFMnAPn5VSsUnz?=
 =?us-ascii?Q?oE4/KeVdB8JHqoAoKQjCH776Mqz3dctCekIKKdFhh0hc4MpRurlnvavw+w4p?=
 =?us-ascii?Q?Ii2fqHudXMo0SOaJKxNAbFXJiBkTGE7i7Hm0goQ2w8CcpWBt8JDTYTm2aFXP?=
 =?us-ascii?Q?Moqrc/Ph+TSdflkqqG0Xqoqy+AwMlrkH64dqA3jPvw+T15Ceq2F7+KKRDDi8?=
 =?us-ascii?Q?USkLaEv7nwxSQO2LC6zaD1UbyfmI9O8AuxZsZLaahjwShaY0C8u9+FnACKQz?=
 =?us-ascii?Q?kNIY4AuOQlcSq42vjr0MBUzBqwXnlFnagL1OxN/8PY51zchOVMgFGtALyXP1?=
 =?us-ascii?Q?b+nzuVuvsunUYUBVQURMnyLDYlqvCu9S2682zZF1/bwhOZ4H+TzaV+rISCRp?=
 =?us-ascii?Q?ADdoRXSy9t/+L6ZozyJ0t9lajV1P4BtiHspMwjI2Jly8JJPMtQlUMn+/NNHb?=
 =?us-ascii?Q?+uWu5WDBvbahDBmMow9sjBK3UW/BDji/w3V0A9Cq0KrHwQLTR95EwS/Ej6od?=
 =?us-ascii?Q?F0Iqa43KfbW9K33rgVndI/En6neE/Yz+4K0GNELTV1dyFsIebm4/o53mBO/w?=
 =?us-ascii?Q?Irf8SCP9uO1t6TYGNrP7RNscVSoW0NrXNfWfCiJDTbi0gokqQgtjNhjmdUqH?=
 =?us-ascii?Q?pL51OGqTLSnlsuNVuYaYpnulfzbnNDE0jTnrUjtddbIw/MyDtu+7lbNXs8PN?=
 =?us-ascii?Q?+UwxAhdBfvGIJXtRuY8Gh2qpxKJ9eHuVpcK/Z4/j10T+S21TLKb9UVUwuYbo?=
 =?us-ascii?Q?b9PlVy6CppwY6fnSO9L6AJECo2afJxEptbgPLdAqgU+Vt/cP/CWhaUOVbGm5?=
 =?us-ascii?Q?PGbQVQcsfjPBDvngqNNQiLCpibEtufHq+2OiYF0bmwk5sW9cfflQ8ZBy9mlb?=
 =?us-ascii?Q?BMWl0vFNjfLJTe+RrDoVVbi8yImeB6mCxNHbmFsLS6zgKw6DA0bkG1ABKo3w?=
 =?us-ascii?Q?ofJHVbxN2sd//pnJCC36RB2C5fMPZsQhsDivsQ+VoyBKveqZQy/x9dpINvLh?=
 =?us-ascii?Q?0G7Cvt6KVOtoAZGP7fBtJR156RuuUzl2NxyKfkVJTQw+IX9u02soCJGBxjig?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59260c35-ed3e-491a-259e-08dc23bd2a6b
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 07:04:14.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLmg4xrgM9umyduYPUVBiMoxW2hHxWOvMgf23tHvvTrnDMRMuHhfaTLT/8qjSk0Wd2DZ8JMit0/rCdeh5P+MKArOEgPq1bRDlEJa3WfF2jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1425

Encoder supports the following formats.
YUV422P, NV16, NV61, NV16M, NV61M

Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-enc.c         | 79 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f29cfa3af94a..0cb5bfb67258 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -70,6 +70,41 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
 			.max_height = W5_MAX_ENC_PIC_HEIGHT,
 			.min_height = W5_MIN_ENC_PIC_HEIGHT,
 		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422P,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16M,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61M,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
 	}
 };
 
@@ -136,6 +171,23 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
 		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
 		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 2;
 		break;
+	case V4L2_PIX_FMT_YUV422P:
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		pix_mp->width = width;
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 2;
+		break;
+	case V4L2_PIX_FMT_NV16M:
+	case V4L2_PIX_FMT_NV61M:
+		pix_mp->width = width;
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height;
+		break;
 	default:
 		pix_mp->width = width;
 		pix_mp->height = height;
@@ -155,11 +207,19 @@ static int start_encode(struct vpu_instance *inst, u32 *fail_res)
 	struct enc_param pic_param;
 	u32 stride = ALIGN(inst->dst_fmt.width, 32);
 	u32 luma_size = (stride * inst->dst_fmt.height);
-	u32 chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
+	u32 chroma_size;
 
 	memset(&pic_param, 0, sizeof(struct enc_param));
 	memset(&frame_buf, 0, sizeof(struct frame_buffer));
 
+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420M)
+		chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
+	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P)
+		chroma_size = ((stride) * (inst->dst_fmt.height / 2));
+	else
+		chroma_size = 0;
+
 	dst_buf = v4l2_m2m_next_dst_buf(m2m_ctx);
 	if (!dst_buf) {
 		dev_dbg(inst->dev->dev, "%s: No destination buffer found\n", __func__);
@@ -550,11 +610,15 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
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
@@ -1132,6 +1196,15 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 	u32 num_ctu_row = ALIGN(inst->dst_fmt.height, 64) / 64;
 	u32 num_mb_row = ALIGN(inst->dst_fmt.height, 16) / 16;
 
+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P ||
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


