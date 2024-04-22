Return-Path: <linux-kernel+bounces-153984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849988AD5AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82261C21057
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8071553A6;
	Mon, 22 Apr 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nvdehezc"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B9153BE4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816609; cv=fail; b=HehzHh//MkEpr2NxVVzwpmW2cpA8WxVUXYV1sRoAh4k07wgOwzGEZQqsFwX7hK8p2GXrm00dse8scQ17TejH0F0t+0TjYedvBm8wxzZXAbHHi+e4XJJ7uVnkH+GO8mGGcwcAdlwCI3zrH3Wix3hNWYRM5YUZGBCMJ5bb4Sv+/N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816609; c=relaxed/simple;
	bh=P5YgNAEmk9v2iE/W5htK7vnS7ect0RWb4CenVpTXdTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HGzguSGr2skKzBrN77SNUp6524aFCGxUrs6h3daafae4tn34nHRra2KI44wcx7L0071yhFyqFrru4W36NGZ3+t5Fu3+YL1vyhQ2ZOZ6dsh2oyARxWb7ZemBTLk3dFd/1XaQnbRgIgD03FSfG33Bj7JaFtKw2orkUighglKCWkU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nvdehezc; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXBuvoxqFIGoM/qbcU7kI/qQ5at0+nzw/OhcoWPWx3Eqd5JN8TE9vd7BZqknUzBk9PawGUuJalQ+WHzOf2m9E5hbQq1lUGow5AkESAcGkwWpcQRWDuhNYpToOBnXS2Hudn7Lu7jlIhE9/iQ5SEwJ0a/n9qqOyMdSk3sMJTVbHz6U94hxbF3+7Fm8WO77C5HEpFJanc7A5szmtl51Sjz1U0px0BFDciBakE6NGxNWfhESdAUB1o9QTJcTMq8UVMyG/rRrLbrmlDORkfTeBaIydDwM8U+hBQxoZeVhASrZ1mmssYBdHN4iz49nPiTCcaBiL4y+A/Qm3RU9gIwX2t+MMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwPa3VhcuthT92uRrSxVKk4HgiR9/lLPyUqgLPcxd9M=;
 b=VqOOsmspCrYO0Ih976VKKDtdZTY1FfSk3s/Nyrm4hGc+YzuT58rROeAeLwyhDKLDzb5gDqjj1TfiCdmlznbQJ62ln2fLyb5S5raawLTBr2Dhy2uyiRyTcagOUFxItGwfcgvGVFFJOmPEqcGbLJ21y8kUSaSi0teunMhKKs/W4m0f1chdntBVxboDl5sANBxxzyv4xGv9xzxogb9AKtLI5F9IeX8WAGV3ugjvem08RrnpyR/x4LR0X6AlIdGaCpWktJmAkmhWGCE1i9r5Bqy1JEJwR5yIVCzURmtaj4nipRKLLvAuybWi6ShFR12QlN2fkk5RWVV/n3fbW558VKmoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwPa3VhcuthT92uRrSxVKk4HgiR9/lLPyUqgLPcxd9M=;
 b=NvdehezcBHvEpj2NTwFrj23cdyXUyeMgLXT+7dE34nOpQWwVBwOxkjT7d/hbZKsDgP+ULbe0flpdD+nDBdTed8Edyxg3UWvlwGjONH43kb2mBLM7Xartgbavh4UzecabNnFPsewgf2Gdq0+iRxvHEPHP/rOQjG30x6tmlgFz+JM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 20:10:03 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 20:10:03 +0000
Date: Mon, 22 Apr 2024 22:09:57 +0200
From: Robert Richter <rrichter@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <ZibEFZ6DoxDeBxxp@rric.localdomain>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
 <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
 <ZiEMnWaHkn99_oyW@rric.localdomain>
 <20240422172055.GAZiacdxkQU0XAbybW@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422172055.GAZiacdxkQU0XAbybW@fat_crate.local>
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 11baa030-86e1-4f00-ccd1-08dc6308322d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2wNCtl9ONPS4uUk3xZDunbxr6nsGoVuwLdpqvP7e/26HZjRrE+t38xdeMBNX?=
 =?us-ascii?Q?7huFMqbZwgR+ElBF5Z/iF7vMotYejTJzY4dHzPGJQpORusUi0dzVqimA58V1?=
 =?us-ascii?Q?GXOeK22PQ2hW777Z+LHqI1YxUL9wW6R9+3JwNU2nWX5jPD26a7asmAbpzgmv?=
 =?us-ascii?Q?Hfhze2e/6THTXnIP4XRHub3bDQ7sPcCQHZJ/6OUg+HQ9bd5etlrFC9NKTP+w?=
 =?us-ascii?Q?UmrW2o8Ezfh9kbLUJG9xa7n9cf9dqVImv0DinBVfrvCn+3p7x1Aw2QbTWfpy?=
 =?us-ascii?Q?RfgA9CV0+f2L9Y7dbCgyJWo59oeQ90Pq0YjuuKBPTFPyctimxdzDNn+WZgfe?=
 =?us-ascii?Q?GgyXZiGkl4e5X9LpoBGm13how+Kux5vO6046prFanzbv4NPq95gO64AQIpyv?=
 =?us-ascii?Q?8S3oYFYpaVK1qformvlsbrOV87HmUZBvmBqSkcOKdlT8uv2yQ5aOPVzDlgiZ?=
 =?us-ascii?Q?JfqEnHbJc4bR9OPIFIfzvaNjfoGD7yqBSJkMwsIdwAJAIDfVGW2kWrKySFBj?=
 =?us-ascii?Q?6s2hLipC82Z95UfdUNK8AbbjidLXppwb5M0jsvFQ67tNOploqj2nBJpxeC/g?=
 =?us-ascii?Q?DfJRpxSRep8UiwZfb/SARuEj+NE6Z4vrGHzweL8rLpA40xdENxYWB0Qfw7aN?=
 =?us-ascii?Q?dd+41vlmKLtUWHx15XPfNkbA/QCZpZ9j5HopsSMM0uCXrkYIkFiOkZ1Ra1qI?=
 =?us-ascii?Q?zhZuXCGVBwAeIHbPWsITxxE/HXIIYU49Czz5+kdgGcMh7UDodLNSWt7cg335?=
 =?us-ascii?Q?4fVBcKU249vX/JNnkOBzgStx17ZyI49+Ab6J6ivbCZJnfRCQcW9+zHufbjVq?=
 =?us-ascii?Q?OTT18eBwkb3BUW0/qc06qkLgZgGnZTkjdsDbPdom1R1T6VjYe8rI1WHqwngZ?=
 =?us-ascii?Q?EG12tgwH+EChzK9FPLgmidonYu5MbRnUv8VQeH8rvOBAEfpZNNzjwRTR/jaz?=
 =?us-ascii?Q?Cqx+DEfaQZ1rHv8DNE3SDsjAF65FEfCglOO9jtVznvszFQ8o0LmssmGa8Zd3?=
 =?us-ascii?Q?YLWZaIZFMl1Sr2tG+0IduVKcbgwIMCfYma0qbbK62xjRee29E1UMRvJN+6Tb?=
 =?us-ascii?Q?Nr8rAadO61XX3HA2KRnr2duiOxG2HwgTJYXBSdxO7sipJThbpHA2hNI2n25a?=
 =?us-ascii?Q?erO/wNjrdQZlof3cpRkpJIrOaqkg44HtMOwLsN42Dzuc5UtyYqUf9CZdGx9U?=
 =?us-ascii?Q?kplv0AQx+bNn/PbjMqPFALl5g3fOIY7BSwnxCnaiBCX/62egauPlKRy9H3ev?=
 =?us-ascii?Q?NO5hdp7E4d8Hl5P4VSGcEPU3+q1XFB9PRCm6gIIqqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5aOX5yfeoAMk5pTyM/+d63cuEYVet5eKaAiePpH+h2TqOKMnM9DNb56vaxDC?=
 =?us-ascii?Q?1Zh11Jve8Iz25SUoNc5LEN2SV+4mWjuECBP+6+So4p1aHsfp47SJ+/WsHK2t?=
 =?us-ascii?Q?ai+7OrmSnbiAkbNBah+IoA/6obJl8FYG+PMEnsCtEhznTYGB0Hg/hXc+mK8A?=
 =?us-ascii?Q?C5Wc1pc3a7Uz6cY7mFUK2zo/X5VAQjMQoovUC/XSij6yhjhwp8+qZZpD2amH?=
 =?us-ascii?Q?5mE3RWYwmC3YYGdhRhGr29GeKiGd8dC7XRPWPQDSj7yWrWuVS7ol1boU1SLx?=
 =?us-ascii?Q?yv2GSTwf2d/9DdBvqGFkNNSBA0+q1XifvlNIaigoN8Q9rCg+rVN9e5ktT9w7?=
 =?us-ascii?Q?6KWQaYjA50EjFr1jIsiHh7aSNlsBLL8Dod1vOEXZfT13DXCRmVeWDVy6ftsK?=
 =?us-ascii?Q?yjagtb1w7gunG3ok/0uD9R/nCUt4F91Yvs0BzIdkgngR7CkxxL1znQe5bnKw?=
 =?us-ascii?Q?19CybU8ooRhijga66eWfEv5S6eMdmUs5EcAPIoB0G6KgWZr56n7SYQq+7OD/?=
 =?us-ascii?Q?/sl68j3oaqP8GcN5Bv5o0N3vT47ExPl2mWVBWT+2a9QN+UyV6cv37IxAddH8?=
 =?us-ascii?Q?cJoJQ0kYTBHS9dD8uk71Xi26FtOqK45VW9db7nfOhFuu7Gr+D4eGZEzNNUsE?=
 =?us-ascii?Q?ESb1eLEGgZ04X/sHArgSBih7v3CtEopgoafutBG1mJ/4b1ueyfEkridMnup0?=
 =?us-ascii?Q?Uo/iYhjGvudF0UcLmwkVA7XnVF6zix9Jq8CkoYso36sxeG/di2+p+vKpXJCM?=
 =?us-ascii?Q?xLo6MEsDI+yhxLL5NRD3YTO2KHiRUE5Lxcw7T5zpWKozXm7EEAgfyzT+THX6?=
 =?us-ascii?Q?ICczRHcAK1FTxiBYquPIGcguJoZ/1E/OGdGKNueCTvf/e729JYez51BPrGRG?=
 =?us-ascii?Q?bVaOFcvxni7s3JcTeWTrza0qtcuiakEVSxFnOcVsXX+a0ZM+rEElDzERCQmw?=
 =?us-ascii?Q?6po7KV21Yucms9+p9IypBgr6bZsGlTU+S/bH8+XutpzkGr1YtRYbnAlgPrxm?=
 =?us-ascii?Q?5+wR8rkisaw+TtQiUGp4r2jCo3x/YXTJtxrZe+JaNtKiwDDG0CDk/4WGH2rI?=
 =?us-ascii?Q?+bcce588bI3L/wLMdoF3C2PPfP1ezKgBukkIcekm7IjxYMFv8Fs71ru1vMcx?=
 =?us-ascii?Q?sWqQjm6/vK8l5YB9exdAsQTu/BdzSST0eHG9P4Vh6kl8B2y6oPVrI9mbvAb/?=
 =?us-ascii?Q?5tKO0KrjWKClF6lAW7Sl7aGFaREHsiGaaISb2l8oYpwAT9iG5eM0ZYvx3efT?=
 =?us-ascii?Q?C0wYOSofIz4bVJ8S53248g8DPAZoS87L48am1wEFDcbkmw+2Cnqa8+XuucVH?=
 =?us-ascii?Q?PVpw5BokqkrI35OzzMaCSi6WCSby3uTtwFe7/KzSSXh29PWjzf/mBtA9lOFs?=
 =?us-ascii?Q?bpoC0BgZ9Ex1lLA20pMukpl0c/Iz4sWIXSMHQd9ZM/QMAoNbXUhwSdaxYe+7?=
 =?us-ascii?Q?/2CChJOviPfka6v5tSfo6tL4WwXY0P1NgNaDrue62sOu82ukwWqjHWMB4kLH?=
 =?us-ascii?Q?SZ0e0Vau1qmE/JfLkprY3BsO2lgt0WpGs7yWNB3/DW6ylo0+/6nzkn/RMMGO?=
 =?us-ascii?Q?rd8WLaOidr3++z5NXeQGh4+CgwrgAbljb79SjbWS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11baa030-86e1-4f00-ccd1-08dc6308322d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 20:10:03.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6LHRgDUouv49t7DdLaFT8RLoQayzLIDt9ElYM39lrPINFn4lnsyjhwYNWgE5ZkSf60YF4DUep8M8Xuk9gh8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

On 22.04.24 19:20:55, Borislav Petkov wrote:
> On Thu, Apr 18, 2024 at 02:05:49PM +0200, Robert Richter wrote:
> > There is the X86_FEATURE_IBS bit (Fn8000_0001_ECX, bit 10) which is
> > available from the beginning of IBS (all Fam10h production releases,
> > revB onwards).
> > 
> > And right, IBS_CPUID_FEATURES (CPUID Fn8000_001B) was introduced with
> > revC. The capabilities of revB are set in IBS_CAPS_DEFAULT.
> > 
> > It doesn't look broken to me, simply the ibs caps field was introduced
> > later which can be determined checking the return code of
> > get_cpuid_region_leaf().
> 
> Right.
> 
> > My preference would be:
> > 
> > 	[...]
> > 	if (!get_cpuid_region_leaf(IBS_CPUID_FEATURES, CPUID_EAX, &caps))
> 
> Right, checking get_cpuid_region_leaf() retval should happen.
> 
> > 		return IBS_CAPS_DEFAULT;
> > 
> > 	if (caps & IBS_CAPS_AVAIL)
> > 		return caps;
> > 
> > 	return 0;
> > 	[...]
> > 
> > Not too complex?
> 
> I'm wondering should we even support those old things? All revBs should
> be probably dead by now. But ok, it's not like it is a lot of code or
> so...

Since we check get_cpuid_region_leaf()'s return code here we know if
the cpud leaf exists and return IBS_CAPS_DEFAULT if not. That would
not change the refB behaviour.

Though I think that case is rare or even not existing, I would just
keep the implementation like that and as it was for for years.

> 
> > This slightly modifies the functionality so that 0 is return if
> > !IBS_CAPS_AVAIL (instead of IBS_CAPS_DEFAULT).
> 
> If !IBS_CAPS_AVAIL, then this is revB. But then you want to return
> IBS_CAPS_DEFAULT there.

No, on a rebB get_cpuid_region_leaf() would be false, meaning the
cpuid leaf is missing, function returns with IBS_CAPS_DEFAULT then.

-Robert

