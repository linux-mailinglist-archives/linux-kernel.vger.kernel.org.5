Return-Path: <linux-kernel+bounces-117124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFDA88A9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E62B431FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD141172657;
	Mon, 25 Mar 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IR9pEv1p"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404316D9BF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372691; cv=fail; b=sHVixyM1EPeMyRJ1gj6/PbxXaxL6//vjw13CjvP5j0dk21/eKHYgW2VdvDeFL0ZjpYzN4MgFSpC352Yq5GZixPkELV/vZpAbORLEmRgm/oHPp0/FLgHFwIlu1jKvuiPbsB4zuGl5VeqyICSMdnTN/a7Po+0fvpkyFNpldqvTMcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372691; c=relaxed/simple;
	bh=3OZUdUg98xblwj2iMUPTxjA6rTITSKkyMah7ycF+ePU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NYas8yh6agHayTiM36r4eP1l/cuOM+UD0IelhpmE0C+nZ1jXYxt2kapcqFvCUHRNl3OlJh/cY1MH17andJMY88FqoDPqT8n/+im5113jLH1xRow91ESnlxDf616nuf+Te3UQks1yXfbljN8MWZyc5iBURoA98JmSTfm7U+iWgBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IR9pEv1p; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOpFu9xVDvVWSHfiolCu9K3/sVPTFj3BrdLepmdRVHVgM7ml0kvr9AEPAu/fFWvlXl/k1l/rUoSb0FuRUtApCUzVgaRpax6yAJV7/GPUTEt/0uNYrxHAiY1eN3eZyI6z1/4EkfY+GHuzcFVlQf3WwbRD2sByeUUseFiSSfCfixB3aBe3jH04dRPmAvd0J0uyMTpNM3EtZlusGuy90yCIFWlZZECqXR3czZAkBxeLdRKo5khKwxY7Fe2qm6wcfQ1gWDSuDoM+ZccTSYvsOznnRKilWMMM7wUp7IuhqkvB7PDgD34vaF1GQRGN46K5CSBGpnEdW0u99ptQbFKouhDLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brcUJxM5mXyvvorGrm3kPkt/b71wogkHUlOHcwZ3wEI=;
 b=jD0KfmEiCT0WoUK7JZi5fCQi4YO1DKnX5imYf3jf093Ld5GMEdcA8gYPBbBzirFcgJgfDxlO3fLLC8pt6n8I7uLy2b29BdSj4hjnFa2oY8khEiOUuA1pzZcpRUFHf2tcRvBqsmZCKLdUX2TAiIcQu5Me6o4aBVITRnBHZ+ZqHLGzoj6ELAw/bN5yQ802Q2Uq072em189w7FBl1qc4Rfh98CVFLliPaJReQZNax3HQImBO6RBQLhUQz1/C7o6FXyVpXy/kRHAZW7UX25MB6qJ5wJZ09P5TJGSunyNuteNGHzjIqYK7HGZ8ETLLpJqlO1QCZsSUrNXuWlvS52N8UJjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brcUJxM5mXyvvorGrm3kPkt/b71wogkHUlOHcwZ3wEI=;
 b=IR9pEv1phGmtNjiUMdvHS3xIC5KctJY0hTaGJRbvi4pn9HGs0QpvAQrrHPiM+tkZSiti0JiDbmatnrCkBgQQJR8ZNnfO6ZIE0EEO/FvQBjPOkfHSmuFWFz9aX/wucwQ2XdlDlD5YJKmFmblJS1V1wi3CnyKBi4NZhH8PxtUbc3whg7vUkiyzq0fjlCpL5nApyTqDRTvCGvATAwzyNVBcOQfWeY/ssxQ1l60B0sQC+yxw1W9Zvrm5W6OGK18uZOcJ21iSPQHB/MwnR2eumrsAregzi6juC7bCSbtBwPDvNtrtbc1FCfTzyWw3LlqmPmFZdCgAePxbWTIhoN8v9Qrl6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 13:18:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 13:18:06 +0000
Date: Mon, 25 Mar 2024 10:18:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix access for STE.SHCFG
Message-ID: <20240325131805.GB6245@nvidia.com>
References: <20240323134658.464743-1-smostafa@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323134658.464743-1-smostafa@google.com>
X-ClientProxiedBy: BLAPR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:208:32f::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5162f5-e29a-4699-074c-08dc4cce027c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6hp3C18rTj4UoBYdrCdKkjkKek+Gma4XM51M5MXifKj5bp1efLJKMJw4f5ytghZrI+EZt/MS9tW56tNv1oQ3SWGryYZ5vnBTYnZiSDKY956TxZJK6BkYXTL540V6znSJ8z36o7H4a0IvLhtG87ExMelt/McGnU7oT0RihA2urQ2ZVS5/UKM2tUrN6HP1RIuXLmmxuKt/bRcEM7LTwd9MtfUAYWPzJ6qrMjWjJ+XVtfYJcdaZJE5E/T2C1ZX5iGMyxS90RSnD55sR+t7IMvBAlC74aknlRxvXq1n4MhVPNlOkZgasTRnrvkIs9awizzmyAjOq7INytGcHZAlRTpFYQnG4vCXnW8tezzXPvg4jqCji3yG1P1+wZAiF4kX0OsgHnOgnyJwZ29eTmvh9jsDcA3fbu7K5tBcSCEAjY2uZhVb7q8BrQnLicWw34nyESXDfRrLxuWYHe4T6KbeeIiU6dsrwP//qQfWQ9KDo9tuSlrv8dpMy+ST4e/mFaQRoIezYC/jh8a56QkADX18wKjKpFlmdbIhEGJWCKNiElBi4/HTegKZkOooQ50mc+kIVVYWFE+c8aIYEMOUIW1IA27JU9uvn13ckgRffBddo4jNEosHmN7qjU5eis2H8gc/pxuA+xd44V2R4LbbfQfJb2Vw/mxzNMdS+hlBCQiiuZquaXQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCfItVl25NRx/HrcTK7jiJuliHpohXwWL897X4wrmV1zDYTMUlT3r88dzjDa?=
 =?us-ascii?Q?ymThI+RWsbO8sjqoM0huRQHmfS6Xktiip+caqN/urYYERDOipzMbjdgwuDhy?=
 =?us-ascii?Q?Nt9gzdWaedxy3xVfbmEylBQmO1Q3NZOyJMB0bGAZ3eT+9oLutonnBz/LbeYB?=
 =?us-ascii?Q?V31jKyhatnNKeC1GQWjPITBYdnBBkoO1eMfSXIjfQx8YJSfg4ifUeFALV4pE?=
 =?us-ascii?Q?ya9FwCDe9aEF+hQI21pRWEqblwQrLDTz5Feihj31OhNXppi5yhotBuiWi4sN?=
 =?us-ascii?Q?rPmYw5oZtPpc236ePGCwqQ+HzBzeLe+V7mNhMNOZE+qO3dXoF/Lr7p34S5J4?=
 =?us-ascii?Q?w+mJMPgJ+qHvOwqSAEo2On3M3COfx9RwUx/Ui8rJl6h16Q65YD0dF/JC3sxx?=
 =?us-ascii?Q?N6mB6R8n4p49Pm/pMrqXC+uRQVg9yNDGV27byJ/yRKBZMeyQrNSvhroXmgAL?=
 =?us-ascii?Q?HOfKujJq+ocMyXA/A4h31vGeLj3RkA4YamZDQWfQ7eKVCDWl7HovZ94TaAJl?=
 =?us-ascii?Q?E6E3lRB3h9rrg3zEPMUAJMaiACNhyfJNGR2EkMrVodv8MYiqAHEm/kn9w9TB?=
 =?us-ascii?Q?QzIQ9Tjv8DNz/8J56FuNcmfpSi1dxZNA2C9VzBu6V31X7Fmb9OpwpCA230xf?=
 =?us-ascii?Q?iBrMUbCVVAb4oiPmt5BBLKo3hIFhRYkfIsTpPod8EJLVUUs4DFtGPl6+/+l8?=
 =?us-ascii?Q?Bjp/eDCoQ9O8/86fq1fKo9eyWv6s40PXOG7LQzXpftT0flprBX8/MmiSG6d1?=
 =?us-ascii?Q?sRRY8SiUwLS+6XJa0MIOhZPdp2D96BdpWMMW4pl+X7MzvDah8gKNDi4VXXku?=
 =?us-ascii?Q?Amw0SHVddwYEtJC2O4ipIz9Jd230KpOv6ehAmdaCz6ZVFBBomgDvm8nEHrqV?=
 =?us-ascii?Q?qf0CR1f/ucyp/PyBts3LtUchAzQXuWsDjrJMNe2n6G2h88rr9f/nDf6GwLEV?=
 =?us-ascii?Q?4+mLWmeRrkceAefRz0YFD0XlkuGvcChSTUbPJ331R4nz0/MiRq3eEtP4r0uF?=
 =?us-ascii?Q?Hcz2qK0wiqcvdrSf93lcGznFbuwfLH0ffPZ8fCsIk+Ef93SCyavBcrYQDvxZ?=
 =?us-ascii?Q?Xzx+/ZuKrI38ZPZkv57JP687DU+IDbdyQXA8rPrPhZmHHupCUNNzo/L/9Dtd?=
 =?us-ascii?Q?qQ4cE1fIM9p3HT5m+Ex5kPcQs0Oit/IyhoRWrgSkBLylNBJcV6RjeSnV6qqL?=
 =?us-ascii?Q?RebvL7uvX/gJV+3vXUcD0IUJnI7N2rhs3dJKLTwRgb+TpfDOJxDSYlK5xeXp?=
 =?us-ascii?Q?qlbAkvqVoaNfTwm4xBGt2DBNVtDnxrrvbyLaA/fj+cp4Tl4lHkQ3iqtyWxut?=
 =?us-ascii?Q?uWY5PcQ7+jHeCzdnmOjjawJFg3UWnvKlRD+/lCB+RGfTPhAZoIDJCRDbPVIb?=
 =?us-ascii?Q?KqaYYyqrEHCDpJaS+Ga14OsjzaQs+y4DO77CK+Hhp1vrl9/FN+JYZl5AFopQ?=
 =?us-ascii?Q?sLQSUj+TjC1sZw1npDdP95EVuRW6ZrU2nIlnkoshmvz5X0TgUSraQAZfIf7V?=
 =?us-ascii?Q?S/Z7qnAQcLPKFO5qH2RcQ5ai8mDcS5K0YjKjB4hJIYfuUGaV2VekwS1uEdW9?=
 =?us-ascii?Q?xFieG2Bw7ZI7ouxUg6Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5162f5-e29a-4699-074c-08dc4cce027c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 13:18:06.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBYs9D0MV7CvlXf0ZjbjxjjkaYYNjV2oLiZlvQUv5asiNau3c9l7650S0Q0WYjS9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

On Sat, Mar 23, 2024 at 01:46:58PM +0000, Mostafa Saleh wrote:
> STE attributes(NSCFG, PRIVCFG, INSTCFG) use value 0 for "Use Icomming",
> for some reason SHCFG doesn't follow that, and it is defined as "0b01".
> 
> Currently the driver sets SHCFG to Use Incoming for stage-2 and bypass
> domains.
> 
> However according to the User Manual (ARM IHI 0070 F.b):
> 	When SMMU_IDR1.ATTR_TYPES_OVR == 0, this field is RES0 and the
> 	incoming Shareability attribute is used.
> 
> This patch adds a condition for writing SHCFG to Use incoming to be
> compliant with the architecture, and defines ATTR_TYPE_OVR as a new
> feature discovered from IDR1.
> This also required to propagate the SMMU through some functions args.
> 
> There is no need to add similar condition for the newly introduced function
> arm_smmu_get_ste_used() as the values of the STE are the same before and
> after any transition, so this will not trigger any change. (we already
> do the same for the VMID).
> 
> Although this is a misconfiguration from the driver, this has been there
> for a long time, so probably no HW running Linux is affected by it.
> 
> Reported-by: Will Deacon <will@kernel.org>
> Closes: https://lore.kernel.org/all/20240215134952.GA690@willie-the-truck/
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 ++++++++++++++-------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>  2 files changed, 25 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason

