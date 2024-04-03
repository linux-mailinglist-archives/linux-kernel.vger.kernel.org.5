Return-Path: <linux-kernel+bounces-129065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7961289643B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4C4B21E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9A4D9FA;
	Wed,  3 Apr 2024 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NcesQ6EC"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2107.outbound.protection.outlook.com [40.107.102.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF54645;
	Wed,  3 Apr 2024 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712123219; cv=fail; b=htRFVF9+SfU2Db/gVUL5IL1xE++9pj0TKVa6lz2Ew5ghlu54B8Q6NPL0W7Gk4RioZoSWa1veg+ugxcd9oqJqvNNp36kgVdv78YwHihmvkOCcMWpzjweuHSt5zxZD0DRIVVAsHOuF+rG/XyE5TDdNOkybz6XdsLFMoPvOuV3tSaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712123219; c=relaxed/simple;
	bh=OJudV+n1tKL2PiLEQo2+gi91BGv4SCkTWJstbzJUUVY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=FLkmjJlifacFk3jisZCu7UH8gQgaZVCwmxNkZUHerkNHSA6qWOsZOOBScqmrd2Q4UBp6RBViK+Cn9rz18tzjMLZ5hAagQqGUq3vocXE6u6tmDhV7mchrj4nFRusivI+iqNIM6jCsbY4ifO6oYNvdkKERvghPQrGxb4o3z5KFjII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NcesQ6EC; arc=fail smtp.client-ip=40.107.102.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPScQHjuPfjPWoIxVRaV0q6ghXJLDXFI4zlHfgd41ZAvNS8u9FX/imcoUPLcnQ83W+szSU/Lg6QcXE5JjdmVxFcsFVZfxuCkcybyIOLQiIrBxcf9sLWsBhslWHwu8AU8ey8n0Y0Nb5HbtZKnbrsYkeM4kfAjwSriLEuTE3s2A/4YCgDYyH2BhQVJu2TGXBYEBRymLCkfn2fVP8TiiDJ1d6dSJn8C2WVtGCjTpLYmmpDgwyxiEcNVFfVYTGSip3KRhRXr6UgD7zBv4mi2TsqU2PXuBRrIv0pWTST8EB7eqGXgP22gyYv1AhUgWm4mijCadRHBOUFtjxc63+4LoanQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDLk5HZw+fSKx+VIXuFdhZN6iMwF9y+6ha0jWrUWf5o=;
 b=Y+1eFRaw5ngh4+CNwqTP5awAD0FsVzu73FLWPBzsOLfJRShFaJTxLmK7iIbFL5uLYPyVR2pUSt++oDaoffPOo7jdeTR1KiemzrlVoAs1yQUfUvrXsTvWB6Oy96sm3ODcbpOWK3L9XPXNZye+pQ/MOHdkFjo8LJ9ckKHuwcJh+Wgrpfyjw0Eybdqf/OaBl9SuZgRt3F/2njidm7IIK8NtbQCFEv6DGd7CUG8pfNKA1oJLNzFJ98v+FaErnGagJDaqtFE2u0l7V94d0JfssSsUNeGY5Ur5jKgajSkSFPCCrezHQpzU3mofyNNhP9Y/qji1nbYEgLk12p+qdo6n1JdHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDLk5HZw+fSKx+VIXuFdhZN6iMwF9y+6ha0jWrUWf5o=;
 b=NcesQ6ECrZiH20fyjxfrmIpitA+zPAlgjO57tFFDQr4GG4EW5IXqfQCInwpRR+hWjSLT6AZ1w97URVKWT3tW9iSSyzlaTKO4CgcegVpHlR+lCjoh1P7P7lRKVFL24lAS69jnRKNVKrJD7QDxLIn8t7XLkwy5JV9UPLr/MQzWRee0KoSm0reW4++HoqASY+G3rLrSooeB14hyN60zuUKpLs5CHxzZBbjzi5tJ8rLa0Fw88Daq9S/5WyaLJmb1Olg5++uAZB0wN9EjzQLS2QvnaHk9w5TUZjKQqK/hejfjc8XWoLrYCmGoeGOR8RM3sILWni+vAQcvUWrgkVlw0F8FeA==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 05:46:54 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 05:46:54 +0000
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
 <20240402205223.137565-2-rrameshbabu@nvidia.com>
 <20240402191842.66decfd3@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, alexandre.torgue@foss.st.com,
 andrew@lunn.ch, cjubran@nvidia.com, corbet@lwn.net, davem@davemloft.net,
 dtatulea@nvidia.com, edumazet@google.com, gal@nvidia.com,
 hkallweit1@gmail.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 joabreu@synopsys.com, justinstitt@google.com, kory.maincent@bootlin.com,
 leon@kernel.org, liuhangbin@gmail.com, maxime.chevallier@bootlin.com,
 pabeni@redhat.com, paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Date: Tue, 02 Apr 2024 22:14:38 -0700
In-reply-to: <20240402191842.66decfd3@kernel.org>
Message-ID: <87r0fn2e2b.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4044:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pkpZMeGS9rxC1AkjYwpnuYgc9r6LxhN3+HZqdyGZHiu5HIDOkMDw/jaXkv1/cl01twrYJ+7+o4c5fTlV5GiP8f5khyQXpqM4WTK+tMc5kv82naI2pkZ3uLoNLaiWrv1HcK6ZcaDza2aYyEwwuwWuR17iLLNY4POyvfe/ME9v2h/sfczqm0UnY23JRDvAJp8MgLf9VoA9dYGsouOeeqFv6CSipkDB/jOz/+SnPgvWxGBSgAAQQf584UG9mDV8ol6J7v4/Y6JRq9O5upIOf8KfpxidLO52IlDoD1v/y4ATcREi8UBPxCGGgzrw3rvvBy9/TiNqLre0FNveKzjkw6iPVU5ZwCwh4JRSxAmdUnqpje9s45SXH3iPO98A9GKj/SeZJZnoRguFH9XDo5+gjQf3e4cejF+N/RdRwe8V2dzl2Oxn/DOdxAXuE+9O3WuHJsVoPA0muCQ7O75NWoqhyneGwxs8RuR6ZLBWD7FWoQwmxfTD53bAS6sKAOmXsqnkHD6pr9EjyOpnySNp01N3a3yd9xCHaKCEzArXLsixBcFqEQAPnqc7VtV+61OBkjEchHhAdXOzQkbhlZPCOU32fZ7cMfuQKZCuteVKlXkUQQ3lmzhFWQIeyn/pMxk4vxEoCDQ8tgFjy6o6zpbCC9aA8/R1mRYWxSl0mZoiJZxs07C4BRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JJ7xOmvuUZQ2fv6IPHu7mllDxAPhOUEbVo5nxUud3LjspBKeozBwaFsVpg9E?=
 =?us-ascii?Q?ZC1aj5kZf39XiwH4gbJFcJ+LOWZpHdTkvIG4uhQoIbXUzlFmIRZfOzljcSeH?=
 =?us-ascii?Q?wmVy9J5DtFnjl4aFe6DZHPpMi4ihm6k+6Fcd4zsVErhYyLREzkHnqmFYTr1P?=
 =?us-ascii?Q?+NS4onu+JR2PpJ1pQnn+Gl3Vw5MBB1lj/c2O+mkHXOoT1Z0JZxgX5A3WSW0A?=
 =?us-ascii?Q?twNXSwJsqXAi3QgLWsT46QjENJfDMN6vly59eSLlHLEDnhrlScgaCp1aKzi9?=
 =?us-ascii?Q?b2TqTQ+Rx1zbTPG09HbEY+bItMrS9o1eOrjVPq+9qLEwD1MwA7MzDhLtLtVK?=
 =?us-ascii?Q?06msDmpsCxNJ4Pu/vRSEOQI1/cJcStHZap+/3TlWyMhmCtGrhp+w1BOUrxMa?=
 =?us-ascii?Q?ztOOhukEzEmlUEBM0Ua6ahLsXp8Lgoe2dFnbq08/Aj/O6FRh86cEvVVvti7d?=
 =?us-ascii?Q?LEftBW4Pj7cQj0PJ+czm2X/xKVykDkQViElWKTm8ex3oY7qFTFkjPzjdHW38?=
 =?us-ascii?Q?TpXMvDFaN4xMi//ZkvEyb51wAInFqhKh542ZnD7gb75rL5R7Vrq/ZZWhOv7u?=
 =?us-ascii?Q?l1NQLYyoIu0VmRpoJPeayZv/IhoK8J3WJ66PmMXBa3S4zHn6NyogoaioHADg?=
 =?us-ascii?Q?cFbAwfh7zCbsL3Vu45Pwoh8EawD8Scg+BbKuL6xT9zYNNDNSVnXommuSqw4k?=
 =?us-ascii?Q?hj4q/h5WAoV/P8dYx+ZV9dVxel8BxRxSbJYrbkQTR5tk9YdrmOXdvnVptAK1?=
 =?us-ascii?Q?0oMy07baNXNfCipZYsq/igO+NdeTu2DYxxtyXW43wibQFzEO0rrVOsjOlJUq?=
 =?us-ascii?Q?pEDKaKEofPJIZmnMekgk5x7buiFYjwoKDLAn/CnldoUTZWwDTqFkybhdsjtT?=
 =?us-ascii?Q?67lQZt0eHRhyvqKkxPLWrBBPrjav5ET7VeeYYgcroIedURhcWRJB150fER0g?=
 =?us-ascii?Q?0XhUOR8bKO316r8rZAKMjsEYM9ZcU8ookg4RywArjgbuYZSSqnxShnhslqIF?=
 =?us-ascii?Q?39smW4/eLOMa70LAMOdPL2M14PQqBtWPF8mmOoB6kJ0KQBhGA3ovdQRLjXQl?=
 =?us-ascii?Q?Kb+eNdYJWIMnYwJa+Yp2uKoPrLGttRBXWEiEEV3IR40VZM5H5zbwGWKX2btY?=
 =?us-ascii?Q?5L9+FVeEtcSwBdPdhhnm9RuUCIKy1mOMkTdwiJgOVXqZS2wl4woeuvwnALmq?=
 =?us-ascii?Q?2x1whM+sxBwE6YRe3kupaR3qqu8c/IL7pt33TzAqruhwiRVhazx8jgyMva72?=
 =?us-ascii?Q?PTD7v1RWs2oUaF1q8c0gVZU2qCnEIUNMhFwS/lWMa6PEMlUK8R3O8joxjeHv?=
 =?us-ascii?Q?5VVFpbhMVJNesUARrBdypzsRacGQvY9pMxCfKbOUCMfbwjlpobZknPy28gnv?=
 =?us-ascii?Q?cYUH5F1Rz8eo506uIMeURwP1dUspHuEEGEF6T0fo959PCF4mJpKDgLU29ML4?=
 =?us-ascii?Q?C3KPX7V80Roxe7QjI2Ms0IdsTA2WRdxnEhPwOwHY90uoBnLzy438AMbW/sQx?=
 =?us-ascii?Q?ZAbiG/UWqaS/6nEmqwe8hEDM/JAUWz8mdS5nNKuWmb2mhl4JQWcV1PZe9jM/?=
 =?us-ascii?Q?H5nJ4S3kXCt7bmGNo3N2u+pd5xC9L4X6ZV4iw5U1fZFXcs1tT1v7UXwtWcwr?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbb3d8b-ed68-46ac-bc42-08dc53a17766
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 05:46:53.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXsOx7T8CAoETY5ek3bsB2y2m0cFKsrqXO2MKzhj7mfBXok47xwXF5KU9ofddh+5JWjuGbWh8iPfmCZrDCDlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044

On Tue, 02 Apr, 2024 19:18:42 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue,  2 Apr 2024 13:52:01 -0700 Rahul Rameshbabu wrote:
>> +/**
>> + * struct ethtool_ts_stats - HW timestamping statistics
>> + * @tx_stats: struct group for TX HW timestamping
>> + *	@pkts: Number of packets successfully timestamped by the hardware.
>> + *	@lost: Number of hardware timestamping requests where the timestamping
>> + *		information from the hardware never arrived for submission with
>> + *		the skb.
>> + *	@err: Number of arbitrary timestamp generation error events that the
>> + *		hardware encountered, exclusive of @lost statistics. Cases such
>> + *		as resource exhaustion, unavailability, firmware errors, and
>> + *		detected illogical timestamp values not submitted with the skb
>> + *		are inclusive to this counter.
>> + */
>> +struct ethtool_ts_stats {
>> +	struct_group(tx_stats,
>
> Doesn't seem like the group should be documented:
>
> include/linux/ethtool.h:503: warning: Excess struct member 'tx_stats' description in 'ethtool_ts_stats'

Was looking into why our internal verification did not catch this. We
run W=1 with clang, but looks like the warning does not get triggered
unless explicitly run with scripts/kernel-doc.

  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments

I have debugged using strace that the way the kernel doc checking works
when W=1 is set is that the matching source file that is being compiled
is passed to scripts/kernel-doc, so include files are missed from the
doc check. I think this is worth adding to the kernel documentation.

Anyway, I will send out a v2 with this fixed but wait for potentially
more feedback on v1.

--
Thanks,

Rahul Rameshbabu

