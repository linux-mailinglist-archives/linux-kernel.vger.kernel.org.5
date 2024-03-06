Return-Path: <linux-kernel+bounces-93637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F8E8732A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15D128A7A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D055F561;
	Wed,  6 Mar 2024 09:35:11 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE6F5EE7B;
	Wed,  6 Mar 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717710; cv=fail; b=p6EDsA+ExbpXGp1vADhLDtOqn+93UMi7O18AjortqS6g8ZbK7/6mVLxLCww4dXgawsgCP41d/UwpLjxbW26GOzEcA7++i8N3zXdJVIOFfvjip3nL7cKmzuHVLw7kiDAun3/BZM2jWwXMQKiEle9mqfiHXN4nZYjMVbYEyJ1eTxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717710; c=relaxed/simple;
	bh=t/8lt0Pr+j3CoLNkrd0kChJLBkBwY8rlY79cPmxwmpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lkv45F45L4N6h+8nEXW0eQNggbZu4jduJ6Wf0pGD2URz8TEQk8qVjQLHUs+Zcgnhlw8+Ws0WSV4j00rHXl02/E7xFY5U3tA9K7wGvoaGi1fGwg/qpztEFeYL3NsNyZIdr1f5fVu3kPQE/oNLQfnkxDXG07BKQebXZAdFI43rMZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgH4DoXRHG7cbPcK3d+nVDHKFqu5KFuMhFFaiRuZBD6yOmLlgmf8ceUuFSCtDdyE8Phf5RPyNWaOjorq9OusgxuJTlyXs512oiwQOxchpErXdTI4IdXiyLXWZTkpmGKSljMlmukmnWXaPKbDpqvcl05T+fqYdPZYKl2u4u5wAVRh1LuGADiMBkVRt1pJxYOTr13EcI3rbtooeuI/cXmE1kHSGNntQXa8SMIGmx0kV6v2VKtHuBzwTgO57vNdspvEVkdxeYfo8KJv9GMpzY1ZueVcfFj/0F8bQBAYhyjOYADhctgOTqUQHAN7zSNePkbDav3aX9nKWuEgvqnNyawPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZwJCOce09A/wb0xiNcquqsX1G80AklZpIiCYsYxIGE=;
 b=B/IdvxDW1kLhCLTmSiB2W5W15DEPicJAwymna+RWcB9pMk3e//y7h7PYJ1+DR+j4uCAJfRovJfPvmRKK+VkkPIcUWTiIzw7mGaVoyUOCnn+CMmF3Oa25pE1Qty2h3mQRhs8MSalVgUXE6pHzwI5PaW0vsxgk01Xf1Xb8DAggYQaTEjHHBCJ0yXvILmRtoIj0uus+ksnbqTCX3u5gmWeI+QxL9kZ/D7e01E7kW4q6HAsORMR/5X+lDg3HShscRwU1bJMxNk7RxKBjWCFrqEmyjI3nbGvbeRLiwxQnk428hI7wJQrg4pHcIUu3Sy49fTK0TGlQ+JBzL+etvTBbRwcOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 09:33:49 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 09:33:49 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 6/7] staging: media: starfive: Add raw output stride configure
Date: Wed,  6 Mar 2024 01:33:33 -0800
Message-Id: <20240306093334.9321-7-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e03947-6e98-4c31-7764-08dc3dc08723
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1jhSHRMEYeyVmPMd46UyFxwO2x9XHeEIPyerq5FPUq5NKdAS2SWfXLTg8vcCTCm7DdpQvQAwgVoGVbIq1/AkX3s6cNgxhLZgE5V5yYvO/1GAilEeAV8WviSi5QbZL8E3DtbU4dfoe9GQ7oUpMx1Deg9xmH3b+oeyPLtdUfrOn0Yi4QiN+qYlmBgGntCpOIYXsetwdI96vMjZgIiYo+3gLzyb7UDy4HHAfjC4fmUqitnG4ZHtVhEe0JNSfpqGYoMij/VErQU0tFD4IjS/iGNnX3FVemb6/DqkKBH6nJXMMdQUst+7gqOOjBMBM5XyJYU41L9G0rgDxFyyfQpQHSknJQYU0Qq7rHz180Es7CqL66n60daXzgKLAMfzYKn0aOStCv0rnwD0G/WFfqHZww0J2hiloE5cAi5sSlCC6AJdEW+LbEequkY69+NQ4Q1Cg/2eW9ZxufBAB7AGy4h54zYMbmnksOMIoEBkaOMutP7Ti55U/Ytwf1gf5gnOcyQ2wzcksxJJt0Z8WwlLtL7o2Qx+LmpE+p4pFl38XsGp01E2On1oZRMWnjHeiAwonrMvIEum8xcaWzxGsk9Paz3vWoS6a3ltq3ZH0gpm116cMahpKU7uyqMQxPjKeNZ9W9BnIB0h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?inwLTePbVv6+60Sje4cJ+IK9nVa91tX4LJYG95RG4VpMKHNSBbF1BRHYeIsm?=
 =?us-ascii?Q?h84ITpWCERTPHTzOcbwZ0478XJSXdLth5pRbS3MsIx6yviJPUUqmJhiaZAyL?=
 =?us-ascii?Q?y6RNq3efC41Kezk74OK8FsxD945HMhJg53ZFBtte5BqGQP8xet60p4zfJWsT?=
 =?us-ascii?Q?vec9Z1zteJwz8Ac4ii+R8dtABQFy9RrqpQsK/RwTu6/DCGkZX1hHZV5DPrcz?=
 =?us-ascii?Q?j76uORkqwdwqT7k0PHTU/Ke7WLze7GMna1dNk2ATNswC0gvd1PFUw7s3CQFh?=
 =?us-ascii?Q?1P/NmHPTAAVif2GQNek9Eq1WftUtkY7byAq5/KLSzanjRMsZARU1MAMXls4W?=
 =?us-ascii?Q?OgkaWVIkj6jnYg/MO1zlg47DzsGDq538buSxnBH7h9k/39stFSaiq3qyDi6m?=
 =?us-ascii?Q?I19YeFQVHoHkGQoLbW+boGxbVyFGaB5omF6rc4vRjrVSTIajME5uUUJ0DU1i?=
 =?us-ascii?Q?BBDGSvnjye2QFzrWKH4KzHGIvGlxLeDAuBfGgXPjRyFuehGoiUloL/CBRi/j?=
 =?us-ascii?Q?xotrGZSfmL+r/YRX4A+0pkYize+1mULA3/k5PsD2kTMSxTXtdLsRdtl0macY?=
 =?us-ascii?Q?elQr+/dGit5hrCL3XDiKEHrSgGQFRirVNF/C7Z2vF0S2UKYmPNkBM+96JQ6l?=
 =?us-ascii?Q?l7BV/8A4z+kXYhsQxdHKna9S09Oeo9yGpZmzIOmn/LJwiEw/kC5Yus+Qcxze?=
 =?us-ascii?Q?JIDHWn+m/Dg7xZmL0KP4+jS/P7umCnZjNG4V4pk+dyi0pwyaU8c7DEaJUm6O?=
 =?us-ascii?Q?Uk4UbMbayeocaAXnLKC+Z3DEpKnrr3yAZjAEAmul7qn8Sw7GBNrmzGfON9bd?=
 =?us-ascii?Q?7YxX1QEB0KAp3EAAzIyJfn3LSWWlw4bGubQ4cY3oC4ai/7FblcJaMc7EB/PG?=
 =?us-ascii?Q?227l+97rTu6pQ8Ktm0CDztw/VemZXFrrdXRAECGY+3s6tcdEpHh9ADNDtg/K?=
 =?us-ascii?Q?P6J0di+68n2OEIxI36eRIkN03H3iKc4Ia+2zN67tVEtlSQulFaZBGQ6B36Bq?=
 =?us-ascii?Q?cvq9ydBlfLyos9wZcKK93EEn782tZEm+19BHjbNaFNcfuAqHm/3Ypl3GrIuf?=
 =?us-ascii?Q?00HmrAw0P6h5nyROMjWg036iUAVMjKVDvMwjLnG7gJEVAd231y+B9giBZ2hx?=
 =?us-ascii?Q?lQc4L+lTS0qrFv66uaDq3wdDJWTFc83X9OW0AuivJZVFkiO8NvKlodYS7Mbh?=
 =?us-ascii?Q?5P7dCoxlilXUW6l3ioiISkNvk76K9pepGeCXMOUBAQfENzvCDSoEpShfkqy+?=
 =?us-ascii?Q?J0FAXMwZjYvTAzd44QksYgIbYM6jYxSOxVLw/PseM/5lpphUwV15IfHyDXOl?=
 =?us-ascii?Q?18f//SojcH47AQs8hwvf9pxlXGL6ikaWufT1Qa2zj5MmQt+gNtGIbeZAOg4C?=
 =?us-ascii?Q?Ec9OENqQSC9qUxDHmkyjU3X73/55DoI6eN2mOFHQoouZEIZXSIJhpIIkYBaB?=
 =?us-ascii?Q?F2KFjpheFDzK7ROzPxo6r9fU5953mb0EsC/vxS40pgrPoF1VxJJuUIbHT68Q?=
 =?us-ascii?Q?9gZikAMLDpvHOuaJLw33BPFTPTzM4BKR/brL6XeUgGkh74Jwu1T1V4m2MNrf?=
 =?us-ascii?Q?nOyOXtVZZeLz/7xNMl1F4tTrQElPf8SNlDdHa1avNO6M3DQTQvjFBvZPdcj1?=
 =?us-ascii?Q?sZdTmIdpTUK65/27h70lbUU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e03947-6e98-4c31-7764-08dc3dc08723
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:33:49.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NktCT5QeRxFrP3hH8k1YJ5Vshuxq6yOQrnpPw+heCcqvYHj7BJj39x8ac8Iv1/q1yTIPkhXuNZVcCX7htftW1DmA9YHP7okf+TYP7sws0t1CFSJnOCHo5smmpw/bppfz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

Add raw output stride to enable sent the aligned raw data to memory.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-isp-hw-ops.c   | 13 +++++++++----
 drivers/staging/media/starfive/camss/stf-isp.c      | 11 ++++++++---
 drivers/staging/media/starfive/camss/stf-isp.h      |  4 ++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index b933d425cbd0..e7f60616bd7c 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -366,6 +366,15 @@ void stf_isp_config_yuv_out_stride(struct stf_isp_dev *isp_dev,
 	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_STRIDE, val);
 }
 
+void stf_isp_config_raw_out_stride(struct stf_isp_dev *isp_dev,
+				   u32 width, u8 bpp)
+{
+	u32 val = ALIGN(width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_128);
+
+	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DUMP_CFG_1,
+			  DUMP_BURST_LEN(3) | val);
+}
+
 static void stf_isp_config_raw_fmt(struct stfcamss *stfcamss, u32 mcode)
 {
 	u32 val, val1;
@@ -417,10 +426,6 @@ void stf_isp_settings(struct stf_isp_dev *isp_dev,
 	stf_isp_config_crop(stfcamss, crop);
 	stf_isp_config_raw_fmt(stfcamss, mcode);
 
-	stf_isp_reg_set_bit(stfcamss, ISP_REG_DUMP_CFG_1,
-			    DUMP_BURST_LEN_MASK | DUMP_SD_MASK,
-			    DUMP_BURST_LEN(3));
-
 	stf_isp_reg_write(stfcamss, ISP_REG_ITIIWSR,
 			  ITI_HSIZE(IMAGE_MAX_HEIGH) |
 			  ITI_WSIZE(IMAGE_MAX_WIDTH));
diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index 1bfd336b14a1..845446ba279c 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -78,18 +78,21 @@ int stf_isp_init(struct stfcamss *stfcamss)
 static int isp_set_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
-	const struct stf_isp_format_table *fmt_t_src;
-	struct v4l2_mbus_framefmt *fmt, *fmt_src;
+	const struct stf_isp_format_table *fmt_t_src, *fmt_t_raw;
+	struct v4l2_mbus_framefmt *fmt, *fmt_src, *fmt_raw;
 	struct v4l2_subdev_state *sd_state;
 	struct v4l2_rect *crop;
-	int src;
+	int src, raw;
 
 	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
 	fmt_t_src = &isp_dev->formats[STF_ISP_PAD_SRC];
+	fmt_t_raw = &isp_dev->formats[STF_ISP_PAD_SRC_RAW];
 	fmt = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SINK);
 	fmt_src = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SRC);
+	fmt_raw = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SRC_RAW);
 	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SINK);
 	src = stf_isp_g_index_by_mcode(fmt_t_src, fmt_src->code);
+	raw = stf_isp_g_index_by_mcode(fmt_t_raw, fmt_raw->code);
 
 	if (enable) {
 		if (!isp_dev->stream_count) {
@@ -98,6 +101,8 @@ static int isp_set_stream(struct v4l2_subdev *sd, int enable)
 			stf_isp_settings(isp_dev, crop, fmt->code);
 			stf_isp_config_yuv_out_stride(isp_dev, crop->width,
 						      fmt_t_src->fmts[src].bpp);
+			stf_isp_config_raw_out_stride(isp_dev, crop->width,
+						      fmt_t_raw->fmts[raw].bpp);
 			stf_isp_stream_set(isp_dev);
 
 			v4l2_subdev_call(isp_dev->source_subdev, video,
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 30e4eb29f077..dcbc42f0dfe4 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -76,8 +76,6 @@
 #define DUMP_SHT(n)				((n) << 20)
 #define DUMP_BURST_LEN(n)			((n) << 16)
 #define DUMP_SD(n)				((n) << 0)
-#define DUMP_BURST_LEN_MASK			GENMASK(17, 16)
-#define DUMP_SD_MASK				GENMASK(15, 0)
 
 #define ISP_REG_DEC_CFG				0x030
 #define DEC_V_KEEP(n)				((n) << 24)
@@ -424,6 +422,8 @@ void stf_isp_settings(struct stf_isp_dev *isp_dev,
 void stf_isp_stream_set(struct stf_isp_dev *isp_dev);
 void stf_isp_config_yuv_out_stride(struct stf_isp_dev *isp_dev,
 				   u32 width, u8 bpp);
+void stf_isp_config_raw_out_stride(struct stf_isp_dev *isp_dev,
+				   u32 width, u8 bpp);
 int stf_isp_init(struct stfcamss *stfcamss);
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
 int stf_isp_unregister(struct stf_isp_dev *isp_dev);
-- 
2.25.1


