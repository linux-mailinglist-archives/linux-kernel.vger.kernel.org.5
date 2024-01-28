Return-Path: <linux-kernel+bounces-41602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CE83F53C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B583A2825B2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D687200AA;
	Sun, 28 Jan 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L37XUGpS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3F1F94C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706442304; cv=fail; b=VutMCGkGkfihVqqPBUavGMA7UztO3KdH7sOH2+tppIxnpmPWdErvIBvZy7g/qrYyV5pOhHuu/Qq+45rp/3rVKTdF/KY1yiLDf9+4b8dQ+pahyAgs98agq+9O9bPZSMqpMqH9u0EpnJGS94FdqPljtu5bYVybGHBNZrtk8N9FXfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706442304; c=relaxed/simple;
	bh=0pakDTN79f7GuJkVjg3o1+6yxTKflLT+JcHtF4FenZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u6GncQuwmCGJ//VokbnnltH91EH9l5aHW8yx90cFrm7ORU4o+gKQX4JpMQgV68x0rjc33U5sVYHuxF7wYL42kV/6iGwRcWYa93XxoOszQNE2Sm9L8zh33th1sux31/oTmIaHOMSJ3upZrtmoXzjnBSLIOBZ9/DCivO6YvqYq43Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L37XUGpS; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706442302; x=1737978302;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0pakDTN79f7GuJkVjg3o1+6yxTKflLT+JcHtF4FenZI=;
  b=L37XUGpSSothBFq//ECcLXr4jKth8FX85i9ajTQaKr12j8XpSqAs38es
   qPaXZyfFjw0M8HERJtmezFCnL2ynrsCO/ftLjkPOGn2yn7rcUCGnH7K2B
   MeXLOwEjbMxbIhOrAUs0TlweDFv97DTIcSz8KOakP+fbfxDpAAExk9JlZ
   1DA6A6J7PoJox1YLdD8lyNqe5saISgU1/zC9VAaXFuo3iLO97IUcngfOb
   bqLY58fpW1BgY6oDMZq6JBHUeOtZX7zjFHYmzGqf1DrhikDZbZE9g62nQ
   rPnl/LzFKKVUTR/Ahi0+1K9Mv9CLVOVZ0xR5vv8dUf/pkbGKiVBZA3pwF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="10150281"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10150281"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 03:45:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3146858"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 03:45:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 03:45:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 03:45:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 03:45:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 03:44:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbAbebRVh3FUwoYrZhYWRsaMfixOD0y3f/9t1zMdvmlqc+ne5wvU/xSuHAkUufX15nATy7F2onYbEuL8WfvbHuGPVmWA014JT2mJ9SReuFuM1xavOaDUwJO5StBZXNJny6hhkxuzd283DyQOsRXliYXzDAQw1FJrLPUrme3E9CXnGvvo0/YjqLwVv7Qz6kY3sDqH3PLeN5tQBzcwjDvjQXCYdXMMcClJaqd+qcXl7XV3xTrZ7Fh27OOyW8KWtX9VXO1+EmTpHu5doTlyOBe6i993vO7MQqQ1Vvvc4sn9lKAktjt/6y6jEuZdxJ62sTrM97oacQtoO8zZUceUYl5soQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyuzeKd7uyWlPYnMx3O8B6EIqjkpzy7oFoPbMyKAtpc=;
 b=gXOf2qs9AcKHJfV6XFWL5HCVJmsNTR7q7Yurk1w0rsCzz9stwroAdTLYv5NyaVnJafNPdWT6LSeQuNOErYlOPZPg/TXEIAjN+NjeqKDxSeZA4kCJt2dzs/CQ7BbBcDQFOuQct03KOdeJb+RpGpGKi3DZWmYVZz5ye6tK8fr0RgLtwG4Bob0UAkGXAsbUwP3J8xw1biLtMKDFYAJu5L8Q+RRLIaifPS0b0DDEwo6AebJr80JDoB/Y/FQdoqxAAPXm5VwK0wQl6HW0y6VfKYJeo3rFInwOAv9UJpFHqb7GMHUzsxk7KLAXfm1yKIpNmxpCLmRkE2VHzbcfFTTiLP+koA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 11:44:57 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3%6]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 11:44:57 +0000
Date: Sun, 28 Jan 2024 19:36:21 +0800
From: Feng Tang <feng.tang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Jin
 Wang" <jin1.wang@intel.com>
Subject: Re: [PATCH] clocksource: Scale the max retry number of watchdog read
 according to CPU numbers
Message-ID: <ZbY8NVT+BqTVGDq1@feng-clx.sh.intel.com>
References: <20240126091250.79985-1-feng.tang@intel.com>
 <3b3d9499-dc7a-4ea0-9615-526940f5fcf2@paulmck-laptop>
 <ZbO3bN3WEUvejRBp@feng-clx.sh.intel.com>
 <ebeff3e5-cd57-49ac-86d3-6ebe3c53fa40@redhat.com>
 <2955c8b0-cdb5-459e-9d98-9db7a252f0ff@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2955c8b0-cdb5-459e-9d98-9db7a252f0ff@paulmck-laptop>
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH8PR11MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 31258f94-bcc5-4892-9313-08dc1ff68d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4z6aMp5jriA/XL2AqyILkiRXCnkA6lRO7hdfiut84SECHVKp1Hb1UXCCIn9dscA4u0s8f+2Jo7gb89wIa9az0FBZrDgYkIhs+bB2VlSLl98PaKrAQDXbfgRVqqM1vN3XCncwrKalzbcvy5hUdf9oQGb03QtlCVeEbmuAmxJ4BGpu5r9KClBVcn8IDb/uYpHtUX7DomQcmwFEzoElJqq7v22yMkaFTHqMbC+Al7oQEH7ONI2VIo7ESYFR8wXHtI7Nlms0SyNNkcpLu71KEe4XDb0WqvH8pwB7mYPD7Bj7YWwZMiM/FwrYjvGn05s4dc7/+kcgrJu8loAG5Mh7kyh4WkybjGxNVVJoAk4ZptceXfRxGDDjon+qG/fQWW8rFdbByxRAkuPNWfFmMaO7HgdOd4QWJW0bxyLEzR2f33WDGJjtGcl/SH87TTDie0wdHCtCxca5xlkkSXI31euYZ31zoUeTPDPi8hEe4ahLtnGQ5Th8LhqpOEjFCkJw9uelP352l5Pks3c39IWr7rjlzfmIOzgEoevcpo5QJRhZUuubwFjx9CnN+ANDMe34ooBrfQPHnnjOChZIKV261YRbg1TQ1dMuUkq2Gj1LbCYElCMSKNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(8936002)(8676002)(5660300002)(44832011)(86362001)(6486002)(6916009)(316002)(54906003)(66946007)(66556008)(66476007)(2906002)(41300700001)(38100700002)(6512007)(478600001)(6506007)(6666004)(82960400001)(83380400001)(107886003)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8oxg00lnfzbmxw16SAPKu6Dw0uVjOR4GltWOOAt6j2ziikFhbgMGGnsGLov?=
 =?us-ascii?Q?bGZ4pn+XUnuCWJJnbEctpcQYl22s5tb5lxSxtfFxZ6F2lhtX7Y+Y6uSB0dbw?=
 =?us-ascii?Q?eLuxrupyKUStO+MlnXqmiGbqFZaHyO9YBIxGTgYL2lDpjbA/HUWWmNFRZRJp?=
 =?us-ascii?Q?4t8QI/D6hv/fafOIuk7Et8yZmc5fxo6VPPW4sBFjXsvMPLN9YcsuAJ44NGDl?=
 =?us-ascii?Q?aINdSZEyNoXWsKlXA3s59tTuQPnFr0r0tU34fOj8gCq6ezcdJtIUUig9KVp2?=
 =?us-ascii?Q?/FJVX9Q4Mqr2YNhiD+LQcMIBWonx9zwjbLK7qCokKTFvaCLwhX+TNswHPFDj?=
 =?us-ascii?Q?+CAhUQdB9FypNoUQlhRAmBZpIjN5QozUsTk1hIFKSkba2jNIdtus3YrQAiMD?=
 =?us-ascii?Q?e1Y7tHcosinZf9nszbsiambf8AiCh9OfBSsiPQVVlZf4IziSfmCLqU/IrpKs?=
 =?us-ascii?Q?y57xX7oh0tMSEC+YAWuZAbrwU25Y6vx+JT5CfPAKyF/BBcLCSP6egEatIaUT?=
 =?us-ascii?Q?e6JxynZHn0VLFGmXGc5/7MkxsQW9W9Lk2E9X+SHLLQ08G2hbOEgdmCbf40gw?=
 =?us-ascii?Q?vpQ+YfXQYNfyhTQa6GD6Pc+HPRizmr21iiNpHeFIYcjuYhCIas7bhQ16tqX6?=
 =?us-ascii?Q?elwr31FzIqPcpe+n5dsSkdTCj6Zx5FyT3cSP/4scZ23JOxdk3a0h8TF3Z7aK?=
 =?us-ascii?Q?pkeYau8avH8CHlplDn8a1QCnQyQhASMksqk/VTJfHcYoebPAOjrM0sIW+Qzh?=
 =?us-ascii?Q?NyzbTmQ97Gtj5Z1BV4BHXSw4ozqHaNxiYVl9j52YMw8o5bpcnr/ssPjlUrBX?=
 =?us-ascii?Q?qNCvpgW3H4sS6xP3KDT7vcecWwD4a6TKvde8hq4VAI5OMQjWhLExtzybTm9K?=
 =?us-ascii?Q?EsCzBOVLWAIXXD4/7OrzMxkmudYnicmc4i06yluKH/dIwG4Nv1XZ0o2vRa9X?=
 =?us-ascii?Q?5HUjZFRVMxLVlwDhkoNJPHwpSUA9UxD+aeyfz+q3HAX6wMmtb/D0o3WrYqbT?=
 =?us-ascii?Q?0t3sNEazQWTgf+NQ12xvnOqbFR/PJix3Y5u56QyuqFZihrSeTxvIw/aT/l32?=
 =?us-ascii?Q?Q5wuXi1z+HKDPByOtOhxs/GcVev2UgGD4pIt9Xka6nq1ALQ5IB8RGKGL+rrY?=
 =?us-ascii?Q?IJUaNb0iUCOVw+oazMIp+B4jNlC451NWGX5m3HXasaW0ICpqeJRCRR3uJ8Dt?=
 =?us-ascii?Q?jwRReqnmNZccWHqP1Ff5Qz0KPL08Dpb3Y/RuO6PmV/roBiZiyCSWyMkWOngS?=
 =?us-ascii?Q?6nLrwSEAm3H1BLii4VKMEtUML/CqCmgCGaHPyTWiu1eLChb0NP3a4jYbDP9v?=
 =?us-ascii?Q?qIeoPKSamfDWwn2qvrzEheZvgvofFtlGqAdSJzJFeXo6RVNOmUIxzV6kjzek?=
 =?us-ascii?Q?nKPE6z2XelKxZySHvaG+mcdDOdpUs7uMEH6dJ4l3Tua9NhFB8asjH1eltPGr?=
 =?us-ascii?Q?W9t1DmSgMAhZrYnUeyNGBBb5Nw5O94tQ3lDHNjzQROSpi0dFl7QqikwaT85+?=
 =?us-ascii?Q?BPjJhFvMqvaDks2rf3xlUso8i6QhZLldC6FbIcY2GR7a7I4ohScDfhg0HZ+U?=
 =?us-ascii?Q?JHs8gI9S1Dc/aClgihpmRY5JNFN2dUY7U5sBp4l4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31258f94-bcc5-4892-9313-08dc1ff68d33
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 11:44:57.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF6pkkuNT41bSP/JTEL0YFo2MCErrElkCOKANn18ZYjk4R0tEs8J64/DBBX28mPu13rL6aKl0PSyxAWXqchvSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
X-OriginatorOrg: intel.com

On Fri, Jan 26, 2024 at 11:28:36AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 26, 2024 at 11:19:50AM -0500, Waiman Long wrote:
[...]
> > > > I also suggest doing the adjustment at boot time, for example, using
> > > > an early_initcall().  That way the test code also sees the scaled value.
> > > I also thought about doing the adjustment once in early boot phase
> > > using num_possible_cpus(), but gave up as that parameters could be
> > > changed runtime using sysfs's module parameter interface, and cpu
> > > runtime hotplugging.
> > > 
> > > Since the watchdog timer only happens (if not skipped) every 500 ms,
> > > how about doing the ilog2 math everytime, like below:
> > > 
> > > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > > index 1d42d4b17327..9104bdecf34e 100644
> > > --- a/include/linux/clocksource.h
> > > +++ b/include/linux/clocksource.h
> > > @@ -291,7 +291,7 @@ static inline void timer_probe(void) {}
> > >   #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
> > >   	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
> > > -extern ulong max_cswd_read_retries;
> > > +extern long max_cswd_read_retries;
> > >   void clocksource_verify_percpu(struct clocksource *cs);
> > >   #endif /* _LINUX_CLOCKSOURCE_H */
> > > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > index c108ed8a9804..867bb36e6dad 100644
> > > --- a/kernel/time/clocksource.c
> > > +++ b/kernel/time/clocksource.c
> > > @@ -208,8 +208,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
> > >   	spin_unlock_irqrestore(&watchdog_lock, flags);
> > >   }
> > > -ulong max_cswd_read_retries = 2;
> > > -module_param(max_cswd_read_retries, ulong, 0644);
> > > +long max_cswd_read_retries = -1;
> > > +module_param(max_cswd_read_retries, long, 0644);
> > >   EXPORT_SYMBOL_GPL(max_cswd_read_retries);
> > >   static int verify_n_cpus = 8;
> > >   module_param(verify_n_cpus, int, 0644);
> > > @@ -225,8 +225,17 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> > >   	unsigned int nretries;
> > >   	u64 wd_end, wd_end2, wd_delta;
> > >   	int64_t wd_delay, wd_seq_delay;
> > > +	long max_retries = max_cswd_read_retries;
> > > +	
> > > +	if (max_cswd_read_retries <= 0) {
> > > +		if (max_cswd_read_retries != -1)
> > > +			pr_warn_once("max_cswd_read_retries has been set a invalid number: %d\n",
> > > +				max_cswd_read_retries);
> > > -	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> > > +		max_retries = ilog2(num_online_cpus()) + 1;
> > > +	} 		
> > > +
> > > +	for (nretries = 0; nretries <= max_retries; nretries++) {
> > >   		local_irq_disable();
> > >   		*wdnow = watchdog->read(watchdog);
> > >   		*csnow = cs->read(cs);
> > > @@ -238,7 +247,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> > >   		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
> > >   					      watchdog->shift);
> > >   		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> > > -			if (nretries > 1 || nretries >= max_cswd_read_retries) {
> > > +			if (nretries > 1 || nretries >= max_retries) {
> > >   				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> > >   					smp_processor_id(), watchdog->name, nretries);
> > >   			}
> > 
> > The max_cswd_read_retries value is also used in
> > kernel/time/clocksource-wdtest.c. You will have to apply similar logic to
> > clocksource-wdtest.c if it is not done once in early_init.
> 
> Good point!  If it is not done in an early_init(), could we please
> have a function for the common code?

Thanks Waiman for the catch! And sure, will add a new helper function
for that.

Thanks,
Feng

> 
> 							Thanx, Paul

