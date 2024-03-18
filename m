Return-Path: <linux-kernel+bounces-106721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E480187F28D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3451F22685
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312B59B64;
	Mon, 18 Mar 2024 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kGvI2cc+"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2128.outbound.protection.outlook.com [40.107.100.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6E5A4C2;
	Mon, 18 Mar 2024 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798617; cv=fail; b=NRkVYM7QwC0yxklKAtTKQLhlJYJ61xPhfvKoSMMrHFSoDTIr0M4o/sEU35C4dkYcjFgbndOkH4WgveQqSh4W+WE91xOcaIlSYkipBlFkrTqloGfl5b16bGffnlRb83jOEyB/6jy3Zo8ao3j0RbcDvGO+g2st+DyDWjQI2/rvYXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798617; c=relaxed/simple;
	bh=pSTbslrAO1DxMBbfrCQeaoy8peo3elWkuTwPeyDkdo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FFDbI+42zzTdztpeGdF1rktNNHzZu6n5d9A5KhObLC45LwK7AraNGERTO0z/oucIEXMLTI0z3UKKojF3DQfRmo/aN5osg95jVbFlcbX1XDRNLkiP9BABPsuYag1q9/5TxXOck1oy6XlbMsQdu0uz2c7mBvomxCzIoRIQ0AtmPiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kGvI2cc+; arc=fail smtp.client-ip=40.107.100.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmaYEDzrG++vrMJ8La+LHc5bEms5xHh1yZHxu0BNfXqBrqF+pcGpPIrFWVQ2yx4YpRcS9jtKCArhIVWv8dz2gUzfbdZfxexSH09Gg0IngCTg6kFG/q3LrlI1qUBpZ5/n6GqhUTTbEDrF0Z4H16qXQHGEs6cbf6mIbGpf99Q1qetlbYIdKaibyn7WcZWWod7KCdM65wAIckOM0guVIcTWse/S1WmQt/uncRZlHJlP+1x/KMAjwpJcNHc4i431b7ZQyOlA5vTKFuP1RIdb9Alze6u2qKsFOavu1d3mtOtOJRfkJvFq3aVn4+9TjQ/tMQVrDlCcAckyxtZ1HNJKZkdCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6l0g8ranMbMdycHSpj0S/JWy8qWbQg7D290t/ksXzs=;
 b=hWYpLUSDyP+83ts+g68unHcYFOhR3eksZ1zYnMks1EwaTaM8zOXx95ZcP6pKfl4uY2ao8kprrD6PMW/iVfX+VLQnvWBLz8aMhicUvuSDL4Eq3Qh8qmIQLsIegcaNbzDTpqqQg60N6D+VpaH7/9pMQr+GaZAm+n7qYv0AO7YOUgT57U6PJBXsS8CQeXe5Gm3anVTHPQXEsm1U277q+cZ1Va5v5SxlsbTcY1aoBOBMiGb//tkwjTf2fjBXaqmOH6lrRHcL1zv+mbG46nSXQHOMpq4SYm2KqwClBOAPjqqhK3DQDLmnYvwQ680vRhGnbhPV9YxcdFPdCnJco2/8momeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6l0g8ranMbMdycHSpj0S/JWy8qWbQg7D290t/ksXzs=;
 b=kGvI2cc+38SZRUtARLFPrg/LVcNGHHvvjk/RX/P6bm1/zE8fsSrY3jgcxFZBpb1cDJ/qubeoPX7isdZb4VRxMOB6pE++Sx6LAfD5QrkuhpD2Xo3oiQ6foRlFBCLi04gyZih/MQmomT/Z6AFUTTYhaGZXAcJXAkPFAwjN9JeCif0=
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 21:50:11 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 21:50:11 +0000
Date: Mon, 18 Mar 2024 22:50:05 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] x86/numa: Fix SRAT lookup for CFMWS ranges with
 numa_fill_memblks()
Message-ID: <Zfi3Da5SNR1NFAGZ@rric.localdomain>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-2-rrichter@amd.com>
 <65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB8769:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nHNzaYErq0pwgbJ2HHRmTxKCKadrM37+VC4z7oYyYcy2eLRGLyoxfoAa24FJE+vaGW/S3Uvaf5KuV10uvnD23fAQ+C0IkMz3hr9YGu+hg3ce/GUwANBlfDaEwSbMRK1gmT4ljFm6JR6Ay0zxGBCgFMXFLBAMJEvxvwc21FAwEmdn0MVabS07mn8Lwdkr/U+NhVFV+dK9spJePo3pwyjj/HMEq2EWeKHWZDCYQKRx19x3a7+ZS1a9nSL1fKRDm75KsqKKcdv/zNjvVoRD1kf5VYrLBMhcy2caqiJ+YbH9P65V2F5A1y21Op0HDqgp8mi1AIxGdkQmACALF2F3mvAoqBu9/5lLjpBAO56Gzi+BB8zCKtnxmayvGkd3wuvrrSaTqf+4+783fOwzQzlaWWlxzBIo7uFDURnjpuSlfevTvFca4Fd1V2f7wojFYYmagiFKi0J4mdGu1/0y9WHN4kXErj379/kGYpn2RrFoeM7BVhmfVM0Trdln9sE2qBVIhfF0M+hegO2TGlzllZnGrDjby364jIwFVt3n6lbk+RClQ/8ACE9LwgD3UvkSSI66XpMT+w2qYMYykxG7GLUryq/Z5uBodKnblThamVNNgSAvpYdUkN+MQcHrtjXkPVVdoCpeOuzgHb3FiKckos83DcRbklNXG4CycV61YWqibewSCBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YlwjK3Wabum2Slgn2f3AbbDE04dfnQNwub+mqvBIVmQmVCsAZEc5WUeK3kqD?=
 =?us-ascii?Q?YVaoRFM8OhEGW4oMfOTQwS9R/ZSueFO1FO4GscacHKzxTETEKTWRbVwlRXPj?=
 =?us-ascii?Q?dOcVj5wum87eApknfkUwckNL2DnBoh4G7JeHy6dhHMLwEJyVSgOS9V9Zy/4U?=
 =?us-ascii?Q?zo9A/Y/9qxys6egKV47rtEK2/teW5Y2aZtIiBevf9KmD+pUyMB+5TpejuMaF?=
 =?us-ascii?Q?v+926nsnJbNm7UORrY134xNj4mhWj94U0xhkty6DCjDsjrTn2x5K+Xu9Nwyi?=
 =?us-ascii?Q?2Cd6LniuLVs/1AaTvd+AJ3ayC4Q3Vm0nCOzCO9ChzcaYyodVt5JRyuqLoEkB?=
 =?us-ascii?Q?2YmpJHe4X0d3gjbKt5+FmHmpbO4V32L1zPKcJF46RmsNLAxetHRPziPosPLF?=
 =?us-ascii?Q?vva3FO1tfycRgVsf0TiMtN9g+zdL3IHCLPkO3I1k4524DZHMMQtQHJq4Xyjj?=
 =?us-ascii?Q?WM95IOhcmr1Tbtv5ktGZ0rQAvz2M5ggeaC6dDSzt9gJ5TFKFPAkZ+7Q229to?=
 =?us-ascii?Q?bvjcFAV0f6LP++jWUVOUHRYal+G3i1c0x2w/jBdJh1cAgcL7MS1Lpau+80Q0?=
 =?us-ascii?Q?F5RKDOPo5fKQiu52oDOLVZjZmtHDVYqXaZ0cS67w2n1NpDmy/I0m9goOxJPr?=
 =?us-ascii?Q?IPKwbIz7GORGuqDZPcfs4tA1zXdRFtCcg/9CHqZDQtEg7o4tA5Tl+p9oipYg?=
 =?us-ascii?Q?G7gh4Wm09tgl5vHwafzGANnJhaLv+J9woELsbHmsr4N/v5I6/pvn6KUiN9LB?=
 =?us-ascii?Q?y5vbw5pKNLFcRKNKkWv1b9syOfLnvDnI/VMEJMYWgm1YXwyIPEmyIHIs53dy?=
 =?us-ascii?Q?B5gtkKLmyNMsfUk/G5vv3v6JA+Yq8NT8qYLWB6qSBKKIjcLtqHi72o/kxlWR?=
 =?us-ascii?Q?pzXfw/pY/nbmft4IgqTokSUpZ0NBGKGZk4MbI96I6NbdUei10dxXH2m7ltkY?=
 =?us-ascii?Q?T5IiH+EEsqxOdt3JbRYZWgDQyu6EV8H9oZiqXpbC+7QVAhr1+jOOSjCvzW5E?=
 =?us-ascii?Q?ijmg+nxqobI5xUnk66iK/HxUTWUdr3hIcsokfMrB92guIeftmwIFh3pLcaS0?=
 =?us-ascii?Q?Ek8Icpes4z9+fhHt43vVyvDHFsFuswR0rkvGyYblTbDsOiojbY1AUiPtiJm7?=
 =?us-ascii?Q?9reTvjBz2vk0CklHSVdASdQdk+0l8wikbJPSj2/gLAVjjC78r1Biukg1tW5k?=
 =?us-ascii?Q?VrS3cCiqO4M5Hj3J6q90CS/CS0mlKgFvpv2gzpOER7LuXkDjncnzJmgGwAvv?=
 =?us-ascii?Q?lIBhoWLQKVriSAEJ/4wX+yeRN5MnPSXonXIJTstfLFKvSZzeOVND1V/f7VaQ?=
 =?us-ascii?Q?gMqZUZ+LcbuXOmRkkUVNgImpD1cMicXjC4McKuKblI0MNEljMcgltBAG1C/q?=
 =?us-ascii?Q?8QjRBwB/vUiBc/2wIQWqRp97QtdeUp8jttfEuWVx/cf6Q2jktqiH8APm0rbO?=
 =?us-ascii?Q?r6wJWg5vqxPE+8IYB2FAFNMFS9h0wQwK1kMlJZV6YVmBY0I5gjVBA/AEZb31?=
 =?us-ascii?Q?Phlyu/bB3WxngFQ3Qv/B0+q6rn8W+PRW6OEQNeiZWdCBJ42dwtZC5jwLnlOA?=
 =?us-ascii?Q?L+oDO46n3hzO10uqh8hshXvTnHaFNIeZ/5+a7oLy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f05a685-44d6-4a51-1bc5-08dc479562d0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:50:11.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwQnBLW4VPhVG5c0J7G2AXih/68J6ekBc8Q3qbJzOnOET3pBHATddvliPgY3acUhRklKz6u2vVedyLECs2XB2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769

Hi Dan,

thanks for the quick review.

Yes, this is the 'old' patch. But only the subject was corrected. I
will send a v2 anyway. See below.

On 18.03.24 14:26:41, Dan Williams wrote:
> Robert Richter wrote:
> > With kconfig option NUMA_KEEP_MEMINFO disabled the SRAT lookup done
> > with numa_fill_memblks() fails returning NUMA_NO_MEMBLK (-1). An
> > existing SRAT memory range cannot be found for a CFMWS address range.
> > This causes the addition of a duplicate numa_memblk with a different
> > node id and a subsequent page fault and kernel crash during boot.
> > 
> > Note that the issue was initially introduced with [1]. But since
> > phys_to_target_node() was originally used that returned the valid node
> > 0, an additional numa_memblk was not added. Though, the node id was
> > wrong too.
> > 
> > Fix this by enabling NUMA_KEEP_MEMINFO for x86 with ACPI and NUMA
> > enabled.
> > 
> > [1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> > 
> > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > Cc: Derick Marks <derick.w.marks@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/acpi/numa/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> > index 849c2bd820b9..2f4ac6ac6768 100644
> > --- a/drivers/acpi/numa/Kconfig
> > +++ b/drivers/acpi/numa/Kconfig
> > @@ -3,6 +3,7 @@ config ACPI_NUMA
> >  	bool "NUMA support"
> >  	depends on NUMA
> >  	depends on (X86 || ARM64 || LOONGARCH)
> > +	select NUMA_KEEP_MEMINFO if X86
> >  	default y if ARM64
> 
> A fix is needed, yes, but this is the wrong one. NUMA_KEEP_MEMINFO is
> only about marking numa_meminfo data as not "__init". Since
> numa_fill_memblks() *is* an __init function, it should have no
> dependency on NUMA_KEEP_MEMINFO.

Right, the option is about just keeping it in non-init mem, but the
parsing is durint __init. Will take a look.

> 
> The fix here involves moving the definition of numa_fill_memblks() out
> of the "#ifdef CONFIG_NUMA_KEEP_MEMINFO" in
> arch/x86/include/asm/sparsemem.h so that it does not fallback to the
> default definition in include/linux/numa.h.
> 
> It should also be the case that cxl_acpi needs this:
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67998dbd1d46..1bf25185c35b 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>         select FW_UPLOAD
>         select PCI_DOE
>         select FIRMWARE_TABLE
> +       select NUMA_KEEP_MEMINFO if NUMA

Ok, will take a look here too. 

Thanks,

-Robert

>         help
>           CXL is a bus that is electrically compatible with PCI Express, but
>           layers three protocols on that signalling (CXL.io, CXL.cache, and

