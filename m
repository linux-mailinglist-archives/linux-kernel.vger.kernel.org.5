Return-Path: <linux-kernel+bounces-79353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64A862119
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B027A288769
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7601866;
	Sat, 24 Feb 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NRfulJ0Z"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187BD38B;
	Sat, 24 Feb 2024 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733710; cv=fail; b=SUldwsPhOl1/JJjXSg3hS7J64Ukdao4L8vw0JYJ8zsecqfPV66LfXP2L/IY4XsGmMtnz/v7mvhO0vPDqTTlHzB+GiA7tP6n/BDgPjfTKTsOzEzUiqdjyx4DqpFQVdGOeIoycjgBQ15QeuuDTcIIMyNUxpmGSzE6aSxWFyH0PxP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733710; c=relaxed/simple;
	bh=vaF8ya0d7VE/Cp+nR09fkkRMpwj+Vba+4FE6/y4MVH4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=LwbIi3+N6v8s/+SEulI2OaOdnqF8e/jpInybiY3tTc/H9xMwrfgWytAT1poyQX/eJWEA+W8hYH0djcLN4LT3Ox5fNpXiaXQtLjz/FPLqMNhYcpZ40TBw7rPproKUv+VB5X+P++q1ocyeos3YjXis77OsXPkCzLo+lW/bpcPM0nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NRfulJ0Z; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltrZfrZ8NTVPxzIMMTH3yi3pqjRVGY3ciYrAMnDgAbeNP02GeHD61EXyIDYRozTWEVCkyxGiVCOl+jurkvXIFcPaT1rErpKD25CCwrROS74t/L6KnWtzkY2v4rCe6lPjLpxcmKAMdauAGePGWqxqhfY2ierHUji9GV1usJYnpndVVRsZQTDmBKCyEtRE3ZLRS40CIkZB/dyjbCng3v3OcTFsw6zDCyFR+7PQGdp28jmViX0hsXJoNZ9nTLVrub/auQm+Y4rV59yZotBkwxGgwEgp3hfq7NOS2/D1+hge9RKGfqOXCRXj+FdqVk9oP8P0pQeB7gZlMnYptV8c7jazRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHTqvXo1+Rlm+Y8bPwFXMtwRTwIM67Vp9uWT2Imp2V4=;
 b=NJ5Lxt5bZUI/409L941NJfPlyvyXmnFGOX94g80/Zd5ruEt3gD4KU/UN7iLQkPXYKK1ORCdp/471QFldqxe3VFrB5SEUyo0d0x3Qw8kwcHLLYkd6EB34hqJDrGW+AqjY6MBdxN7J23v84MlTglEToMU1BQwGPFdX6N7RwH4i46W8dXFJ4ypUgQ/43cDVtUFWYeq0DDosurl98gBRwKEZW+XOasPIkDCj9p/Qw7h/kFNIsKCjK4bXuFAemUGx6yKGGmuqBAeniwE8Mjh1K5i3Sw/m0l3scQlq58GIhxkaJ5jLGOLg9p0AVU6OrRzyAgA071JWAdt0cjobZAyOGn0YAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHTqvXo1+Rlm+Y8bPwFXMtwRTwIM67Vp9uWT2Imp2V4=;
 b=NRfulJ0ZJGtJ3zE8nCq6tLbYjdrfiYvxRNBYyInigwfm0rd+Fe7SP5NfHRHcQ7CPkKIQTS2ag0z4KSgtQBdRFEqZPuO3H7TM4AAtw+MuaVmqPitfoW9iknZIivRAiclCAMqC+XsZK7hkaU2au1faJVzQ09yvXlpyPcq7P8nPFCWObOFIPEB726PXK8G0sZzvg2slSyJkP2nFlueEmhfpgkG3EMEjLSm4zGTuDwG3SkZT/gJuIr9p+rO71+CLuXvsQ5niSPO38GiTBLZLnWjuZskfheFAhi5sTIgtYFezXj0yX5rEdhPgxO8WzFagfqKde76ZhzmL8dVlxRqVw1Xwrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sat, 24 Feb
 2024 00:15:04 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 00:15:04 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com>
 <875xyex10q.fsf@nvidia.com>
 <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com>
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Ahmed Zaki
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
Date: Fri, 23 Feb 2024 15:43:27 -0800
In-reply-to: <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com>
Message-ID: <87il2evhtk.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 272d2280-72ea-4c04-deb0-08dc34cda62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qaqPeSb5iGdc/v09blO58esI6jNnG21fus9WydLqaJI417sxvfJDtM8JpH4d7EWcnzkdU2ET1RrXHsNjrexc7nQEixqy5HuvXWlzZ28KYxwM6mJhS7zfAy9PX7dXgS6DfRod47ookwiRBDE5xMdhq1zCkKNmT6Fd8TW20W/yiQBQTBQVGwE1tSiiN/NqlN/AOf8DncOibHfAMFwkbSGSMwTQmgkRQq/VkLWFkany47YDQ1kZzlByqKi20Ox8Yd8Z0+rwWU5QTwe6jOwtZBPHDy7JQSjxgPUfYKDI5ZXh4AjSCHl+0zhuh8y3SVafRAtfGT8RvHHOyXs9eXFga6Z0hcbI1rdx3p+bfV4tqh7nf4Mywioz8GysWFcXO1aI+Qr8nV9EacLbGy7z2dr6AAh/P5ORFm7fzsY1LoZWTcaWh15kBwH/THfdAkYYtAcBufy/69sb7WHzHTK3Rs/DqibdWnGDby0GpDWXLiBUEBPD6tx5PZa+PkJC41JQKc0f0XRvSBTAd+bS7MVxa9eDtifpONRDfs1+P7PNphDZA5sD07n8dANjKvQ6/XrHzLHh4dNkzWQWC1mgGKUZmwfHj0mFDMv+YiB5cA6L+kJxSd1D9NQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3n8XaCEfRcDBt2k3A/z0d2/2H0HIRab5wWELxgrvYIp9KlYVUk9/E+xkV0GY?=
 =?us-ascii?Q?NzUTvsTvSkdMpEEqiAspfgFu19Zs9L5qxV6YXxTmTCYTVH7tYSHoHl4Vz1qy?=
 =?us-ascii?Q?Pgt5I3odVzvWOpdnQhI5TXvxCZXOrfHYlTKCnsIX3ltSomGZR99NbJ7eoJso?=
 =?us-ascii?Q?y1vynxHjE9FmfeTNfzpRhn8K52caWpTkm919tlqJUYOqG/zFSu6wS/xIQkwp?=
 =?us-ascii?Q?UzF2Vh+JCBc0XKGC1L549jihcH38ucBi25BR7kMn0w1l9Vr7FJtDdr8fNGaV?=
 =?us-ascii?Q?O3p3S0XiSL9cp61EpUyGHB5HirZn3ShflxQdgy5F7NJYv+V8uqwnkvtWMm/3?=
 =?us-ascii?Q?3mqUSVRa+U5zUUtxrrZIHa1pLfJmdsWuWIwn3w1jsj7h9RBbEBu0FbbckJjj?=
 =?us-ascii?Q?5NXlouraVHFTPr7oj4sbwlnHt+UTesay+uySJksXJs8o7LSj7PWhSpM9XqQr?=
 =?us-ascii?Q?eUdX6EH2Qg1vlp2FkQNwxdmZPVrwgHjloDnzy6Q8fcsomY1ndpGIavQnM3Rp?=
 =?us-ascii?Q?IATecMoz5IylFOK7xAdRezgPmvFZkxXOv181wOYntY0o9Qr5h9oV1NiyBOIu?=
 =?us-ascii?Q?2Glelj3hHZABKlyeOO4DEgY60/zsaDKP7fWa3YH+Wr5uSN4WSMO2Y+We0+DZ?=
 =?us-ascii?Q?7r4LaAxdt0uLPwqgo+fQYjrgFNgWImGu0bNFMVK/l+i/MBQS5/BZD/kCo1WO?=
 =?us-ascii?Q?LJS0giVUI7WwAMS9eOG72wN4hhCYtzyMLuTia3wVNJOdhTCdosEsNeRrfoxx?=
 =?us-ascii?Q?pdetvjXEuNEsP2OH8qMEJ0DZkNg8o9Gx4+Yyi9VbAXKF5vrRNfYpi5HP1osH?=
 =?us-ascii?Q?WjxrwcDLXEp7JVg6BNwYPGPcQGRhrB+Ee6wDLClXherEAkyGx26OLDpLvxqz?=
 =?us-ascii?Q?HAPgCrDkvXQEhWVYdbGRV5p1/fSbwe2WQFAiq93DljgGfc2SnJxYVen/FR4d?=
 =?us-ascii?Q?GiLnFAsNTvPt14Nd91iZtqIz3f57B7yRdPdK0p83s9qSMS4bFbRguudaqfsW?=
 =?us-ascii?Q?vlMvRpeUvn6gVyBs5BMVyq206MfSEh6et4nXAD3UtPaRKYGJwK6/HVZdKYHw?=
 =?us-ascii?Q?di6JPXw/VXDoL/B2G2IH4fH/HwB9cTsXQJEsWgQKekE4jJbrR/hjQeJt2xJA?=
 =?us-ascii?Q?fP3b/G2L3hhnVmL2x0HxaOO5ROk+6rLexvU4Yn6mJkMQUQabpspmmwEimQaZ?=
 =?us-ascii?Q?rs+IX8OLMfcvc3znMOpRM9HnYhF3BvYXt1nxiSLISmL+ogw+uB1FNeTumlPN?=
 =?us-ascii?Q?ZCyPvXszjrsZ8lbK78jyNThmlab1bj1pjzSDKRSCECLsDQVdOQWwSQCG/Wo/?=
 =?us-ascii?Q?LLLkapm997YK57KRJMf7mgulI0yhPzvtlSIzOQzq9MjDyWxUxg6+3YgaMX6E?=
 =?us-ascii?Q?f3ucP23MV0PLzZGC5rmqt4zpoi3tdNM6ll81Pt/1M6rjxydJIgD/7BjNNn4K?=
 =?us-ascii?Q?kOFs4Cj22JzRlc0c+TnYvfkIxz+ryOsklGHkDY4iWPboAkApguJNzflKgRCR?=
 =?us-ascii?Q?JTvXtCyfETUGmLY5meSacKOv8IWPrUL2Nn+0uAS8kqEri8ot9ulho/ahsTLO?=
 =?us-ascii?Q?poZmbIitpyHtYWONat0Cj53zv/kYC/KArvcoTtVAqfSzuJXks01uuqPbDjN/?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272d2280-72ea-4c04-deb0-08dc34cda62d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 00:15:04.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naHlebNMeg971S3lHGeTGzrG0IgrhG7g94FyDWaZIXBE4w7QfNwJBWYljEZ7zRw/+6A/mGP4M2Ov1bT06wbOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895


On Fri, 23 Feb, 2024 14:48:51 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 2/23/2024 2:21 PM, Rahul Rameshbabu wrote:
>>> The Intel ice drivers has the following Tx timestamp statistics:
>>>
>>> tx_hwtstamp_skipped - indicates when we get a Tx timestamp request but
>>> are unable to fulfill it.
>>> tx_hwtstamp_timeouts - indicates we had a Tx timestamp skb waiting for a
>>> timestamp from hardware but it didn't get received within some internal
>>> time limit.
>> 
>> This is interesting. In mlx5 land, the only case where we are unable to
>> fulfill a hwtstamp is when the timestamp information is lost or late.
>> 
>
> For ice, the timestamps are captured in the PHY and stored in a block of
> registers with limited slots. The driver tracks the available slots and
> uses one when a Tx timestamp request comes in.
>
> So we have "skipped" because its possible to request too many timestamps
> at once and fill up all the slots before the first timestamp is reported
> back.
>
>> lost for us means that the timestamp never arrived within some internal
>> time limit that our device will supposedly never be able to deliver
>> timestamp information after that point.
>> 
>
> That is more or less the equivalent we have for timeout.
>
>> late for us is that we got hardware timestamp information delivered
>> after that internal time limit. We are able to track this by using
>> identifiers in our completion events and we only release references to
>> these identifiers upon delivery (never delivering leaks the references.
>> Enough build up leads to a recovery flow). The theory for us is that
>> late timestamp information arrival after that period of time should not
>> happen. However the truth is that it does happen and we want our driver
>> implementation to be resilient to this case rather than trusting the
>> time interval.
>> 
>
> In our case, because of how the slots work, once we "timeout" a slot, it
> could get re-used. We set the timeout to be pretty ridiculous (1 second)
> to ensure that if we do timeout its almost certainly because hardware
> never timestamped the packet.

We were thinking about that design as well. We use a 1 second timeout to
be safe.

  #define MLX5E_PTP_TS_CQE_UNDELIVERED_TIMEOUT (1 * NSEC_PER_SEC)

Our device does not do any bookkeeping internally to prevent a
completion event with timestamp information from arriving after 1
second. Some internal folks have said it shouldn't be possible, but we
did not want to take any chances and built a model that is resilient to
timestamp deliveries after any period of time even after consuming the
skb without appending timestamp information. If no other vendor finds
this useful, we could roll this up into the error counter and leave the
late counter as vendor specific. I do not want to introduce too many
counters that are hard to understand. We document the device specific
counters on top of introducing them in the code base already.

  https://docs.kernel.org/networking/device_drivers/ethernet/mellanox/mlx5/counters.html

>
>> Do you have any example of a case of skipping timestamp information that
>> is not related to lack of delivery over time? I am wondering if this
>> case is more like a hardware error or not. Or is it more like something
>> along the lines of being busy/would impact line rate of timestamp
>> information must be recorded?
>> 
>
> The main example for skipped is the event where all our slots are full
> at point of timestamp request.

This is what I was guessing as the main (if not only reason). For this
specific reason, I think a general "busy" stats counter makes sense.
mlx5 does not need this counter, but I can see a lot of other hw
implementations needing this. (The skipped counter name obviously should
be left only in the ice driver. Just felt "busy" was easy to understand
for generalized counters.)

The reason why I prefer busy is that "skip" to me makes me think someone
used SIOCSHWTSTAMP to filter which packets get timestamped which is very
different from something like lack of resource availability.

  https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-configuration-siocshwtstamp-and-siocghwtstamp

>
> There have been a few rare cases where things like a link event or
> issues with the MAC dropping a packet where the PHY simply never gets
> the packet and thus never timestamps it. This is typically the result of
> a lost timestamp.
>
> Flushed, for us, is when we reset the timestamp block while it has
> timestamps oustanding. This can happen for example due to link changes,
> where we ultimately
>
>>> tx_hwtstamp_flushed - indicates that we flushed an outstanding timestamp
>>> before it completed, such as if the link resets or similar.
>>> tx_hwtstamp_discarded - indicates that we obtained a timestamp from
>>> hardware but were unable to complete it due to invalid cached data used
>>> for timestamp extension.
>>>
>>> I think these could be translated roughly to one of the lost, late, or
>>> err stats. I am a bit confused as to how drivers could distinguish
>>> between lost and late, but I guess that depends on the specific hardware
>>> design.
>>>
>>> In theory we could keep some of these more detailed stats but I don't
>>> think we strictly need to be as detailed as the ice driver is.
>> 
>> We also converged a statistic in the mlx5 driver to the simple error
>> counter here. I think what makes sense is design specific counters
>> should be exposed as driver specific counters and more common counters
>> should be converged into the ethtool_ts_stats struct.
>> 
>
> Sure that seems reasonable.
>
>>>
>>> The only major addition I think is the skipped stat, which I would
>>> prefer to have. Perhaps that could be tracked in the netdev layer by
>>> checking whether the skb flags to see whether or not the driver actually
>>> set the appropriate flag?
>> 
>> I guess the problem is how would the core stack know at what layer this
>> was skipped at (I think Kory's patch series can be used to help with
>> this since it's adding a common interface in ethtool to select the
>> timestamping layer). As of today, mlx5 is the only driver I know of that
>> supports selecting between the DMA and PHY layers for timestamp
>> information.
>> 
>
> Well, the way the interface worked in my understanding was that the core
> sets the SKBTX_HW_TSTAMP flag. The driver is supposed to then prepare
> the packet for timestamp and set the SKBTX_IN_PROGRESS flag. I just
> looked though, and it looks like ice doesn't actually set this flag...

That would be a good fix. We set this in mlx5.

	/* device driver is going to provide hardware time stamp */
	SKBTX_IN_PROGRESS = 1 << 2,

>
> If we fixed this, in theory the stack should be able to check after the
> packet gets sent with SKBTX_HW_TSTAMP, if SKBTX_IN_PROGRESS isn't set
> then it would be a skipped timestamp?

One question I have about this idea. Wouldn't SKBTX_IN_PROGRESS also not
be set in the case when timestamp information is lost/a timeout occurs?
I feel like the problem is not being able to separate these two cases
from the perspective of the core stack.

Btw, mlx5 does keep the flag even when we fail to write timestamp
information..... I feel like it might be a good idea to add a warning in
the core stack if both SKBTX_HW_TSTAMP and SKBTX_IN_PROGRESS are set but
the skb is consumed without skb_hwtstamps(skb) being written by the
driver before consuming the skb.

>
> Its not really a huge deal, and this could just be lumped into either
> lost or err.

--
Thanks,

Rahul Rameshbabu

