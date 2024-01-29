Return-Path: <linux-kernel+bounces-42092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF4083FC34
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2043A1C20FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0BF101EE;
	Mon, 29 Jan 2024 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkBa8/HO"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B2EEDC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495200; cv=fail; b=p5q6aVA8C+mI8lFsl0zr8M3YyRuADoVJz8m7MULCVMPz3aRE/WaTlmgDK7otOVi2rajsate53fB0QSRZonER55hRPg2RtiRJb5IJLoCuKjvTCgZEjWtULfSo7utLe2500gkAKAc99JfSUh05UH1xS3gNUPvZdwSgDJNSjGz0TQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495200; c=relaxed/simple;
	bh=8CCv/SyNbODPPd1+Wfi0E/Wp6VejEeh4QUOpFZfDN7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WfXPGW2zfnyzD98FtOcbXFRvzzPzpxp25Y/SEYkPOFkNaoapxuXGmOaMuBYmUppsLYA1d+WLJVev9LTzZeAQYHyleExvTNS3mlMn6ymHjDBBPaPLuRxsdfD9u62DRSxyncFcFMJEBnU2/PlTfAHa3/JCAkZjQ+vxSQSm4jWYw7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkBa8/HO; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706495197; x=1738031197;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8CCv/SyNbODPPd1+Wfi0E/Wp6VejEeh4QUOpFZfDN7Y=;
  b=jkBa8/HOfFvql3z15qPzkGK0Aw7X0WSsIitI0fzKiAVM46168JweJC7w
   zdEMxX92tzFl1WYdneZJn7YRHnIk32c4OKw9AuGFBz5T7/MXuotektfH+
   3bxxSWg2H/NMb9qoTcXrNLuTFfc0Ec2mwgzXG0EDbHQxv19BlDNV0rJqm
   dYoBZ8hLRqJi00rAiMzfQLMaj5De6qXFh4AOoqF1+VfKR1bkwTcZgcnuH
   n3RxxntIbx1q41KuWqY3jathsR7ZwI8LxHyFNGAgOJbIyxH0Jg3CG95WQ
   dlPT6iZNLc6DDruNCINcsR6RBvX61z9LqyW5MCw+se/G5uhXbXM+jzCjd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="401697048"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="401697048"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 18:26:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="1118792305"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="1118792305"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 18:26:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 18:26:36 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 18:26:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 18:26:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 18:26:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzbayfHkH8oEYsDt2T7KhNEcNFdn9Jm1IOonyFEmKCH6eFzIzbNEp6HYyIC9tGQ1ow+EB2sHfw2ain2mf5pr3GNAM+cq35dsNZkWfTCJ/29QodzqFSdgg5gpl72oVgmv6eb+MM/8047Ls5dR3E62tsNxeNeiut84UTOQkJCalmGLW+bElRF20dAYCy0E0U5n727C5hh4WvWC7G6CG1DBSqNzYwZisZaOcz1Zvbbu7g5v8MCk3f6TPYIs0MewQg4r677ZJdUejSb8Sp3wV1Uji0jE+qFY2YWwqTbepo9HJ2akNdsvvNCrak5/q0w31Pgh5ss2n9BGlWx9FjghJn5SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FngxZjZAE9h04XJD9qY3mlVs5L3JIkyVg2nwvB7qd3E=;
 b=WTC2Rhbc1o6Rcds41Mo5ZMJg2G02p8B9yQpY5pW1dS6Hu+VWZygdOnZwJwS0VBE3aNcOGOOfOZHI76aKosKe9EUGcdrY/S0LTalKovt4B2ax3oMO3SFDzqF/XBY1/th1XWrytBtg4P72c4pryelashSfg5F+piJOaI2KiQTwqV6U36eIKFAVeWq2MAnorJb5pbrRqAMHHyxArMZbvJr6hZ/CqPJURkORM34rTS/QrPznF52HQVVQj+Fup0KsYdCR7XyZXS24nf7RKXx0vOLij2DXUtKKfwM/MyaULVf3yxSdagO7DkYKW26XK1Nyyu7w9V7mRz2OBZ+SlnBL3GaDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6119.namprd11.prod.outlook.com (2603:10b6:8:b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 02:26:33 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:26:33 +0000
Date: Mon, 29 Jan 2024 10:17:56 +0800
From: Feng Tang <feng.tang@intel.com>
To: Waiman Long <longman@redhat.com>
CC: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, <linux-kernel@vger.kernel.org>,
	<paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jin Wang
	<jin1.wang@intel.com>
Subject: Re: [PATCH v2] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Message-ID: <ZbcK1Ixk2bjnYxdf@feng-clx.sh.intel.com>
References: <20240128143143.3021280-1-feng.tang@intel.com>
 <9ca4d7de-d022-4a5b-b114-3ffe5f4b4bd1@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ca4d7de-d022-4a5b-b114-3ffe5f4b4bd1@redhat.com>
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fc07c5-ee71-49f2-92b9-08dc2071b5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XYBUjTIB3H/4H1D5Qav07G3XbfFrE/6d6hkAJJbcXxpNP2AR1uB68jrjKQZrAlqfuu5LnIqDhk0Id8NLesOEw4mX6AmPFrxztbmGegZiQhCrQbzfjaIgeBSKzSUOy/JrYLNOlbbyqGGFU1s+/LLvZeCa/pKYzhc1XpXxUaaWfvAUWjAlZEjFYBWUi6LaM8Ex2SWeZOBc7ILW51rgcy2EOg84wywvjPLFdIkQEWn+VAQajrV8iylVW5x19eK9KX7KSfAvZWMuj+Im14xPnZ3JOvjGecbk53KGkn9tmeKr9tXaqxl3d3XvxR1fAN/sCttc7x8TLovZ3LRFgH5AT4WnVxxitbJQwoVmLzKsZuAF5AF9/pg8aBqTqLBvwk2cp5X/W2kaipZaU2DxRriKamiJQbpB1m4hA6nxnExFehYO/nTR6ifEje+VZ3QeedYP+qVWBjdW06gf8X/315yDF0jY0BZG10d8nbEih6WA9PWggcmOF08ovMnFbfXO+vZvoC5EKqS/BG9VWtvTajZ2YMTiz+KEd/YsGNq3g8tXXK6VCEjarmpsu8flB1P7DayaNFR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(316002)(83380400001)(6512007)(6506007)(53546011)(66476007)(66946007)(66556008)(6916009)(54906003)(8676002)(8936002)(44832011)(38100700002)(4326008)(82960400001)(478600001)(6486002)(26005)(107886003)(6666004)(5660300002)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ilNEfrcoB9/RPHigBb5FhVcIOpYa1MCfNnEpBs0GoUKEPJEjKtUkoUKMXHMh?=
 =?us-ascii?Q?embiBDjjWtV3xo3TgeDISLMl0YRp2konLBWGZid8pLKJ1Q0KfcZvR3ZG8Yxk?=
 =?us-ascii?Q?cwr4xrSyZDiOPxglG2RHl9uSfZctgzZMD02BX9dQWRu/SzBKQYX/PqAz5MsN?=
 =?us-ascii?Q?jtFJCmMaOymPf+7jYPKQg9UT0EGa8tpAz1riDgVz+q0PpSa7F2i3YdjywadX?=
 =?us-ascii?Q?KzD8kq8JjmFEsqz0zU1Pok/WFfhPnZpxFFXMLdl5KH8uFB/kzHbK+WHOrk/W?=
 =?us-ascii?Q?EMS55d+8aXMI7/croGz/FmM3PlVQN7riCP1Jg2DLDxScJdRkCwRIvP9HL6Cf?=
 =?us-ascii?Q?2PkOJcXirbNbtNdGRP71HaSkmUuK4fXZ0YtjslXcOBs0fLly8Oog6nzgpT7k?=
 =?us-ascii?Q?E3UHZtMgIPuPJtIIaV+3ysswn1x1QOy94ljUeE8FDAHYavf0/dGJyUrHe2FG?=
 =?us-ascii?Q?uzLNeKYjYGbfXIUlaRNEGaoWSwatRhUr1bDLUCvTxnKO5K1S9wl/egtWlb8t?=
 =?us-ascii?Q?7CtKDr3aM2Kis+oKJKVFBrwvEFyqu7b7cdmn24qznQz2JylHh+3ZQP9WrD0Y?=
 =?us-ascii?Q?y+5mfJqpmdp1setr4atICTnKLDFQAwXU3aB3ocXCpDwFMiCiC/4+dOTQKaCd?=
 =?us-ascii?Q?TxNQdTaqYVUYEGRWTI3jTE8qZ9XhdFFv4SH1GHD257ynINiZEPl3YKx+VMpv?=
 =?us-ascii?Q?8OIy51bHWS0I/aIokQZt9KzpY1yj08QzAm16MhFf+GYgeOJLnUnpcKHbmbh1?=
 =?us-ascii?Q?0zcF2QNlANiKWXQPrDtuHKd/oyLya8640dBkkv0GVFCXhPwYRK4R0SNGZm3a?=
 =?us-ascii?Q?K/JM8ZrJTUveOiwXR6Vgz5pT9VZdhV9rwJU5WSVtVJ1D70OaYPEaqv/zS+yF?=
 =?us-ascii?Q?3wxkVH1LokQE9snXcGHM5/hCgtN/tNOspIMGh2Rji81yjbQmZFKb92VIMhfE?=
 =?us-ascii?Q?Ky2xZq/ygc/IUprotT7lFRxg2fO51gHw7HWIiWpLvwc0Kf6FbSS2XqD7kvF4?=
 =?us-ascii?Q?xIL7uO7srnDvotzj1IVWa4cBdysaXgyNT0CAxR/U9d2ftba+6X+1SbW9shmt?=
 =?us-ascii?Q?LrbSpEsKHOoXeO2yKzF/AXwmjGtyfsjXWTntSvLT62m0dxsdaCFdLJPdFEJx?=
 =?us-ascii?Q?VvCdiu5oqs79H5U6ZOZJ1xnSIhWV76dbodI6VdjFYv5cVput0uyYydONdQur?=
 =?us-ascii?Q?b8IE+MGqKFrteW81KSPJ2VS9ZS9ClISWTfJX2i1sjvBhV16pyLEFk7YIOgfn?=
 =?us-ascii?Q?h357n1kUvqeb1Rv/CBI2drSEtbI35mc+jqs2ALqRCVXKPllft12dd4QfBXMu?=
 =?us-ascii?Q?ZWukPjXwa0r76aRyHdOpeFJehfBFlyAW97P37MTJtV+tjBhvjBZAP6zExVPY?=
 =?us-ascii?Q?Ai5MmQ8JHrV8U78TixUbqdrQFQJk2yWg05hroX36sADuB5jXlR2KOIMcuoDD?=
 =?us-ascii?Q?Yp+K7T2sOWgEN6AW9eOw48xQZxn/46mzQQRZvqA6hnX2gubLe0HsoDQveOac?=
 =?us-ascii?Q?L3UkCGPPe7sCOIOdDy4cUxq3dNTvIDNVdKG6rTjuCzHIONNGzpKN1NGxk47d?=
 =?us-ascii?Q?gCIPGppXC70EmcIC2pPU1WkPH+ow8dHLApmLM8XP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fc07c5-ee71-49f2-92b9-08dc2071b5b5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:26:33.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwA6HdvjpU4R/GKorUjzwbDUmqPo/oTJfMhbRqYSIt74943qcw8dIqdMx7FzLb/clTVahItOTQrOHTAirgv39g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6119
X-OriginatorOrg: intel.com

On Sun, Jan 28, 2024 at 01:15:31PM -0500, Waiman Long wrote:
> 
> On 1/28/24 09:31, Feng Tang wrote:
> > There was a bug on one 8-socket server that the TSC is wrongly marked as
> > 'unstable' and disabled during boot time. (reproduce rate is every 120
> > rounds of reboot tests), with log:
> > 
> >      clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
> >      wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
> >      tsc: Marking TSC unstable due to clocksource watchdog
> >      TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> >      sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
> >      clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
> >      clocksource: Switched to clocksource hpet
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
> > Also add sanity check for user input value for 'max_cswd_read_retries', and
> > provide a general helper for getting this max retry number as suggested by
> > Paul and Waiman.
> > 
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Tested-by: Jin Wang <jin1.wang@intel.com>
> > ---
> > Changelog:
> > 
> >      since v1:
> >        * Add santity check for user input value of 'max_cswd_read_retries'
> >          and a helper function for getting max retry nubmer (Paul)
> >        * Apply the same logic to watchdog test code (Waiman)
> > 
> >   include/linux/clocksource.h      |  2 +-
> >   kernel/time/clocksource-wdtest.c | 12 +++++++-----
> >   kernel/time/clocksource.c        | 26 +++++++++++++++++++++-----
> >   3 files changed, 29 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > index 1d42d4b17327..8d84d2f79622 100644
> > --- a/include/linux/clocksource.h
> > +++ b/include/linux/clocksource.h
> > @@ -291,7 +291,7 @@ static inline void timer_probe(void) {}
> >   #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
> >   	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
> > -extern ulong max_cswd_read_retries;
> > +long clocksource_max_watchdog_read_retries(void);
> >   void clocksource_verify_percpu(struct clocksource *cs);
> >   #endif /* _LINUX_CLOCKSOURCE_H */
> > diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
> > index df922f49d171..c70cea3c44a1 100644
> > --- a/kernel/time/clocksource-wdtest.c
> > +++ b/kernel/time/clocksource-wdtest.c
> > @@ -106,6 +106,7 @@ static int wdtest_func(void *arg)
> >   	unsigned long j1, j2;
> >   	char *s;
> >   	int i;
> > +	long max_retries;
> >   	schedule_timeout_uninterruptible(holdoff * HZ);
> > @@ -139,18 +140,19 @@ static int wdtest_func(void *arg)
> >   	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
> >   	/* Verify tsc-like stability with various numbers of errors injected. */
> > -	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
> > -		if (i <= 1 && i < max_cswd_read_retries)
> > +	max_retries = clocksource_max_watchdog_read_retries();
> > +	for (i = 0; i <= max_retries + 1; i++) {
> > +		if (i <= 1 && i < max_retries)
> >   			s = "";
> > -		else if (i <= max_cswd_read_retries)
> > +		else if (i <= max_retries)
> >   			s = ", expect message";
> >   		else
> >   			s = ", expect clock skew";
> > -		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
> > +		pr_info("--- Watchdog with %dx error injection, %ld retries%s.\n", i, max_retries, s);
> >   		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
> >   		schedule_timeout_uninterruptible(2 * HZ);
> >   		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
> > -		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
> > +		WARN_ON_ONCE((i <= max_retries) !=
> >   			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
> >   		wdtest_ktime_clocksource_reset();
> >   	}
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index c108ed8a9804..00e359c80822 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -208,9 +208,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
> >   	spin_unlock_irqrestore(&watchdog_lock, flags);
> >   }
> > -ulong max_cswd_read_retries = 2;
> > -module_param(max_cswd_read_retries, ulong, 0644);
> > -EXPORT_SYMBOL_GPL(max_cswd_read_retries);
> > +static long max_cswd_read_retries = -1;
> > +module_param(max_cswd_read_retries, long, 0644);
> >   static int verify_n_cpus = 8;
> >   module_param(verify_n_cpus, int, 0644);
> > @@ -220,13 +219,30 @@ enum wd_read_status {
> >   	WD_READ_SKIP
> >   };
> > +long clocksource_max_watchdog_read_retries(void)
> > +{
> > +	long max_retries = max_cswd_read_retries;
> > +
> > +	if (max_cswd_read_retries <= 0) {
> > +		/* santity check for user input value */
> > +		if (max_cswd_read_retries != -1)
> > +			pr_warn_once("max_cswd_read_retries has been set a invalid number: %ld\n",
> > +				max_cswd_read_retries);
> > +
> > +		max_retries = ilog2(num_online_cpus()) + 1;
> > +	}
> > +	return max_retries;
> > +}
> 
> Should you add "EXPORT_SYMBOL_GPL(clocksource_max_watchdog_read_retries)"
> since clocksource-wdtest.c is likely to be in a kernel module?

Yes, you are right. I tested the wdtest as built-in and missed this.

> Alternatively, you can make clocksource_max_watchdog_read_retries() an
> inline function in a header file and keep the max_cswd_read_retries export.

Yep, will go this way and restore exporting 'max_cswd_read_retries'. Thanks!

- Feng

> 
> Cheers,
> Longman
> 

