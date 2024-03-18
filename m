Return-Path: <linux-kernel+bounces-106706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBA287F234
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358E21F21C56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79435916A;
	Mon, 18 Mar 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k22yWgQp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1E58ADF;
	Mon, 18 Mar 2024 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797538; cv=fail; b=XgY/C59i3BdM8mfRWMI8Dso7N4hYIbwtAGQFRe6zeCA5JNYv0iCtR05dlquNwr7qrcUvp1bfDh9mKxFD9BdiTLA2JZjL4lRpRvr7JuO23qpV5Ue/lJCeHJpoRP2GbLUSVESY0uPEOzEFHnMQZE4m7wBUYcPWRWQV+s9vLpb0vC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797538; c=relaxed/simple;
	bh=gxEfvMqKE5/0AGJ1BfqKymWLqXEEggyc9HYFSSpg19A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZhU2/0wDwUTwy+zvmuAljGwU1akV09NZOdmbqR1cg/6k8IBxdBaxDyRUTJc7H0lZZmB1qJxiSMP4pwJebeWXwcLjfCxaA5sWchX84dD4GZRhEOZOJOo3GqHePHduvfMlwREuTPPabBTXzufL8Q43rCqRqEDpHq5wUi9g0ECk2Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k22yWgQp; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710797535; x=1742333535;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gxEfvMqKE5/0AGJ1BfqKymWLqXEEggyc9HYFSSpg19A=;
  b=k22yWgQpMug37heOKuwycwtFOjtqB8goccnu+rVPb3NqLNBNKO+6+E9e
   +IxkMleWnacIdRVsMSCXfmmy1war8eMHjchv6+pnuxqxL3fafL5L6MUoD
   7RFaDX5eHPgPxlCsakOIOMHuIzMHk+gAZqH3YwaWJCN2ExQr19t9u00qB
   /eBii1CAICghITNJHDR6GTD7NvZU4voFQwoYvkidoN+JEaqHO9nKDOrRj
   SIa9JAfRmWXv43l7Fsc6wxNWkU6XcqzllwmJ6dTLU0KepROjbsZTHiICu
   tWL613FKLbUtsVTK9WCwuTFADlIpbZMhognkQI30TxgQ0+1wuxfxfOqX7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16181589"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="16181589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="18169364"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 14:32:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 14:32:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 14:32:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 14:32:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 14:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCria/Spo4V+g4pdfM9f39WRYqaR3mEFfzyGPD+gPi/yFVtUz06dSZCb7UZHAIN/k2iFl/RqJmJqVPujOsXtJMlf3ZRdnHnPuu1e1tp6vS0Zx8JWUsYArmjnyge1LqylnZb7+1oVzxRiisHyiAWgCeaKXNtZLTuEunArD8WbGVr5ro19EExRXLSfkMO1LP+Ifw777eso0lgpgwmOtJAg2AAWGT2Z1EpFGKyI4lHJOVaKctSIm3pIngxqBnC3yaDENC3qydVBr7GYcjd+Xot7zEbneEep03Imnr2Zjx7+9sWl+vFCt2+EDiVNVPPgbbHMztsMkxBt01p0f0jZWDZQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkykG7UxxYvAvDxq5bmeck7bX8LFoV213Zg0ZvIHJNU=;
 b=W7ZxGcmIC9NzrgFlMntvtoBKPmhYeEWroh5wh3BKIXeoY2L/5H6oyyMP+ZV6xsug5w25V2VqOh04mtUatgP3hjL3q5UNLc2SuaMoXG4L8BXAVY9WCsb4L+WOPJPGQNel30Bv5xOtbFEZ1a3w5Aevf65oPgI4XFAr7VI5cHQ1Hwf6SKyKdHnEMyTBjny28VSoaaimUGzKy/VXUayIP7FWOXYgrGRuG1YBu66707oAZ/8Nqovq2R+K2KwSY+GWSXfU3l+IDIRzPKAWJZ4Wg13sAjExEUMLppkcwtdNQ8o57wx91iiD9LAj0GXQh/T4T147mqdTU0fyuO2PEvA5o7Gxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Mon, 18 Mar
 2024 21:31:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 21:31:30 +0000
Date: Mon, 18 Mar 2024 14:31:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Alison Schofield <alison.schofield@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Derick Marks <derick.w.marks@intel.com>, "Len
 Brown" <lenb@kernel.org>
Subject: Re: [PATCH 1/3] x86/numa: Fix SRAT lookup for CFMWS ranges with
 numa_fill_memblks()
Message-ID: <65f8b2afdfc38_aa22294ef@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-2-rrichter@amd.com>
 <Zfiuow9LiOIl3C7X@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zfiuow9LiOIl3C7X@rric.localdomain>
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5816:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTlsizwA9zHhHNi2xoXqjKuCqjbjDCXMdO3hlpNbUDBSgar4GHcaiOAXoyqrWOXB9SyYG60VM6sYtURkCJkCxgFdEYC21ZftXXgl2O/51fRQ+YZvfoNaqKNCOiZ7cDtsryC/qtxt/ADgT7XmqBxeEqIRDX3qh/a5JBKkCltqYciRca5FuVapJky0fH4M7F5z1yMiauoRRBCE/Nub4D9Z9bZtyfXobm2eobnLpCzNIQSX6EoZD0cqlsRv0Vggk1C6DDpCt0qA2Jg0tuASNvax/PUiEXjbg/l51cv1XmED1iZSJLyVh4TcI/0gg3f0kd5fohYnn8n9IRjXpjzh9gntkSjT+97YhHpLGGYRpM6VDFsiy8GBzcAYygmDxHDfzgEVbS9KBZZiUWyj4/3KcugnQ6AWnvMjITf6+ls8iCHCzCA0XL2bny5THVFILfM+K3XuD3c78dQBgmzzO2knYz8TMholKdyK6dkE6YNxj2rQ53flAfQdrvAOsco0wBLfk8jKmnFr7c6Pt6Y1W5dudGgpJVJ91Ave1aL3dh7lsr+DxqfCCqiq+ORnRY5LR+nvY3/e5n99FQY9mLN/ahhK5uSIWHTf4TW3LDz1yWkvZF1ypDD+05zjqQw/iY2BahJvIYGuHNfRGOQpQquM4qsZFFfxEu3pRWPFHD8ce8476HulIHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xE3o83aCZ8mkNtBEkHnyI2pUQmBfUHTWGFya6aqJiO1xmyjjCuXxD2HmHZoZ?=
 =?us-ascii?Q?z9peizTQCXxd6444HR4Nek5ZSD2alumDAyPeXY1ODIjo1QU+SUxMyGO4fHHv?=
 =?us-ascii?Q?XvmDhm9s3admF+Dgpgws7Np6bfzzCk6Bd93sYeK3wmjv/J5HD6OY3vb469Se?=
 =?us-ascii?Q?ncJcMiml3xSPa0zac6rcNBinIGJ+lXr6ut5C2dAFiAI83hwTtGmcRTKMbWH0?=
 =?us-ascii?Q?oXFmq3RKO/Eam6ARtg+h29N7hKveVsjGrLgBoZvSIbMo9kkIAV8IOQShzntn?=
 =?us-ascii?Q?V6b2b/bn0xcSTuk2FjU2HYoymlvhzEe75WQ/+Vih9Fs7wwLaqOSpJJ2PCaV7?=
 =?us-ascii?Q?XZAzn3wPldk5L8SypD4Dr0DsAaLCW4LUyWAepbQ0gcSk6RQP5JQ6N1prLHEX?=
 =?us-ascii?Q?Js/5g/2jWmqrRUaHD/UygBL8cv+iYlk63Pgg58xtVUEMMN26uOOo13g3xJm6?=
 =?us-ascii?Q?XCRyFAl+WICJwcIUUbvUsuQaFPOpUMlchMceGtckS2822gHdqAczAyxCLlLi?=
 =?us-ascii?Q?zrlI0ApshUsH9wpHISqjiIVXOgBevnEOF/ONRxfQc1an9Jpb533P6mPrPIBE?=
 =?us-ascii?Q?QR2o3IlbFHSaCnVkyx80lEMV6PWe0B+AjEHJagw001vn2N1UjyoZVyElrA0u?=
 =?us-ascii?Q?WFd1iB3dcaQIAJGuR8Eo9YLRcRqWgWqa0NX0fQFVPv8fDdphDhD5Z8k4PLd4?=
 =?us-ascii?Q?gOW4ZWl135P+oPbIVY01vIaikstSJMfWL1JOM3ozvh69a5ViVbzP0xyGfzMD?=
 =?us-ascii?Q?FNXUGXh8UbGG1JdrzSwJCApQkf9gU4dvH7YTwiqtlIJQL3xCA7D0//9xVsUd?=
 =?us-ascii?Q?yuWiy0WcbJ0Q5NjNbWcXmhmsArccNkfotjVjHWbJStFJ5pdcRKA7r7JZ0bNi?=
 =?us-ascii?Q?6DGPHcyafQTYStkuS3spaVc7y6CERFa6R+RIgG0mp5Wr+FOf9U6aHVouEez8?=
 =?us-ascii?Q?W5+Quqr8+C1tVuDnR3W2Os0VE9r8fMv5pVMCP2xPaojpnW5sIhQT50Toa0Pb?=
 =?us-ascii?Q?TufegBX1kl8Iwsyr9b5cimpxmSEICh0PM/0R/iIIquZGb8SkB7fB8f0VA1mA?=
 =?us-ascii?Q?ccFArOAs57ddzopBvkWHDMyTPIQ33u8/DRZ2bcwCjLkga45dxXqxJ2oNtN8Z?=
 =?us-ascii?Q?H0zgWZHJpN2d9loGHKGF7EPIhRl3VRCWgjZ7p4PsxKXo9nUUo25DloY9ScW/?=
 =?us-ascii?Q?B6GuW5FMTBpH8tfTvxLvXkxPalseCYSdNRFLOkcv6sk0WnOhQI1ZfbycGrPv?=
 =?us-ascii?Q?5c+Fh8nFjGzmsErXensgA+vs2oeAzP8on3bb0Cj3RD0o1KdscpMn0fn88dZ5?=
 =?us-ascii?Q?81k+v+4ReLxw8n1bOHFAztrak+0SjvDzhtX0M5kYpOAzaPXpe9/zT8p+/BXl?=
 =?us-ascii?Q?q0Q944384da8UKrsRKfa4lh+k0US+BVIvlFquMn+Cz+SUSblsnhdopKjoWL/?=
 =?us-ascii?Q?gZWXvH1nHqg2Csfarifc+LsO/WAcdOiwHqSrTnEFEaQprfmlJzRnDYt6RfUu?=
 =?us-ascii?Q?4S5aknKfM+GyjvCktApucR9KW59CIpIIlXN1IfEtWl0gmW4ZE+fdJr6l6lYZ?=
 =?us-ascii?Q?CLRxWgE5YpqbbWg0+mdMCQ1wG7rjgbiV9GLwgCWNVa7u8kWcsAbbK3TpEec9?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1d67cb-0fb2-4159-7947-08dc4792c692
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:31:30.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoZSerQMuWe75/orpsLMb3JfhzC93y9z2uYXrQXkysYvmdgbIyXL+pfeSz21Mnv6J8Vb2yNry6HykMEIRi5nXEt86YNlRe7r6hctwPg/SEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com

Robert Richter wrote:
> On 18.03.24 22:09:00, Robert Richter wrote:
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
> 
> This patch should be dropped in favor of the other 1/3 patch, it is a
> leftover.

What "other" patch? Did I respond to the wrong one?

