Return-Path: <linux-kernel+bounces-163240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467AA8B678E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19AA1F22859
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB28A10A35;
	Tue, 30 Apr 2024 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="A2SGq7AA"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022018.outbound.protection.outlook.com [52.101.154.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D342BE65;
	Tue, 30 Apr 2024 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441160; cv=fail; b=PxppntSfK+qmxR0OaED7EkaqZWKyoYalJPuIjabkNkF5tulP6pXwbqzJ2H4eK09kE7TUkAlZi1jExxc7RPyBb9y0dcZVW6ZrrXBIuDl/Jg1gbROfgZylvD9R7sTkA9tbxKgzoF4Cux1M1PEwPoGIXHLTceXJ3/13h7fONTPEaRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441160; c=relaxed/simple;
	bh=xZjC5Ab4JmVwWF4Uog4CgivMX3blp6oRo08rwmQXU6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGjKc4twyVyiv/eukwqR4GjE3bCxF0lMF2i17ZxnvNexm198/K/4joajylY3JofF8ea+KKMLvzS6I7VwSul5IioTz6J86uexjdoGM3lau3xXhUXZW+ZUpSK5U532/wtHwNug0BBLJZ0NJsPD3yw+2yfO8UDz1vzDampE9lg0xTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=A2SGq7AA; arc=fail smtp.client-ip=52.101.154.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVIVCDb8+sz51do2PxMHAcEFZ6+sAb23ZMIbIQQKROGBKLj8CM8KAFLvcCfSI5B7Fhm4OqNGgG/KmXg/B2QydzeGljU+Bs867HhErf97bKLp2GcZzZfC0ZKB3Fsvtgam81rA+mCZVSCEUVzQLlEvO7OPFSLYKX5jm5cgSiO+0SRQ0hUn6odyWdWQ+lbXBhqC47dUUacHQQogoQ9CayKzQt02EarxEpIqWgWEXKpb5E03xUZwWKJkhnGfNX6mvMeohSuQbY8gROWy6Me8UaDwh+XW1reWuvLrpWr8LujYnH4a9K7P3vJ2QcOKzh1m/zUzNmmgWsmYZkaL4oD/LGGU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcO/zvPBzs7ZGOQScq+lMlN0ZObPQX4lYy5u7RowwwM=;
 b=lfyIc4WPVV8xDMLGzb/EVRowjzcA7T2WRHM71UFFwbKy3cVLT6nuCLAhVKfruFJVVnrXZK6B8jD7VE2T++ddBd4p5skOwURKMkO1ctLCrhDk//A/MNY0qJ0LCtjdJ0PupLFenxRxMno0pN/W28Cdhiw24YgWqbnZn0cdU+w+13e+WUymGeHMhbJaRg+kANl+aim3WB/miKSIH8jw20kf2Chb1nReI5nJSAOiJOBwUttHe1jG+8hmBf+BPpVcIgq0kKVeQ7XIemyvMxuH7YaRD6dxEJ76BVIrvLwYJCQ0ZXCG4RV0sDIpu/ag+/GO2oraiu9pSmuGj2A7/z/vs1aJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcO/zvPBzs7ZGOQScq+lMlN0ZObPQX4lYy5u7RowwwM=;
 b=A2SGq7AA9CxqHUjf6gmaBfK1pHueTI8xQN1iZJtjZ20TRupRrAnDYLZDfWUV2vZBh6Mpitqh6XwrUqdVmXk3QovqsdaxI81iROtpogCZsn7lMSKtXqy61iX/n5mCXxeckrOX/9SiQLCKJsY7ahdrpCdeTzIjQTF+K5BHnCP91x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 SL2P216MB2195.KORP216.PROD.OUTLOOK.COM (2603:1096:101:150::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Tue, 30 Apr 2024 01:39:10 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 01:39:10 +0000
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
Subject: [PATCH v3 2/4] media: chips-media: wave5: Support runtime suspend/resume
Date: Tue, 30 Apr 2024 10:38:58 +0900
Message-Id: <20240430013900.187-3-nas.chung@chipsnmedia.com>
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
X-MS-TrafficTypeDiagnostic: SL2P216MB1246:EE_|SL2P216MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1e57e3-cffa-47a5-9296-08dc68b6552f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bG2NKC2cEMykwWWqg29rtdWOFT9OkyQaXC5V/LyLDGHy8V1rTYjAmqzWTy34?=
 =?us-ascii?Q?Z02U0hsv2GaUT8YGCmWxZUwg2Z8Kb5NAK9HJ9bCbr9VP7lhx/IO7+2Lmrg6N?=
 =?us-ascii?Q?FbfV7zt6lry8zKnvCcXBcebfE+lRLBHxzuURrjrJiHHXN2lr/182P+BzziIF?=
 =?us-ascii?Q?bt2TZWWP5smg1oo6Ls+0bm4A2wSakp8LUw0bnUOuPmi0mxlDSnkGDBXKG7w1?=
 =?us-ascii?Q?JVqML4dBwzSuIOwiNvBfe8Rh9lKP0LPNq3QxObMDIUne9liP0cc+XuoXaepM?=
 =?us-ascii?Q?EzxKxpUqeUHins7bYAeo6sq7yNbqSDHcWMSiouWa5nnkk6mJ4TORKO3b77Lq?=
 =?us-ascii?Q?ztodqKEkeBHfKhU19YP3DnuFad+kyrz71aoIzroJCPB0y2kgxS/5Sv73HuqO?=
 =?us-ascii?Q?usfEjrH1etioWQo9yTuSzsLgnW7nT0kSab+yFXx3IwUpFHloyw+wnnZLpwua?=
 =?us-ascii?Q?L0msINsZsDCDFKldLT0slrLyUiyP+FFBUm+gwr1hgdA+4znl855hSufpewnj?=
 =?us-ascii?Q?TE2EeHQ9rh4xxLBKzgTDfQK0z2z6j7GVCgViIgIjSYtG/8R1HY1HWuzTO+jU?=
 =?us-ascii?Q?GXIyWQkNwDMY7iT+QMpSK/7Ga1Ji7CSDZqFrNAeKg3Soq8XA1+wSBwTIgG3a?=
 =?us-ascii?Q?I3pi3cfL2E4FcOrONZE/hzjSHlNuHqcdQn0DymRJa5qwtjtulCvC/hXdWJUV?=
 =?us-ascii?Q?RMDpFprAxdiq+w19h61qEOXUdf3BuYptXrB8EJbOwsM7siE1x7nbMGnbA+ly?=
 =?us-ascii?Q?ZP0XJiZxIv+04NnwSPP2tV0X7y7b1+5+io9H5G4SmZnIKSLKCg1a0IxK67qf?=
 =?us-ascii?Q?DsLuYlJDjkpBavhqRBTar+5NNh0WsqPQ7Jv1MpGuXRjtWeFEvLoQPx2lvZ9i?=
 =?us-ascii?Q?m2HQlWN/Enq99BW+pXJwFytvtg1lDcqRAnEz7YmsLsRkSEZGE0tk8OkFHIjw?=
 =?us-ascii?Q?U1qV8UbN2WmSROQv9OFPaCccbshUKAGW7yKjMaEKa+jAqbE21oXFDvkBjhjO?=
 =?us-ascii?Q?doRu34yI7ETxdFgjDYU9vIVllwRO3MyUN80wBvzzruxWy/tKLzjq2awwkACZ?=
 =?us-ascii?Q?fnr8moTkE/A3vx8s7kZW2FT+6OEfsNtCKxsNI0Y5gSBpxenEEM/Ky2orV6Ur?=
 =?us-ascii?Q?GhoSvmYqg4jsA6bhn2uGsv3SxVVQsa+Nl7m3KH+rO6sLpShgUrvesP/MKcIS?=
 =?us-ascii?Q?gXDrKtIKfdV1hmuKdNnQbpCCaLC6GdT4AW5lajwvJ42yMMlIp/q4YPMmzHj0?=
 =?us-ascii?Q?B6gL+W0FgwL9tDjLBK2NwFAVbIj6sA7k9CiZna5wZjrKvGFxyi4Vq9hJQJ2e?=
 =?us-ascii?Q?c4eY503iiP8pWNXYLZr3ia+jEtM5Dx9mqWP0Q1O/3wM9kQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GaNeQwMZFfXS+Jq+uJDW/nDcSpuO6dNgo8WfsYDs6grRPjFo74A2w882DGgc?=
 =?us-ascii?Q?nR61J8gTmOfRR5U00nPYCvDOjIeN/eCFDuCouOdFCs9Rf1pqD6zh3otHYoF7?=
 =?us-ascii?Q?oIURlajwjjSaGjwST/qdAKfG/TIoOKHE+nGn4y6TccL3LlozgKHkJqfurbYJ?=
 =?us-ascii?Q?KiBFjkPs6IyunUO6vx7Hpfstg3+i8xXfkfGFkOWGDm8H52ssuW8QXNQYbn/l?=
 =?us-ascii?Q?sspCQPpVvLXIKjGct+n4loDNFcTlwjMA6DI17MZC47TM5aRur/CwO5WDrTtI?=
 =?us-ascii?Q?k/DP9ut87istPb9REGBbmqyfYzEGPi+lWdQ6AwNSTDx8mTSljzT/yQtZxKWG?=
 =?us-ascii?Q?rf/JjxTQs89JGZH8ks2eyFlptUxLqCDdGRJY6xK8s7D9NP4xM3Q+4S5clHRh?=
 =?us-ascii?Q?/zHuGVGYCO0i7UqA3Wae/w2n2BAI3I4YOaw1+uvDdE3ZgyjBQPTvRohR+tOH?=
 =?us-ascii?Q?eCH2YQVqhlXLJ3fwUwndNQISA71YEqoIqfhCRpo9R+1ULSA/q2U4fQYqNqEe?=
 =?us-ascii?Q?hyjzoGZ5EYRmp/RK9vPi5E2vnZ1cE4wbZYTqPIYBrBchMCmEe99UkQXLkeBA?=
 =?us-ascii?Q?dfHkBCZf26Yo/lhXh1WhDZQX+/MRkJ6E4/RxuHbMX4ObJR5HtosSw1HX1c9y?=
 =?us-ascii?Q?R6A4eMwePx9rBgUFTitjb7uuf/QBNoSPu9ILgf5Dmyly/8h07/5C/F6BE+K/?=
 =?us-ascii?Q?eB4ovGUWXL9SjnIyYkvWnMur4FuPeJjw7lMA27TiZruJgVrL7PkDJzsUhWst?=
 =?us-ascii?Q?s75PBCNZHGCyRvl/hQ6lx9XtKaZjTUVGqkPD5T0VBYV+pHMWkiOcd6BdlQ2J?=
 =?us-ascii?Q?rA9DiH91O7v3hLINa4rvNAONovfQKO9wGdT+WQGiUeCk4aD22PMKk30eLQUi?=
 =?us-ascii?Q?ObkzUpZocPO7rYMF5IWxeguRh4qllwVc+H0VzXvp8mXhfOde/Qyqm+xBGsO/?=
 =?us-ascii?Q?VVReKFVeHwoLROzflrGypnzaHbDc/c1n25u9YOfekoZV29/HpdXv/p4g2DbQ?=
 =?us-ascii?Q?gtMutCS70EXexOQ2fmaYVSv1if87odYBu/U1u6YEcsObORb6obqrPJ3sXgqd?=
 =?us-ascii?Q?StXbwzi6FmYAEo6eplmjxn7aRGQw+U+SiGzyuMCQYA8cdrIIVD1nCKfjZ3Do?=
 =?us-ascii?Q?g/ckiGGxM3DW1OTiwNLpC3qCEnVYcyd5nKIMTLu6ScAEjycOBGxZ6ozY1ykv?=
 =?us-ascii?Q?Vdj0Cw2fCr2/QhpDZif9QvVIFS60J/UDrM2b6Du0SozlDY2aya0/7ZzbjpOr?=
 =?us-ascii?Q?1s9Q8CnCxw3MjcLEIkS/ViG8rIMBmYHKYRl+/TKmsJAdxT9S0fjBXLCQaxjF?=
 =?us-ascii?Q?EBUaZ97aD1gkBMdFy4p+NzpQPPYW2HJTnBIWL1iMCDbGA/UPJKBaW5HvH6ou?=
 =?us-ascii?Q?a3Bzsh+cJOPOmoLK+lw9CSTtlotgTP6LBTu19w7QAhilTwUAGj9PsD+hhU0L?=
 =?us-ascii?Q?D8YVRKVCamBXz6oYBoswbHeRV+mMZd9/QmKZTFye9YTzAsgMFPQCAYiSflSZ?=
 =?us-ascii?Q?v4s49y3VvhWanp2bUhTnWQwCdLBrjxHaqjYs+dpoCsP7yFnsCvfUr88hqG0u?=
 =?us-ascii?Q?1mB2EIgR/iYh8HGRLyfkdfl/mkv4BDUw9sRP+qG2+jz7q9j2KJpn9RXcMolO?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1e57e3-cffa-47a5-9296-08dc68b6552f
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:39:10.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vkprfPFO6326DNqCtb3Yy/EZzzuCefqMxIvdvKk6aaPXEpKeAs8mzUB0t0aY97uoVsGJtsVXtm82WPQlPfM5RuhLgYTpiblhsWMmlu2Q6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2195

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

Add support for runtime suspend/resume in the encoder and decoder. This is
achieved by saving the VPU state and powering it off while the VPU idle.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     |  4 +-
 .../chips-media/wave5/wave5-vpu-dec.c         | 16 ++++++-
 .../chips-media/wave5/wave5-vpu-enc.c         | 15 +++++++
 .../platform/chips-media/wave5/wave5-vpu.c    | 43 +++++++++++++++++++
 .../platform/chips-media/wave5/wave5-vpuapi.c | 14 ++++--
 .../media/platform/chips-media/wave5/wave5.h  |  3 ++
 6 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index fff6e66b66e4..791b1f0e3199 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -1084,8 +1084,8 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 	return setup_wave5_properties(dev);
 }
 
-static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
-				size_t size)
+int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
+			 size_t size)
 {
 	u32 reg_val;
 	struct vpu_buf *common_vb;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index c8624c681fa6..861a0664047c 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
 #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
@@ -518,6 +519,8 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 	if (q_status.report_queue_count == 0 &&
 	    (q_status.instance_queue_count == 0 || dec_info.sequence_changed)) {
 		dev_dbg(inst->dev->dev, "%s: finishing job.\n", __func__);
+		pm_runtime_mark_last_busy(inst->dev->dev);
+		pm_runtime_put_autosuspend(inst->dev->dev);
 		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
 	}
 }
@@ -1382,6 +1385,7 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 	int ret = 0;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
+	pm_runtime_resume_and_get(inst->dev->dev);
 
 	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
 
@@ -1425,13 +1429,15 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 			}
 		}
 	}
-
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	return ret;
 
 free_bitstream_vbuf:
 	wave5_vdi_free_dma_memory(inst->dev, &inst->bitstream_vbuf);
 return_buffers:
 	wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	return ret;
 }
 
@@ -1517,6 +1523,7 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 	bool check_cmd = TRUE;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
+	pm_runtime_resume_and_get(inst->dev->dev);
 
 	while (check_cmd) {
 		struct queue_status_info q_status;
@@ -1540,6 +1547,9 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 		streamoff_output(q);
 	else
 		streamoff_capture(q);
+
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 }
 
 static const struct vb2_ops wave5_vpu_dec_vb2_ops = {
@@ -1626,7 +1636,7 @@ static void wave5_vpu_dec_device_run(void *priv)
 	int ret = 0;
 
 	dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstream data", __func__);
-
+	pm_runtime_resume_and_get(inst->dev->dev);
 	ret = fill_ringbuffer(inst);
 	if (ret) {
 		dev_warn(inst->dev->dev, "Filling ring buffer failed\n");
@@ -1709,6 +1719,8 @@ static void wave5_vpu_dec_device_run(void *priv)
 
 finish_job_and_return:
 	dev_dbg(inst->dev->dev, "%s: leave and finish job", __func__);
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
 }
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index a23908011a39..703fd8d1c7da 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
 #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
@@ -1310,6 +1311,7 @@ static int wave5_vpu_enc_start_streaming(struct vb2_queue *q, unsigned int count
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
 	int ret = 0;
 
+	pm_runtime_resume_and_get(inst->dev->dev);
 	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
 
 	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
@@ -1364,9 +1366,13 @@ static int wave5_vpu_enc_start_streaming(struct vb2_queue *q, unsigned int count
 	if (ret)
 		goto return_buffers;
 
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	return 0;
 return_buffers:
 	wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	return ret;
 }
 
@@ -1408,6 +1414,7 @@ static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
 	 */
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
+	pm_runtime_resume_and_get(inst->dev->dev);
 
 	if (wave5_vpu_both_queues_are_streaming(inst))
 		switch_state(inst, VPU_INST_STATE_STOP);
@@ -1432,6 +1439,9 @@ static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
 		streamoff_output(inst, q);
 	else
 		streamoff_capture(inst, q);
+
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 }
 
 static const struct vb2_ops wave5_vpu_enc_vb2_ops = {
@@ -1478,6 +1488,7 @@ static void wave5_vpu_enc_device_run(void *priv)
 	u32 fail_res = 0;
 	int ret = 0;
 
+	pm_runtime_resume_and_get(inst->dev->dev);
 	switch (inst->state) {
 	case VPU_INST_STATE_PIC_RUN:
 		ret = start_encode(inst, &fail_res);
@@ -1491,6 +1502,8 @@ static void wave5_vpu_enc_device_run(void *priv)
 			break;
 		}
 		dev_dbg(inst->dev->dev, "%s: leave with active job", __func__);
+		pm_runtime_mark_last_busy(inst->dev->dev);
+		pm_runtime_put_autosuspend(inst->dev->dev);
 		return;
 	default:
 		WARN(1, "Execution of a job in state %s is invalid.\n",
@@ -1498,6 +1511,8 @@ static void wave5_vpu_enc_device_run(void *priv)
 		break;
 	}
 	dev_dbg(inst->dev->dev, "%s: leave and finish job", __func__);
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
 }
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 68a519ac412d..325e311cdedc 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
 #include "wave5-vpu.h"
 #include "wave5-regdefine.h"
 #include "wave5-vpuconfig.h"
@@ -145,6 +146,38 @@ static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
 	return 0;
 }
 
+static int wave5_pm_suspend(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	wave5_vpu_sleep_wake(dev, true, NULL, 0);
+	clk_bulk_disable_unprepare(vpu->num_clks, vpu->clks);
+
+	return 0;
+}
+
+static int wave5_pm_resume(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+	int ret = 0;
+
+	wave5_vpu_sleep_wake(dev, false, NULL, 0);
+	ret = clk_bulk_prepare_enable(vpu->num_clks, vpu->clks);
+	if (ret) {
+		dev_err(dev, "Enabling clocks, fail: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops wave5_pm_ops = {
+	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume, NULL)
+};
+
 static int wave5_vpu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -268,6 +301,12 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
 	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code);
 	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
+
 	return 0;
 
 err_enc_unreg:
@@ -295,6 +334,9 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 		hrtimer_cancel(&dev->hrtimer);
 	}
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
@@ -320,6 +362,7 @@ static struct platform_driver wave5_vpu_driver = {
 	.driver = {
 		.name = VPU_PLATFORM_DEVICE_NAME,
 		.of_match_table = of_match_ptr(wave5_dt_ids),
+		.pm = &wave5_pm_ops,
 		},
 	.probe = wave5_vpu_probe,
 	.remove_new = wave5_vpu_remove,
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index 1a3efb638dde..b0911fef232f 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bug.h>
+#include <linux/pm_runtime.h>
+#include <linux/delay.h>
 #include "wave5-vpuapi.h"
 #include "wave5-regdefine.h"
 #include "wave5.h"
@@ -200,9 +202,13 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 	if (!inst->codec_info)
 		return -EINVAL;
 
+	pm_runtime_resume_and_get(inst->dev->dev);
+
 	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync(inst->dev->dev);
 		return ret;
+	}
 
 	do {
 		ret = wave5_vpu_dec_finish_seq(inst, fail_res);
@@ -234,7 +240,7 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 
 unlock_and_return:
 	mutex_unlock(&vpu_dev->hw_lock);
-
+	pm_runtime_put_sync(inst->dev->dev);
 	return ret;
 }
 
@@ -702,6 +708,8 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 	if (!inst->codec_info)
 		return -EINVAL;
 
+	pm_runtime_resume_and_get(inst->dev->dev);
+
 	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
 	if (ret)
 		return ret;
@@ -733,9 +741,9 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 	}
 
 	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
-
 	mutex_unlock(&vpu_dev->hw_lock);
 
+	pm_runtime_put_sync(inst->dev->dev);
 	return 0;
 }
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5.h b/drivers/media/platform/chips-media/wave5/wave5.h
index 063028eccd3b..6125eff938a8 100644
--- a/drivers/media/platform/chips-media/wave5/wave5.h
+++ b/drivers/media/platform/chips-media/wave5/wave5.h
@@ -56,6 +56,9 @@ int wave5_vpu_get_version(struct vpu_device *vpu_dev, u32 *revision);
 
 int wave5_vpu_init(struct device *dev, u8 *fw, size_t size);
 
+int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
+			 size_t size);
+
 int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode);
 
 int wave5_vpu_build_up_dec_param(struct vpu_instance *inst, struct dec_open_param *param);
-- 
2.43.0


