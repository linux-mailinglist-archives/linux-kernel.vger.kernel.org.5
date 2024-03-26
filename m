Return-Path: <linux-kernel+bounces-118252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2535F88B6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FDA3B228A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF171CD20;
	Tue, 26 Mar 2024 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRBa4lfV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD51CA96
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416497; cv=fail; b=UFXxI73KUVYtldKESp0pdYAupK2ycTTmInssGin845pzTB2RZFHbQDXPjhWyiSc95he93v8bmHQ88lFYMXm6RChr55ELmbtREZ2L2sTz8nABqd2w5JJrqvPtZfY9pnJC7ABBdmGHjrsneBA91MjqdS++0vps1AUaf4unkg8vyYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416497; c=relaxed/simple;
	bh=lMQxLrzu4DpkWMu1NdBDZNADHqfPhNgFe0lGL+oao54=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dU+Iv/Lo7EIETyKEy2SBdgUJ2MrEYedf/XexnRjkNfm/f/mEXx030pU115Zc1JZf3GzkkvAhWRQRb0SUTXflF7OoNbY/VCc3aNQsWdJTzRvM6SzCf9VUyjBCtnaO/l+PjcNAMxBpdNAVEZFtn+vFMPh9xbnhaVzlvxNxvMsZpvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRBa4lfV; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711416496; x=1742952496;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lMQxLrzu4DpkWMu1NdBDZNADHqfPhNgFe0lGL+oao54=;
  b=YRBa4lfVVG5P/P7bWVKpd1sOhkno+8Jwzs6dMq3rDBrdzuE796kaAzwE
   qRAbB9hiOnyO/byKGhvoujD7LB1JNWYmulqDy/hYojZjfPiT8xbwipX2U
   RnPcakf0NyHBE6ZSQf7jSvKZk//gLnUy5WYaAAzekT4jCa2hxY3I6dL1k
   O4Mqu7s6RnkClZXUrsVG8VETDc6Ewnv4yF14I4EXZlbdO1TTe8IjDxF1/
   P5woMvxoLggFwTylmuzFg/fqUqNQwPy1Tv0IJoa9eYUaMtEh5/ro1Rcn5
   Oth7JlzmTW7Rl/7C73wP6+UOo8iJ20ot6XjxLcUk0vTWX5uvUz8qgxovG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="23934836"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="23934836"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:28:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="16186380"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 18:28:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 18:28:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 18:28:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 18:28:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 18:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBpfxNoCpzhgi/G+gWreOnJbKS+v+o1CKDSleDW+KBg9wQUOAhe7fqRNfesByZ9tmjNbvDxVWacbIP/pYbCGrQzYBaDN7mcQcT1Nfl8NwJlaj0LpdpK1S6TeEe1NRPQcGgL1eOj79t2AXdNb5es1lp5o85Wo0YalbCHXCnvsqtg+3M/lUKliGiOzBXKN5Hhn4IlaGl2w/dmmY3GY9hbEiIXhsj/GRuqnhfi/A8ybg2KoDQVgR1kVlz5SrXdsKD2Ow/aTv6N2ApJ2GOS/VkcJ18F95LswPHJUyNyccJo8mmEVjoy8OCzEbtAwZ/SBB2oYlTaJeJijUrg6GKd2pR5BFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpWiMV+jRG+Lf1Ix66s9JKNMacBeFvhh1U+eb4PH824=;
 b=WyeX/Ck6RrdEaOJP3PdMzk7M/Lq4uA/GrGiAaNbnSpUhWgqGwYmzbL/LLUvjtZYZ843sA/1SjkmH+MhUFzc03pvVE+bl2UQqLG/4Cwfq9pVrtd0+GfVV+IvKkXyHwr+w+TwbhWG/7G3PbqY2WUtpMtXSSzaJXVmX9eFlWYE4O082sZllJJEg8LTsAgPT/rZLy9urjFGolbeleYKmBunPI7XDXiBdMDvAXK0IX0XhbJJhZCMASAvv+B8M2wp3qNPo7hwTAxKe1NrVZcDyRAccwYsYmFj3U+Jeiu6IL8xg89AnV30vHL9d19KyIvfkx5sxPBcJLz6ukIf57frF6YUr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB6555.namprd11.prod.outlook.com (2603:10b6:510:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Tue, 26 Mar
 2024 01:28:11 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 01:28:11 +0000
Date: Tue, 26 Mar 2024 09:14:16 +0800
From: Feng Tang <feng.tang@intel.com>
To: Waiman Long <longman@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	<x86@kernel.org>, <paulmck@kernel.org>, <rui.zhang@intel.com>,
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/tsc: Use topology_max_packages() to get package
 number
Message-ID: <ZgIhaPzPNDXO7LMK@feng-clx.sh.intel.com>
References: <20240325030928.4190408-1-feng.tang@intel.com>
 <ae9eafa0-3c6a-4130-9890-a7463c8286a9@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ae9eafa0-3c6a-4130-9890-a7463c8286a9@redhat.com>
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB6555:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eb9Y+3bW82QCK4cTuxMVqu4/lDlJ9NK39CRVVgSTs74eUPC951LnIEB8JM0d3NsoizSM48etuN8AOUifuDyiMniRkGuqjOevQ3/OLh+VKy/WJw8K13vXHsH8qy4Fkf/BmhnyaBHGqF+/2w3jBWpr2P1LM0Sw336kAHHKrRkEN2gfddQP5MLTDVBIO5io/An/+GK6JscBWyoOU+1grCi3QaXa8aN+HoDKDVBDsaJf2j3UHPNg6T7Kc+9ag+xLJRqPJeHZbOu2GLviz1A5RFzyqrX3IsN337b6wg07G2vZUyvpZt4dFgPa1G9FUmQ6XckEss8nSvBwRzKwpm+LGfedX5+G1hGzfcnLH8nIRxmCqXvLKZhPKbGTn0wFhjlEQMFSKuOmmSyjEfK1iySha59rERZT9iripc4L8BCVLgGU0C57x6kZzL15GFK6VecFw3pbMrXFRQTAyZLnD9LmELgtiWQ+yEtUxrSbvvKWaxcuNVuttSBZtN+fQbeMumIoMHFhoRnZXVDvByL4w/N2fKXT0U7hXI+b2sLJbk0sXp1x9+PTVt7pOptSj7Vl0TT7iZL3e0+4aR8PTGFSe78SyBVgjjOaYE4/ZU4FrLyFJktLjuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ji35BKZtV5FbwvjBSFoDxN9OWCeJ4l+SLHMx//MiaA/RhvF0jGqXBqF+opzm?=
 =?us-ascii?Q?1EROdhl25P4Oe8ZQZFygya+uQqPWPPgwz8EonIrQSrGnHUmR9IB8XbfdbHIE?=
 =?us-ascii?Q?vm3enhGyRy11c5gyabrmrq3dkCOLxrjJE5qjjz1f/kORACQVrgQHcM9lgj22?=
 =?us-ascii?Q?aB4ES2wpr9eJi7Ygyqz8sDzvvukFJvvr6dtlliM6d7WgyvDNHaGxKR0wj6BY?=
 =?us-ascii?Q?YbKIjHI/RblQhU7WiJLyf6SVc+6DVVygo7hkCU7NuVXHlk94mp58FL3zyeGf?=
 =?us-ascii?Q?70zvasONeLK4Dse7EH+zpDBjlLv6zy90jh7RRKk387WhmORKp6pOUvT/mWFB?=
 =?us-ascii?Q?lYObHKS5i0cODzRxWpyC1uLqbzpygOfsosNpSV903YLMNA0V+HMycd3JOJEt?=
 =?us-ascii?Q?sVZ6RqC7vfZUYl+Rv1Dz6RASkFnP/SR3H/6H4HYDG9I9JefGTLK7sTmAL/3Y?=
 =?us-ascii?Q?Vfw0JrS8SeNpAGPD1zZjUnZQ+hdvqtccpo+SLyZkzWduRHmyArl2tRkhjheA?=
 =?us-ascii?Q?ET6tqk68SZa8ZZkveyIXykDq48FSt0dpKG/9ao1OVg1KjGatsFzqbVmUgxvc?=
 =?us-ascii?Q?BpcHP58NX35Bbt5LzU80ISgpBKo+vsQ7d+Y0dIfesp1fxnUsyTLUi3qNnsY3?=
 =?us-ascii?Q?d09U9V4g/2jKIw5nMyFB/i1l8CuzrHzPYHXLmV4k9JKEp8h2G+sOXdXQueYF?=
 =?us-ascii?Q?R2oXQlNEPI+m84HU4Kfr+3pQTG50ThixwCrQScP9HFwEYzGFBZ4unfAhOPPA?=
 =?us-ascii?Q?0zsOXbupB1EKnRTgJpFJfSi3vRLaktEZy9/vQ5yb3sLq3Mb/I3UV82EOa4Ph?=
 =?us-ascii?Q?Q98VT6EmsIZ5IovVq0iwD+HxtWZ272LwBSIHnqCDTvXtIYgNV/sCxqdM7A+R?=
 =?us-ascii?Q?DrQx7zKbBsMSOlrZeQ6MpuVzfvfYpQGbPdLGUiuTAERt1OfIbOJigq9jZLMf?=
 =?us-ascii?Q?+8+g6RXPsmKZlVVxlbZrJnFKAGzKh9UpwH2XZTToLUfoOS4oCTH2+c0gqORH?=
 =?us-ascii?Q?LrwwHxZEz4AufCq/4ANDjmVAf0FXpQjjTScbwTVRtHk7RCPnvxwERlJbpIYD?=
 =?us-ascii?Q?E/CVTk1Hg3rv1hUk6In1a9Mm82PXGC6skcAcUUwFAbzRqpoqD0EyCGCGt5kr?=
 =?us-ascii?Q?PpRRjmmrPSUhvHb9D7SLpQhWQlD5ddmrGJFOn34sF8vGdNqK17wPoRS3NlAt?=
 =?us-ascii?Q?0kNaERewHHy/XNaaASg8ghMlzwEF7lPyAc5gD9oHk3OgHQTXP6xOC2iqtoND?=
 =?us-ascii?Q?XVtPtrWEkbBH8PTWvgBXY8ug7hBI9D7LupzUAyglUIJcPrHYWn2BBkN/k1i7?=
 =?us-ascii?Q?AxrfQ9Phzrr9OAKkOIw8NjfmENqqHft6dY5vdXieQjpA1YG6nQnARzpRb2GJ?=
 =?us-ascii?Q?uCN73AofZNtxT19KXz4ol7QChF3+PsLgwaMCrNjVR5q4gMeI1VJhjswZyjak?=
 =?us-ascii?Q?rPRZVkZ/TcYUSczTNAVuNx6aCerm7IdsG/rmIxtlWCvlUVJytzPLZPzyRKTC?=
 =?us-ascii?Q?II3ATAuHPNXalb1vpAj3mGVLr9QpsoflYav8RNfDBwtKSshUOs2x1FZR0iCf?=
 =?us-ascii?Q?bfM1+bBkwzQ55plAL0jwrQlsStluJ2akX+Se6fIn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a5a402-f1b2-4bd3-c59b-08dc4d33ffef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 01:28:11.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SidnDB1CEmFcxFQXTGIQ1YaDbkSsn4OWBXh/Csx0A+ETW/ZygPGEvcZXXIw3zQryXHjZSR0qxG6Z5bFVHPodug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6555
X-OriginatorOrg: intel.com

On Mon, Mar 25, 2024 at 09:17:38PM -0400, Waiman Long wrote:
> On 3/24/24 23:09, Feng Tang wrote:
> > Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> > on qualified platorms") was introduced to solve problem that
> > sometimes TSC clocksource is wrongly judged as unstable by watchdog
> > like 'jiffies', HPET, etc.
> > 
> > In it, the hardware package number is a key factor for judging whether
> > to disable the watchdog for TSC, and 'nr_online_nodes' was chosen due
> > to it is available in early boot phase before registering 'tsc-early'
> > clocksource, where all non-boot CPUs are not brought up yet.
> > 
> > Dave and Rui pointed out there are many cases in which 'nr_online_nodes'
> > is cheated and not accurate, like:
> > 
> > * numa emulation (numa=fake=8 etc.)
> > * numa=off
> > * platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
> > * SNC (sub-numa cluster) mode enabled
> > * 'maxcpus=' cmdline setup, where chopped CPUs could be onlined later
> > * 'nr_cpus=', 'possible_cpus=' cmdline setup, where chopped CPUs can
> >    not be onlined after boot
> > 
> > Thomas' recent patchset of refactoring x86 topology code improves
> > topology_max_packages(), by making it more accurate and available in
> > early boot phase, which works well in most of the above cases.
> > 
> > The only exceptions are 'nr_cpus=' and 'possible_cpus=' setup.  And
> > the reason is, during topology setup, the boot CPU iterates through
> > all enumerated APIC ids and either accepts or rejects the APIC id.
> > For accepted ids, it figures out which bits of the id map to the
> > package number.  It tracks which package numbers have been seen in a
> > bitmap.  topology_max_packages() just returns the number of bits set
> > in that bitmap.
> > 
> > 'nr_cpus=' and 'possible_cpus=' can cause more APIC ids to be rejected
> > and can artificially lower the number of bits in the package bitmap
> > and thus topology_max_packages().  This means that, for example, a
> > system with 8 physical packages might reject all the CPUs on 6 of those
> > packages and be left with only 2 packages and 2 bits set in the package
> > bitmap. It needs the TSC watchdog, but would disable it anyway.  This
> > isn't ideal, but this only happens for debug-oriented options. This is
> > fixable by tracking the package numbers for rejected CPUs.  But it's
> > not worth the trouble for debugging.
> > 
> > So use topology_max_packages() to replace nr_online_nodes().
> > 
> > Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Closes: https://lore.kernel.org/lkml/a4860054-0f16-6513-f121-501048431086@intel.com/
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> > 
> > Hi all,
> > 
> > For warning about possible compromise due to 'nr_cpus=' and 'possible_cpus=',
> > another alternative could be checking whether these has been setup in cmdline
> > inside tsc.c and warn there.
> > 
> > Changelog:
> > 
> >    Since v1:
> > 
> >    * Use Dave's detailed elaboration about 'nr_cpus=', 'possible_cpus='
> >      possibly compromising '__max_logical_packages' in commit log
> >    * Fix typos and inaccuracy pointed out by Rui and Longman
> > 
> >   arch/x86/kernel/cpu/topology.c | 5 ++++-
> >   arch/x86/kernel/tsc.c          | 7 ++-----
> >   2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> > index 3259b1d4fefe..2db03b00e29b 100644
> > --- a/arch/x86/kernel/cpu/topology.c
> > +++ b/arch/x86/kernel/cpu/topology.c
> > @@ -460,8 +460,11 @@ void __init topology_init_possible_cpus(void)
> >   	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
> >   	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
> > -	if (topo_info.nr_rejected_cpus)
> > +	if (topo_info.nr_rejected_cpus) {
> >   		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
> > +		if (__max_logical_packages <= 4)
> > +			pr_warn("TSC might be buggered due to the rejected CPUs\n");
> > +	}
> 
> People may sometimes use kernel option like "panic_on_warn=1" to cause a
> crash dump on warning. Maybe we should just use pr_info() as the presence of
> rejected CPUs are unlikely to be a real problem from the TSC stability point
> of view. To emphasize it a bit more, we could add a "WARNING: " prefix, for
> example.

Good catch! will chagne it to pr_info. The possible hurt of these
debug options are relatively small. In the past several years, I
haven't got a real case that TSC is really broken. 

Thanks,
Feng

> 
> Cheers,
> Longman
> 

