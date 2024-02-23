Return-Path: <linux-kernel+bounces-79281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F20861FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD871F24DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46D1493B0;
	Fri, 23 Feb 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BoZVTEil"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728D249F1;
	Fri, 23 Feb 2024 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728532; cv=fail; b=ofsWuAIWSMNfTuCt4uaHY93qRy36qElk2NDh4sCZuGjFLmmYnq8GS1W7w9Ohl0OfC60x2DdXWfiIjuEtQFykGq28ZvwSKbbtAJSMq2WRqkPKH0iSWitD5ND2PPmMjGyl7Kl7IjqZLDQaDLgLgAdsvY4fKajB8FFRm0u2BuG9kbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728532; c=relaxed/simple;
	bh=8qhB3LbPwVv9HJcBP6KOT+CxOVqMX34xkG40ql9JWmI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=rnWVMHMPpQezKBvs+U6f0eST2HxBdj9l262mfRL2MakcELtTKekINDRjyNtAXG9u2pVHuJYcwUN3DlOk9Al4ha7fZrNM2yVEZ1hKP/Y3/C0x+ZvlmQMNwQAHNpz1QBSe7H6tb5uJWgIW6DpBYfkQB1DSELXCz9EdprZNrg6CjtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BoZVTEil; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GndvDIjQZLlf94kZfIOoQVY7pgJsAXFq76qy7k2yJAKdxwAa09l6tcDyYzS3Dc7t4PdcjP+oma7U6g6u/2gOAvfNRfbuaLfc53AsStbX8CAP5e6XFQlvWn8cyQVtB7VxmMVrq0JPSOA1K/4s/LvoI+Zq0nKnnWbiei6J20Ai+Oz+Z7aR58pm8cwcH+U7KNIyQoqUVA45xuotvvEOssk8cf/U0e+O3orF1RlP4H5TOhntwnJkh18KQd24YECRzHw4qEPDUU9XrhK4JJwRrxDzwkvSr86oeXANsVXGMsanufigFbM2PhEbWc7KrojJGj858/8L/PW6sWV8qRPSDPG2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXv8dqCAof1zQ6M6qceAya8i8P1FzNPdGa8niwoy/Ik=;
 b=eU6cgorOL4IWOGMxK3xCDpYT7JDCQJZvXqs0qYi9c8cJPTzA91NB8ej5JBThx0TXNfpGBb0Dy559VVxhn9wH56O7c94WlOdxa0lwMYphvQnxPGYki1m1YFz84Wl5WjSeLD5BodUXK6nG6Va8nRWogtE18E++fER+UYYVBgRwt7UKM7sGcq3rreYr/BN/wbJyz+UX1VID8KLE0cwVt2A9+7G8Frzw3HxBYTM2sZz9g7qWKxdYQgVug5X7j2k4aN2Q5GqtQ6lK0nCDut1317y9aO5iWsvDlRDoMZWIUpqUjne6harwl5EVO3BCOGq9cmqJ+Uaf7YhVTsjER50n3G0Dhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXv8dqCAof1zQ6M6qceAya8i8P1FzNPdGa8niwoy/Ik=;
 b=BoZVTEiliOaI3ky32hQ56b7w+I1XgNpImqjpecKP8e39p9L0r3W46SqxXKiCkcc5D7SnS6Nc9mS+8jPkKHVKzzef93XXCjDvg8kDbbU6lnJrg1bsArvxvQdR5oAbB85Du2Q1LzwA76D1gz2uioymQw/ATB39R5T1YQHrv9LjnOoBwiAp2Z997jEQd2NA/19uCVFjbUjdMOSDEZNUA2LAqpv4QWcv8XUMxt6Uw3ncA0/nTY7iyVeKWsVMdy9ZRPEhjJ6RJy7au2L91w8dac8AkYIPo/WfyeeoFen2B42bNQJBvo+osl+ELqUHdArUeZ4yFbpUPfL6fGeON1Sa6zSTyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5276.namprd12.prod.outlook.com (2603:10b6:408:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 22:48:45 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:48:44 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <4c94d725-a903-4979-bcc6-9353e0869cd7@intel.com>
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
Subject: Re: [PATCH RFC net-next v1 0/6] ethtool HW timestamping statistics
Date: Fri, 23 Feb 2024 14:47:37 -0800
In-reply-to: <4c94d725-a903-4979-bcc6-9353e0869cd7@intel.com>
Message-ID: <87ttlyvltg.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5276:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c89f25-43a0-4db6-7923-08dc34c196c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qHK8w0JJoC6+Ky5ZWstRaFu6PuKiTK5vJm9OhE2C/PCV1NxoyDSJOZsJJNCAOvE6VMp3P0XJUl7+na/X7lu0HsBgQ8rGwIp/ZRzrAqKXFjY+RckJzF1giH+LETY/NBrAE/t+EfxEftaiticPLWiaFB1I5V2U9YNW1Bpx2lXwyYZVPo0mUkbZBDPEGl6YltYgka6G2tApf21Aq/YcKQU6kBCC+DMG4v+pmb8h6Q/9HslnT+yNPa4Nf1OO6kD4nI+uVZKyJxP6FnthXqKD1mCMKTgWsFQGrHh7ghqJJJWPEnJ+0poHBQsA39N1YCxyPsld1xiZix6bkeoCtQOgFjuoBJk9s4AXuupcoKr30v57aLn3PVp/Vy/wodJbBECWdR2BFw8uQZsqB1LgZYG1WzVDVBaGPZ4cPIqS//1R3WnuZWukKCnZ4ROjZjNhpt9Okbi0Gq82Q0EngNMrX5AU6t7tdoc4ncm36YKOOIU6li40X+WrlUE/dqzSAwrubN1iGU6PhbLkVLaoF/Lz0dfSRGkkqEqFGFDC3oglx1IuVbkE/9hRMQhEHPwqfYMEHI3wEfst
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TH+Bz4uu/VnlIFnr+nGjtqK9j9XDShNxga9Xka3ozg2teE0MeC+epyTJzj2i?=
 =?us-ascii?Q?ev/jNz1zW2410bkiWp5tr2gQ2dad0q7R50pOX4Q4yDI7dXiZQBZyxvtZyTNG?=
 =?us-ascii?Q?V8hg2+LiwdmKGJfUKBMgMYUK12yBYz2A4LVdBPHj1JgEaN2ZW5dwkhhMvVKY?=
 =?us-ascii?Q?fhEjW7XxvXQBCAiGtDq3RdJDn7m74fQK664yeJfCni3ipJHYPYSiZpuM+Lk5?=
 =?us-ascii?Q?Nzpo+5+6vzChe0NG0ps9SOPcn4+ydklx+aSRLEoPip8A9QE4wjf80HKYpQZz?=
 =?us-ascii?Q?3JMp4mB8qyoOclMz3tVK1EHrcdwjz7JSch1/Xwjc5qtWAXJczoLxzW5tl+Ga?=
 =?us-ascii?Q?RY2/dpPJjRqStjg3My6VKJwHaZekhz1ZaQlYU0w1yhCNJUFeGEcUznEs5uRT?=
 =?us-ascii?Q?sirwuOqOMv0/Vs13ZiloiZKt5MxvzmD49sgbWuwGWFggmt8eO4OMnRo2Vk2U?=
 =?us-ascii?Q?+K4qsO64ZB8xc9xVWzY9dq2A0V47AbxiBrC892jUngsdump1TWr5IzEDq5g9?=
 =?us-ascii?Q?gs6j74oIOFf1p4tsLlpFTsglxcQm75bRa3fzRSdr0Rq451YrbROs+UfB6eF2?=
 =?us-ascii?Q?aRZraBdHfPf89266PLZP4hqBXcwJPslP7wQJz1EPrCDXfhHvMbA0nVpUKtyv?=
 =?us-ascii?Q?OKYsH2X+KcS33fnM+h3orDAx0tXw46JaNth/ZqizKkMMpDqZCP2uZLiNIrkk?=
 =?us-ascii?Q?yuOrDGF3n4JLrOnsbl5F6MW320yauER62WYJ1biPat92ElPhzQMTqM8rJHYV?=
 =?us-ascii?Q?O9ueP4Q8Qq5uHPIlFDvMCEFnj/pb/byjBqAD28FFAMFe0nm0VsY/W+ixYOVe?=
 =?us-ascii?Q?RGja74TmqnOl4uKeGjpd421T71/H88zHMg2O6/FgcAEcMx/i97SxsAo9V3ip?=
 =?us-ascii?Q?5qBv6uJeVBdxta70urHKk5jm0c6iW6Ivl4auItOk2xlt33iwbqD/PVuekkyh?=
 =?us-ascii?Q?yX+TrJY9F7xE+pQ2FMV6QWX63EF5AJGO0xCoawArMNKgJRWtso9RmBpqDda3?=
 =?us-ascii?Q?zvDv0NbCjFMWqaapNlU1eZzR9DMTLZy5MGel2U4hf4UIuiTQBbptrj+9WwaJ?=
 =?us-ascii?Q?noHObl1YuQXpAD16l8Q2MlPphhihPGwx5vzFGnAR6pKEUf+uL/6DmxXvYwZD?=
 =?us-ascii?Q?+f23ALY4ECA/x3VpXyepRVuyJQdlg/B8HI5TXRX8uQr6wxgrWR0yMFclmw8W?=
 =?us-ascii?Q?KQj6miJ7lhG/6ZaZqusRX4K0L1DPmzT+AFHKykyool+y3jME1N9qw+/zs68x?=
 =?us-ascii?Q?U5VaxEVnyerzkdbrN0faWqaFjNRNstLEzPTKBSAorAnMsphyJlO6YuHJNvjf?=
 =?us-ascii?Q?iwkG89JXGsZCwpL1CD1fw8WL4GxsSUARjoKRcEfSJS4A3OGc9eSkxRO1GB8s?=
 =?us-ascii?Q?7mNNU73evTr0mhWZqMyWkDeQCAFeL4KpMZetLnS/OQVd2BgnL3v/KR+T+aFd?=
 =?us-ascii?Q?ujJ/f7zLsQfw3xoY8y8PI4JrOxhoVHlSMikGuS/Y6dicoELpwtSZ0PO8MSwd?=
 =?us-ascii?Q?F8MC+jHXQVZqLnWn8iaH8w2dMQaRR3ZDp5w3D2sWW/LMg56MqTvxZvn/839B?=
 =?us-ascii?Q?wWAwTe09wN543CYpicArCR7YitI0uOBlnPaGepHzHBAk4yVHh7+WjpP1Ma2A?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c89f25-43a0-4db6-7923-08dc34c196c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:48:44.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsAgWbmzXi/MAJitROw2ynIk151hni7k4zeWYbGA/iJypzQKy7JS7saaGnYNpYXsdW9g99KOi86eNuTJOAkaNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5276

On Fri, 23 Feb, 2024 13:00:10 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 2/23/2024 11:24 AM, Rahul Rameshbabu wrote:
>> The goal of this patch series is to introduce a common set of ethtool statistics
>> for hardware timestamping that a driver implementer can hook into. The
>> statistics counters added are based on what I believe are common
>> patterns/behaviors found across various hardware timestamping implementations
>> seen in the kernel tree today. The mlx5 family of devices is used as the PoC for
>> this patch series. Other vendors are more than welcome to chim in on this
>> series.
>> 
>> Statistics can be queried from either the DMA or PHY layers. I think this
>> concept of layer-based statistics selection and the general timestamping layer
>> selection work Kory Maincent is working on can be converged together [1].
>> 
>> [1] https://lore.kernel.org/netdev/20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com/
>> 
>
> Makes sense! I like this direction, I had meant to work on this for the
> Intel parts, but got sidetracked by other tasks.

I still have a back burner task for a cyclecounter API change you
suggested a while back.... Hoping to get to that after getting some
large features out of the way in the next two months.

--
Thanks,

Rahul Rameshbabu

