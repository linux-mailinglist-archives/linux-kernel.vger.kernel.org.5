Return-Path: <linux-kernel+bounces-105650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988E087E211
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806991C21DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86ED1DFC7;
	Mon, 18 Mar 2024 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxg1GDVi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8811DDE9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727894; cv=fail; b=V8G8xpp7K63EO7uN4qGgmkaxKN8hGM0wQl/KbBykOIoELFyP3gm6cQd1qfdpV2owsKM19ncY4sERp20TKwEusHOP8kJhUMvgT+mBUJpVUsMM+1Gq9pCJfKycBhlBPH/MWQGlgmKRS+e492IcZ1xG5a4w3qWBQTMgCaMkvoPAVmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727894; c=relaxed/simple;
	bh=HQIDwulmZPt2qQErNJEY4G/vulFhvOixbmxh5aK26u8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sOFLnWchIlcD16aOGSSBRn6yUN2xccy7ITqT+4NuHR8W43s+vIS2yub26rPU3BtM7XkAFAictLw+uKqElUrhVr04NGmnO+gH6FfZoTCvsCpTU//bfsgRemcFGgAgiegzwg4PnyQKl82g/J9uRGBFQENQ71KH0GYwULnlFpanPqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxg1GDVi; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710727892; x=1742263892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HQIDwulmZPt2qQErNJEY4G/vulFhvOixbmxh5aK26u8=;
  b=kxg1GDViGRd/m6o10s0dmakT6qv0WWBqbPNHVUbCd8nhIaxeZYlJK4YQ
   O72pNXlz42s78hyWdY2k42BBDOVdJRFqEkSUhwIUQZz93ygdXDseurPOj
   Lc1kwp7cAlt9njdwJ27pWKSTReMvKYzou1mv+LMdozBKTc3NDlau9MCAE
   4sZo1CCotIJao9CXr85YpsxPhB8bD2WwNIy7sBxRZ+tEsFEwyrgdWwO3X
   06viNtXtLHmqGZkPytk/bRymIbvhakzm5lk43byfkibgX/ISO8elL2F5M
   q8RHPiDgFYStlaLjPOM3uXfGRBQscmYcs3aJeMbDf4NxZsXD4pfIO7x3j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="30962760"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="30962760"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 19:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="18005284"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2024 19:11:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 19:11:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 19:11:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 19:11:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 19:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjAckDTl+2eZ006lUpULOg5yGpdv22E603bFEr2tClWhpE2rabeSuwu6uAJIIsjCnF22a+cFHdKVhMu4c94BtPb6KCFQvM7y1IJ2pXsRXImVf3ku+dr1Y3iRyJ3LFIGJQ7ONfrk1xBurqlpcwb5+1W37Jq8S9i7I9zEiAtb/u6TFmRGZhDulokCHwDLPdAdxHP7D/ABFFrJRVjC1u5fagXgUQPbt7uDjNrXZucOSojL1YLhoOf9kCMl8vfGhlRice1p//ODbr/udYXvjHh7KX5NoyNCgtxpb8vA+Gs9Mtl15nCGdBlwX6DNQPrlUJL8RlWlHPwz9GwMeON/Fo6+rkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8QwSD7JBuLcmHAuGPrNw84mqycbjZGTH2hxqh4pINU=;
 b=S65yf/nQlH2RmUQMbwd02UP/3IRE5YNSTPhS16Yz364lzc+OB9yYsOMShsLRnSmaBxMx9Eqk4gh1dHnQBKqD9BTNC7L+AAE6fcMc26URDwtaNCMl0vF2Z/LKUSwa+y1T7mipHuO6j+dEII6Jf5huKyyWuXKHwaPCmhCMxLeIHTKTyzW1ayuH1yG1pSycJbGL+y79Ghwu51nRHgNuzMdrnu0yURl2wCrroKleOcsq0sqRMoFv93T09IdfOGgn1TzsQCmTh8soNzaj5qB2TMckQM5mEVX0+GFg1q4b+bST/VDvepRhWFpcahdzbYg+xvQEPxObTzbDY194tO/sn258RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY5PR11MB6511.namprd11.prod.outlook.com (2603:10b6:930:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Mon, 18 Mar
 2024 02:11:27 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 02:11:27 +0000
Date: Mon, 18 Mar 2024 09:57:30 +0800
From: Feng Tang <feng.tang@intel.com>
To: Waiman Long <longman@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	<x86@kernel.org>, <paulmck@kernel.org>, <rui.zhang@intel.com>,
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tsc: Use topology_max_packages() to get package
 number
Message-ID: <ZfefinwL7jUo+Ly0@feng-clx.sh.intel.com>
References: <20240315112606.2248284-1-feng.tang@intel.com>
 <e0d1b16a-2880-4e3f-b3ca-b0b47494014a@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0d1b16a-2880-4e3f-b3ca-b0b47494014a@redhat.com>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY5PR11MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f3ba5a-f24a-4868-58ff-08dc46f0b82f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C04JVaQozXuENTpjZCLqhBOo+Uh2KKgtm6toceNH/a+q8Y/lRHZdfWefuLsKuKH/X4a4f2kwcf6ccI6pNPNkueWagssbusTpmKZNsY73Z1dMnn61/8ErpI3phS0t43BSWJ2M8YtWLEJ754iT2IUy0l+zTCQOymNEEacij5icUu56MuLLZw8mV8eADWxhWrKPA3M4IT2nHpWgBqHurig5Uy5mTu4siGru2nfUXyNtbZ19/lwkBCsEMQoBkVqrCpqB3YMWGm2G/dVVOvE/4MSrCT4lcEtyc1l2V9I7RGVrlM0pb/z2EOwIuASAnmrheTywpMlWg4UkmrCZWnZQjt91M/hYBf3+ak09SMfFVvJNecbsuHUIGaM1v3pcquEZzV7VteGyv9a+f8eJR+RdC0bPASE/ZM5Am+2pobmGUC9/AAVmYY8/RPV7rfVQ3nJgy546Pfncp8G2sCP2upmpdn+WCXdfIWbUJs8YNxAhtCxDUpI1tdfL4ZDRXYhm0DE8pzcge26Xnfd94M8Fs1pPTLNTROO/MZcTXz7UGqP80O+W9lq8KAbkO1fKuZdm64gzxvFk252bsvMt5LPzoDHds5dffSLcmID4oFa8n7P+f56a/m9DRjsJMQIw+mOkOTvdahEiP5OjAZfQO+7IDXEU0PRDumQgVriE2flvwfRTiQ7cH8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?voMtb5hUA89MlbRfWbfjqTa4Qb4ea/aE5TVybf4SkjWQrB6d1VpUt+HBRLjb?=
 =?us-ascii?Q?9mung1MAFyJhOtGrIpBSKWOB+doVWe0gCRsEl6G+pC/ZFk27ADmwHcn07kXE?=
 =?us-ascii?Q?VuGaekJFAh6VZ7Du2OMeuCabygBWWlX8rvuh1qUe+Wi6MxwDeNNJ7SlG7gxW?=
 =?us-ascii?Q?8D/L7CyLxhyGAvZu0e2Ydlb1jSlnuyCw0lLv+V/B7yYDYUzJCKX6vqcqQhQi?=
 =?us-ascii?Q?P22eMptRHJoDltvtSFrH6zVcGwvQGY/vp85ZF6TRfwydYaLnCDucCmmGt1ya?=
 =?us-ascii?Q?QscTUY5WRg7hO4h1fehBMBuIv+YAhDRzJih3LPC/fo2XjJhH5dC2RtSIRGSd?=
 =?us-ascii?Q?unx1RmheLE2Svnwq979EO3IePCOBDJBR9USuXaJ/TUEcLNSJBTWb0df/i3BQ?=
 =?us-ascii?Q?7216v/MGim8dnB4JCSrUCV1+ta1Mtm/taaTNX+mzI1Gwj1Y7l4MRb0y+weOr?=
 =?us-ascii?Q?s3cyOOZwSVdGGlWJKOUBQ3mV6aIOAGdhZ9lXvN7VMQHTrQeB90Po3QtLSj19?=
 =?us-ascii?Q?OV5AWJntvurhyy/xwNbM+GFf6XFfvSfw8JWTBfHmNrlbDXfWRF5paUmY7dNl?=
 =?us-ascii?Q?ZJKQek7zoy4204zU38360vP2F9hkgRy+eq1a/SJ1oFCfrTLSPwbmt+p0CFCT?=
 =?us-ascii?Q?HYqyPbA/Z6oW70Nfpk7MMsfqqJU8+SUcvsTNn2y1ROmTAUuZ6E7PsDbDd8DZ?=
 =?us-ascii?Q?T4ZD1p35gGI9IwbRRlpnwQF/o16u87qzmwOIymXvxrLfpgvoO8nKRE/8z/8t?=
 =?us-ascii?Q?s1Rs3rFfTfUExt8wPyxDWSJzm2fc0XNHGMHx6nF3pVXmAshwXgoFDZanRigT?=
 =?us-ascii?Q?/ZkdQTH4C6TJc8t9uzOPwleHjkHUJk1TKeuYL88zkONCzzZYkRrY4vnhLLsl?=
 =?us-ascii?Q?FuJrzvF1iJ+ZV/Sa9JnF4DRkUY6T6+2UqtLkmziM6esjTnFz3eBFGzduz6uV?=
 =?us-ascii?Q?ZMpJhUuVgJHiIx6vlgBdUmjNBScND+O1HbkoKe+84UDRq/Pc27ktfryWFvQB?=
 =?us-ascii?Q?mFM8ZtOqrt02suzsi0eSjihV3vzM1Jyb6gDiIw3+I7y07hErexY0skNwBd6c?=
 =?us-ascii?Q?8O0v32EWmBYfkIOqVF0VeGg7a3HBJgRymRDB1eoIXm/7PY+AdLqdIEpPLLrP?=
 =?us-ascii?Q?31tfHVd7N2863PNMYCD8tlzL2R13uEg9SeaZSwbYsVqnrxAkigq5JaWs1ock?=
 =?us-ascii?Q?UGEAc65Uopa7hktEV8hq57Jq9VsITG/mHvmi9Z1snw9f2KyvP33VZ0w3JZB+?=
 =?us-ascii?Q?VHIxfjE8pMaWQV3E1IhkFuIkEpJd/URKfiGV4Vl8ZMHMdVd5HqgRAAEmhJHV?=
 =?us-ascii?Q?l81f6YABpeNwJInFCbMuxBg4hCjlBeudqSXEdKYYKQQNAZSMucapuSqGfw32?=
 =?us-ascii?Q?SsNKCDO6WXO4TAOd/uEnmdgy72NcHjgaB51N7jA9E6OgxwMhpWWGkG5dRILl?=
 =?us-ascii?Q?ojDosRJ6jbpYUrVEWPDAWIBYcrur3WVMPJtR1cDyozbQJoErfXxP9Sz/yK/U?=
 =?us-ascii?Q?E+77P55gjsrOC6cic2q7KG+TxP75fbbp1eiu/DUFc3YT2wE2qHCqITm/behu?=
 =?us-ascii?Q?RCp17BbJUPK/vquv6o72STao9EkWE1+yr5sfPYgR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f3ba5a-f24a-4868-58ff-08dc46f0b82f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 02:11:27.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8e2srkj7PAHjCi0qUXi4o51nZK/4UMQTCUtgrkVF6r/597FuyRyXYtpJ4F8ELORTPf20bLLBjl5F65oShKi8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6511
X-OriginatorOrg: intel.com

On Sun, Mar 17, 2024 at 10:03:38PM -0400, Waiman Long wrote:
> 
> On 3/15/24 07:26, Feng Tang wrote:
> > Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> > on qualified platorms") was introduced to solve problem that
> > sometimes TSC clocksource is wrongly judged as unstable by watchdog
> > like 'jiffies', HPET, etc.
> > 
> > In it, the hardware package number is a key factor for judging whether
> > to disable the watchdog for TSC, and 'nr_online_nodes' was chosen as
> > an estimation due to it is needed in early boot phase before
> > registering 'tsc-early' clocksource, where all none-boot CPUs are not
> 
> "none-boot"? You mean "non-boot". Right?

Yes, you are right. will fix it. non-boot CPU means AP (application
processor) here.

> 
> Other than that, the patch looks reasonable to me.

Thanks for the review!

- Feng

> Thanks,
> Longman
> 
> 

