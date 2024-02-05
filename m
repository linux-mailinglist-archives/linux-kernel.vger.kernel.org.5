Return-Path: <linux-kernel+bounces-52138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22A8849482
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482081F26B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A01118F;
	Mon,  5 Feb 2024 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nw3iPI2V"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2079.outbound.protection.outlook.com [40.107.103.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779111715;
	Mon,  5 Feb 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117993; cv=fail; b=BH0elNqg/U84BV7nd8HMZaNhbnaE8gmoYkZ4ndwH/CS+yX8RgB7GeI1Yk1Bm/pq/cSQV4OX6uX3yTUDwhjrJZsv6CA7FCdRke0judhz6xW9+WswKSg2aC7zxvvtZCk9vOhAFSh2RZtNwAWZAdikLpLxxz7vDGwGQt1YJLxlcIFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117993; c=relaxed/simple;
	bh=DKyKuhgJFcm2ZsKVbN9maEnu59UmHXHiH/PTdUHKGwk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FLTu1uWthG7C7JB8t230gJi1OOppwNYOB6cMHZSOKv5LiVcJrUHx/FJCNTEEmjTBvNCkjZrPABmaP+5Hq3PBElrYlJY/THYKk+j5JWw5fd/N8rIJ90b/MMDBOX0Z/T6VAGl+zXce7Tr/nXlZp/BYlFngb3MgAJ/a1DnJR+cv6Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nw3iPI2V; arc=fail smtp.client-ip=40.107.103.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7FWRhTYxIf0Ywvt7PXO6/fxfbknfv6HRdD/xWZm2KUbKs7VgL9ezzlZd+9BNTbrrcl/e4EW6RdGtqbQUrEDHIq1B8jmpbMVrkyQu4gw0XKDg9575U09wlGrb5A1wM/Za0LZLviCt2VvUorRd8eGduIPUk9PT9kTdDK/se+dukKjoHOxl5CUGUUwY3JMOQHgS+QRNEg+ZR/kLbC3rMgbK0zx7JkZFSSvTXkZmHNgHXnallLrugA0KfJYvLSXBxR6tES8aLco6NsxsPMYnSyvkcTWKlHD/XIwCXPgMUcn2xkK20RZKvMKSnz1+I387wxwqA5blwmNY5nKm6BmiUBfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrRIk2ZmcuHBO/ZjaF704N2O9wU9HcJ9zfCNODPuRzw=;
 b=F9bzWaNcoG8jIAgEFwNiSvE10YqzSqJl8CmSidx9X8BWZ+tZskZ6CLxgOcmitXBLPV8m8w1QByBo8SVCQ85CJ6NkuSEag6dcI24UIa/tuiGecTQDRTPJ6BlXTceS9oS7UfiF/pwhvT06BgsH9/0+5WPnqHvgdqhWtAGleYmYui3/dPbBtrNuCZUSuUdC4SywPEx+7JaPzkTF/WDIGsR2+gduc8DmZ4qf6MAOZU2my0dJ5OUaqzGzDrFB8p4HC7nNOeCMfcd+Af0N3WLnpGOYR+epL3BINw/pXTQdR67hCQBS0AieZoyQnbHU/ANUPmcgP2N3hASYsjTEjQL40UfrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrRIk2ZmcuHBO/ZjaF704N2O9wU9HcJ9zfCNODPuRzw=;
 b=Nw3iPI2V0/tS7h8pWjZZyl9ipTkhKtPMnC4hifFJRduDiwsvMDB15bzKLudJXO9l7EPlg1Q9oH854esetmZEXijnZbuiB9PFAx88ihv54v4n9WPNZ50dUvm7ebMvV6cF7yLTV1Ff247SrDyUBs+/SJ4uLTCN9jdqOc5oUcRHG1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 07:26:28 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::1a48:b74b:ee2c:d2e7]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::1a48:b74b:ee2c:d2e7%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 07:26:28 +0000
From: Ming Qian <ming.qian@nxp.com>
To: mchehab@kernel.org,
	mirela.rabulea@oss.nxp.com,
	hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	xiahong.bao@nxp.com,
	eagle.zhou@nxp.com,
	tao.jiang_2@nxp.com,
	ming.zhou@nxp.com,
	ming.qian@oss.nxp.com,
	linux-imx@nxp.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Support for negotiating bytesperline with client
Date: Mon,  5 Feb 2024 16:25:56 +0900
Message-ID: <20240205072556.804809-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.43.0-rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DB8PR04MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7908d6b0-9279-4a1f-74fc-08dc261bc491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Z9OnbQNulOAYMOhxBPzkWAOfajy5rCfCoi1Ck/0W1dlhzOsHd9g70Bom6udfJg9JAxKGVVpK8kzT8YTAtLA59T/zUrOnxi/goFskcibtEKk3isFWg92iRWagggPEyq1JQXcLf/ONonZDxK3jFZ7OdP4+UhbvCWPGWupGfdp+oIxWw+waTKKYVlQmKhRbAXphcsWNMiIrs56lMzdwu/+ax9lELnHUSuKKSivle5YAfAq0UVWLExe78B3fcQxWiPFa/HXE/i5p0zkePVNx0mpoB5ugDXTyJ3bKgWpPTcMQviZPF+L50OASPQCGkl5mGXXhMGQ+ni20eWFWV4pLM1qwWcMfccO8jyuBQGZsPXKSWHIlAvXcxrIqETCR61ucVGPEky+Ox/saqGmOjTvMEMu+n4jBldfdhxVVkb8fTbwiTq302OM3thqKUXzaRH/YVFndKXn7Rq4jLhoBCem6VAAI+QVQ/LjN5tNgVWstAzqcs/OrGKF/CmBrl/gthceBHrkLRuqTRSmWGwpzd6c297TnVBuYu1FqRFNJmfAlq+AW/dYiurvxJgG3XzYt8rVynAUnt015z2zVstfJN3gSsMtrBKSzXrF05bShTQZ98hYOO2hzxeCDzJotjMmZYL45J1f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(38350700005)(36756003)(2906002)(2616005)(478600001)(66946007)(66556008)(1076003)(6666004)(52116002)(6512007)(6506007)(6486002)(86362001)(44832011)(5660300002)(316002)(26005)(4326008)(8676002)(8936002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z82RBD2iR4iHgI4U5CnctB/qQNf3XxRUEb4nCSAk7HHWu4MU48+TBAgx/5Or?=
 =?us-ascii?Q?GpOb2gV+BkxxbVXRzJMEwNTaR/cfghi9a3FgbyD0CYrKmAFVgrDgliJDIOso?=
 =?us-ascii?Q?KOdGM5Uz58m9Mjk4XkwAasG+cqnChPIgQz8LTVyfdBbjRyqcEa59Ouz3Iv5j?=
 =?us-ascii?Q?WNShkHyG7bJjlbhwAPKjUe8Lmk3i6E35o4cIr/TkWQuciT830ICuvMlB2Cyr?=
 =?us-ascii?Q?du51gjwcK6461nJGaZu+MaxYlzSP4AfB8Zt2bPvZn37N8gQk1gY6ZUUcSie8?=
 =?us-ascii?Q?cet7bxh1nwPqFOcz5Hm1vTa7DpU2Xl6By3PVPZaQ4XakH+1q7+SsoZn40cg7?=
 =?us-ascii?Q?2nQDmRAnfU9cVb1Ga9YzTPaCdmo4t3acoQ49UCSG5zRGjKbP4ix29MdUC4Dd?=
 =?us-ascii?Q?U+XrGFiWObsLHBBnZfiRZetQYQ86ufFftq6tnCODv2IqiuHYmXucxjEhEx41?=
 =?us-ascii?Q?2Bu86b8H26ttk7Gx8CyACqkM5hgUO/zG8F4jEz6nV1TWgiPtAfc2ZAZ2dsNX?=
 =?us-ascii?Q?tXDeCsjp1bSTWa0nikrmWvME4jDJSKpKSFE00Lf8m4ZjsDG2YcadC2bdePy6?=
 =?us-ascii?Q?N1fprNHDmyemvNVXQY1LLwKCq3rIUUPpOI82TbFjkM+n9l1fs1N/BmaV1P2t?=
 =?us-ascii?Q?xMTmruNbjC4VF7K9AHzln6ah6nBtKNmH/Epc4YMQUOyCaxEEue2RTXmxBwfO?=
 =?us-ascii?Q?FakpXfc3PTxCn/r3IRZPyDJAe1MnDXDpoAf/SwDQPZ42ihXXyW2zBNDGeYHp?=
 =?us-ascii?Q?8x3wNIzDUVP9w4N/yAIf4NpeRbv54HHELPEF8v3RIio3LjKa/zxHj+WY1xoG?=
 =?us-ascii?Q?R70phOblqnFL8o3MmyWSYUtbpSe1KGeDVoSUG8SbYrmcAVSOYC67eSdXg0E8?=
 =?us-ascii?Q?bFk+T0RtqHN4cfz1dzJI5CsObCv9R8Tf4r2qhlgDi4k8rjvHnNMQFAro9qp1?=
 =?us-ascii?Q?zRKF6uC15VnmRbzJCI7fZqCZUshwbFpWnP9GCCKUK8rY3V5sIX2+gVysdpGK?=
 =?us-ascii?Q?kt3gLVeD2mozdAjE9sCZRBO00kvgd8arbxMNnYPvg9XefXQKKjV0yQdUpwy1?=
 =?us-ascii?Q?z/gp5Hh6c5QbFih5h+l11WlavAArx3P4z1ZvliGnkLTc988Y42KgFgpibm/U?=
 =?us-ascii?Q?1BAL8fQyXOZiv0rYefqybrm5pST0IUEIxL2ZihmIiH2R46opmry0a4JbYrmZ?=
 =?us-ascii?Q?AgBZCWujAGjY9reuOokwH7GkuhErVcsQqQMk+AMvrToZYYgkWRT7X+oUuY12?=
 =?us-ascii?Q?yZPnla9FvoCe1OKZJ1HQkVN4JI6tDqWk6HshuAH3Fiw6znUqTzNkKKuv3RtT?=
 =?us-ascii?Q?hB+qlA+r4n6ie/Nal3w0HuKzPzjJSjgLk2X7QhYCHMcNnwTy6Ay8/AdNb299?=
 =?us-ascii?Q?RkgjbgLt7NFfLjYZooICIiRNx3uaz+4aXsfyrQ5kAaliSYgHXIVDjOzykcwK?=
 =?us-ascii?Q?1n6RFMf14KTh+fsEKsCVdud6VOjYLzFTWQjnvKEmrT43JMdEsCSXQe1MZhtc?=
 =?us-ascii?Q?GOPIyb/uHZ0JFjz/Q/yIGb0QccsWeTv6C5oqtIGuBES9IZcMwMIMHfkFPzkx?=
 =?us-ascii?Q?cap+yV1c+LdVNucBVS8kkKvuJ/b5NbhHYhoaBMRV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7908d6b0-9279-4a1f-74fc-08dc261bc491
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 07:26:28.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Gq7SOlHC1EVNEEZ2wZMd6QAobpMhD/h3FDnRjr5Bl8lG+Fa6fgMqFR6/rrIwxIxtQ8+lMNfxwVAkj5KcXlRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7082

This mxc-jpeg driver doesn't allow the client to set the bytesperline,
but for some android cts case, it need to negotiate the bytesperline
between decoder and display, and fail the case if driver doesn't support
negotiating bytesperline

The jpegdec and jpegenc does support to set bytesperline which is
multiple of 2, and greater than the value calulated by driver.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 16 ++++++++++++++++
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 64112b63298c..cc97790ed30f 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1373,6 +1373,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		q_data_cap->crop.top = 0;
 		q_data_cap->crop.width = jpeg_src_buf->w;
 		q_data_cap->crop.height = jpeg_src_buf->h;
+		q_data_cap->bytesperline[0] = 0;
+		q_data_cap->bytesperline[1] = 0;
 
 		/*
 		 * align up the resolution for CAST IP,
@@ -1752,6 +1754,14 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
 
 static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
 {
+	u32 bytesperline[2];
+
+	bytesperline[0] = q->bytesperline[0];
+	bytesperline[1] = q->bytesperline[0];	/*imx-jpeg only support the same line pitch*/
+	v4l_bound_align_image(&bytesperline[0], 0, MXC_JPEG_MAX_LINE, 2,
+			      &bytesperline[1], 0, MXC_JPEG_MAX_LINE, 2,
+			      0);
+
 	/* Bytes distance between the leftmost pixels in two adjacent lines */
 	if (q->fmt->fourcc == V4L2_PIX_FMT_JPEG) {
 		/* bytesperline unused for compressed formats */
@@ -1775,6 +1785,12 @@ static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
 		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8);
 		q->bytesperline[1] = 0;
 	}
+
+	if (q->fmt->fourcc != V4L2_PIX_FMT_JPEG) {
+		q->bytesperline[0] = max(q->bytesperline[0], bytesperline[0]);
+		if (q->fmt->mem_planes > 1)
+			q->bytesperline[1] = max(q->bytesperline[1], bytesperline[1]);
+	}
 }
 
 static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index dc4afeeff5b6..86e324b21aed 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -22,6 +22,7 @@
 #define MXC_JPEG_MIN_HEIGHT		64
 #define MXC_JPEG_MAX_WIDTH		0x2000
 #define MXC_JPEG_MAX_HEIGHT		0x2000
+#define MXC_JPEG_MAX_LINE		0x8000
 #define MXC_JPEG_MAX_CFG_STREAM		0x1000
 #define MXC_JPEG_H_ALIGN		3
 #define MXC_JPEG_W_ALIGN		3
-- 
2.43.0-rc1


