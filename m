Return-Path: <linux-kernel+bounces-145387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6858A5592
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048DBB233F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F871B3B;
	Mon, 15 Apr 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="goO8I6Ca"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19B2119;
	Mon, 15 Apr 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192598; cv=fail; b=A21ZtxxgC9m0OtnNxULeiv951A4UyGPl0tnzkbYZP+GEgves7D8+cUvHj8mIfTrVPBt3JKUy2lc0Tjmbwwgxm1+u7t0xQZdPbkaL6SSatq8i4755MXP5v74PsmMRwKqxe2Elei+d0SccjrgQrOrPhqSEfc0eiM6QYCR1fIGuvls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192598; c=relaxed/simple;
	bh=NdwYop5QqFqtNxwBVYFy4geeZtoLquVe4ZeNsTfa2q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OhqlM+D0ytJn+DIush07RYEg2jnU9Yia6TmYCtapILqwvkTRiDXu1ScES3JyZZ5y+wxefJkjLHWfBY8gzzCqLuRC93pnDHPU/JN30O9spdfzOD1Neq4rEOHbig0H+pihwqUGFuGot5IN4Z9Qr80FjXAvhFQbzPQtWudHrOtv+oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=goO8I6Ca; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9JOYJ34+82SE6R0IqqkwCRGoCxvhYn6vjpSJsmJDmctfTo61ENu692ymmxHVfEdeNnCcLteH1L4QJXd075TYZi9AgoSOuOmo1A/5VUsTfQsmkcq1tstTEU5i+Zo+41Za+7CCvEIsji+25Q4S4WYrW3diiU19L9Et3+P7IK4D+xd8MSATqaDFHlU1x31tx6tr6tUgYNdOmx9Nd38siEWC528XFiCk7jQZhkzfncZhLomp1S08sohEx+iUeaBzOfZvtMyobBO5TVK4g6MLllE594VJ9qYrmT/rRiREozFTvHQVFjyoBT9LSsSlDcE7ffXlNluPb0sKxc1wcp0XfHGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAKGhtLz/IZS3lAsyAT1i0IfU6fHdJFz0LpgoQm1il4=;
 b=XNkYxhDa+vEuL6G0xoabef+mdiRploFlfh0y7GxPMYYVx185BccEXKtfF3dLBl2zQ/avnFUO3KvuH2nwt9g9LpG4UG6rla0t9I0GyfCuSZTA1LIPGRL7fyMELQvDxLMbPjER/4J73NhFZYLGY6hFzcNzYlFHDeiHZ/2LVd6G7XOlaxECr5NSN7QiHWQXUV0IhmbkM14sQjxqQkFwz9rHh3gd7nSOUFwMGqR6+5o3qrYUOJQgWhy+IR6oKzqpzUe3jEhRcwxUMzmLbPQccgJsH8zkw6mdj9Z8ODPsn+gM6AShxs7sbC70x8jMqb2P+rcxsHtZuX4Jh8/Qx3WOia7Oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAKGhtLz/IZS3lAsyAT1i0IfU6fHdJFz0LpgoQm1il4=;
 b=goO8I6CajsB/3bHZnyPTypT+NBwQ69XORFEo0HZsdK+xg5DKMIMAext2lpw6Yx7V4TLMgXGnXLbggw132+tgLlFWKA+s4AMVaNhqa7tGg0Hs4aCcvz6hgEEtzzRNGCZE98h11WnmH32fw8m7vWSJDjFJ9zeLfwS/tcplRe8N+IQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV1PR02MB10909.eurprd02.prod.outlook.com (2603:10a6:150:16c::9)
 by AS8PR02MB9020.eurprd02.prod.outlook.com (2603:10a6:20b:5ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:49:48 +0000
Received: from GV1PR02MB10909.eurprd02.prod.outlook.com
 ([fe80::42d7:280:d9dc:e5be]) by GV1PR02MB10909.eurprd02.prod.outlook.com
 ([fe80::42d7:280:d9dc:e5be%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:49:48 +0000
Message-ID: <7e6eb387-5a0e-460c-af08-eff070fa35ca@axis.com>
Date: Mon, 15 Apr 2024 16:49:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Add sdev attribute to lower link speed in runtime
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>,
 Gustav Ekelund <gustav.ekelund@axis.com>, cassel@kernel.org, hare@suse.de,
 martin.petersen@oracle.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240412134838.788502-1-gustav.ekelund@axis.com>
 <4e5c88f1-1b24-4f6d-8c11-d7029329ba7a@kernel.org>
From: Gustav Ekelund <gustaek@axis.com>
In-Reply-To: <4e5c88f1-1b24-4f6d-8c11-d7029329ba7a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0021.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::26) To GV1PR02MB10909.eurprd02.prod.outlook.com
 (2603:10a6:150:16c::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR02MB10909:EE_|AS8PR02MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a03d7e-caa6-43c9-23ef-08dc5d5b4c03
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UVVvQRQNBagoc287kH0jj9FgK4XJfP6l/TKkPjzL68onuWnxJuz3DdvTeIxHWv6Fb8k1eb7YHOjkGDEOuWvMdJYZHaLPrpU5A7DYV0Id2KONwnrqkfKRRi+OAdre/z72n3F07PIj8v793sEa5i+yECGAmTD4Bm+qncwcf3RXKvQ/Acf5cKLdUDT2Lsn7V9ZgJjjPtJt1yrVmrSCLPT8knMR2tAgX5wzGKMMz4+R4y68Rto+fiFfe6MIqPm6B2gG8+I9FeYABWn6g0uV/oBhsGoKQG+cm/ndCH1vo5VLOOK81w25U6ESZHyXTPK4m9eUqIw5q9pqjnDsDDQip3bbT+7c9i5I6PsenuFzqmjtH9KGSh8TL+va63DtfUOmQ6BTcpuKbgqjZ4lOwqznE5dmCV0jMVMxzkxiw+Pl+iU+/x9lqycxAvb5ExUcnHXBG/rIa8swV2PbRMCCmm5QPt9B9AeDYJQDrGLhEPWwR9oP/btRVPPWGIO7Mm6rAk52A+TDIH4keU1KIiRmItAD0lFHrcqWkP6IY0WGeQGdanbLCK75C+EGEvd0wCSk3JfPMA1IHe38rBrq1ny2FHiSJaSDLrBdTAKojXTacykF/1mKa5p9i7lvz4JkwWy/UrJPO2ejuSYqnh0AJ9XMlnhM/Pnj6OMkTxs3kGVF5LHYP/Kkvkco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR02MB10909.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny9rOXhHNFhWd2Y4U0tjTUVCcmhiYlpUazF3d1Z4UncwZDJkRStncHIzMUx5?=
 =?utf-8?B?OXhvRmlRSDBhSTYwTHFpNXNwQXVxbmg4T1VyYkxIMU5QT1E3aGNCR04rL1R1?=
 =?utf-8?B?VWxUM2FWeEo5L2RrUjlVTGF5a0E0QnhpUUFyS3lLZUJRb0JybklydXBLbmlH?=
 =?utf-8?B?RUcybFRNbTY4cS9TbU1hak1EZGVTSVlyd0wvRG9nVFBwVEJHbklPUzBBV2RW?=
 =?utf-8?B?ZE91Q0h3VURSbVV3TGh0U1lPVW02MW5ENU5yWUM1L1dGSkRVeWtEUUxBRXM1?=
 =?utf-8?B?TGtrbk5YWVBiSFBjZFA4NFdtRTVzY3FuaG4xeENyb2I4V3dEZFFpMmNDVUdC?=
 =?utf-8?B?aThvNTgzYXIyZXF5TlZPL0hBdFUvYjB4RnJDMUc4MkppTGZDbytxS0ZXTUxu?=
 =?utf-8?B?RzFUaVlsMzJObmZHdEkzbzgrMkpqTER1Y3pVbC9mVjU1TkgwVXh0RzdBV3Fi?=
 =?utf-8?B?eER5Y1hpenlCTWg2RkdBeVB1Zk9FbkxYRHBQT3pyNWU0S2dvSjAwcGp3WVFV?=
 =?utf-8?B?VzV3aERPdS9qL1RlY1RMdlVnckg2Nk44a1hsT2QrUjZQNUlYRVRsczhyQWNL?=
 =?utf-8?B?Y2huNVN0Z3cvM3NJVlZ6cXc4Rlp3TXpHZGJVanE5YnVQa2ZpRnVFbFdNSkFp?=
 =?utf-8?B?dGdhemZ4TVppQUpiUXRkbTlhVng3OWRUL0xWZTAzQkE1eWlGQTNXSmo0MXJn?=
 =?utf-8?B?cU4veDJLTkRsT1NvL1ZNa3cxNDF4MDNZdzMvSFltUlFvb2VnWjhuQUhPWlI5?=
 =?utf-8?B?NHR4ZGJBUkpoUkpMeDJ6RU5Fa2V1UUloYUVSNTlEU2JvN1RoSzZiQUIrbXJ4?=
 =?utf-8?B?SWVUa2tHZ0U5MHVacm9IS0R5cVpURHp0M1VZNHVYMUNmL3Q2OXlUMmlzVkZS?=
 =?utf-8?B?Ynk0TysyNEhGWGo1V05PWktRT1laTWp0MVB5YVNWQkl6OWlTUGdsQmNOM3pS?=
 =?utf-8?B?b1E0U0VVR1YvRTJrM2o5R2RBRWxENmJ2RWozWFVIMzRLOWhzMG5rZzVoKzBO?=
 =?utf-8?B?UkJ3NUFldGVaeERXQ2hCaDBNOVhyZThCbUpKeWZhUHp1RnlyL0NaUzVjMW12?=
 =?utf-8?B?Q1Y3d2lSeTBrQjJ0MTc3VFJQVXp0MTIrdXFsYnFXcmJBNFVxTWdXWFRuV0dG?=
 =?utf-8?B?WnlKcEF3VFM5WVZlcW1oZ2RUSC9qenF5WDNLZENQcVllOWZOZWs2VkNYblht?=
 =?utf-8?B?UGE4MHVPa2s2a0pBUzZqdjBlMDJrMmdnL3JSKzhBN1ROUjg4UWRYdlhFdzYx?=
 =?utf-8?B?clJlNVZIcitzY2ZRL25sR09GbEkweFJzdURUQ241YmtjY1JnUXpZdFlrdDZF?=
 =?utf-8?B?TnZBZnZTK0JTTDVaSUFWZkthd3FZckFsbnd2bEowMWozTGRla0FNTVJzZkVQ?=
 =?utf-8?B?ZDgvdTFsSWlSTjdZTFV4NWZkTU00T0UwdFBHMyt6OXE4SmhSZUx4TVB4UTRB?=
 =?utf-8?B?eVZsZ01jTndPand4Vkl1VVhyTlJvOWFDeG5Ra3IvVTk5YS9nc1FicHhLVjgx?=
 =?utf-8?B?NzY1eEFkZ0xiY25WOEFHdnpwTm5yL2JQUzNlMkE0NnZSckMxSVh3UmNFa0hM?=
 =?utf-8?B?MVN0YjFKZDhtUGlyZUE4RkZad2dPYm5kR0crVzVwWVZJcndoRWVuQ0VPaHdk?=
 =?utf-8?B?bC9iV2hSQndaZDg1WFZXSzNzcDNEZ1VxMkgrV0kxNHFibjAzNWN1RnpSYUZk?=
 =?utf-8?B?eWlkbVN3RG43NVBRazBaVkplN3FaWHlYMlNaY0wxK3FMTjZkR0JFSDlnNmVK?=
 =?utf-8?B?eTVRKzZFUkU4blVIUmdna2hLZlNIOEMrcDE1WDN6dWd0ZHR4REZDcjQxTnNK?=
 =?utf-8?B?OGJuUXZQTTExc2Y3b2UycHl5WTFXOHRwV0tDalNwOWtEWlNyVUpBMEx3WUs0?=
 =?utf-8?B?cytURk9wcHMzRHUxY0FxSk1nbE1FVVl2TGkxanp4Y3Urb3R2b01ZRzdMUlpZ?=
 =?utf-8?B?b1FESUlnKzVXQmZMN1YzSG5nTGxQOVJiRGl0MmhGZDZaSzBFV1BoYUxwR01H?=
 =?utf-8?B?MGJzQ1l2TzBTQlNpMU5teDhEQlBvR21ITGtZMUViaW95bmwvR0tjNzZyTkdy?=
 =?utf-8?B?RzNCWWdwVks4YnhpNGh2WHkzRlFJbjhPVDJIUlRwSGlqR0UrK1JKSUtxV3lt?=
 =?utf-8?Q?nfrQ=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a03d7e-caa6-43c9-23ef-08dc5d5b4c03
X-MS-Exchange-CrossTenant-AuthSource: GV1PR02MB10909.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:49:48.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpwvP8eiODH2FwEz2BkizWUCfNREciO25qZbl7aPHtXzN8OTZYCQpFNS8kHJD9yIOPUT3HllLgt0zYgs/XLMEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9020

On 4/13/24 02:29, Damien Le Moal wrote:
> On 4/12/24 22:48, Gustav Ekelund wrote:
>> Expose a new sysfs attribute to userspace that gives root the ability to
>> lower the link speed in a scsi_device at runtime. The handle enables
>> programs to, based on external circumstances that may be unbeknownst to
>> the kernel, determine if a link should slow down to perhaps achieve a
>> stabler signal. External circumstances could include the mission time
>> of the connected hardware or observations to temperature trends.
> 
> may, perhaps, could... This does not sound very deterministic. Do you have an
> actual practical use case where this patch is useful and solve a real problem ?
> 
> Strictly speaking, if you are seeing link stability issues due to temperature or
> other environmental factors (humidity, altitude), then either you are operating
> your hardware (board and/or HDD) outside of their environmental specifications,
> or you have some serious hardware issues (which can be a simple as a bad SATA
> cable or an inappropriate power supply). In both cases, I do not think that this
> patch will be of any help.
> 
> Furthermore, libata already lowers a link speed automatically at runtime if it
> sees too many NCQ errors. Isn't that enough ? And we also have the horkage flags
> to force a maximum link speed for a device/adapter, which can also be specified
> as a libata module argument (libata.force).
> 
>> Writing 1 to /sys/block/*/device/down_link_spd signals the kernel to
>> first lower the link speed one step with sata_down_spd_limit and then
>> finish off with sata_link_hardreset.
> 
> We already have "/sys/class/ata_link/*/hw_sata_spd_limit", which is read-only
> for now. So if you can really justify this manual link speed tuning for an
> actual use case (not a hypothetical one), then the way to go would be to make
> that attribute RW and implement its store() method to lower the link speed at
> runtime.
> 
> And by the way, looking at what that attribute says, I always get:
> <unknown>
> 
> So it looks like there is an issue with it that went unnoticed (because no one
> is using it...). This needs some fixing.
> 
Hello Damien and Niklas,

Thank you for the feedback.

I have a hotplug system, where the links behave differently depending
on the disk model connected. For some models the kernel emits a lot of
bus errors, but mostly not enough errors for it to automatically lower
the link speed, except during high workloads. I have not observed any
data-loss regarding the errors, but the excessive logging becomes a problem.

So I want to adapt the link, depending on the connected model, in a
running system because I know that some particular models in this case
will operate better in SATA2 in this system.

Can I use the libata.force module to make changes to a particular link
in runtime?

Best regards
Gustav

