Return-Path: <linux-kernel+bounces-138223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1063989EE42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1FF283669
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB42159588;
	Wed, 10 Apr 2024 09:10:56 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2130.outbound.protection.partner.outlook.cn [139.219.146.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A0158D99;
	Wed, 10 Apr 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740255; cv=fail; b=k6eGxaqrmAOhSUEbnnpLeJgWt62CU9hKWKfBXBKQqorsl6v34wOqrRV5/oFUcS+O7ZChihFKpcr5XPz8kNV5JHT8uWWqHGF7t7xo7xIkLIHvz6Jm6xenXYQq677Vt9bsSaEqpPEZrBbM1TepBCEMaJEq1MMQpgKzKTfBMEW6s9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740255; c=relaxed/simple;
	bh=z5RRqwGE7wNXht/3+kIt1k9RkZ4Q0l+HwFkJS5zp3Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUJisbx9ZsxjLAihFqUdWIdpcqczfSr3cTHJ6NodVtcKHdWQ9dOjLJLCqqxsG+MFXXBy5DbyQDaMXqupZPPoKgmoMJZSQVr0cEXbFX7dBvUySmcLnH3P540bO4oRqncJSbdiVRMEFxwp3v7vzv7RdBUL8wkF+W39DrdbtVkGT2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jhe+DRYPn3Lr0tp62CRz71/19/oac0W03G9goCNXNTGQxUyhvP/kLlDNxs0dryoQ6KBojtfqMINKOPbmyZjnPJXgxBpR+kaipWTJ67+yIwJFWoZlREEC+Go2ZUW9F0XeaGAP9NORtk9mBv6LQP/2a57lgA7u6XiNqCYtWdEaT2ngH/T+9mb2koetTkBN8uvpHmC5F4i5bjh5GO0CQ+cODt0yCR6+VMoDR53ielf5dv5J1ylS1hrAznqs3FxnnkTsW3N4K6XNsF1xs+BA1JWcSFYks/HpTZXny131Xzm2nRPVRJxPVyq/laL+F/0mM2P5f+yZ0GeHviTKDuZFDnW+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Iw810YQNx2yaZsOTC0egPyAnLZ2QJ2YQuyayR/5eBs=;
 b=bx0L7BwEDdllC66FyQCU5+VeX3fhULpq/Yvm7iKqcC00LG5Wbxd7NdFW9DyBpd3KVl6ENzgONtd2/YarFbFGYbyWFbvbMOa2CQavS5rMDHXN/b46ZR/RDuUdSKVP+ujxUsCtAE3Ck7QY65JGumaWawbqh1+SA9+MkQkAYt5bJadL6ZFmfUjFanpoXVTxfwjoMXfoiCezKM4tdMofKKfNW7NZnJko8vXdlkGlLVF0Zs1mWmf6dqKCXG7g5rPYz6O6fqT9wEHc4wXYTs9BpQi9y1MibcI7HmHLSAtXuGbkA/rED5to8x8otygJV3TmcCu6VnwOyyt5ZdXz1AJZGgVWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0461.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:41 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:41 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 7/8] staging: media: starfive: Move the struct media_pipeline position
Date: Wed, 10 Apr 2024 02:10:25 -0700
Message-Id: <20240410091026.50272-8-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
References: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0461:EE_
X-MS-Office365-Filtering-Correlation-Id: 674c8356-b30d-4ad2-3eb6-08dc593e18bc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dbb7xkIYzNe0FaHY8ZdwZ84/FJQ6jy10+8D1UewV2vuR9nzxOqzw8eqi5elof38cYTVtc+woPsLJN2d89k2W8dUerqJsu0q3h8EDVI9epqtL45d7oxLOoQnIb94aFn+D1Go5jgIneNLuQA1XKT8yUfq66kpeCCEvqVk8lDyct/PccZJ2CiX3j3M0r5wuDUkwNUYuGyYOEt/VoUavLmfMWErKTit3x2XIehgJZpWU5zdQcgIx5Hscou9hZntZgAmVotRw4juWX7TUZMcBL5gqBOr6ODJy138B3qBGxSSKpDXhjU2hwiqNahXrjOvJV3cLsgmqRaDREtXCxOBFQ8Pvb+/n6PikEccIeI2XWoIoc1K07RnG0oYrTU9M2KIoydXaYvOfM03v+y+LNY0im97m2h+QZrkamj0+DVV7adc8JxiS4D5O68RC5CtqzBmCfDuAdWVhXOwyMYJiblPjj51977lU2XtJ3+Oblo18Rg4FDsB0Y/UuKxAPD/XEU+XhL91d/ur2TD/jk3n+NHmAAebbWkFxvYZKIfNHaSffD/JL45AanzM4xtw7JX6BqKC6dwIdl+wZ0dL+Q2mHT3gOuFx09VccxCIMO/xlvncwxX9kzEfkO3LBNy5dk8gsST+rXdDA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/M72600xFXwg7rfnK837AYLinfK7gUso1FXYkPW3vPmqmcopARU+5BuKT8oG?=
 =?us-ascii?Q?CdWQj0d92yJlj/oO8GWLN0RWuSEbSwQ2mVTrAlPbGNtFrbvQAk5bcdspEUmB?=
 =?us-ascii?Q?r1cRkfYjYMkOXt29Uv3vLeb9AqxGJk52zN955UnyXRqpsb/g+RykSwv5XPq/?=
 =?us-ascii?Q?d0MwfWXKPaLtW3wa0R0/fsUSbniDpGcm0u2KqrkqDfru6Tcb/2Q9Cj7pZaW7?=
 =?us-ascii?Q?dxtOXp/4yArLxBDlTJDL/OeozTomHkpGxQlzl8owTu1HwgveJpofH9JQazqG?=
 =?us-ascii?Q?quEJMQkms7T4O56tSRAlri90eiy2xq0ka7IX7V7UQ8DdGyXtzazpInND0/Uw?=
 =?us-ascii?Q?xnliK1Y5F5ljfUCwEJfQGdj6KDrrPxhjPQbJpK4RlD48dfGgJj5c8dNKjgMz?=
 =?us-ascii?Q?hb4KXoYChngJeV/i0ntoGElGy1wLyyezam4ZfrVfDqsCN70V8kzFbA/Tba/h?=
 =?us-ascii?Q?J2OpAKKTvTabvnSJ9UguLrA56vQ+KqrWPaBd2bPyNyYNk3qyZWjXSosztHoD?=
 =?us-ascii?Q?d8B0PuJvAFSZWt48lwDXe6gAf3yhfRlhVzSq7JcepzqzthMAPd3Fu3D3d7Qu?=
 =?us-ascii?Q?LAmJeD6EC4fj393o1ngJn60mlq1rO0qw6DwTKhI9weFQT92UfWKPOOzLHmw/?=
 =?us-ascii?Q?JNqXaBmht9ROEeoCdCk/i6Vd0J2aAcvU+/GsVEF4YJf+Ia3arnsQC5qlX2NY?=
 =?us-ascii?Q?pxKwzR3DivBlFnY62XFiWtTmgru9xdAfdqPWGPZ1jN1ZcgDs+EvnocH+g2hs?=
 =?us-ascii?Q?eyUAMoGuXkYtJcCMJZqdhUpiBSWEiwEtynI7JWupMaYy57YmCzQYYXDKt6LD?=
 =?us-ascii?Q?fC6LwPHMNxQdU7Rz86ZAXaounApYQ3ZRDCbTfWxFl/RCnmrtTIrXcrUYkUZ3?=
 =?us-ascii?Q?4KHTxI9XWlhxERBb5U234f1ArX7ZdZT+8UKx0NIG5VzA/mglkOwkHNL36sPi?=
 =?us-ascii?Q?jencf93DS9hBbSAszm4/7iE6zvMfmwPKKmEny5OzSVYudJ+gLdhaEn2m2av6?=
 =?us-ascii?Q?gKeo/MhJRkYpmuMfzYVir9YwfnODHvaO2dEl0uj6ieFeC4WMwV4QeDfYCql3?=
 =?us-ascii?Q?TXb5HkxplnEEewUOLWGKvwPAFlcddT15N+8a/+vF3V1iDF9UtgdSL/NdsWJw?=
 =?us-ascii?Q?fbFz4gUmz9FyMx1WiyekotX6vukBIVoCc45PBMIWhNQ2KvV5yzFLVsDywb90?=
 =?us-ascii?Q?hBEzq8sJf0ZkK1sEF3HlfMuKluEAuJDGQORRQEODA54Stu/W3kzdp2qGOjAU?=
 =?us-ascii?Q?OHARSGruxDSUj/g5eARIfu7Po7+D3Jnio4y1YR71sMabERdYJ+mlQ4eU122w?=
 =?us-ascii?Q?Atdzv/y4KvgVBvyMgTDTPwAtuGxL86yJAfAYAf/+0imTeWmu0datt23FUW1y?=
 =?us-ascii?Q?WOPeRCzhPT3yJoCAq7qScXu5sSe0plY3MQGdLyAP7X7CUOobB1yihpPQYcZE?=
 =?us-ascii?Q?iK+OwXPEp0uEf6Uu/ZXBhlz8B9Pzfx/bhdmCgR47l5zBStJ0FO2J8Uo/Hn6J?=
 =?us-ascii?Q?/4gYils7yOuOsgXhbmINbyv3Fu3+V6ACYA/syikwtgHcraPNXYUT8xijjf6S?=
 =?us-ascii?Q?E7W1MYWtHRuRhPk/STp57NdgJ7Emu5wPYEr0Dv4lFNIiWA+AfnD87+kDRzkq?=
 =?us-ascii?Q?bLOfeyl5j/LRJ/Wip1aREAg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674c8356-b30d-4ad2-3eb6-08dc593e18bc
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:41.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yKFE53dFhThHLbyww0isgW6EX04zlUv1hBNyzFedwah3g4lp4O8aTdXbzvC/JC7AUptHB5Mf3hjv5ya4SUV06oA2XtrWkFmPc9qr6R2PKLcY0VFtahPfXWM3Ca/j8m/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0461

Different video capture devices have different media pipeline. The
media pipeline cannot be shared between the "struct stfcamss". Move
it into "struct stfcamss_video" so that each video capture device
has its own independent media pipeline.

Fixes: bba185d141b1 ("media: staging: media: starfive: camss: Add core driver")

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-camss.h | 1 -
 drivers/staging/media/starfive/camss/stf-video.c | 2 +-
 drivers/staging/media/starfive/camss/stf-video.h | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.h b/drivers/staging/media/starfive/camss/stf-camss.h
index 6b9215c92cfa..5fbac7e97eaf 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.h
+++ b/drivers/staging/media/starfive/camss/stf-camss.h
@@ -52,7 +52,6 @@ struct stf_isr_data {
 struct stfcamss {
 	struct v4l2_device v4l2_dev;
 	struct media_device media_dev;
-	struct media_pipeline pipe;
 	struct device *dev;
 	struct stf_isp_dev isp_dev;
 	unsigned int isp_stream;
diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index 69e3e4f9e56b..61d9d42fc5a0 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -280,7 +280,7 @@ static int video_start_streaming(struct vb2_queue *q, unsigned int count)
 	struct video_device *vdev = &video->vdev;
 	int ret;
 
-	ret = video_device_pipeline_start(vdev, &video->stfcamss->pipe);
+	ret = video_device_pipeline_start(vdev, &video->pipe);
 	if (ret < 0) {
 		dev_err(video->stfcamss->dev,
 			"Failed to media_pipeline_start: %d\n", ret);
diff --git a/drivers/staging/media/starfive/camss/stf-video.h b/drivers/staging/media/starfive/camss/stf-video.h
index ea7ec92c3ff5..0699c1716c2f 100644
--- a/drivers/staging/media/starfive/camss/stf-video.h
+++ b/drivers/staging/media/starfive/camss/stf-video.h
@@ -68,6 +68,7 @@ struct stfcamss_video {
 	struct vb2_queue vb2_q;
 	struct video_device vdev;
 	struct media_pad pad;
+	struct media_pipeline pipe;
 	struct v4l2_format active_fmt;
 	enum v4l2_buf_type type;
 	const struct stfcamss_video_ops *ops;
-- 
2.25.1


