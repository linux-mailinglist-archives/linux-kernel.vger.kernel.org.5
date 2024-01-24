Return-Path: <linux-kernel+bounces-37548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C0683B179
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8497C2886B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C549F131E55;
	Wed, 24 Jan 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="EXHUkeZG"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5690131E50;
	Wed, 24 Jan 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122205; cv=fail; b=NdS6aiQxFusKYfsorF55ZvLlxsDPCs+TuqG6jxxGNNBluWXw0PyxIExbsCb3ES9Ytgwi7nRiQJ2mrjD89wAfu7CFops6lUqGUL6HCcexPMPeO/B3GokUw6UxxUGlCJyLkCfnMLZYJXVVupOB0JvvIqOKlxlg6UuCL94hr4N0X3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122205; c=relaxed/simple;
	bh=ji96LCfwkdj2IkmKhxfI4OLy6tZvZpmE5/ooicKy3Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QVz+Y4rJMElbi55TQmuCIySrU0V7RJ/dNSDs8RGYp7URjiQZe5FlcLd+IiEwfhOXbr3aNa5ujJHBcDRIf/P+nkKIKOLFRPpi1wLkn4H8b0om0o/5NKxBk0qfCC/jz0lL9nk+GS+rh/KIUFJiloQKYCTr5TjrFUwymdNjmrqhpbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=EXHUkeZG; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzLhGpRyU8/YGnLxayr65zadkc8nuyuMvBOOxHg4kg3jhgR6EmD4sdfA0FNdxWLUlIiLcCEl5b50rHdXacpwsRQqz1pAGi4IS3/dG5N/L5v9r9sbka4Em3Q1xu2cbsD5w9/dX1ij2pWnupDUnyTQy15e4Uw8KC2sXDcRnrlebcaGyYHiiOtmofMmUw4PhAECBeAS2l1WouUdmCn2p/l884LsBMo5uMoP6tzyq9fnfA8qNrCoE939Sbgeq/G9dGVOMz5z31dsMcCHO0ZRzZmfJ2GOSsO4NIW5qccUpREPAMiSU5C10dfvbIDBF2tV0SoDnrJ9nqGPirm1Ij/yfWN0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6mgO5luPo/BfDUTypkDWRZWnHU0pXEuKFb3flUcDgw=;
 b=KCi4PAyRDyo9fg3fBr9FK0qivL4jVDbLBN7npYNdJybfUKUiWR9AZwAh8m38E5mULmTqjetlsqw3eioE1Q8Y+l6AYd7NZoMS7BBjwbvOLMcgc2JTeKDzmkkjVdcBl8LtiR9vjQHzvTBNhKoNg+kGr3bLy22hmZeLlF+tphoYBl5uObNk5jtIH5kAJR22y/O17mj9Zwqitb1SD51ZYvNnh+dZ0Dv7h1yWD7Gefh7xi7OGevzoOaZH2peUU6q0WFK//G/OoV8k4b/S5KmndGMC0NZj+En6fdIfYcvkKFzdI0JO3qBrq7utqiUN2mbRCW4BvfJLsDzYiJretvHoCt0R0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6mgO5luPo/BfDUTypkDWRZWnHU0pXEuKFb3flUcDgw=;
 b=EXHUkeZGS0SnDwmRR+VYo7LAeP+IaJprJzLz/mdx4vLFgAVYvqZPBIVhOWxGn8JPAZJc5N3PFZJ2/SZUhl0jADGOzb55bv8m4xoLhrkaez7slS0VuRKPoVB/AaV+kxB4jt9Q1/gsdmFmmm8AQJJr+MzJfwkzvMF5bzuhYjePLt2++plmmjugkOBvUHbwRhx00BmgT7zDf5MtqHyn/LamyGg4XfHrvz1N0lpzs4l13JReynjNQWkrdW2J0rLVTzAY5zPEV5UfJtvi7rL3E0aR+2OJsi34XwtBGmJXScvpTMQFrlrCwhtoBZcwC//bM99W258XlAaxUea0foyBR20KJA==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by BY5PR03MB5048.namprd03.prod.outlook.com (2603:10b6:a03:1e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 18:50:01 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::cc0:a35d:c90d:e350]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::cc0:a35d:c90d:e350%2]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 18:50:01 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date: Wed, 24 Jan 2024 13:49:46 -0500
Message-ID:
 <PH7PR03MB706498B5804E735C6B681407A07B2@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Et/HryODooaVs+ZOXp5ff0Ja1kibWKmUOeCnI9ID0SU=]
X-ClientProxiedBy: YQZPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::28) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20240124184947.5263-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|BY5PR03MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: aba481e2-c6fe-41ff-354b-08dc1d0d44a7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gnFO1rg9/iMW1oXP7zxnX/Pd7aXciQn2F5UAyF/051mB/KGG4cf2Z0xv0e6P7WCr8R9QtoHu8W40gqqCSGSUWFSF3c3o4/0NP6EbIEMsJPLSXml/sX9wd0mYuuP3Dau70fbbHUgV+1Qghiq6a9MeCyub0Vu86LTysHKje62rLhPOFPfrVTb208kexOV9JVJADhGBLZLLnfgTmNJfomeSlQuPZtxEK+UC8+0R1eDerCnyUyYRlmsbmwgLndvzwzAdxkI7/WSfMFUxFdBcqd+p2p2GN4XFZl8mmyIMd1W/uCa4YWER/7Lytx/OPsAIxCqwHUEwFUsuMEYZKKFPsvOAqptnI/VPxpC8aHoojKo1Kkvrzpnn2ZcTF/1Yv03zDFzx43MK1g37MDgyS/k/gsBDZ7j7s0NRkznJ/dKshFcqbdauTV6SMmJHKJLe5qONgabrhGE5M1bc0M1G3CjBtWfzBGUDDAeQEGH2kNwHYBZANm6ldnx303Jh6uozXnijQrMITNtmOki2yYDPQSc2YthXa2coDj6bFx32XYMIbpn3Hjdt2yp1JYFSNHAEYfV51iP8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7EloORp2NQNRXhBG8EF4OiIpdKbyP0wi502jzn0qGOCe+BrorgnPWm20yzF?=
 =?us-ascii?Q?XDmWd3fauevT9HgmxOVfQcSC7eg/fUa0dXIFZouOOLAtTrHAmEw4xA2bKdmW?=
 =?us-ascii?Q?1f2UCn/hLrrBD4ueYUhMLw/Y0idyLbpP+MB7L7wFoPz0AfYQJI7XSUGXI23z?=
 =?us-ascii?Q?ITW7k+U2FLmGcFEQ4Z9rq+aXUeq0aE8OATiSDil7X4Or3xRZdL8wGS9zP+Y8?=
 =?us-ascii?Q?5lRxJw907k4K0ctU4QzleFZEbEqNej6vupbeMP+1cjFLLUWK61fBFhgz4cu2?=
 =?us-ascii?Q?P6FW6YExjVEisEoo3Blvw0wbzV17Ic4+3JCyuUulJfQVqiqKIQxTOiNn4SAW?=
 =?us-ascii?Q?PilIfa6isl8D2CpTK0bHozjge3f3B9wawYpLoGp4T2kbc7gZxilLPF0sUFvs?=
 =?us-ascii?Q?th/OVSTzaJLs4fjc7guiVGgNmvkmZ5TmkOkOuY6o3G+2+dRsQFdyGSIZC8Wa?=
 =?us-ascii?Q?55BnnUW+pqJojEjkPIhjKMg0mQroZAOianQhd1yT1pMfSeJtBUdNd98UmWus?=
 =?us-ascii?Q?6/x6MOgeYj0xCV2/5HvQ7CO4BE8iGG8+BfD8USec6IIGsmxtk++K6xzxSB1k?=
 =?us-ascii?Q?OjuC/6d1KqjNygYK0Xim5bzAjIqh6d8HM2Q3tW+FzNTi6TPAynkHEkpsdTJA?=
 =?us-ascii?Q?Br71HuaNtVMoeqzcRFYltuSA/pRgX0NgyQdbh5j4qNSwjPNdIUTF60xFElP+?=
 =?us-ascii?Q?QWU6CY+1N/heWfw93Rq0wp0/2RbcX2yMhB6Av/mxkQ/nkCHwWzT3HvHYiRxY?=
 =?us-ascii?Q?XjHEv4aX+ZlCNLrLVFs+EPQ88FIGtNgVaPfAeN/Tijjt20nlWnn8FsWIEw75?=
 =?us-ascii?Q?6Z3MV1l2q53Vqc8cuT55FiASsoj5TGS5zREPXhMIWmiy3qy9p8lVTYrMC3e2?=
 =?us-ascii?Q?aMnmrIKoh0DqZcZKAKFzuO8tbBaLtIAvAHYHwwiIhyf4oLqyhxEapPAsyU3f?=
 =?us-ascii?Q?yD3fASGlzKiz3qrenScvbEvDXBRW7QLomi18Dl1v35n3Or/StsUEhDh53/yE?=
 =?us-ascii?Q?Pb/96OA9cshZJkfNOcFvIW7reqj+OGaxV/MBuxThKpEZgQL30w1DjZ9H3r87?=
 =?us-ascii?Q?tdK/ax1SFnCHHDRrxpARkkwNRVZmt4iiqH1u/8Zawx5ikbkxUCZn71ej+udU?=
 =?us-ascii?Q?fnAIO51KDuawP/11TZ7GIo+2Hgc4X9wdcJozS9Bs7Tqygi40lkgI1wq+3H4T?=
 =?us-ascii?Q?2+DgCR2MPQHUtRdc6uZm3PaEa1p61bLOf7cvsA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aba481e2-c6fe-41ff-354b-08dc1d0d44a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 18:50:00.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5048

From: Min Li <min.li.xe@renesas.com>

This change is for the PHC devices that can measure the phase offset
between PHC signal and the external signal, such as the 1PPS signal of
GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
the existing ptp_extts_event so that application such as ts2phc can
poll the external offset the same way as extts. Hence, ts2phc can use
the offset to achieve the alignment between PHC and the external signal
by the help of either SW or HW filters.

Signed-off-by: Min Li <min.li.xe@renesas.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
---
-Rebase to net-next tree
-Fix the typo and ns2counters suggested by Simon
-Remove inline from ptp_fc3.c suggested by Simon
-Use flags field to identify extts and extoff event suggested by Richard
-Fix indentation suggested by Simon
-Rename PTP_EXTTS_EVENT_VALID flag suggested by Richard
-Update flags comment as event type suggested by Richard
-Change HAVE_IDTRC38XXX_REG to MFD suggested by Lee
-Change some masks to GENMASK_ULL suggested by Jakub
-Remove unnecessary logs and unused local variables suggested by Simon

 drivers/ptp/ptp_clock.c          | 16 +++++++++++++++-
 include/linux/ptp_clock_kernel.h |  3 +++
 include/uapi/linux/ptp_clock.h   | 13 ++++++++++---
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 15b804ba4..3aaf1a343 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -44,18 +44,31 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
 				       struct ptp_clock_event *src)
 {
 	struct ptp_extts_event *dst;
+	struct timespec64 offset_ts;
 	unsigned long flags;
 	s64 seconds;
 	u32 remainder;
 
-	seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
+	if (src->type == PTP_CLOCK_EXTTS) {
+		seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
+	} else if (src->type == PTP_CLOCK_EXTOFF) {
+		offset_ts = ns_to_timespec64(src->offset);
+		seconds = offset_ts.tv_sec;
+		remainder = offset_ts.tv_nsec;
+	} else {
+		WARN(1, "%s: unknown type %d\n", __func__, src->type);
+		return;
+	}
 
 	spin_lock_irqsave(&queue->lock, flags);
 
 	dst = &queue->buf[queue->tail];
 	dst->index = src->index;
+	dst->flags = PTP_EXTTS_EVENT_VALID;
 	dst->t.sec = seconds;
 	dst->t.nsec = remainder;
+	if (src->type == PTP_CLOCK_EXTOFF)
+		dst->flags |= PTP_EXT_OFFSET;
 
 	/* Both WRITE_ONCE() are paired with READ_ONCE() in queue_cnt() */
 	if (!queue_free(queue))
@@ -417,6 +430,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
+	case PTP_CLOCK_EXTOFF:
 		/* Enqueue timestamp on selected queues */
 		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9b..6e4b8206c 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -200,6 +200,7 @@ struct ptp_clock;
 enum ptp_clock_events {
 	PTP_CLOCK_ALARM,
 	PTP_CLOCK_EXTTS,
+	PTP_CLOCK_EXTOFF,
 	PTP_CLOCK_PPS,
 	PTP_CLOCK_PPSUSR,
 };
@@ -210,6 +211,7 @@ enum ptp_clock_events {
  * @type:  One of the ptp_clock_events enumeration values.
  * @index: Identifies the source of the event.
  * @timestamp: When the event occurred (%PTP_CLOCK_EXTTS only).
+ * @offset:    When the event occurred (%PTP_CLOCK_EXTOFF only).
  * @pps_times: When the event occurred (%PTP_CLOCK_PPSUSR only).
  */
 
@@ -218,6 +220,7 @@ struct ptp_clock_event {
 	int index;
 	union {
 		u64 timestamp;
+		s64 offset;
 		struct pps_event_time pps_times;
 	};
 };
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index da700999c..053b40d64 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -32,6 +32,7 @@
 #define PTP_RISING_EDGE    (1<<1)
 #define PTP_FALLING_EDGE   (1<<2)
 #define PTP_STRICT_FLAGS   (1<<3)
+#define PTP_EXT_OFFSET     (1<<4)
 #define PTP_EXTTS_EDGES    (PTP_RISING_EDGE | PTP_FALLING_EDGE)
 
 /*
@@ -40,7 +41,8 @@
 #define PTP_EXTTS_VALID_FLAGS	(PTP_ENABLE_FEATURE |	\
 				 PTP_RISING_EDGE |	\
 				 PTP_FALLING_EDGE |	\
-				 PTP_STRICT_FLAGS)
+				 PTP_STRICT_FLAGS |	\
+				 PTP_EXT_OFFSET)
 
 /*
  * flag fields valid for the original PTP_EXTTS_REQUEST ioctl.
@@ -50,6 +52,11 @@
 					 PTP_RISING_EDGE |	\
 					 PTP_FALLING_EDGE)
 
+/*
+ * flag fields valid for the ptp_extts_event report.
+ */
+#define PTP_EXTTS_EVENT_VALID	(PTP_ENABLE_FEATURE)
+
 /*
  * Bits of the ptp_perout_request.flags field:
  */
@@ -228,9 +235,9 @@ struct ptp_pin_desc {
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
 
 struct ptp_extts_event {
-	struct ptp_clock_time t; /* Time event occured. */
+	struct ptp_clock_time t; /* Time event occurred. */
 	unsigned int index;      /* Which channel produced the event. */
-	unsigned int flags;      /* Reserved for future use. */
+	unsigned int flags;      /* Event type. */
 	unsigned int rsv[2];     /* Reserved for future use. */
 };
 
-- 
2.39.2


