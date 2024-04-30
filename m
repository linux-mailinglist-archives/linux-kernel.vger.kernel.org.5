Return-Path: <linux-kernel+bounces-164129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C308B7970
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30C91C22BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0442173349;
	Tue, 30 Apr 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mRB2WSl4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA317278D;
	Tue, 30 Apr 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486929; cv=fail; b=ag1Q7X49BFjYLKzxLDSUZf7+KcRj4lZzFzKh9dftY89ldE5aJty9HzECJ44oOAydX29XuX/NzFEnSeJxn+XYhQZzvwXxsnIdx0uEvqqolIZoyHuri8dCS67o3psKaz0eSeNwq0a/vW4xTCUHKQXiPZwvNtDHJz71juBue7CmPU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486929; c=relaxed/simple;
	bh=UTasaX6C6RhqnXAn2qumn4L2kltj/tSYvWUPwZexkyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFuTCvzNyEkrqbjSFrPVEDUOwculwNJ7GQd4Ckk5CrHiDmU26/qhmSRn27svBQ9Y1Vy3K4O0V+ual+BJCmhWWBD39HvpICsbzv5P9EPpKRoiACPKosGfSAA1m/A+2X1lO6Vtuhv9WvBXfSiEboooN8Jid33mqszPNxbOUcW1e8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mRB2WSl4; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RACvH1pxCK6tmdhee/ms3n+Zcyt7wuSKxw9ImAlBCET5JGhriYaKCa32MedTpM/ntNOmg7ssA+VL1N6gyYykxfOT6Gmf2A1i1hwvPsIvE44wXia2JSlPsEA7tfwmttYMdejUXTB0EFvAEDTLfB2uBaihJBluer/TPaHQpmmJJVPilX4Qe8SjbycTM30K9/DkOi17A1tjpkSWo1c8PW3BhVfyPQuZGrlVHIvJbGj2NndLa9+wuUQ8gP+l/KAJojOTK5CAY6yCOuQKzhXc2tagxG95H/Z+ml18QpxmW8Q0KyQxDRdxPE7AsBJ75f3RMJybPaCOACQ6WBddvTT8p/y0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9IMc04nsMI081cGtyAZymqvwuUWMdiM1zkZQqkk0M4=;
 b=Q9PNzOBE5BHpmUviEbxmSX3XOcxCBXJdlz8ufBZ9u63SN2/kxMNzobdcFncJ3icup0xWMVDajX7aBj5Dj+A9+U21dmk3ft3HIoFGf/B9aL8vtNwsUikR+hgzw1WK8G3pSYfgfMoQH8WYIIr/KMATtA2+M3fgF+JF/pDklkvGkSdr6SUjkppPzKCRWepKK3JiEB7bEB4nAQnn0bvTkpYSifc2I6hs+fZJwq17wbaqxlFiA0XjF1DRbZHnB6G1mjpP4TobLit0rjx2tTpkk2nrpJi0ozoaYPUusSWqv4W4NIRGB5UmRvMf78N+pByXB6qlc0nna5VUFtlcMi5StdSRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9IMc04nsMI081cGtyAZymqvwuUWMdiM1zkZQqkk0M4=;
 b=mRB2WSl4yC/w2lZHiOSrMNjy1+uU7nvZ3hGviJNgU+cdXMKW2sIqd+0KYy62k5q6aIKTOMg8hhVtzf+0pyu+W0YSAqwvk7tGLbH7jtunM+yQ4VyaJ+JAsy8cK+BLw4EDzBsOenwqiKoHlNLcTGTovhL16KfXcRPuSRuWWGIS7DQGrylPoVm6sFbEp4r2GaSktqnh1ohuaPX5P6gp31bwFauc7//21qVcVx1st+1hf2sLMQ2s8tehNi1K0tJ4MYiagEZxGGkkK3DdJh2BbrWZ0bO/ch+86i4AKxwP9dL21smRiUIXdEcOIVXA07hMAQ2xEC5FYQtILeAgejvrgpPnIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 14:22:02 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:22:02 +0000
Date: Tue, 30 Apr 2024 11:22:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 2/6] iommu/arm-smmu-v3: Add CS_NONE quirk
Message-ID: <20240430142201.GQ941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <81d79f51c69604a38ea4f72c8ac2c573c52e8609.1714451595.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81d79f51c69604a38ea4f72c8ac2c573c52e8609.1714451595.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SN1PR12CA0067.namprd12.prod.outlook.com
 (2603:10b6:802:20::38) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: b833b8bb-34a4-448c-4f56-08dc6920e7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQFqHbf0YhIGQwpoOvXbyO+Qa8ganzUNZsfAf0zsergJYNrFplBvTKSa9q4H?=
 =?us-ascii?Q?lXOI2FJTHO9Ah9v4fhh8G6VVyjMXLTDtQ9HgzQ3B4bUyRq+O1GZKQpJSaZLU?=
 =?us-ascii?Q?2EqHaI9M7r2CfwhbQ6YR+pHrNqwTfBXVDdB9jF55AlO1cb0ucmkQs4KE7/aI?=
 =?us-ascii?Q?Hk7ttmf+InKfN/7Iy4lVnifZwxXXKsCzr8OxvI3VN8v4BO1H4UDI814ibHz3?=
 =?us-ascii?Q?ru8TP/8dfdkaM/uo+bI4t6NtiegZD0YjU93/Fae9cLQPIJohkOr/nBtMSKju?=
 =?us-ascii?Q?cx7uTzJ7HAStVsnv+Y5+m6PB3x+l75m34pG1XXFyJOQ0CRAqejMwNF7LgwB4?=
 =?us-ascii?Q?0rfzSQ58uCJ1yEauWyrn5fPlg0Lh93nYnAN1TOSBia+smRU9z3ykBbcvPXqE?=
 =?us-ascii?Q?ONsbrwqeSl3Ksvd7mTNrnHM/dCSGJdszvAuVPPc4TlDSFNxHeaus48s3HviB?=
 =?us-ascii?Q?w2wmSHRmcgpQPzyQz/wB0e0WUmai7XLCv99PSnECk7HwIoUz6jFBJzXt2XDP?=
 =?us-ascii?Q?MKfN5Yihn5RDEB6OAugMskrUVwVSX4xTxFeQRovRsmzq8aKHS/GxlM7Oas2Y?=
 =?us-ascii?Q?26NmW3PiqIgYIEdOY6FW7KuyC0wUKgY5Bebx7PSm0SXd2oVDojtghUlQRkGl?=
 =?us-ascii?Q?nfkGZd8GqRwdqGIcqW8ViIDYRpQ64cSgEuhGtQZDKlc7bJBGG4Iq12NsD+v7?=
 =?us-ascii?Q?1L8QCb9lHUnYr4pVXPeIAoRyS3x00jw5Hro4vbuMYEstIjGKb8d4p09Ul3GS?=
 =?us-ascii?Q?ksks1M0j9aZcemF/sZ8PjmFa4q0NrceSDBvkvtHMMDekJFEuUADafPV2QtrD?=
 =?us-ascii?Q?23ArAzCmvUVy039x/7e3QKiF4tkoirDp6h6x0QUmJ0Vin6kdmh3l2mOTPbAX?=
 =?us-ascii?Q?MKRMCVPMVhy2zYsqGKPhRFXFr2wpYbxqgXwSNUmyUxfJnhvRctWTntgYixGW?=
 =?us-ascii?Q?q447bbvI3W4hD3W377U71Fark7NbQMzJGADM774hEdk4w6ysvqato7AMzaw6?=
 =?us-ascii?Q?GorBFEnrn6qlzGJ3ijNI/P+xvoEefnLcKWgBQWURQ4Fg70X55CCmpXtQQd4G?=
 =?us-ascii?Q?iZNpmfiZ9Y05/EZlFGGxMagH+6UWDqZ97u6sVtR3iWVSxxVroBDG1n7MBTdH?=
 =?us-ascii?Q?9wgtDNqeBg8qrC2Yi2EOxHqhcDDy94r4469RDcs4iBCvmgpVe2PR9rcMOMJ9?=
 =?us-ascii?Q?CITQxNP89E9P5N0qeJ0hpQm/3seWQFeRlw3QsNQs05lLHScjaJ+5YEkT7zQL?=
 =?us-ascii?Q?pzzDMAvGNCDYW0zbAfcj6jo4q9qNHXq6IrUazU80rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Mt07unKBqidaWZacqXNkwwgkNtU3fc4G1KfGUVgsSdQgV7qXraIT8Unz1fB?=
 =?us-ascii?Q?3pIWb8C2zU1BHXnGm+7/XyOE4+HRv0kWq2scGRXJ38mt8vWF+5Ix5obcItUj?=
 =?us-ascii?Q?2B65N75M7sM+h6fWkUjI0u9ZkwiXnEm3enP7ylh7cLA9t18NDi80RkRST9G+?=
 =?us-ascii?Q?ovSqP1EfZtDL3qpbVm03yxXTbJNO1xMOhAqn208Dr+Djciho7gl0+bCPt60Z?=
 =?us-ascii?Q?O5WFvhZhOPSd1hMVRIxty0okzA3xPrf2ILi69D3B+pmS8bcMkrhm9CYHqya1?=
 =?us-ascii?Q?9JjpAdsRrRtxrgSYEgVMDcXLR1x2dZjOg0xaBtl+icWKHqhUuHXDTCSqjiWb?=
 =?us-ascii?Q?FaAyXOk6OcxXbmdffTft6EGmqYGMVSRuQeoe9ElUKTL0eVHOUSdqoLb8pS8t?=
 =?us-ascii?Q?XxqbelX6ySH76vo+ESQJBfueb1igvvoYDL2UtxZOS0TuPkbOUI8QE4oV9b+a?=
 =?us-ascii?Q?AUt2TRzRkZ49tLFaT8FhOtPJF5VnB7w0/fUUZAxF6+J3RKiw44ziWwcp7j9t?=
 =?us-ascii?Q?jxMMZ7AGaTv3xKqVbWlCrBELBTyNY6BlteCvDdgswlLCCkgsoLyjTptUXHPv?=
 =?us-ascii?Q?i5PhSTlVqejVFAUQ69nlgmE5DDtbQvG9swIHzMc8tRTBeq6JuA+w97EWB6jy?=
 =?us-ascii?Q?qxR1vjnQ2tZCBeRwpVxT4W0LrKND4jBlZKUiKNOzzFpig7/dpGj5zAf4+EEG?=
 =?us-ascii?Q?BshEjVDbnr3mqzw4wyRfxtfd+6avEMXXVAurwnf3G2Wu3FsMzLadayGsuWzE?=
 =?us-ascii?Q?W19ay9I+SufLeqPM8fLOPEA4K+5E0WoNhN47+e/XptqNiiD+FFj2BYeXMvAn?=
 =?us-ascii?Q?AXQW67MRW7SjoGsuS44FI2/2y77yVOIef1jTw95aVprrJQyZ5KH4WlVL9BF2?=
 =?us-ascii?Q?0IU+n6qeIN939Phoh2Oe6gOvDmMFI5kA+CuxtTmUraZGpovBUCshlvWIk/PO?=
 =?us-ascii?Q?QLYtvLKbF2OLW3IvnJNr6UkPpFixaT/PhPnlnVwtBwiQ0cmKeRlQMRJOS81E?=
 =?us-ascii?Q?3dUpuj8LN63do8/a3hAMVG5ywJl+mvvxPIW+T0N4khvOPeAkgzyZ/timas+0?=
 =?us-ascii?Q?Syr8kBIB8yVRsQ9NhEzfDXkh0ZOQOpT2JqnMflO8LYO39iIRBrFsagD+Q8Qq?=
 =?us-ascii?Q?Up5G7Nl09guLt5VLJlK8B19E5pmF93D8qJRkl4VOHL/8xo/DGW65V+/xcoiQ?=
 =?us-ascii?Q?BbM9OHreYPh+DdIng34hYG0d8+0JBfjAhSpO/rKWTbHk8DC6LXlK2k5+uh5T?=
 =?us-ascii?Q?6xG304b/mGtZxP7WWDiBcUHHfCCtlIAgsfye+vIzjOBaz3aJT8xm+b9QGg7E?=
 =?us-ascii?Q?UpNQuau5XxQsU+RxqJ5CdqWDBvi2ABRTLIKB3mqHc12z8qd4MWShLMEgq1Lt?=
 =?us-ascii?Q?YyiNeAntl0lS9PSyMfm1n1MSVlWUzAJzOwDtI0kIdMkLyof+S5v8ZNBigoxY?=
 =?us-ascii?Q?csTdosc6fmBnDu5bpDJG//zXtfwbEPjHRlRQ5S1jUw5IlMNkFDKImGWB+TX/?=
 =?us-ascii?Q?GMrO3gRbp2UMUkm7y5eYL67ksmX165dCEaDMpRXF47d+cNKTQqAJvrjXW4Y2?=
 =?us-ascii?Q?rh1yH3QSk2DB29dPMv8u+AVeCQGTfv4rNFnzoVy9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b833b8bb-34a4-448c-4f56-08dc6920e7a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:22:02.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoiPpf8L7jJ3s50SmGwOY8DXKyVs3tNzwdx0j+Zbxa+Vn3OimPl7UJwSJU6zA2yO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

On Mon, Apr 29, 2024 at 09:43:45PM -0700, Nicolin Chen wrote:
> The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
> CS field of CMD_SYNC. Add a quirk flag to accommodate that.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)

This seems fine, other than the misplaced hunk

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

But it might be tidier like the below. There is already a function
that is called to build the sync that has the q, just build it
directly there and avoid going through the ent?

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 268da20baa4e9c..fa9cb0f49bf1ee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -338,18 +338,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[0] |= FIELD_PREP(CMDQ_RESUME_0_RESP, ent->resume.resp);
 		cmd[1] |= FIELD_PREP(CMDQ_RESUME_1_STAG, ent->resume.stag);
 		break;
-	case CMDQ_OP_CMD_SYNC:
-		if (ent->sync.cs_none) {
-			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
-		} else if (ent->sync.msiaddr) {
-			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
-			cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
-		} else {
-			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
-		}
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
-		break;
 	default:
 		return -ENOENT;
 	}
@@ -367,25 +355,30 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
 }
 
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
-					 struct arm_smmu_queue *q, u32 prod)
+					 struct arm_smmu_queue *q, u32 prod,
+					 bool msi)
 {
-	struct arm_smmu_cmdq_ent ent = {
-		.opcode = CMDQ_OP_CMD_SYNC,
-	};
+	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
+	cmd[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
+		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
+		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		return;
+	}
+
+	if (!msi || !(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
+		return;
+	}
 
 	/*
 	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
 	 * payload, so the write will zero the entire command on that platform.
 	 */
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL) {
-		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
-				   q->ent_dwords * 8;
-	}
-
-	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
-		ent.sync.cs_none = true;
-
-	arm_smmu_cmdq_build_cmd(cmd, &ent);
+	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
+	cmd[1] = (q->base_dma + Q_IDX(&q->llq, prod) * q->ent_dwords * 8) &
+		 CMDQ_SYNC_1_MSIADDR_MASK;
 }
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
@@ -402,9 +395,6 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 	u64 cmd[CMDQ_ENT_DWORDS];
 	u32 cons = readl_relaxed(q->cons_reg);
 	u32 idx = FIELD_GET(CMDQ_CONS_ERR, cons);
-	struct arm_smmu_cmdq_ent cmd_sync = {
-		.opcode = CMDQ_OP_CMD_SYNC,
-	};
 
 	dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
 		idx < ARRAY_SIZE(cerror_str) ?  cerror_str[idx] : "Unknown");
@@ -437,11 +427,8 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
 
-	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
-		cmd_sync.sync.cs_none = true;
-
 	/* Convert the erroneous command into a CMD_SYNC */
-	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
+	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, 0, false);
 
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
@@ -812,7 +799,8 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 	if (sync) {
 		prod = queue_inc_prod_n(&llq, n);
-		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, &cmdq->q, prod);
+		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, &cmdq->q, prod,
+					     true);
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
 		/*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9412fa4ff5e045..b1ce1986e61101 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -520,10 +520,6 @@ struct arm_smmu_cmdq_ent {
 		} resume;
 
 		#define CMDQ_OP_CMD_SYNC	0x46
-		struct {
-			u64			msiaddr;
-			bool			cs_none;
-		} sync;
 	};
 };

