Return-Path: <linux-kernel+bounces-127262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF98948E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A471C23510
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F42AD2F0;
	Tue,  2 Apr 2024 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQtacPeP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D7945A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022406; cv=fail; b=NWuGUZs18x8/j19WLs4aX3zxE3L12+0rE664thZQICQW7rROm5w6YRK0mvmmCdyzBghhzyRx8SQrGohGPYMRCr8Wmwl+voKXdILr/h5XIX/syccJ1Vv97GYYJ1Y4MjGUQBkTABrbqyVpE+2JGL7lFRnL5FbHEuTASx85OaMtD1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022406; c=relaxed/simple;
	bh=RdA8vNDqVpAygHWX4hNBNI+NpuWUdFL7Pj7+ezuf78k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XU1UzhC5LQQ9ah7pLQ2f80Sqpa5dGvwzxnEg26kLtbtterokczfzdOsuwcWvrB9/hBsQ61z5suQzzIYM49uKUusIbnLp0LsCnlDC3eMq92W0IkRoP4szRDRGRwT1otNTzY6xoyMM2EkBnZpPtzLJg2fuTHkEZrOPMRnkde/rcms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQtacPeP; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712022405; x=1743558405;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RdA8vNDqVpAygHWX4hNBNI+NpuWUdFL7Pj7+ezuf78k=;
  b=iQtacPePXINW27VvtS6xJsLY+CnCIzNpwpE6rnZNRdVO+ZwdatLlwN02
   mU2pPTo6t1tAQgQZx/CieI3kmElS8LpokWVaGR7dYu4La+bHsRq2zC8/c
   jg7smeafDPEGAgLlAbGLlkBKtI7gyq2vF9Wi9z+SZr5NKqa2lHtX3djFv
   r3gPPkdJTmBwIc0vqu9jLDstj1hSx0p5mKFiFhHdxQGZ3BcAeWQ96c8jK
   iTOFx8x+1kVTp7jJ0TOMMvXkw79ZIewtie0phObGebjWmYAxmraw0EvZ1
   XtsZ4SOKJ0n99D1zP74JXzV/tEP40XzzCZtI96dzLqIWYmB+VattToYAS
   Q==;
X-CSE-ConnectionGUID: uRSfmuqMT3inw6xLwxypQg==
X-CSE-MsgGUID: T5qM/pLqTDuNXtvC8ObHTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7288071"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7288071"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 18:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22561270"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 18:46:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 18:46:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 18:46:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 18:46:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 18:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMjOuy8FC7cFX/EyYdr8Cc0lN/8kdnk/d3TaeDZIyArmeYrqkTcBJk29ce/ABswC9faScxHSkrWlU42td2O3CdmzSLydAGPxxdBvnJnKb/VIrx4SW9nxUJSgGKQFRrtmOG4vRv5T0uy//CBZQn02Ea9n3CS9UZbUFbCYwpnWIn18GvbKxFUeYoo+3EB28FKJgqc7kyLXbWQHhukwXbxUFU/Djhlf4x45VPx14g15wWPO3y+e+WkYChZG5Fn1OyUKmSKSZdd0fkaApG+G0RaT4JTA9zwDACrsL+6XOK6ZAKXzd475R4GukzIorxvwdj/mgRCsMct8U6W1dRgs3a7IzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoCtxxNheEAPkc4CLLKZFpavpbjB9I4RRqdfytknCSE=;
 b=hYxbCUeZw7+40xJ0QRXx/o/Y83xZ/JbizbmypdyfspSTJi+QpzP30TdBw18FqbDUX8URdaZ6zyCntnn9wWlpE69c6j+LrsR7HnoyqNOvElgBRsQjgo1hMUF/gN/DyFFaRVUDVHQhp3MeaUk3RBG12utjjOaE8PaCoTeEgk7Yk64zGQtO2wkSVa7tf8I+p9bN1GuKlHmG3dX5F6m6GPkC7JfN1PJ8Ghqw8a4h5qa5VkYzgkkSj1yEpuuzhMQn2D0RphyxEZc3JhkeuU4HFJnorI6qUEKXviBByzsB6PnDEMniD9vGMZ2qWM8TVEdnb5PvRHIgee76Jo+RGKeRy2cvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 2 Apr
 2024 01:46:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 01:46:37 +0000
Date: Tue, 2 Apr 2024 09:46:29 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: Anna-Maria Behnsen <anna-maria@linutronix.de>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [timers]  7ee9887703:
 stress-ng.uprobe.ops_per_sec -17.1% regression
Message-ID: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020>
References: <202403271623.f0b40181-oliver.sang@intel.com>
 <Zgs5NxoUUoGIkuQO@pavilion.home>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zgs5NxoUUoGIkuQO@pavilion.home>
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7424:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gSi2cbwzic9i3RUQyn7WKd1um3mvonki3xwFSqmjVrwnWu+M/vQNvE8gLRbBshKrNC7BNJSq186+ohGHMQLXZVHgUkqThVkb80R3rD4bDDcm8iOIkii9EHfwDR+v5JziB3IB89qbsOBeuVJukra5DsJbY/KgfoOnbSk0dcAhM6346fzEN0c3dV3TpzhVdD23QpOZnpovZXaMKcGyP4s0exL8MwsO0kDeMDU0XgT+uG0ho1VDu3+coPaxeGp6I2Bk+Ie43SzWkHqIfGaQ2WaRr/Eb+KUKwxwUxQ2clsjNqq3pvPoTDMLDyLoqex/Yph3MVppNU+gq4z4LjQoXTPJwpcehrblX2NMCBkssfbnX2LCf4fA8bZtm4J9TP3bdJq8gJyt0LcVOiArCb9NgMDMcQZU3NL2SkUibajYyY/XBUQZTPOMyOUPVBFahOokdDjU82IgguEvDp9Vg0xdcMm+K6CKNarh45YrfiEF5hjJbmDoZewf/Wl4q7M4bPH77owEkXoeXyL0gY7JcxK1ZbSCB7KpfDYyORK+jueROolPVgDW/f7CeDbJjvcon4LAXMgkAIOE4INE34tv6d1vOa3AkljfMWMAifZmNkifix270KQ97OR52rQhnLVAXsVYvwr/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZD1cTNgpdbC7RroAaWiFIG9D7J8ScgOywOyCaVXccS59+9+BdVybQGK0z6?=
 =?iso-8859-1?Q?UkcZ4AUPn2HObv2OGGO6Q0V+d0pZb1+rYyZYEphJD7Q+7u3CH+vnfatD99?=
 =?iso-8859-1?Q?RTPDkEcFm0ntM9IICv2nsupaTZtEOO1eFwkYxXPN3jRmdA1Bc3q4lVIUXl?=
 =?iso-8859-1?Q?tfjr6PG88zEH1wSd0g9zZputaSPz4/n6NbUd4pdcC1w90tky81gFKPHtiy?=
 =?iso-8859-1?Q?/MN6axcZ2JnLYRxElpAPmzgxajCruuU7QlXJuJBCllKiZ8z1cTNHWn1fre?=
 =?iso-8859-1?Q?1nPTG1Ex+EfcykziIgq2cIw8O+dYVFC0XmsaTyaOmsi1vH/by7v7bsJ4T5?=
 =?iso-8859-1?Q?tYx2bVoxIuOdH0JB40hQmQklu+jklnLvfsOHF8uknILHC0siS65VrXSqg3?=
 =?iso-8859-1?Q?GPCctPYfClHEnCz5BJy8K8c00CjaGq53XOQEhmHDopIWHyjBs/Bx6yLWnA?=
 =?iso-8859-1?Q?6Qiht83ilMOiG4bpvgnSU+cuAMFHCX97RePaOUHzeUMC7Qy0y3bq3Junw0?=
 =?iso-8859-1?Q?u3s6eLvcazfgDsoiVNT3V/sNf/+xWpK4+/6owVUugLZq8+14T76tK4i/e3?=
 =?iso-8859-1?Q?gJ4UiLPrzz/7HAuN5sax/xsGTmxT2xfygCVuZiCJG/ayfLU9nWc+1MYkXQ?=
 =?iso-8859-1?Q?OyqG7aJljbyn258lzu4pTUi/2Ku9YzFQsKYm/FEIOWocEweb24ByCEbwnw?=
 =?iso-8859-1?Q?n5HspCwhZwS7wOfuVLxRUbMolWmbeO9IuuO8iPd5uqlgRey/V0bN5qQg0E?=
 =?iso-8859-1?Q?qAI/VENv6E6Zo0zxXboTO34IkXacodWuqejvDRG2oJ+1+bSz07RansWdB9?=
 =?iso-8859-1?Q?UHCaZ/DzmEjos0RZzAC0Qml6zDEHrtfHDIqtgiFhp97KY1KGwZ6/OhEeAt?=
 =?iso-8859-1?Q?cdANIGeQTcxkift5D/it+8Lbfji2J+nyxfTcG73DB/b5o4dgZ0iIiV2kEl?=
 =?iso-8859-1?Q?jYXVyVYm5FV5hAXdH/PwlG3ecV+bsXk8qoL9qJYGEKQb6Dy856QRq3P6+L?=
 =?iso-8859-1?Q?ixdeN+5TAnjoZTtqczbNN9rARfHbPQLIRAuYbpKxU6IynkJ+jffrwPPNFy?=
 =?iso-8859-1?Q?Dw/CFgsNZyJYQSZ/nqKLrUWmjAAv18iOUTPGFGc0Qmrl+Lu+y0dzjWAtto?=
 =?iso-8859-1?Q?ZQNOhodsaeZGMQ4LfdLEqd0sUhm+fN8P1OLLUXiTZweDz16zJpWEudBsC3?=
 =?iso-8859-1?Q?15DS8MslBBQruJIfjNJbwUtr23JLr8o6kdlt7VCe/hUIr3ywP8Knby8HPZ?=
 =?iso-8859-1?Q?T0kcQep0jRVGwH1VedaP3bj8OyHvuOOhkgQkQbkmpgzCOEg+3qy8ncDlFJ?=
 =?iso-8859-1?Q?WNSGEPnfuGFJQGSQwa9UBG0UIQLDhHKKXPtBHnibulDuiThen4nReugK6Y?=
 =?iso-8859-1?Q?npx2JMAH8kgVODIZhqEEtf3BRRZEx0nPmPWCYab21y8xrXJJdCJgJ0wFzw?=
 =?iso-8859-1?Q?s3PXa+X5F4iglC5vF7MUAA1EQjkpRIPdZ5z4qOAZf1s3HyQIf8WOBjRsQ4?=
 =?iso-8859-1?Q?6GNMkFWeBJPWmYMwf2dkFUmRqjDy6CU+fjDqVJqTWIpto+oLFYxoh5nTxJ?=
 =?iso-8859-1?Q?toPASEtRfNFfkao9DJdcqbWQjiqQJgG2iIy3InE2SHuSzXq6zGEGeLVD0u?=
 =?iso-8859-1?Q?zmH1sVQsQ3hnCfFRohlH4ap4gzUvByB92j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f7e035-166a-4831-6008-08dc52b6bc47
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 01:46:37.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1/yL/l+3yQJ5kekIv2LwRWqA4tBhce0AH1Yzn2vXZzhKoBlRIFSO5wZiX3bGlB/HTCluWnLDrtKjlvwXlt1cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com

hi, Frederic Weisbecker,

On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
> Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a écrit :
> > 
> > 
> > Hello,
> > 
> > 
> > we reported
> > "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.2% regression"
> > in
> > https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/
> > 
> > now we noticed this commit is in mainline and we captured further results.
> > 
> > still include netperf results for complete. below details FYI.
> > 
> > 
> > kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops_per_sec
> > on:
> 
> The good news is that I can reproduce.
> It has made me spot something already:
> 
>    https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c37a943fdbcbadf0332cf9c32c350c74c403b0
> 
> But that's not enough to fix the regression. Investigation continues...

Thanks a lot for information! if you want us test any patch, please let us know.

> 
> Thanks.

