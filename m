Return-Path: <linux-kernel+bounces-87781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C591386D8F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B54D284D49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241262C68F;
	Fri,  1 Mar 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnU8rsTA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9C2B9D9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257054; cv=fail; b=P/cqGSEjKDaqnbNf4NeJH2XmBlqTv860QGNDZDJiMhp3c8pz3F7KbyRYE+TonTx/uSe8iXNiHJgFSYWM1pMKHGjrdsUQ1OmFFGqegdoqAiWoCO7VK88cz7jybz+X0VPV/38RX+zMf8cBnnqeomDqzFoBEtdM689DyB/BINIKnY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257054; c=relaxed/simple;
	bh=dUvQ/nx1LwiWLRn8Vk2Tj8CEIggvBqNDJ1zwfVCMkAs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BAxUn3uTnAhPK5E38Hj0kSz8yuIIr0gJFCjCKh2e3NkJoicUZJ2wVM04Z28cctLLDycK24wkTdbxy73QOt4+VIFWy/0vA4mCtAdVfNm96V0QlGCoopYlwqa1lH8PJ1E1pNrImNiXnEeaAu4blDrrorOYQMztgWY4OTqyuGoWFL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnU8rsTA; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709257052; x=1740793052;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dUvQ/nx1LwiWLRn8Vk2Tj8CEIggvBqNDJ1zwfVCMkAs=;
  b=KnU8rsTAIdAOLDmGZ1hmQyDlRWMXRi7pQZQfxYjX3zLqc5G2w1ooSPK5
   /EvJqGHD/CNDt6b5LiqxzI1w/pyLmQap1Kz2a6NlhRyKFxiq21cYEzAfO
   QUlqvV4PeR+MDeKAmzp5JEvAeZan0ZH+aY6dyql2rulB3StGhhmE7FxY5
   yWITWgAdSt38dzo/mrYHEfhSC40ydTr33Ni8N7+5Se/UHKHQlkjND8zx4
   zI/jngOjhYdnIccfd/kAf18KMOelOEfG8ewZT6nCzNwVamNXRaLK7qZsk
   256A8vSPYTUogMhsv/oUdJ1kQRj/1UCk0V+jLD2WMHCaX9WLvXGuUMOx4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3640398"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3640398"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 17:37:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8159010"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 17:37:32 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 17:37:31 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 17:37:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 17:37:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 17:37:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMKEasvCSC1IJ07vIVtx0Bb9lOwUCTMwaG1RFvXkeCwWhXgHfpv8pQGuU4k3jolPk3FKJFosV2ugX/Tbh+9FMDKIIGUJQhaIU2llmsBDA4gh/IjRRwBrCWYT4W1EUu71V43Y3OyIfM+a9miPpZFc7iETSQkC/8XLJcn/b78p5IFgl9WH4WROF2ZbaHpRcO1CYeBtx6wO6gIwsJC16tALoFTvNuq1izcWaBdtJN1bad+UQtQo97SFibUJ0YUgNb0fFB7vozdDwQLEszi/ixsj4TGEE0RsJKjAak78MvOaYX2qFvDsA/m1X+ycwotUX2qklt6NWP2BpNXPnvh8eGYKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrlgMgcfigeH+7BkRH6/62vGtHRHCXCQwtAAZP20Tho=;
 b=fkxXpYrvBd7Ib1qvRCKUj1ECehwQnXMn/H56ftRF/vsoeMWVKHXxx8iasJOWdM1mCV5Gccaq6R94fK/RJee3H067VFtcKCtxxFZh4oB90bHFUX6u3lEq8leWc/IJPaTJaQDUzr5/VicWSryoFXAre+jWTV4+zAG/qO3KTLBOsVg1NthBrLiIBPxVi+Gpy2A7jhz9mcpAbBySF+Ti656PsW9cexeRwNl1ZuzGf4f8Izq3XxHU+bbc+9qbKpAZamVXUqCkZAF4so2TIOhZOfC2E0FgZck/k0K2ZgH/HRyYcszPxDUkWPwm23dOTLMTMKW4PyAAB7/ccGHZV2q5IkgNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 1 Mar
 2024 01:37:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 01:37:27 +0000
Date: Fri, 1 Mar 2024 09:37:21 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [broonie-ci:regmap-test-format] [regmap]  af560701e3:
 RIP:__regmap_init
Message-ID: <ZeExUW2XjKjuzd5p@xsang-OptiPlex-9020>
References: <202402292329.a1c8a83f-lkp@intel.com>
 <2d5fdeda-868d-457f-b462-8d5552a7fe1b@sirena.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2d5fdeda-868d-457f-b462-8d5552a7fe1b@sirena.org.uk>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b297c9f-3eaa-45eb-66ac-08dc39902760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqHmVT6VnjZjfxSCXV8Q3sOOx171ZHBoKKmIPjLvYruy/1fKZUdXJPaUjFgM1WDbj4VbcgK4qrMrqNZaksFzSR4igzoN34kWuvbNhHkSzsqPozqLzVv1oX1Bl0YQKf+xwN95KQO9aAqKQejlVpojXf69JebwAL2Vr6XVSM/hLwhAgBSbVmmIQn21R3ovufMlY15tregv87vhI+dXHMVhyaf0jIIo7OMLU7h7OgU6TJeWV+dLEQcPnyNw3uqpkVBE3/WCalGbmzDRK4vDqGxxWuyEwbAuIMmyH66PMx7EaOskOfL2ebPgxkXQDbr4pOgHrB1WenJfPTBi3NxlNKyroa5QiVdB57w2lvzbJzsoZtEwvWahj1FC0b0DF4a/aBb/DcHvsJHxHb965mSCrfowAaNZJGd2jdY0QbmdsYIijT8rl+CewMmxGDk1tX3aLoOrbbhL24HRSVShWKXLJVlTwLLbBGE0dctqyoq4fNocQl1709fmJEbbgKh/Wn3M5ULR+hNjQfVnIIYl5ujGoiQijVMnnaMEVIUi2ocoPpJBwTkdG0TyhjBZ9LHL4kp6mf/HzuGK2elZk6mKffrTCH3JTItg4bmwA5+vJhhS76dS/j4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5GT5hTet3YfnXT+33PN3vzRCAfDe3B0fuJZdnNFyVbGqxjs1FfGoRHkjklsq?=
 =?us-ascii?Q?ioRoV9wVcO89Ick/mHKukWWJ1GOdtQ5SUclvC4O+1KnFpAtz038TjuYIOayM?=
 =?us-ascii?Q?I2xGcUbm8R9cuajJQL3f7oWnRN3UeH1pndivz1PxwteOIDzfQ3uAIozuadDx?=
 =?us-ascii?Q?WxA0cp1xa10P5AqlOqS4wyuyCkXpNdJvHmh0mKpCcWk+PTJpIMuYHiG0/vQ8?=
 =?us-ascii?Q?4pnlTcac1NhoGN0L+giLqWLHZHAEpig3SiKtxCxYXoayo0/Un/JU3Kc0pn3w?=
 =?us-ascii?Q?go2fEgCqKBL9/F1CxmvIx6UYLL2GJYSGLbuSXZpUX63izOL8lzyYWr1llxPC?=
 =?us-ascii?Q?42e+MxhvVkj+nBOfCbEl48ISp1eZVfAs7AXgzYlMaWfQF/c4RktUW72J2BoW?=
 =?us-ascii?Q?ZmNl8I8Fxo9NkIG1i2bT26jMga6jH8mUEqX13nI3iwn58mSZL+4pMl77KLP+?=
 =?us-ascii?Q?2m3rQ7+PxdrzGLGX7Z7cNd9/0aY3JHPJ7HtbSucI6rkOLGEzyq+9UUscr2FB?=
 =?us-ascii?Q?J0Zd8KYuV+yftwz8+gEPhASex9Z6VyK2lrmRsWb0/5FjyNIRiFhkxK4vKHIH?=
 =?us-ascii?Q?FPFan4HU7rlTJlt+x3PgyN79zG+j/ORwFQvz7GWldlwxMvyoo3ZTGixecvfk?=
 =?us-ascii?Q?24TfvtqIenJKUeUI2av5MBvTfiE47FVfxKZbueEKW0oBTLB8D9/m3oZHa7OC?=
 =?us-ascii?Q?+LoiJpx4pyvV2sStHJg6KIHK1hGjgtyCwAfpOvlTb8gKGtxVtzIHBE0GSzDc?=
 =?us-ascii?Q?zTq8JnMAxfIHX5hQ4LpvejPg/H6fITQcalk2ujoAs3heMhrIn9wkUkZCiDg9?=
 =?us-ascii?Q?6IR4odPu3DjXKef0DDJO28Q4poziJKQKu1NqO6Utl6nZU0N+JmxbfDPvSvK6?=
 =?us-ascii?Q?5/4Ic6yzhr6hAUpVVOPsK0Y9xX61Tsk5HaKsb2QyPn+7/rz7JXAhBNp04dUF?=
 =?us-ascii?Q?uQYgJZvVYUlpwuG2J0HUup3mrCD4nrye0wXnQpTv4gs6RR88ZSPW8ZbOpnyR?=
 =?us-ascii?Q?nLRKe/y7CTNwbH1GZF2p+YYnTlwf4AJ8eLa95oX46hv5bPbIc3rvqoz+z+Q6?=
 =?us-ascii?Q?7q3ZkK+1/+db94fWItosIaIBxmMDnC4gHVFR/wyYceJFbFEQd/ePW+w3ICru?=
 =?us-ascii?Q?LZ3ZPKc8Q68GWt7B/GJpEzwQez4CR9LMtfVVsaZEB784ejmupVkpotf4jmMq?=
 =?us-ascii?Q?RqdrvRObhcYnOCN7AtMOtH/Ue+uBkQsdVwqKmV/OzfAYSNvLEnvWVi+n45pB?=
 =?us-ascii?Q?ZjWs3smtRIwJYS8pFiqdNnl7f1q+jTqvjyl9Xve+hP1HObd7pC7pqcMJxW/G?=
 =?us-ascii?Q?kHkOk86IelF10jIVnTPztidRso1EI6cUdJ3x541vuX67elxY8RPrj0hS7usM?=
 =?us-ascii?Q?IoBjJ/1TAu4+zYzLDuk80b1V5080aQtR04NOIJ/OsAb1qWwa/7G5rcAOO/zV?=
 =?us-ascii?Q?VSKMXKAqMtJQvdmiXThZU33FnNTGTQQvBD+nM8ov46uSCtUGeQWegnUba3n+?=
 =?us-ascii?Q?IF17sauypmDqPjNBAPBUgo5MkR6c1fcSERN9H4jbp2UbkgDkSdyN4TlT8Qm4?=
 =?us-ascii?Q?Aincx8ZuwHvxPWWa4WJSZuKg4zRMzkmK6R3Loa/SB64eiGH87Tif6INp7sG1?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b297c9f-3eaa-45eb-66ac-08dc39902760
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:37:27.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpJwHTaUNz9KtD0yD9YTzjlCBIXbemwbsZs0EwB96gqFhzjdA10lzsCstCU2TYcLMFxPJO0BX46x+xM5DahGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com

hi, Mark Brown,

On Thu, Feb 29, 2024 at 03:47:33PM +0000, Mark Brown wrote:
> On Thu, Feb 29, 2024 at 11:43:55PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "RIP:__regmap_init" on:
> > 
> > commit: af560701e366502504aebae54af374710e35b55b ("regmap: Provide a callback for bus specific initialisation")
> > https://git.kernel.org/cgit/linux/kernel/git/broonie/ci.git regmap-test-format
> > 
> > in testcase: ftrace-onoff
> > version: 
> > with following parameters:
> > 
> > 	runtime: 5m
> 
> I have no idea how I'm supposed to be able to tell from this mail what
> on earth this test is, and it doesn't seem plausible that anything to
> do with ftrace would be related to a change in the regmap KUnit tests.

sorry for the information is not clear enough.

normally, we want users to follow our reproducer as in
https://download.01.org/0day-ci/archive/20240229/202402292329.a1c8a83f-lkp@intel.com/reproduce

however, this 'ftrace-onoff' is just a simple Ftrace on/off test, as in
https://github.com/intel/lkp-tests/blob/master/programs/ftrace-onoff/run
details is as [1]

thanks a lot for pointing out our problems! we are really working on how to make
our reports have clearer tesecase description, this reminders us we should also
pay attention to this kind of simple tests.


regarding the issue itself, we reported due to it can always be reproduced on
this commit, but clean on parent:

5b071e8b2e3e7f02 af560701e366502504aebae54af
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
           :6          100%           6:6     dmesg.RIP:__regmap_init

and we noticed there is changes in __regmap_init(), we also noticed the issue
seems happen before the test even starts to run. not sure if the detail dmesg in
https://download.01.org/0day-ci/archive/20240229/202402292329.a1c8a83f-lkp@intel.com/dmesg.xz
could supply more information?

if you still think this is a wrong report, or you want us to test any patch,
please just let us know. it's always our great pleasure. Thanks!


[1]
#!/bin/sh
# - runtime

## Ftrace is an internal tracer designed to help out developers and
## designers of systems to find what is going on inside the kernel.
## It can be used for debugging or analyzing latencies and
## performance issues that take place outside of user-space.

 $LKP_SRC/lib/reproduce-log.sh

cd /sys/kernel/debug/tracing || die "no /sys/kernel/debug/tracing"

: "${runtime:=300}"

do_test()
{
	for tracer in $(cat available_tracers)
	do
		log_eval "echo $tracer > current_tracer"
		log_eval "echo 1 > tracing_on"
		log_eval "echo 0 > tracing_on"
	done
}

 $LKP_SRC/lib/runtime_loop.sh
runtime_loop

