Return-Path: <linux-kernel+bounces-96038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F204F87566B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E4D2825C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE10135A68;
	Thu,  7 Mar 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQCtuXXk"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7906182BB;
	Thu,  7 Mar 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837574; cv=fail; b=gcXYTEW0a20hGQfdc0lLhz1xoZA0fyndCj0w9GFaH/z4yOaRlUKqQPUgKpvX4XRy71xhWuL2a5lnPh4p3drllSpxcz+NBfWTZfcZvnJ69B3/4AXWtEFGuJYUz6JV2fbkuAvf+R7vZEyGo55Bz70HoWu8aLEXma5tDF5tAjo1xJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837574; c=relaxed/simple;
	bh=ZJnv5yGrKrJ0HXC+EnOJeMG+JZTb7JtRlrCU/7EpitY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=o3sh061V6+8Mcp4A9G60JzQlNRvyIx8KmgQYDuqcJULlCgFsvjn96COqgJ14k+WpB5XkoPbCeuxRcUlvtJKpjnHTegjSskjHUhJNYC3K0MygLWJGLKNNDT60vnYIGg0389DkHv1zCy5/am8ds+Ka1UcLrDWRNrJvctaDQq5enOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQCtuXXk; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7/yCux5+bLvWQvIh0Tch8/bo5fC9nEGptKsRRrc/NMjzj3uZNVq/iMpsVQ33oQltQ6GQsKmOQktCKcpwWOJZKVBxxQmnlQs9VteK59rvq/DcB3O9eev5ZWa6JXrn6uA4om3IekIjR3MQcwg0K7Qo0PS/znYU02M02v2NQKaRA6dGZnHrKFqGmkCWFyP+CA/kjfgF1Y+xpmWkpogQanLue+qseFNFaCMJOijAL++J0vFeG7OFtICtS56a82+iLsEjKQKjoRkuO5LHVzQW5J38TXOIUfyA58S8wY3KBVLNFjOJiPrBYJmTLzMSaACik8UNGwhXNRex64EA5NX0W7LuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+Y7s/RkZuGf10Ovd0Brp4qozHuzny08T2I8Ase4J4I=;
 b=nTclPz7b+z6I4JvN3WvV5DgzDd63XLpCmTg5QlWC+Un42rBErQFFGUhO0X/K0APJzDdxRf0zYKzXSK8ufGXcQjBnUdQTLZ3kGcniEJCgw8tyjgEieshNNE4R6ZNTf1rAPaRO6dzxAcDPeENL4zFprlaHXbBhwhT53CAbF3ri0jdYU2zv0Vopof8C7YpKbLj6eWsrQxJQvf2N6/ZZ9hNVIdNTmlKRscjFLFY2895ILcAQV+2NKLZnPKGBYOyNZFJNsennzISj9yNeWh7sIRUA3M1wjpITSasjDQHdGCf7e+WjW14xq4SMJk5vVjTGgIYYxpDIoSxcfnoIcUsilvGZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+Y7s/RkZuGf10Ovd0Brp4qozHuzny08T2I8Ase4J4I=;
 b=GQCtuXXkw/M25UdxXTfTP2RSMpN7dq3GaExCWO5lwzioFU3n9hLjqUQKOzgm4GZ88izEFnizlLut1PaOGALX1f30w0Ihy0tkpsW/IgczH42OO8Uwe49lVu8uytKnm7s0eYvMWIUB7AEvAMtcAgDdG9Klow5XcdFe8Q6qT2EpKLB5a01qSXPVHq/tupHpKPrnGT+FXNb/sViQIx4sHecW6+e+VPdSA4g7i4Wbv/B4uYa5EqSsRzoronYah15g63hvN4K8ut5EHv6mqojCa1ULZHuLiAHuN6x0wtMOO5FeeFS/GhPeqr0gbNa8sugdWrbvH+NpFvWEaxVGvDTiuWN3hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 18:52:49 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 18:52:48 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com>
 <875xyex10q.fsf@nvidia.com>
 <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com>
 <87il2evhtk.fsf@nvidia.com>
 <ec969f62-a1bb-4287-a4eb-083201134bae@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan  Corbet <corbet@lwn.net>, Richard Cochran
 <richardcochran@gmail.com>, Tariq  Toukan <tariqt@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Ahmed  Zaki
 <ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Paul  Greenwalt
 <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Dragos  Tatulea <dtatulea@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Date: Thu, 07 Mar 2024 10:47:16 -0800
In-reply-to: <ec969f62-a1bb-4287-a4eb-083201134bae@intel.com>
Message-ID: <87le6tvpq8.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::25) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3da949-73f7-4900-c215-08dc3ed7c891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tIEc4xOZoUKVauaMhN2kHNFFFcN9a/gDP1ZkLUPEdqe+Sph2KB1pBspH1pihS57lPukaqSx2FULi/EfqE9pVR3IOLp97RbRJky35Bkmd8oW2V4bWXpEzLsF7UVIsg4V6qfMXgcy3r7/zMDCiHcJTr8t0PeSl4N+sghPM6J8K5NpbjSgbVbk49/TSdxCz9W5zKOmE/3t6FNFG665h3p/YMRdO3jlIKAxfDZejaOQiiSIUAhUyfQpBIZmfrih3OqNyABnVm+sI8mbB+bI3s1qHEuTYOdNM1R5f7P7gedFccnqnAbmlyH7f6ZNXHsnoPIM8fHm6W/pWp3R5N3qjcwQHkxvZ+gMl7Ax6rOmBvVlyK3vHiOfjpSlNqnEhkfuuoMHs04y5OVFlT+3fYjTOZL9NOHHlNxTfvjEtFsO2bUgutj1q1F87soWHeHVIyipLxzbMMmcRkclcZ7ncbXaZFefMuCF4O1jBNZnlDS/satc3Prw5k7MvRVVWtWKUcjIb3lpPvGn+ssvmn1kcls2p0fF2rjUyn0gkQheNnKaNHkfnURbxAUs3DXbQV9jUNMG5UR6Z5CW69/kqe15csjwCk/wBz/Ga2WeKhnCvkIfqJBUC4RIgQKHSNYE4IoecF2bwbgtAwIcMf/iT5w6XGEKL8yg9GI05tFINkM3/rWqM3TEB6pg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/DEtlcBv7rXzo9oDvLon1KKfI5sMSPsWErjH8h/h6gzirxb15cGb0oPIzbEu?=
 =?us-ascii?Q?hici/iyEiniJ5joweR3M84FDN06bpISuADQse/vuR9Bn5+Z0xs/uefyfmwBP?=
 =?us-ascii?Q?BGM8omCxUBdZmq7TS0gyOVKNGm8ORezaukRY7J+Hg3az2D3F5pNODY8wahck?=
 =?us-ascii?Q?Evwe+6MwPj5DMlwojn2s4fyt6qMGQ/QTj5K+MG4UfJ2VDhvmRP4r5oUCgP31?=
 =?us-ascii?Q?i6Kit3hxyzqb8X6prbdcfgRC7Kz2i3BSv/Xdq55Rdw6JB2lf9FGA5iqJDo4z?=
 =?us-ascii?Q?8tCCUZT79NALMY1J4Z5FfYLIH4JqWYrdwU1t1Aw2csrjU/5pGSqf2VPl1Qo7?=
 =?us-ascii?Q?XDPN59PZ1/APwZirXSEu7QAEXrkQveT55t7KXQ5sSxtqlIDAKtdVwRMOUp+H?=
 =?us-ascii?Q?73LMcPpYz7DAvSuo0apKnG2d06UnInszHMh3/C3w6NYstqqHhi5sIhcxopOS?=
 =?us-ascii?Q?ODTC+dFJw0IGrq9YrmOV4ZQogx2ixf7kaxYUe9rsFgG6Oyic7/CTRkXcDU6E?=
 =?us-ascii?Q?GbBn6UCHcihm3h+rVGS4apmXVO7QG5O5wKMnqETdmEll+E+zQo2NfehVn+Va?=
 =?us-ascii?Q?MqaBL5ca6SWek3x1LMbOtKYDuUWI6rK/lLzy72VAOJt6a7kVwgRoXO/SMkdP?=
 =?us-ascii?Q?s5PfHVp77dGEh9DjMiv7BuK+XUE34bguwS5hn+wRSSj8BwGdh/JZXRQYfc8A?=
 =?us-ascii?Q?FhFnsY7KFIVK4HqLHeIgMcuXi5Wi2TuWYJFOXCGGDJHStRDKBT2eLCKO/xJF?=
 =?us-ascii?Q?wNVxbqJ58QN5QnSOIWvoaNP8FatByhldCtpXK4giWNNaQrJVvOHW9st08YUi?=
 =?us-ascii?Q?/fToNsfj50Hivw8JbRXJOccCY1nKAPLDjL016381KSFD98gDQ+kFxHdJg9Hs?=
 =?us-ascii?Q?v2dpz7icDtfWiDlDPAIC7hgqSMk9F272hlJP4S3TL4i1ERFJjgV7zre4n6w2?=
 =?us-ascii?Q?1EGVFrk0OsGNf+SUrAN3V//ZocAIyj5jctm/0N9dWoz7NZX7W2t/C2fjbCeY?=
 =?us-ascii?Q?REH5rg32frx/WJWeiC6yjEsu2jrvbzCppJRHoMGPsWQJultVFg7C4M1qrfy4?=
 =?us-ascii?Q?lzKHF8fO2D2s1HgT5t5mlib3QEp3eUDhZwIsjjCXuJRFBbkBrfsYGZPAWEVF?=
 =?us-ascii?Q?9kR7XX8PxWjrip4pwzDci8Kgl9RU8vWN2MA8q3k8GJzi0mtRogw7rxBpdDrY?=
 =?us-ascii?Q?tWpRt/2ibOTZ0jn1tcizVazHiQGynfm5xIueDtoYzBEvr3Ty7e07dh6Bi76w?=
 =?us-ascii?Q?BZR9QQ+ROPCwnJbLVVLGlHUbSIeiKXD5oUYTHsLIFlaTnA0bgbQvtqmS6La7?=
 =?us-ascii?Q?V4s1kekwU0eHejflHe766+ta/EtO6ZarKLSzt/BLqOntqEinJYnzcl797IBF?=
 =?us-ascii?Q?ngaQf60NoI8q9KA5Vrr/2QLQ0AMXpUM7lmmIuB7w1at9i4BKbWz6dY2TPdYT?=
 =?us-ascii?Q?ZhIirst1E7TMI8sUDaAd/EMtpaEJWciMsQkxWclXJTRuIjYE5S8Zg/DKngkr?=
 =?us-ascii?Q?loDTv/9bsbeV6TvST4JorbvlH9ByVLXLRpj5Ea9W29ouXX5cJEM1IPvWjlD/?=
 =?us-ascii?Q?2csT+sFmlqcgSfY0eV4BlsEb1RtjocaLowRkdT9Xu+21slEnQIx6WBuJHkcI?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3da949-73f7-4900-c215-08dc3ed7c891
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 18:52:48.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCoLjUrhYQBMdZLnjnS+4sVYS19E+lvP8pPQhlKX+MMdhJvcB2QjqW6tFy4gKleimYjAs4FfSj2B7/0WtkPT9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279

Hi Jacob,

On Mon, 26 Feb, 2024 11:54:49 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 2/23/2024 3:43 PM, Rahul Rameshbabu wrote:
>> 
>> On Fri, 23 Feb, 2024 14:48:51 -0800 Jacob Keller <jacob.e.keller@intel.com>
>> wrote:
>>> On 2/23/2024 2:21 PM, Rahul Rameshbabu wrote:
>>>> Do you have any example of a case of skipping timestamp information that
>>>> is not related to lack of delivery over time? I am wondering if this
>>>> case is more like a hardware error or not. Or is it more like something
>>>> along the lines of being busy/would impact line rate of timestamp
>>>> information must be recorded?
>>>>
>>>
>>> The main example for skipped is the event where all our slots are full
>>> at point of timestamp request.
>> 
>> This is what I was guessing as the main (if not only reason). For this
>> specific reason, I think a general "busy" stats counter makes sense.
>> mlx5 does not need this counter, but I can see a lot of other hw
>> implementations needing this. (The skipped counter name obviously should
>> be left only in the ice driver. Just felt "busy" was easy to understand
>> for generalized counters.)
>
> Yea, I don't expect this would be required for all hardware but it seems
> like a common approach if you have limited slots for Tx timestamps
> available.
>
Sorry to bump this thread once more, but I had a question regarding the
Intel driver in regards to this. Instead of having a busy case when all
the slots are full, would it make sense to stop the netdev queues in
this case, we actually do this in mlx5 (though keep in mind that we have
a dedicated queue just for port/phy timestamping that we start/stop).

Maybe in your case, you can have a mix of HW timestamping and non-HW
timestamping in the same queue, which is why you have a busy case?

Wanted to inquire about this before sending out a RFC v2.
>> 
>> The reason why I prefer busy is that "skip" to me makes me think someone
>> used SIOCSHWTSTAMP to filter which packets get timestamped which is very
>> different from something like lack of resource availability.
>> 
>
> Busy is fine with me.
>

--
Thanks,

Rahul Rameshbabu

