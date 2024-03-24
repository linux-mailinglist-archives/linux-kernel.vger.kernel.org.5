Return-Path: <linux-kernel+bounces-112665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A190887CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC7B20EAF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2017C6A;
	Sun, 24 Mar 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QF/pYych"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027117BB6
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711282856; cv=fail; b=FJsjNrCm/N5RwF+kH4yjZDAGKiHPRJ2FdMr67BnbWoULoSV6bX7aS6+4fw+qNJad/ohTce1EOPl8HJqm5PthVMZvSl7R/hTkQzcuIGjV23c3J9hyYy+FElVvn6Dfp9KD5dvwqKVDkdO4MWt2wv1+tnx2Avdi27nXSPXpYHkrpGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711282856; c=relaxed/simple;
	bh=HjUdViZkXBbjVp2mpk6+DXghHax2mAjMFtiSbRX18OA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JvuqccAIjhUFJnS3+hKX8dANO2ovVQ8LqhicuB5HCLaRoXUp6UsVB9hhxnfmmwkJQ6rcLkWq7neeJn2nhizb0F2EUO4TINFqinTMaw3ROGc9ETaS2g5fDKIrH3RfUO5dQ1boxe3lEAH1efK+NBjAegwkgGeKaQcSkQ7hWq3EoOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QF/pYych; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDOlp35AzeiFy19SKvkufR7udgqDgl8UEbDz3wx170GRiSFM36RlS52j1P90reQOL4JDTGDw/SB92GOfc5nW0435K74NRFfql5U39jLyZGpPNLC6bYq6Ucd4h5XXhRlN2vhNzq+zcAbGnavO3zdjHDBUYtRhRwTJO+8zb8c20H7ymCoVqtQE7MV+rat2WU8VYAnLoU/LOSnIgefYteQ1edvyctPU0IFPEVzb0NqvVKa7PNN4I172NzIqCarMiKlbtqqSl9k53ijgd1rvNLxMfrfsExPrrcY3UaMqQyh5UWP5kOllgcApwJzhnFv8SAYEB8sWqXgsCPs3RgCGkVDFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWUwpvRdGYCbTQ05mtW1+fJhbr7iX8XIT4j6BO/zlBo=;
 b=FiA7wFyY6U3XeJ8PSkTzA4c9maSRm2kUlGWfF9GcG3nL9xADIOfA0O/VaHKL8zvuyBXyp6sR6GFVmkDcpjSEkcQVIqkVNX+ePY+2mNUIyYGqc5Tl/cBF+XmUAwZ+xSw4oaZlP4oph8A+uOn4/6QfcJiE0yGrui8j7wDIV3cSlpHC0CZFo05ov0r3smiOY9P5Mqrr9wp3u+6NIv80yyWznIJrGNy6rwYv+Em2bIfMWANzTKUE+FsK58D9ThtkUbYbKfdlcYOucIg+UcTTfapOa+zcJgfTXu1EghU7DqHzkyCUIq30ByasGdi7bIaLl7OX2oCiklAKN/M4mhpLAz2Ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWUwpvRdGYCbTQ05mtW1+fJhbr7iX8XIT4j6BO/zlBo=;
 b=QF/pYychNBHzYZPGI04RDa/1/si8qQekkxmM2i5Us50Q8WO4H2DNV46ANBjNjDjDBWHndzplfX4ZdKBfp4iHTV9Q9xK1BLmyHM5vH65pukvCFla69cN0nz+1aJdE8NlNswgAHVC/a0cMWvPg8AfW0W/jlUln2N74cD9BMEXFEqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9901.eurprd04.prod.outlook.com (2603:10a6:150:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Sun, 24 Mar
 2024 12:20:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 12:20:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 24 Mar 2024 20:28:58 +0800
Subject: [PATCH 1/3] iommu/arm-smmu-v3: save bypass in smmu device
 structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-smmu-v3-v1-1-11bc96e156a5@nxp.com>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
In-Reply-To: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Marc Zyngier <maz@kernel.org>
Cc: Bixuan Cui <cuibixuan@huawei.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711283345; l=2466;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=J39T/x6ksIZycb9izGpKSZJk900zTRqTi3UlHlbNKMA=;
 b=FXwmzpUlEcqcqb3b81GkB7JiZ8q1e2dNd0NH4VvaEmA223U+lJv8QeeGfZ4t5UZAO8XFHFIBJ
 zhceHUMlvJeCkYMAWUrcIz/dPamU6LbqZB6EBuRh8fKXTLE4vmjeRxk
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
X-MS-Office365-Filtering-Correlation-Id: 16573211-9a32-4ffa-3b8e-08dc4bfcd802
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	66kgUotgW3Bi09kAgdEfoNUcpn06q0ATX23ued8yNrdW4KLDHxm6Kyi5TeWa0MmEnMsEPZl/bLH5pram3fr3gMGeXIr+TO/LvK5gK8e5pV2LrfF3SKvF0AEWSsRU/J4fATo8Tr35gBvmcQJk1iBhDJfHwPeM2jZ7uxRYEHM7qbPZzmro3NCAWkY3NaODGVUUWd40wXaSWXfXa2VjK9/nRMNp1e4Hj0zBMyfp90TT9wHWCeLDodDhdz4AEfKQO6Vg3bZeRnrL78gjy5xtdC06neG4zorA7EouYPGEP8TI8qHzZrja248zvJeskxIHeJCrwJfEU+GS7Yhah65hi8eInWxtkU/Q9OmWHFvsFAJ6GW9yTuwDsf5dNLXY6+usnf9AigAYVQzhcjnuZOc6EePxtkB9/S9eBIBb3YNxzYEKbhCAnIHFWs4ltehpMhhCBWGacouW+TJ1Z+uDyMsKNPcE947faYj+pC5oz6mrMklhrDXtGNJA01UXONXvXUGnQYnkr32DM0XDPCltkERwihVobXtbMAlZHgxupQVQPT4M+xBDPGvu7N/eqxsLImKwg0SAu977/f0UIUQJEakwds/dYvLHfKOOrJpzASA6M9srq8GGo8+yaaq22rRNYa9ylC2neh0kgP2IoZ3OEmPqMAjnBWtnrVsFj/WTRe+Sz6cfFa8pdVzZoyyftpZol/igYV+3DiUGQ/SOIq8OPaNa62+0hx4rw3/nD6NVAezwJgc0G1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUxBd2U3RlhyUmswd3Q2cXQ5dmhuVStnVzViMmR6VzY3VFZIbUhPKzVXaXVO?=
 =?utf-8?B?NlZXb1A4ZmF2SUVtREdmYzg4SVEvNjltSVBXakNXc05vK2I4dFBVZnc2MVFi?=
 =?utf-8?B?T0JXL1Q3azNGYnRIbnNUYjBnRTUrbW53bitQSk1ORFAxRGZEWk4rZ1Y3cFdO?=
 =?utf-8?B?ZThxNTRxd1NxS2t5SUtHYWQrQ0VlVUdBdEVtVmlrYlQ3aDBRK01IeldZZ0J6?=
 =?utf-8?B?YmxrdGJKOFBYUk5MZHlsaklEampySWVMTjBFQkVEYUk1dFBLY1cxaVF2Qi9K?=
 =?utf-8?B?L2RoQU1zZEZadTBrUHdDcTE0OXBNQis5MjdvRExDa1AvYjR5anlMM1llRGxt?=
 =?utf-8?B?SUhjUlV2VW92ZnVPcmpuQ29hZ0RqZkhPNW9CYUlwczBGZGlwT3hKT1gyV0cv?=
 =?utf-8?B?SmtBd0dla21SMEhOS2tyUlIvdzBxcTRyMEV6R1RhLzhkUUI4VlpMazV5Umdw?=
 =?utf-8?B?a3dSMmswU1VIVW9ETmNrM0Y4dENKem1EOHZTUE5vRjdsRFlUbmpKK0Y2ZWhC?=
 =?utf-8?B?NEJVeFd2ZDBMcjZUQVMvMk12NHVKNFp2UWQ3ZVhTUjl0N0hydng4MHJQNTA1?=
 =?utf-8?B?NVdSdnJ4cWZlU2Z2Zk1mek42cTNMeXZjdzFBWFdBVDlRODYva0I4dC9KUzhz?=
 =?utf-8?B?TklxUVNWeFVFWFM3dk1yM3dBQkZCWlNDN3Qzc1M2ZjR1VFY1SmpRV00xd2pL?=
 =?utf-8?B?QXlzeWtxNHJSTzNzRkVWVjZxMW9TcUcrUWRHaEFudndNTCtKSVRYeUZmQkJG?=
 =?utf-8?B?QmFldXdPS2JtWDV1NFV3b0M0cXBQYU1hZ3hqYzJyeGhQRGZ0S2VIb3hUNG4y?=
 =?utf-8?B?UWphUWJyUG81M3NmVm90d0Jib25KaDFXVStIY2dUcjduVHJ1eVR2RFBwL2sy?=
 =?utf-8?B?OVpXSmRKbGc0ajNWR09SVkVOSUlPL0QwVm4vUU45MlhCSER5UldxTVpob2xR?=
 =?utf-8?B?bytXK3ovMEVGclZEdWhnZ1lJY3dVeFgxQlBZc3pjeXJnbEIzSDF4dWtmeHll?=
 =?utf-8?B?OWRRZDRrNlU3RHdSY0V4ZldjZnlUTjNQZXNCcVA0aEJ5MlpMc1YyaFhDWjg4?=
 =?utf-8?B?WVFNRFhmbmJIOG1udHp5aXMyemlKRENQenUwa0JYNHRHNFNtU3EvN0pCNWI1?=
 =?utf-8?B?bFNYWFF5R2Y5emRZRGpwMkFTQzNvSmtBbFJ2RlJFT3ZVZ2RzS1A5OEF4Z091?=
 =?utf-8?B?aHZtYVJXR2JrZG8wUGJ6YmFjSWh4c0NRWXcrRHlsdUxWb1ozYjd6TkxzSXBT?=
 =?utf-8?B?WlY2Ui9MdnkyWjRtamUzby95Q2oyNGtuczEycExNUlhlWWovcE55eG1jbTlZ?=
 =?utf-8?B?RyttT2MyZXNLTy9lTTB4bjI1dS9Nb2NyeGx4TmQ4MERZc2czY1dpSi9xdDhI?=
 =?utf-8?B?WWlyK294V1hEbVE0SGNqMHlEZ0I5RWR6Z2lwNVU1eDJiVmdnOGRFSmpOUXhQ?=
 =?utf-8?B?NWlZMkdaZ0U3c0tKYU40bllvb2pHRC8zeDlhT2JTNlZrMndMd2dLSVpEaFZa?=
 =?utf-8?B?dklPNnVsbnppbzdTQjZYaHZYVm9jWE1tK3ZlV2hZbDc4MitscGdVejVnODNW?=
 =?utf-8?B?dmF2OXdYUHh3ZXE0MjdFQXNSNFdqRXY1L0x6QzNoUEdtQkNIbVJ4WjBUZE5n?=
 =?utf-8?B?MFd4SHdJWDlKdGRVZlprblA2UmNyTmNEZEZUSXArWjdQYmRDT213dVRjbFpC?=
 =?utf-8?B?YTB2d3Q3d3lWKzI1VGVlUU4yTWttaXl3YnRIYkhIRENMUk5UbjJ0c2E2ZjJK?=
 =?utf-8?B?b3RON2lMUjAydmdVcjlZTmtUQ2Y2eVYwRzhYQkptT0tLWWRzV2l5c1I5UGE3?=
 =?utf-8?B?a1dQUkQ3S1VKUkRFdEt4VzlYRGRJaWtoam9YOVk2TlJHWGJLNWQ3ZVN4cTdr?=
 =?utf-8?B?cW56U2VQSkN1b3NPSC9aZW9oYk8waktlQ0l4bENlQTRmWUpvMFV6RUZwTzkw?=
 =?utf-8?B?NytjQnNvU1E0WmE1Z29ZeFVFWTg0YTBERHBOTGhPaU9hb2FEMkk3djFZRlhS?=
 =?utf-8?B?dk1iY2NZaFB0V1hiTE5CbE1RVnJUdWJuZWNZazl4L0ZTcTJZYmFmUUlBRGF0?=
 =?utf-8?B?NDFSK2h3U21VNnltbnIzZ0J3eXVYZkhSVU5mRG5WV3FwajI3WlpKVDArT2xX?=
 =?utf-8?Q?L9k+yvTY4VjXoMeXcgFkiU/8/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16573211-9a32-4ffa-3b8e-08dc4bfcd802
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 12:20:50.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I0VKA7sFfPj7R7KPzZnw6/hNSqYxOoGkYm/F3GP+FhqEhkAcHn+hk3XuR+R9vdfemAZ44CzOF18eJ5WBMqUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9901

From: Peng Fan <peng.fan@nxp.com>

'bypass' will be used in smmu resume function, so need to save
its value for future usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5ed036225e69..a8a569573c2f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3494,7 +3494,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
 	u32 reg, enables;
@@ -3612,7 +3612,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
 	/* Enable the SMMU interface, or ensure bypass */
-	if (!bypass || disable_bypass) {
+	if (!smmu->bypass || disable_bypass) {
 		enables |= CR0_SMMUEN;
 	} else {
 		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
@@ -4007,7 +4007,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	bool bypass;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
@@ -4023,7 +4022,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 
 	/* Set bypass mode according to firmware probing result */
-	bypass = !!ret;
+	smmu->bypass = !!ret;
 
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -4087,7 +4086,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	arm_smmu_rmr_install_bypass_ste(smmu);
 
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu, bypass);
+	ret = arm_smmu_device_reset(smmu);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 23baf117e7e4..97064a6aa87c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -683,6 +683,7 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+	bool				bypass;
 };
 
 struct arm_smmu_stream {

-- 
2.37.1


