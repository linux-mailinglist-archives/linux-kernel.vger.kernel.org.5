Return-Path: <linux-kernel+bounces-79268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C252861FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03312B23265
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF7214535B;
	Fri, 23 Feb 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lv2wQRP5"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB581119B;
	Fri, 23 Feb 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727706; cv=fail; b=e+Yauoe968T964N4jfMmwwvWA1j2xXDnpLm8bYP6vJerln9o6pbhW1k2C7miw5FiEQsG2vP3pW3Fp/l1IrE6maTqGj3Oa/ukDtfmpOpsAtVav8lWHymnQZVhGQZNwZe6IEmk5dRm6RBW4lL5xNmirTBoFHB3BR450I/o5M58srk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727706; c=relaxed/simple;
	bh=e1VLAHa43eDQVoCgJrHKhZ3vZH9ikvH/SxOn1ShgsgA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=so/gY/wYX2kqKc+5foGj2/UGvRvcOgvWk8+ZzfgKHSGGfbHm0oVRZVmKBlx6+GG49FYpEJbSALtCMG7Ube4TuZZq8bCwYuie+qEoQw89GJNRr1wvqcmCAX7z8O6KvE8dpxFoxrmJodWR+LTBuz6FHfQbvYdUy/OicZpWuZ8Se54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lv2wQRP5; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjpzCmbXdDSF41ywITz2CMANzZQWpVTM72nDNqaA5k5ucV96eDBKlSKBg1AknCi3bRKhRUHEa8HCOtSeoezk+25MhoYQPGex9Au9z854T+Ohua7A2BM3PmS1wIWy4EcNo/KAjUQJN788adDcHpg1ypQmbmwcUeEiXd96CaWRezTstTBENS5Ps7l3WOstSlYj2YnZKlK+yldRhI3yQGJ+zqG0bDtgo8ls2PUAW9xj/epQR+oAMjbVG4gV1ngSnyBu6O4jy7OEsrgn9Ij0qLnmr3DFrtLhfqFq9fnOevxSWFjpChXW6XcxkAiuxNxyj1gYaHciNmRHm/lf5gXOvK4Wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQEEwT0Gqtqlc8FAYC7VWNceJMqCXWoWjA8dmgBYjMc=;
 b=FLxku78xmykVgEjxKXl4ZSNapoJRX7wvk6uTRI0hhCDTX3P/Ly3rspr4xXBjiMzE9ns6O5FTU11z7OvqpVVJmTaQAK73WtZYQAte//3RBi1hkqV38XR/5/hCHRxQsBWP+bACaBQSEUnPZ6l5xKnElpg+SWWu04UifcaZ8pfcy3BrMjW6WT7vSPpGINerY8ZEObTrhWUvsebleLcdvTtEEAAJd7GjQfD2yTgiRh19RkUH5fCRJ9DtHFWEpQ6NJsUZ8EqWJFcvsG/rqrnxAH4GhtEaC0YsElyKD8TqMVUCXD7UUoLJpcl2i4whJUCMsjWJbfjABXF7MLlre+bH4HcMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQEEwT0Gqtqlc8FAYC7VWNceJMqCXWoWjA8dmgBYjMc=;
 b=Lv2wQRP5I/I5ffIgN8rkyBUBfI6Gc+CXqQyrCuw7E1vt180ZaZwj290jbbzu/th+Dti6Xqu6kkcowdvexjIIcVEf1xSsG87/tCNLAD2KJJgGeFqQGi9tZB83FsDoMjAVHvQaz0dVbUo8km9lY9C4H47RCOq1dV9ZANpG1SXr/TUMih9HnL9ecU4Bx3D97GyInvIu4FiVw+Tf7W3VlPBTNRe9TfhURRLoQUCLa8Mz2PRWEmhBMZbNlVKEkgypQFPRI/weiYQmgsBIuZm/PqaXcioS8RazMl5A3AL7JcGJcfvBcyka1whJlKq9YLdBSacVZrgIA1i3ZXh/ObQhbTWM3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 22:35:02 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:35:01 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
 <richardcochran@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Ahmed  Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Paul  Greenwalt <paul.greenwalt@intel.com>, Justin
 Stitt <justinstitt@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Dragos  Tatulea <dtatulea@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Date: Fri, 23 Feb 2024 14:21:12 -0800
In-reply-to: <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com>
Message-ID: <875xyex10q.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ2PR12MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd88224-7109-44a1-d4f8-08dc34bfac7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f7iOX57eTOzr10uJ1jI69OdA4Qa6hBveiKReOH9xDsj1KqqgqIJQkPXFmuxRX7Mp8pvSgIrmAqyBdwgVW5MhKVw/Q7qXbsHZxKJOE5kf+/t6d+ZJqrPyV+1jlR3wHZyfs2YeK5gslhbDJvMWm1JMYDoJ3HwWaeAZ2daRe76KsHQL2tE2aPFim9+q4eYp9gjLjEf5GNfTlAAVy42RFI3/cPEBBPpCYBazgWaUfrsD1eh/NkX9x7I/wGrcFDOZAeKmZL/6nzjV7YrqDTIkyoQOXO0emyNfCY3xS+bnX67kbYwXYGPyMWH7RtI1O12ybgp5wCHjT2qt9bUgJQSfqV6j4CB/P+TXcBrSf0U80v3p7U9S+KUN0r3yg0Dqn62wbzxEqWP1Vn+mMj09X3TKKbekv6KJdMwnpnn/vLQXea63kFEC7+2uXN0WGAvlegQCy3Y4R1N5kr7v+hTIZJ+fAZl4U1MGQEdlZABp4YkAFF+uSVJ4BWl85xbv3OIpzSV5ByzkxUPzookUAGvMHKBM/w03GizFCa/fz/AMk7tIIydpNqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RSUEXLupRPDV+aq0OxwzCc1aZOaecQFNaQmvm2UYGtBAgiC6R1JZ0T1GF3F?=
 =?us-ascii?Q?PeAhzQQ19L86nT3R/Lv3TSlTn6USg1a5iDA6qiKuxUeUSvvbkqrk6CycLZmu?=
 =?us-ascii?Q?LXZYAuh0kj8iJUP1sW7G2o+VQzCyj45UHIApZJPpdklOrCnicaSnPA6vz0Ho?=
 =?us-ascii?Q?p/BuOfE1jhz/5yPfWiDF6nVPTpmCQ/I+RJw/APnDQ+hcpt9ke9iSJiPKfzSq?=
 =?us-ascii?Q?rIPzSqD8q37zxEHWzxJsiWHBoZx/oxWXglHE3gC2P1+ENvmZA/jy5SkMjyEo?=
 =?us-ascii?Q?KpesfzwBMG1oZ9qtPTdbKQfFf7LevmQyD2grH4B1CTJE70UFehoWvXmmb2NM?=
 =?us-ascii?Q?yXvM5V3xcDUQ9LlETBWXpOoQoeFdyQBOkBFfAXyjAqEcMM4NrhrRhjRAoA6E?=
 =?us-ascii?Q?pkOFYzbd0BnN2SW/6o0Qp5Hu+RA1cgamWZ2Ox6JrN5KGJKt1cG2U/Z7yFcP3?=
 =?us-ascii?Q?Pf23MuViODv/ayb/rcD3bGAxy5iOJv+jlx4ey23kPf9VQypIDug2omxHOkEq?=
 =?us-ascii?Q?HQS2xOdONjk265/mg6y8wlX4qS8lOUX50xcz/TDglOzYwSVqKLFvemFmuq+E?=
 =?us-ascii?Q?+Cp/z8wMaovDLz87rXPKLsrGQGI/PhXbeucOYn4mFGM+n7/2rFoapzHMzwl/?=
 =?us-ascii?Q?KzhXDbQa3PomM8tAfE60BMyNoJNzLQCpZk5H6MyJcnbi+iM8Evk9bfldwlxE?=
 =?us-ascii?Q?Nbi7EcdJwPtBFlivgG32jlCaV04lTTaGFJE8SbMactK60uiNP20b03mT0ht4?=
 =?us-ascii?Q?QO4tmyg3MIF/EvHr4yAGSMgnBeFPh+sODrh/5dvDzY1bwxjmnZa92skV9An4?=
 =?us-ascii?Q?LVUjTmvW81Ix0LsQ69l2QJ/4qq174gE6d/gPSTYocg6d9+I7RoETwLLBqgXr?=
 =?us-ascii?Q?vcFnNIjfDBzO9GVAl6nx5DSUGHj+ku9AqScSV1oLVBDlXKEQ4uTOW4/wX/dc?=
 =?us-ascii?Q?rQwbtvnZksfmHHnUiY0tlWjsR6c5J+/aVyPooye8zgmaXyRcc+cDxK7f5Bjw?=
 =?us-ascii?Q?gef+oEfHnpwbzelGdnMjug8vyOGTCgPY5fydSNjTb6meqWvpKzd7zHuzHKBz?=
 =?us-ascii?Q?t/t17cDealAg+IHgp7qlnXWrOkLqizHCNP/bYRf0480FYzwCC4bME+Nxo/c5?=
 =?us-ascii?Q?5k9BL91JYkWFJc5/VQzft1cU97taVHnb5kljludJwZd3JozmvPjjU+okrSGT?=
 =?us-ascii?Q?pEj3v7xMbntBAzSU2l7ITvx5qGim+3ZP+9E3l92ilEdBLe5Srf8N1LkLP3Pa?=
 =?us-ascii?Q?SIfS7wX0fxrlP9vLMULX5t4zA5V3G17tk94HC+bSqNoHE67MGa4N2t15edvt?=
 =?us-ascii?Q?k5Kx/nBtuteuJLOyGgOoMrLGDoS4LNDjCJq7qmP1tLe77UbE3BiCRMk4rWQN?=
 =?us-ascii?Q?qo1RTCOeySULTC7Z2z+Kxk7CLwuZJuGTiqGcnaMhRxq9lEWB3wGq6BS5uf+H?=
 =?us-ascii?Q?6PL1aD8VVAEyAeBIxJ12Duj9Wl5SfwUUsqDY/bSE6nxrSJr7LlrNwBE7Ohgv?=
 =?us-ascii?Q?C8dzaFhB5fDW3shrGMQM2sSCpdavV34gp24riBUVTv88k5tkWT3dzGGwSI/s?=
 =?us-ascii?Q?9xsZApr8I1NuuWGxn35RC0cCl71emX1QH7bgi08S5EWyuUgikE0o/OM1UGa8?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd88224-7109-44a1-d4f8-08dc34bfac7c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:35:01.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMWX30FdNvwIVIDmtT2Gv/QyLyUpyGMQdZQXwC8PAh7X4G/jpYzTqRiGHsX1O+Ntb6d6YTWHy74ZwZ8k1rKMMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847

On Fri, 23 Feb, 2024 13:07:08 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 2/23/2024 11:24 AM, Rahul Rameshbabu wrote:
>> +/**
>> + * struct ethtool_ts_stats - HW timestamping statistics
>> + * @layer: input field denoting whether stats should be queried from the DMA or
>> + *        PHY timestamping layer. Defaults to the active layer for packet
>> + *        timestamping.
>> + * @tx_stats: struct group for TX HW timestamping
>> + *	@pkts: Number of packets successfully timestamped by the queried
>> + *	      layer.
>> + *	@lost: Number of packet timestamps that failed to get applied on a
>> + *	      packet by the queried layer.
>> + *	@late: Number of packet timestamps that were delivered by the
>> + *	      hardware but were lost due to arriving too late.
>> + *	@err: Number of timestamping errors that occurred on the queried
>> + *	     layer.
>> + */
>> +struct ethtool_ts_stats {
>> +	enum ethtool_ts_stats_layer layer;
>> +	struct_group(tx_stats,
>> +		u64 pkts;
>> +		u64 lost;
>> +		u64 late;
>> +		u64 err;
>> +	);
>> +};
>
> The Intel ice drivers has the following Tx timestamp statistics:
>
> tx_hwtstamp_skipped - indicates when we get a Tx timestamp request but
> are unable to fulfill it.
> tx_hwtstamp_timeouts - indicates we had a Tx timestamp skb waiting for a
> timestamp from hardware but it didn't get received within some internal
> time limit.

This is interesting. In mlx5 land, the only case where we are unable to
fulfill a hwtstamp is when the timestamp information is lost or late.

lost for us means that the timestamp never arrived within some internal
time limit that our device will supposedly never be able to deliver
timestamp information after that point.

late for us is that we got hardware timestamp information delivered
after that internal time limit. We are able to track this by using
identifiers in our completion events and we only release references to
these identifiers upon delivery (never delivering leaks the references.
Enough build up leads to a recovery flow). The theory for us is that
late timestamp information arrival after that period of time should not
happen. However the truth is that it does happen and we want our driver
implementation to be resilient to this case rather than trusting the
time interval.

Do you have any example of a case of skipping timestamp information that
is not related to lack of delivery over time? I am wondering if this
case is more like a hardware error or not. Or is it more like something
along the lines of being busy/would impact line rate of timestamp
information must be recorded?

> tx_hwtstamp_flushed - indicates that we flushed an outstanding timestamp
> before it completed, such as if the link resets or similar.
> tx_hwtstamp_discarded - indicates that we obtained a timestamp from
> hardware but were unable to complete it due to invalid cached data used
> for timestamp extension.
>
> I think these could be translated roughly to one of the lost, late, or
> err stats. I am a bit confused as to how drivers could distinguish
> between lost and late, but I guess that depends on the specific hardware
> design.
>
> In theory we could keep some of these more detailed stats but I don't
> think we strictly need to be as detailed as the ice driver is.

We also converged a statistic in the mlx5 driver to the simple error
counter here. I think what makes sense is design specific counters
should be exposed as driver specific counters and more common counters
should be converged into the ethtool_ts_stats struct.

>
> The only major addition I think is the skipped stat, which I would
> prefer to have. Perhaps that could be tracked in the netdev layer by
> checking whether the skb flags to see whether or not the driver actually
> set the appropriate flag?

I guess the problem is how would the core stack know at what layer this
was skipped at (I think Kory's patch series can be used to help with
this since it's adding a common interface in ethtool to select the
timestamping layer). As of today, mlx5 is the only driver I know of that
supports selecting between the DMA and PHY layers for timestamp
information.

>
> I think i can otherwise translate the flushed status to the lost
> category, the timeout to the late category, and everything else to the
> error category. I can easily add a counter to track completed timestamps
> as well.

Sounds good.

--
Thanks,

Rahul Rameshbabu

