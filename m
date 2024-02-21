Return-Path: <linux-kernel+bounces-74201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8E85D10C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D021C2291C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EC53AC0C;
	Wed, 21 Feb 2024 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNMPz7Q0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B73A26E;
	Wed, 21 Feb 2024 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499727; cv=fail; b=p5aGVOmVqzgyxxgjNv1hRoKQ4t/ZuD035VHD52l5mJ6MtyoFdUrgKzM0kMFwo4QUqy5tWHldqnzsDctqiqds9Ixb1RQEoKX9hn4Do1Nz7cQSLOJY4bQmTBTilqtAyxxTLZKf7l4ru3bGIufDdj/gQxQykcAZDyKfzV8InBEXDFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499727; c=relaxed/simple;
	bh=PG1/rFeWUiviu8p9hDN7w7Jl9UQ5r7JBPrerrKS68E4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dDkYFXci7OT2ZuIkan9KvWAzCoA6Bm/o05oH+pFFhMdax279KLFdzyXXkLBQp1rKi9vtMR0IL4U5YsUqoUjW0z1iQp/OHEEfcYH9feicHeFH/3E2xoClpZ563S9RGC8dGdQqaEgcn7KuqVEt6HIju5dVokBvrWavuZ3m+sN5hnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNMPz7Q0; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708499726; x=1740035726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PG1/rFeWUiviu8p9hDN7w7Jl9UQ5r7JBPrerrKS68E4=;
  b=RNMPz7Q0lyN3w+AwW9RxEOTiCfPrzynEOZ4BdizDBClpITyUgam50O8/
   7WHdu42a9E1jwyx1T/+QzVAK3Nkcyl94H5uF8BdTS66WIt1hNm84w1AIY
   YBMK1UoOk8tT751TL+vaaRIdVGcKoObLHbdFejrOQLTPHbv/pS2Tnkmpf
   /wsSUBEzLkUDBQMVys7uUlyfKeW7NokFLz5Zc8Dt8SDv/BqBpp0cmKCt2
   Nzf/iQ8jSjewrNHGQFzDn5ABpWi3aZ+WM6u/ZGheFdDtXmI/M5To6dyMV
   zO06K7ZiYRej/d5VLspyyF6fhHJ2/RDt6hB972tEo5hY0wWwqt6wHbp9I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20182532"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="20182532"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="36081839"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 23:15:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:15:24 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:15:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 23:15:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 23:15:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J020TsLunRqaS2595OShNf9PkFZtW11srV64+pR10LzyvjjbaqKD36OhkhNd061JTfVgeo9LbWa74MeTebFKycGecNW39J4wwWgmhogztpHSVXaA6B8AorMKLfzai4WwdmuW0j8MLEhmxuxkJG+SYWTY2OzN9ou3kjCsaITUJ0IPcDqXm0qMBAlViFvJA/u/pqsrHrNcNFHv7whml5EZtS6REhSj9MKKQXFS3trnvBonzXNVAD0CW+e9c/D0d3sswpmRV4f1NJ+R3JdAV2O3Ay1lFkOOnNkHA5V+xR7AMRE0TtBmQuaJJKquFti6uK97cjiiZbExEdrK7rVUnEqFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmZ4p036RZXEPKM72yEiP9/NrEyIdYVK6CE2xbv9C3s=;
 b=ThvNbMMX1v2k7pfC/grdYpgS1N8Z6Z2oKTCWPMaB6TMDgkAoGJkU6iNSLMEnTsG8Lheu0orEPzrjxSBMRGAJ7J4C/TxD0xT8FfokGK25ubp23XtXLfhTi8EUHsEZvYbztiqhIP+rMXAdtCPfvfPwJSfbnojxHSwjg/dR8jLZFhrJ4dYQAkPVkS1d9YrFK1fmpE6SKI+N1Jz93R2pGdWyxwRvou1j6AVSAZYy279rYzSJyWGmZkpmCh7KemH0hyooFaxwoiwp/wVcscaDqvKO3EkvAGCc+7DZTaa0064nnJkGYE3hDJYOh7IedXoPchahyY3QjwqyfcREeAkPhJ7ZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 07:15:19 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 07:15:19 +0000
Date: Wed, 21 Feb 2024 15:10:12 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "dumazet@google.com"
	<dumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"kuni1840@gmail.com" <kuni1840@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, lkp <lkp@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [Syzkaller & bisect] There is BUG: soft lockup after sendmsg
 syscall in v6.8-rc4
Message-ID: <ZdWh1Jo8KYPR08oB@xpf.sh.intel.com>
References: <ZdVgLbuAYGKoDzpS@xpf.sh.intel.com>
 <20240221054154.51749-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221054154.51749-1-kuniyu@amazon.com>
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CO1PR11MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: 38855dbc-f685-4c57-74b6-08dc32acdc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CeHWzlH7sabbdehtTHNvtuxP8wzY9LanBm7st1tmYLWx83ckDiabx/se5mbF9XoT+ACgk3iPZRNfUr92eJRzCAt9AewV8CfudnTWSmg+Gq/Wb4CQrORmu/mtbBw3i1TT2ER9ymQPE/p4MnlOewOt+BQSVn2kyqWhNBsoZYy1coeBLfx1npIn8hVnsqIQ5+Ime+7sdfL0jzR034bbwsk2NNRbyTbJJsfnfEP6MXdCmhrJk6te9kRXIkSLL0Q92TxwmZP3vEbhX4IDWmsm8kSuURGN1bZYxqyEEM90Cu5T288qhYLRdUjzTget7u7hefX9ZA4rRYFyVqptQidLhYtB0jiI9AL35jqbJGyyIsR+JLn5btO3HESdeA+o/vQN2V5/omQJKFqB4Qn5+lT/Ft81wyjQrYbfe72ICxgKJPbKnrcoalxAcsIA+dg/v1kRlhqoZbkaTwrzgBFXIawqAxpDQ6uNOipnSq1TNnhvbaB1SHSXV6cfsncNPB/AveF13KH85rqevq4hLQjR4Vnatrukig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9gGibPRW84/UqAD0AymWct2qo1qaz+A/j1GkUyTUFcchuH5aj69gwFINHonZ?=
 =?us-ascii?Q?StkYYdjFDlOT7+wntwy0IDlNHN3tC8MB+LPzUJccZigOvjuYUeoGxSHOa7uW?=
 =?us-ascii?Q?+cKFiH+wnW5u9V4E1hdH7nvlHeaEj2YErR4JDulOOSolc1ehRoq+7p8IE9i+?=
 =?us-ascii?Q?XL+1Bf4DlhS9i9CJJhBqzYlv/eJuryqqafdH7M2hGlDM/ZTUq2o8Z1QcYZ1v?=
 =?us-ascii?Q?bjisnmikHNy7OPoKeG0hMfr7B5blFFpXTXS23VJnW0WFNJjx20nP0XyODTdo?=
 =?us-ascii?Q?+JoLAjeOKYs+Vevb8vWFLzlr/uqwCH3SpZm+RYKCHfNXvSK/7GMbvVI4wyO3?=
 =?us-ascii?Q?alB+SKR/0mQPC3ztcBHAyJqLl266ZoioS1tI7/ilJI9Ygj1gD1crCHjdkitp?=
 =?us-ascii?Q?+A9UrD/XILosDAJKcQqoJ7ksn/rFEF47cTZPG6rC0dXu2YpPWSD65PlKk07W?=
 =?us-ascii?Q?XimcnEtAkmRp3w48X+fd7YUBL381qGk1yn1R8eJJhZo6ZuQmy9f4PkkIEPpS?=
 =?us-ascii?Q?CFigOGl3gxIUN5RA4twxrcJe0miB4iCaKDNF4FY1C/lP80XQwT3UeMkKXsB1?=
 =?us-ascii?Q?uFP2+s4axylq007SgQ9p059mGWUgqUP6JAalWan2I9IhXXPUH0FDSncOr6uB?=
 =?us-ascii?Q?vHd9FOo68EKEN4c1ponsFhtpUthWJPbQcUytjfagtvpu0SV6uhagHgUSFFy4?=
 =?us-ascii?Q?fwv6xlB7cQX/C8HHrz0N7o0obd1v/5PYqrpuap+S7KSxof6Q1T7M6tNxWh3X?=
 =?us-ascii?Q?l1ijPMe31G7nOqQZLRX2KxG0y2x50f2oi3s24atul88FsHdYX42bCDptqIV3?=
 =?us-ascii?Q?3HfCTyJaqtK+O4YTysAKTWyS8xhys4pydwlZll+ns2LX2k/bPt8QXlBDfLrT?=
 =?us-ascii?Q?DTwfG93XKzHYUBEhWEh4BhO6lxKTUsYKFVtf/0SLev/pn0sWrXTKWjDjQRf2?=
 =?us-ascii?Q?MvFGcYbktG2tsB0poYEAMB4Lfnxy7FT9N3imST2PrF+Vjq/7wV9LDLhEBq+m?=
 =?us-ascii?Q?G1ncIyPXj12c2tXRyQjK0GXinxG0veDfd1q/eIeRN6+tFXcJzDdEyCs4QiPC?=
 =?us-ascii?Q?l7w4w5O/Espe0actdmC7plp+tQSwcvefSUbLNHQVzDf+M8Vx4fKJKmAvWLaj?=
 =?us-ascii?Q?Aw3NsYq/t8fCbcPtaAEV39xVe9R0eukJFucR1wZdY4JWffJeLPQrVa/9OCEt?=
 =?us-ascii?Q?FLj9I38OXNKv8Aod6G1c4PBCM4KbwVo7SJVnzBnDAOxFeArvPpSg6dYYb0zQ?=
 =?us-ascii?Q?MTAfhWTMA865f4kA66LdBI489l1PuyxgXO115b9jmI6G/F4Ve7IJJ+ixIN5b?=
 =?us-ascii?Q?EvPTwDRLz03DCGbnDk9btqKPy6xq/JCxKnwyEkyFOqQ8slh/5ViczEXyhO28?=
 =?us-ascii?Q?Uei90mWPOhyutTecOb4AE+khNY+kJVbjD32xiZ17/JofZyugpkiYkMIyzWtf?=
 =?us-ascii?Q?ym6fVl+01Wz4CkdoT4UHGa2/rxjNHNclKTcoemm3Gw6IWoLM6lZ87p/URgYU?=
 =?us-ascii?Q?UT1XRlbXEnbUUZ7LgrcigoVQM35B9IJzpw1XnqXb0Vj5qey/P19F34VBQ/5u?=
 =?us-ascii?Q?KckJoapBhs+yEjd1sgxQTTVzg8akHGTravSRoIlC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38855dbc-f685-4c57-74b6-08dc32acdc51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 07:15:19.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqoBlywltqBPxSCl/dabnFhVXc/U+JLy+WvzvFFYUG0+JCZsH57oY3iJtoMzz9+7cBRWAU+yFV0rbFpal3XG8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com

On 2024-02-21 at 13:41:54 +0800, Kuniyuki Iwashima wrote:
> From: Pengfei Xu <pengfei.xu@intel.com>
> Date: Wed, 21 Feb 2024 10:30:05 +0800
> > Hi Kuniyuki Iwashima and kernel experts,
> > 
> > Greeting!
> > There is BUG: soft lockup after sendmsg syscall in v6.8-rc4 in guest.
> > 
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240220_161242_softlockup
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.c
> > Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.prog
> > Kconfig(need make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/bisect_info.log
> > v6.8-rc4 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/841c35169323cd833294798e58b9bf63fa4fa1de_dmesg.log
> > bzImage_v6.8-rc4: https://github.com/xupengfe/syzkaller_logs/raw/main/240220_161242_softlockup/bzImage_v6.8-rc4.tar.gz
> > 
> > Bisected and found first bad commit:
> > "
> > 1279f9d9dec2 af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
> > "
> 
> Thanks for the report.
> 
> I think syzbot reported the same issue.
> https://syzkaller.appspot.com/bug?extid=ecab4d36f920c3574bf9
> 
> Could you try this patch ?
> https://lore.kernel.org/netdev/20240219174657.6047-1-kuniyu@amazon.com/

Thanks for your link and patch!
I tried the above patch on top of v6.8-rc5, this issue could not be reproduced.
It's fixed by above patch.

Best Regards,
Thanks!

