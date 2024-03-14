Return-Path: <linux-kernel+bounces-102673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F82287B5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79751F23527
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793782595;
	Thu, 14 Mar 2024 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nswu6wAv"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919737F;
	Thu, 14 Mar 2024 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376108; cv=fail; b=fp7NwupGmG98nYGa/QkfCQaY1sZfvwYI8DpwnVziGmsCjiShOq3BFr/aNXpzOSMW+58TvaH3DGtV0aenUmvlmqshw+k2i11Jin5kb+x4cT5XFfzqEhS925kpKK5piHIUoEPpp1LTKQT3hMJhTjamxeCwNBVgf5MJp4BsJ5CECmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376108; c=relaxed/simple;
	bh=Pjc78ua7YCHAKd5acxzBcs8GQgnhsj+9zhGoRuyujd8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=m8eto/qeoq6PtK5ppGLXh6OKru7Ql7ZhgaAkqhqeJq7XTzkm9bD0DjPySnUs5hIzGUld1fVLFP1pYQ2h2e2J4Htap2RwiDrSeH0vkO9IXbgUIWrWyHugv33LLSANvGFvKlEwQmfNWWCsGL/9PDT2CwekOA9uZMQ4vfPyvf+efwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nswu6wAv; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muKvujILqBKRRSMVBWm5BQvQd1Ybgi8do8TipsGu9Sgwerj2VRrl+lm44BOiYobeWc4jJ5+bY0UvAHOQgpwSyPUYsf5m47lZGmfIWI6dtYG6TiGpuWoK5OwLyZluhf/rjR7ckFfLBCLa9KIFmX2FAjKzYnOkS4Sin3+ayDW+OtpwM8rwCTWJbZptyufgY/mXkkCHe1rY019xRdrXLmFTPSzjP3gTSECE1vLNgw7JW158yztHxP5y0ie65Yx0hB155+lH++BXZQUVOKE5sxdolPrwlKVqIbHSgHLu5DS0dgjoT4AbmvT2/mQnemjXKIzZIcMe8VQQWkNENE4p1t5tbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGj1XFjJcuxwUdV47Iks7WE3ncXj4QwsGQBo0wYdVMg=;
 b=JFD5oIZxDUDVBUk08YsF6IaOuMyQ4D49mauMAc+6dS70+m24uasKOB8SASy7a5tAHDfQweGlOQZSOFrrFb1wTjXvo9bWF4tqr400GGj56nk+1rMaOAebx5WSRau1C+FnbHmtBgvtFt0PBZYhTo+sZGpRVkoHHfqGdDkhI3cU3xgmOx4v83SqcW2rlRohJus1pVqb4Bq0EpvB07EehfQVYoYXWjOqtVtWBn13+CDrVjCF2tbA9f7D21FPCYCIfl6nTRDPJ1w/Kl0ke0fsGs8LzO6yP0Y9lVL05mvuvzmJATx6qr1mcEAk4lAAb23DpoPrfdk8FicOMF+eBIGclB3L8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGj1XFjJcuxwUdV47Iks7WE3ncXj4QwsGQBo0wYdVMg=;
 b=nswu6wAvgT7Q++742xO7zeIoSwfQSj1OTk8L7Y0PzPr4b8EME21shAtmIRZqPnlGr+Yb67h5TM4RREXyRWlpECuKQ2pNChOHJLLGUB8rVD3JsOkV82hf7vemBjD9g7ymd7Q1nCDNjXIyJ/y3ewoxEuc/5jDdGWNa2vfr98BQUTWR03Q6rHM9nrY49FK6TvCe4j5Ohz3xJldxx4YlT6YJyTRdY3DnRQjD+0Ap7TnYALxkA4g8y9GWvkn4yQb6/xBTpmQvtZb6tDeXWD979/TNWtxYFQEnGjL/iItUtURDYpuXOBIXTmkdNR5au83ySWAfe0/DlDRtXhTDNHECzrTJAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 00:28:23 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 00:28:23 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-2-rrameshbabu@nvidia.com>
 <20240312165346.14ec1941@kernel.org>
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
Date: Wed, 13 Mar 2024 17:26:11 -0700
In-reply-to: <20240312165346.14ec1941@kernel.org>
Message-ID: <87le6lbqsa.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:180::17) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fe6f1a-7b7c-4436-90aa-08dc43bda819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3/zjdZqgJK5jNvC1ChMuR2JnezV4VMo6wbnWh78g3zTg6KX+RsexKhIgZnmXU8QfgTbuX0U3YedIbTLs4WSHxgALU/bkntCcMhqeup30DTOKA5OZENVc0gXCKZ/2yVzsNk6jn+WiKVcBW1/U7CzA0z2f+kqqOMQw3cJ0dbJ7wgvG4eiAQp5QESsdUtyiNYOkbjlsoSG+amnHPTEez/t6FMnEC6ZMQWGNGv7BCknPAOpGEmnr9zODmJ2ylBHGdcp5AtdVH3bLGUpgadxIpfKiQnGB1K8/DMXAH6JOqmssYxUStxrjcE3d/9BeRzgzGDztNMVxjSbpzWwcs836RZogDLK0So04eNO3WqvP3fgU3ceUvTOEaMy4wgry2Tc6SHVdhKZQ6kXmv1jcJfokQ2BA9StEcEclkRmoOHM7oYPDx4CyjdvPZ5Nf8UVo/19mluEiteycikxd2RsS1JLG2tMHaKBdEVIHoQxSibxYxVpDa7mPfn9nu7tI5+jFwFcVQtHm7jhqrUbJl6NagrUSIcy5VNkjFxnpzWJXas9Wj6ayqyJdzT7B3f5ECppoL7UM+4mxOGQcm7Re3M2hobSGCGLZQmpKBMjxShoEqdQ8NrtCzxhL8kjOjZmb8smqbqZ6cAgxHMDKndVyfyghx4soTwIxdDoPo5QueH9OHa49wzkb9/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xTkZMxdvye7zKCLiidOXfjUyvmoujC+W08LtfaBjiwk0lPBXnQfj0sDPc7DO?=
 =?us-ascii?Q?BrPYjNUbaVRoGEEgl3U7AdUKhEqXXqd4KzFCpohd4JjDdWvLN4ACHCAQTpSu?=
 =?us-ascii?Q?JkGQemky15fEIDZ9tzm2AySuWOq452hqK28FDtdVoa3bE5nmr/J2EKR3i3nj?=
 =?us-ascii?Q?pWm6j1EgPvj58lJhCPqr3Lm0wYTC/En1Shs2GonXkiRWZj4xqcMdM9heQpnR?=
 =?us-ascii?Q?/ZPUis60jFiHQ7FQ+yAmkgtoXYJrVaTvJXfs2KCX4oVc4umcCmaYIdOxbXPY?=
 =?us-ascii?Q?S6ovr+/+XwmobkmUgxb4iyYejmQf8Ka/krk3iN/yva4rtxv++1Mq0rRr8HW5?=
 =?us-ascii?Q?yNX3RkoWJjdaT7R3VrwRxLy642r9V6tYxBxmrxURW2LtmWFjOSrG0KkXrVpE?=
 =?us-ascii?Q?nRiYG033aTDLmddX0o18G6lR47iIXeG+9JMS8VLFheIqaEXqrN8KzZug94Lq?=
 =?us-ascii?Q?Fihpk4C0Rqbw1uTMqtFJZumGHSnL8gRe8twYzeiZQxHd5y2BESg0663vbwFW?=
 =?us-ascii?Q?Qpc9EznHA5/9wUcmT9IYOq4bnZNXH576Eb47Y0Q0fofBZvN/rmpvN26WiF4X?=
 =?us-ascii?Q?Sv2lKH4/iXsaCAfIiB488TtzdPD+OVnij2i5RXHDRfRu0m5bnwTkoHAL1xAX?=
 =?us-ascii?Q?JR4B5cUKW97OwX225sbfhZaU6FNB16i5D5PHjCYmKCWzIp2CsaE+Kv8QUAKw?=
 =?us-ascii?Q?1oWJHQ3/KlftHOxyGcGy8FmTpjSVeIKwR7LDuhrhTrf7qELy/iCgVhwJHKKa?=
 =?us-ascii?Q?9NXPUlR8evtmsqKRYANIyqID6Dw5jiSWSUL5wn9AAhZKZxQkgMCuIl1M4TWu?=
 =?us-ascii?Q?cXoCcwKijhtalglJQaHaKp+Y8TbDQ5lhqgqdY4tE9ft1cJ524SXtSRT6oXZ5?=
 =?us-ascii?Q?hR5EbP0oj+YOhNRSGu1Ju5XVWHjZeR8OrfDmXHNUrsjqSgj4PfR2SZmWNIvK?=
 =?us-ascii?Q?qu2mGwDKbq0zp+mD2InWWbgWrb/GH4mA5dZ6SaW7AUjxJtSZFM+pv1pUga2U?=
 =?us-ascii?Q?ojAhYajUly+yFSVLKi7uuTuKIqvEq2chGMql+m0YP0cB7ixuqBCHVqTDhCDv?=
 =?us-ascii?Q?H/ofeJoij14HO5pHo3mH9EgqnKImVt7fz8g9jrpfvb/H0xbQ6hnUem/pquUJ?=
 =?us-ascii?Q?XmROu4g3QhF2Pg8vCfqJqk0XndnQWV32yI5pWR+m79OxWHgbW13bGxZ5sjjk?=
 =?us-ascii?Q?HR4+o7wLSo+JY27az8/4UONwDjxZy5s2uyWQkZjXyNLNz1wPeC05Xlq2DEu/?=
 =?us-ascii?Q?yvJJUARSXqQXWQCwp/pul5bX27wzrV9dJ94DvDKGjPBDXLumJkV1NqEiC6tS?=
 =?us-ascii?Q?mu3cvj94tSnZ/X5M/CV0r6FjTPizrJRr99g1tFY82+5k7Rhp3+xR7/GMM/DI?=
 =?us-ascii?Q?sqc2AaRqUKlQpzB9fae4/ZO8LaHvt0EJMuvTdG6Yp/NbfPzB7RZdig0+7dcQ?=
 =?us-ascii?Q?nFZtjaGXskg9NW9yBIe+UsSo2DsOw0fIfevXOMgQmt0muWtzQIDWEbyH6kYz?=
 =?us-ascii?Q?SuaT67nVTkUDL5M/fk6VFCT4+z167EqJeVZsAtnXPBysUKYvXLGexsUUnQdH?=
 =?us-ascii?Q?svDeBRDoWo9xVRPzbrYkX/0LjJ3JadnhBDx4PeyqaLHqznNMsXgM5m9ZihFr?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fe6f1a-7b7c-4436-90aa-08dc43bda819
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 00:28:22.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrohBwDZpAubEMbGaVn48AIkHxTekCzt/zpuMQ4LqMh2GUIzgwu/01JnsaHiTVzIUo6zqdZ1mv4U+O7Hq+iJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

On Tue, 12 Mar, 2024 16:53:46 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Sat,  9 Mar 2024 00:44:35 -0800 Rahul Rameshbabu wrote:
>> Multiple network devices that support hardware timestamping appear to have
>> common behavior with regards to timestamp handling. Implement common Tx
>> hardware timestamping statistics in a tx_stats struct_group. Common Rx
>> hardware timestamping statistics can subsequently be implemented in a
>> rx_stats struct_group for ethtool_ts_stats.
>
>>  Documentation/netlink/specs/ethtool.yaml | 20 +++++++++
>>  include/linux/ethtool.h                  | 21 ++++++++++
>>  include/uapi/linux/ethtool_netlink.h     | 15 +++++++
>>  net/ethtool/tsinfo.c                     | 52 +++++++++++++++++++++++-
>>  4 files changed, 107 insertions(+), 1 deletion(-)
>
> Feels like we should mention the new stats somehow in 
> Documentation/networking/ethtool-netlink.rst
>
>> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
>> index 197208f419dc..f99b003c78c0 100644
>> --- a/Documentation/netlink/specs/ethtool.yaml
>> +++ b/Documentation/netlink/specs/ethtool.yaml
>> @@ -559,6 +559,21 @@ attribute-sets:
>>        -
>>          name: tx-lpi-timer
>>          type: u32
>> +  -
>> +    name: ts-stat
>> +    attributes:
>> +      -
>> +        name: pad
>> +        type: pad
>
> You can remove the pad entry, and...
>
>> +      -
>> +        name: tx-pkts
>> +        type: u64
>
> ...use the uint type for the stats
>
>> +      -
>> +        name: tx-lost
>> +        type: u64
>> +      -
>> +        name: tx-err
>> +        type: u64
>>    -
>>      name: tsinfo
>>      attributes:
>
>> +/**
>> + * struct ethtool_ts_stats - HW timestamping statistics
>> + * @tx_stats: struct group for TX HW timestamping
>> + *	@pkts: Number of packets successfully timestamped by the queried
>> + *	      layer.
>> + *	@lost: Number of packet timestamps that failed to get applied on a
>> + *	      packet by the queried layer.
>> + *	@err: Number of timestamping errors that occurred on the queried
>> + *	     layer.
>
> the kdocs for @lost and @err are not very clear

Makes sense given that these are stale and should have been changed
between my v1 and v2. Here is my new attempt at this.

 /**
  * struct ethtool_ts_stats - HW timestamping statistics
  * @tx_stats: struct group for TX HW timestamping
  *	@pkts: Number of packets successfully timestamped by the hardware.
  *	@lost: Number of hardware timestamping requests where the timestamping
  *            information from the hardware never arrived for submission with
  *            the skb.
  *	@err: Number of arbitrary timestamp generation error events that the
  *           hardware encountered.
  */


>
>> + * @get_ts_stats: Query the device hardware timestamping statistics.
>
> Let's copy & paste the "Drivers must not zero" text in here?
> People seem to miss that requirement anyway, but at least we'll
> have something to point at in review.
>
>> +enum {
>> +	ETHTOOL_A_TS_STAT_UNSPEC,
>> +	ETHTOOL_A_TS_STAT_PAD,
>> +
>> +	ETHTOOL_A_TS_STAT_TX_PKT,			/* array, u64 */
>> +	ETHTOOL_A_TS_STAT_TX_LOST,			/* array, u64 */
>> +	ETHTOOL_A_TS_STAT_TX_ERR,			/* array, u64 */
>
> I don't think these are arrays.

Sorry, copy-paste mistake from FEC stats....

>
>> +
>> +	/* add new constants above here */
>> +	__ETHTOOL_A_TS_STAT_CNT,
>> +	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
>> +
>> +};

Agreed with all the comments here. Have accounted for them in my patches
for my next submission (aiming for non-RFC once the net-next window is
open again).

--
Thanks,

Rahul Rameshbabu

