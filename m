Return-Path: <linux-kernel+bounces-164829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F688B83A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3146F1C2210F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EF10FD;
	Wed,  1 May 2024 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SbMchJ3H"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6F173;
	Wed,  1 May 2024 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714522693; cv=fail; b=bYbsmrYNyusTtpOzsKMk0Xi1elET/yf9r1+NK6mEVx3XvdkgRkdlBV4q5lLMn3GwbdN5gxiha1UhKa25z/NHoCzAhqhcEsMvcL+lhNPbn9ARWYE87wAP8K4NC/deeMcjelezKEYP9TNgmz9lgxNc1EpgPZT3SUGMq/IcXPhtfeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714522693; c=relaxed/simple;
	bh=iQXoc7YeMVKDNjAY8VhlhKTiegwNa9+PvYsw+1V41Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lW2BDV/0DmtAuzRU3BCFQWDk88YnfmEroULTN3/Am/IJuVxUdOFC21YzY08CeQuVVDb6/66XFf6LSpo8ukDrq6yOxDS6GkG1uma9BxWjSKx7ys/bWUkeh1gBxrTpJZ+OxrPDj5MCQNEKbJxxe8nUXjO9y5KlQHA0iyjVqs0bvp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SbMchJ3H; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSoCfHa15LG2OP88lYZgcBfopEsregGA/LmNjTy+eSyrEA0wKPsX9vTYuMlaVN8XuNnTzBrD8pKK51sWl5rXZyKvV4Q/kpuwfgGBbhAos+Oos97mzcTwRQttv1adUkcPaH9Qyfhiib2uhWEGSD7nQqqOV7vWSulYESI+b5ELdPPIixhCq8DHXMvF8FF9Nep+Pb8u6PTZIwHWgU+BWyr0hGRbcVlrIruiA8XRz4msjs3Sdwzb0xj9J0YTtOC0vngIqdKLGIFaSQVdVRaEkqUWgGng0FIHZesnbgWcWOfTFwbAzn4oxddJksndpNB2YPL2ZN0p3UtTKAFSxb9SMeW13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFDafP5YCZVIxKTSNOI9beI9OSohXIhuTr5evFVxfk0=;
 b=b5dwfYvwyQ+Zg4jknta+iczWjH9zdbfgAzMf9zYJCx4s5kWwiNnxZE958n2YozWAdthJby0p0JiEtJGdlOJc0KSRczdFGv6kfSOy1Actu6eIthHsTXC0jkxiFTNrB9RA4LfWe7yEGkw3ST2Kw20/FnnG5egDfSlvXHUrlsprJ5o4ytWpT9L0vwU1Df1yhKLLxstE57LSEvDB54S9xm9guIwh+2KROq1HQzoI+BFu30qlgBSA0X32IR8DYaGYREQ/KbsSIhybyMb8TRkRouZWvCTMbU7Mbzl/WsJajl/GrJ0KivMCH6S2M8J/D0QLyhF6CQdys+c8GgRHrogeHDxF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFDafP5YCZVIxKTSNOI9beI9OSohXIhuTr5evFVxfk0=;
 b=SbMchJ3Hgc2b+q7LhjePi1ON03iP0DvVBun36/vVIV3WOMn3hWhIKHNMPtvwVqELilG1MlzgIslxdzNQxNfjYOfCPOdj6eZiswbGodXQj+bDIpmjxGA607nETASVRvjjbGx6PSyZi5bwJxjZjvLnp6zLGMSOc8Xxo/VxHlbOHZ9UxNp2ATWsk/rLMAGhy+mnkKFQizaOxXCwoKmRHUfCdwP8ma62KE2bSTBf1OL6itCtf1aHNXf0YVnHhOU0FheFJW4h6ql91mKy/exCJZKDH6OlFFjPn3axg06q7Rl3kpj1i/I3IVCV2IA5lpU4I2Zyja2wmz5jljlahpNM0ciMoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 1 May
 2024 00:18:06 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 00:17:59 +0000
Date: Tue, 30 Apr 2024 21:17:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <20240501001758.GZ941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <4ee1f867e838b90a21de16b12cf2e39ba699eab4.1714451595.git.nicolinc@nvidia.com>
 <20240430170655.GU941030@nvidia.com>
 <ZjE/ZKX7okSkztpR@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjE/ZKX7okSkztpR@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:208:23c::29) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 344c541d-0fda-4887-cb18-08dc69742883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wg4gRawHDV3hGgzlOKJPc5niFDwNOhrrSbqLiTj+IC/nZFbMKBIBX/37u+zh?=
 =?us-ascii?Q?TNXkymtbiDVpB91bRorrl9+R0XJbZrSXEdyh4HYqUvgJBm64pltrlr/SDl/y?=
 =?us-ascii?Q?u9rpk8zoi243jXzBdo4QTEwZIdm8nyAsKEucUlPlD11Z48Y5tRGOA9jnQOTh?=
 =?us-ascii?Q?ee2evR4kNWIC8r1RVEhCgfq60aHnmBpuO+R0kv+2eRvlHF8d5dbjiZ9nDO3P?=
 =?us-ascii?Q?hwKOm9YV1htkld+MvmO5gy5zyL5zt7p7PWF63oSz7eC4/zaWeMom//ROhXJB?=
 =?us-ascii?Q?MXB+f4/cpxcncfxOG/+aE3IVsdU2kJpBWElj0ja93yF/BLMNsHido4I65B1s?=
 =?us-ascii?Q?qnBz2WrFvMnVLYK453gQ3UctxsKqPprtO0URUdO4mqRdtM5794zcNtlr8hDc?=
 =?us-ascii?Q?c3WG3PlwvODsmBXX4TUUHToSOr3KPmvVtdkYHiGJ6GE2NE0bu5dOUd8x9zu9?=
 =?us-ascii?Q?oAjDuGnIDaUtYx9q9icFrwY0KX0xicGzksxg24KUQdr6GdbGfBakLCL6bu7d?=
 =?us-ascii?Q?QbITUTZTqXubmNZwilcI1K1OQ4wlTWcjElKpHVgm28AViZqWuBBI5FqQxe3X?=
 =?us-ascii?Q?3OZyTfyZMKuBMrpEEc77hHLjDJs2bAQHBmBhZxZMicuXRer4X4eK6kDT8bjc?=
 =?us-ascii?Q?AYNJA9GObUTp8vms09bz78dSIarGT72zDBrEUJjVwzB2tO7wDvueDllQUqyL?=
 =?us-ascii?Q?0dhFZkR2TVqffZ3he46tOVOskN9k+dkwST02hnT9mfEfI/8+MTKkjUePwOuT?=
 =?us-ascii?Q?QhZ19BOSsH77/bAS1heiLFLQ9KxXnAENG8ljdoSnPdLSk/ZbrkmRFuNBV5zV?=
 =?us-ascii?Q?bZdj/gDi5HwPNS/ULz189qMJcw8g2iQbFB31fPk+gw6JMMihjuqoVo5U3Ehv?=
 =?us-ascii?Q?zfJYfFAjwicxjZ4Z2kve+HXbdRy55SK0fEA2JJaQyk4SESstrxQK7CPSYNut?=
 =?us-ascii?Q?CpfP9cJHnSmlomx+5RwabH3mf1lzggJqCYQem/3jYFIgCsdERF1RiJq0BnMw?=
 =?us-ascii?Q?bIj5VMIp5aOR9fx8MT/HSG4xfolkPjzJEWSsz1kICONg6XeHItOMMIGCa46J?=
 =?us-ascii?Q?xuD4PdwNMN9IMsWGSN/tBw2eq+aONDXhxtSLSTDjJBzqG5GYbYvcB3pk5XDV?=
 =?us-ascii?Q?821otMrWQCoVSByjgd8ZdwyLfBnGR1kbBBAWK7b9n27xjBKOx3IlzWG4E7tn?=
 =?us-ascii?Q?rl0dFEEXbwSXJkIf5krV05CCAmqUktpmvvkEUtm53sjSc2VB/0qRA1E+5/Cz?=
 =?us-ascii?Q?bYibQPDsr+RuPXjsHPVKk43dqCHmjAVSehtXdbX3bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTZIjq2BEEo8pHOHNYO1NM9xhkdlZ61SbmMCcA0Np/mRGl0ihPEaLnwIotGN?=
 =?us-ascii?Q?HiAUBe3E4b8Avj1Z9FV5hlu0iQvT41BvlYeepC3Dh+A7BnqCatBwG3gOe+XN?=
 =?us-ascii?Q?y0iSiSRFWPznUrlBm8etU1ctbZjCK4uu2EXJCJMBpL9qkifivBXiLhKvmogn?=
 =?us-ascii?Q?cMk9t3mftl3Cy/9U6T5xWkQiUESRj+jnR4f4Bj0oDEX2yrrudl5Js4D6eAJX?=
 =?us-ascii?Q?aTy7Q3aK0CBOSLQ/2+M1QpmJ/kHRYTXC7StjGWLEkG7LJHtXi5X0J9c1etTE?=
 =?us-ascii?Q?PsP1raeZPEm3hvRVt8D253VGKmeNTPAwgMoq42vJmquYbqveaMCtfeVNbkcD?=
 =?us-ascii?Q?JimuZfNOAarxelBiod1kSSKyjFBDo3uW7hdAVjFoSxHNPuwkRv/oz6V2GfOx?=
 =?us-ascii?Q?RFSIf6VF1SFkXrtMzmUqgM57IxRug2JJjuVY+ZBgmuzImTCr3/L7gEaPwbkn?=
 =?us-ascii?Q?AD5f1fqt5haaiEUMktgeRvWRQVBDo19UzapSfl0lMHqMhBkkj8EWY7Dw9ICV?=
 =?us-ascii?Q?rHa7o6Ra4KKsAZs6sTgMMnWgRUBsx+czIBHC0mf3cKo+31xNBY4wFPyZ02jA?=
 =?us-ascii?Q?BNpjTYpJcaArFwOxM489puYAV5DAPMtercXSrd7NvRd1miGRiPZ4G8e/Dcuc?=
 =?us-ascii?Q?BawIFcIE+bVqXZIq5eCmFrWvBqPvL/XNanNHm/WoT5ZrstGTs/NRa/TDDe8w?=
 =?us-ascii?Q?llWNdRe+1nXbO/jHUqsUQm42Bk+M7V7Om4+Rz30mcCHqNuABpkrezD/bPnXp?=
 =?us-ascii?Q?puVQQu0iCmSb78zY92uQCMJ0kSLd8NUTrs/Fb9w9eZJnH8l/JO5xlrLcjegU?=
 =?us-ascii?Q?/0wkvgyyPJHAHAJyvvuo/pdFNnFSychyKzruY21NINvHfgLNOukxZhV3h41I?=
 =?us-ascii?Q?tRf/ILmg+QKTJwNlMVPZdJ0Jrjl8F9DYSYBkkDok/Q4MRGTQoX3JXENJoWXU?=
 =?us-ascii?Q?9d39BXDjCCueJaplGTCrdzdEXvS53Aak/NF5Un8vMvprf3PmZwXjS9r4SbPp?=
 =?us-ascii?Q?mPY/nMvhDbkaj+MrvoKuJTb/Q8cgiocOTKGWmuX1z6M/1FH6LCa9mHqDlsDM?=
 =?us-ascii?Q?veR2M3sfKjOeU2Hsz50PX4Y3yE5SOGBx0GRFiomJN+q2aZpYPl0Z0Ca2E9HU?=
 =?us-ascii?Q?fOimCt7LHIBaFP2e64HxT3uO8uEP8XTBkOGqp61hiU2ZlKyAmyyGNAELcowH?=
 =?us-ascii?Q?iE0VSZonXeJ9aTnegFSDH8KbUxFXH32ZcZQ2Xo6vQjXmRHpzq6lzDfKmZbmz?=
 =?us-ascii?Q?sOuffyWawKx2q641pEF1UyYY4Lbh6uBhdCZ/puYShZrQIKJ5TcylCOSThiQv?=
 =?us-ascii?Q?UckcHHMoB9yni5xBEuVl/P8HnQuRpVrtf4dhL0GjjBeT5BVsTATaJisNcAu1?=
 =?us-ascii?Q?3hoh9m3Vt0pxGrgogDrfDZ41ZvYDhuHByZIN0XOe8gEqvltzdU4gI70c3k8P?=
 =?us-ascii?Q?I+OKPJ32rreCBzYeDnaHLxP+uNS4oF9oUWdMrHF6/5EYZc4uhsg4LZ6AatUm?=
 =?us-ascii?Q?N00CVAVpRTpcDjZMyfs+zWiZhTqmqJTyA4d5ey5tN608C85vi6mlpR4zn+OJ?=
 =?us-ascii?Q?V/BgTXlXWM7PGC/Br+3VZn7mL7iKzco7Z8iAgsw8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344c541d-0fda-4887-cb18-08dc69742883
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 00:17:59.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfadC1gT754EY1y+RkUhb9PqzqbwBzIZgbfsUj4WBp1cixjylf4kyFeGlQO72XWi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

On Tue, Apr 30, 2024 at 11:58:44AM -0700, Nicolin Chen wrote:

> > Has to push everything, across all the iterations of add/submut, onto
> > the same CMDQ otherwise the SYNC won't be properly flushing?
> 
> ECMDQ seems to have such a limitation, but VCMDQs can get away
> as HW can insert a SYNC to a queue that doesn't end with a SYNC.

That seems like a strange thing to do in HW, but I recall you
mentioned it once before. Still, I'm not sure there is any merit in
relying on it?

> > But each arm_smmu_cmdq_issue_cmdlist() calls its own get q
> > function. Yes, they probably return the same Q since we are probably
> > on the same CPU, but it seems logically wrong (and slower!) to
> > organize it like this.
> > 
> > I would expect the Q to be selected when the struct
> > arm_smmu_cmdq_batch is allocated on the stack, and be the same for the
> > entire batch operation. Not only do we spend less time trying to
> > compute the Q to use we have a built in guarentee that every command
> > will be on the same Q as the fenching SYNC.
> 
> This seems to be helpful to ECMDQ. The current version disables
> the preempts, which feels costly to me.

Oh, yes, definately should work like this then!

> > Something sort of like this as another patch?
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 268da20baa4e9c..d8c9597878315a 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -357,11 +357,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> >  	return 0;
> >  }
> >  
> > -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
> > -					       u64 *cmds, int n)
> > +enum required_cmds {
> > +	CMDS_ALL,
> > +	/*
> > +	 * Commands will be one of:
> > +	 *  CMDQ_OP_ATC_INV, CMDQ_OP_TLBI_EL2_VA, CMDQ_OP_TLBI_NH_VA,
> > +	 *  CMDQ_OP_TLBI_EL2_ASID, CMDQ_OP_TLBI_NH_ASID, CMDQ_OP_TLBI_S2_IPA,
> > +	 *  CMDQ_OP_TLBI_S12_VMALL, CMDQ_OP_SYNC
> > +	 */
> > +	CMDS_INVALIDATION,
> > +};
> 
> Hmm, guest-owned VCMDQs don't support EL2 commands. So, it feels
> to be somehow complicated to decouple them further in the callers
> of arm_smmu_cmdq_batch_add(). And I am not sure if there is a use
> case of guest issuing CMDQ_OP_TLBI_S2_IPA/CMDQ_OP_TLBI_S12_VMALL
> either, HW surprisingly supports these two though.

These are the max commands that could be issued, but they are all
gated based on the feature bits. The ones VCMDQ don't support are not
going to be issued because of the feature bits. You could test and
enforce this when probing the ECMDQ parts.

> Perhaps we could just scan the first command in the batch, giving
> a faith that no one will covertly sneak different commands in it?

Yes with the current design that does seem to work, but it also feels
a bit obtuse.

> Otherwise, there has to be a get_suported_cmdq callback so batch
> or its callers can avoid adding unsupported commands at the first
> place.

If you really feel strongly the invalidation could be split into
S1/S2/S1_VM groupings that align with the feature bits and that could
be passed down from one step above. But I don't think the complexity
is really needed. It is better to deal with it through the feature
mechanism.

If high speed invalidation is supported then the invalidation queue
must support all the invalidation commands used by the SMMU's active
feature set, otherwise do not enable the invalidation queue. It does
make logical sense.

Jason

