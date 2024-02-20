Return-Path: <linux-kernel+bounces-72720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AEC85B7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B3A1F2998D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306D167C46;
	Tue, 20 Feb 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="lVeD0BZ6"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2110.outbound.protection.outlook.com [40.107.7.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFA66B5C;
	Tue, 20 Feb 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422029; cv=fail; b=N8uZoYgRZziaNeo0f2X3jKGFcVG5UTvlmI34CWZ9Y2PQpNHpjgxm3p92q66W+NP1VFTcrugkwv+dYCq0Nw6Dj8eAriOcN2imubC1ez9vLBiKQPcpV4e9TWUdGqhIO6IqJs2zYwqjJKBxX1I1S8Wk7odcc3D9IojVbKujvwmHrPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422029; c=relaxed/simple;
	bh=obBxQWVh8Y0Fgnw+fpdRah3Rpr9ZAPUSz141wf1Voiw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XnSe2ChKPsSCzYU8NOhmWjrtKSdHMudq1I7V7FXIMRGugE8Mk5EscSynWmAmLXgPX07ba+oydOHh4g2PGrpuiPERdGt2Y1YnOI+EqaMPWWkq1ny5RNGfmvTnvqYNfB0OZmsVwM8XlvzJbmVIDgeHvWJOj5jY5HSPP1vRk9rGTAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=lVeD0BZ6; arc=fail smtp.client-ip=40.107.7.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk+iY7saq2bdwldOFQyts1l25iZU4KpAZGjXzeswteytt5cG1SsmrGiLt6Y8X7JPM0Rx4ulqJ3+Q7MzesHB4OwcyQNRGjKZPH9/7hapyvq4zHhcF+TwsgnCfxw5jAL5/zRvpycKg+qB81AfIiYQFcdw6I0gkMJDchd8o6LhNpWMV+ED3b2uaugDZ33W2N3tlSy4yaGHW+XPSfAVz0PNJmi8xTUga3q7s6kqLvO6zM38+1c5yq8k/CC1Gi9m3bKFlAU6vByLmzdfU7Hsu8Onrk8Jw9S85hw6RcriTKVF1VyT/A0ZawsGeM71PlLW66NVs6oV2KGGu4yNYOw3+RYNHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boH9GrW7+OUCqgPgiUWbbmJsWcS2u7Pz66CwVac9ZVo=;
 b=XSY3WR75ySmIupK2v3gRi/3+mhanD5T5AuSqLL8v7sRHP2MbrsZDJSgqO4r0YIzG52k0fSF5KoN7bjmPytO3pqgsBHkPUibvfZvXkrVdYmkNJcsMFtqbn+PoKQVfuK4/8XnM5NooMZiQBid7oJoTn0a4afjkae0imk+hbkprSh2WGdWi5+o9/+bYRmpKhAMbr54iO7MsnPSIoRryO0bNRVmaGDjW5wpy7g1+av3Qt6uik8QXQa1I/KtLiv2FDSju/Ef0NWZEerEe3R+yLi6XX1VCv3WJbl7SVrVrhms/+ff8iXOBMHxJ9LjV0zh+56Ksd9PBFiKLK0Z5giUt3wBPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boH9GrW7+OUCqgPgiUWbbmJsWcS2u7Pz66CwVac9ZVo=;
 b=lVeD0BZ6ENSzdJyKGb18d/ABOFpY6tVWLjZS990eQCby9bKBlESBe5iiVIns9R65mnhi68Q1R5O3avyD8ymKkzwtbk3Ye7/H6+Q+KROIztq1BlN8+osyYwkYH7VYYINbcg+jUBsesfMwl/stz/j4WbopKnBdnfq3j1VUf3IszM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV1PR08MB7681.eurprd08.prod.outlook.com (2603:10a6:150:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Tue, 20 Feb
 2024 09:40:21 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:40:20 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Tue, 20 Feb 2024 10:39:22 +0100
Subject: [PATCH 12/14] media: rockchip: cif: make register access variant
 specific
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-12-2680a1fa640b@wolfvision.net>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
To: Mehdi Djait <mehdi.djait.k@gmail.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=4765;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=obBxQWVh8Y0Fgnw+fpdRah3Rpr9ZAPUSz141wf1Voiw=;
 b=Y2lL2xHpFYvCYYNgdHWXnRAHBHxd/4wiFj8uYdTv9u/PTM5aTlb9Jy2IiOZlpk69fGls2DieI
 PNf8SfYla2QDJeBbbZut4T6pxsk4aTqKuif1wKNzBVMk0tIM/bOqfVu
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=9ral3sulLe95bLcbaiNXTgUTRiBayRBEFZ5OVIEHp+0=
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV1PR08MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 35172da9-deed-42d6-8b22-08dc31f7f429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TQLhUpl5/KGF8kcfX2RDZeuXlTbKXeiBzoY3w2rKUT0NyNrcqNrLMJIs3J09IZfE8MBe9yHKz5Zxn/Q9VWYSON2T5+aOunXLTZtRWsy9bwlAoEv/ejhn+mmsWO8WXpCxWSn+JEsLl2ugORBiZyhpQra3bMmeJolHU9g3cyCmyQWp2Z6+9RXqg95Ai6zFr+YDRaEKQ+B9ihtAh3K0Rl7CZjueft6JzZu6TeOZtx012avTtQ3jkhyEguOVb4s3EjyTLo2qM0XJO/hFSXCdX50NHDbvYEDYvA3TJBS253WfsZWqTO9JO8o/E0xD7gIOMIslWPpQHUjhADcICZ6wQZMcf8eUMUd9yWhWEGYzNvrwOcM96oSV5QcbNMKuoMgBMPgbl89JVQc11CFIcxeQBekEuUYblS9j3ZaPI01TKAky2S9CmAvEsuChIJSQMk+fOby2X4NOu0kmB4mLDeb9561b0WUl9FJGGA73bewQWXRmnRhv3BxuarUFD3PS+HVJ0MMsl1DWg9Frcu7BSGRd2CwzVvq5TDo2gHqfItsAnZVTNl+vZb600hKiX/xZ9UDUOPyTJ+fKAkOcM/kdm24yld1gtWZ6Sno/w6xNEFAUbCDA4r9HWi1T1jfNJ0WpNory/I62CMxvGFDlIFBlOm06Y1HhFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vys1bGJxRmZFRk9GS01XcE9ianZMUndzTWhraUl2ZXZNMWlhRnNFVU51S0Vr?=
 =?utf-8?B?NUtxRFFubTRRdGlqZGs5OFBvb1ZMcENDOXpzM293a1RBMXQ5eWhRaDZ3QUtJ?=
 =?utf-8?B?dWd3THpRam1UQjU3dVlqcHdIUTZ2QUFKY2ZFbXB2dnBDK2haamJ4TjZCaStR?=
 =?utf-8?B?N1U1ellxVDBqZHhwcDQvaUZpbCtpd2wwVUJRRGxxMURSdkZJVW95QTRSVWM1?=
 =?utf-8?B?OHJEdnFrTEdyNEpxWVpFRUJONjVVZWJoMHY1czlDNGIyZHhzcVd5b0cvem5x?=
 =?utf-8?B?TVdJRlg5cTF2d3FLeTl6Skl6NXlKVEpURTlwSWsxcmMwVTZQQm4rVE54UEFK?=
 =?utf-8?B?MVpJUUovc0piOWZNL0JLM1hPZ2dnUUdJVE5NMkMyQklTa1RYeEx5Z1ZrY1hM?=
 =?utf-8?B?L21ndWZ6OEJvV1VXTmFQYUtlWktCSzQxNWdvenM2QTIzUlV2cUhYZkJjcFYw?=
 =?utf-8?B?VjJVeUNMVmh5b1N3djFzaXdVeXYrbUtwejduT2pwK0hUMjk3RGVQekd0blFx?=
 =?utf-8?B?SUk4bG5QZnFwb1V5ZWhVVkR3eFlIMDEwNjMzb21KRWhLMU1qOTh2YnJOMStY?=
 =?utf-8?B?eHVDSDBvOENsaU1qUlBoYXI0RzBWVm9YR2w4bVBOZ3grUklzT2dyclFUUmNR?=
 =?utf-8?B?eWJiVlEvbVV2R01RVmZRTTJDQVBPRUhTOHNIZU5zeUFOL0hma21lWDBybWlp?=
 =?utf-8?B?RkJLdDM4TnRPdVIvSitDcDN2Umw0c1AxMUpocFB2S1pITnNpTjRIZ2V5L2Uz?=
 =?utf-8?B?eGdidktTaDRaV09nK001cFpsSkh6bXQvMDhrd3ZHRUdDMFU1cXlPazkrV1dS?=
 =?utf-8?B?bnpCY2J0VVpUMVh0a2FMbTcvSTdUeThVSThjTnZkZDNPYUZreGpiYUpHcjhy?=
 =?utf-8?B?M0pPV0VDZmZrdmVEaFl3elBiOVF5clpOTm5hVVR3ZFNwdHRsV2EvaE04cWxN?=
 =?utf-8?B?MkFvSC9WNTJBSVRnY0FJSlhJaERpcms5MmpjUnFHNjQ5UEFkZkdZUFNSamhl?=
 =?utf-8?B?M3pGTXBFUnhKSlByR2hJSHhWSEpkeG1wVm1iVE1WQjN2a3VCWEt6N3NXekxK?=
 =?utf-8?B?RnZUUE1RK2psbitxWmYreDVMRXZBdHh4TU44Vm8zUmdzdGM1N3VnS3lFTlZC?=
 =?utf-8?B?L0xHelFzWFBKN2lsbjJTZDgrM09sdHNlVzUwV3QrT3BDdlkvY2FPRlkrYnd3?=
 =?utf-8?B?UWhqd0FuelNQWFVEVTN5dVRkTkV5Rno0aHVnOERZSSs0RmdITzdYTiszRHlH?=
 =?utf-8?B?QllUWlg3VHdSTE0wVDdkcEUwM280U0pEcW5VR2R5OUJjNXpOT2d5WmhnV0x4?=
 =?utf-8?B?dDlCYkdRRkM3UUhTa280clNFU2doOGdYV1REclYrUDVDczJ0ZlhWRVU2N1Mz?=
 =?utf-8?B?Y2hqd1lYS2QyUHdMbGRlVi8zM0JuRTcyZjdVYmxlMEJTdTFYYThNR0V3UVY1?=
 =?utf-8?B?VTFWQXVQamFmQlhkRlBtRlV1ckJkdG83RTR5RG5wOHdBOGZIY2hJaWhkS2M1?=
 =?utf-8?B?RXpoUWIyUFZmYytkZzRTWmJOYWNZK09SQXVlTElFT3VRL1F5bms1Z0VwVUtt?=
 =?utf-8?B?U3RBUUt4VkErOFBKSGFJZXdRMTZaVlBaZVdlVTFGdDVVeUp0U0taMUdkUU1K?=
 =?utf-8?B?a0tWSUxXcnJiQzdodVhHUzNhcjh3aEgrYm8xTjNWV3ZwV2xIY1VGUjNBbmRM?=
 =?utf-8?B?eVdyOUExSmczUmZjanlrSUlsdnpaRHJSSVczVnFiQ3h5QXVHUFhTQnVnS3lF?=
 =?utf-8?B?K1Z4b0JUL1dtaStEOEh0YnpCRkhaOGgyb255ZW9mcEhYNkhxZld4SlJJNUIx?=
 =?utf-8?B?SUg4WjlrRTNHemtLZjUzSE4xZ2hTdFM0OGszME1TSHVndHlOQmkwRXV2OSto?=
 =?utf-8?B?VHJkYkdUNlBmV1NmTUdNejZ2ajg3bVpqT2RJa0J4L21GamtmVmRHQnUxS2NR?=
 =?utf-8?B?VFVvK2g0WWU0MHpZRmJTWlcrU1Bpb0Y0eDd1bEZYQkthdHNHZXpNS0Foemx6?=
 =?utf-8?B?Q25ueDhkNUpHUi8rNmNMWTdCZmlRaXMxL2E2TnFsYW1GSkoyb2dyRVJjc3da?=
 =?utf-8?B?S2ZhYjNYWUM2SHAwbmFmWVd4blhYYkZMZTB1cFJuOERGeVk5RzIyVW5oeHlN?=
 =?utf-8?B?cFBlTCsyckptUDR2RVV2KytTU0FZNllPKzRDV1FxUm1mWUlRRW5xZnN4eXI3?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 35172da9-deed-42d6-8b22-08dc31f7f429
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:40:20.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7vTBWUv2SN1g1b9M+SfotGVwY8xgrM2/iWj59suFNjr/NAGj4o/pBxpgVaNQ42pV+7QCUOyc4Ts6Iwpn0u1q9EKY5TEFw6nCEGbfpzBeIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7681

The offsets of the Rockchip CIF registers may differ between the
different variants. Modify the cif_{read,write} methods in order
to support variant specific register offsets

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 drivers/media/platform/rockchip/cif/cif-common.h | 26 ++++++++++++-
 drivers/media/platform/rockchip/cif/cif-dev.c    | 17 +++++++++
 drivers/media/platform/rockchip/cif/cif-regs.h   | 47 ++++++++++--------------
 3 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/rockchip/cif/cif-common.h b/drivers/media/platform/rockchip/cif/cif-common.h
index e5500705eee2..7ecdc820171e 100644
--- a/drivers/media/platform/rockchip/cif/cif-common.h
+++ b/drivers/media/platform/rockchip/cif/cif-common.h
@@ -19,6 +19,8 @@
 #include <media/v4l2-device.h>
 #include <media/videobuf2-v4l2.h>
 
+#include "cif-regs.h"
+
 #define CIF_DRIVER_NAME		"rockchip-cif"
 
 #define CIF_MAX_BUS_CLK		8
@@ -101,6 +103,7 @@ struct cif_match_data {
 	int in_fmts_num;
 	void (*grf_dvp_setup)(struct cif_device *cif_dev);
 	bool has_scaler;
+	unsigned int regs[CIF_REGISTERS_MAX];
 };
 
 struct cif_device {
@@ -121,14 +124,33 @@ struct cif_device {
 	const struct cif_match_data	*match_data;
 };
 
-static inline void cif_write(struct cif_device *cif_dev, unsigned int addr,
+static inline unsigned int cif_get_addr(struct cif_device *cif_device,
+					unsigned int index)
+{
+	if (index >= CIF_REGISTERS_MAX)
+		return CIF_REGISTERS_INVALID;
+
+	return cif_device->match_data->regs[index];
+}
+
+static inline void cif_write(struct cif_device *cif_dev, unsigned int index,
 			     u32 val)
 {
+	unsigned int addr = cif_get_addr(cif_dev, index);
+
+	if (addr == CIF_REGISTERS_INVALID)
+		return;
+
 	writel(val, cif_dev->base_addr + addr);
 }
 
-static inline u32 cif_read(struct cif_device *cif_dev, unsigned int addr)
+static inline u32 cif_read(struct cif_device *cif_dev, unsigned int index)
 {
+	unsigned int addr = cif_get_addr(cif_dev, index);
+
+	if (addr == CIF_REGISTERS_INVALID)
+		return 0;
+
 	return readl(cif_dev->base_addr + addr);
 }
 
diff --git a/drivers/media/platform/rockchip/cif/cif-dev.c b/drivers/media/platform/rockchip/cif/cif-dev.c
index e7b5ae5804ca..929ea39dd832 100644
--- a/drivers/media/platform/rockchip/cif/cif-dev.c
+++ b/drivers/media/platform/rockchip/cif/cif-dev.c
@@ -283,6 +283,23 @@ static const struct cif_match_data px30_cif_match_data = {
 	.in_fmts = px30_in_fmts,
 	.in_fmts_num = ARRAY_SIZE(px30_in_fmts),
 	.has_scaler = true,
+	.regs = {
+		[CIF_CTRL] = 0x00,
+		[CIF_INTEN] = 0x04,
+		[CIF_INTSTAT] = 0x08,
+		[CIF_FOR] = 0x0c,
+		[CIF_LINE_NUM_ADDR] = 0x10,
+		[CIF_FRM0_ADDR_Y] = 0x14,
+		[CIF_FRM0_ADDR_UV] = 0x18,
+		[CIF_FRM1_ADDR_Y] = 0x1c,
+		[CIF_FRM1_ADDR_UV] = 0x20,
+		[CIF_VIR_LINE_WIDTH] = 0x24,
+		[CIF_SET_SIZE] = 0x28,
+		[CIF_SCL_CTRL] = 0x48,
+		[CIF_FRAME_STATUS] = 0x60,
+		[CIF_LAST_LINE] = 0x68,
+		[CIF_LAST_PIX] = 0x6c,
+	},
 };
 
 static const struct of_device_id cif_plat_of_match[] = {
diff --git a/drivers/media/platform/rockchip/cif/cif-regs.h b/drivers/media/platform/rockchip/cif/cif-regs.h
index b8500f0a9ac1..2ce756fde204 100644
--- a/drivers/media/platform/rockchip/cif/cif-regs.h
+++ b/drivers/media/platform/rockchip/cif/cif-regs.h
@@ -9,33 +9,26 @@
 #ifndef _CIF_REGS_H
 #define _CIF_REGS_H
 
-#define CIF_CTRL				0x00
-#define CIF_INTEN				0x04
-#define CIF_INTSTAT				0x08
-#define CIF_FOR					0x0c
-#define CIF_LINE_NUM_ADDR			0x10
-#define CIF_FRM0_ADDR_Y				0x14
-#define CIF_FRM0_ADDR_UV			0x18
-#define CIF_FRM1_ADDR_Y				0x1c
-#define CIF_FRM1_ADDR_UV			0x20
-#define CIF_VIR_LINE_WIDTH			0x24
-#define CIF_SET_SIZE				0x28
-#define CIF_SCM_ADDR_Y				0x2c
-#define CIF_SCM_ADDR_U				0x30
-#define CIF_SCM_ADDR_V				0x34
-#define CIF_WB_UP_FILTER			0x38
-#define CIF_WB_LOW_FILTER			0x3c
-#define CIF_WBC_CNT				0x40
-#define CIF_CROP				0x44
-#define CIF_SCL_CTRL				0x48
-#define CIF_SCL_DST				0x4c
-#define CIF_SCL_FCT				0x50
-#define CIF_SCL_VALID_NUM			0x54
-#define CIF_LINE_LOOP_CTR			0x58
-#define CIF_FRAME_STATUS			0x60
-#define CIF_CUR_DST				0x64
-#define CIF_LAST_LINE				0x68
-#define CIF_LAST_PIX				0x6c
+enum cif_register {
+	CIF_CTRL,
+	CIF_INTEN,
+	CIF_INTSTAT,
+	CIF_FOR,
+	CIF_LINE_NUM_ADDR,
+	CIF_FRM0_ADDR_Y,
+	CIF_FRM0_ADDR_UV,
+	CIF_FRM1_ADDR_Y,
+	CIF_FRM1_ADDR_UV,
+	CIF_VIR_LINE_WIDTH,
+	CIF_SET_SIZE,
+	CIF_SCL_CTRL,
+	CIF_FRAME_STATUS,
+	CIF_LAST_LINE,
+	CIF_LAST_PIX,
+	CIF_REGISTERS_MAX,
+	CIF_REGISTERS_INVALID,
+};
+
 #define CIF_FETCH_Y_LAST_LINE(VAL)		((VAL) & 0x1fff)
 
 #define CIF_CTRL_ENABLE_CAPTURE			BIT(0)

-- 
2.30.2


