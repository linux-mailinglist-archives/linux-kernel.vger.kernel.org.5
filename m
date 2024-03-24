Return-Path: <linux-kernel+bounces-112667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E4887CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BE51F214AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40670182DD;
	Sun, 24 Mar 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VdyJAsNv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907F179BE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711282861; cv=fail; b=mqTlglUwfDMJH7nxBpSDnRfUrXjP/moQrVWqHlUvZLswz9tJBeLV/OZupA1GLrUNjvXdEpmSUcfUU5myJHmWqxoovlp2CXMZHQukIV6lNOOO/xcoJrXp0U7iTPKwIsMOOIOzhXBeI7729aYmS0VXkN7lKQ2k5tb+i/Z844rD50g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711282861; c=relaxed/simple;
	bh=GoSpC7n6WXnV2T/mfHSFPDuzbn5LxmE/urmN3js0sCg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kN3LKLD11vNKeDnhWiU3+4x/g6QhHixHwBLiYZeB4NXr3s0UiueBDBpIf8YDBnLNEcY7v/d/DuDsaaDqeMkoHzK4mZhndipg0+Azt1ULvTM50HFaroW5Vspcw6Efmav69he1ygQ+CXAEBFoubIr5tg1i9f12oVC1ZIIxhxQ3ZIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VdyJAsNv; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLb3H0vDf3V0thM6p380iCjhw6zJT6RQ2VC1oZTC9HwyJ8d5QiONn2Oi1VtaYvLgsDU83Y81mxpgYTcc635meQHzh5cufb4RvNnBhPs9JbmKXKheyuoA1OaIo9FrPIxZon71etM6mixeCvcYH4krHvTLdDAswqwtg9nwXZHvoJm4sNDObj0C3Ajysm40u3vf5QLI396Yns5r/DEJ5jUPPS/5LdHXIXlberbsCnLcm3ayPmolpUdYZ6oiX7bI0M6CNtEGghCVdRK4VmSFKY5tfZSrkM69QKxyi/jpP0S2Qc7hRsK5hpZfQw47NF8/v09MJ787gyKi7fYjlo4XVWBtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSBBP8CdkRt26BWQnEn0Twnx5706NESRFGp7EcaHaUU=;
 b=itQGpBekUwekhdfcuY/Z0S8L79SKdJQx5cbDM+L+Gychuk64U929lg5fpvL+HmejXLj2EQMWhetx0btSZZRnpAL+RANEiICepk0QaXG5IEVVBTMU4+YKOWhVsOelV4h2Tj9Hnnl3kgMSo1SIyQ32BWad67I+b44iKheTgZH2Q4RwxyPfuQQOXc7H1mWAq+nmlMFpFfBnBPo3U2qBZcw03tbPpR4UHIynDJAha2+Z6Xc1rFbxRfOGs82jKhoS5UZ8b8v9duDS+cYgjyqnElVKG/YPQPGLxGGyMFb6VUsiEy0JwQlpQ5jPtJgfSwI5LZfE8s9dvA/S8yRhpgEG9/bXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSBBP8CdkRt26BWQnEn0Twnx5706NESRFGp7EcaHaUU=;
 b=VdyJAsNvtnZipZdR/9LnxouoYjStzer8lMGCaGkXnUvEnCc+aTuGLwK72z3ltJ1nEcuFKYU4udwhpKUNbgGx3rtwEy4WIrOIIHuRBkQl6jfvW30yLnvuI2hBGD+tiftl9vpXvZuPzk7WONOXqZv5RndhikbDyyJItgSu6kH7InU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9901.eurprd04.prod.outlook.com (2603:10a6:150:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Sun, 24 Mar
 2024 12:20:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 12:20:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 24 Mar 2024 20:29:00 +0800
Subject: [PATCH 3/3] iommu/arm-smmu-v3: support suspend/resume
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-smmu-v3-v1-3-11bc96e156a5@nxp.com>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
In-Reply-To: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Marc Zyngier <maz@kernel.org>
Cc: Bixuan Cui <cuibixuan@huawei.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711283345; l=4688;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GiSd4PlTexX48iZrMpUZF0JbBWkoDDMT3nVKob6ALg0=;
 b=Qw1qNbRzkiQXnGwnSyX4pIUbPqNQ+Aqr0AQUC1bi66PWMtK0gor0N4PGwcC4SOnugOY6F4ikt
 w95Ia4FqP/ZAr5L4tw8jvUhfY9eLH6pR31cONXOtIWJhWquCksA4kjg
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4dc8a9-8c4c-418d-92d6-08dc4bfcdbee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qbSN8UJVE/j0W3BcbLbZzXAMmXmn0i+6BuhfLJxNNiB0tFftNS3BLRVChqFTQOq8LFO3Fo71ddekqFRXhkTK8jn2qdCZhpzGktGhQHqkmt3m+DzWodh0gO3VsBHhdWqjks5+J0ZWYnzghW6ZuVvkojVEoIxRGCKUEFxXt7toFf0VxAMGRx8Ekx3sDB8rnTFuAIYTvbSDh5E0OHMTl5LpmU4aK0O8WDQqI7hiEVwxEWVvpzg0uY/65b46JQi0nA2ibUtnAVPYNrdCcnOOYwI1ApwbgeFQjRyzA9r/EIjLosDTD6pTTdHhasO3ryJ2Jv55sLy7g3BHd3+CWWgWkCZFxeI2WusaA8Sja7RUwT99e5r8LaAp1u8SW9JeBBfxkw+TAN+3Wb+46cbqjWehc7owVMhFT5qeo5Ino3xECsCUUKBlcAXXvNhG+PMeHgrCGu7uHNyzAAWG8zk74k7JBW5c+xjIc1QlObw50pxnKK15NkGPEPfgDxevywbSM/qSRetrDeONe+9s5ReqfWUkDThGqiO3ej0kbWwuXD0QAUyh149Wnr5N6PgspgbedS0noNbOIame82E3HlzPUv1PstFQ2HIk/HtQoy74fQEiDiIiI1jiw9DizY+6kYW1taKEdGN9AHZchbkRo0mRfcKTGqX3omlZdqZJzlrk5anwrYKG2VcD32aFcftePWOH4iiKGE11ScEX7Gi8rhAwWZduRBkR9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3hzMmRNQTNhUkRlMUFhS1IyalNxVnN2OVhQMGplMzJUYzN3RStWdXZwaEZL?=
 =?utf-8?B?YTF0M2Q2bHFDQzdDSFpkcUZVZVNOUFQ1UmY5Mm5ZL041emd2WHA4Y2w1ZkI4?=
 =?utf-8?B?b204YmlxelVtMVFDbEtvTjBKL29reFQ1ZXJtQzBUMkZYaTgweFExdnQxOGx1?=
 =?utf-8?B?bzB3elZLdHRsRkN6bnp5aGQzU0xqTUhLR25VZDBQSGZ3Nm5ZYnp5YTU3azhy?=
 =?utf-8?B?Y0t2NWF3ZVJmU3ZncDl6YjU4RDgzWW9Zckp5eVh0b3N5YW0zU2NUTS9ZZmVl?=
 =?utf-8?B?VmNKdjVYQVE1VXNUVEwybFEvOVpDS3pBTzhnS0lkVkZJUk5nbjFrRFJBZFV4?=
 =?utf-8?B?MUlPUkYwOGdxY2Z0aHMwTWFkQnkyTmR2aUR6ZS9KQ29BSVFjLzBkZHFsNStK?=
 =?utf-8?B?UHBlZDRTcDRJclE5K1owRGs1Uy9Ld0xZK2Npc2V5QTJ6cVB4cmYxYzg3RjNj?=
 =?utf-8?B?THk1RWkwYzlFNUhCd0hoZm8wRFN3VjlsZjM2YndFdTRMb2VWZTB2dU11RXhw?=
 =?utf-8?B?OGxQM05Wc3BzQzhzTEdhUFMyanQ5dUNPdm1aVWFyai9HRUxXMm9QY1dSNVFD?=
 =?utf-8?B?WkRBeldlWWpUV1FIZzIwM2RvenloaVNJTm9TYkxBb1YrZnVBenlkUlhpN3VG?=
 =?utf-8?B?ZXB6NWpyR1pVbURzcDgzdmpxN2hQTmFjdEtkdWNCYlRVL3J0WVVuNGRnVTdJ?=
 =?utf-8?B?VjQxODRwRXpQTmptRlV5dVYvYnViUXVzUk9VaWZjMnBRMUx4K2J5cUUxNWhI?=
 =?utf-8?B?ZWFFM2Q4N2VxMlJlWURSL3R1SHJVNFNNdEFFUzZlWVJlL2FOYmVzMDcvWEpx?=
 =?utf-8?B?MWxsWnF0WURZblMxY0h1eWFCZUNWTHg3VnhUZnpiR2EvbnJlNXNrRytSQXFh?=
 =?utf-8?B?L1B1S2YxUUE4Uy8zeVFFUEsza3JtR2FGQmNnRmV3UkRrbG9VK05LZStoNFRC?=
 =?utf-8?B?WG11eVZpVlNsUDlEaGZOYXpsM3JNV3YwSFE1TEpkS1h3MjlzaURvT1B6WWhv?=
 =?utf-8?B?eUhleHkyc1BRNG5NdzlRd05telZvNk9sWlhXN1oydnczeFQ1TnY1eHlHU0U3?=
 =?utf-8?B?a0hKV1lndmswckxkNUhmSU1HMkREdDMzejArSkIrQlY5SmY4dU5Xa0x4UWJF?=
 =?utf-8?B?d1pEejJ4OGcyT0hoVlZNSHVvYTBNNFA4dHNHd3N2TWx4OTJZaEtQYXM1Mksv?=
 =?utf-8?B?QUV1V083eUg3eFFFZjBGdlhIZjd3by9pazduN3pTN1dNbFp3SlBFcVR0YW1y?=
 =?utf-8?B?TXE1aDNreEhvN29sQTM3Q1lWVHdQZXdJTlFwazI3TWExckRZUy8wcVUxelJK?=
 =?utf-8?B?K0tPa0tKd09RTUpCQWtReERIOWZIUEN0Z3lzOHZTWVEwQjcwdkJSVXZab3BO?=
 =?utf-8?B?aHB0RTZZREZsYnRNUWhINmxaZmZ1VTFHZkl1SVhlTExwMHNjMzFXTE1hNlh3?=
 =?utf-8?B?TVBKU1A2YXVYL0FXQ1lHUUZCQ05FN01CcUN5ZUN3MkluOWNiUGdYMVROaUNF?=
 =?utf-8?B?QU5SbUpFUkF2TWRxVkpkYndKVUVJM3hHZ2VJTmVTRHdCOFgrd0RKWFgxWGUy?=
 =?utf-8?B?L0E1NTNwZm40UU5Sd1RjVlZmbkJYbG94NjJSZ0pQbDVYWkpSZGtrTER0c0xR?=
 =?utf-8?B?VkE3WFI1S1V0SDNXQkZQa3NKbEtmL281WFdxT2F5UmRFTFc4SjBmR2VGYW5X?=
 =?utf-8?B?V2ppOFhmSzUzMnV2ZUxsV09VbEU3UUlqRjYvVHJJT0c3QnRkNWVudkdSMzlL?=
 =?utf-8?B?TEhCSVpady85d0xCNWw2S2ZCK2xKUnZzKzA2eWJOWkp6T2tHQlJmbDhiUjYx?=
 =?utf-8?B?alpDdlRhU3o3TFJneW5Kd2pSd3pTNXRzWm5nMDI3eXVoRi9iZit0R2hHb1RH?=
 =?utf-8?B?dlhUbGJkbDNQVmkyRmJtb1kvMVdTYmt0UFo3M2ExMUlvNjcxZ1hvZEZ3cVY5?=
 =?utf-8?B?ZFJwb3RTVCswZWQvRC83YzdoTEhWczF5N3VKQ001VFp2WDJsWkVGRnpBTGJi?=
 =?utf-8?B?blhUYko4K0ovQ2pyQSswRHg1VVZpR21KMHpLa1dUTmViZ1VYSnVpeWFYTnhP?=
 =?utf-8?B?S1dtWEJCUGNyWXFyVmNSeUoxeHQxRDE4V1RUbVNENEg1NTVJbUd6enhvZlgv?=
 =?utf-8?Q?PMzagKaXvD3NZ0ujysUSuOJL9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4dc8a9-8c4c-418d-92d6-08dc4bfcdbee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 12:20:57.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9/e38xJbknM2qqmXUpu0i/uYfs9dzOI0vXhCzH/hX3alae8DbLEMZOX1JWka3ccylgXJzjIIbl3q1BKjEIsGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9901

From: Peng Fan <peng.fan@nxp.com>

smmu maybe power-gated, and the registers are cleared. So
need to restore its registers with arm_smmu_device_reset and
resume the msi interrupt settings in resume callback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 71 ++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a8a569573c2f..2bfe4b3d0ba1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3396,6 +3396,36 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	devm_add_action(dev, arm_smmu_free_msis, dev);
 }
 
+static void arm_smmu_resume_unique_irqs(struct arm_smmu_device *smmu)
+{
+	struct device *dev = smmu->dev;
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	if (!dev->msi.domain)
+		return;
+
+	desc = irq_get_msi_desc(smmu->evtq.q.irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+
+	desc = irq_get_msi_desc(smmu->gerr_irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->gerr_irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+		desc = irq_get_msi_desc(smmu->priq.q.irq);
+		if (desc) {
+			get_cached_msi_msg(smmu->priq.q.irq, &msg);
+			arm_smmu_write_msi_msg(desc, &msg);
+		}
+	}
+}
+
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 {
 	int irq, ret;
@@ -3442,7 +3472,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	}
 }
 
-static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu, bool resume)
 {
 	int ret, irq;
 	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
@@ -3456,7 +3486,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	}
 
 	irq = smmu->combined_irq;
-	if (irq) {
+	if (irq && !resume) {
 		/*
 		 * Cavium ThunderX2 implementation doesn't support unique irq
 		 * lines. Use a single irq line for all the SMMUv3 interrupts.
@@ -3468,8 +3498,12 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 					"arm-smmu-v3-combined-irq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
-	} else
-		arm_smmu_setup_unique_irqs(smmu);
+	} else {
+		if (resume)
+			arm_smmu_resume_unique_irqs(smmu);
+		else
+			arm_smmu_setup_unique_irqs(smmu);
+	}
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
@@ -3494,7 +3528,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume)
 {
 	int ret;
 	u32 reg, enables;
@@ -3602,7 +3636,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		}
 	}
 
-	ret = arm_smmu_setup_irqs(smmu);
+	ret = arm_smmu_setup_irqs(smmu, resume);
 	if (ret) {
 		dev_err(smmu->dev, "failed to setup irqs\n");
 		return ret;
@@ -4086,7 +4120,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	arm_smmu_rmr_install_bypass_ste(smmu);
 
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu);
+	ret = arm_smmu_device_reset(smmu, false);
 	if (ret)
 		return ret;
 
@@ -4124,12 +4158,34 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_disable(smmu);
 }
 
+static int __maybe_unused arm_smmu_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	arm_smmu_device_disable(smmu);
+
+	return 0;
+}
+
+static int __maybe_unused arm_smmu_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	arm_smmu_device_reset(smmu, true);
+
+	return 0;
+}
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_suspend, arm_smmu_resume)
+};
+
 static void arm_smmu_driver_unregister(struct platform_driver *drv)
 {
 	arm_smmu_sva_notifier_synchronize();
@@ -4141,6 +4197,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
 		.suppress_bind_attrs	= true,
+		.pm			= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove_new = arm_smmu_device_remove,

-- 
2.37.1


