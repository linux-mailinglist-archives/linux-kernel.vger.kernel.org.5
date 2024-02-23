Return-Path: <linux-kernel+bounces-77801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F6860A65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AA11C228B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A711CB6;
	Fri, 23 Feb 2024 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="ZmMCt5KH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4D11CAD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667254; cv=fail; b=HSAX/LNcI8KJqDzCFv1hQjLZvtgRgQST63sjgjF5ctp/AvZveuabot+vT5fSw+0ZE3yICWWQSds/K+IBsClgoEgldflX4sL1wMZdXX3FhrHC5sXcmjPCPkCvhWx/0NvXJz10MWQG+zISMba1yOPfmZgGxE/Q7Q30tNyhAgfUdVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667254; c=relaxed/simple;
	bh=RqgtiePwFQTHbS59aguy1W8y7wtUL70fWzrmPhM0nUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ler56gZAhQyTIllUROeiIIAB47BmDlvS5lql0+LUqFHnj6AFGPy9QoQjvir36eVT99wK7e8nqfJU7dEXs3QnQ2dz93axxJSA5eS+rlH1t2fx7JPFoOypdIs7NyNwOrKyNWa1zyMcBw99eM7tEsyoJkEayZS2LtfZm8qRoFLMSdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=ZmMCt5KH; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTDzRPhazuW+1wPWVy9kFZuECEqopD5viojyq0EymdZAeTPijT3VjhYQS1KnjkIVO5h6r1/9yxPaDxRadsPvGQ6lVikDp1e1+C5PpaZqHYnQey15db/8Wgg0hbyRVUjV3673+VHkeiBq7r5GRSSyTJwvJj54yuwNPrkpDNh6sniy9qcf+xBvCxuQAyuXBoMGaTZNufyi2yMKg6Eq7QX9aBnLrR7f4Vz6c7/OxR8SJV7TF7DQ0v65kjurqd7VwQEPqZ/i74JgswEtoghWEmmeqWTrOB57z6lchVPcO7+L9afQdIRr/ZQvv5iuKfPMTvyZ3qeZHrHsFgxvh0uCHFgcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBxyYbxGXzdeplhPo/gqLZ/nwWe4mkrbUXkJ7VcHaBM=;
 b=GFfHfw6udQBD+jjOTYz32la+7wTLLX7xq8IvmRxveDw9w8Ld/44LbkM32Qjk4DxUyb8e20Yo2Oca65Xh2MoXs3NtafM6ozSXhrvGbhJtCgDc3RlWhhhSjPONQTn86Xe4P8YQgC55i5dYU5LjkSCBN5uTOPGV1/So0x+PqbzbN6mnC9KWhD928DuMjJN7/SWgTvP3+8XhPlKZUa/ajnU9BeyazqARL+NhdH6mIdJEWWy1oe0dOoXWzMM/Qt/5fJ2G4Go0enzjq9K88+RPuyBh+65Gbsk6en+z4rAOJDQdC0OLhFnf7vFzfG1hnEVAbSGSASNf1x1yI6QK+/UrsKkhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBxyYbxGXzdeplhPo/gqLZ/nwWe4mkrbUXkJ7VcHaBM=;
 b=ZmMCt5KHEMAcsM10kFwRv2hB5bwHTcf1OBKc1+lTsdvjIYS0Io6TGeJ9s1GGcUP7hbx5Z1Ya2EumEYo26Nhi2zDvhdiSqSElH7OmGzsioBpws9R8/Vttm0+qK8ihjffPaIdc3BCrn7tOFm3dR6H6PJcmPrfRG5IMwnONlQi5WRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SN7PR17MB6803.namprd17.prod.outlook.com (2603:10b6:806:2dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 05:47:29 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 05:47:28 +0000
Date: Fri, 23 Feb 2024 00:47:20 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, dave.jiang@intel.com
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
Message-ID: <ZdgxaLSBznupVmJK@memverge.com>
References: <20240220202529.2365-1-gregory.price@memverge.com>
 <20240220202529.2365-2-gregory.price@memverge.com>
 <87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::30) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SN7PR17MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c720f6-be28-4e0d-6fa8-08dc3432eb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XZmV1CHqYnhXvV52Txbjv7T0x4yK5FtFQpKAMCVQiFfJGNg+hsRV23E7Xg5M75QNGARH9PSvfE1oDLKi5y3zUR6qtpjMVpCOKAUiJ8BgdGiEshJIIHAiiE5TkqIyVoQKgiJmnrc0geXDiwH4IzcW6aB52EQEtqr2ElgoP0ZZ98BwJILu08ipJczTcu9BGUOvkgtwF0m29mmRRprCRMulCtDdQhvZU0AEKXftwmY26hwqkZq66+N41E4+BboqX0yylHK12fzeqMoUpGz501xtLsPQCYHjaK8SCeM75y5CYt7bgjQiCM3w7pfBUvfs5MYvF8BdeEK/JVVLbKohFIcATzuqvx0NN8HtjRmniI0NWemuOk9IgsxyvVp7JORLcxIp7isYhlw7V0JBs+/sOQ/5BKP/uHQ4P08iViBvDvIZryQY3fksm5ajzpInsYVrsBwC30RMfhD0ThTG2cS4ThpX8bP3QcPuXMK3cmiAKWBF1XAnZURoNI1eAcisnI/RuOKUrfVtp8TUExKU2Q5Frmmkyw+Rh4SxRqigtX5hjvBDnLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vh0yRjmt7E+RT7fYLLc2Q7wjToiZihTarlVo6bPBrMJQsL6pvudl3ycN5QtL?=
 =?us-ascii?Q?i4zid05rB70NdYiQ4Dns3u6uQxL/Zv8Wzdf8+OKtpBQorSu6Nm0Xl7i8hx+a?=
 =?us-ascii?Q?Tm3iBa5oNvP6jqZFqfHQ3dMnop44oiGSWEyNvNzJyanWWIr8TEuw/ZsNm8Gq?=
 =?us-ascii?Q?V5wfboMQ7x6f3dEc9CsmqZ9efR/Q6VjYbprwOBIfLJsAkQ4SyLyhUReBtAnr?=
 =?us-ascii?Q?FLQ25uQZlOSYDnMWdgIikkR1KaqcLr4tR/Cy6Ys4tePp7VoWEWs572+qNV69?=
 =?us-ascii?Q?MGHZ651CDjvAkDEXDMRrGUof1MwVGKNsGuy2iuMLvhr5cZBeSH5Wu12/csFf?=
 =?us-ascii?Q?d6oj637hHCjoEB18I93M0dkHCTqe/kbbNqMmklCA/Fm2u0Hgksml/CXSCQSA?=
 =?us-ascii?Q?QhrsncgU7m8hEsl02LTTMoeQ6gdLqPgEf4gPfzB41ENuKccA1uveyn7CK7Oc?=
 =?us-ascii?Q?yH0ax67QbQNkYGzElN0HMmX+KWnGmIEdtbe8QyrLiYkx2asEW71p+he2FkTm?=
 =?us-ascii?Q?CiPvJb1F4K0Gn070gRZaTim3+qGiAp61ezwlLtSVrwJaGz+imET/WwD0rVY1?=
 =?us-ascii?Q?B+IqQaR/CemjP4VrjMo+rZeZz/Opnre2MHS4+XMjM0EU5aEqpA0SJNfzAtJ/?=
 =?us-ascii?Q?smrvossLiqFiQzgcdRoeChGiC+pteIupyQudxZodDz0IwyHUQcV+LyDRQdnx?=
 =?us-ascii?Q?wxAXhRhlwNUTGyoqR05pkZAXntV3vBSR+nldlanIy4aBBLzE4AfHvWPq4z/i?=
 =?us-ascii?Q?8LBExF+dBLOfoUP46W0z6AOVgUQ2VnOmCs0/1euHc/KI41R6tnM1FzsjWBLx?=
 =?us-ascii?Q?6W/iM2LH8V21z7ERfPE9v1rgmc9teoh+BGqRiF422w8eo2Y0fOczx2wrH2Or?=
 =?us-ascii?Q?Y6aZYRdHYXHx9grCBHQOkiGmINeKOT/2Di48WcsLvDIA7Lak72RbKWu9oyWC?=
 =?us-ascii?Q?vNHz5P2ihBOd4jl2+YM4xqxz3Nlh/AUV6xQNbF7/sW2pmUCs2h/mPt25hPj6?=
 =?us-ascii?Q?k23cueCbJS49ve+wdj9X6dHLTqjQzFTkYV6S6Rd5blf4AJ5GvwCu7n+3of1W?=
 =?us-ascii?Q?R43Rt3QpZ7vHd8JiTeyx5FcWORHHwG3hT0f3lTSUXdY7+YYykYEflr628hHA?=
 =?us-ascii?Q?cR/aYi1JBUNNxU/ohmezghIQKiCLmcIHjMJhYR9Y598QsIDOS+Fm+spsQrN6?=
 =?us-ascii?Q?45zRrE3TBRvbTbQm9bY5BEmvNjZ/F9DD5eSR9E+uAfJ1OmzW1Ho7yulEL6Yz?=
 =?us-ascii?Q?VqoB8Ni2PxtR4yCqKmnFVW2Gcwq1te2LXYVcDZ6ql0cZ8f/grUsTEdtx6raq?=
 =?us-ascii?Q?6XSo3avPWojeLtStbSs8JX/YLT0uisbxb3L6G/VpGFye4C2JXO25/AqsODW/?=
 =?us-ascii?Q?rov1TJmbwe9IBRMUfRwjRZeADEYjYZkPFlQNSabcQxAS9nw4YfLDnedU0Cu4?=
 =?us-ascii?Q?C/aw73jKVt0f5etEYIShCGlgKgR6ZJJXKzhlzyvSRIl9PZcf0Ds6xXd+/0qA?=
 =?us-ascii?Q?ffzImAfiA8PuwLnX5X/ABL7PFj/NhZ8lqgh8mV8GPLzV5mJlIsEvRscobArF?=
 =?us-ascii?Q?i9MdONp+4wqDTPLMg8fsMU3vPHy+xFyfZNc+K0AX2QfGvN/oMmeWGBIIrX9u?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c720f6-be28-4e0d-6fa8-08dc3432eb7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 05:47:28.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAwCn5Y6Fxct02MRx9+qGHoYK5hh/6eRYIA+J/7BaGcqb8D522t1K3MyG3QtpkKGhXgELP9VS3zfFUJFn7ti5HWT5aBSwapg1h89MeQJRIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR17MB6803

On Thu, Feb 22, 2024 at 03:10:11PM +0800, Huang, Ying wrote:
> Hi, Gregory,
> 
> Thanks a lot for working on this!
> 

It's worth doing :]

> > +	new_bw = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
> > +	if (!new_bw)
> > +		return -ENOMEM;
> 
> We only use "node_bw_table" in this function with "default_iwt_lock"
> held.  So, we don't need to copy-on-write?  Just change in place?
> 

I'd originally planned to add a sysfs entry for the data, which would
have added RCU to this, but i realized it's just duplicating the
node/accessX/initiator information, so i'll rip this out and just do in
place changes.

> > +	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
> > +	if (!new_iw) {
> > +		kfree(new_bw);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	mutex_lock(&default_iwt_lock);
> > +	old_bw = node_bw_table;
> > +	old_iw = rcu_dereference_protected(default_iw_table,
> > +					   lockdep_is_held(&default_iwt_lock));
> > +
> > +	if (old_bw)
> > +		memcpy(new_bw, old_bw, nr_node_ids*sizeof(unsigned long));
> > +	new_bw[node] = min(coords->read_bandwidth, coords->write_bandwidth);
> 
> We need to compress two bandwidth data into one.  The possible choice
> could be,
> 
> - min(coords->read_bandwidth, coords->write_bandwidth), that is, your code
> 
> - coords->read_bandwidth + coords->write_bandwidth
> 
> I don't know which one is better.  Do you have some use cases to help to
> determine which one is better?

More generally:  Are either read_bandwidth or write_bandwidth values
even worth trusting as-is?  Should they be combined? Averaged?
Minimumed? Maximumed?  Should they be floored to some reasonably round
number?  These are the comments i'm hoping to garner :].

I've also considered maybe adding a weighted_interleave/read_write_ratio
sysfs entry that informs the system on how to treat the incoming
numbers.  This would require us to cache more information, obviously.

I have limited access to hardware, but here is one datum from an Intel
platform w/ a sample CXL memory expander.

# DRAM on node0
cat /sys/bus/node/devices/node0/access0/initiators/*bandwidth
262100 < read
176100 < write

Notice the 90GB/s difference between read and write, and the trailing
100! That doesn't look to be good for a clean reduction :[

# CXL 1.1 device on node2
cat /sys/bus/node/devices/node2/access0/initiators/*bandwidth
 60000 < read
 60000 < write

These are pretty un-even distributions, and we may want to consider
forcing numbers to be a little more round - otherwise we're doomed to
just end up with whatever the ~/100 value is. Or we need to come up with
some reduction that gets us down to reasonable small interleave values.

In this scenario, we end up with:
>>> 60000+176100
236100
>>> 60000/236100
0.25412960609911056
>>> 176100/236100
0.7458703939008895

Which turns into 25:74 if you jsut round down, or 25:75 if you round up.

The problem is that any heuristic you come up with for rounding out the
bandwidth values is bound to have degenerate results. What happens if I
add another CXL memory expander? What happens with 2DPC? etc.

I wanted to collect some thoughts on this.  I'm not sure what the best
"General" approach would be, and we may need some more data from people
with access to more varied hardware.

Maybe worth submitting to LSF/MM for a quick discussion, but I think
we'll need some help figuring this one out.

> > +
> > +	/* New recalculate the bandwidth distribution given the new info */
> > +	for (i = 0; i < nr_node_ids; i++)
> > +		ttl_bw += new_bw[i];
> > +
> > +	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
> > +	for (i = 0; i < nr_node_ids; i++) {
> > +		if (new_bw[i])
> > +			new_iw[i] = max((100 * new_bw[i] / ttl_bw), 1);
> > +		else
> > +			new_iw[i] = 1;
> 
> If we lacks performance data for some node, it will use "1" as default
> weight.  It doesn't look like the best solution for me.  How about use
> the average available bandwidth to calculate the default weight?  Or use
> memory bandwidth of node 0 if performance data is missing?
> 

If we lack performance data for a node, it's one of 3 cases

1) The device did not provide HMAT information
2) We did not integrate that driver into the system yet.
3) The node is not online yet (therefore the data hasn't been reported)

#2 and #3 are not issues, the only real issue is #1.

In this scenario, I'm not sure what to do.  We must have a non-0 value
for that device (to avoid div-by-0), but setting an abitrarily large
value also seems bad.

My thought was that if you are using weighted interleave, you're
probably already pretty confident that your environment is reasonably
sane - i.e. HMAT is providing the values.

> > +	}
> > +	/*
> > +	 * Now attempt to aggressively reduce the interleave weights by GCD
> > +	 * We want smaller interleave intervals to have a better distribution
> > +	 * of memory, even on smaller memory regions. If weights are divisible
> > +	 * by each other, we can do some quick math to aggresively squash them.
> > +	 */
> > +reduce:
> > +	gcd_val = new_iw[i];
> 
> "i" will be "nr_node_ids" in the first loop.  Right?
> 

ah good catch, this should be new_iw[node_being_updated], will update

> > -		weight = table ? table[nid] : 1;
> > -		weight = weight ? weight : 1;
> > +		weight = table ? table[nid] : 0;
> > +		weight = weight ? weight :
> > +				  (default_table ? default_table[nid] : 1);
> 
> This becomes long.  I think that we should define a help function for this.

Maybe? I didn't bother since it's not replicated elsewhere.  It does
look similar to the help function which fetches the node weight, but
that function itself calls rcu_read_lock() since it is called during the
bulk allocator.

I think probably some more thought could be put into this interaction,
this was just a first pass.  Certainly could be improved.

Thanks for the feedback, will chew on it a bit.  Let me know your
thoughts on the bandwidth examples above if you have any.

~Gregory

