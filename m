Return-Path: <linux-kernel+bounces-32057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C913B8355D3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71866282146
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342ED37163;
	Sun, 21 Jan 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YwjX9TtZ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2103.outbound.protection.outlook.com [40.92.107.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F8364DE;
	Sun, 21 Jan 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841630; cv=fail; b=OOdJ5qkX2TsnfeP8NkAe5CU1Zs8KIYp6ebzVw9wmsHvqg0UhUsdvlUHfR+sQbg6XWChpMJJ43x/1Maf11CH5HgQakPmsQSGbErmeHiBvJ4tfEnJjYMGo1/WE2Oe6HXI0mzqosyL5l6KJYdN8wUEuuwDVOon6fBdcmYabZ/Honxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841630; c=relaxed/simple;
	bh=VxZmDOoR3xLARAU3Ux+V/1/evUili5ak2uEsv32+E1w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AfuPgvf1BEWU3CIeowjYBJGRyO8/cBUbHQ9C4TZkir2cQ1EC8diwkOvNwZoges1krAlmB3cDkLgZnNOOS2taeWC2cpJsa8CAVpqDEa990PdiVgPljqU5BJ+HlELzb+wwjxpKkIxeJ0AHexKKYeCq9y7BDGxt4zWBSWttkoZvJK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YwjX9TtZ; arc=fail smtp.client-ip=40.92.107.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY7VbF9T8f0B0JU7+MFGSdYQwMOq4dMvpBQip4aUFTM9wQDBeJhRfogaQrTd6DPf7w0TQlg2we//Zq5KiH6+AHZVE+zfEjYjg2G9wRF4H86rC/EasUZIyNxZ+skBmmh3DDUfha0munQFshd6qdCkrmLxqjRViXZAk2hw0FuUneDtWphgTrNGuhea0VxHsg7UNQ9PS01sAc0FAaGgmx/6EBRj0ZkQ2YeGgM0pv9T5mP3597CUr7FZF25ejxfMcGpiKoqDWdwd9EfrWRoSY7RNltU8Ay6hO88SDgfC4RbiKYx0zoXv34c+D35A11mEl2OQ3hwU13+oCtlyAWU14+pRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlNulvPlUtsfCmjWal2T/iKOa6dTgiIQqxi0OOuGoss=;
 b=IJ8IB4IBfpTMj7UEAQ3iVYFkYRFiaNMwUL421vV1T9RU17U+Yo+g7KBqqp7zZ+e8E7P4wS7aUvDVWXYo2MIhTuoLm76mGJIUzVNABOFqiJJZaNXtu3xMDzPQZFwhWg2bYSQG2xSqADACDfjLVB2OXP1j81O7UOtgxOqIxMZ/Oj6aiNQhSe49N4tBxoze1pfeam/e65C2lFU9m73M8urQvkGKMsN40TyGIly6i1PBVvCvEnbjO9ctjSLqsQwE6Y4QkrSN+fC4NXspFMM42mdTChQd/IPLYzNc2K47rnrL18mdfOOkZNbfrgmt7gmiIWfZkEmHtKxwWMz78rwWLTTImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlNulvPlUtsfCmjWal2T/iKOa6dTgiIQqxi0OOuGoss=;
 b=YwjX9TtZSohjAdCdKk8uR7GvRE1KV59MZu0xlrAJTIFWL+pyvG8qcJEQjpRfvVg5kmR/NJ30hyieyE9S6bdJkyQ+1yo2O0qocyMDtlsRuVSysbK3FY5TpoxHgas03bBZobaht0G3dPCdyVGDkP/nHob35TfYALoodg1bmGsI+EAETBOqQUOJd6PCCJVRZM4KwQ4N3hUDyaIGxLeikAXgNS0gVwGdjyF2gqzwwyeFcvTEHrDHeBF3XeMPPBHYOAj0WyZm6ZKzMkw9an6dn9NR3LJG1PlJfrT4diiT82YU3g6+wz9cQZt/BeC8TO/3XHaABEr0U86ryZFrX9vFNmXNUg==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6693.apcprd01.prod.exchangelabs.com
 (2603:1096:604:273::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Sun, 21 Jan
 2024 12:53:44 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:53:44 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: agross@kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH] arm64: dts: qcom: ipq5018-rdp432-c2: correct board name
Date: Sun, 21 Jan 2024 20:52:52 +0800
Message-ID:
 <TYZPR01MB55564BE24CE8718DBD4644A2C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1S07Ob5cJz+mYpdRcf1JOdizd+Xmm7WPT2/FF1OdynRGRzSdHqu0rw==]
X-ClientProxiedBy: PH7PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:510:323::17) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121125252.3330857-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f9446f-7f3c-450e-4d1f-08dc1a80000a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FOfwi88R3aWH/tK+v1XOaDs16cxHogPy7/c4y8ipzaTwGGdr+eUlLbdl4nyBi44SSmE8Om35GrguAgEUCmJNbSf4SeRoKrBh4w/hIuDF2vv8YlY3Jjhm3T2KOnuC8dhg6K3Rnd56BEscxr/9yKFmAR/izQjQr2tYVQqiEJoPt7PzPZj8/ZJFL2mp+2EYyqKeiARKNEV6xBzUJi3OOneokg4F+JV9P3/+kiaotMP+XgBi6rgscH45x2qywtClNcQ46nTl9Gfq9Bb//RSrYDGLw9jjRM2Rtc9Rev6GMJ55oifNh6CmYmzEHE7bEkPoStokPuXZ5f1G62UG/dp4geosErC7tPXD1oNmT5uBJAUAesPjP51EM6TNlwKNer8fEpg6P1GjQmzm95YWn4VqkFgBuUS7U/qcZ2903qiTOfsvNrDMklDFpCHQ40PyLTytxuyf5wy/luqdxktMrncuUyw60piMHD6LvjxnwcaaIbnO/y6kd8J5tTdDapcUijBWVammXOmBecvNfK1tj1Vw46UxmoypfjF1VS6IOphFflf9cvVyAmyC8IUL83/682y19J77YauYg+dj2/CbBD6c2oZRIuhOlAWhzGBVI62CG+SPojE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ut+HlQ4HGzmmomp4JT6QTsGPsLGuTjIDafebAgf861tpUxgMgKQ+cj0ZlH5?=
 =?us-ascii?Q?MRCphJSrQCbTnliB72YzNY7k2zAwxy16RYOdGPKSTHS1va++GUyiwRqwEV0H?=
 =?us-ascii?Q?zm4kLgdtA86WmBQQhcCwx0mvlCidVJCdPS9axEGVFarNiEEtzX2SLY1UptM4?=
 =?us-ascii?Q?mlX30WREjdFzMOF22k18UeE+iF/Jgkk6HeLlm3Nygb7iBRCR/ALpdjOgdqoq?=
 =?us-ascii?Q?rT8F7JZuW9dsBHP+1Y2Jn4lOBFANRx/iDOarO9amWUw9ZaaIHrwkpYHXJffG?=
 =?us-ascii?Q?BJt8HRAsNY/drUdF+b+xApyr2OpBVMOIq5OtCqG5TvUkS4F8bcEQPdSy6ak9?=
 =?us-ascii?Q?ldmLGX2ntiGvi+QeogF81DY16x0goUcOQSfjA4Nuib8hBtYH7GIEGhIAHgpe?=
 =?us-ascii?Q?4tjyGQhUC3V9TXrtiRYIoPDBSeZMfJTBCUiAyd5TlK1zM/X5Yd9JQQoj2WJs?=
 =?us-ascii?Q?CIpLd/uLY+9eWymVrQJvEq03WKcIJ33VtI895IpSCzYofiCed1CH2ccElxPH?=
 =?us-ascii?Q?J7Cgrr+lWzGFxd9XZaZaAmbo3Y7RF1EzxzTYLcMUewoniPXTcgiYPus+2jnV?=
 =?us-ascii?Q?TcJ7K/0brpNc4n27Scdv/e+g65q3XHeRdzKgM2WkjbMsDgF4vYGs3Ug4miqi?=
 =?us-ascii?Q?5Ll3V7XsTkAiDGWNb3/HIEwmNGiHQKKNWN1K+Li4qb1Q3GntpyeTfwTVJloe?=
 =?us-ascii?Q?0MQdtbZ1UvaktE1qG6bWAJgA/2f8r9PBkWmK5kQ56UNyTt3xNAhDbup25Z9g?=
 =?us-ascii?Q?8HUM6HkGFe4+Jbz0GmlJGouoBhyRMvMr0rqZGfq9wlEDeP/2kJKrIDQwHFGd?=
 =?us-ascii?Q?wDZXuz3TEc4efmP7B3OhZwbTPZhImIjbGzqQAyoTF0FhW73h9Ib6vFztInX9?=
 =?us-ascii?Q?/A/SoQp2iW43KLHgyjoCzXRbBZZ+9PIsJJ/jw/ntS43qS4u+gk1miqW3Oh5b?=
 =?us-ascii?Q?yzB0tgW0k5V4jniuehhLZ4Bc2S01/iiQnANnPTnNaoGTCWtiGBY0KpJvsAXl?=
 =?us-ascii?Q?zXS+my6lrfI69vhcSTpZoLbAPBMTSHWbrHc/eJ/lcIijlayJU9lZqm0oNKH2?=
 =?us-ascii?Q?zX13pszVOs7G1ZfrhHuv9Th8SswgjmUzcGq9TMOJOAHZpwUCWZt48OJFCpoa?=
 =?us-ascii?Q?NvYS6Cwyx6Zslif85K5tMoG2s5y/tlAL/P3jxObjEKrzuZcjFTd/Yrwmc/Hv?=
 =?us-ascii?Q?vGCdLKFURVz8fJfeuSVTWjiUsBxvQaOtiGYRAlZgv2csmoyH2w/ujY7m5oCg?=
 =?us-ascii?Q?36sEYVQuwrJBvzByrbS7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f9446f-7f3c-450e-4d1f-08dc1a80000a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:53:44.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6693

According to Qualcomm document:
  MP03.1 is RDP404
  RDP432 is MP03.5

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index 074b78d7939c..f7e8b5af6b44 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * IPQ5018 MP03.1-C2 board device tree source
+ * IPQ5018 MP03.5-C2 board device tree source
  *
  * Copyright (c) 2023 The Linux Foundation. All rights reserved.
  */
-- 
2.40.1


