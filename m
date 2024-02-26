Return-Path: <linux-kernel+bounces-81627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60E0867881
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B6A1C287D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2204912BEB5;
	Mon, 26 Feb 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="hCwx3Zo/"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2122.outbound.protection.outlook.com [40.107.223.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5F266D4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957814; cv=fail; b=dt/fOkmWneCuXUipXWhNMHV2r/PIqLdB4C5Nc0WfDKtR4629sV9r2TdXMhTD8n43blzjKWb7YacN0I0cv3UoMAdJShZst1KNuixc5K18Nv3BTOMFox8tm7TfjdzbEzDlcuvqwAjySCXQBXcXX1DEKq9hgab+kqBoXmYW612c9pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957814; c=relaxed/simple;
	bh=PZNQJuXsnfhb4CQS4KiM05+B47MQs9b4GezIJUr/uns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VYpXdrBYmHpCLuPMl9jaJq87wPFVjT9OwFGwNfjD/rSewxqLKTOnc/+wzl7Xz6iR35Db7ya8o5osRy9Kog+XwZ4DkgJ1WYlPHjeLUo2n50orAvLP6+uuIFuuNsIyM8Bvg+Wa1dVHKfVI8onJ/XdggHKXPQLb25kU9JwB5raGtXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=hCwx3Zo/; arc=fail smtp.client-ip=40.107.223.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZBPCdVVTfK3TCQW48X0pJj1tWYqpUraoboCyLKf+ZV57pA4OVbCeL7Qn6Le70O91KvYSzvI5p3OrAc9g/rQXjcok1J8ob6svjTyWXUsGQ22NxKfjC87h1FWDNE091/JFq+3dOHXrYdyJMetu/8ya6I4sp1m+Zhz3rRO8+Je/U2dp7EK+DcTOPgA40YpnH1BNsDcmWPk4ClLJ1phonvEOzo+NmPi0p00WYnVXe+u59qKIwielJJl2U8Kn+fCUur1peZLQ2XpAlp7zul++kYLoys+xPisGiVwSfz4pai8i+HVdE6pe8jBn6uqNX9k8tl2QQ5KDVUonpjRSpFs5xSklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oxZUW9g9kiXeSSvpXUbSMNlbQAL8WuJ273GwvftyHE=;
 b=Z6QJX8RpYgZ18LxMcB0VM8wpw38rE+jOSneF4a6JCWfVzdWdk8LQarBR0P171yQoa+JpiGK7eVuq9vfOgRtrt25EbJiZUT2mVYgJN1zAxJlrQpV+PMy+uuTKUTb656QvyNz2VVIJr7NJGFJRXOwVg+MCUicu8f8htDviXKJxKqYS6gB4Tmf3WHAV2wWpHEjeuqUVLez8LLrWdJCRpMGrqLlKV+5RjHGc6tUelh/ZqcnaJjr2fIaspLgE+67J5ItLZGnjok50hxkprIMtWkmoPQzE4sAIGrPM5BRvpxxnYwrThPrZWYHrO9IEDtW/fzDFlI+2MZenXpVpImSQOHgk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oxZUW9g9kiXeSSvpXUbSMNlbQAL8WuJ273GwvftyHE=;
 b=hCwx3Zo/4jSeP18LhR6paBL8jk3r1EQhbJ+7skZM8AJ8afE/5JitvRkslnrrPA6ryG+3bJs2I3zm7MKHZoMr5/tyRsViXGpgi2qYt4ruahRQzqEMwqee3psYShECY5bw1jytB0WTTdjq0zEUIBBvBBO+bWantvkCrLNH1v9VTCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA0PR17MB4395.namprd17.prod.outlook.com (2603:10b6:806:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 14:30:09 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468%6]) with mapi id 15.20.7316.023; Mon, 26 Feb 2024
 14:30:09 +0000
Date: Mon, 26 Feb 2024 09:29:59 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, dave.jiang@intel.com
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
Message-ID: <ZdygZ8ZidfaORg8F@memverge.com>
References: <20240220202529.2365-1-gregory.price@memverge.com>
 <20240220202529.2365-2-gregory.price@memverge.com>
 <87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZdgxaLSBznupVmJK@memverge.com>
 <87sf1jh7es.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf1jh7es.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: PH8PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA0PR17MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f533875-9ebb-4949-f828-08dc36d76f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	48nldePbNvuzqSQLwMeBqY5v3MRDdIh6bZi/5NP026ssiMmwh/P4EjCbk2h/daUIofaqXvTdsuXc3ml4q3X6kXfzyabMu3C/g8hm7LT6RXWRYPZbZji/4mkFE1wlstR+pdyo0FA9GEfIMfjlH84DS5KBJbVnLAQr4YcpVWJjMAY2dkPLKjQNuCqxjKLqtT/7fRIM4y5BlZu2r5HYpZWuC0nro7/lcZNy8FWCgLd1rYx/O5NGaIQBuMKhSUd2oGnK7K7HGZ7QmkEdRSw2bEfLkOxRsVgQK1zwwp20TpJX1YR1yx556MCbW76YLR3LUwhfTKiQKgJUsQ4vl+y3qvZe0+bfSTWzj879PfxHeO+GrqPKcMIIDD/Gn9MdjWMzPeKwqQFdISDRSe8RHcRE2kK8nPfPcCiQ6LYxkQvON+1YNDNduMMtnX6cduZsVPBgHfT9ztK5uo+9xIg26CGrZejO4900Q4gn/H93JMQ3rAwTIWWqF4Xn6l+r6PMFP+Nifuy3xACQMToQaN8gR/Xjp1Rs0eSIQ7vhJIJGyT4AjDOxznHYJskTHCkEgdDp74F6V7SXlWu4vbn+m/yUhyJ16BQT5o8IiPfEw74tZ5NqnngytgunYLg3RGWJhsy/WKit+mmV9BbtAiAGJzxjjUy6rGKrEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uBegDWmrRaHT+tnEUdwTyx4ZtTE+EfhfSuAEytEEOcA+gciaX5zcvX1UOXP5?=
 =?us-ascii?Q?BUJ5NruDbQpkf7fAPsNzYPDQsvTR+4PSFsaYAU4agJoOPogoo1TiPbfFSmzj?=
 =?us-ascii?Q?FaRkrY2HjcfkTZDVXBL33CoZVR3gt8FfsB/W00S+0N4Bqp7dRfSDRKlKrU0O?=
 =?us-ascii?Q?XiXtvjhaS9rnpkc08Ba8gXxZdeRMNKFTCl3e4SZvQ3C2h9iSw1bE5jeq4xrQ?=
 =?us-ascii?Q?BKlcsSvpL7Sxo++qAGj+90n4FIoADOOpgsfHV3wzcC/MElYK2dR8PuY59Zkt?=
 =?us-ascii?Q?S+a5qoRlb0N3Mc4aV3UhXnVAgxbQwkO7nh/DolmCtKD/NrY/ht+t9lKxj80W?=
 =?us-ascii?Q?KsxyAka/SyLAytvjAi+29qfHnsPamSg3stH9Oei4eDgYTZHkw6U1LNkwMqOa?=
 =?us-ascii?Q?Qb6aSWBDKR966Q7qpkEbn7ZidFx0OSnik6cmJaEFN/rF9NJTMBLcFcwYUgK1?=
 =?us-ascii?Q?/+94dSF+SpygnlrLoB6LugLyuNNbkvifrQfVV35WUa1dbtp3l64/ayAdPKYb?=
 =?us-ascii?Q?XFqgrTZ7CCgOG3f8FPQ4l26ZEEvpCTIHuA4xIR2LC9He/rSTO9ttHWdikGEb?=
 =?us-ascii?Q?Rt9dqO0frLzTFeSQtHe4Y9s9minrfPXkBp1x6qwoG+3eNrPB3R2W4Fm6db+O?=
 =?us-ascii?Q?wdQCBnSKEXGGww49udzIr8B3EKq5ol0oG4yOu6N/Huuutp523R9+YR1Fkiq8?=
 =?us-ascii?Q?9hLooU21zfdggaVI8eI0YO+IQcx4c/BW0cVEdIXpYd8T9yNicbaOLO2NnHYw?=
 =?us-ascii?Q?F1cJiNuQlixmX2anDVz/jzMB56NOKJYoQNOHlY6TkeEyOZUUFXAOkjvIX7t0?=
 =?us-ascii?Q?QMVMX1PDOviiKo5T7uuvIqmC5YYQqfKjr6BBRQEsSCsV/xGm+T1ns3TC/ya6?=
 =?us-ascii?Q?+FaVm2cuHwObTGxtTH4UBws8SnuuBhyv6IpVUUH7JCeXWl/KvJhQtaQhGKWl?=
 =?us-ascii?Q?8lh4G6p4srMS5EDQsF6/fa7BExtOeTn7VlTPkbG8+B5yAFpgFdkOBLgta049?=
 =?us-ascii?Q?yaE4PXHt625LEQAXRW6H8Sg6/P2bStWmhIu3+FbXDoJA8Sn4lfWexjQWLyKR?=
 =?us-ascii?Q?vSAHQ1inoCjCASifH/azHeHc8QVSEO6NxyO4n8UntStCcWF6/96fAYMt9Uw8?=
 =?us-ascii?Q?ho7VvysSFH1omjDKbb94UBPfGxhtfKUyG1Yl0jCC6KB3AmCVnFhVjXxnLATf?=
 =?us-ascii?Q?UM+cfMKV8JPqWrrzMIZes+57iuFBjIwqUqb+jjD8NNfiGVUgbXiSkHGgwtUQ?=
 =?us-ascii?Q?n2n5HDQVSx6FrajnUomdnLrPmMSyWGFO4ZAGqZwGO9Z3xDtLnic0MuM+1RwY?=
 =?us-ascii?Q?dnDBird4AvRbo3DTd+0kijJPknCBoXPUYujAyIT56f4m53Fjw0fXj21OJYTV?=
 =?us-ascii?Q?IaKwf/hEfUzN227PZNT5eicZ4FMk89d/LP4mbRCulADV8PPkcJGDBOlufWK9?=
 =?us-ascii?Q?C8xha6X5weXOde9xvCpaBogVvRHeXa4Hw+bHLuPAK0olAMVywLzRSJytULNm?=
 =?us-ascii?Q?LGtyjwCO/U4mMjK/VZ47BW5ltZNZAmzUaDQDQhD1rUrAZ8RYLCmxFOB3oGnW?=
 =?us-ascii?Q?XxYV8dE9RtD8CXdlY6aEvC5md9MD0fQwRkizplnwn/anFWbfmC0+8kNlq1sP?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f533875-9ebb-4949-f828-08dc36d76f3a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:30:09.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHBtQilmtdBhraw/UIn5bwAPp9Cb6bStNvgTBPyVmg7gi2G0ZWRhuM1YKJhbnexsGc6Cc3gLqYysnyU/cwKQWTY6b++3DvS0DM3VlHVp8f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4395


On Fri, Feb 23, 2024 at 05:11:23PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
>

(sorry for the re-send, error replying to list)

> >> > +	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
> >> > +	for (i = 0; i < nr_node_ids; i++) {
> >> > +		if (new_bw[i])
> >> > +			new_iw[i] = max((100 * new_bw[i] / ttl_bw), 1);
> 
> IIUC, the sum of interleave weights of all nodes will be 100.  If there
> are more than 100 nodes in the system, this doesn't work properly.  How
> about use some fixed number like "16" for DRAM node?
>

I suppose we could add a "type" value into the interface that says
what approximate "tier" a node is in, or we could ask the tiering
component for that information.  But what does this actually change?

You still calculate the percentage of bandwidth provided by each node,
and then just apply that to the larger default number. I don't see the
point in that - if each node provides less than 1% of the overall system
bandwidth, and larger numbers won't do much. In fact, we want smaller
numbers to spread spacially local data out more aggressively.

More important question: In what world is a large numa system liabile
to use this interface to any real benefit?


I'd briefly considered this, but I strayed away from supporting that
case.  Probably worth documenting, at the very least.

We had the cross-socket interleave discussion previously in the prior
series.  The question above simplifies (complicates?) to:  How useful
is interleave (weighted or not) in cross-socket workloads.

Consider the following configuration:


 ---------   A  --------    C    -------- D  ---------
 | DRAM0 | ---- | cpu0 |---UPI---| cpu1 |----| DRAM1 |
 ---------      --------         --------    ---------
	           | B              | E
                --------         --------
                | cxl0 |         | cxl1 |
                --------         --------

Theoretical throughputs

A&D: 512GB/s  (8 channel DDR5)
B&E: 64GB/s   (1 CXL/PCIe5 link)
C  : 62.4GB/s (3x UPI links)

Where are the 100 nodes coming from?

If it's across interconnects (UPI), then the throughput to remote
DRAM is better described by C, not A or D. However, we don't have
that information (maybe we should?).  More importantly... is
interleaving across these links even useful?  I suppose if you did
sub-numa clustering stuff and had an ultra-super-numa-aware piece
of software capable of keeping certain chunks of memory in certain
cores that might be useful.... but then you probably actually want
task-local weights as opposed to using the system default.

Otherwise, does a UPI link actually get the full throughput? Probably
only if the remote memory bus is unloaded.  If the remote bus is
loaded, then link C performance information is basically a lie.

I've been convinced (so far) that cross-socket interconnect
interleaving is not a real use-case unless you intend to only run
your software on a single socket and use the remote socket for
whatever you can swipe over the interconnect. In that case, you're
probably smart enough to set the interleave weights manually.


So what if the nodes are coming from many memory sources down one
or more local CXL links (link B from cpu0).

 ---------   A  --------
 | DRAM0 | ---- | cpu0 |
 ---------      --------
	           | B 
      ----------------------------
      |                          |
  --------                    --------
  | cxl0 |       ......       | cxlN |
  --------                    --------

In that case it would be better for many reasons to reconfigure the
system to combine those nodes into fewer nodes via a hardware interleave
set.  This can be done in hardware (at a switch), in BIOS (at the root
complex), or by the CXL Driver.  The result is fewer nodes, and the real
performance of that node can be calculated by the drivers and repoted
accordingly.



So coming back to this code:  Then why am I doing GCD across all
nodes, rather than taking the full topology into account?  Mostly
because the topological information is not easily available, would
be complex to communicate across components, and the full reduction
is a decent approximation anyway.

Example from above using real HMAT reported numbers

A&D: 176100
B&E: 60000
C:   Not a node, no information available.

Produces Node Weights

Calculating total system weighted averagee
A:37  D:37  B:12  E:12  (37 is prime so no reductions possible)

Calculating local-node relationships only
A:74--B:25  D:74--E:25  (GCD is 1, so no reductions possible)

Notice that 12+37 = 49 -  12/49 = 24%

So the ratios end up working out basically the same anyway, but
the smaller numbers produced by averaging over the entire system
are preferable to the "topologically aware" numbers anyway.


Obviously this breaks in a "large numa system" - but again...
is this even useful for those systems anyway? I contend: No.


This is still reasonable accurate in non-hogeneous systems

 ---------   A  --------    C    -------- D  ---------
 | DRAM0 | ---- | cpu0 |---UPI---| cpu1 |----| DRAM1 |
 ---------      --------         --------    ---------
	           | B
                --------
                | cxl0 |
                --------

In this system the numbers work out to:

Global:  A:42  B:14  D: 42  (GCD: 14)
Reduce:  A:3   B:1   D: 3

A user doing `-w --interleave=A,B` will get a ratio of 3:1, which
is pretty much spot on.


So, long winded winded way of saying:
- Could we use a larger default number? Yes.
- Does that actually help us? Not really, we want smaller numbers.
- Does this reduce to normal-interleave under large-numa systems? Yes.
- Does that matter? Probably not. It doesn't seem like a real use case.
- What if it is?  The workloads probably want task-local weights anyway.

> >
> > In this scenario, I'm not sure what to do.  We must have a non-0 value
> > for that device (to avoid div-by-0), but setting an abitrarily large
> > value also seems bad.
> 
> I think that it's kind of reasonable to use DRAM bandwidth for device
> without data.  If there are only DRAM nodes and nodes without data, this
> will make interleave weight to "1".
>

Yes, those nodes would reduce to 1.  Which is pretty much the best we can
do without accounting for interconnects - which as discussed above is not
really useful anyway.



I think I'll draft up an LSF/MM chat to see if we can garner more input.
If large-numa systems are a real issue, then yes we need to address it.

~Gregory

