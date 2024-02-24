Return-Path: <linux-kernel+bounces-79333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1FE8620EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6439B23AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0217C9;
	Sat, 24 Feb 2024 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C18z0ydI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAA623
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732982; cv=fail; b=PH6Xq043IvKHGMvIHjO3/6J9PCjtPE7nsLNKFBPRSPy+rJTGbD83oZEurzlXo61M2fQih0Tr4ORpCEniT2baVaK5amd7kNyafXLYOHDrlVW4XmbqV+2u0RRpxoNtSMtkQbLCZZjHc2EEYMt05Nii4Z3NvyvF8oNuD/GhqO4wmMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732982; c=relaxed/simple;
	bh=Ng6vUp59oWSpB+5gZuuw7/sa15D6q9xlyeTT17pd9+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lUVwG6qBucJDv3Vba3+8TvXT1lwRCA8IkxoMScruDiONam7b/DxbDjJesJS4Av2iQwOMo8TvQHr84Cb6mnJmrNFlFysWEZQQEgmAKRlMs6vt+oQLeWhiPA7nr8igtjT7jHEF4uyvDmDbML+whDcnV+6hiiQOaGCRTrkvXCRBg7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C18z0ydI; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708732980; x=1740268980;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ng6vUp59oWSpB+5gZuuw7/sa15D6q9xlyeTT17pd9+4=;
  b=C18z0ydIOBOPMqWKrhlmrRWrNVeli/xQhDgIrSvNij2JyxiOG00qQWB0
   ACxxEZ9rmk9uO69rkPgrqSJC43EI9HtjQwGMhLzW1UuuezbRztaZHMXMi
   FRgPuz2ltDURsPiwVcPrcsXz4tt7hoy+wKago8BjwHnODjknO9F47mcJJ
   7WZfYBvnLbI7Y/RjhkMYUWS7HnWAS2EPQ43pc/VhkSzosRZhFexV+tx5P
   rFKgGpCAu5PI2o+7xUG/UNxKyt+OwPJwKW57PneqyHtp/fwIljK31WcIo
   t6kSJr9WWQXHR4Y/yRXxpAqvdWslrqvFidnjJC+XU04BA4D9w9rGFQ1Tc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20520833"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20520833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 16:02:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10623304"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 16:02:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 16:02:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 16:02:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 16:02:58 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 16:02:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8WQMuBbh1eoLRQlwmLjyU8bQuLOLHJ+Xv/yZxGUAMZNVsTUalLoL7dUsg45tIcIr0YDTbM5fV4moKmw9612NTlKWWhxgpkGBo6tN3CnAyOMinydXO61N12tOuOvSokFXafkH17oPTum0L0ZDS2eC8EK2mbm0yJ8WIHlXa9RTHVQH1IiMLrVrOT/puNFPQ9yYTTklivY/eZaCRu4e1I71JcMXzliov5Y4gOIo71IN29hhWfJnJwWWoreU5r1wf3+c6u1xqpbDdU7UQuxVBJxWgnqyd9clzaIxQXPfhAL4pxA67L1uarkq8V1K5jBt7OjQ5WLxbbQP6fSlvgA24KFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E136PpfnC8r+QlbEPxGT/bkpuwPRME3xFnBuCJxeTGU=;
 b=HZMNuGdYJSrQUQjqM9YI9mv+mH/r/4CLg6H57F43ah4E4Z1V/poAnOgULpeD8ON22pS+LnlxsLZ/0ZKz8zG04OHng07VIo24Th/P6NqKpGOotfRYlsFXgZUFNk7CH5B97n1V7UKLcSXtoSh0zRBDVX1jxXrnxDSuKPVxxoIm2pUhMfvCvv67burVRwzH7yTOz//YpBybaQFZBtb7CCDN7+4k7WbRBBuSbuT/NBCGcxEpxrTCgOG8MG8F5nXfFyEQZDYqVpOHQH0AA1+dkHgyJYpWWOL3Bl10NclTK+KrS8aXhw9q698yZs+gvdLo5/SFR33p6rds0mXXmNiU7NV/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Sat, 24 Feb
 2024 00:02:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Sat, 24 Feb 2024
 00:02:53 +0000
Date: Fri, 23 Feb 2024 16:02:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
Message-ID: <65d9322a53e90_2509b29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <afabdd17-7f1e-4d8c-a7c2-dbbbb230fccf@amd.com>
 <65cad52616ffa_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <1adda7f0-0061-4296-ae6f-dd767676c23b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1adda7f0-0061-4296-ae6f-dd767676c23b@amd.com>
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3793f4-bf91-4ce9-bea9-08dc34cbf276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TnMXt5Ckd9pDMrVHYFIuf0rdv5XKKr3m1yRWFtRMObRT9EYYAnq2mEZqbrfw8LtpIZ8aVtW30A0+mFiQdyRj3z0I3ET5fSmxA/kccvSJ9Hvhy/idXOMdEOJDYR75VLDtz7/WG2LY5UEjdKS/nuip52XdEflC2gmtatH2j+eZSJ/7cvv8vV3R0Z7/hZxwreMdliGKgXZQZDRvLoXFJaAe7frbVqGBYEPbmFoKD36SCp340kI71anZwhinjww12svLhmor+9M+Al+7Ui951pdRitFwuNR2ZpR3oTht+nDZ5MwMwFbXhv4OlxMWWCNDnKt3vsc4PwmqDai6jZgX2cmoauBsM3hPrMbo7UOAUCiNtSBQcHqLO88zQqZ4ScsOvyR2tmmfJZ4wF5JBUTkzoU63cBXOUYADR03DiaIiaZ3B6p7cuoTPxWiI44N0QyoFE0PvMAMoKZAggvXQMlkS05JTPkRIqipbEK1OsU/8i5qSJdJnW4bZYZ1phItky+VVzsHpCRpWcUrDcN78sRRNn1AgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0drL/n53+shhMa7cPpgaNNKD45yZkEWae7KYODnqzBISM91ex7oT+OqPMPCu?=
 =?us-ascii?Q?Km8uDqpcku6aCger+tJAVWuJJUZefNtgsxFcWIX7FJNKJVGOVJ1IopSRNwOK?=
 =?us-ascii?Q?cHOv5blbgsUzXVmGqPlnZB76Ifo7fuqFkIBoCHOX9VFInpZyRycf2dfUaka5?=
 =?us-ascii?Q?IAhnCJTg6De0vkY8hbesYvbcCfdSuGO8xNG7clH+h3Jy6HbeSNEikP7+8rnV?=
 =?us-ascii?Q?ln3Ql9Y69eL2+VR5yo4xHwODp4CUvClhYZ7zgTb05Li8WeUYZYsCze3U55a1?=
 =?us-ascii?Q?eHUzJdDeKmIUGYw5loAA4xwZTSMS2M6mfCqF39OHBz3iX7BTDguzY1wfF9dS?=
 =?us-ascii?Q?kORvWoImqSyOjZtwOwrDCcaCWhCDpVALEMcljyoOemSVt+ivt2eF8bG9+bdF?=
 =?us-ascii?Q?VpmXGddfi02zDjTLWv/8sD8lRlk9OLIKNYZuTABC8papK1ZvSzqYd+2asHtx?=
 =?us-ascii?Q?dkw7aHnYJ5AEtpGj49hjGlkU8mocYIdWNZr+yq2v5Z33gIOxkUBt/HqiES0N?=
 =?us-ascii?Q?Gtp90di7bpEBkzLMaKMW1zghOyqiGKPskqb4MbiOKs6C0LZ1lB2bjVYlFjF5?=
 =?us-ascii?Q?PXNrDlqM80MrPeI7NN0IDR8g2q9J/ManfgyY6j2ecsm5ZyCE3enTITWGrpql?=
 =?us-ascii?Q?ZxVpUxyj6MQZL54lJDbiAdppNHuJdKHAjkGa6RHE1aXtuslM2jx9iHSo7cET?=
 =?us-ascii?Q?H+Fe1xYkUYsFkc7qwZE7/QI0GPbEI9i+TZYng8ye1MKmjLCssMbirLOFKoCX?=
 =?us-ascii?Q?Huayf6l8zLxop4oWZHQ+UKrHKY+qjrep/OW6R/X3U9cz8YKtHgLTm1gAJvfB?=
 =?us-ascii?Q?HtT0002FrTOo5CBlPGsm2BmzJ0Pqdpj/g62rejFZkW72XA8gEdUuhl6IyWo1?=
 =?us-ascii?Q?8NLczk8CXuDvW1oAtQlL/PoxmPLBillmIZUul2yo+gh6sInOPZGSjZBwUYkr?=
 =?us-ascii?Q?wUXwjT5BKMrtLwRoBVXK5lYD0k9byV7jsyh7jeeQhhF8Azjfv7pxvXFvTNWP?=
 =?us-ascii?Q?ShaH86iCVifMDGPIN0e91vZ87qZsKw7l8k9ksAmQZm+7cwbxH5aD12xhoG2b?=
 =?us-ascii?Q?WqAkZHIF+n/ybpAEC3RNwVVUWW925ahb2refy/DRUVDHLYar0QWbINE9QUHD?=
 =?us-ascii?Q?+CHtOMKd44Xd7w5TguSiCdAFT4Nj8Cfs/h1UQM8ED8P9zSoI0kXa5aJz1eSx?=
 =?us-ascii?Q?szyBT4XqcncOPEnkg3/lE27gY2BnHqWXk6s5IvyhuvG1J8f5k72YfbXvROP5?=
 =?us-ascii?Q?ilnY/VROY7bhHVM6zBkizVfHKOEKVndcmDr6F+N1viSH+dEMPr/W6zktQbe6?=
 =?us-ascii?Q?7XeyS6lufPOZZsCBZP0HlGkYLdJ67Njh0q4215uYS/JxwGvyPTfshOGvzXad?=
 =?us-ascii?Q?ayM7pjDOBxxsR5Du2twMlUDM2yPGyA+CZlptXRbUhljYTd3dXwwikq87I9jL?=
 =?us-ascii?Q?c2SV58OZXOYmpGps3G2gWNDN9Wpnwr5/zZUwdY4sur6qKxm7KlD0+c59+DpM?=
 =?us-ascii?Q?jQ7ehnXrVvDV/+3M2Op2BL+rzbsBA7x/uwS/ZJgVHJfvn3lpRsyKTQvsWctg?=
 =?us-ascii?Q?imrJIczohhg/lZyOvLw8xsiCVEX3ttvJImr8L2nE4nsp6EtOappefJTZ3zwn?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3793f4-bf91-4ce9-bea9-08dc34cbf276
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 00:02:53.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZLhsCy6z9pEv8EzcjlOhDycDtaQYEtBSMNlHW5isorNdFGVb29ui5BRLwp588XJKbllGcC3S8LDNFGtFL4v8l2xS9lcRQMCHNVhA8Tnhsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 2/12/24 20:34, Dan Williams wrote:
> > Tom Lendacky wrote:
> >> On 2/2/24 01:10, Dan Williams wrote:
> >>> Tom Lendacky wrote:
> >>>> When an SVSM is present, the guest can also request attestation reports
> >>>> from the SVSM. These SVSM attestation reports can be used to attest the
> >>>> SVSM and any services running within the SVSM.
> >>>>
> >>>> Extend the config-fs attestation support to allow for an SVSM attestation
> >>>> report. This involves creating four (4) new config-fs attributes:
> >>>>
> >>>>     - 'svsm' (input)
> >>>>       This attribute is used to determine whether the attestation request
> >>>>       should be sent to the SVSM or to the SEV firmware.
> >>>>
> >>>>     - 'service_guid' (input)
> >>>>       Used for requesting the attestation of a single service within the
> >>>>       SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
> >>>>       be used to request the attestation report. A non-null GUID implies
> >>>>       that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
> >>>>
> >>>>     - 'service_version' (input)
> >>>>       Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
> >>>>       represents a specific service manifest version be used for the
> >>>>       attestation report.
> >>>>
> >>>>     - 'manifestblob' (output)
> >>>>       Used to return the service manifest associated with the attestation
> >>>>       report.
> >>>>
> >>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>>> ---
> >>>>    Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
> >>>>    arch/x86/include/asm/sev.h              |  31 +++++-
> >>>>    arch/x86/kernel/sev.c                   |  50 +++++++++
> >>>>    drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
> >>>>    drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
> >>>>    include/linux/tsm.h                     |  11 ++
> >>>>    6 files changed, 376 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
> >>>> index dd24202b5ba5..c5423987d323 100644
> >>>> --- a/Documentation/ABI/testing/configfs-tsm
> >>>> +++ b/Documentation/ABI/testing/configfs-tsm
> >>>> @@ -31,6 +31,21 @@ Description:
> >>>>    		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
> >>>>    		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
> >>>>    
> >>>> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
> >>>> +Date:		January, 2024
> >>>> +KernelVersion:	v6.9
> >>>> +Contact:	linux-coco@lists.linux.dev
> >>>> +Description:
> >>>> +		(RO) Optional supplemental data that a TSM may emit, visibility
> >>>> +		of this attribute depends on TSM, and may be empty if no
> >>>> +		manifest data is available.
> >>>> +
> >>>> +		When @provider is "sev_guest" and the "svsm" attribute is set
> >>>> +		this file contains the service manifest used for the SVSM
> >>>> +		attestation report from Secure VM Service Module for SEV-SNP
> >>>> +		Guests v1.00 Section 7.
> >>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> >>>
> >>> I wish configfs had better dynamic visibility so that this could be
> >>> hidden when not active... oh well.
> >>
> >> So do I. I played with the idea of having two different structs and
> >> registering one or the other based on whether an SVSM was present. Thoughts?
> > 
> > That's the status quo for the differences between TDX vs SEV
> > (tsm_report_default_type vs tsm_report_extra_type). I think a
> > "tsm_report_service_type " can be a new superset of
> > tsm_report_extra_type. That that just starts to get messy if
> > implementations start to pick and choose on a finer granularity what
> > they support. For example, what if TDX supports these new service
> > attributes, but not privlevel.
> > 
> > It seems straightforward to add an is_visible() callback to
> > 'struct configfs_item_operations'. Then a common superset of all the
> > attributes could be specified, but with an is_visible() implementation
> > that consults with data registered with tsm_register() rather than the
> > @type argument directly.
> 
> I've been playing with this a bit.
> 
> For the configfs support I was thinking of doing a per attribute 
> is_visible() callback field since the TSM support is currently all in one 
> group. The callback field would be checked in fs/configfs/dir.c 
> populate_attrs(). A simple bool return value should suffice, I'm not sure 
> we need to get into umode changes. If the field is NULL, then the 
> attribute is displayed. If non-NULL, it depends on the callback return value.
> 
> In order to keep tsm.c as vendor neutral as possible, a way to 
> provide/override a default callback would be needed. The new SVSM related 
> fields would have a callback assigned that always returns false by 
> default, so that these attributes wouldn't be visible. A new tsm.c 
> interface that takes the attribute name and a callback function can be 
> used to override the requested attribute. For example, the SEV guest 
> driver could register a callback for these attributes that returns true 
> when running under an SVSM or false otherwise. Or it could leave the 
> default in place and register a callback when running under an SVSM that 
> always returns true.
> 
> Thoughts?

Sounds like a patch I want to see, yes. So the idea is the low-level
driver registers the is_visible() callback to the core and that gets to
filter attributes?

Hmm, as long as it ends up looking similar to sysfs is_visible()
prototype.

It could even just be a bitmask of attributes that gets passed in by the
provider, something like:

static struct configfs_attribute *tsm_report_attrs[] = {
        [TSM_REPORT_ATTR_GENERATION] = &tsm_report_attr_generation,
        [TSM_REPORT_ATTR_PROVIDER] = &tsm_report_attr_provider
        [TSM_REPORT_ATTR_PRIVLEVEL] = &tsm_report_attr_privlevel,
        [TSM_REPORT_ATTR_FLOOR] = &tsm_report_attr_privlevel_floor,
        NULL,
};

bool tsm_report_is_visible(struct config_item *cfg, struct configfs_attribute *attr, int n)
{
	return test_bit(n, &provider.attr_mask);
}

..and in is_bin_visible() for the binary attributes?
 

