Return-Path: <linux-kernel+bounces-110747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ECF886328
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A101C2233C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB8F136982;
	Thu, 21 Mar 2024 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b4ZGyugU"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CCC132C37;
	Thu, 21 Mar 2024 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059457; cv=fail; b=L9CG4a9STtQOL4XPWQyXTy1Bu8Px/jYKQWKRg+Dibs1M4bSQ5Y64oH1ckXRRDjFgNmQ7Laiesm/w/OlILGeoFrWUnVPnjnDgtkoUG9gyXRYkyRTYUDhc0IktiOrkQ4pGGZULfmDbUWbX1FMSVGToOuXCZL7lbzqsKfkzIDulLXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059457; c=relaxed/simple;
	bh=FZ84ed+16fncB9RfOtucd/FeITqMvPbq0Em8Qa2RgEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CLSQi//SvsCrpWyYfPedHhyE1FQS4bk8iSH/FakqnRdKOekvzgOQI93COUpnFBJsRdjw1mrkQcFEqAFeJTplAZ8YIOZz2SPHhcBthqwXumpef7UaWWXweiiKj4FWdfbWN+7LJUnQE3TFJLxcTig6UrzhYl+1OlUVFKmk/yjGwj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b4ZGyugU; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/FwYXrcV8hvpH2WBv7INtJ5vlAyG1FAwXdtprPt+3Qt2VdQ6LMy4hsPFU9tXvjegbtNRV2ENYkgwhOEhsygdooRsONm+7wD8BMQOMOoPWLvfsIoanu3pVyBBgT7hGPDhyTYrAEyL9esr39NMtE4VedCQmXmQJ1Tg/G8JazouNpDpi0S9aO0/i+JCkY9uDj7CIfxf3kW/bLT0PORVhf0wFXvimx6vENt442+UGCKFUh6eATkLW0pi/CUDHZNGdrZb05wlMQ6uRy0tpCyxCvckxc7tg8R+SX7QAo5OcQ8xtQGQf1V+ApbFZ5Hjl4/sM33Pd4Q8XgdA5w/z2l7HCTyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em/njjXQIlqNvOkMdRG209i7ooojyJ6gLfXSefrEebE=;
 b=aD/A+lZYPgIPZOsratx7IyQmMx+JgRAXvThxuNrRff1z+RthW8cjHCLl85A74exzomqcbDrKaLGp/uKRGyMqcACQRWTCFy6mhS8/+191PFhRwe1XYbazTO5dLgw1fh8+oOkE86EYrKkCLRAAh26NPGpl2xy9IWV9WW0Adr4R8sjnFcbmkX2Ra7+2NYVz1IvKARF68ASFrs9Tvn7joFLPq7dA6Mn8wEkCuYaICnAGyKv26nwue405ZNlu4Qax8wyulD4aZgNrr/QfhGWX0cPH8KlJEukqc2vuPHJG93afv5eUQk2qH5tGS44jXs2JYATy0fiP3nwyDBPoJ3cklYXgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em/njjXQIlqNvOkMdRG209i7ooojyJ6gLfXSefrEebE=;
 b=b4ZGyugUaCCB6Rls4HrBx4WxvGTlHoxpdFzN8fmXj0ayI0eAA+o5W165CWJ+pStxRE+U4ytBLgd39PZ0geO04Q0WTSJVyM+RJHVxU+8j05+lgTHwAGd/icFhNgtZQ/XX13uXKNKUj5DRYX1ay1pCsSB8x1m8sTnUMnSm3UWg6QE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Thu, 21 Mar
 2024 22:17:30 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 22:17:30 +0000
Date: Thu, 21 Mar 2024 23:17:23 +0100
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
Message-ID: <Zfyx84KcvN90sQSw@rric.localdomain>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-2-rrichter@amd.com>
 <Zfsg3wZpSFVT+Zv2@aschofie-mobl2>
 <Zfxmnfj1K0OTk89U@rric.localdomain>
 <Zfx+1c6RVO6r176O@aschofie-mobl2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfx+1c6RVO6r176O@aschofie-mobl2>
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 73114ed5-7cd1-44f4-e0f2-08dc49f4b2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eJ5hqcIhDT2oJhMlG01xj/KuSpINmmMzBVCADbmCcAVyqo01+WtrZxsAUHccZMJZEFwxE0UWahD0qf3IEBFTjDNx/p8voqzZFGPQ8+UuAxNsnvAJJCYbqmbtQx2qtPNQ4EOcIMSfD7cKrxJpLTJCPka28BG3Mr6EROgrM3jy3yngwe3R5PqlVi3vV5pOdpETbYECft6BkN1BLuf099eoOSPjLevXU+WgVfSRFcXtVgRUHcAokOPEezefR4BrriQaR8Ww/ysz8jUqkDYRyUCBsEgFm50qr7Wd0HULEBfdRYLWXqo+gtOPU7d6UWbHEYG5oKGOeVF4nDNAuglz3du2jbmBrLvS91zmp7hfNAQYlgvjfVBxgSqeLPqAgreXlqfMlS4HBF5qIH7KeYBNC2bgSFBJomIZCOjFLVu2KQKo6sP7wcBPRa6BoXX/iuuP+S4ZD8x8PNLtC3+xBSAYWxuB5oW/Mun4GuOysrXq4LQLRYVsMk17PGTlzFNh5X+PLPAbjqlBCK8z6uBVVHO+bo6CVj2uT2MRMBfNttpMrkG2r62vsKKriVfci+RvrciKEW+n1P0fEOLGN2BrOvEbRoNYVxzdXiSW1JKT+9BNsxAXw2GX0o0fbeBw437S866Bsljam4nUUIupS+C4SB9toZ5bL1I8f+SqAW2FptkJeY+E8ZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ob8g0+phNWrJWchsCwjj2h/CetHPZzW7lyi2SCs9r6zHJYbm/7fl1GkhhQA4?=
 =?us-ascii?Q?EzpHhvkQmwskJh9T0iP2u+8kW2Ku+e9URHJK/Ki6X+hKAqW+QqfdC40pmKKd?=
 =?us-ascii?Q?+ONl9h8t64JwmtTAaQ+5VlmfnRIIDTD6iuiRLmj20AZ/0CBy43+m1EUAtPns?=
 =?us-ascii?Q?vSjezV5krkSeFRO6kTW/XFX/K3Ll5sW3qSouKXWdn1hu2BV+qAf3C/r48mhq?=
 =?us-ascii?Q?KM3bDlfI1brANvSK1BjMemg+akNLtSAdMExRz/hKkhZnDKn3heG8TZi2buLj?=
 =?us-ascii?Q?Ea8CRnitqGV13La2oBLJz0bprxba3Z/JiagMvaGb2mKaX+Z9s38KNjOguEyg?=
 =?us-ascii?Q?mpJJwBs/Noe/nCqdFhJNt7EER00bmUYRLb6l5vSyXS8mlYbzli2U+nuM0aRF?=
 =?us-ascii?Q?N9Cpc+R+nLfICwWH34IcA8q2qr5EEhxrrE2O7vApFVAHYQYsQOoEul7KlSQX?=
 =?us-ascii?Q?MZygm9ng7f6No6kMXExCrV99/lf3Z9vsnbmUHYT5+reoG+HucrTG5Zsl19FM?=
 =?us-ascii?Q?NXOw6qll85/M7XOhElYqAHdjqd1s7cfO7YZcnrf//IO6h0KmVwoJ89pLp+A6?=
 =?us-ascii?Q?GzvVPikVxVUSrRyeh7mjZYf951YmaeF1h5PkH5V8ngFhOQkYl3HVxlf7hG5H?=
 =?us-ascii?Q?ZrcK5b2qsxewLMMsuEElGEQYd5nQdcRllxN7Ivo4HUpUBrgF2Y3CE17pyQ/G?=
 =?us-ascii?Q?Be7WPvoN7quVjox+tt2X5wgNpWd6MhFcDqDvKTSgiPaynYxvpKUI+S0rXHEv?=
 =?us-ascii?Q?e/Q1HXSTvJU43z3ugA3htsKL3mirfqu0S0UtTSVrgoh5+C63+sQFPpwrX0Yr?=
 =?us-ascii?Q?MatoDswhxHLsYEAjAEDH/l9wQFm4iqRnzZuZYUNM4/ZR/qyTuRTFkWlIB8kw?=
 =?us-ascii?Q?a+p0XtwrbQMFQNRUIPfuwOPr0z6xY7N0joXAD3+gFKVPQMWdfp61nandWcyS?=
 =?us-ascii?Q?ejjLugIaeKZOL92ic9aBNufDZedUbc6I7GgLk+xnMwze0WVLJrMFim5FApkX?=
 =?us-ascii?Q?vmM16shuW/IYyDGdrtw1MM7FyEa8BhrNlsHsUxQyy0P7L2zXWg6SVlMB6vXc?=
 =?us-ascii?Q?hvMjlPY7KxVOJQuWmuScVbbfQmdetUc7Jer0WGdgQuQcjvXQHBWY4arpf+NA?=
 =?us-ascii?Q?lzbIfO5gDrxm5uydmA1iTCcVyDz4yzhuWt45bxM2byq7WIfsVMSlfU73/vOY?=
 =?us-ascii?Q?hEnrjuI1ULJSVPj5G+8XpRrKB1IURF4R9ig1qdZGuiWnbrEm0o7m/2xth8hk?=
 =?us-ascii?Q?v0Kl4nrKcyze3/6Udd6xgMaLYsu6ByymfrRKvZt3nS3dWk43FdKEfH6VcxZP?=
 =?us-ascii?Q?OfBBXNr0T1JxtAnOeO6syg1uwDCaDJSPpJb5DmerPFksaTlLW+cHfmtdWw3w?=
 =?us-ascii?Q?FZOcn1zwVYQHHbsz0VNORfloDNg7sgyzDGXgojg9RaDnlN0lKjPgr684zcJ7?=
 =?us-ascii?Q?jzVFWrbbW/JK+V0wxTzhUrG0feriAXGnWMZQMuIYTYS6DY/Zo1feY/XQTmxC?=
 =?us-ascii?Q?0zRTulUGLL3+0M0OkICFBxzPbk7AkME5fiIQmIHbbEaApEnhQj6yY470cSiZ?=
 =?us-ascii?Q?nPi6RSaO2ZvzlcjJhomY0B9iTf5UH9jlqsmqmBN9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73114ed5-7cd1-44f4-e0f2-08dc49f4b2da
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 22:17:30.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YO7KAVHzezwacO0LfRtJMMHXqEbzf6PSE5grVtgaA/trUiu6rERbp3PZ8zKWtYqTMFiO/t3QeWY8DhFq2pJqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

Hi Alison,

On 21.03.24 11:39:17, Alison Schofield wrote:
> On Thu, Mar 21, 2024 at 05:55:57PM +0100, Robert Richter wrote:
> > Alison,
> > 
> > On 20.03.24 10:46:07, Alison Schofield wrote:
> > > On Tue, Mar 19, 2024 at 01:00:23PM +0100, Robert Richter wrote:
> > > > For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> > > > disabled, the SRAT lookup done with numa_fill_memblks() fails
> > > > returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
> > > > found for a CFMWS address range. This causes the addition of a
> > > > duplicate numa_memblk with a different node id and a subsequent page
> > > > fault and kernel crash during boot.
> > > > 
> > > > numa_fill_memblks() is implemented and used in the init section only.
> > > > The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
> > > > be used outside of init. So fix the SRAT lookup by moving
> > > > numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
> > > > always available in the init section.
> > > > 
> > > > Note that the issue was initially introduced with [1]. But since
> > > > phys_to_target_node() was originally used that returned the valid node
> > > > 0, an additional numa_memblk was not added. Though, the node id was
> > > > wrong too.
> > > 
> > > Hi Richard,
> > > 
> > > I recall a bit of wrangling w #defines to make ARM64 and LOONGARCH build.
> > > I'm seeing an x86 build error today:
> > > 
> > > >> arch/x86/mm/numa.c:957:12: error: redefinition of 'numa_fill_memblks'
> > >      957 | int __init numa_fill_memblks(u64 start, u64 end)
> > > 
> > > include/linux/numa.h:40:26: note: previous definition of 'numa_fill_memblks' with type
> > > +'int(u64,  u64)' {aka 'int(long long unsigned int,  long long unsigned int)'}
> > >       40 | static inline int __init numa_fill_memblks(u64 start, u64 end)
> > >          |                          ^~~~~~~~~~~~~~~~~
> > > 
> > > In addition to what you suggest, would something like this diff below be
> > > a useful safety measure to distinguish num_fill_memblks() success (rc:0)
> > > and possible non-existence (rc:-1). I don't think it hurts to take a
> > > second look using phys_to_target_node() (totall untested)
> > > 
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index 070a52e4daa8..0c48fe32ced4 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -437,9 +437,16 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >          * found for any portion of the window to cover the entire
> > >          * window.
> > >          */
> > > -       if (!numa_fill_memblks(start, end))
> > > +       rc = numa_fill_memblks(start, end);
> > > +       if (!rc)
> > >                 return 0;
> > >  
> > > +       if (rc == NUMA_NO_MEMBLK) {
> > > +               node = phys_to_target_node(start);
> > > +               if (node != NUMA_NO_NODE)
> > > +                       return 0;
> > > +       }
> > > +
> > 
> > for non-x86 the numa_add_memblk() function looks good in a way that it
> > is able to handle presumable overlapping regions. numa_fill_memblks()
> > would just fail then and numa_add_memblk() being called. For x86 we
> > need numa_fill_memblks() since x86 specific numa_add_memblk() cannot
> > handle the overlapping case.
> > 
> > That said, we do not need the 2nd check. It looks to me that it
> > actually breaks non-x86 as the whole block may not be registered (if
> > it is larger than anything existing).
> > 
> > For x86 the 2nd check may never happen if numa_fill_memblks() is
> > always enabled (which is this patch for).
> 
> Hi Robert, (<-- got it right this time ;))

no worries. :-)

> 
> I wasn't thinking of x86, but rather archs that may not support
> numa_fill_memblks() and return NUMA_NO_MEMBLK (-1) per the 
> #ifndef numa_fill_memblks in include/linux/numa.h
> 
> In those cases, take a second look at phys_to_targe_node() before
> blindly adding another memblk. Is that the failure signature you
> reported here?

No, I am seeing this on x86 with NUMA_KEEP_MEMINFO disabled.
numa_fill_memblks() is not implemented then and returns
NUMA_NO_MEMBLK. numa_add_memblk() (the x86 variant) is called for an
existing range and it adds a duplicate memblock for the same range but
with a different nid, which causes a page fault.

For the non-x86 generic variant of numa_add_memblk() it looks like it
can handle already existing mem blocks within the range and thus does
not need numa_fill_memblks() or the phys_to_target_node() check. Using
phys_to_target_node() would be actually a bug since this always
returns node 0 no matter if there is already a memblock or not. A mem
block for a CFMWS range would never be initialized by calling
numa_add_memblk(), no matter if the range does not exist at all or if
it is partially (at the end) missing.

> I can wait and see your final patch and how the different archs
> will handle it. I'm worried that NUMA_NO_MEMBLK is overloaded and
> we need to diffentiate between archs that don't even look for a 
> node, versus archs that look but don't find a node.

This only happens to archs with ACPI_NUMA enabled which is arm64 and
loongarch. As said, numa_add_memblk() handles overlapping ranges so it
is ok to just call it multiple times for the whole or a partional
range.

See below for the full diff of this patch that I will send with a v3
(need to take care at the other review comments yet before sending
it). It just changes sparsemem.h too.

-Robert


diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..1aaa447ef24b 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,9 +37,9 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif
 extern int numa_fill_memblks(u64 start, u64 end);
 #define numa_fill_memblks numa_fill_memblks
-#endif
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_SPARSEMEM_H */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 65e9a6e391c0..ce84ba86e69e 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
+#endif
+
 static int __init cmp_memblk(const void *a, const void *b)
 {
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
@@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	}
 	return 0;
 }
-
-#endif

