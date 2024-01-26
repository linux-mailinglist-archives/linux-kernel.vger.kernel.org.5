Return-Path: <linux-kernel+bounces-40148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65A83DB35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C69B23855
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF01BC50;
	Fri, 26 Jan 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyCCt858"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8281BC29
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277246; cv=fail; b=HLpEkHZOJIAUOY8sJYTHW64TQwo4j97vZHoYa3+F/Du0cIHusSg5GMgC+UZch3rzUGv2uShAj2WUMGqSTSC3Rw1ZSrxR/2QudG05KdrIoZF9e9dY6upHdnrySN26mSsdFQcQs+H7EBTs6Ir2BrHgxs6iLC2aRRnxXkuLA61qRyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277246; c=relaxed/simple;
	bh=okxoQMB8hWZRCxgNTxCCJfAaHCnPxOeo6rNnK47//1k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kcYqKFWr8mayv372+KJAs0uRIMrE1S96b1r/QS4dcamV9LG30RXa2+2uva2IC3tDP6N3l+AHV4MWsQG/+9ilmtN2oY/wqiLUr/TjmJEGuPz1cClsOaSY828M4k8suzWL3fj/EqgHtiXF3taS2lkXohgESnCGVgr19MhlKucfpbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyCCt858; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706277244; x=1737813244;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=okxoQMB8hWZRCxgNTxCCJfAaHCnPxOeo6rNnK47//1k=;
  b=iyCCt858mDtnxo/aSmyR0bzSc6YUGuOVed0R9GiT3qBm5sT651ccahKN
   UoxwaRxWZrcy64rHoyD+at6WSE6jP2OPVT4oB5aNWbV268cOV6RhbZ7CB
   5Qgpx7qq70fSoBR2R9NW/sLNdhM+TfNvZJaTw/h8b1v+7lAuvgO+0zQ15
   byvIuPNN2HW3zXlJTxBwbaNgJSX9m9a+kOVwhptErLpo8uhU2H3WR8q0H
   L9Wo4v/KNP/CYjhbmdnXgpT2tjB1MNuhP+CXSDNxLlilgbSRv1UBuWYGp
   Ftd7H5Yr5/04ZPaNnmDzvvEeu7W6GC67aXqhCMHA3Gmc7ow5pUZitH+RN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9857527"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9857527"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 05:54:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35443201"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 05:54:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 05:54:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 05:54:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 05:54:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 05:54:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFUS6Jb7N6ZXvKzLaDnuVZVE+8mugy5SRjnlbitDiKznBysaBL7J1Z1ouRTGg6c2p4VzsuHTtCunQFTAX81rMbwgdA59lZyeLNUXKFiv0EbhUtaG8jrGtNXVoR6vHv/ipQEV47G1yEZz1GLYejEvak5TyYBX98LFF5Ei0ncvFsUgrKOjmAkq+OSculImAzVJQxEas5+sg+PvhxyyWwmLmt7XMR7TIBwrj//E5we4cEwdGL5Sz50PFyy4ePefTvxLD6XFnlpkOQtawQXVSi+2o6DJNac0mp6FmYIQLox9rU39Tmkq+ZoqVF2awdPtaZTuam0bMl/MF6/5eZXPe4twBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IggXX2xgXJ+uYpdgPXi+stib/AgPMHs2QCKmc+iAHpY=;
 b=jT87Gmd/m8HUXsuKKM6teQr0gOVwBFmcq43yLplspHoG5/wRohf+1Pn//66n4rJ+Zpa69ZxMlTgCeE4ewFpPTK+NIkocxq9YdgDQD9hzRjzdZRZitfy9XqF2mPs471DQMBnkGrde69PF7JAvdKID8C4WEaVo0LU5UBfxZYOljgmfk1D0aqXus1XNYbE8QAWcoRGMdZzIZsBxgTmGkA7I/ujvxj4mXNqAmlR7oCLlFUf2WINcUmTUSj3RBrMLY6/uWnDxeeTlf4Ih/V9H9IqKi7QViK8DdkFSdDfoH73FloZS+zD03mVZ3lFzG44QfCpS+3vR9y2sHFwA5CuZStJjmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 13:53:53 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3%6]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 13:53:52 +0000
Date: Fri, 26 Jan 2024 21:45:16 +0800
From: Feng Tang <feng.tang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Waiman Long <longman@redhat.com>, Jin Wang
	<jin1.wang@intel.com>
Subject: Re: [PATCH] clocksource: Scale the max retry number of watchdog read
 according to CPU numbers
Message-ID: <ZbO3bN3WEUvejRBp@feng-clx.sh.intel.com>
References: <20240126091250.79985-1-feng.tang@intel.com>
 <3b3d9499-dc7a-4ea0-9615-526940f5fcf2@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b3d9499-dc7a-4ea0-9615-526940f5fcf2@paulmck-laptop>
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 374f8226-70b7-4570-8030-08dc1e763b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zr/HubIBtwN6GmPCj4Z02suebStOm7onBw4idn3vu6FEHkXP7pB9RMUZ1bQyGrr0xDQSXg4qE+WMNl8EtN55RjVfwBhya/Duz3vBj4LQmnRsT7V4ZMxVWmAB3Kyb4YRvcUaeSj68LI/NcrE/2BueevPqYD1hmLCt6pele0Ou0XZa6LJ3OXnYhHILihD7jBtkZNU/MgN22dE2WkDXtbmZjPJqcqqdBjVdp2j2z+x4lS+lk9K6p4St3WGwSZnCCnwcxHZnkxVlsj50X01vY9yWiQaRBG0zDAgkA6v+DpC06bcuN0/k0udoTEZoNftQh3d4wugB1t8VyD3afG58BsuAAJwPlc6sOAOP9QO/yG0nuGnfVhGpJFWgOZq40q3ysFHPAOqJHfqskNGG2VonLyb8x40adBSHdrO5FLEqQIhr4IRsMz6+qiPb8Txx8RVrSFBRHUqipCbvSsZYlhTvS6pJP/7hixXAVE6ZWwnuitqORDIoe3sWcGeBKfv17I/Dh35HaTL3tMxUAuA7pKhdd/enEH6g0E5LKs8d7wDkynJKiG3EkovnpA5mkdHcoBRNezu2n+o6Bw50gqrr7siZQ4n1YnQbWmEEYnmbheoAnhY54AbgAEpUzeXRe3KeoZ53onVK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(107886003)(6666004)(6506007)(6512007)(5660300002)(83380400001)(2906002)(44832011)(41300700001)(6486002)(4326008)(478600001)(8676002)(54906003)(8936002)(66556008)(316002)(6916009)(66476007)(66946007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TKshM4uACfrEV+vZfemLOlcph+oYBjknq7WOaMDCiVDcamcIcobZhSWK5mo8?=
 =?us-ascii?Q?l8R8wqW4h2M86p7Z4BvJLZnmXSqIGmblbgFctPW4kCFnYI4/U/WHNclNF/8J?=
 =?us-ascii?Q?N1hYgXhAvveFYbdtata+aoZOOqOWJJdE2d+gE5KXUktBxhjwafQXzmV2sPif?=
 =?us-ascii?Q?CN1wPRVjT9kmGLGPvZbd6EC53I0hl+/eOEZSo7mxAZzUiSoqgA5yLIy3WsVT?=
 =?us-ascii?Q?Ultn0p85IDHOEE0yG6KDm/v0Bg7mODeOqNut5XS8AFngKNER/ZQUoec6tfF+?=
 =?us-ascii?Q?euTZY12TL4r0X+JBHUatUX0VECSLoGu3g8u/n8407v+Z14dJIgKxEhs8pEQz?=
 =?us-ascii?Q?X/9EggUrIqfouOtrvrwS0Jn3Suc4aDXpGHeZS16tYUQ29bOKP7R1s+E4LSnw?=
 =?us-ascii?Q?/8T9+mMCvYOhlcPj7LX0XrfrxWgc2WOAOq61oFJ30r6+zmJlhHUpXRdjgunY?=
 =?us-ascii?Q?00qRJNEl/5SLDAHjpKJ58p59Zg2/jD0g/qY5l0WSyCHzDdMMK62uPSSnZGzh?=
 =?us-ascii?Q?fLhJCt59TdZEQw7862QyZJBEjsG/NcbBkYSNXH5lcbFrb5kmpsrUcNGT+7tN?=
 =?us-ascii?Q?lluGpVFCg2SBT/gReCBFRMiEuuN84mj1trsPh0zU/YsVlrT9WpAl3N5Uz+3T?=
 =?us-ascii?Q?xs6+Ns8XTfh1Ja6f0d/fob1kkq1+FnOwxHNU07n1yTTWa8rIlUMe6lB9Z3gT?=
 =?us-ascii?Q?8vOrwqaQ29XRB/vfWIlWplbNSdvUAEA2RLtd42lX8o4yR5fq8ma+3f7l1iBy?=
 =?us-ascii?Q?GsIOIKb+frRApCjaXrb8R5V2tK2b5DtpJCbLhfk2VuTD0Z4aAiWD9tUuVAmZ?=
 =?us-ascii?Q?BMvTcGcNTjN2o1547+PB31BZgeclLCIt7W2Y196J9OjYBSP86LxWsib9Gaef?=
 =?us-ascii?Q?jrxt52SDao6cZ2Nc8OAVmHdmkJcqOiM2YYwLC8X014ChR00rleL5sDYAS05O?=
 =?us-ascii?Q?dZJQXAU3zTB41w41m2vz0+MrMtMqeotUe/qrelICfscAu+wRhJ2XhYJBPrfS?=
 =?us-ascii?Q?A97wZHxuSo+eF0ptg6en2dd7AjVeryL9q30LoefeWUBgFNwrgUUrBgC7hLKF?=
 =?us-ascii?Q?LbdaG6/LSSps3hDSNQSfjJm9hfRsCuVtWQZL92mfyRZYieeWwuTUUkkO2WlD?=
 =?us-ascii?Q?vbfqosxJHXcq6C93O0tAgzSQghm32Gc0eznqWfXzmlmdzTU15V9UmhgGqeCu?=
 =?us-ascii?Q?K+KP9i3j98TeYOh1bLL2Hed0viYHbyHXxjdk7K2QaLsYRnQC6MjNtClW+vnu?=
 =?us-ascii?Q?jyotWKZLPksp81f5WQnL7n2m9YnnZynlwlRUASAX73Z2CMqgQB3VXf9DyKKt?=
 =?us-ascii?Q?JTNFREFsLrO/m90pqnzvmz5GdvtDc6ma14QIR/gbUmRSz1eAhrqtJDCEVW1s?=
 =?us-ascii?Q?dyZXLN84B+LLzIS+ZXZTlqoyOm1ZdM6ctEg5H5yDhSZGeN8o1M2jGku/dSM4?=
 =?us-ascii?Q?XC8fHir1TuYDxh6ypQNuFb/29A4GxAWH3fADClbINCJ3cj9yUrEjcNoHtNpD?=
 =?us-ascii?Q?JHUtabwrUwuLMYDNHWFkWMcKN/aZiSHy4SgTLKFpwk6o12fK0Y3/xH/R/1lc?=
 =?us-ascii?Q?ULOKjnJzmX6n5y7x2R4saIkJxXmcUjsnycQp79Lv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 374f8226-70b7-4570-8030-08dc1e763b2e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 13:53:52.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gjb0xwYiDeEENUKgwxXQv8ukUEDaHHjlgYaZNoDXezyJAIQgT2k8P1402YthDmiNVptq81VFg0Yl9yckV++UQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6725
X-OriginatorOrg: intel.com

Hi Paul,

On Fri, Jan 26, 2024 at 04:27:19AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 26, 2024 at 05:12:50PM +0800, Feng Tang wrote:
> > There was a bug on one 8-socket server that the TSC is wrongly marked as
> > 'unstable' and disabled during boot time. (reproduce rate is every 120
> > rounds of reboot tests), with log:
> > 
> >     clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
> >     wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
> >     tsc: Marking TSC unstable due to clocksource watchdog
> >     TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> >     sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
> >     clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
> >     clocksource: Switched to clocksource hpet
> > 
> > The reason is for platform with lots of CPU, there are sporadic big or huge
> > read latency of read watchog/clocksource during boot or when system is under
> > stress work load, and the frequency and maximum value of the latency goes up
> > with the increasing of CPU numbers. Current code already has logic to detect
> > and filter such high latency case by reading 3 times of watchdog, and check
> > the 2 deltas. Due to the randomness of the latency, there is a low possibility
> > situation that the first delta (latency) is big, but the second delta is small
> > and looks valid, which can escape from the check, and there is a
> > 'max_cswd_read_retries' for retrying that check covering this case, whose
> > default value is only 2 and may be not enough for machines with huge number
> > of CPUs.
> > 
> > So scale and enlarge the max retry number according to CPU number to better
> > filter those latency noise on large system, which has been verified fine in
> > 4 days and 670 rounds of reboot test on the 8-socket machine.
> > 
> > Tested-by: Jin Wang <jin1.wang@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  kernel/time/clocksource.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index c108ed8a9804..f15283101906 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -226,6 +226,15 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> >  	u64 wd_end, wd_end2, wd_delta;
> >  	int64_t wd_delay, wd_seq_delay;
> >  
> > +	/*
> > +	 * If no user changes the default value, scale the retry threshold
> > +	 * according to CPU numbers. As per test, the more CPU a platform has,
> > +	 * the bigger read latency is found during boot time or under stress
> > +	 * work load. Increase the try nubmer to reduce false alarms.
> > + 	 */
> > +	if (max_cswd_read_retries == 2)
> 
> I like the self-adjusting behavior!

Thanks!
 
> But why not make max_cswd_read_retries be a long (instead of a ulong)
> defaulting to -1.  Then when someone sets it to a specific positive
> value, they get exactly that value, while leaving it -1 gets the default
> CPU-scaling behavior.  Zero and other negative values should get a
> warning in order to reserve the for possible future use.

Good suggestions!

> I also suggest doing the adjustment at boot time, for example, using
> an early_initcall().  That way the test code also sees the scaled value.

I also thought about doing the adjustment once in early boot phase
using num_possible_cpus(), but gave up as that parameters could be
changed runtime using sysfs's module parameter interface, and cpu
runtime hotplugging.

Since the watchdog timer only happens (if not skipped) every 500 ms,
how about doing the ilog2 math everytime, like below:

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b17327..9104bdecf34e 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -291,7 +291,7 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-extern ulong max_cswd_read_retries;
+extern long max_cswd_read_retries;
 void clocksource_verify_percpu(struct clocksource *cs);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..867bb36e6dad 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -208,8 +208,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-ulong max_cswd_read_retries = 2;
-module_param(max_cswd_read_retries, ulong, 0644);
+long max_cswd_read_retries = -1;
+module_param(max_cswd_read_retries, long, 0644);
 EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
@@ -225,8 +225,17 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 	unsigned int nretries;
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	long max_retries = max_cswd_read_retries;
+	
+	if (max_cswd_read_retries <= 0) {
+		if (max_cswd_read_retries != -1)
+			pr_warn_once("max_cswd_read_retries has been set a invalid number: %d\n",
+				max_cswd_read_retries);
 
-	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+		max_retries = ilog2(num_online_cpus()) + 1;
+	} 		
+
+	for (nretries = 0; nretries <= max_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -238,7 +247,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_cswd_read_retries) {
+			if (nretries > 1 || nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}

Thanks,
Feng

