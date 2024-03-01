Return-Path: <linux-kernel+bounces-87971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3286DBA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419C11C234CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B2967E9A;
	Fri,  1 Mar 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2v5xtpD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69767E7A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275625; cv=fail; b=syHmlRLALTfhfu2eGPRyibnjtLInXc/9lkPHVXotpBbDTclpweRjSLysU7Hhy0dh1/9c88G/6qkcppGJcEEzR1uNGsIHDbsyoelbqr3Sn0L5Rngy8F8hEnygJ6DjrU4zENkEv6aGmRTOGAjXDsToFHWogR/fqq+iSrtOb4y1KMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275625; c=relaxed/simple;
	bh=9jKDQsupXInzWwqK89Pxi+yKA5EGqjGdx/ogZBJUczc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eRc3g/2FlQQxA3AlzHRCMBoOYfCwE2EwJ6sAUaS4A0/YJChAQd2Fedwd98PC3kMvvdznB+hozlphtt/snfvcgOrNYXVAhg2ZrQY0O9jGnqIDpkSftbRz7Fam8YRiwyN4H5WhqEfkQyBtkkZZiwfrwsuZ1NrPrnxZ88wpymqCFAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2v5xtpD; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709275623; x=1740811623;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9jKDQsupXInzWwqK89Pxi+yKA5EGqjGdx/ogZBJUczc=;
  b=J2v5xtpDxd4jmG5cTEA0WxK/8/03x8lcqIVl4sS+a9eC9HEVYNpH0M0C
   n8Nn0V28Pf0uFphS+flrRLetRa3Q1OD0b5GEto2HhBwVyHFBykBHinrFY
   fLaKMTCjhOi+/Ut1SPjfUC7m5pUWRAtKvc8tyNlDbnslL4B1+Hifk6fk9
   qzS0a2sPhgwI/O43vzLz5bcFZQ9nWEovcGQo6lOgRZRONXjt/lbRuqx/h
   kuPLtzSDpnmlEuHJU2DHyMzIJlkjpc1H9E7MpcKqFcG6Zw1QHWbFW0J5g
   45uAqr+gHwfqQrWuFCYGJIkuM1MMsSSH3Z9cQ65z6eYN6po8HmHf2CLir
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3652717"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3652717"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 22:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8501312"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 22:47:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 22:47:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 22:47:01 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 22:47:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJFNIRUvNIqygVW0UsJTtGsz/TZu4z7SWshjAGTRSmIPupe7gdqhlWurfz9NI6gcJGsl+UdzF3Pgvo5UP5eMU5ZBV4xCrpjbivZg80495s3CxOkzL9RomsyB7ugmSk3thd/74ZKi41OpM4/3r7PlcTqBMDgi2Ug2OcKPVy58+Upa5Wt3pSont+Ko2kXtgiLd62egkfghRrGAT18AHZozEHugWk4xN58CP5HfkTpKH1jyrettSG1v3t40VprMgte6oGWDgVupskaRsdbK/XO4R8+xIUdHGcBcW6W4v1WsSYzuVxEerpZYQEa183wO7JyOE1TdYkT8qCMy2X99/paV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S30vdhVL6J8ripZrTKZdUr8v3q2puQJPW2u3g1MHk90=;
 b=DS9qnzSmpAArsgpaTZdYPDIRC6uuY0n5BAz0F6dzIL8ET3sFywPEgJ0g8GRyV4n7q6sJDpRgGLsptbFNW7w/fxjFY7AB8iBi04/ia0es2vrMHFvjgVBeUALgaGzufA0wepSZ7g/RcCGPc+GCnh8b1Ede8Keb3UEl6hiVTXraMrFuraoCm4iFdt6ttKYwcOAiBv6d/a4cjblFUNCzm4vrOq/g7B1/zfgPUghMystIXRIvXI8qGmT6RVq9hg97sKeFYT8Lu31Ef3fnpxGdpCqh/g+Fe/oh8zUd4Mz3di4MJTGMRbA6/CUA1W6DEOo7dADfEbQeRgriHetYt6We+h0ELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.25; Fri, 1 Mar 2024 06:46:58 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889%4]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 06:46:58 +0000
Date: Fri, 1 Mar 2024 14:46:46 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>, Tim Chen
	<tim.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>, Honglei Wang
	<wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZeF51sKRWaHMJIZ2@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20n0xbx94w@mail.gmail.com>
 <Zd9QRBaWVgmZ5Df8@chenyu5-mobl2>
 <CAB8ipk9NFXrPM3jMi7U9hWNy-gSiqSWuUu_tBXs0Xgb3R66S_Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9NFXrPM3jMi7U9hWNy-gSiqSWuUu_tBXs0Xgb3R66S_Q@mail.gmail.com>
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY5PR11MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 574b8b59-8783-4d09-af38-08dc39bb6452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bK3MX0NEr+ivNDQI9Ndpo3s9fmZK8fWhGIYK+2EtrqhOSHKnYF8Ww36BvCl6JIAJEjggVcy4vHMcZObJA3g1W7DJ9abTHDSasH1tfavZ2IlMZ66nGaJLYjHFRXw/HLQHf/pu9Rr1tWnxh+TC+P8yMIHggIWmhKG1VSSt+t7xBllgXfhPEjXQF3mStLVgipbzwQFEUNyt7+lFnhKdSZsAko4Oe/RTTISwgBWSZgFCkXh9sEEe3Ub+0ooVeWJq3yujkjf9CaiQIdU6rKmGtJy6a1eN0lsjnOT3YRmv/lLsgYwPrDWXe2BvIiju2KDTyiYNIw1qruPhIG4d89MCor3GLFeP+446rnSYFZlFa/AH3RvsRToeLmsHHAeB4Kq79DjSlEkmPKIXf+1aq778gazLrJFBVxaeyeSdknqdLyYoePVWYIG24RVPc3mZ1WLs6M9oROsoDLs4LOW8unEgUY0AhaPVw2OiozTlopYyny+tyVlppsUKzzfR09nYMHmY7bnJP//13AvBqWfl0r4CWSlg1EYLV+3RyDbPNFYsNtKt+xI9q7ydXP6dfphY3EZEpaIZjnEy1YQdvaKbmpXAncXvTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpXVy9EK0VUMlVGMm16Rkp4bkNkSU9MbEs4UldYSzk5aW9RUFlaTlpXcVVW?=
 =?utf-8?B?WnVTSUEzOFhCSVpGVHQ0eEs3RjlFa2tJMXFpWnpib0Ixb1p2U1RFUnRPM01Z?=
 =?utf-8?B?VWtFdTBLWVgybGJiTnZRV1V3WGhoYks5a0ZpMGQvWlYyQy9HblJ4RjVBUXVt?=
 =?utf-8?B?K1RTcEFFZVJxLzUxZnFCMVZjSDl3ajU3LzZWZnN5TklNM1FGUU82WTV2WjNN?=
 =?utf-8?B?TzF1R3FEM1RyMlRoN0U4MFpmUmhuTHVZVGErVGxLSDEwcC9EZDNiRWkyaEhG?=
 =?utf-8?B?T21SRlA1NzJnL0E3aTZwSGloTTZ2eFkxbWJURkxMVWxlM3d6TTNxb2h3bGJv?=
 =?utf-8?B?cms5ZGpNSVRKVjBuZGZJRWhIajkyN1REU1YzL01UaTRBOUZmV28vUXJ5V0Vr?=
 =?utf-8?B?TWF2TENVcitKa2ZXRzhORXovMW1JeG45bVB3Ky9SdTUvWkw1dTZJeGNzSWgz?=
 =?utf-8?B?WVJnTkx2YWVnRzhscEs1Y1hLRXhyMXdBeGZ3VS84L2dqaFRCQ2ZBbXVpQ3pm?=
 =?utf-8?B?aVhKN3NkQlRSdXRwWUt1dFJTSS9xeXI3cjVCd1dYcEp2YVNtWVQrcVZuYlAv?=
 =?utf-8?B?dWtldTJ5Ri9sTStab1R0VDRBOElKUndzajRYK0NaMm9BMmVqWk5WWkUybVRu?=
 =?utf-8?B?dVpxWHVYTzZpaUcvUFo2REhOWEhxYk9SWE1rdHY5Mm83S05LWVk3Q0JQM1ZC?=
 =?utf-8?B?dXRoK2RWanZQWGZYL1VjMk1XRnhzS1QrOHYvNjFGdGJkako1T1ZOWWpKczZG?=
 =?utf-8?B?dEdERjZmUVFHb2ZBR1hSa3pUNUZVY0FTbmhrQk56Z2tpaVF1QjB6bTFhcDRa?=
 =?utf-8?B?ck9tSEF6Z1VXRzRkMEhyQm40YmFvL2FFVFh3Mm5pRHlxaXNPcG5reHNUMTNu?=
 =?utf-8?B?VEZ3ZVFjVGdKVTMzRUVaVndHUnJ3TllBTXdrT2ZLSVBqdE9FRnRQNUg4a1E4?=
 =?utf-8?B?NXVjN2RZQ214ZTJhUFpaTW96bWRxbnZlYjZvR09NbEhtem5ZS3c5d2MxUk5B?=
 =?utf-8?B?WHFkQi9uaFIxRzJlNmpFZGNWN3hudHRjbEFVZnRYckJ3eE03VUp1YllZM3Bs?=
 =?utf-8?B?d3FmcGJZenRvNjBoaDgwSldWNDFQb1cwYk1ObkViejRUb0U3OUpzaHdFUlVH?=
 =?utf-8?B?aFBhVVZCcTAwdVFlaVp6eHRLRE1jdGVwWDBmeFUxeXNqQVIyQ01QNDVUTzVs?=
 =?utf-8?B?dlh2V3Z6MW5nNVJYMDVwTUUrbW5YVHdHVUNVQ1U2MnFZTGFEVExDZlRlaVcv?=
 =?utf-8?B?TWtueitjWDQrNWh0QW1MT0tiM284Ym8rd0xiZFg3NTcrdVp6UlpLamxXdnFM?=
 =?utf-8?B?Mmh1MkNqRGxrM2xvR0tlREswRHduZlVLMkl0Rmpid3Fkd1AvM0F2S3hCcmVZ?=
 =?utf-8?B?UmtEVU5HOC81cDRKR2RxMFJILzUwVGo1eVhzWVhvNExKTG5GTWc4THA1M1lq?=
 =?utf-8?B?dHN4NXNTWmdaRSs2dmpPWTlnN1dQaTAyZnBFeFNWYjVUWUZGeHZEUVFJODRV?=
 =?utf-8?B?TTFPcWNMUUNNSFlveVAxdStYTldIQVVPdi9tRVNuQ0dTTWtqeThEeHZpVVl6?=
 =?utf-8?B?UWtjTXZqZnl6cDR2d0FLakNoL3JEUzQ4KzgyM1BtUGRBTXg1ejQ0WFFDVHFD?=
 =?utf-8?B?NXloUm5lREFjMGkzTGpWOVV5OHRKQ1cyL2c4M1Q3ZDhjOHcrSTF4dkxuOW01?=
 =?utf-8?B?VW9sQ3lGR1l3Ty9sd1ZsNm1yTG9BcVE4akVZRE9LdGN0SGdxeEFnMUJ6eFJs?=
 =?utf-8?B?amg2Y05YcTBMc0ZORlVaYUxGV28vM2NjZWVscjU2ei9CaTJJcW03NXZkSlNC?=
 =?utf-8?B?cFE2OXZFeVZYK0hidEZFZi9DakoxYm13RWVjUTIzVEZjTWc5YnhKZzZ5NVBa?=
 =?utf-8?B?Z2w1RkZUV1l1U1JkN0JQMTZSK21sYlJPWThXU1BCVjh6c0ZrT3k4NTNZRXZ1?=
 =?utf-8?B?K21KV2JqWi9LSW5GcnJMcGxlUkVPUjJONERDbWhzbzVnY0d4NFJXZi9LcldW?=
 =?utf-8?B?TWNsZTFHWXRVSzBoNXE0bnJnd0VWaVBNTzgzNVFXNTd3OUcxdjNVNkNjemhm?=
 =?utf-8?B?dm5IaUNMRlRPNVNsVHRvVTJZRE5YK3pCeVBxSkZvK0svajNLRjB4U2I2enBv?=
 =?utf-8?Q?ZL/+dTqn0B7lBf4aRI5dS539y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 574b8b59-8783-4d09-af38-08dc39bb6452
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 06:46:58.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Oiy8bbmcRihYg9wF4qA/kpnV3Kog+gvkcN+uluQ+iSWsAlG1X0enuElejBPgtR7MiUmxPLmhGuOyLpudWB0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-OriginatorOrg: intel.com

On 2024-02-29 at 20:10:32 +0800, Xuewen Yan wrote:
> Hi Yu
> 
> On Wed, Feb 28, 2024 at 11:25 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Hi Xuewen,
> >
> > On 2024-02-28 at 17:04:49 +0800, Xuewen Yan wrote:
> > > Hi Yu
> > >
> > > On Mon, Feb 26, 2024 at 4:26 PM Chen Yu <yu.c.chen@intel.com> wrote:
> > > >
> > > > There is occasional report from lkp that the kernel hits the NULL pointer
> > > > exception:
> > > >
> > > > [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
> > > > [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> > > > [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> > > > [  512.082337][ T8305] *pde = 00000000
> > > > [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> > > > [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W
> > > > [  512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> > > >
> > > > This is caused by NULL candidate returned by pick_eevdf() as Abel analyzed.
> > > > After
> > > > commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
> > > > the NULL candidate would trigger the NULL pointer exception. While before
> > > > this commit, there would be warning.
> > > >
> > > > This NULL entity issue was always there before above commit. With debug
> > > > patch to print the cfs_rq and all the entities in the tree, we have the
> > > > information when the issue was reproduced:
> > > >
> > > > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 min_vruntime:763383370431
> > > > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
> > > >                         min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
> > > > [  514.536772][ T8390] Traverse rb-tree from left to right
> > > > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
> > > > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > > > [  514.538539][ T8390] Traverse rb-tree from topdown
> > > > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
> > > > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > > > [  514.540340][ T8390] Found best:0x0
> > > > [  514.540613][ T8390] BUG: kernel NULL pointer dereference, address: 00000074
> > > >
> > > > We can see that non of the entities in the tree are eligible, neither is
> > > > the current entity on this cfs_rq. As a result, curr is set to NULL:
> > > > if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > > >         curr = NULL;
> > > >
> > > > and the best is set to NULL, which caused the problem:
> > > > if (!best || (curr && entity_before(curr, best)))
> > > >         best = curr;
> > > >
> > > > The cause is that, the curr is eligible, but vruntime_eligible()
> > > > returns false. And the false negative is due to the following
> > > > code in vruntime_eligible():
> > > >
> > > > return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
> > > >
> > > > According to the log, vruntime is 18435852013561943404, the
> > > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > > > thus:
> > > > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> > > >     delta * 2677 = 7733399554989275921
> > > > that is to say, the multiply result overflow the s64, which turns the
> > > > negative value into a positive value, thus eligible check fails.
> > > >
> > > > So where is this insane huge vruntime 18435852013561943404 coming from?
> > > > My guess is that, it is because the initial value of cfs_rq->min_vruntime
> > > > is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this case)
> > > > seldom scheduled in, its vruntime might not move forward too much and
> > > > remain its original value by previous place_entity().
> > >
> > > Could you please test the follow patch:
> > >
> > > https://lore.kernel.org/all/20240130080643.1828-1-xuewen.yan@unisoc.com/
> > >
> > > Because the se->vruntime would be changed in place_entity() and
> > > reweight_eevdf(),
> > > however, now the vlag may exceed eevdf's limit in some scenarios, it may cause
> > > the vrunitme's error.
> > >
> >
> > Thanks for providing this fix. I took a quick look at your patch, and it looks
> > reasonable to me. I'm not quite sure if the vlag issue is the root cause of
> > this NULL candidate problem, say, if the abnormal vlag happens, it should satisfy:
> > curr->vlag == curr->deadline ?
> 
> Actually, this is just a situation, because in set_next_entity(), it
> would set the valg be equal to deadline, and if using the vlag to
> update the vruntime, the vruntime is most likely wrong.

Yes, the child with wrong vlag might bring potential risk after child been place_entity().

> However, even if vlag is normal, after the calc: ((W + w_i)*vl'_i / W)
> or (w/w'), it may also be an out-of-bounds value.
> For example: if change the nice from -20(weight:88761) to
> 19(weight:15), its vlag would be 88761/15=5917*vlag.
>

Yes, this might exceed the limit range of vlag, 

> >
> > According to the data,
> > curr->deadline =
> > cfs_rq->min_vruntime = 763383370431
> > cfs_rq->avg_vruntime = 386638640128
> > entity_key = -10892823530978643
> > avg = -6851585614346926319
> > load = 2677
> > so avg_vruntime() = 18444185410266494357
> > curr->vlag = 8333396704550953
> > which does not equal to curr->deadline = 18435852013562231446
> >
> > Anyway, if we want to root cause why vruntime is behind cfs_rq->min_vruntime so
> > much, we can add more debug code to further investigation. And we will also leverage
> > lkp to test your vlag fix patch set.
> 
> Yes, maybe you can see more information by adding log in place_entity().
>

Sure, let me think about that.

thanks,
Chenyu 

