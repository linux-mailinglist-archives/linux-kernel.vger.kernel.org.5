Return-Path: <linux-kernel+bounces-110453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E69885F21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5CD283353
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4AE131749;
	Thu, 21 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EblMwRsn"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3E79D8;
	Thu, 21 Mar 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040169; cv=fail; b=REx0mCHeMN3l2MejMCCNSPgojDcSK295u8U0DkL9SUZzSRJsj5g59Gd+/9s+9UvI2u87KneJriFzIiffyaP+YlBsn2AEDWXx7gL3R+l+lZoh6oyWhiRPjyeHWl7kVl6rJiTvPLYbetZZNQoXx/fOQqryYhs/T7df6cCjgwyZj7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040169; c=relaxed/simple;
	bh=6uJ0RxcSfs8z62b2Z3gtOlhxe0Gv7TqlDXP9g4oYjEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GvUk1XY0Aaz/5fKPf7YgAtFdSfcx0jS0fRghRdMpGfRHOmTDA+0oWGXyYc4jYUz1VgqYsn3GtrmOrzc2Lgp0CoSXHPN1QRNac2/1ERn2I3FfQa6Oe8bIFgn7N6RlrJDfDVgA68DyaQJHP+jd71L1G8rwfITbPtvu7q4w+dZvuig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EblMwRsn; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhWFOZ3iAFByjKuGKMTzR5MqNPJTk3Br4XJfqxXSRrJYUVcbb7G0h/AxSrllA/iCDEEVaqEKaTQS01JtQfEqEpn7+2byA9dri0n9SlTy4ihIJ9OKbjyH0L7AZXw4o14iGZ98a6kfYrSlzLd4TpygWKLI96MdNAFEgeswKPqa5rGzarDyWzLJsR5S6wOZDHS2yVzsBTpbFUCEkoJuJguD3puVgsHX72HD2yQ5J+R8gDuqT8oPsyfHL4Cb6fZ1cH2aBLPC0aX9ntCU2NfCmoCQubZ0ZdhPXEbd6K+TXFDNnyTV+4hL+BMXUD/o76l1BpqOfxQfgdk/nn2w0dMecHKF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/IMDZfnsrDzuS1RDGR50DJuUo9AyNzzIeFxAd1s2aU=;
 b=T5iZATEJbiRLgmxY7JMtX/M88uSMaJLZ2OZGsAtIr/yQEMy1yw3O2Q3jaLX8o7jKJ1HkyWLa5WIe/J8XQ7K3QFcTTZEGlMyLHJwCmRJholcLaoBeHPkhrZnvvhdBRvy268j68/FAdTeRHhFZoQbElz7cdsPy6u86seb2m0Fx1tLmVPo5P9QUYv39AIiSlkrp8v7nrw+0Tw4fVHDeQEvg7VeGM2nbWRFFuYCCFER3Ua0SO3mLjPwWTTgiXJdc17R44KqR7xfj4fXHMRdbZyy0y4H0HLVQeGnetAJH5ApmvL9kOrBxfAF1tEGDAmpPQU+gl4nmpL+MsjLg5TR/Y/wdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/IMDZfnsrDzuS1RDGR50DJuUo9AyNzzIeFxAd1s2aU=;
 b=EblMwRsnaHgtNPVLMRHGuLHDd395iTLbnU+U/ttMFcJQgUuOni3+111t5mWt9R96bk00FnKFlvp5IB1zIi+ovJRGjGUuO+zJepAy9Gr7FTgwZnNp/HicoikbXBBNcON8HHPfZMWToLID1y3yp7e8YaBCYXzyoAXleYDTCElzqTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Thu, 21 Mar
 2024 16:56:04 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 16:56:04 +0000
Date: Thu, 21 Mar 2024 17:55:57 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Dan Williams <dan.j.williams@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/3] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <Zfxmnfj1K0OTk89U@rric.localdomain>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-2-rrichter@amd.com>
 <Zfsg3wZpSFVT+Zv2@aschofie-mobl2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfsg3wZpSFVT+Zv2@aschofie-mobl2>
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 964fe297-a558-4596-da9d-08dc49c7cb66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dg5ihyKPGPe7TJPLVANMqTFY7Jc2a9IgUnVIe5hkjN9JhkWSi7rrD6glxlnxXRjYSNjtKsyx+ulsTW6gS/MuG5bJGM4scHtoiKa1EPJZTvXXVaGQoDeNOLA+gV3ktqbr0ArPHsJEmJ2wRU+PMjaGFLk3W4kxGOqhNdbYZHyETIddNl66Etjy6rW0L+7OOfsgvjQHflZYNp+QhS6HBqyrImNrx4IgQUO0VbnlVXX3Frcf+mjqwsXTjl3KK6xGkuQ+lclz8mFUuVg2ura+ZRyHDkIJYLCz+sUK9AAb5oljnaScfCwRmzjYO+NX4/TLM2FbXHlXDIE5joLKjZUwkhUwnWSWzO+k60ftkfVkl4VvzaeAWFEeGppSeii2mJP4sLCUaV+D1b5NiTQtfct3mgvSNg120QA7Uy3FXrUh3Red3dmvpA5+Wdqkne7GOSN05VwPwl8RNTnXZyIwDIF1i/VvN2zpPz2OBpSxSM3t1ToQhM143CWsCsRn/LLdUMsMcV+LDRjK06uT2ERh6n9yUGJK4RMapyOun5iHo4PAs9RTznOhxg1ZdyVO8zUPP0Pz2g65k3JaVpbC99AwN+5Hss+27w9KyAzvSYgwvTI3u/+rPKWXbCAd+TdLYdTUnZyoK5fiXDOcoWeMq7MumETDfDnCcneZE+VQTNZ4Z1d6oV5EIHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1W1gZ6nqFi+G7hRGmlpPZA4ot8aMnzSR86TVtGP4BFlhbShD4GyFU+BLsrhH?=
 =?us-ascii?Q?wU/zGF8VfObCRJfe9NFjYCNrajMb4j4i7XezfFHEsvxWwF2SbqEb1UNhGswd?=
 =?us-ascii?Q?1aT/vldGw9EXxkKaNdNkbRAkLHJ38L9uyWn8gZsAc6cNYIjalzK6ZBL6VmK3?=
 =?us-ascii?Q?OUETPBQ0rboSdJ0p85rA01ga9YvuiownrdslX8e4EcbI2Qa0PmMfL10zMOUD?=
 =?us-ascii?Q?lJR6WLAwBS9X6qVrYv2wPDtOaNw4CDzNCnGZJf0j2oZKZO3rUMXQxmTy3Btm?=
 =?us-ascii?Q?jA4LysTpodiN2WfTJaTm6B0AQTyeRr0HssYpAyTe/NAMj7cPjuzcosg1A2W8?=
 =?us-ascii?Q?ocyUlkP350O7kkgYAFGXooSsD2w7CRdGtqv4aMhNmd5V8DTV3sPdSXLbOGqg?=
 =?us-ascii?Q?1vBm/vo97W06OsWe0nGUl327A3xjX8yREptOdQKw1kx8s8GXEiXuOsE8c1gD?=
 =?us-ascii?Q?A4+Sl13QTOlygIKVV4NEOY5P9vZj+Gut/st/VPp4lg5FZBKi34fgTmLdA0ej?=
 =?us-ascii?Q?phCiAIw6MIELg62yRNqWitIbCGe9IrPCB/2CK/w2FVuV9s1c/Dp2Qtkb5tTv?=
 =?us-ascii?Q?iF5jVcFbazu/2JgQEmq+t64OGWwUk/tNonPBJelw3P7YcQSm/QZSHoKzzOLc?=
 =?us-ascii?Q?TVQtld62E/8Pc5XMYz1StSyIvBbycjN6xkSxopjccuN08XHu+l2rviG7QtV+?=
 =?us-ascii?Q?tvHvOR0Ug+yyT7ldP4i8DjNJE3//fjCgCklcMKt3Rw+Pw0WnS0KcvLNkKjpM?=
 =?us-ascii?Q?06rZQcLsSMgfMXs5KvMhkLzlOiYvVfhqubflG8jWXg8YsEhZgmjP2Ydy37pP?=
 =?us-ascii?Q?6SP8+tjfpDq/pIqhSv0EtytSFRNrwmE3JY4jpo+4SGXNmX3hPuFFLmN/Fpin?=
 =?us-ascii?Q?WCnDyIL6BHbR8o5M9fwVOTkpX+ntiEdIA5AmsNteZaniZ7xuh4wMmNaFH8E8?=
 =?us-ascii?Q?34u3hH+vSc8l1K2R/3hzjMaQ7GSZa7SETyd4tV61GwT9OIjBmZ7b4gMXiUb6?=
 =?us-ascii?Q?MHnRCpiqos3ONz+KmgRrAuJuD5oIpPLsHHcH7a7e72BOvDOEBZhX9phkZkRN?=
 =?us-ascii?Q?hP61rIVbSDBAFvJbYl66jcdl5DN3mE9ix8MLeAEKSG+uGlNxwEIDFaHoP74b?=
 =?us-ascii?Q?pQbQhzzvfZ/ksjDNNiZd0bqLiQzBjmTIvReOyr/UzacEpzCw9uKOkpGfTifQ?=
 =?us-ascii?Q?mzRwr0PPgvgkFM5wvodmPx04k2ND8O+m9lcfvNKBIvi7BHko2xOrAFFX+W24?=
 =?us-ascii?Q?iu4LWKZGiM4nVK7CwfVOy4RCfORuhlDKVGaiVlx/C+6w7NFv0pn/u/9qhgjv?=
 =?us-ascii?Q?K8VJd6AxwkOeXc1zEPQl/2m+GESOn8iVb4u33XrrJPSH155V5pKaGZZtZB1B?=
 =?us-ascii?Q?uez2sotlVNUHGAfb4BRQSNpEKpLzIi+mZkI0W8lhU+9rA6w9GevZ3yIhW88x?=
 =?us-ascii?Q?R8rxjHmOBvEAZxAB+epHXAwpJTH8ovxN7kaW9Ewt2tADxptTqFPMUEUbMuef?=
 =?us-ascii?Q?IojMUpD+/kpuX+9iqv6vsSPntQfZ9AH53ZD6x8pYzolLo1DFJH2p5qEm68ja?=
 =?us-ascii?Q?g3s8+gE5l2HbzDNZlGGEpJFNtGlx402U9OB1M7ry?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964fe297-a558-4596-da9d-08dc49c7cb66
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 16:56:04.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svC0xFrqzsBXuRDPbp4lLalJOzbzTK0ygt42vmGlUq40e7XwCEJLX+vCIEdoUtGf/4EdKTnTAKrYbOno/0bkyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133

Alison,

On 20.03.24 10:46:07, Alison Schofield wrote:
> On Tue, Mar 19, 2024 at 01:00:23PM +0100, Robert Richter wrote:
> > For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> > disabled, the SRAT lookup done with numa_fill_memblks() fails
> > returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
> > found for a CFMWS address range. This causes the addition of a
> > duplicate numa_memblk with a different node id and a subsequent page
> > fault and kernel crash during boot.
> > 
> > numa_fill_memblks() is implemented and used in the init section only.
> > The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
> > be used outside of init. So fix the SRAT lookup by moving
> > numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
> > always available in the init section.
> > 
> > Note that the issue was initially introduced with [1]. But since
> > phys_to_target_node() was originally used that returned the valid node
> > 0, an additional numa_memblk was not added. Though, the node id was
> > wrong too.
> 
> Hi Richard,
> 
> I recall a bit of wrangling w #defines to make ARM64 and LOONGARCH build.
> I'm seeing an x86 build error today:
> 
> >> arch/x86/mm/numa.c:957:12: error: redefinition of 'numa_fill_memblks'
>      957 | int __init numa_fill_memblks(u64 start, u64 end)
> 
> include/linux/numa.h:40:26: note: previous definition of 'numa_fill_memblks' with type
> +'int(u64,  u64)' {aka 'int(long long unsigned int,  long long unsigned int)'}
>       40 | static inline int __init numa_fill_memblks(u64 start, u64 end)
>          |                          ^~~~~~~~~~~~~~~~~
> 
> In addition to what you suggest, would something like this diff below be
> a useful safety measure to distinguish num_fill_memblks() success (rc:0)
> and possible non-existence (rc:-1). I don't think it hurts to take a
> second look using phys_to_target_node() (totall untested)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 070a52e4daa8..0c48fe32ced4 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -437,9 +437,16 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>          * found for any portion of the window to cover the entire
>          * window.
>          */
> -       if (!numa_fill_memblks(start, end))
> +       rc = numa_fill_memblks(start, end);
> +       if (!rc)
>                 return 0;
>  
> +       if (rc == NUMA_NO_MEMBLK) {
> +               node = phys_to_target_node(start);
> +               if (node != NUMA_NO_NODE)
> +                       return 0;
> +       }
> +

for non-x86 the numa_add_memblk() function looks good in a way that it
is able to handle presumable overlapping regions. numa_fill_memblks()
would just fail then and numa_add_memblk() being called. For x86 we
need numa_fill_memblks() since x86 specific numa_add_memblk() cannot
handle the overlapping case.

That said, we do not need the 2nd check. It looks to me that it
actually breaks non-x86 as the whole block may not be registered (if
it is larger than anything existing).

For x86 the 2nd check may never happen if numa_fill_memblks() is
always enabled (which is this patch for).

So we should be good without your change.

Thanks,

-Robert

>         /* No SRAT description. Create a new node. */
> 
> --Alison
> 
> > 
> > [1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> > 
> > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > Cc: Derick Marks <derick.w.marks@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  arch/x86/mm/numa.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 65e9a6e391c0..ce84ba86e69e 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
> >  }
> >  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >  
> > +#endif
> > +
> >  static int __init cmp_memblk(const void *a, const void *b)
> >  {
> >  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> > @@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
> >  	}
> >  	return 0;
> >  }
> > -
> > -#endif
> > -- 
> > 2.39.2
> > 

