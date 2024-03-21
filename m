Return-Path: <linux-kernel+bounces-110011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62E8858DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5711C2061D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798F67603C;
	Thu, 21 Mar 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="frjpWqK+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD1757FB;
	Thu, 21 Mar 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022959; cv=fail; b=B7Q3GmIGtpO4Lc4N/aJlJfnuW6mAD/Zpgwy+dOOAG9wnwO0MWTTGXOFqmuITvl/4zlGlTa6fYFf03Vt+zPvlFqZeg2V3Zx1rGJ5ZOUsjU5TucN9XVcwff0u5Hu5YG/u6SBZfe5cKthvR6ExlVsZG11zGwRb6oKJ7mJcngyD2Zd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022959; c=relaxed/simple;
	bh=Ru9MkZwIg4lBkLu9MFJrre7ZWKfwqYdU3+jDs2VaWAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CnTvm8Z7hozgSdSFasFiLHapp5p7CZ/4MADsG8bnnbK23/GQ6fF7t58x3iv/av4qI0sIBWsH+6ipR1eO9HOogNnR765tBQA5xbJMLtiTfxL1LZ9kUXABPK43kAKVnqvTTlQv5+8F3l0Lu/3wCZZtaakYDPn8/o7p0m9RlIEOKUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=frjpWqK+; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASPuDPdHO7KnUSzGOg9wEsIXeZsyV5dHEongShV3DfEIPgqDdj1NOxomDA1z7ifpsNr0cMN3cCfAq21G7XMfwzBdbov5MnJFnkgfx89KG1LNmfxZf4yxdgwZqwtn4XsjCLv01lgbbmM0/CoJ/DH0dGVDrCG7LrVcB7pLsCM2bAqNngj+ONoG2nMQKD0nNxzegm9+E3mu32mQs5Am1NHQFW57oOqb/bmPWxBs6YcM+0AUkSwyIB78MDvhiVQYc3f26NuOX+fQyO8dLK8w1OHiC5c/hcqyPkTSa1uTB+9o7SiK4SCMJSQf3/QBpx/1Ey62Tgxk8Y1dB2L8yMFkyxrk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n9HLlAZ3B0iZ5ez1w9PTvbH/PyuWPzVmwA1/x5Be1M=;
 b=GJxxvVSnI5otDeDeJ9ehtHjzp336tulWe1KDAe7wJL3w749avvP3/+n8waaDj4s2y41E3AhUdmg8axSxGBpHJkUevbiTCOd6LftlgV4/CAU/ebZ7625hkYR3upDeyB0ckSAW9tvPepx7FmtQuVrFuNEmetq2YZT4yLiGvXS4EsBdqo2mJSmEJp3T2wWLb7rmez+cZG5sP5XoNDOGcp1aT74LjB0kIEVbXnIjMxfL0hoUeaR1EFwp2/67PXgss40zMweeu7znOGCIuUOmQlHm8oXJtT38UtPiel9bNbvA9Zwu9aluKwzWAr2Lt8pXEZLuu8Xu18iCo3cr6baQ6VI9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n9HLlAZ3B0iZ5ez1w9PTvbH/PyuWPzVmwA1/x5Be1M=;
 b=frjpWqK+zFAXWf2hsRD1dfmNhKUfqX/m196KhNhSYgg1sZFMwZAvb91hVthB2A6uGquluZ+e6NIrmX9Q3CTuPZkvzj+saBduCgHJc2ACDv76z/6ov0KIfeB4rhbQG+IDAZpZCfGH6jKj7W9EVpEHZysnvjDlCCEOcrXsrhecuks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 12:09:15 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 12:09:15 +0000
Date: Thu, 21 Mar 2024 13:09:08 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cxl: Fix use of phys_to_target_node() outside of init
 section
Message-ID: <ZfwjZMJMNUpWXZN8@rric.localdomain>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-2-rrichter@amd.com>
 <65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zfl9Efxe7DwuU_i3@rric.localdomain>
 <65fa2c219548f_aa2229499@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fa2c219548f_aa2229499@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR4P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d24bc5-0eef-4aa8-7927-08dc499fb9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0K5sNq7D+0bAJU7UuK2EHmOYmNyDlGpTpbIr1iQtj0po2a0AD+SfevHeLTmJe1V4Ic4y3Mid3DX3m1Ei019wcpyKUOPs24pyG+BQZD74iNZ3oYJhpQudz6vDeYt4Lypq0IUXvpLg/SsGclP8Cogn6pRuvHSLuBezTjn4x7tYuIpPdb5Udou3hXjcrHesbQnsHa5bV/wnXyHxPdJ6P36NtAI31IU2N6K1yVOtOacs9sMukotKGLUaBD+50xcT3RTsVE6qysZ94CEEsRYEkl7fIds2KugJeRm0Wq532rq3PABsB2xC5h0JAw3SmAfF3VPcZBEXlYs07o6GIG099W8iTSpziR1ElwXZCnTGUYpL4DluwyXkuSTklIzLJ6RFjzwIuuj6VINXhPXEGz+zn8k3DBYfRpu+vSI3x5hnaHJgXe3+VnWdHlaqQNbyNH728tHh18qSqfopm7fP3EQh/2sa6v3tOeD10ywXbfFIhSGP14O1jvghiAmQXXAbbIkc73TOG00Gi4anY2MpxKpc7GRqlXvClKnHt0RIqsRZSPQOAe1KOpOMs/xTuw/hVr5kRJUfWNanD3pzBxwI0Cs477Myi6IDNQtECRTM6+ZhzS3eKJ9vi8yLkeXNTTOdzPr/PuxhTxw0Vkfvs3ow9CfCEHQg60XGhQtGoMWaTPkZMw9fGz0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/IqBz3iH8m59jzBje4GlfIy60V0slJpbH1NwFLVSrl3Syux9Hka8yL0+Ndt?=
 =?us-ascii?Q?JLLSqlIPAGnqdFpXqBgrZu7Vz7tsNptLX3gu3NOXOnO0ah3oSPDTjjHNN7xO?=
 =?us-ascii?Q?gA+/7yA79JiuZlWVXmxENHszf17Oh1heaZ1HB+KoLlejAAoqDIUc7T9fwyE1?=
 =?us-ascii?Q?a6iYVnzu4ZFjYeYz2xU+JsxwpHBUn8WPgH56VMafCa1fMWuG8HyPlcNTwR+8?=
 =?us-ascii?Q?zq322rhA9X6oEh/wKR7daL+TSoFwvBbmyMLg4DExgnoBYcWdGz5SYLLQjR9B?=
 =?us-ascii?Q?09DB60ViFTQAiTS9mYrk2g0ZZ5Tr5J/N1G+UHaNDDJzTa3hveKwXRZKCTRHr?=
 =?us-ascii?Q?NSBX1DREM4Ik2RTiMx8E+jpWgosdYxF/bv2XsPSeLvsdD5Za5KdhatxSUIF8?=
 =?us-ascii?Q?ye++LyUsiro5s1/NyLvyaKfnkbHvEqiY/0zVS73XbtRI15OQCHm8ARfzQ1M3?=
 =?us-ascii?Q?beOxnDcBwx42wqlaSE5zGg0M3/l60TsOhEeYbEh76SBNBRdkMKVAOXpS0pxj?=
 =?us-ascii?Q?f/dEgctiPUuZCvcL6ice5j0HXqGNdRCTDrfVKYctfebRQEuCyrTp2UJunsF7?=
 =?us-ascii?Q?NH0mUDPE/ygkwNLFhH/j3MNc7TriS99bjV9xz1ExQycj7uOdf5VxZm4cjIZ4?=
 =?us-ascii?Q?OAp1S6gT0DTZc1rK4lf/iBYunPzmtB+ZjQOo7EJp17JUURlb3FHc7FGkck8L?=
 =?us-ascii?Q?mkb4MYagYbrIIFNspY9DEyDNNWui0eQQH7hiSjJ3TiWRCOOdQiIjP0Y9XwMZ?=
 =?us-ascii?Q?sMTT91pETpRnktg+n4wyJBYD36O+XJcms0t6mZ0X4WXmF73WfQuKtR4COqBt?=
 =?us-ascii?Q?SCa5k/EUcrzmVdkzpf1JyNvf95KJeEPPCj2R46/e61hfb2wc2mSP8UFpdpaJ?=
 =?us-ascii?Q?XqrOelyt6402mpeb3QbCrwOj8AsQMsz5oLYiqNm5hdV5gwq7R7k52uMNvXoU?=
 =?us-ascii?Q?A0CSVXGD2KuV8/L0qAc3tJ78DWx8zCjL22QH+L+Zvlkoyd6f7qOxlBJwtjf0?=
 =?us-ascii?Q?SiPpGyExDQZ76C2xjl3gwm0QjhX6U50lJPBqs0RFNIC37WQSgAetQEb/Uc+8?=
 =?us-ascii?Q?NSCD85W92uKoTAsIw2RKwMp5zKWhhL3urnsndODcA95J6y82Hnm0Usej8Y38?=
 =?us-ascii?Q?ZUYvvj5Zy1XWgB5e+tSkCn84cVM6q+OUKMpQqOUxzbm1W41djPXQc1h2riag?=
 =?us-ascii?Q?6NX5h3IoXW6rnYxuUaTMTG7SNWBJcQ29ar2tR5yts2W1EevCxtSZ/mVMWKd2?=
 =?us-ascii?Q?l51h4eATCWMclX8AwubHl3LUVBcONUOJH0sRmEFToOqt2j9PZXqeN1MRtU6+?=
 =?us-ascii?Q?9czhWQ7iL1XPVVOXYXnWh0erfV0E9DjoJkpdfjlrXtIOmuFzfRTbaLbqG6Ne?=
 =?us-ascii?Q?sBkfVqiEYlL1YVs1jMZ6ThBrfc90Cw9BKkUhrQ3UCRuAyRqbDXgn7qqrnVtk?=
 =?us-ascii?Q?MyDEc5DXjAxUXcDmcSYrDX8niaejEuACIVOz7u4CQRf2t0ANCYcbcyT+APrk?=
 =?us-ascii?Q?OXQf48QPAF3KYBNjnCp1EUxI6b433yklwG6mpC3GAvhYskowGe/Pc/8ixFA2?=
 =?us-ascii?Q?CYB72py0+G+Mn6ZztvrYxt5bsry0098RWsZ/Aq6b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d24bc5-0eef-4aa8-7927-08dc499fb9f6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 12:09:14.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y41Sf8aV9rXDeJfSuyX2dy/forSTkEWtNMRwEarORvrZm5i7AFsIkr8saOk1VQjSGtLRlkrbNM+kZSy6YsfS9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

On 19.03.24 17:21:53, Dan Williams wrote:
> Robert Richter wrote:
> > Hi Dan,
> > 
> > patch below. I have not included it into v2 of the SRAT/CEDT changes
> > as it is cxl specific and can be applied separately.
> > 
> > Thanks,
> > 
> > -Robert
> > 
> > 
> > On 18.03.24 14:26:41, Dan Williams wrote:
> > > It should also be the case that cxl_acpi needs this:
> > > 
> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index 67998dbd1d46..1bf25185c35b 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -6,6 +6,7 @@ menuconfig CXL_BUS
> > >         select FW_UPLOAD
> > >         select PCI_DOE
> > >         select FIRMWARE_TABLE
> > > +       select NUMA_KEEP_MEMINFO if NUMA
> > >         help
> > >           CXL is a bus that is electrically compatible with PCI Express, but
> > >           layers three protocols on that signalling (CXL.io, CXL.cache, and
> > 
> > From be5b495980bae41d879909212db02dac0fba978e Mon Sep 17 00:00:00 2001
> 
> Hi Robert,
> 
> When you send inline patches like this can you remember to include a
> scissors line? That way tools like "b4 am" automatically know where to
> trim things. So add a line like the following:
> 
> -- >8 --
> 
> ...see "git mailinfo --help" for details.

Thanks for the inside on your patch processing. Will use that in the
future.

> 
> Also note that if you reply with an updated patch in a series include
> the "vX NN/MM" suffix, like "Subject: [PATCH v3 2/3] ..." so that b4 am
> knows to perform a "partial reroll".

This patch is in addition to the other SRAT patches and can be applied
directly to the cxl tree. That is why there is no version update here.
But I replied to this series for reference. I saw the b4 shazam
--no-parent option, would that help here?

Thanks,

-Robert

> 
> > From: Robert Richter <rrichter@amd.com>
> > Date: Tue, 19 Mar 2024 09:28:33 +0100
> > Subject: [PATCH] cxl: Fix use of phys_to_target_node() outside of init section
> > 
> > The CXL driver uses both functions phys_to_target_node() and
> > memory_add_physaddr_to_nid(). The x86 architecture relies on the
> > NUMA_KEEP_MEMINFO kernel option to be set. Enable the option for the
> > driver accordingly.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 67998dbd1d46..6140b3529a29 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -6,6 +6,7 @@ menuconfig CXL_BUS
> >  	select FW_UPLOAD
> >  	select PCI_DOE
> >  	select FIRMWARE_TABLE
> > +	select NUMA_KEEP_MEMINFO if (NUMA && X86)
> >  	help
> >  	  CXL is a bus that is electrically compatible with PCI Express, but
> >  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> > -- 
> > 2.39.2
> > 
> 
> 

