Return-Path: <linux-kernel+bounces-108263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0829880881
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9581F23ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87304685;
	Wed, 20 Mar 2024 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RaLIMdhd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCE321D;
	Wed, 20 Mar 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894121; cv=fail; b=fB0DBdn8AGVb3o3a8PK5+LqDqir+cTtYQKl5rsa3ZMyWqlRy+TxcZqItlM7Xkqf7BP51zg+v+AwHDDUG4/qEcsbkxLZ5OOBHFqdY6wBkrS94u4qnwXfYHvn2nmHhfnpWYs1GmU0pJ6x1mX9s0axlfQg38ZoUXcKyILxnGtDFiOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894121; c=relaxed/simple;
	bh=fFpzXfJv1jaUrtor9ILJQCHJbwPLybCIaXrQ1PlmwH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mjTg1R0knqUxjhPWUdL++2CGPGMMxo7PQ0lpvysC7iurviv2vWSwO1agp9sj08s1IWo7RI0sSr3vAUreusu/cjm/twc2LumU/m6HmMIKf44SGIi5NmEDKRBfE3dJHz+WwDpYUZTpBewP4reKt5HrJxihb6RHm5fZbOSeaZ2c7Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RaLIMdhd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710894120; x=1742430120;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fFpzXfJv1jaUrtor9ILJQCHJbwPLybCIaXrQ1PlmwH4=;
  b=RaLIMdhdG7BAVzGDqMVTNfFdvi7BSZPrgCN6wxVMrDheMNe2IYL02+Er
   6bHMHgY8CItJ2lHCnBpCxUG/n90Y3APhDP0DRcxbQdJrnpQMsXDs1FaqN
   Tot1FIjyzv6BhERJJKPOIb+sRzyJIwt6mLMUv4gI1Mo7DCT3iXxIWY6M5
   +hOXmY3JKTvo1YIMv3wGuBPpLyHl8Z02x+CMmdK/tXM7ZSrhVrnyQOUzN
   uBEMGLvMH6wjApWgYNPtjZDMjMVx84NL+v8GmyBmaQERlJPpxSTUdl/UJ
   Ms1h9f/9lpLF7jmjxQWN5EOY481+5tajYkjHXeQBlOKMeoXK556dOiZnG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5975650"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="5975650"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:22:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="18703396"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 17:21:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 17:21:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 17:21:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 17:21:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 17:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSoIXvgdlS4tib0TJEz1pBjBtkd3/kkpeSyveIK7u/sXHQIui6o2CNx849rErQRDhKFO0ar5TVDicCLXv1pwgjAV4JhL6MYqD48NSpDBRxCvN1Qb0RXcvu0XgJSTav/pAQPD361++fd1ID9p8vNVLJiCeMQL77y37cS1OiH5YbH/iU3xRvakb2dOUzVtm+aBomAFS5KtlVfQxnnFZqsf2kAzi11U4fGoyaRBYyacqNLeqojWk/zEw2KsIyiucpPTFoXjGXQTkySs/6T23CXecia/Ex98tBCZnOiF8dz003huTEst/FeLTvjeLsgnKwVF+hPqYC7b8QuGNmO/yVQD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cy1lNPiBAvde08llR3bgaa8+/Blz7+PmIKMgxBxj+U=;
 b=Ur7BAcVLh+teGlpPiGmjFuwylf72DOuFacn8ZYP5H+RpQiP+iAOHQ2d3bzCFbaIYonmXFgXBk+uZAuZkqFi7vUfO6DM5ZZ42x2ZMarIFLX8zuUCN93ASZsgQlieB7tKgZrpAphzXajbBk9hY4TMb/D9sjNKiz8m5cbpDFDg7wpwPTikUn7Avl4cgCT43xiU/OdWv8TcwoMTMu18sDNSnOqIV+exK1h3Och1qD7CtCrJ2YD0Spms2ufNatzFFE8CEwcGEgLcVF8MTNUnhT3geUyDHoqUqA5w6/YFTzcK0J6FpH79uaO9KgG7KpKauhroh65SNICSogsg5ohEuE7GbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Wed, 20 Mar
 2024 00:21:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 00:21:56 +0000
Date: Tue, 19 Mar 2024 17:21:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Derick Marks <derick.w.marks@intel.com>, "Len
 Brown" <lenb@kernel.org>
Subject: Re: [PATCH] cxl: Fix use of phys_to_target_node() outside of init
 section
Message-ID: <65fa2c219548f_aa2229499@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-2-rrichter@amd.com>
 <65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zfl9Efxe7DwuU_i3@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zfl9Efxe7DwuU_i3@rric.localdomain>
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c7257b-642f-4b11-42e6-08dc4873c00b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqjIJ3wf4nqDamyIpbxWRt55FeonDL3LilnF0WA519rx6So02qQxmUePV57fniGlhePj9M7tkdYcyNptQ7kMWyRRtNCJmetDm1hHcUulmjH8eC7zyySjAu1/r0os0xP/xvO5D+KRa92fxSIwcRf2EUpjrSinvULoJdvlDzAh1AwBD0SLj4R3aWIOzLr02kiHt7/DJmSrTMNlVRUqbNY7WjcPjeA5ZWoiFp0IObN8qWqn+dKd9wgBQIN+OcrQ8zGoNDB5qY5G+ig1tQSS+EZ/RTR5xtaDJPRJM0XR+6tk36ROyI96HQlPKb2cfH8uO1+I5iOKRKa3LOL4q2uniRcP0VTNbfcI3HOGaTBn1+C0Yu+W5/gsDdLFCUcsDlrZKCR3CYYVmaZLqMFJarHSPMo5YuXroutc5H1Xl93bYqtAh4Vq1NdFaidEsL8EyfdthsTri4itWNstbF5/HdYsJObwc8z9a4JMdPMRIlqqv/49OSqIoi+Oo4OsfyHXO4TtsE+rEUqVvZsBvpFbjLn89DwLgL6nTms9/rHMBRNfEVNH58DlalH/TXO1pEyxhk5D3KKyWgbuks2/704C/sg8QOBE9/c9Irx4QvXy6w5rmcAwtWUBE04zLblmqwquzpteJLfnJv+Avh1hVNs11x0wgMu/5ipBBdg/GQ3mDFyAlHWT+nM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xdmt3OSTZHgBkDtMyxFoVPnnIeDLJaRf6r/j9J4D7kRtAV/dRw+Q3QFq60TL?=
 =?us-ascii?Q?Ma8tdutS15vLTyLNGUJx2USv6+aElmP1NnIqWEVoG06GiKTIYIbsJ70hNfe6?=
 =?us-ascii?Q?H8vD7B9y83WShgKEwA6SdGqgesBCjbQ4J4Xv4zKcjWs+yjNFFudphiWxroin?=
 =?us-ascii?Q?sWkceyQ1zOFd5pqPrctCkEiPJQy0rqtUk8OeN+d05zhKkNzWLXTviBnpatwH?=
 =?us-ascii?Q?UhwT0bmxGHRH8eipjiIf3W6V7w4APmgw1qSB9f4g8A/+eLTcyTI1LliDjNrx?=
 =?us-ascii?Q?fZ3LVZTenH8xQ3wET5NRI86OJy2PUbF195ubGQILT7YDZ4U1xMY1xBjLwnw8?=
 =?us-ascii?Q?j9AAFixujonXvgQFppW9yEVO84bDJWd/gI1gMzCWetHTH9MEFrKFY1+sx9oy?=
 =?us-ascii?Q?oUU/O3Y/5qMBrPwpA2SjJ8mZwRFj2gJbg96kMaLRRchU+fRQPfxnPptEnjyG?=
 =?us-ascii?Q?HoGwULlRN/tWV66rm20rexH6ThhvK6Y/aNJDI8KUB1JkSIvT4zvMvfj2fnop?=
 =?us-ascii?Q?+mTbfsvL3zuZZqxf3DsvGKElLtOtRXHGSaj1s10KyJG0ZONYm//tUzHmJYrr?=
 =?us-ascii?Q?U9AlMcoXacWdCBXv2X4LBGBYQHckKEMrCAa2FLtg5AX6QVkpVq8xpOCAFAKe?=
 =?us-ascii?Q?7hnfEJBdyeoTsTA8SF03MPlvrbc1L1FMlw1SjATcrZb6KOmk08lZabQ/8tn0?=
 =?us-ascii?Q?kRACipQcnXS+YeELzJWjHyJZFxNKHuvG1yOT+7Xk8erTXu505U3IM3KDMosK?=
 =?us-ascii?Q?F47LoW4iUYmmHXvXfpE6oV8aCKuYPeJ+KDL9ZzCXJUFrxZOqgg9U8wgMqSAm?=
 =?us-ascii?Q?4zoN3eSwEkPBq64UZh+RaU1NWqbliTtHfEeC9xrldJEp3oNMupRWEnKcfFPh?=
 =?us-ascii?Q?JxOUl1Tp3zh7EpQeGCH1u/9QT05QkbpmHJQDXepZ0aTOMTzzQIbQvA3Yb56a?=
 =?us-ascii?Q?hRWgPj9GTiY1LH+/9wlTfzpOWbsWZCh79FPeyS6+Iuteaw8QhG3n/JtoWiuF?=
 =?us-ascii?Q?yJWPhj9Kwxq+VNIH2eRJxv24wOW1Y5LTARLttN3sxedrz4UXE4t1cvi7a6aJ?=
 =?us-ascii?Q?cIDM8FJKjLzl5nmVI1pfbmoyyimOkSF1DpgS6KQOUlPIsL9WDJ8mmSU+xxpe?=
 =?us-ascii?Q?7oq1uowg30qCW5Cb/doQT8LZwLVsy8ed0p8CNVPgULqc6nelFDT0fMwCjOsJ?=
 =?us-ascii?Q?6JUc5HQv0GMWDHrAJfsUH4azIewuBpuS/jRpb8XHs5SOOegL/591InXVSKYf?=
 =?us-ascii?Q?dDE1RKmuLxjAp0YUAR0+FxGb28dKBpDydCKENhLyfDVERK5wlVqkC5aCC81I?=
 =?us-ascii?Q?JFAjrEZhuxC+2tma036Z5sNFEgYkdP2+DAxxopfGTVNrYLImINX5ejylxxaO?=
 =?us-ascii?Q?x18xUES3fXahbCbqZRWl/CyveiLtpvRko1UqTJcjyvGc6wIT5WxqtdxL5pHn?=
 =?us-ascii?Q?U5Pzxk7vMVMvqjMv7Io4zWpy/JAYixIPmDFKclTHCyfS7o2iUApaxpBC0CQd?=
 =?us-ascii?Q?zHt/CBDN8J+KymyUfTfljW88WPD5b6NUbn/NoB/oxaaO/8fX0b5NyKxRCAgU?=
 =?us-ascii?Q?wpgWtaYVeRTWbzIGTmpJ0XUNw48kElORDceCvTs79voTQb5FyJTscQwehucI?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c7257b-642f-4b11-42e6-08dc4873c00b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 00:21:56.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEsWW/IVhfQfjGkslbz+7fEpdXuhE/jcSJpbso15yvSUzu0NRh3Pil7qOsiiNnhuurBcCoAyuGi4CBEQLGW1Wtp+StjB5r9K2cD+FJPQnWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Hi Dan,
> 
> patch below. I have not included it into v2 of the SRAT/CEDT changes
> as it is cxl specific and can be applied separately.
> 
> Thanks,
> 
> -Robert
> 
> 
> On 18.03.24 14:26:41, Dan Williams wrote:
> > It should also be the case that cxl_acpi needs this:
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 67998dbd1d46..1bf25185c35b 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -6,6 +6,7 @@ menuconfig CXL_BUS
> >         select FW_UPLOAD
> >         select PCI_DOE
> >         select FIRMWARE_TABLE
> > +       select NUMA_KEEP_MEMINFO if NUMA
> >         help
> >           CXL is a bus that is electrically compatible with PCI Express, but
> >           layers three protocols on that signalling (CXL.io, CXL.cache, and
> 
> From be5b495980bae41d879909212db02dac0fba978e Mon Sep 17 00:00:00 2001

Hi Robert,

When you send inline patches like this can you remember to include a
scissors line? That way tools like "b4 am" automatically know where to
trim things. So add a line like the following:

-- >8 --

..see "git mailinfo --help" for details.

Also note that if you reply with an updated patch in a series include
the "vX NN/MM" suffix, like "Subject: [PATCH v3 2/3] ..." so that b4 am
knows to perform a "partial reroll".

> From: Robert Richter <rrichter@amd.com>
> Date: Tue, 19 Mar 2024 09:28:33 +0100
> Subject: [PATCH] cxl: Fix use of phys_to_target_node() outside of init section
> 
> The CXL driver uses both functions phys_to_target_node() and
> memory_add_physaddr_to_nid(). The x86 architecture relies on the
> NUMA_KEEP_MEMINFO kernel option to be set. Enable the option for the
> driver accordingly.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67998dbd1d46..6140b3529a29 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>  	select FW_UPLOAD
>  	select PCI_DOE
>  	select FIRMWARE_TABLE
> +	select NUMA_KEEP_MEMINFO if (NUMA && X86)
>  	help
>  	  CXL is a bus that is electrically compatible with PCI Express, but
>  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> -- 
> 2.39.2
> 



