Return-Path: <linux-kernel+bounces-127681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FD0894F64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229661C225FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D05A78A;
	Tue,  2 Apr 2024 10:00:42 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDD58AAF;
	Tue,  2 Apr 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052040; cv=fail; b=TKbuO/w2q3vZ6lRD1I9lHG9gvuBOuVIZamWNPol/ZCjeS6dlZqaAXErKDpeLhAVqtZkkArNq1s1Ubcq42OVlSs5/eHY5nnY2CVM9FSFxekp1DrhDPKD5OjjMzrRImG3wwA8bslFYTQnfPxhcZFLdGoq7ao9r7Ev02AyXukh4Kt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052040; c=relaxed/simple;
	bh=psKjk8lY4xkCZjyovCvvAwOqtqQWHZsp74ASjK+koTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nb6N2KXOCGS+nOCW5OFLtlSXb8YZm2q3zziGSDQv8l4wvU9tQPNVhImBEsfKjvCRpxgTXfJOe3ydqWAkKcr4B/+0WJGtBl8dh99fC+qBhU6kh7Odku/C0RnuiXzbI2boVQmzl55VE2tseKtnEcLZDnla460BpOQrdumASX7/gug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6K+3UQlTNSyveDCd4zE6jY+Vmb4oiMYimQ9gzHG7DWKYvoDKV5ihvUvysW+aknD+fGwO4n4SH7IZ+VkiRriF6N3PkRBwRluCBbRa2e47aWIEL++dz83/xiAZWAscII0KbPKwLl6lrbkNnzSbNA1LYm6Z8A0dXKNCNjIDUBbDBKX+kBdHGdFGnBWWDL9NoQ2dYvvcw3SO3ujQzYvaqhquzwEX3l+WFU7mY31dxx++R8WXvHTwBIbhzft0oSOOfF+8WcpG3BFSQm1fmhMvlILjD00V8wOamGnR7YMcvPVRPbF8furDOnqGeJbMKVlCUiSHaNWTO61mpONHqw4WnYhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQXDmgtuv7pIMPNQ9nG9CHZHF1Mb2rssyvCxM2x9gZA=;
 b=m0L0thWE7I+gfYPVbcYlBpx7Sd30o56SoeHbgE5t8jfamT1FwKL0YnC90WkPj9c/IINTLOmKpF+iuujrM6NvUq91M7A3bbYxdutS5LnJMwM4D4pBKIFkvgZR6FBbG6KpO2hPn8lcLcyB+1CFzOp9q+s3HSJjIvyOoqeCKgK1XEFcD7xRh6zb4mF8muWpRbtlssnGA0n51vUSxMTR5VzP3hPP9F9gYeSUDhMfWc6aRbpCdYf9Th9XTWM2wetgQmN3VzxSGJUPH3NwAjoPIiUWblBY51M/vK2qYFZitaP30RZgGh6cG/MNmfvxUJiQX6+Za69YxXj40ukSkI5PW63L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0669.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Tue, 2 Apr
 2024 10:00:22 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:22 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Marvin Lin <milkfafa@gmail.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 01/13] media: starfive: Add JH7110 ISP module definitions
Date: Tue,  2 Apr 2024 02:59:59 -0700
Message-Id: <20240402100011.13480-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
References: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::11) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0669:EE_
X-MS-Office365-Filtering-Correlation-Id: a0133740-c809-490c-d32c-08dc52fbb5c6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fOmuy2dXMIzelQRwIsxwbQV4HL6FpC5ua/oMIhZAKeqfM5DL8nOVkMwWDZsUKqqFIm8Bhl7TvssNSRx2JOQzEMfu6ur8DPp/IdxydiYoTIfPr7oHgsxeonun0mwOvjPdysmBzwHNcC5dtlNXfqXAVW54Pyd98+REI52QoU2FCnSwEwSiO9FyBjmcKKRt3Vg5nWQfj/05GwGtI6zVvu1vgQlRcBDFBDJpvt87g8ZqbLky4aMCbcUcbfpu1/iQQSuiNoNDnvcxS869v7ZrXDBJ4n3WrPl9SEF3r4g2wEvekRWWQTWAC1mMox1AK/bDuBSeAyXauT5f5+x7RY5P2GB3PackRw0wYU7xWzFHlXhpHQx8RnUmuoWTfhaMHkiIEXkIXDGg48jaHoiM9sF3CDUGMLKhkP2M7demgLAXpGn99vK13E/fuaq3NCn8hV9KDTW65iR0xUxDrZyig4igHyd3Hjy/yyOLMKQoYgqPI5GMU/F0tDlVO26EaWU3cGVOkM6B+x3n+jIDa5TsiH+vKVQjKiY/kmB9UQ7tXg6GrlQuvHyD2CxThUovAu+iqBT0Wrb34BfIcMEHd7Wo4HrupBId+lwWr+VbSdOsZb3IVvJljv7tVlpBMEAnJ2sOl1cxAn+mP4LMil8643MUjb1RfZ+RCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlpnaVFqNEcrN0luSGx0ZWFxb3RHOXRJQmpiOUlsVXMwZHUrQjJVTFZxL3lZ?=
 =?utf-8?B?RWg5SGc4S1laOXpWZWZkbWU4dld0blVDY1dLVytqang4bzV0VlJuU1dyV0s0?=
 =?utf-8?B?dFdMN1c0YTB2WWtMWEZSOGdGaDhuN2ltR1M5a2pralV1VHNpWW02QWVHZy9q?=
 =?utf-8?B?RGw0OXg0SEo1RHF0SnF1REtJVVVBRVU1MlFzVkR0Kyt5OFBxcW5RMTJCaTVh?=
 =?utf-8?B?VzRwQ2ZWV0ZlZDVaRGxlWWJTQ0ViUEhabml3algyeklLOWJzeVFYbVZEbHB4?=
 =?utf-8?B?ZC9udXB3UzlqdEx1YjRRejcyWTh1MWNpckV1dEY5RUdTU0NwRVNVMjdYenly?=
 =?utf-8?B?WmtmZmFHSmQ5TlRKUEgxSjA2WHpHckpZSHJSamtsNzJ3Q2NHeGk1WDVWUHk0?=
 =?utf-8?B?ZWJCLzBlM3hiRi9uTnVHak5TeVAySzhIRGdJL2RpZldncWptMUpKaG8rU3V0?=
 =?utf-8?B?SnRhUXdGWXdjM3liMVJya0tLUHRqem9Ub2JHa1dTR0dlRWVWRnN0blV0U0xF?=
 =?utf-8?B?RkYwRUFVTjVBUEhmdlR1S3htT1R3dVE4ZlpiSTFVdDVjTDdSK1lSZVFkWlJz?=
 =?utf-8?B?S2VTRHFEQzAyRUpCMGJoOXBLL2hzblVLeHhJV3hIRlRJN3AvanBwKzdXOXlj?=
 =?utf-8?B?U1hrRmxZWXFXUGlwS2krTnpOcS9MWUVaYzUwOFgvcVhlTzAyalZPcEdyd2Vp?=
 =?utf-8?B?WDBycFBIaG5pempla2ZQQ3ZrWDFRTHdrSTA2T0pzY3RzeVZkVjMxVFI3Z0xt?=
 =?utf-8?B?Q1lHaG1QYVJNVmpUeHVtZjI0UTd4VFMwb3lLY1pSZldYR0krWW9DMGp4WVZq?=
 =?utf-8?B?WHJoZmFrejhONjRNOFJxK1kyd2x6N0MzTDZwTDFoZnczcFVobnliZnNkRXVz?=
 =?utf-8?B?QzRYNGdrQ0c1YU5Pb09DVC93akNsZ29tY25ETzA1WmFyTFByODQ1bEtVMFZT?=
 =?utf-8?B?Y1R0L284dlgzY3B4aVNiRHpFWHFZWVEzbkpteHZmTllvdXk4VHZJaE5XVGV6?=
 =?utf-8?B?OGZ2cEVqMkFQSEV1UmhnL1E5cVlkMVZQSmk0K3RFMnZCYzdEVHh6Y0M3Q0Iy?=
 =?utf-8?B?cnYyWGI4d2NPNnUrcHZwNkdMMmVZTTFiKy8zc3p2WHdnOFJCK1lkbGY3ZEdy?=
 =?utf-8?B?UVVtTXc4WVFndjhOd2JpTC9Td2hQQURYNXhmeGY2eDN0Y0t3cmMyeVhpdUhh?=
 =?utf-8?B?c2MxZmZDVHg1YmdqWjIyb3JWbW5wSG9Ob0xJSU1meUdpZGJ4N1gyUTFjdFQv?=
 =?utf-8?B?WUlNNzM1d0NnQUFzcFJmaW1jVmRUUGpTcW0wejNWcXJNTFh2SlFGeXFhbnpP?=
 =?utf-8?B?VHlpUS9CQW5XSkc2cWRwVlpQazVMNUMzOHpXSGtVckQ5Mm1wQmtnSVFoZ0hl?=
 =?utf-8?B?V1h4OVN5SllHSlBjRTdNMlZiTjhraXo2c05QM3hyOHJHTFduRFpXMWFnU2c5?=
 =?utf-8?B?b24yZENJVFp2RkdsbHZZM0I1ekpPZDZURkZEVUZaOG50VGw4UUZDdXd1R0E4?=
 =?utf-8?B?U2tIY1lqNTZCQTMyc2FUbjdqREJla0hhTjZvSDd0VlNHV2hEZE40Y0R2bW5s?=
 =?utf-8?B?S2ZUOXZPOGx4MHlvR0RvYUZSVmZjdnhjeDR2UWZtRUVzZUR4WkltVDFGYkY2?=
 =?utf-8?B?NVd5dCtMK2RZOHR2TS9KRUp3VVhDVUcyQWFRTEVid0VET29Ld09VNkJmaGRB?=
 =?utf-8?B?bktCT0ZXU1JQclUzYS9BU3IwTzdLSm9HY1FHVHIwSGtnNHNrWkE5YUN1ajJ5?=
 =?utf-8?B?NDczdHljSDcyTitKSkpMZG9sSlRGbWZxSndJMURLZ3hNWHovNWtyV1ZXMjk1?=
 =?utf-8?B?a3J1WXdxem8yeCtrNEJHUkQ3dkx6QkVkMjFoU3FUbTFmcENkOTRkK2N4eWNo?=
 =?utf-8?B?cGhXODRLWWxncnE2dGFRSVdQd1Y4cGJqbDBic0x3UkhVWXV3bWw3QXRyeFZ4?=
 =?utf-8?B?QnRmMWdtNmxOZzRzL1pqbXFtcGw3VlAvR3Q0WEhURVUrMGNZRSsxdjh5Rjcr?=
 =?utf-8?B?Y1BZcnRGeXIySTNiN2phamU0NC9FbGVnYnpaQkpjTTBPRU90NlVUVXBIY1BK?=
 =?utf-8?B?NzNwUUdVN0d5M1BRS2NLYVVVUTBhWlFXNThtVjI5RElKSnkwMC93YnVrMGMz?=
 =?utf-8?B?aVRkdXJTWktwUWtNSFVGVDJhVmdvNnAxL3RGREJoT2pGb2RQV2hyWlBoSzhq?=
 =?utf-8?Q?6aToMPKKvzcHaaNGvoliBB0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0133740-c809-490c-d32c-08dc52fbb5c6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:22.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbAvjYd6eo2XwZdSzBHHicW6PYzyooYCxJPhxWiaLkwrZ220llKBcBSOGBrS0/cFYPZFsU0cbUiM+T5F7rquqh2ycVQJQPHDbpm36YJhmUae5RqgALG83GqkNI3sJrP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0669

Add JH7110 ISP module definitions for user space.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Zejian Su <zejian.su@starfivetech.com>
---
 MAINTAINERS                     |   1 +
 include/uapi/linux/jh7110-isp.h | 739 ++++++++++++++++++++++++++++++++
 2 files changed, 740 insertions(+)
 create mode 100644 include/uapi/linux/jh7110-isp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 88b4cdde1ad8..e5ed3c876a55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20955,6 +20955,7 @@ S:	Maintained
 F:	Documentation/admin-guide/media/starfive_camss.rst
 F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
 F:	drivers/staging/media/starfive/camss
+F:	include/uapi/linux/jh7110-isp.h
 
 STARFIVE CRYPTO DRIVER
 M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
diff --git a/include/uapi/linux/jh7110-isp.h b/include/uapi/linux/jh7110-isp.h
new file mode 100644
index 000000000000..e9857995068b
--- /dev/null
+++ b/include/uapi/linux/jh7110-isp.h
@@ -0,0 +1,739 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * jh7110-isp.h
+ *
+ * JH7110 ISP driver - user space header file.
+ *
+ * Copyright © 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Zejian Su <zejian.su@starfivetech.com>
+ *
+ */
+
+#ifndef __JH7110_ISP_H_
+#define __JH7110_ISP_H_
+
+/**
+ * ISP Module Diagram
+ * ------------------
+ *
+ *  Raw  +-----+    +------+    +------+    +----+
+ *  ---->| OBC |--->| OECF |--->| LCCF |--->| WB |-----+
+ *       +-----+    +------+    +------+    +----+     |
+ *                                                     |
+ *  +--------------------------------------------------+
+ *  |
+ *  |    +-----+    +-----+    +-----+    +-----+
+ *  +--->| DBC |--->| CTC |--->| CFA |--->| CAR |------+
+ *       +-----+    +-----+    +-----+    +-----+      |
+ *                                                     |
+ *  +--------------------------------------------------+
+ *  |
+ *  |    +-----+    +--------+    +-----+    +------+
+ *  +--->| CCM |--->| GMARGB |--->| R2Y |--->| YCRV |--+
+ *       +-----+    +--------+    +-----+    +------+  |
+ *                                                     |
+ *  +--------------------------------------------------+
+ *  |
+ *  |    +-------+    +-------+    +-----+    +----+
+ *  +--->| SHARP |--->| DNYUV |--->| SAT |--->| SC |
+ *       +-------+    +-------+    +-----+    +----+
+ *
+ */
+
+/* Auto White Balance */
+#define JH7110_ISP_MODULE_WB_SETTING			(1U << 0)
+/* Color Artifact Removal */
+#define JH7110_ISP_MODULE_CAR_SETTING			(1U << 1)
+/* Color Correction Matrix */
+#define JH7110_ISP_MODULE_CCM_SETTING			(1U << 2)
+/* Color Filter Arrays */
+#define JH7110_ISP_MODULE_CFA_SETTING			(1U << 3)
+/* Crosstalk Correction */
+#define JH7110_ISP_MODULE_CTC_SETTING			(1U << 4)
+/* Defect Bad Pixel Correction */
+#define JH7110_ISP_MODULE_DBC_SETTING			(1U << 5)
+/* Denoise YUV */
+#define JH7110_ISP_MODULE_DNYUV_SETTING			(1U << 6)
+/* RGB Gamma */
+#define JH7110_ISP_MODULE_GMARGB_SETTING		(1U << 7)
+/* Lens Correction Cosine Fourth */
+#define JH7110_ISP_MODULE_LCCF_SETTING			(1U << 8)
+/* Optical Black Correction */
+#define JH7110_ISP_MODULE_OBC_SETTING			(1U << 9)
+/* Opto-Electric Conversion Function */
+#define JH7110_ISP_MODULE_OECF_SETTING			(1U << 10)
+/* RGB To YUV */
+#define JH7110_ISP_MODULE_R2Y_SETTING			(1U << 11)
+/* Saturation */
+#define JH7110_ISP_MODULE_SAT_SETTING			(1U << 12)
+/* Sharpen */
+#define JH7110_ISP_MODULE_SHARP_SETTING			(1U << 13)
+/* Y Curve */
+#define JH7110_ISP_MODULE_YCRV_SETTING			(1U << 14)
+/* Statistics Collection */
+#define JH7110_ISP_MODULE_SC_SETTING			(1U << 15)
+
+/**
+ * struct jh7110_isp_wb_gain - auto white balance gain
+ *
+ * @gain_r: gain value for red component.
+ * @gain_g: gain value for green component.
+ * @gain_b: gain value for blue component.
+ */
+struct jh7110_isp_wb_gain {
+	__u16 gain_r;
+	__u16 gain_g;
+	__u16 gain_b;
+};
+
+/**
+ * struct jh7110_isp_wb_setting - Configuration used by auto white balance gain
+ *
+ * @enabled: enabled setting flag.
+ * @gains: auto white balance gain setting.
+ */
+struct jh7110_isp_wb_setting {
+	__u32 enabled;
+	struct jh7110_isp_wb_gain gains;
+};
+
+/**
+ * struct jh7110_isp_car_setting - Configuration used by color artifact removal
+ *
+ * @enabled: enabled setting flag.
+ */
+struct jh7110_isp_car_setting {
+	__u32 enabled;
+};
+
+/**
+ * struct jh7110_isp_ccm_smlow - Color correction matrix
+ *
+ * @ccm: color transform matrix with size 3 by 3.
+ * @offsets: the offsets of R, G, B after the transform by the ccm.
+ */
+struct jh7110_isp_ccm_smlow {
+	__s32 ccm[3][3];
+	__s32 offsets[3];
+};
+
+/**
+ * struct jh7110_isp_ccm_setting - Configuration used by color correction matrix
+ *
+ * @enabled: enabled setting flag.
+ * @ccm_smlow: Color correction matrix.
+ */
+struct jh7110_isp_ccm_setting {
+	__u32 enabled;
+	struct jh7110_isp_ccm_smlow ccm_smlow;
+};
+
+/**
+ * struct jh7110_isp_cfa_params - demosaic parameters
+ *
+ * @hv_width: detail smooth factor
+ * @cross_cov: Cross covariance weighting.
+ */
+struct jh7110_isp_cfa_params {
+	__s32 hv_width;
+	__s32 cross_cov;
+};
+
+/**
+ * struct jh7110_isp_cfa_params - Configuration used by demosaic module
+ *
+ * @enabled: enabled setting flag.
+ * @settings: demosaic parameters.
+ */
+struct jh7110_isp_cfa_setting {
+	__u32 enabled;
+	struct jh7110_isp_cfa_params settings;
+};
+
+/**
+ * struct jh7110_isp_ctc_params - crosstalk remove parameters
+ *
+ * @saf_mode: smooth area filter mode.
+ * @daf_mode: detail area filter mode.
+ * @max_gt: the threshold for imbalance detection when pixel intensity is close to maximum.
+ * @min_gt: the threshold for imbalance detection when pixel intensity is close to 0.
+ */
+struct jh7110_isp_ctc_params {
+	__u8 saf_mode;
+	__u8 daf_mode;
+	__s32 max_gt;
+	__s32 min_gt;
+};
+
+/**
+ * struct jh7110_isp_ctc_params - Configuration used by crosstalk remove
+ *
+ * @enabled: enabled setting flag.
+ * @settings: corsstakl remove parameters.
+ */
+struct jh7110_isp_ctc_setting {
+	__u32 enabled;
+	struct jh7110_isp_ctc_params settings;
+};
+
+/**
+ * struct jh7110_isp_dbc_params - defect pixels correction parameters
+ *
+ * @bad_gt: bad pixel threshold for the green channel.
+ * @bad_xt: bad pixel threshold for the red and blue channels.
+ */
+struct jh7110_isp_dbc_params {
+	__s32 bad_gt;
+	__s32 bad_xt;
+};
+
+/**
+ * struct jh7110_isp_dbc_params - Configuration used by defect bad pixels correction
+ *
+ * @enabled: enabled setting flag.
+ * @settings: defect pixels correction parameters.
+ */
+struct jh7110_isp_dbc_setting {
+	__u32 enabled;
+	struct jh7110_isp_dbc_params settings;
+};
+
+/**
+ * struct jh7110_isp_dnyuv_params - yuv domain denoise parameters
+ *
+ * @y_sweight: ten coefficients of 7x7 spatial filter for Y channel.
+ * @y_curve: intensity difference (similarity) weight lookup table for Y channel.
+ * @uv_sweight: ten coefficients of 7x7 spatial filter for U and V channel.
+ * @uv_curve: intensity difference (similarity) weight lookup table for U and V channel.
+ */
+struct jh7110_isp_dnyuv_params {
+	__u8 y_sweight[10];
+	__u16 y_curve[7];
+	__u8 uv_sweight[10];
+	__u16 uv_curve[7];
+};
+
+/**
+ * struct jh7110_isp_dnyuv_params - Configuration used by yuv domain denoise
+ *
+ * @enabled: enabled setting flag.
+ * @settings: yuv domain denoise parameters.
+ */
+struct jh7110_isp_dnyuv_setting {
+	__u32 enabled;
+	struct jh7110_isp_dnyuv_params settings;
+};
+
+/**
+ * struct jh7110_isp_gmargb_point - RGB Gamma point
+ *
+ * @g_val: RGB gamma value.
+ * @sg_val: RGB gamma slope value.
+ */
+struct jh7110_isp_gmargb_point {
+	__u16 g_val;
+	__u16 sg_val;
+};
+
+/**
+ * struct jh7110_isp_gmargb_setting - Configuration used by RGB gamma
+ *
+ * @enabled: enabled setting flag.
+ * @curve: RGB Gamma point table.
+ */
+struct jh7110_isp_gmargb_setting {
+	__u32 enabled;
+	struct jh7110_isp_gmargb_point curve[15];
+};
+
+/**
+ * struct jh7110_isp_lccf_circle - len circle
+ *
+ * @center_x: center X distance from capture window.
+ * @center_y: center Y distance from capture window.
+ * @radius: len circle radius.
+ */
+struct jh7110_isp_lccf_circle {
+	__s16 center_x;
+	__s16 center_y;
+	__u8 radius;
+};
+
+/**
+ * struct jh7110_isp_lccf_curve_param - lens correction cosine fourth curve param
+ *
+ * @f1: F1 parameter.
+ * @f2: F2 parameter.
+ */
+struct jh7110_isp_lccf_curve_param {
+	__s16 f1;
+	__s16 f2;
+};
+
+/**
+ * struct jh7110_isp_lccf_setting - Configuration used by lens correction cosine fourth
+ *
+ * @enabled: enabled setting flag.
+ * @circle: len circle.
+ * @r_param: lens correction cosine fourth curve param for Bayer pattern R.
+ * @gr_param: lens correction cosine fourth curve param for Bayer pattern Gr.
+ * @gb_param: lens correction cosine fourth curve param for Bayer pattern Gb.
+ * @b_param: lens correction cosine fourth curve param for Bayer pattern B.
+ */
+struct jh7110_isp_lccf_setting {
+	__u32 enabled;
+	struct jh7110_isp_lccf_circle circle;
+	struct jh7110_isp_lccf_curve_param r_param;
+	struct jh7110_isp_lccf_curve_param gr_param;
+	struct jh7110_isp_lccf_curve_param gb_param;
+	struct jh7110_isp_lccf_curve_param b_param;
+};
+
+/**
+ * struct jh7110_isp_obc_win_size - optical balck correction window size
+ *
+ * @width: window width.
+ * @height: window height.
+ */
+struct jh7110_isp_obc_win_size {
+	__u32 width;
+	__u32 height;
+};
+
+/**
+ * struct jh7110_isp_obc_gain - optical balck correction symbol gain
+ *
+ * @tl_gain: gain at point A for symbol.
+ * @tr_gain: gain at point B for symbol.
+ * @bl_gain: gain at point C for symbol.
+ * @br_gain: gain at point D for symbol.
+ */
+struct jh7110_isp_obc_gain {
+	__u8 tl_gain;
+	__u8 tr_gain;
+	__u8 bl_gain;
+	__u8 br_gain;
+};
+
+/**
+ * struct jh7110_isp_obc_offset - optical balck correction symbol offset
+ *
+ * @tl_offset: offset at point A for symbol.
+ * @tr_offset: offset at point B for symbol.
+ * @bl_offset: offset at point C for symbol.
+ * @br_offset: offset at point D for symbol.
+ */
+struct jh7110_isp_obc_offset {
+	__u8 tl_offset;
+	__u8 tr_offset;
+	__u8 bl_offset;
+	__u8 br_offset;
+};
+
+/**
+ * struct jh7110_isp_obc_setting - Configuration used by optical balck correction
+ *
+ * @enabled: enabled setting flag.
+ * @win_size: optical balck correction window size.
+ * @gain: optical balck correction symbol gain.
+ * @offset: optical balck correction symbol offset.
+ */
+struct jh7110_isp_obc_setting {
+	__u32 enabled;
+	struct jh7110_isp_obc_win_size win_size;
+	struct jh7110_isp_obc_gain gain[4];
+	struct jh7110_isp_obc_offset offset[4];
+};
+
+/**
+ * struct jh7110_isp_oecf_point - oecf curve
+ *
+ * @x: x coordinate.
+ * @y: y coordinate.
+ * @slope: the slope between this point and the next point.
+ */
+struct jh7110_isp_oecf_point {
+	__u16 x;
+	__u16 y;
+	__s16 slope;
+};
+
+/**
+ * struct jh7110_isp_oecf_setting - Configuration used by opto-electric conversion function
+ *
+ * @enabled: enabled setting flag.
+ * @r_curve: red pixel oecf curve.
+ * @gr_curve: green pixel oecf curve in GR line.
+ * @gb_curve: green pixel oecf curve in GB line.
+ * @b_curve: blue pixel oecf curve.
+ */
+struct jh7110_isp_oecf_setting {
+	__u32 enabled;
+	struct jh7110_isp_oecf_point r_curve[16];
+	struct jh7110_isp_oecf_point gr_curve[16];
+	struct jh7110_isp_oecf_point gb_curve[16];
+	struct jh7110_isp_oecf_point b_curve[16];
+};
+
+/**
+ * struct jh7110_isp_r2y_matrix - RGB to YUV color conversion matrix
+ *
+ * @m: The 3x3 color conversion matrix coefficient.
+ */
+struct jh7110_isp_r2y_matrix {
+	__s16 m[9];
+};
+
+/**
+ * struct jh7110_isp_r2y_setting - Configuration used by RGB To YUV
+ *
+ * @enabled: enabled setting flag.
+ * @matrix: RGB to YUV color conversion matrix.
+ */
+struct jh7110_isp_r2y_setting {
+	__u32 enabled;
+	struct jh7110_isp_r2y_matrix matrix;
+};
+
+/**
+ * struct jh7110_isp_sat_curve - Saturation curve
+ *
+ * @yi_min: the minimum input Y value.
+ * @yo_ir: the ratio of Y output range to input range.
+ * @yo_min: the minimum output Y value.
+ * @yo_max: the maximum output Y value.
+ */
+struct jh7110_isp_sat_curve {
+	__s16 yi_min;
+	__s16 yo_ir;
+	__s16 yo_min;
+	__s16 yo_max;
+};
+
+/**
+ * struct jh7110_isp_sat_hue_info - Chroma Saturation Hue Factor
+ *
+ * @cos: COS hue factor.
+ * @sin: SIN hue factor.
+ */
+struct jh7110_isp_sat_hue_info {
+	__s16 cos;
+	__s16 sin;
+};
+
+/**
+ * struct jh7110_isp_sat_info - Saturation information
+ *
+ * @gain_cmab: Chroma saturation magnitude amplification base for gain.
+ * @gain_cmmd: Chroma saturation magnitude amplification delta for gain.
+ * @threshold_cmb: Chroma saturation magnitude base threshold.
+ * @threshold_cmd: Chroma saturation magbitude delta threshold.
+ * @offset_u: Chroma saturation U offset.
+ * @offset_v: Chroma saturation V offset.
+ * @cmsf: Chroma saturation magbitude scaling factor.
+ */
+struct jh7110_isp_sat_info {
+	__s16 gain_cmab;
+	__s16 gain_cmmd;
+	__s16 threshold_cmb;
+	__s16 threshold_cmd;
+	__s16 offset_u;
+	__s16 offset_v;
+	__s16 cmsf;
+};
+
+/**
+ * struct jh7110_isp_sat_setting - Configuration used by Saturation
+ *
+ * @enabled: enabled setting flag.
+ * @curve: Saturation curve.
+ * @hue_info: Chroma Saturation Hue Factor.
+ * @sat_info: Saturation information.s
+ */
+struct jh7110_isp_sat_setting {
+	__u32 enabled;
+	struct jh7110_isp_sat_curve curve;
+	struct jh7110_isp_sat_hue_info hue_info;
+	struct jh7110_isp_sat_info sat_info;
+};
+
+/**
+ * struct jh7110_isp_sharp_weight - Sharpe weight
+ *
+ * @weight: Sharpen filter weight.
+ * @recip_wei_sum: Sharpen amplification filter weight normalization factor.
+ */
+struct jh7110_isp_sharp_weight {
+	__u8 weight[15];
+	__u32 recip_wei_sum;
+};
+
+/**
+ * struct jh7110_isp_sharp_strength - Sharpen strength
+ *
+ * @diff: Sharpen Edge amplification delta level.
+ * @f: Sharpen Edge amplification factor.
+ * @s: Sharpen Edge amplification factor slope.
+ */
+struct jh7110_isp_sharp_strength {
+	__s16 diff[4];
+	__s16 f[3];
+	__s32 s[3];
+};
+
+/**
+ * struct jh7110_isp_sharp_setting - Configuration used by Sharpen
+ *
+ * @enabled: enabled setting flag.
+ * @weight: Sharpe weight.
+ * @strength: Sharpen strength.
+ * @pdirf: Positive Factor Multiplier.
+ * @ndirf: Negative Factor Multiplier.
+ */
+struct jh7110_isp_sharp_setting {
+	__u32 enabled;
+	struct jh7110_isp_sharp_weight weight;
+	struct jh7110_isp_sharp_strength strength;
+	__s8 pdirf;
+	__s8 ndirf;
+};
+
+/**
+ * struct jh7110_isp_ycrv_curve - Y Curve parameters table
+ *
+ * @y: Y curve L parameters value.
+ */
+struct jh7110_isp_ycrv_curve {
+	__s16 y[64];
+};
+
+/**
+ * struct jh7110_isp_ycrv_setting - Configuration used by Y Curve
+ *
+ * @enabled: enabled setting flag.
+ * @curve: Y Curve parameters table.
+ */
+struct jh7110_isp_ycrv_setting {
+	__u32 enabled;
+	struct jh7110_isp_ycrv_curve curve;
+};
+
+/**
+ * struct jh7110_isp_sc_config - statistics collection crop configure
+ *
+ * @h_start: Horizontal starting point for frame cropping.
+ * @v_start: Vertical starting point for frame cropping.
+ * @sw_width: Width of statistics collection sub-window.
+ * @sw_height: Height of statistics collection sub-window.
+ * @hperiod: Horizontal period.
+ * @hkeep: Horizontal keep.
+ * @vperiod: Vertical period.
+ * @vkeep: Vertical keep.
+ */
+struct jh7110_isp_sc_config {
+	__u16 h_start;
+	__u16 v_start;
+	__u8 sw_width;
+	__u8 sw_height;
+	__u8 hperiod;
+	__u8 hkeep;
+	__u8 vperiod;
+	__u8 vkeep;
+};
+
+/**
+ * struct jh7110_isp_sc_af_config - statistics collection auto focus configure
+ *
+ * @es_hor_mode: Horizontal mode.
+ * @es_sum_mode: sum mode.
+ * @hor_en: Horizontal enable.
+ * @ver_en: Vertical enable.
+ * @es_ver_thr: Vertical threshold.
+ * @es_hor_thr: Horizontal threshold.
+ */
+struct jh7110_isp_sc_af_config {
+	__u8 es_hor_mode;
+	__u8 es_sum_mode;
+	__u8 hor_en;
+	__u8 ver_en;
+	__u8 es_ver_thr;
+	__u16 es_hor_thr;
+};
+
+/**
+ * struct jh7110_isp_sc_awb_ps - statistics collection auto white balance pixel sum
+ *
+ * @awb_ps_rl: Lower boundary of R value for pixel sum.
+ * @awb_ps_ru: Upper boundary of R value for pixel sum.
+ * @awb_ps_gl: Lower boundary of G value for pixel sum.
+ * @awb_ps_gu: Upper boundary of G value for pixel sum.
+ * @awb_ps_bl: Lower boundary of B value for pixel sum.
+ * @awb_ps_bu: Upper boundary of B value for pixel sum.
+ * @awb_ps_yl: Lower boundary of Y value for pixel sum.
+ * @awb_ps_yu: Upper boundary of Y value for pixel sum.
+ * @awb_ps_grl: Lower boundary of G/R ratio for pixel sum.
+ * @awb_ps_gru: Upper boundary of G/R ratio for pixel sum.
+ * @awb_ps_gbl: Lower boundary of G/B ratio for pixel sum.
+ * @awb_ps_gbu: Upper boundary of G/B ratio for pixel sum.
+ * @awb_ps_grbl: Lower boundary of (Gr/R + b/a * Gb/B) for pixel sum.
+ * @awb_ps_grbu: Upper boundary of (Gr/R + b/a * Gb/B) for pixel sum.
+ */
+struct jh7110_isp_sc_awb_ps {
+	__u8 awb_ps_rl;
+	__u8 awb_ps_ru;
+	__u8 awb_ps_gl;
+	__u8 awb_ps_gu;
+	__u8 awb_ps_bl;
+	__u8 awb_ps_bu;
+	__u8 awb_ps_yl;
+	__u8 awb_ps_yu;
+	__u16 awb_ps_grl;
+	__u16 awb_ps_gru;
+	__u16 awb_ps_gbl;
+	__u16 awb_ps_gbu;
+	__u16 awb_ps_grbl;
+	__u16 awb_ps_grbu;
+};
+
+/**
+ * struct jh7110_isp_sc_awb_ws - statistics collection auto white balance weight sum
+ *
+ * @awb_ws_rl: Lower boundary of R value for weight sum.
+ * @awb_ws_ru: Upper boundary of R value for weight sum.
+ * @awb_ws_grl: Lower boundary of Gr value for weight sum.
+ * @awb_ws_gru: Upper boundary of Gr value for weight sum.
+ * @awb_ws_gbl: Lower boundary of Gb value for weight sum.
+ * @awb_ws_gbu: Upper boundary of Gb value for weight sum.
+ * @awb_ws_bl: Lower boundary of B value for weight sum.
+ * @awb_ws_bu: Upper boundary of B value for weight sum.
+ */
+struct jh7110_isp_sc_awb_ws {
+	__u8 awb_ws_rl;
+	__u8 awb_ws_ru;
+	__u8 awb_ws_grl;
+	__u8 awb_ws_gru;
+	__u8 awb_ws_gbl;
+	__u8 awb_ws_gbu;
+	__u8 awb_ws_bl;
+	__u8 awb_ws_bu;
+};
+
+/**
+ * struct jh7110_isp_sc_awb_point - statistics collection auto white balance point
+ *
+ * @weight: Weighting value at point.
+ */
+struct jh7110_isp_sc_awb_point {
+	__u8 weight;
+};
+
+/**
+ * struct jh7110_isp_sc_awb_config - statistics collection auto white balance configure
+ *
+ * @ps_config: statistics collection auto white balance pixel sum.
+ * @awb_ps_grb_ba: auto white balance b/a value.
+ * @sel: input mux for statistics collection auto white balance.
+ * @ws_config: statistics collection auto white balance weight sum.
+ * @awb_cw: Weighting value at 13x13 point.
+ * @pts: statistics collection auto white balance point.
+ */
+struct jh7110_isp_sc_awb_config {
+	struct jh7110_isp_sc_awb_ps ps_config;
+	__u8 awb_ps_grb_ba;
+	__u8 sel;
+	struct jh7110_isp_sc_awb_ws ws_config;
+	__u8 awb_cw[169];
+	struct jh7110_isp_sc_awb_point pts[17];
+};
+
+/**
+ * struct jh7110_isp_sc_setting - Configuration used by statistics collection
+ *
+ * @enabled: enabled setting flag.
+ * @crop_config: statistics collection crop configure.
+ * @af_config: statistics collection auto focus configure.
+ * @awb_config: statistics collection auto white balance configure.
+ */
+struct jh7110_isp_sc_setting {
+	__u32 enabled;
+	struct jh7110_isp_sc_config crop_config;
+	struct jh7110_isp_sc_af_config af_config;
+	struct jh7110_isp_sc_awb_config awb_config;
+};
+
+/**
+ * struct jh7110_isp_params_buffer - StarFive JH7110 ISP Parameters Meta Data
+ *
+ * @enable_setting: enabled setting module (JH7110_ISP_MODULE_* definitions).
+ * @wb_setting: Configuration used by auto white balance gain.
+ * @car_setting: Configuration used by color artifact removal.
+ * @ccm_setting: Configuration used by color correction matrix.
+ * @cfa_setting: Configuration used by demosaic module.
+ * @ctc_setting: Configuration used by crosstalk remove.
+ * @dbc_setting: Configuration used by defect bad pixels correction.
+ * @dnyuv_setting: Configuration used by yuv domain denoise.
+ * @gmargb_setting: Configuration used by RGB gamma.
+ * @lccf_setting: Configuration used by lens correction cosine fourth.
+ * @obc_setting: Configuration used by optical balck compensation.
+ * @oecf_setting: Configuration used by opto-electric conversion function.
+ * @r2y_setting: Configuration used by RGB To YUV.
+ * @sat_setting: Configuration used by Saturation.
+ * @sharp_setting: Configuration used by Sharpen.
+ * @ycrv_setting: Configuration used by Y Curve.
+ * @sc_setting: Configuration used by statistics collection.
+ */
+struct jh7110_isp_params_buffer {
+	__u32 enable_setting;
+	struct jh7110_isp_wb_setting wb_setting;
+	struct jh7110_isp_car_setting car_setting;
+	struct jh7110_isp_ccm_setting ccm_setting;
+	struct jh7110_isp_cfa_setting cfa_setting;
+	struct jh7110_isp_ctc_setting ctc_setting;
+	struct jh7110_isp_dbc_setting dbc_setting;
+	struct jh7110_isp_dnyuv_setting dnyuv_setting;
+	struct jh7110_isp_gmargb_setting gmargb_setting;
+	struct jh7110_isp_lccf_setting lccf_setting;
+	struct jh7110_isp_obc_setting obc_setting;
+	struct jh7110_isp_oecf_setting oecf_setting;
+	struct jh7110_isp_r2y_setting r2y_setting;
+	struct jh7110_isp_sat_setting sat_setting;
+	struct jh7110_isp_sharp_setting sharp_setting;
+	struct jh7110_isp_ycrv_setting ycrv_setting;
+	struct jh7110_isp_sc_setting sc_setting;
+};
+
+/**
+ * Statistics Collection Meta Data Flag
+ */
+#define JH7110_ISP_SC_FALG_AE_AF		0x0
+#define JH7110_ISP_SC_FALG_AWB			0xffff
+
+#pragma pack(1)
+
+/**
+ * struct jh7110_isp_sc_buffer - StarFive JH7110 ISP Statistics Collection Meta Data
+ *
+ * @y_histogram: Y histogram data for saturation control.
+ * @reserv0: reserve byte.
+ * @bright_sc: bright statistic. If flag is JH7110_ISP_SC_FALG_AE_AF, This field is
+ *             saved auto exposure and auto focus. If flag is JH7110_ISP_SC_FALG_AWB,
+ *             This field is saved auto white balance.
+ * @reserv1: reserve byte.
+ * @ae_hist_y: Y histogram for auto exposure.
+ * @reserv2: reserve byte.
+ * @flag: Statistics Collection Meta Data Flag (JH7110_ISP_SC_FALG_* definitions)
+ */
+struct jh7110_isp_sc_buffer {
+	__u32 y_histogram[64];
+	__u32 reserv0[33];
+	__u32 bright_sc[4096];
+	__u32 reserv1[96];
+	__u32 ae_hist_y[128];
+	__u32 reserv2[511];
+	__u16 flag;
+};
+
+#pragma pack()
+
+#endif
-- 
2.25.1


