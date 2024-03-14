Return-Path: <linux-kernel+bounces-102768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061D87B716
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38701F22EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BFB8BF8;
	Thu, 14 Mar 2024 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aVBZhnGD"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FBF33F6;
	Thu, 14 Mar 2024 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710390232; cv=fail; b=C0h72g0hRjHEE13O91pWOcXfUJNr/9iG8CtILNv4lLiM+hEY03BICZ7QBpxytt/4i/CZ24fNtX4E7amjzK9N8pvWzhIAneHDacp3qhGBgWybn4dXRMK6GsQQJdHQfH3TmMk6a62pMYHbiopdXN9GglkK75vcR+9y8oH9KhyP2UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710390232; c=relaxed/simple;
	bh=UZlkCBdiYd7aTzPsqRA0XF8BErFB0BI3sHBPHli0fUM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=gCwSz7PT9IYGK6cbNEy70vZbWCzUTXXPc1eiZl0I+rEO3DvxARhHqH6FaeNvN7KY8bgi/CDCf1NK9LyHOQDsUgKoF75bLhKrbVT5HmJFueeKUJRrLvgLcVl7Ld1RAMqqN/pOJPGoWo6GNdvVH3jYkSOrK25pdN7JKKnOq9qiKkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aVBZhnGD; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI4MQdbeftVcfQkbKEbmZBb5D8mZA79gFdTn7AIUI29MjTdFOqHJXmyZMFd1pJhdvcBnWX4okdZ7AIFd84WOMsEFf8nNDgXC9X4OOLECFDj79WW7YHejuGpdqaA+o+gYJdZKn/T41oJV7nZddJzlHVX6ZwZQ3zerBjks4dpwjKCF8gq+SGecGeHfJF9MssqGTLCHDNiFXSEfTzEOaM2I9davuE2MDMc86zjtQyqd/5PUTcYTFPMFgrhT4wdT1BlcqgE8IKVagorU6UakiafsQX7yILlP3wQWY+hzPkXoSIq0RD132OgyusrISyfmrKhaScduiRyIEDUdV86n2XWAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5RkOKx61kXG/hON0foO6mIp7Khyfg/S6IEM4wVNVzI=;
 b=j6eY4HZS0uLPtZlxnNDz7WzH23e2k4zLmikW3iLl9KtzDyN8Ptoe0dLFv6b+Yu+YcZhh4j2JkXwPe6WAAYJl/k0K+jy3xPXDKkJaHF3D6s1L0oDSU4AJnHqQvxgBnNVaKp4WC5mhlhvtcujuWs0t/w9jR3fPjY+AHQMudtvb/mY2xKsxNoJPsbHwSdg77IchOwj0lfBdHFk5mwNClghLbyFnNiZC/yhwl9fEQtvrGlIr8fVN553U4OWYvHCogFXOfwUrNiUH9T8JJ86s401Vvk9KMFeq6cmoKW+d01z0dEOYKVU+efSOGwA0BdUwEAMaa3fnoL/vyiFK9HFoEW/S8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5RkOKx61kXG/hON0foO6mIp7Khyfg/S6IEM4wVNVzI=;
 b=aVBZhnGD2BD1RGKk2givkYupNhZs0e0nPFmXmjJWEI7cdcvjQZIDgFtrqguJqR6AJslzm983arPTJJ01P9XH8RJI8afx9XQqTWQ+m69ncU6pLoxe4yEfhpR5bPFwWkiB8HhscAr2k5O/qnPwLOOi1nYDWyWiSkwK40etnNWzjZhWM/eRxn5j29XCgPpHs7bAm0XrbVifKhpXHobYyr4bR7/j7VXhMWqE+swdzDtmyewQfGg7QC74L7j+3dmnX3GhHEyHrWKo+BPY4S5mx6r3v5sU4q8+Gou9rOQ1Z9TppTpzTmDJOex7DDrVSnBC6Krg7yNKGwfqCpapHXJzQOAqIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 04:23:47 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 04:23:45 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-2-rrameshbabu@nvidia.com>
 <20240312165346.14ec1941@kernel.org> <87le6lbqsa.fsf@nvidia.com>
 <20240313174107.68ca4ff1@kernel.org> <87h6h9bpm1.fsf@nvidia.com>
 <20240313184017.794a2044@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Date: Wed, 13 Mar 2024 21:19:26 -0700
In-reply-to: <20240313184017.794a2044@kernel.org>
Message-ID: <871q8dh25r.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e52e3d-6a27-4f71-1f87-08dc43de89e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ESFq7YEsgyZlKCsNDNe31K2dxNwVWIPgRP6NnVRv4JVC7KPZ7B2kLJBM75mXztY6aAAit/rJi9A29A/b6sfckUm8U/Ex7jJRlaylIA36ORVLzsXVgelT7+k4ukoqYvQ1DwMRhgiI2AcBU0hThFaz8/yEq0Mlf5oMvwQu4qmemYvtQDWxVpb/2ryOW7Nl1Kw4bADsQjTvYW7YTga6NTzixm+tbBAHl6ognoLF4QQaaAskW+f7/0HJ+WbblAbH7vkAMar1qtozMyG77WrRZ4hdOIUTFPCRnOdo8rWegt3OX/V8+6zTI2eAww8TEDAt058iq+fDZKBS81kvS9GVC3XNEqbjW4Vq3EwnCjG2VxQFOnGC2m8rpD71wW1UkhYsHvXsUd6fIcJHCE0rVOD5ggcJWuDjuz1Xk013Vn5gYA2n5mvJy3ZKnSjiqejtIcI77evLhYYRAi9enT6/KDNRwRt/GOjU4SZSOMpClwtneIntgLu1lLxhX/6EclKls57bNeXyREX3rLJrxfWGk3i+g4lYe6k2Pk1u/ybrRC18i4zD2uyD5qRPvz0h5wOERsNFRR6eAGDpbW6Y8MROkRWsJ4fDIfAJbWF8NN8T8rjZRqE7lNVhjqwLpDOhL4IYGhZQ8aZz3FSYQU97StuCVcTm5QgYUwDsR//F/IMFjBqu2GKDVgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CfkUmmHt2Qh1taLAERrcn3XKI06LHlEm1qKZXMLpzZQoVBIYiw5lMIGxWtFO?=
 =?us-ascii?Q?sQshjiqY/UpE9iunJpTrZALEi46r1vchE12Z5CLS9Jgtr6PIMI9OZuliRSg/?=
 =?us-ascii?Q?ZiS7cegq9zeg/kKnRUJjpjexwz5OYIeqSo3EZA7jcNFkxEFI9+BXkv2XnwRl?=
 =?us-ascii?Q?H4Z/46vPb7uKN60AC2/Cx/7kB1VLe1Yy4Rl0YlGgirde5/5jtaJnNmT+5QLD?=
 =?us-ascii?Q?CiFd+OjCuvWzmcNvPMCV1KWHseU1xmCKyl5j+azM5cFE3mpmlQ8X2wmBMARc?=
 =?us-ascii?Q?ImLNkt8dNn2r04yKAooydnj+dAg2P04V4qUWq8Aq01Ab6D/zugKJ2e/Rqecr?=
 =?us-ascii?Q?3l1Ht74/lH2tyDq+wDf8MAa7f/Hn5AJdbmhVsLLHzWhmsAO/41kKHOJFXIr3?=
 =?us-ascii?Q?CwbXVJ25+aKCKj8FH6yByEMvtp8z1SqZE6qXp2vXZ8PrwjxW6lgQ1IpkENf9?=
 =?us-ascii?Q?fmMjaR7QshrKficWVMiMX/VdIBlZ56oztX20YPW3DTSWDjsPYBxt2mmebyTf?=
 =?us-ascii?Q?InNAiKZe31OZRx3AwQU3XZeZz0QT2ern46z4sPL+x6SPJSJY6Rp0zBkdgp3e?=
 =?us-ascii?Q?lVfdyXNSChrch1K/ja6/X057pPoZ6X00riiPIC19cIhJPZ7ZCQJOhUhwAyRX?=
 =?us-ascii?Q?0/R1pmIkOrnJXG9+f6H/KZJ0OeThCEjDdB1IGWxpgd/yarPXYyeHtmM4Xkz4?=
 =?us-ascii?Q?1R8MAm6mHvqVSwZnDSr6z50DFzXkoObg4DkXRY2LrMS1ZrjNsb6Xiz5eK1z2?=
 =?us-ascii?Q?2jVik4Q59PZThedXbgfRN9pIvrtlyYr+4K+nrWB+C0yp/uUp2RmQDb26mtX3?=
 =?us-ascii?Q?FS2l8hzqDArirUwO/VO1HzFnnJ39NjDJnSTQ9yDhKEX1DSvqI2NdohJw72gG?=
 =?us-ascii?Q?mvZtQcuOh0W/W9X4v5I1uzUCyMjJE5qntvWEfrMQg+KNNiOjqY3sCfID8+4T?=
 =?us-ascii?Q?IMOO45L3miO/Wy97dHkJs0+wg9wT7i18210tLYcJt7BfUcjBDA0/L142sWgL?=
 =?us-ascii?Q?DPy/sfZGfihx7R6eu3AkApgD7nRLR4KJfJI7BpiwOgQLZqwPdb7/KyoALFb3?=
 =?us-ascii?Q?WNCTK8xAc4So95VwWZ6HbpFJfx9UWHd/57/KMXa5KfyRT5BE6N8jnwTKpQvu?=
 =?us-ascii?Q?up18zZFfxS2F4Z00muxcqLVOXffbjWox5/aIGHZ/X5706xgUFS/Pe4Acr/PX?=
 =?us-ascii?Q?6BUxQNFHDuxDEhNoWwvrMayH23TWZa3XpMrvrJUIyuaFKpFN266v8M/J02Ag?=
 =?us-ascii?Q?nQ4LPYxxrRnEvB0Um2eigJG1eyqUCdvq5bGSaI3ekcxFu9dHphoA7Vo+HQ7g?=
 =?us-ascii?Q?igrvk4L+jljidXDEPkLJPS3ttUwbDGVWJvTowIohCCQdiazROEl5LQG2yJcK?=
 =?us-ascii?Q?c+FTdx75fF1+xEVN4nLihk8D94Zee03uuXUGgyXUUByGPDt574u4RT2Gs+0h?=
 =?us-ascii?Q?bzHwRGS/1Z2xsvhMReCjGYU27cPHSj8FbKTkBO0HLvEYccOeMq3JWcFyiw+V?=
 =?us-ascii?Q?SmSsQX5nWBXZRQoP2r7JGIJ8xliDVA9YNts7lV7jf68sP/YSF6fR71RJIn5v?=
 =?us-ascii?Q?XHW5dN5eU/f8Tnd9I2ANKsVSaDq+xjrW57397cdT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e52e3d-6a27-4f71-1f87-08dc43de89e1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 04:23:45.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNeKAsq9YtS9g72BVlkWtJG3QdDw1bUwJGZNYgmd5i1SjpKaDhVMqt81TfUO8/BCLupFM8BcpfMiB9DRGKBvkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683


On Wed, 13 Mar, 2024 18:40:17 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 13 Mar 2024 17:50:39 -0700 Rahul Rameshbabu wrote:
>> > Should we give some guidance to drivers which "ignore" time stamping
>> > requests if they used up all the "slots"? Even if just temporary until
>> > they are fixed? Maybe we can add after all the fields something like:
>> >
>> >   For drivers which ignore further timestamping requests when there are
>> >   too many in flight, the ignored requests are currently not counted by
>> >   any of the statistics.  
>> 
>> I was actually thinking it would be better to merge them into the error
>> counter temporarily. Reason being is that in the case Intel notices that
>> their slots are full, they just drop traffic from my understanding
>> today. If the error counters increment in that situation, it helps with
>> the debug to a degree. EBUSY is an error in general.
>
> That works, too, let's recommend it (FWIW no preference whether
> in the entry for @err or somewhere separately in the kdoc).

  /**
   * struct ethtool_ts_stats - HW timestamping statistics
   * @tx_stats: struct group for TX HW timestamping
   *	@pkts: Number of packets successfully timestamped by the hardware.
   *	@lost: Number of hardware timestamping requests where the timestamping
   *		information from the hardware never arrived for submission with
   *		the skb.
   *	@err: Number of arbitrary timestamp generation error events that the
   *		hardware encountered, exclusive of @lost statistics. Cases such
   *		as resource exhaustion, unavailability, firmware errors, and
   *		detected illogical timestamp values not submitted with the skb
   *		are inclusive to this counter.
   */

Here is my current draft for the error counter documentation.

--
Thanks,

Rahul Rameshbabu

