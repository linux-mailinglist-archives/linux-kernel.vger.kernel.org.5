Return-Path: <linux-kernel+bounces-73970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF585CE29
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6461C1C20BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3193A25777;
	Wed, 21 Feb 2024 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUY2UWNG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324DE2B9C6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483293; cv=fail; b=rTxrBtuvKk+GWzf0GZZbdhKCxuQfhVyv73rdWGFlxIQJndmiw/xq7VuxIy/tUfaTttSAtwvWyiOvtog+obE/KY1WJSVI7xFFj208O8GfFKMrUCfMQxQkWodZSMp2LSS9cpkaVhrlD7rezgL/gPjZl5qvDpqJtO64oFeM4hIzmAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483293; c=relaxed/simple;
	bh=gy8CsgVu9E9DZJwzeVhwJnERi7LpWMPZCAvU1tibxLs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F2vQiu/lN3BLow8wh9U9AC66g4EvjJ0UHsTM+C6j5w+LH0TJJt17rUZz2qtnhGt01K8DCCMW0KAZOE0T5pXmySo9JZm1mdRUYdW5zSXmvo8jAZ65u1rfun5uLGUe2o5qtZr4/ElBdMQxsLPu+5poTSY5gM3cIzp59JF6z3VraAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUY2UWNG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708483292; x=1740019292;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gy8CsgVu9E9DZJwzeVhwJnERi7LpWMPZCAvU1tibxLs=;
  b=iUY2UWNGJIOdO5FsyyxK2lZ/fB4xkRk4qoCEY8a7KBeVdKARwyopULXv
   UPa9Im9WqFqSUCKzlV3ABOCtY7wPUQJg9xmw/9utImBqvS+1kCAlHcISv
   zFVvXZtEnjn5BeGPgFLxT2+62f2F/4jgowo1hit2jUIlE0muG3OD8lGIT
   unj9/GsBDydwZ+oQY4XMGxCFroRUu0iv0BAHU2IROfKOcXXvRZoov1XwV
   quuvf+R6tHEAgQimGh+CBkts4+pCHJyc+bAW+kuUbLnowcLBpSLySQ5b0
   C+gOsUzNdV0f7V7+j2Df3fkZ0kUlLHTZn5fmLX5bbjfEOCO7FQ0+gSsm6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6441208"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6441208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9637515"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 18:41:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:41:29 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:41:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 18:41:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 18:41:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOu6xSMVIm3c5UCBk7m8lC2ZVkicm2SMk833cp1sNNhuEZ0bNZofWRHbPetYtz79xbR9EFUrAnj0gnzG9oHnLkGFahmhupCzEvol1zcvHkCs24xEPk7hY7aamGK01Bd81Pmlyx412AT5usa8mcEhfL1zdcv/Ie6C+Bo6id/ynQh5815aSr8AYQpjQ2Hp6AOzyCUJyxuUB3DtErirpBMENSu923ZHw0z6ALmqydfX2dpqE5mXdp2FH4rssEU7cSKqh3wXH/VsMBGmuUIeQQXkoCQ85kjomf+vR1nuTtTJla8MuTkKnNQR/bltSaEtnFDcWQtkEn1aWgVFf8FHzQ7Nwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObPYDDsk0p2eKkxYg9bFz/MYCrN3WCAHihnyzTiIxY0=;
 b=EX+nd78ik+RKjPCVSoIAoYOmXx/AXusPto4VnTltrPLP17PUEN2/SejnDaXxdQjBhMtrQzbl7oGelSMIa6l9wcuj9XxY2n8reCmOKq+ZcXaJ7MugWkIPTlLOFWn4RbFMgBjobb52kh7EMDS5iqehot8Xcb5Y8Bx9zmhS9tgHlnRyFVIa/92CrDoGezA+agCTjHbmygpfjlWf8DfCfMkxmnv/w3Mn8z5pH2TVoy2v+ca+Snz95Vrgiopv0Y2wYcB6IbihkIs2LuQT3g64+qN/XGaUSakc0QDWLceiX0cYakI6U2bedMOo3mzLWmmpyvMW4dmq0o97Ub0/YKoQ+spFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 02:41:27 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 02:41:26 +0000
Date: Wed, 21 Feb 2024 10:27:19 +0800
From: Feng Tang <feng.tang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Peter
 Zijlstra" <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
	<linux-kernel@vger.kernel.org>, Jin Wang <jin1.wang@intel.com>
Subject: Re: [PATCH v4] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Message-ID: <ZdVfh1yeDEplFPzR@feng-clx.sh.intel.com>
References: <20240220154302.848412-1-feng.tang@intel.com>
 <2996a3b1-33db-4a58-aa69-fd13cdbb1eee@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2996a3b1-33db-4a58-aa69-fd13cdbb1eee@paulmck-laptop>
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ2PR11MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad4b69c-d1d2-4b27-8625-08dc32869980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppPozrJd7Xq8086kDh9ZLkFeaOthUiEafOpGOb/zDMIECDgYZo9XzsZ05mYDKuYxBeE6DlMScMeAoqheDy0OFaj0cDzVUKYK0YOaVkOLVGCR07XQhoMZxJDtMr2YHm0peOOOBJB3H02kNAsbnVrjn4k2WwZipyldVVfLEeSjttICW4vgm3lDMFfzVAik+eIVmsNOEJctbySQiCKYzL/wtaYaQBFMW6bUU1VzMKygdqzeOaalLZQNCkTG4NOPIzUXwrkdUR5VwcvXu+H0hRgejY9k+zCJiEtloEJlnJlWxt3cHIuIBCWnlYQKc3Lf0oYmoMM+vv5E5gaAlKIH1ZENgsmgtJ8pmzrZSjfgTQv86EP7ULwdMCkwIPNiggeC7Io1G7ckE614LXSxl6Hb8tErJVKJkk87Edujw+CKVLIISR+Mv68BhJ1Hu/BsfpK8LsiI7laLo79QF9u9iUBCbZM5anZamczG39klW7tXN8D3BvK4/Ib9auRY/w8QKFFZIrQBoAy02LfzjqQtMoz50FKPITddlUl743LubMAGKeU44i48Rdvs9wKmCkCwW2dVyzvq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/e6kH1qeNKPGKY78QRAMMxpCIMpCdVzGMnFKBela8YLyu/D65DgMtskKmNJ8?=
 =?us-ascii?Q?JIOqQfGTj6YTMfcTDtuL6BrM3H21AASoVvj2zlbZZVUrjfyV4PFA1qv/Uwcd?=
 =?us-ascii?Q?L0RMn433X2CcIQLj+AXl+8+b0WcY7I/Wx/BmuSI8G52uyVkJo2142AK/tucP?=
 =?us-ascii?Q?P9gw3pviWJ5t+oWdA80FWwFuvLmzJHNhCacyhINFCpbTx/m+OgeeIQKB8Red?=
 =?us-ascii?Q?93PxWO03PcJGxqCmyV7PGkffh9ZSUBWW3oPxAPNn1nCxMDmhSAeDMCjrNHib?=
 =?us-ascii?Q?mR0YJQd6Vc0bpXfzgvhfc1JgrRd5sk/deM+gFtL67TSPz5wRGh3gOqOsrr6L?=
 =?us-ascii?Q?1y67nsx7/WjQYn1qFo0eOe9m7EExmHLb47lUFnAlfOufh96yiKfGehxrC18n?=
 =?us-ascii?Q?B2JrTLOuRzMAszca5iivbwmPikKWerKqLk3iLDqZNxTAYC8hKVeBIBTBzTPe?=
 =?us-ascii?Q?Gp1fbj8UYp6BR2jNMKS4UpqWXMkp3OyNK+HDllAY86CwHRZfVjtsZVyACCI9?=
 =?us-ascii?Q?lKkXHvuId5sTUpql19GOBwVjlOKSyPOt/F3KzvHXVDJwz3zoM7S4//xPUy0I?=
 =?us-ascii?Q?Hq4G3TJXzWEO5MIcmfMiNr/bPDWFAoQsZP8g3E/uG6fxCXKz1nF17+8123sp?=
 =?us-ascii?Q?Qo9W+p91gaBQyEhrkLDdZ7+Jsn4KqU4+jv6yndtdGL02lFGJh320iKwNlxzz?=
 =?us-ascii?Q?bMyMsJaw+rQsNhReWNTBRwNk/VgERxMxkaS9rdqKzOYuSQeerknWZpobg/Od?=
 =?us-ascii?Q?3PcotTk+jOI8FaYgxPtn8MQmPvL9eYys/Nend/bAQ8HtPHG7QMSm438odf7P?=
 =?us-ascii?Q?EIZ6tWbbErN2DC87cuNnv/hnUXeiJxClBA9ZEY03UtVwmMGi82pYRLEQNVku?=
 =?us-ascii?Q?GOzFKIIWklg1rR3aJfBc/7zdmmj2sRmlFrBREyVHJw4ezpmQKXJIQ5S3Kh/y?=
 =?us-ascii?Q?CAvfo7uVjhVWnxUU7OQgZ8NQJBgbC9TkjFiF3RzUTgJIzqp4C9+E6CW14pHV?=
 =?us-ascii?Q?YeEHF7O2pWpPQLTxO9XuMUexs8udA8hudVYCpp4ws9jFbzGVHRg36XrCc9aZ?=
 =?us-ascii?Q?q9QktbVBuNQ8hNXMPPpRBd5E7KiyL86g6LtzaPPTG0Wwc0ps5wdfMG8Y6b1m?=
 =?us-ascii?Q?brYJl73jnAUGH4o38k5rfdltMERR324qPOT9+r7E/luXYGny50MWbOOskbOf?=
 =?us-ascii?Q?aHxtOGlXINPxA93/A4u5iNofLw0ttjDC6ioGz+fkXkSUPnuCEJJSL5ymO79F?=
 =?us-ascii?Q?Ong1QUxUn+EAoJb9dNQm2OvHk9JfwD6bSpeuU8/IXqQFbgiYd7+7u3By43hC?=
 =?us-ascii?Q?pjcUGRoi81XpZbscQObQA7x+RIbhxqwuwFXINa09EwacJG23A/21LR5u0Lik?=
 =?us-ascii?Q?xRUF6XCdwhZTwYhehla6u46QbYqpBJVyDYGLOc7gxFhvt9LtVpxNh9X9zvFF?=
 =?us-ascii?Q?LduyVrn2YkoAVRaaiyI83sMR+AK5CMc2F+KntfYXhJbhHQt6UWk7fTc227SQ?=
 =?us-ascii?Q?rcSNmTsdee9ivMZOhD6XHe3YrXST1cqH5c4dmBELwrje5sPTPLtwNPVHF/kF?=
 =?us-ascii?Q?WpvHbAM7pe6hXJ3hmA9d0x9HFyJfV8V9+YXq/63V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad4b69c-d1d2-4b27-8625-08dc32869980
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 02:41:26.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlRfTd532CJZWY5F58fAM79jQAQ01M8yP3hSTBbOAcVnZt8bMrOg9oJTlXD/8FRFEECw5kWev51d2wALLGRE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585
X-OriginatorOrg: intel.com

On Tue, Feb 20, 2024 at 09:47:11AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 20, 2024 at 11:43:02PM +0800, Feng Tang wrote:
> > There was a bug on one 8-socket server that the TSC is wrongly marked
> > as 'unstable' and disabled during boot time (reproduce rate is about
> > every 120 rounds of reboot tests), with log:
> > 
> >     clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
> >     wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
> >     tsc: Marking TSC unstable due to clocksource watchdog
> >     TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> >     sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
> >     clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
> >     clocksource: Switched to clocksource hpet
> > 
> > The reason is for platform with lots of CPU, there are sporadic big or
> > huge read latency of read watchog/clocksource during boot or when system
> > is under stress work load, and the frequency and maximum value of the
> > latency goes up with the increasing of CPU numbers. Current code already
> > has logic to detect and filter such high latency case by reading 3 times
> > of watchdog, and check the 2 deltas. Due to the randomness of the
> > latency, there is a low possibility situation that the first delta
> > (latency) is big, but the second delta is small and looks valid, which
> > can escape from the check, and there is a 'max_cswd_read_retries' for
> > retrying that check covering this case, whose default value is only 2
> > and may be not enough for machines with huge number of CPUs.
> > 
> > So scale and enlarge the max retry number according to CPU number to
> > better filter those latency noise for large systems, which has been
> > verified fine in 4 days reboot test on the 8-socket machine.
> > 
> > Also as suggested by Thomas, remove parameter 'max_cswd_read_retries'
> > which was originally introduced to cover this.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Tested-by: Jin Wang <jin1.wang@intel.com>
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Waiman Long <longman@redhat.com>
> > ---
> >  
> > Hi Paul, Waiman,
> > 
> > I keep your 'Tested-by' and 'Reviewed-by' tag for v3, as I think the
> > core logic of the patch isn't changed. Please let me know if you
> > think otherwise. thanks!
> 
> I retested, and all went well, so please keep my Tested-by.
 
Thanks for the testing, again!

> One nit below...
> 
> 							Thanx, Paul
> 
> > Changelog:
> > 
> >     since v3:
> >       * Remove clocksource's module parameter 'max_cswd_read_retries' (Thomas)
> >       * Use "ilog4" instead of ilog2 for max retry calculation, and
> >         may be adjusted later (Paul)
> > 
> >     since v2:
> >       * Fix the unexported symbol of helper function being used by
> >         kernel module issue (Waiman)
> > 
> >     since v1:
> >       * Add santity check for user input value of 'max_cswd_read_retries'
> >         and a helper function for getting max retry nubmer (Paul)
> >       * Apply the same logic to watchdog test code (Waiman)
> > 
> > 
> >  Documentation/admin-guide/kernel-parameters.txt  |  6 ------
> >  include/linux/clocksource.h                      |  1 -
> >  kernel/time/clocksource-wdtest.c                 | 13 +++++++------
> >  kernel/time/clocksource.c                        | 16 +++++++++++-----
> >  .../testing/selftests/rcutorture/bin/torture.sh  |  2 +-
> >  5 files changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 31b3a25680d0..763e96dcf8b1 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -679,12 +679,6 @@
> >  			loops can be debugged more effectively on production
> >  			systems.
> >  
> > -	clocksource.max_cswd_read_retries= [KNL]
> > -			Number of clocksource_watchdog() retries due to
> > -			external delays before the clock will be marked
> > -			unstable.  Defaults to two retries, that is,
> > -			three attempts to read the clock under test.
> > -
> >  	clocksource.verify_n_cpus= [KNL]
> >  			Limit the number of CPUs checked for clocksources
> >  			marked with CLOCK_SOURCE_VERIFY_PERCPU that
> > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > index 1d42d4b17327..b93f18270b5c 100644
> > --- a/include/linux/clocksource.h
> > +++ b/include/linux/clocksource.h
> > @@ -291,7 +291,6 @@ static inline void timer_probe(void) {}
> >  #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
> >  	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
> >  
> > -extern ulong max_cswd_read_retries;
> >  void clocksource_verify_percpu(struct clocksource *cs);
> >  
> >  #endif /* _LINUX_CLOCKSOURCE_H */
> > diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
> > index df922f49d171..d1025f956fab 100644
> > --- a/kernel/time/clocksource-wdtest.c
> > +++ b/kernel/time/clocksource-wdtest.c
> > @@ -105,7 +105,7 @@ static int wdtest_func(void *arg)
> >  {
> >  	unsigned long j1, j2;
> >  	char *s;
> > -	int i;
> > +	int i, max_retries;
> >  
> >  	schedule_timeout_uninterruptible(holdoff * HZ);
> >  
> > @@ -139,18 +139,19 @@ static int wdtest_func(void *arg)
> >  	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
> >  
> >  	/* Verify tsc-like stability with various numbers of errors injected. */
> > -	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
> > -		if (i <= 1 && i < max_cswd_read_retries)
> > +	max_retries = ilog2(num_online_cpus()) / 2 + 1;
> 
> Please pull this into a function so that the two calculations of
> max_retries are automatically in synchronization with each other.

Will do, thanks.

- Feng

