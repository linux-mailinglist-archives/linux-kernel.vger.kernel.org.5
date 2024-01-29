Return-Path: <linux-kernel+bounces-42150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5E883FD12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB9AB234D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF7125C7;
	Mon, 29 Jan 2024 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKw8erxu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91710A20;
	Mon, 29 Jan 2024 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500886; cv=fail; b=f6zHwlr9vG2azjAh78U6floQ36oafIWxKrzazh1Du8l+wDLCIz6m8O/vFEPUP01EPonNNttmJaowtYdqTtx2ozefFHn1Ka4wBdbaJlmV5SnXuNqjQqQtKdL36WJ/YkqrHdODveiz0A4OF7ntI+2yuWUNQGkcmGGP+J5QiooRJrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500886; c=relaxed/simple;
	bh=ynGo1Cm27aMnyC8VjM34K10vTlbR0R5t/D8/mD1gF8E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kg2F79dzh9+JvUOn1+UvMU3F1ORX+jZAK8Hn3W2aADsJFDq1aQlL6Vlco/L0FbfRqpxysgyWJ1E19jHByeqgZeMROhXKCyl8+jovzzN9cO4Sn3ezg7YstSYDjxKY3PsrQ2LyCW456VYvN+ppSB6xNDeIkDzwMnRvtzi7+/yTBGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKw8erxu; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706500884; x=1738036884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ynGo1Cm27aMnyC8VjM34K10vTlbR0R5t/D8/mD1gF8E=;
  b=JKw8erxuxwOEpN0hpdeZSDrittjjOkf26908a2JRAVP7foUEB699Vpsm
   SjJB7x/PkJBILLjDvuan5DY6uDvM5bAzjKebxowrfbtBH2RsLjDO20azv
   /u4sm858tS8hnO8xI/GRP1THmQmskvK9etlGyZ+nqKJA8l2HR2ywW+Jdi
   lZbTrkZeKgsDGaB27ukQDHOShtGBCKMgyasMyP4kqVdwHHiXkFer4DdIb
   PkQ0fIGXBxto8V8Ew9OiAktorbCTWBiZgmX6Xnoo6q4riXRWur2lJYZwF
   1KGlFFqmGedMwHnypZf2UCM8go0s/Ka67+H9iBKPqSmqOxnMkfdbMH8VZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2731822"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2731822"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 20:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3328501"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 20:01:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 20:01:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 20:01:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 20:01:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 20:01:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3DMebeduyK2Wi5OumJishoP8VGgp0QomFHF0d8QduMvTeTLuYL4tDRIfzUs7nS3kQSrKHWqxWsalijouqBcJWPjY0FK8+u4gbJr+61FdmoErbyx2aaCzGw5vnrSjlP08OMjfD64jaTpPkNU3317NkxQj4s9nt802TQfrUTK+BrDeDsixanYgDNb42kl7e94gzbp4abegmcnuqiVlLkVK8kxNVlAhY0WrodStCopfo6fHdaZNqeTdKQQ6fOguaN3JpwrtZNNQGdL58bfLOam6RXijp4bpR87OWhPKyoLkN+gMuYQaQKn2zYUbLESqA5uEaXU+n/2z2lMjwqqe7keAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWbIlmvQl34G2GvkC6C0G0fihG8yeS3iPSAcjC1rYQE=;
 b=cAHoQr45DMZSIDHajnTQXA20HcQ2AZte9/+aE1nH2vEZF0e9pMTBvPOf+hiQHwzpV4hQ+u+oJpO3adPNrH9JWLZb0sjqpZgyrRSa9yQFH47YW1j+BH+ylwu8lelpohS0Vcg0H27hL98tOZknVXbHVKOMXkpzEe/FW9HJw0qlAxVD4aE8Eah6/q/ZajcmEdGpkptb29hxGtJCQuc3N0qL0PbuhLOAfpPOVuVyxWuyW9aJtroCEi8tRfjnmRrWT5ibKcwNi5BFfgQ8YsUVa2J8kaGpP+FwvR3GC3YdxQvEySzxo74cgwEZiUmpx9kCNT9nYHc360gKFZ6IDYTaMzDbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN6PR11MB8219.namprd11.prod.outlook.com (2603:10b6:208:471::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 04:01:18 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 04:01:18 +0000
Date: Mon, 29 Jan 2024 11:55:58 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: Ashok Raj <ashok.raj@intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, <markgross@kernel.org>, Jithu Joseph
	<jithu.joseph@intel.com>, <rostedt@goodmis.org>, <tony.luck@intel.com>, LKML
	<linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<patches@lists.linux.dev>, <stable@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <heng.su@intel.com>
Subject: Re: [PATCH 1/5] platform/x86/intel/ifs: Call release_firmware() when
 handling errors.
Message-ID: <ZbchziXFXPvIWP4s@xpf.sh.intel.com>
References: <20240125082254.424859-1-ashok.raj@intel.com>
 <20240125082254.424859-2-ashok.raj@intel.com>
 <4e360838-36a9-41c0-a1d5-f369ed78cf04@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e360838-36a9-41c0-a1d5-f369ed78cf04@redhat.com>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN6PR11MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7cfc6d-a2a1-49e0-727f-08dc207ef27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lhkHKH66xKUZ1xUgRPh5WMcDrZEKDWtD7v4X1z62EnqgVjKtL4OxyBg0nP0sXMck4qBaHHhilvkNJ5QMjw94E1UGNn0hMT+qxPAdrOzfcPwgUPkHnQf9tWVwROu8txTalU3f5CKYqv1dNWJnLwrVaAf5ZrcwvT/dvzRByBtXt4C/7vh990aH/XrmXQ6ouh+c1Ighjigo+i6ieQcSRjdr1Brrpga4mFO4zopTH7NXGuWMi0PgRfpmCidNzJTysucyLJpc54gvn45OHPx+zwZp7xpG+9rgolmXdk+HzwiABCwT7k5Rul2fsCLiDOUxP+4RlFYfg05DuMtfodOk0zRQ8/mbhvRJ0aaCkSAbavi0dZO5qJPTDBN+n7Y8bN+K4TvxpCcaf5IhHvP+xWMt2FTVdTW+5+2qZT+HsJcnaZvLUtCra7UbnLOMU2kTG4GXUi3WIauCmfARFjfb8f0hz8QPLSolFqxmffg3NCpvdgkKNH3xXd1ASBdx5RjPRwF8LQ46AlFJdT9xZPe8lzFMEW1qlceo7CydIrBCM+P0KXbPkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(6512007)(478600001)(53546011)(6506007)(6666004)(83380400001)(26005)(44832011)(4326008)(8676002)(8936002)(5660300002)(2906002)(966005)(6486002)(6916009)(54906003)(66476007)(66556008)(66946007)(316002)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjnjEXHsheFkVGZM/t/hAFTLWFdpSiMh4FVhOuHi3RJmHsK06XnQuKHP1Os7?=
 =?us-ascii?Q?ayGhbb4pymVjQkKIu6YJ0kkE7X0l2v9c4n4Dlm/gmOsQvjZhdx1mY679TsQZ?=
 =?us-ascii?Q?My8aCbfAfkU0Qkn8oqjr0fLnKh2Rlx5swnYkvr5XdyRc02HyToBM70QhzFqo?=
 =?us-ascii?Q?qBBghMklFsKI5WqiNG+TAM/bwFA/jMqAGmuqkHSEPoZUrnsiKiqjmCk3LB/U?=
 =?us-ascii?Q?QEhA8Aku9nAefQBKJXGFJqPZpg+eLedDuE5uBGIKZOG2Haxm7cfy+UrDaLhg?=
 =?us-ascii?Q?ItKwZJKon9W2/ymC4ZfhaCP5ZzhXQHFg1+gbiryx4pUw8E3jnAZxqt9VSAzq?=
 =?us-ascii?Q?kaDvPdECoyfEcVzGzOobKEsGItK/a+tmyVgnHWfniDADc+DynEodgYM887rV?=
 =?us-ascii?Q?ffNNmmc/amvJPq2fGAH1sdJTW4gpzZ0nGbi3uEJnfLiTPsF5ezDxKMP2+qTj?=
 =?us-ascii?Q?5eAAquc0X41ATEHBlG+lioIPYwTwpveh/rVqVsQlruhzW38riv+w3cSxamHG?=
 =?us-ascii?Q?AGJpOpKdmXTXPvS43HELgiLvLECNujWM9ubiWZwnDNaBZg9w3USwfgtnW6uw?=
 =?us-ascii?Q?gVlerEb/AKicH60kJx9NtAmlsM5VPC520jzIk+cd02MYh0lKe9uuz1fJbrG1?=
 =?us-ascii?Q?i5nuXVlQV2LaWBknqEOWurSfVzBkrbQjnI5PBTJIG3KMvFqan7U3KGh1+LUJ?=
 =?us-ascii?Q?kNm4lKXrA19iCd/0ttS9+TZtWnUexs9D4HKYY/DstvsSIVmGomOUVkUX/wEH?=
 =?us-ascii?Q?NdeLq/g/1I0UnCQrkG/vgLXizhX4spvBGwyPOdYYNaE+f0JcpvXCL7XURaQE?=
 =?us-ascii?Q?nhlP/eOdcBFXxrkMXkk7GG/CW6yWYcrxhvhmDfrKun51pvdaA1k8bSe3nfTB?=
 =?us-ascii?Q?jiApgGkl4lTPzdW2AI9rjQi0jPvQ4auG3855a7hTVKRM9f+1RxELPip/JLfD?=
 =?us-ascii?Q?OIMaHwP78O5QmxHUuOdukAYW2fdy3OAWIfHHbb5tCaKx+Njuxbc/Ftxm21gC?=
 =?us-ascii?Q?XznW+98/gPRVttqabO5NxrkOIibkFW1KhPk0CUdwxYHMKp3rH2abthQc6lqX?=
 =?us-ascii?Q?/ufoTP8xo03aPwRYsneemcd/vBSvDpZNSiPtTuce7YyKlyLLtahUjo2LzDSF?=
 =?us-ascii?Q?5ls74AsMFwf5xiz5chtC37rLHW8TvfBIN77bnjwi7OFvnBLfCHoknruvRTaP?=
 =?us-ascii?Q?pjKQftzQI72ZRVVZyma1yBH9YAn60azlMBpLgHQ/Kbm+P4UaIkXImVtJhqFK?=
 =?us-ascii?Q?9uR4EDLJzCLrQ0ltx2kDAjjfxM/XsOhxHhWuQSSK+yzIUddow4AiQoPtYmKA?=
 =?us-ascii?Q?mSFNaj+6qeEArJIMxabNBRjCMj1oh94f8SGJThyTju4zAz06Owz9fwKgcQxf?=
 =?us-ascii?Q?C17MPxbXgyxTx51P5+tCvmPVPTm3nduZr665AMWEtab2gpAHk6buTorIvknp?=
 =?us-ascii?Q?D0z369q+/d4v8wxIvGgQuw5SdGeAc+8xY2ALDZ0NGJWR0fhrY+KqBjy8i4yP?=
 =?us-ascii?Q?U2u4G7Q/xijxHyBIcfqE5FytVI2ezxJBAQLvuqaPm39DeVWHpWL2D1xAhuQg?=
 =?us-ascii?Q?qD++8w42ks8xlyZmlZskEp4Zc51lKYR7pp06XY2j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7cfc6d-a2a1-49e0-727f-08dc207ef27a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 04:01:18.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orIHmSqExT1z0E3dMU3cFG5Z/qHzjGIn8JVDGtUEi8WqywAHv1QzDXdfZMxb5OjC1dilOr0UeFxjCgVGCr2/Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8219
X-OriginatorOrg: intel.com

On 2024-01-26 at 20:15:46 +0100, Hans de Goede wrote:
> Hi,
> 
> On 1/25/24 09:22, Ashok Raj wrote:
> > From: Jithu Joseph <jithu.joseph@intel.com>
> > 
> > Missing release_firmware() due to error handling blocked any future image
> > loading.
> > 
> > Fix the return code and release_fiwmare() to release the bad image.
> > 
> > Fixes: 25a76dbb36dd ("platform/x86/intel/ifs: Validate image size")
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> Thank you for your patch/series, I've applied this patch
> (series) to my review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in the pdx86 review-hans branch once I've
> pushed my local branch there, which might take a while.
> 
> I will include this patch in my next fixes pull-req to Linus
> for the current kernel development cycle.
> 

FYR.

[ CC stable@vger.kernel.org ]
Missed CC: Stable Tag.

This (follow-up) patch is now upstream into v6.7-rc1:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=25a76dbb36dd

Looks like linux-6.7.y needs the above fixed patch too.


Best Regards,
Thanks!


> Regards,
> 
> Hans
> 
> 
> 
> 
> > ---
> >  drivers/platform/x86/intel/ifs/load.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> > index a1ee1a74fc3c..2cf3b4a8813f 100644
> > --- a/drivers/platform/x86/intel/ifs/load.c
> > +++ b/drivers/platform/x86/intel/ifs/load.c
> > @@ -399,7 +399,8 @@ int ifs_load_firmware(struct device *dev)
> >  	if (fw->size != expected_size) {
> >  		dev_err(dev, "File size mismatch (expected %u, actual %zu). Corrupted IFS image.\n",
> >  			expected_size, fw->size);
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> > +		goto release;
> >  	}
> >  
> >  	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
> 

