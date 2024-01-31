Return-Path: <linux-kernel+bounces-45590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4658432C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392F41C2413C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF3C7492;
	Wed, 31 Jan 2024 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="JNjAVMi/"
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2119.outbound.protection.outlook.com [40.107.129.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F735221;
	Wed, 31 Jan 2024 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.129.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664665; cv=fail; b=MyRc8qn14jN7R6CBFbJwLM+Rc97h/jhXCEO5vW0Unv3DosnT5lh31crHKDWNmYBjpK/wT3ajZov23bKZiDPTcHsCVJHIkYNyp7vMNOWX1ZCPV7Rt17TF+Mum7783L88R9XN/9H477F+H2FUG3v5AWzvpPa87U3MRp0H8Gw/U2Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664665; c=relaxed/simple;
	bh=It89T/OCK0c4YrWvhqTPEL1//rjjpfiigp/1WxciMrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=suM067BUwpaDxo6M/kOkMpGIjjALDdcOFKYfFdmpfrKQG1ETjCQ3JWerwi5iEOCdCqhp7TAr597lBEKxakADvfwke4nGcK6U0Vf1Rr1FGyaI8jHwPwmcQi0aH6Nfwg9ISl/dJqfjkBsd4VNQZnTaNoXaH9vB7hrUsHTDEpSxY0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=JNjAVMi/; arc=fail smtp.client-ip=40.107.129.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm0stP0j4Aqe52+Qkwz320w4ucLBSakb06sGjiIeI9xPK/NL+XFmOzhfs4hfqtXoN+UUoA/u/Nb3JT3C0CsxCu1MT6fY3arCHHV5w5inHjGNIXaTkzkS4ccIP+gkv0XrODTi0YpLAFdgFRwgWaDksku88IvqsxKmT4kl9rkyo7RuGZOXPvOJFvWeM97ctgzgKlR/XVLqOzRdMMANyNNuTy+p3m0e0+NPDh+j2/q0F3jKSv3lKtmoJTowPgCfdRyfUM0rOaSo/kLdYZ/oWUmzJdNmSqxFCz/CtyvTVducAJ8VRk4spduhwPG4k5SUSkkozTFRbYu1WQ4or14U+p71wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1FYjVEimazUD4M4Ka9FO0ZhPmGOo7/M1aUDfxKQQGY=;
 b=MxajkYErIpy3hypzMxnHeW/l2U/rW+YQmQ6usPAIsYoIsm4KHnibCkMwWganlnjvhvfT0a3buqZv4DMbhDvL6ht40oxe5Mtmj9MR9DVXHTpKmwRdkZfDSzOcFDpjzunuLDQo/l97ZpTvearUpDDfrSxIEZZDQPT7R45BLcVD1JW/za3M7+5B0YDn8qvDyTQ/Ei6Q4FH6EorlQQ5W8q6wA+TlJjd3Ik2QuHTvnI7XVd64aLf3dNQmaHrJcUYFc3dPW3KPajfhrWrcU0cxw0vsryrIqGA+60IDQoH+2g5UFVJ9FHhF74+ifd4Ai5TDFl4fps8826iOs5EZAhS7wMmNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1FYjVEimazUD4M4Ka9FO0ZhPmGOo7/M1aUDfxKQQGY=;
 b=JNjAVMi/c7KKHnEY4Y18rWv/zzWT+LDtbHeJi9NfhpxkNorMU35hSPZy0qT58lt15lA7yqsNau724SwGINmvL2Gjyspd22EGD7P35mL9nbwoGWF4aUJK8sHymnehUYICs9epwkadkkETHQU8LRJKEALJriHVcnJo/AUNAeiM66U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB2229.KORP216.PROD.OUTLOOK.COM (2603:1096:301:131::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 01:30:55 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 01:30:55 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nas.chung@chipsnmedia.com
Cc: jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com
Subject: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
Date: Wed, 31 Jan 2024 10:30:44 +0900
Message-Id: <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3241f235-97b9-42ae-6a4a-08dc21fc44d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KTIyerzzR5Z3rLd080agJQ+sJ9V4YR7ZWuUy8Uv2vYLs90Su/C+NtGQewjXtBBaxyitESdBjdDYNEUNAmOOyfEceLIRjkilZ4Xx7RWDEv7cH2PEksdVkQRmqIxrvbceVd6CihcSW8E4/SVKPo5lN4rOu58QpXVbniCDqVdI4QNybRoECdAoqnVQCmnqV7Es7eBr8XKCqG1eMFBy8f2mqgMntpSDL8x5flaoWvT705Fgr3AMGlQwWhXV/BcwSrtLrQb61SyJuCJzsGwOfWQoQxouEFHrwrEFGRErqCYtTmxCb7iHu31v++qdnEEf/cB7ypjgiD+WOLQ49ZfmGtQc9Pt58ZEX/Dth0xsKfD+9aLl9dLpwhfoY4pXnM313sSyFsyfxEbH1VUCQey63Qt7dG5/EwGDYVkSZa3myIYBEnGgK8/z7q9FIj0dboZxIA0Szpu+N3jtjPYcJLijF6FuOLvUKuJSk++47/OJSScTI0xVeFHE6qYdOEmfunIpn1cbzN4jGcQm4Sxt7iymyAyjaXVf4wgMT1z3rksyn4/TUKkIsk7c0xyyc6JHL+gtRlTUh9tkVQM7xYNNP1RUEZm52WUOj7cxilOad0HBE7VNqB8cikhDl2QfHkF+jydC2JFLCY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(6666004)(52116002)(2616005)(6506007)(316002)(6486002)(478600001)(86362001)(6636002)(66946007)(66556008)(66476007)(41300700001)(26005)(6512007)(1076003)(5660300002)(8936002)(4326008)(8676002)(38100700002)(2906002)(38350700005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w6hyyDLAKW/QLXOhCdwZ+gxOcykQcxbbCNMyvdnRiJ4JK4fg72bwuIb0dJwQ?=
 =?us-ascii?Q?3/o6sehMxTyZs/lSoJGxUMZ8QyV1HXKsDtUVfmL5Uy4KRPbLS7lsl6qu1z4a?=
 =?us-ascii?Q?PpSBZBvQNuMyl02xY70TFuFPcZ0GiEDzwjao5CtgQfvXuFcuj9xZDzw8CQwX?=
 =?us-ascii?Q?5qA6A4XZPRff2sToXWUCHQB3Mucl3O9wqQoeNobHzeEWZy1n+U24Yg09c6Dh?=
 =?us-ascii?Q?DLJ3V9uhk67dIIX+6SH3krM5fOejScr9R887h9gk87u+kqa+9FsKnFSak+89?=
 =?us-ascii?Q?+wFmDIPPw99zOOYRlYcnI2v/zHzZgJV7IpWKFq/HTy29yP74yarDPKEgXQZB?=
 =?us-ascii?Q?32U3MDTfW3zABYU6CkrTJ7+4Kpk/VrSzzgcTopBswhkE5pMF1KutkzSQG+WN?=
 =?us-ascii?Q?Y9x/wicCdt/Dvf87Wh3HIqJzWTUsYw1LkkpWHJa7qJWXSPYt3zXusieYuN0H?=
 =?us-ascii?Q?fTvDa+6qIBEMYuWePyEogZpSK7QQ4xTFZ4Z6zyJFTyF5Rd/0EXoSvkNIpo/l?=
 =?us-ascii?Q?kypbqbdlO4GDguoboYLXTlpZq9Rh76eBsXd+7Egr86PY+vilTqPPWIkeH0MQ?=
 =?us-ascii?Q?upniL4umv6Qc7hBbbpTHbfM/XWKH/3peLAgdyu+cC7kGaAg3PM3FEsq3FgxA?=
 =?us-ascii?Q?v9dDBFx7nY9YAs9/i/0BV3VTOZXyn67jS09HoajmM0KZdM0MHT3NvVozIMM7?=
 =?us-ascii?Q?Nx98X6Z/a4dYb2HM3cK9k6TLJah4hzttjuDvZ3upmW6z7KkDX8p5eD3+92BK?=
 =?us-ascii?Q?QH/8tbsA6gXxIJdr+SzX8S2B4o6tq5nBuovj1xll9sIUBhm9s85KkO0EW6K6?=
 =?us-ascii?Q?xfAUBe6+hSl8WNQyBjV7lnxKcpCe84mwfsH49YTXu2GJisSgwtPl5Rj4eg8W?=
 =?us-ascii?Q?QKhUhPP4/wtsWVslckL+ks2+l/PLPa7LbZA1epjpkvpccAEMnjbps0yZ31R5?=
 =?us-ascii?Q?r6fewxjDTSUmqOhe6mIgzYeaxAEkwMuzFLcGXxJaFK+T6JfigBlLdS042HI+?=
 =?us-ascii?Q?1sFZX3aEaLUk1RUk/BZU5L7ha8xyZU/GP6XsXkeshNUbA+mt14GwIq1T2iWL?=
 =?us-ascii?Q?GAGILtRhPuGFJp1RvFPFdSCxvVRwRr+Kydp60fnAzGGBs2SFyMd6jOHi/ON7?=
 =?us-ascii?Q?YsYRWFqRqCXQ8zepR6dyWc93T108yc2R4r7mXfbHXbSs8AxAyF6eyP21U51i?=
 =?us-ascii?Q?WFe8xc790KD0++Rs3lXz+6RwzxljG8frw8TGqX/AV4YVFBPpxasaI/jMbK7L?=
 =?us-ascii?Q?e9I5bCInfsr4ETCoK7tgHkAtDxvlcKBRSN9bIhpy4emNzvr+ndt8lcznriC/?=
 =?us-ascii?Q?5BqeR2jKMXAwedU1yEJlzC+QVYE0TwjM3S/yu22fYOQHI0FVqCHUQzqhrEen?=
 =?us-ascii?Q?6hOi/vQNk/8VeSs7Z8UHgjCYMXv/w7qU8dPRGD5axnWyNyELUSTZUc+hah2M?=
 =?us-ascii?Q?bX9DvgPle8hRczp3eUD9+Gg5IOtzYcUJbaqVZKbcb3nXFbdQK70RZK8CGHGk?=
 =?us-ascii?Q?+8riPs9LnKIw0jktaiZf9AXB72ebIR6q0l8CMzJBsqXK+vXOzwkxqzzyrIOA?=
 =?us-ascii?Q?1zSQ3sY5VWRTNWKwlgHCR+rCbjzRVJ9u93UeR1TqHkEabOwIzBkwAoQ5k1di?=
 =?us-ascii?Q?hILXV4dnHYecNe/4dH7x3hM=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3241f235-97b9-42ae-6a4a-08dc21fc44d1
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 01:30:55.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzUnYctPIIO59M6W1NvABeDJWBhK9srS6c44H+JK+4QmPQFhUmUhbvCYIlRhe2ZrZruXR6RuQb7/qmOyKpwF4xQoSx0+obPea9YoxYG7AHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2229

There are two device run-time PM callbacks defined in 'struct dev_pm_ops'
int (*runtime_suspend)(struct device *dev);
int (*runtime_resume)(struct device *dev);

Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     |  5 +-
 .../chips-media/wave5/wave5-vpu-dec.c         |  9 +++
 .../chips-media/wave5/wave5-vpu-enc.c         |  9 +++
 .../platform/chips-media/wave5/wave5-vpu.c    | 68 +++++++++++++++++++
 .../platform/chips-media/wave5/wave5-vpuapi.c |  7 ++
 .../media/platform/chips-media/wave5/wave5.h  |  3 +
 6 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index 8ad7f3a28ae1..8aade5a38439 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -503,6 +503,7 @@ int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
 	/* This register must be reset explicitly */
 	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
 	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, 0);
 
 	ret = send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL, NULL);
 	if (ret) {
@@ -1075,8 +1076,8 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
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
index ef227af72348..328a7a8f26c5 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
 #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
@@ -1387,9 +1388,17 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE && inst->state == VPU_INST_STATE_NONE) {
 		struct dec_open_param open_param;
+		int err = 0;
 
 		memset(&open_param, 0, sizeof(struct dec_open_param));
 
+		err = pm_runtime_resume_and_get(inst->dev->dev);
+		if (err) {
+			dev_err(inst->dev->dev, "decoder runtime resume failed %d\n", err);
+			ret = -EINVAL;
+			goto return_buffers;
+		}
+
 		ret = wave5_vpu_dec_allocate_ring_buffer(inst);
 		if (ret)
 			goto return_buffers;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 761775216cd4..ff73d69de41c 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
 #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
@@ -1387,9 +1388,17 @@ static int wave5_vpu_enc_start_streaming(struct vb2_queue *q, unsigned int count
 
 	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		struct enc_open_param open_param;
+		int err = 0;
 
 		memset(&open_param, 0, sizeof(struct enc_open_param));
 
+		err = pm_runtime_resume_and_get(inst->dev->dev);
+		if (err) {
+			dev_err(inst->dev->dev, "encoder runtime resume failed %d\n", err);
+			ret = -EINVAL;
+			goto return_buffers;
+		}
+
 		wave5_set_enc_openparam(&open_param, inst);
 
 		ret = wave5_vpu_enc_open(inst, &open_param);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 0d90b5820bef..f81409740a56 100644
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
@@ -117,6 +118,65 @@ static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
 	return 0;
 }
 
+static __maybe_unused int wave5_pm_suspend(struct device *dev)
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
+static __maybe_unused int wave5_pm_resume(struct device *dev)
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
+static __maybe_unused int wave5_suspend(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+	struct vpu_instance *inst;
+
+	list_for_each_entry(inst, &vpu->instances, list)
+		v4l2_m2m_suspend(inst->v4l2_m2m_dev);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static __maybe_unused int wave5_resume(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+	struct vpu_instance *inst;
+	int ret = 0;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
+
+	list_for_each_entry(inst, &vpu->instances, list)
+		v4l2_m2m_resume(inst->v4l2_m2m_dev);
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
@@ -232,6 +292,10 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
 	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code);
 	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
+
+	pm_runtime_enable(&pdev->dev);
+	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
+
 	return 0;
 
 err_enc_unreg:
@@ -254,6 +318,9 @@ static int wave5_vpu_remove(struct platform_device *pdev)
 {
 	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
@@ -281,6 +348,7 @@ static struct platform_driver wave5_vpu_driver = {
 	.driver = {
 		.name = VPU_PLATFORM_DEVICE_NAME,
 		.of_match_table = of_match_ptr(wave5_dt_ids),
+		.pm = &wave5_pm_ops,
 		},
 	.probe = wave5_vpu_probe,
 	.remove = wave5_vpu_remove,
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index 1a3efb638dde..f1f8e4fc8474 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/pm_runtime.h>
 #include "wave5-vpuapi.h"
 #include "wave5-regdefine.h"
 #include "wave5.h"
@@ -232,6 +233,9 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 
 	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
 
+	if (!pm_runtime_suspended(inst->dev->dev))
+		pm_runtime_put_sync(inst->dev->dev);
+
 unlock_and_return:
 	mutex_unlock(&vpu_dev->hw_lock);
 
@@ -734,6 +738,9 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 
 	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
 
+	if (!pm_runtime_suspended(inst->dev->dev))
+		pm_runtime_put_sync(inst->dev->dev);
+
 	mutex_unlock(&vpu_dev->hw_lock);
 
 	return 0;
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


