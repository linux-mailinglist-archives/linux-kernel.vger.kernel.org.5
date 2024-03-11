Return-Path: <linux-kernel+bounces-98453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D6877A52
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791321C20DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD7C8F5A;
	Mon, 11 Mar 2024 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="SjEQA5du"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022019.outbound.protection.outlook.com [52.101.154.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC46D39
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131104; cv=fail; b=bCJQ0mLgDItpB1LbuYfX6uIaJkgBN5LgXr3GOmRkrhpUMLPeQueg2Yaxyt7I+WklBGig0o1jHzQdCcWhS2tuvdTFm0tyiUPH4IYritps3cWG9seYDndMEOmu6FVrOD5W3jtaoogAgqfWERoHU4If2YHLhEVVm/5h6SpA+kG6Ee4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131104; c=relaxed/simple;
	bh=c699SjHFtTzC7I067eLP9WqVNL2aredc7aHxW6xMntE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCr454j4fo5R7p00FV7O6rziDzqE0K711Xxe21+qX5QgjLlXOOuJXfX4NVTTVyjKAzz4UNfkn4K1y7CRjA2EV8ENibDFyPubo8DCyJrCmzW5dYXDrLCBtC04N+fMy0qK2A+n7o70MSzM2NIAUSiqB8QgXQVnFqlPqnh0Vuk1MeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=SjEQA5du; arc=fail smtp.client-ip=52.101.154.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCn6MPgqtJj/RfZ6MjbKxr0ACtiTr2Xbk4V6BOnbytmV7ZEXbdvNI/Y+RdEBD+Bd8sJAXFAwUBIOVTdDvnCEYnnmH9XSMuvkxSPvAm2XI4JO/MzrsxJX8TvNCs9cKUis/hVle4zPHoY5RY6WjIbvK6yCEjMb55jpWJhkS9qj+SY50E/Q0nmqdBT1WvOcPBipZ8/RpUeoHavet9ZTmgcOnU1m4xRFEdw7Ys5yaCAgFCYQkJyL88ArmN8se7YlBR4xaVPKoJMO/87FSvaS6OKhxRWcFy9AXkNuOsY6CO7aBs++tzZhsO2/AZXk1WFubhWkby/3tv+lKTyJJaS6RZg71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBu1pcMHOWrYRIuELwvfaJNrJcQdtFs5qXu5g0hd17c=;
 b=decl9nexpYFHBuUPG//olscjsFjfHKp6jY9Klu8AbtimA9tlEmRmgYlrnMeuYpeROX8WLOdVwhxLTHmTyEJuQPUh6xSkne5OBNj+Xou73nDVu7UTytY+U8E6E3YWQCZtZ1nlhm/JXnA/E3puyIZFkYPK5VGhbV68hlt+1y/HJ81zunUhfSw54PMv1NAiSd3qwennnPaaX+Z6MM8Vh/ywBLNuTo5n4ZVCqRo3X2LbbVVACHtQoI1GOZdfa2sx9Q7XWqNLnx8ppQsn3ryTMmKgpQFOQBUcHfQCpIq2biELVq2/WtfO9XMSiaN872bWdT/bEBbyigA20oZGWfdZkLQRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBu1pcMHOWrYRIuELwvfaJNrJcQdtFs5qXu5g0hd17c=;
 b=SjEQA5duQJwADK1d1QjI7tQavm2fhDCpGXAgbVVf7VL65pZ7qBtzjD1Cq807X/ZK04nqeQjmZdYSyxkUUZuXe6hBFH90Uepolx5Ma2TaZsxRGcHVwvxHnpHGvH3hC1Y4dZ3/HGeVZoQ2cQXPNts56kF0fIquSa0qsyDXquALSw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB1997.KORP216.PROD.OUTLOOK.COM (2603:1096:301:12f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 04:24:54 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 04:24:54 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [PATCH v2 2/4] media: chips-media: wave5: Support runtime suspend/resume
Date: Mon, 11 Mar 2024 13:24:40 +0900
Message-Id: <20240311042442.10755-3-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>
References: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:100:55::29) To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|PU4P216MB1997:EE_
X-MS-Office365-Filtering-Correlation-Id: 24349289-5f1e-4c8c-ee88-08dc41833389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H8p1NBq9UrpQa6r/v/VBfle0p04vnyhJXzF1wwIVIRxqdQG5G2ASPM6r0PVxaDsw57USerwhaPxjaZDxb+8nk3F0FF87YAEaepwk8aEbrYYnhErcN3NonT1gKRi4X2bTibgKeUu/1X/Qfh50YI083DAw+pmEi71X6jVmpJ5ukg4JCjGpptqt0eI8OEylvk9VoefQDvaSCcRP02PVoNF1SHk4wBgffQYjVhEL1u0CPOrWNwK9HjyPBkf2gQwPHx6R9r+rJwbeVnchL+7Ks+2eufIHR9swJ0cZUhbJDjmCDuc6DOjOF+28UKQAZOcCMVgaYvzHvt0iOxC//LEw0zwciNaNRYK+e5FY9LT8+O9csE6IZXMIs1BRx0X4no6Re5sqt3oRmRy0BtXdAGesBPj0Ncr3dAOqa2R1228IbdtfBPcq6egI0DJ28ymeby1mclUP+BJF2GRhsnYMdQswJ+a4P4N1qDDh2OhXfPNXX5PwO1kuclFXID9Ez02agWC708w+r4yJvbyexyYtHGg7T8VitAHodC2IGc+KcRyaTZ/eFqktjEDqqCp8HFwLVHy3P6yDgsh3TEK4LFF5Iq9bMnGxow1rBCbIlkzFI8+VF6X4R/3/xkZEfh+aIWhjbbtrmBFLnYiJKmrPljCAVydFqFBBIJkigqxa7GXhk8hnPM9d0GGbhjzKqaBS3aAJX8Tnn87VdVxjFxUEQkAB4Lxfb2aY6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u1zb91E2AjEaG/9dFIKx7OFlyI4B9ddHaUJEhVxx1p/ZQtXap3CpM8+6tQnS?=
 =?us-ascii?Q?WIap26Y4YpV9H5/IT3Xqde1YuYuLNdN8h5Z7l64x+tr1PcvLko52bZEbjZHi?=
 =?us-ascii?Q?kiP9+Fl6cr1LmDaz+R0WXek6MvKA4rZSCip91JleNAuRogMwb40tgrS0d6dq?=
 =?us-ascii?Q?mfH2v+t1TRHJk1l/b/kxIIfmAIdi/EPoC9RalkSCbCnt7ebZOQ8qfzKkT1uw?=
 =?us-ascii?Q?MPOgDlLReJLZ3MoFlv6oHgCFjEMbvwTxwxspKWRYFFlmIOO1u6/HryZ6SXsf?=
 =?us-ascii?Q?DMO7I/AowkD8a/oc/9wHZnImfPYefVZwEVESam+rH7sY5c1DVpiJNFz7y/Ef?=
 =?us-ascii?Q?oxGOZ1dsPvg3Or4wIVMfHEkxifmhxXWjrL8P41cV7Hv2LI2YAVfugCHTTouH?=
 =?us-ascii?Q?CoSB3106XI6tK0tTMJyjulQlPlZB6DLz3r+l+dijb9H8myMfSZZ627+dceCQ?=
 =?us-ascii?Q?2kypznWGKeNMlMhWQbPCenqPeQBg3BlEws1yfkZbL/BMd7ygBY74t6JMZtG9?=
 =?us-ascii?Q?U0oxZshE4RgPFdhlAF5NolHXZBA/jKk4/lBeX55if/Yv/FQhRslS2aWfCBmF?=
 =?us-ascii?Q?Hd5Med15Rzx6eThM6Z/Fxa9IAK3ACsZVIxP+y21YJ3Z6t/jayCvHYWrzgqIh?=
 =?us-ascii?Q?rP+VcsNqjNiqTsYfV1K7pms7yMOiAjDCQs7cpeQPgIFXvBSi4J/r4xSMDqKB?=
 =?us-ascii?Q?usAfUSq5jnoJ5Sri3S7AHVesFspTcFWIJRVaFovegmZ5hqq9/t5N3h5AA7Q2?=
 =?us-ascii?Q?wf25DsX9mfkTBjUhCuOGnjn3eMXKpezkiGiI+Ont91IH8AOvg0woteovDbQO?=
 =?us-ascii?Q?ag4CbnQURFF66RAQSYVRLbxadBqFFn+LeIQXT+eGCUQ7T77DadR0vZ/kSuzv?=
 =?us-ascii?Q?8vYGWU5kt98478+TpF0aVxkHg6UTZ3lOEaEOh3jdUdb6RrhTiDT7XEeZ7Ix/?=
 =?us-ascii?Q?Y9F2TpcFp496kscflC6n30SfUIJ4gUL83nSgwXCIU7OMFPnZ09TyF6fSNt7x?=
 =?us-ascii?Q?Keb+EybLyYqqRohmQlfXq/hMAoZmxddnO5ByuBkOkjinFbMTqUSxkf9u8EPT?=
 =?us-ascii?Q?rye9S8f0I6idyVIJhrlc3qpqH/YZoyuWw3IhNscrteYrPEwTyIdOZcuQxBzo?=
 =?us-ascii?Q?HapECzVpRbaNNiqaWnNqU1pFhpMyPgKuN9lgMJw8tyvqWqFWbAx322jg+ET1?=
 =?us-ascii?Q?MlE1iQCLUS1hWnuXChhw/3iIpe6ESV3dsxujBc4fhtTfPwhQ2tVpqwGBJ7aS?=
 =?us-ascii?Q?VjuoH2pXIHUHYY6Ms+ZtrZ6XP0Wwtf92az5qCCnbGegp19zgiuAVdO3hP6Y2?=
 =?us-ascii?Q?Rc2RtKJjDK0COM+oJ0iHnxqWzoRp6e7bD6BjUJh5wuDKs+JBslfTQM58IrMq?=
 =?us-ascii?Q?oE9lvAJMbQpctZkQaqp9PfKLH5yq4nRicVrWZN7peE8o5ejznW21ueuPog8I?=
 =?us-ascii?Q?BzTFByu0rBxnCy5Nwo9BHXtK+iTQrM7rOPf+JzOUpvD/5PB+Y0U/svfhPzYa?=
 =?us-ascii?Q?YvjMuJi9rk4WPpvVdPq6DZMLiYJw2U9W80Y+uwzGyCqe4CvP8AT9lWU8EaIR?=
 =?us-ascii?Q?IgxCuYL0ut/Km3pqYmSm9HnTdPjuw1ZUk52NQbtqv7wfmPo+F5/3ulkp5a80?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24349289-5f1e-4c8c-ee88-08dc41833389
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 04:24:54.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmtMYfbJ8kLe/khBSNTFyjmTPPeyKJcpnoe/EIdkv0XrJ50lZIJZ48QRixoUbTeZfwrMtLiqhBkhYQBm0F73d2jG13XRx3TPMNiVcJRG/+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1997

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

For saving a power resource, we support runtime suspend/resume for an encoder/decoder.
So our vpu module's power turns on only if an encoder/decoder is used.

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
index 4a262822bf17..826b92b7b582 100644
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
index ef227af72348..a199877c643b 100644
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
index f04baa93a9b7..013e2bb37fbb 100644
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
index 0d90b5820bef..8e08461b3515 100644
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
@@ -117,6 +118,38 @@ static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
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
@@ -232,6 +265,12 @@ static int wave5_vpu_probe(struct platform_device *pdev)
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
@@ -254,6 +293,9 @@ static int wave5_vpu_remove(struct platform_device *pdev)
 {
 	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
@@ -281,6 +323,7 @@ static struct platform_driver wave5_vpu_driver = {
 	.driver = {
 		.name = VPU_PLATFORM_DEVICE_NAME,
 		.of_match_table = of_match_ptr(wave5_dt_ids),
+		.pm = &wave5_pm_ops,
 		},
 	.probe = wave5_vpu_probe,
 	.remove = wave5_vpu_remove,
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


