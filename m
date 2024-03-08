Return-Path: <linux-kernel+bounces-96527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B255875D8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7991C21C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476F532C8E;
	Fri,  8 Mar 2024 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kCNOelpC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292812E65B;
	Fri,  8 Mar 2024 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709875794; cv=fail; b=g7KWQrIEGD3YkKx+VbbPmzNFyruyyTftnMGjMv78xX+nqG89AXWJClJhc05YDs/GHyQOp7Z93meR/cjvg6dfHGmFxPD159LoVckOeumzApNNMZ2F4X6dB4MxqxpW+Td8Y6WxdUmOsX8vr+sZF6sA+qw3nd2euxA3FkxaBuUpNvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709875794; c=relaxed/simple;
	bh=mRCNYqq1ydpK77fKwNmuyVg/Oo+zbBNQ83b6meKnRwQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=mSPFG+MmnKDOb7gXGKWFmFVgyZSBbax9X5/LLs4jVRXex17E21hGPQBEkECx17MFzBeZvs+xoIMseYJBI57ooKN6wu4OtoHR+aZWdFB9W7MqVs3o9VrIePvi1IHLSBmRmE/9YDQUS1wHacBOsNtXIHHBtXeSATNjYKF3aFeppGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kCNOelpC; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM2jW34g/m7oJp96DoNYcoIaefj1L/8ep/CLk7b3XadLhOH+xVme3DR+8744C5+SBl08UnYHfpl8x70+4e4TkZOLAta4lbGsGZA/fXU5dfCD+HYuN/Ilj1xLE2nkIrzG8bQv3VxSoED0tv0Igu+/VsZ6ATDfBW/EnnCF5m3nmbiUTUtpaUlGnX2wWz11XyLyDW2AFAH8LT2aO1wFhzjLx66b4kv9ohMziadJOyq2Vc1lZHIaZUlYYAjd+PaR3X94j7EhZ4m3gdxz458txjUoLZ95IW1VJybsBNpoCYdxSeChqC7CasNSveSWFCvCS5mNE17Xk9uBPeg71PGrkAZwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56fNPCYJBldnaNLAZyfoBGn7ImQAQT1/XDFwScOPy+A=;
 b=AuL5E8KY6yiO5XoJ4sfsFTePosH4yhJC0epogUs1cuoGG1pc/U50FYbcic+ag1j1cD5uvhkuvdLkKbqLGGRpgX/31CVnt3dv9SEWW3xD2qEMqFmVvQc2B8z163zlD7IysvnFocZqmsdLZuVbTx0Vg6WOFaCDET8NVlILMqsF/08uMKcUZAZeo/jFukkOL55bJMUbpbveNkthbTwsYP2dNE3Dio2CDxG/gbaGZxlrRzsPRk7NPatmD1Fd2CGN+eMFfub05EgQbQjxpZAQB3T5xi4NQatzxvxod9FO/bNAa5IVWcBy9Ux1C8q61XzDN8ktgbxR/EpV2+gO31U+A6lp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56fNPCYJBldnaNLAZyfoBGn7ImQAQT1/XDFwScOPy+A=;
 b=kCNOelpCDLYPPWRGdr/3j7RbngBXFIJIRwLtNDHJFqBH14nKLPfjSoNBtPrhTtAhK4xHiLLk6zlovXYLyhVZ1Un26f6iDQTMfUpGvOXre5cZDYkiu7H0ZiWVnJW3WnpU+aGJEgiemD8rp382yQZzyyHv8AaohrukL7FxH301XR+0sHzvP1j1SyOExyOfk9DlLM8VX6Rwv9q+ktsPt8FqRD4b97jC6AXh51V+ri/JU27dB29r3UjM5r+dHQq15Vhszvpx3makDbekeQDybjj6dtnnOvubinIkH6bIC3N2PeIxnZWlEUEKRsHI09YHI2o6/T0iRu+J5w0WDvIvJKFPtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 05:29:49 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 05:29:48 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com>
 <875xyex10q.fsf@nvidia.com>
 <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com>
 <87il2evhtk.fsf@nvidia.com>
 <ec969f62-a1bb-4287-a4eb-083201134bae@intel.com>
 <87le6tvpq8.fsf@nvidia.com>
 <d030d02d-150d-4337-a063-69da28049548@intel.com>
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
Date: Thu, 07 Mar 2024 21:09:18 -0800
In-reply-to: <d030d02d-150d-4337-a063-69da28049548@intel.com>
Message-ID: <87edcljnp0.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 94250a27-fe77-43d4-082f-08dc3f30c58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2rQhaPS/1DPGgg1SgeCunMolxf8tMfMg9MMubIbFkjXvLxon3tjKR3kAel0RjHJINZ8OFSsUYyntO4QiN9cfCOcFImBr16xqGN+Oh2uy2k2+g2cIzvQjJjCaq+db96vtVYI3cxf2oqdVbwJpn/SFTPcpDfuL5mKDv4PqZgJCYO+6Xdd5Wjp+Q9m1eZvsPeUXjymLKEfdxsKDXZtwQh7/0d5xi5QVPUWtHaYHSBLpBkKUYKcH5P2RgouIAQ57pozI7gFlqxTRkTtOPEslgYwGQ5vLI/hpRwVRsBi1v+TYZvRBmVUUcfsGpt8BCle233fPgBI1bAeKSWO3NRFDd2iFDPa12dk3GUt5Ua9LO9X4oqNmhESVmYoJslTH2YnHc5SrQBrjbeQx/umOsjc1S6bbI0DL8687YJgS6d18N91N77yKbRJoHgAr2jBqMNWBE1mUn+D33jNhtZolr/7odG51xgL4v0E/3CruSIx3BldNSkWzplbgsoEg8BkoffXWNSCf9VaKMZIvZMS7xsepkHHAcKHMBrPHJTo27V3d8ctCoe5DnAWfp1bSNe1KKX+bQPqCbE9oHhKmTdKjyeJYMxjUlRH5W5Cw7w+1xtE6Tecur4YSXPLuifLzWjHbLzbvK7W2L0VHLqzRMUe1zHhu1oYcpvRiMKZghJp8vIQYufEm6Qo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQIFm+P1PoQcVwfWoWDU2qeJe01rBH/mkGCYbq/mNt/DBv6SkvdYMNhmPC47?=
 =?us-ascii?Q?M9c7hLp4seTGN1gVCNqQa3oPQfP/5MWnTu1Wh2mTiqXqXtfymB9bNuqO/tHr?=
 =?us-ascii?Q?ZS88y6WFZG+rr84LpfXWuA3n6w7XWM/Gi5MNZHddvFN/b3zl88CjKkTnUEae?=
 =?us-ascii?Q?QON8imCnoz5ywplpwbZYnCgMsP5MUZlAv8AkV2LSuAtz4UrHx/gyN7RHKEQg?=
 =?us-ascii?Q?f/Sk2KZ+0YR+X3WttiJXOmksbctmI5MZu0LYhS/M9U/kcXxSTwNVFvipU1Kb?=
 =?us-ascii?Q?iUv5vza7NI6qaOF3lO6mvSU9M2c+ypNLmeUpdDFkNYfYmOodyRb9B8jpzsYw?=
 =?us-ascii?Q?q9ydG+CUq7QWexwjgGnDKHHZTk57LTfvQmZGuZmrp+0t+ujlgDZKGd34QqCW?=
 =?us-ascii?Q?DKDKO1AyixP5gmAyoOoLm6GxzgQZAEmDgH8NxhWRmFuqH62rGW7aq9rmrviy?=
 =?us-ascii?Q?3QUTyko6U6pEC3lkhX0XvBXL4LoyIOFvy4A8tVc+lckw7FipgpN/M5jQOdXj?=
 =?us-ascii?Q?6nJhr5y5MKA7Uv9Ar2WZ54Ig2qxz4GIo6krEL/OOWyTj9stV4UHNQbPmxbrE?=
 =?us-ascii?Q?MBHFRfhbe7IDuI1oNX5h5YwnjZCmXjzcsBuH0ztBg3ZlmLAvOh8QqD9GBU3a?=
 =?us-ascii?Q?jE3b6KPj17qfLtVxSJ4Ej6C9qM2/QUth9JgKjDTWuq4ZgZYYGr8CLHox/vnS?=
 =?us-ascii?Q?X4i/Ah0uwDuzyzSKdmyaKNetdgHqfcDBxYErIzRAyvsa50gsHNvZ+WJEo/Qn?=
 =?us-ascii?Q?4xanBkUXlHdKgLITmCkx+h7dAvTb+6XaHUcUjTx5887DYHtv2sXkVN11hSdm?=
 =?us-ascii?Q?WP63wnJkCR5TNw35MXZ9YJjCk1Ggvc3rKyzxWYOFSbJvEC5CbbQrdYj5l/Cf?=
 =?us-ascii?Q?CUUlSCoKT7jXusOtB/QoCD+xG02C7H+Oqy0aL0lRyg70Y2PnFMlg/j2LiogJ?=
 =?us-ascii?Q?/WG7s/Zd21+TQCkRioCQGIDlJDgAvKyoAE5unFSyDJVBhwZpC+8YZYM/dw2G?=
 =?us-ascii?Q?5r15dWQbzy5rsARpxddMgSfSEfL/8g2gZ425Ha3BsUtfGbLKGNnOBIztJtNm?=
 =?us-ascii?Q?r3NhNpjf2RZO97nR5XdxCq4WMde+mHdcJgh7Zi7Bj8k4LKk0fBLpre5pKLuj?=
 =?us-ascii?Q?McFw7J1X2CIUXP7CuaHUZyLqVTuiBJr09zfN0nFZdMKJ2Q+Q0UNjwKKwHC6d?=
 =?us-ascii?Q?HxhhmuqUr3zd3INpe1s6ToxepmEhDYYp941erRWEcP3HTpe2U89CduckCIY8?=
 =?us-ascii?Q?+Y/xoZA5bP22L5kPJOqhxKKLjfg6Aajv/XRYi8kN5tVw/s6pBzv6KIoM9Ug5?=
 =?us-ascii?Q?ASOk2ZvqdSwUC21X0yPEbBeDKTUxUHWNqSu2vZZxFm0qHYrFz+/pP6IziE3s?=
 =?us-ascii?Q?A+70cz6YtcaAo1mvUqJ6XQ/NdbLudEPc9HDMoGdPMoHasBUx97JmNFkeXDih?=
 =?us-ascii?Q?T+eKnYrfXKCH/V4sXf+YjYfjkI0WCPVjEIiEKhhYQKxWrsVNvlZNpYP0H1Md?=
 =?us-ascii?Q?yrOAhgYZlm9NvwQMiPOYYtCEHoksXPZotDfORhfrAMOk6nTekGhxImlMBhMB?=
 =?us-ascii?Q?0foQyUGGGeCcGyUPVFYuGFZdFe5zsIVUlMA05Ia3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94250a27-fe77-43d4-082f-08dc3f30c58b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 05:29:48.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWogxAT3KS50jz7dVqgaNzWcc9vbtQ8brME/8mt+MlkIlVKNJbasRpyZdTfrWUg3gtQCwRGtV0lGoBgCq7momA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172


On Thu, 07 Mar, 2024 19:29:08 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 3/7/2024 10:47 AM, Rahul Rameshbabu wrote:
>> Hi Jacob,
>> 
>> On Mon, 26 Feb, 2024 11:54:49 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
>>> On 2/23/2024 3:43 PM, Rahul Rameshbabu wrote:
>>>>
>>>> On Fri, 23 Feb, 2024 14:48:51 -0800 Jacob Keller <jacob.e.keller@intel.com>
>>>> wrote:
>>>>> On 2/23/2024 2:21 PM, Rahul Rameshbabu wrote:
>>>>>> Do you have any example of a case of skipping timestamp information that
>>>>>> is not related to lack of delivery over time? I am wondering if this
>>>>>> case is more like a hardware error or not. Or is it more like something
>>>>>> along the lines of being busy/would impact line rate of timestamp
>>>>>> information must be recorded?
>>>>>>
>>>>>
>>>>> The main example for skipped is the event where all our slots are full
>>>>> at point of timestamp request.
>>>>
>>>> This is what I was guessing as the main (if not only reason). For this
>>>> specific reason, I think a general "busy" stats counter makes sense.
>>>> mlx5 does not need this counter, but I can see a lot of other hw
>>>> implementations needing this. (The skipped counter name obviously should
>>>> be left only in the ice driver. Just felt "busy" was easy to understand
>>>> for generalized counters.)
>>>
>>> Yea, I don't expect this would be required for all hardware but it seems
>>> like a common approach if you have limited slots for Tx timestamps
>>> available.
>>>
>> Sorry to bump this thread once more, but I had a question regarding the
>> Intel driver in regards to this. Instead of having a busy case when all
>> the slots are full, would it make sense to stop the netdev queues in
>> this case, we actually do this in mlx5 (though keep in mind that we have
>> a dedicated queue just for port/phy timestamping that we start/stop).
>> 
>> Maybe in your case, you can have a mix of HW timestamping and non-HW
>> timestamping in the same queue, which is why you have a busy case?
>> 
>
> We don't use a dedicated queue. The issue isn't queue capacity so much
> as it is the number of slots in the PHY for where it can save the
> timestamp data.

In mlx5, we use a dedicated queue just for the purpose of HW
timestamping because we actually do have a similar slot mechanism. We
call it metadata. We have a limit of 256 entries. We steer PTP traffic
specifically (though we will be changing this to any HW timestamped
traffic with the work Kory is doing) to this queue by matching against
the protocol and port. All other traffic goes to the normal queues that
cannot consume the timestamping slots. When all the slots are occupied,
we stop the timestamping queue rather than throwing some busy error.

>
> In practice the most common application (ptp4l) synchronously waits for
> timestamps, and only has one outstanding at a time. Likely due to
> limitations with original hardware that only supported one outstanding
> Tx timestamp.
>
>> Wanted to inquire about this before sending out a RFC v2.
>
> That's actually an interesting approach to change to a dedicated queue
> which we could lock and start/stop it when the indexes are full. How
> does that interact with the stack UDP and Ethernet stacks? Presumably
> when you go to transmit, you'd need to pick a queue and if its stopped
> you'd have to drop or tell the stack?

Let me share a pointer in mlx5 for how we do the queue selection. Like I
mentioned, we steer ptp traffic specifically, but we can change this to
just steer any skb that indicates hw timestamping.

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n71

Then, here is how we manage stopping and waking the queue (we tell the
core stack about this so we do not have to drop traffic due to some kind
of busy state because our metadata/slots are all consumed).

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n775
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n257
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n397

>
> I think I remember someone experimenting with returning NETDEV_TX_BUSY
> when the slots were full, but in practice this caused a lot of issues.
> None of the other devices we have with only a single slot (one set of
> registers, ixgbe, i40e, igb, e1000) did that either.

So we experimented that even with a single slot (we had reasons for
testing this), the dedicated queue for timestamping worked out nicely. I
really would suggest investigating this model since I think it might
play out nicely for the Intel family.

>
> If this queue model behaves in a sane way (or if we can communicate
> something similar by reporting back up the stack without needing a
> dedicated queue?) that could be better than the current situation.

I personally really like the dedicated queue in the device drivers, but
if we want to instead model this slot management work in the core netdev
stack, I do not think that is a bad endeavor either (when slots are
full, hw timestamping traffic is held back till they become available).
I do think the netif_tx_wake_queue/netif_tx_stop_queue + dedicated HW
timestamping queue does work out nicely.

Let me know your thoughts on this. If you think it's an interesting idea
to explore, lets not add the busy counter now in this series. I already
dropped the late counter. We can add the busy counter later on if you
feel this model I have shared is not viable for Intel. I wanted to avoid
introducing too many counters pre-emptively that might not actually be
consumed widely. I had a thought that what you presented with slots is
very similar to what we have with metadata in mlx5, so I thought that
maybe handling the management of these slots in a different way with
something like a dedicated queue for HW timestamping could make the
design cleaner.

--
Thanks,

Rahul Rameshbabu

