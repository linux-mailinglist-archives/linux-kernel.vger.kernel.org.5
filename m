Return-Path: <linux-kernel+bounces-137741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1DA89E688
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED011C21C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B6405E6;
	Wed, 10 Apr 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="V4E0KIp5"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2096.outbound.protection.outlook.com [40.107.93.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76A1EEE4;
	Wed, 10 Apr 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707230; cv=fail; b=Ul08jXmRVDClPpdD7nLZyTFu5ovpB1rIsk3v9LzkxL4Ikj2GHN2TJFWPaeEChhUba9HtDdVCkKrBGjIYfLkfL2yn0I2buGBRxHtBmpnYF+x7QHsoI10JOukNofsNftp6X7jsvjFpqKec+5Ff3+hVsMAkKAl2xGmDjPTj0wF2Po0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707230; c=relaxed/simple;
	bh=H4uiKZm/KRv5avKt/wGGPYJKxnG36vKbTMBi+ssqPxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mp57/q85Sn9bS9dCKfeJoqgX585efylnS52FrUudQMGBkVc43UI/kMcy2N/JyEXQk7wCWJFF1dnXO7GzOHXizC2wUkNKK7Z3rBOVTRc6TmlPUbXqr6m3PWknS14/CIzdG2CWCq2SKALSjz9q3jUWZzAsezCzZlGMqyeamU4zu4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=V4E0KIp5; arc=fail smtp.client-ip=40.107.93.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzQp+NI+EAoY87PDYzJL9X9HTT+u6yPoCzJr8HwHBo6oLpkXZq+hOPkVql/sibW3gMApfQJM/C4MF3vQ8ygXQHUo/qs/6p1h2tHU3HdLg7BR2V/Vfab8rQYzw09YTR+uJqoWSQdsXGo+KBY17jdZxpWFLvfB1Vn5Q3+pVZaHLohm5IIgcyrS+r0taaHZRV3npYe5q8rm78sw7I6myx3Vx6bmSwDgowAQYz4MpwkKSSX/+C6f47o/ajdC8E2dsgba01YhUpaTJrM5dpf8fjXnSkdGIT2gb6SaTZZ5Xbs73g0V05JpgYB2dHG4YVqKLS6vbCAPsDvR6Pv8SThWBfL2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nni7Egkd9ekpDnKpIwEfIsN0HZfZZyBBCH/qPOyDUuM=;
 b=jU3qqPicEPGczP/D8iMghh1kwWJxTSxgJYZ8gCYVe+ItH7pYvpqoZ3LZg+icoy0szbGMRvobfhrL0dFFk3fsRzVbYbaadEhzl9ZRLrDUDaj3vU7zBqLI06lVdcHuoSHHfBY9CcaRrhVUP9G0PNjDH8JoirKOz3zVsfMV21B8vzMDvyLsuBrRQ+8/JAtKX7m7wegJzwVV4KxroazmZ8/nZCkzukaTTQTSOLGrEXU9Zb6qRSp5jCnJUzJF+7PrvCJ0kxcXxJuJmQAD8E2kwHbbIEuvDcglvpKjzKLydfGm4gvi+u7qMktDaxymYdwDlc2WFRkzGBZIG0x1mbEKMIS5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nni7Egkd9ekpDnKpIwEfIsN0HZfZZyBBCH/qPOyDUuM=;
 b=V4E0KIp5Ws0mAxko4m0Adf+giM9zgP8CRjZvTPlGoe7Tl/oFE6OPKdka24eo3RhGgNSKXuC3jdiXqYJaLutxe7j6D0av6B7l6qk4p4wWralEdj8lzQClI78/cm9W7345ie+xFMNokD3CdfFKs010oFt/aLNSbUFeD2ZWd5bB7bg=
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4398.namprd17.prod.outlook.com (2603:10b6:a03:29b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 00:00:25 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.049; Wed, 10 Apr 2024
 00:00:25 +0000
Date: Tue, 9 Apr 2024 20:00:18 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
	akpm@linux-foundation.org, apopple@nvidia.com,
	baolin.wang@linux.alibaba.com, dave.jiang@intel.com,
	hyeongtak.ji@sk.com, kernel_team@skhynix.com, linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	rakie.kim@sk.com, rostedt@goodmis.org, surenb@google.com,
	yangx.jy@fujitsu.com, ying.huang@intel.com, ziy@nvidia.com,
	42.hyeyoo@gmail.com, art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 0/7] DAMON based tiered memory management for CXL
Message-ID: <ZhXWksusMnVKElmf@memverge.com>
References: <ZhAtLhcU3KfT/9i7@memverge.com>
 <20240408134108.2970-1-honggyu.kim@sk.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408134108.2970-1-honggyu.kim@sk.com>
X-ClientProxiedBy: PH8PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::13) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4398:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OoAKf+DRCnorOuRircvgxPHmSDrIckdWD8mL3aqmfZtcqcGp6EMhXFK+9tOr0xcjXFMQ3ZdAPexwmkcvoRHLGKnwElPY8bEwunkVAFxtPL4vU5YKQf0K6vccA++7NqV4ILKsOVAEpMiWM7DNM4KOUIPUWC4XUzwjB8ohdirc1df8EpD7IB3sujx1u4lT/c7eaWxPvYdmBXRPJ7UFhC3CAyDKJwg5FNUaDHJgpdP6b7C0s0DJKy+3WHKl53aazv62QydNz3YCZKZ8Sii1qUOuwal/wPqPdwhrJjg2IRZX2xamjP0qeDkLmwalJbDrVAA0MoU3YkzNT8ktulSy8LEsd9pVhP7PV8Q3jlkYDIKl5LiMGtsFZniMbKGjin4VXOdrv0QfPX4vuwFhcIEAwNi519JLIvdLhbPOqTmehlNPpR0/LhadiFXZoal3Q/BQV6REu0fiXxxykxcVc561ZxVHdrLsat5+Utx374FD5eJ5sEJOxjDlaT1K5FKiYRneVddOwuXWZea0mD+OjDjkYIl2REjfzLa0EfhiwMNq6wfEg+X5jJKdNA1mnUd3BvS6qDvnIqtfFBig6vWwkCPvIbyxYPBLSlYD5BSlw6jMuqo3jIFyxbVTczaTkhIPy+9BnEwi7cO+WSdVE6tMtmZv6/1D6JZFLhOx9C5KlTyA0q8dLe8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?US1L8cdvj4tgQXoBj5jjzmDtby/BO7BeIrJJWLeFMR4gCujotsGWJ5T+pMP9?=
 =?us-ascii?Q?HalZtx13aLwCKUk5blE7Jm2wVFePxClMjaIlWMDtqaf9c2+12ipFU4lhOQ3G?=
 =?us-ascii?Q?yj9dXc/ZlXYEUNBKm+HdMvei3Jmv/EbM8dGv6RO2+AJOAxwKSSB1lmh9qJOd?=
 =?us-ascii?Q?RoSndDpmKFm2TucDxHHEknHwbennuAo1qlssSk1B9RbCE6BeyeM9ljU/jsCm?=
 =?us-ascii?Q?8uBOTh/AaO54ZHqSgAjhdjFW78LHVsyT6GmmmV4KPHVT4NOWru6ZMPgo3/kv?=
 =?us-ascii?Q?8jKNZccsPJq99RjqG170gJhf1HHJFqSm+SFvWwonD4xAOrIjTSLvI7cS66NW?=
 =?us-ascii?Q?8HmVbdI8al9MNWBgd38nHRWF7SLaDRuDNaXrmLhsY+ZHOBmss0sXZdeaOO3q?=
 =?us-ascii?Q?SVa7vofXAX4KxiFW8EF4vdywEEr83XmYLT5PnQCDeiynwp0ZmJ5EkPNlKc2I?=
 =?us-ascii?Q?xaPGdwG31VWeShnEscy4vCxuHoMAzoBp3RhtcW8U5N51vTOdWGn0UHMXejDd?=
 =?us-ascii?Q?VqorpkSBAnSJW971cB2vtS5Fx2F4QfJCaETeBXklnCgy9QZu5YL5MZrW95Y+?=
 =?us-ascii?Q?+P//BdaUUyfMbNbVKiS4cbCiGevFNzYPQN6pykVEm7NvHmt4TErq3Q4gSeom?=
 =?us-ascii?Q?JuiIk8DVZB1PDGead7ydBMjrQW0Dp/kVYXaXt5l70UQjBe5ZlhrEDyOYqFIx?=
 =?us-ascii?Q?fl+WM2/cHtlqG7XTDM5C7FnJ/0VngOxGDjPDMMEPiL9HcB0sAByRtbTvnu0y?=
 =?us-ascii?Q?GIJrPn2QyivYx90K/2t/AJhMKog6ed7luNou21wgakEISBQ2lgnKNm9YteUK?=
 =?us-ascii?Q?deJWoudBsmb+lmWS3FKOVfwfW/RgTQfhvGbtcrzP5pJSn+Y2lJSTbERTonXN?=
 =?us-ascii?Q?t/94Fd/Bh0yGaY4FYwElgYiVWLIB9Hs7Y+EegKG6RD1n4PRYHiQTqC7I3wo3?=
 =?us-ascii?Q?tHKCEg/+QYiHSLH2b16ROspkYy7HsCIyxmZ7eoPi6IUhGvYJwobD5y70aLAg?=
 =?us-ascii?Q?qZMw8kCjVK1aJdm8W/OX/Yb8Qx7d9RrQ3a5dAO0NbMUqK/9LH6PckSaBqLI5?=
 =?us-ascii?Q?a7aZO9ynUdf5nexscAys+SePFHS+ygpK/qa+UYPmeE5i42nlsFcEBuawDvst?=
 =?us-ascii?Q?JQlqWF7e4gD88nMJQO+kasH/AWmsK1F3EpCnqA4ohv2CEfzAnWRTG5dNmz/l?=
 =?us-ascii?Q?uS+Y6sBf5pQP4Fify3aMfwtD6vgKscoNwcfPskfizj3vC4VhPBeQIBZCZvm9?=
 =?us-ascii?Q?g1cnmFy0hvJ1ScZfKInKUtJ4VuNdmdkMmC/bTDKzSulJnbRod7Q7Vis7Y0xX?=
 =?us-ascii?Q?sGoQFAUHAiROuohNlhlEO30jyq4jtMZdEl4gOJpUEnNij8wPyrlK7sTjx0Aq?=
 =?us-ascii?Q?2o7R5dEdzRyiNc2pjAgUA4wyobULMl6h6nKl787eyyhNuW0E0+/MO1zNaOCP?=
 =?us-ascii?Q?yzlKTTAum1qqJ8GnGVCLFp0iz3Vu4Rzoy8ohuVuEzz34uI+uEempvtJjpt9C?=
 =?us-ascii?Q?iAOYRvWYcNCMxp/ljCeY7sFiC/+2gyHPC+olHKsyKYcwX8bK7H2HaxUzLKiP?=
 =?us-ascii?Q?p+wPGSaI+0fmcbdllYzesScxo5hkziPZVlaytVy1Z3arIV9t6HUOEL1Iah6d?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2443ee24-29be-4c1c-65c6-08dc58f13994
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:00:25.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOkzgLdo0JO4LXoLigd1K4GJhsOYURC1YqbN9VlUkt42vklrlrxLv7ZKVrfRQfyT3xzMb3W5z5GAt7DHBgwUGrK0ikPlxVw8PsNGVsF6mO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4398

On Mon, Apr 08, 2024 at 10:41:04PM +0900, Honggyu Kim wrote:
> Hi Gregory,
> 
> On Fri, 5 Apr 2024 12:56:14 -0400 Gregory Price <gregory.price@memverge.com> wrote:
> > Do you have test results which enable only DAMOS_MIGRATE_COLD actions
> > but not DAMOS_MIGRATE_HOT actions? (and vice versa)
> > 
> > The question I have is exactly how often is MIGRATE_HOT actually being
> > utilized, and how much data is being moved. Testing MIGRATE_COLD only
> > would at least give a rough approximation of that.
> 
> To explain this, I better share more test results.  In the section of
> "Evaluation Workload", the test sequence can be summarized as follows.
> 
>   *. "Turn on DAMON."
>   1. Allocate cold memory(mmap+memset) at DRAM node, then make the
>      process sleep.
>   2. Launch redis-server and load prebaked snapshot image, dump.rdb.
>      (85GB consumed: 52GB for anon and 33GB for file cache)

Aha! I see now, you are allocating memory to ensure the real workload
(redis-server) pressures the DRAM tier and causes "spillage" to the CXL
tier, and then measure the overhead in different scenarios.

I would still love to know what the result of a demote-only system would
produce, mosty because it would very clearly demonstrate the value of
the demote+promote system when the system is memory-pressured.

Given the additional results below, it shows a demote-only system would
likely trend toward CXL-only, and so this shows an affirmative support
for the promotion logic.

Just another datum that is useful and paints a more complete picture.

> I didn't want to make the evaluation too long in the cover letter, but
> I have also evaluated another senario, which lazyly enabled DAMON just
> before YCSB run at step 4.  I will call this test as "DAMON lazy".  This
> is missing part from the cover letter.
> 
>   1. Allocate cold memory(mmap+memset) at DRAM node, then make the
>      process sleep.
>   2. Launch redis-server and load prebaked snapshot image, dump.rdb.
>      (85GB consumed: 52GB for anon and 33GB for file cache)
>   *. "Turn on DAMON."
> 
> In the "DAMON lazy" senario, DAMON started monitoring late so the
> initial redis-server placement is same as "default", but started to
> demote cold data and promote redis data just before YCSB run.
>

This is excellent and definitely demonstrates part of the picture I was
alluding to, thank you for the additional data!

> 
> I have included "DAMON lazy" result and also the migration size by new
> DAMOS migrate actions.  Please note that demotion size is way higher
> than promotion because promotion target is only for redis data, but
> demotion target includes huge cold memory allocated by mmap + memset.
> (there could be some ping-pong issue though.)
> 
> As you mentioned, "DAMON tiered" case gets more benefit because new
> redis allocations go to DRAM more than "default", but it also gets
> benefit from promotion when it is under higher memory pressure as shown
> in 490G and 500G cases.  It promotes 22GB and 17GB of redis data to DRAM
> from CXL.

I think a better way of saying this is that "DAMON tiered" more
effectively mitigates the effect of memory-pressure on faster tier
before spillage occurs, while "DAMON lazy" demonstrates the expected
performance of the system after memory pressure outruns the demotion
logic, so you wind up with hot data stuck in the slow tier.

There are some out there that would simply say "just demote more
aggressively", so this is useful information for the discussion.

+/- ~2% despite greater meomry migration is an excellent result

> > Can you also provide the DRAM-only results for each test?  Presumably,
> > as workload size increases from 440G to 500G, the system probably starts
> > using some amount of swap/zswap/whatever.  It would be good to know how
> > this system compares to swap small amounts of overflow.
> 
> It looks like my explanation doesn't correctly inform you.   The size
> from 440GB to 500GB is for pre allocated cold data to give memory
> pressure on the system so that redis-server cannot be fully allocated at
> fast DRAM, then partially allocated at CXL memory as well.
> 

Yes, sorry for the misunderstanding.  This makes it much clearer.

> 
> I hope my explanation is helpful for you to understand.  Please let me
> know if you have more questions.
>

Excellent work, exciting results! Thank you for the additional answers
:]

~Gregory

