Return-Path: <linux-kernel+bounces-102973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35287B94F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8E31C21910
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9D062A12;
	Thu, 14 Mar 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1NtjYWBJ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE86281F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405080; cv=fail; b=PhGJt9Q0uOqvd/EScHFPONgZFCJBBR4xAvWtLU++A+nPCkqmzgYv0kHjOVZf+1jdU8kfFVKxHbHhw8nvpXBx14MFw7GmmJ1Bs56WjJhEGEVWvU4rwUYau4tT08SQpujvrzO8bHACkFQrl8yhDL0j+xQmvuVDg2ovbO5usb3YKFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405080; c=relaxed/simple;
	bh=7fSLgDFe2H0/MfjoXwhE/4MdmzfRqh66hOHewEMM+mg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FNPNt/OrtS5Xu3+TngHJclXPsIs9YElmBusbiEopwbw1dwwHoT9VOai8SQhUySfinYRxLroSYKNl4/ic/oooYoMX75aBs9ospbrAg5UzNDzYudqsl3W3BBkpGV5vpLUDclrsobDlORz5B5t9z45XiL0XKxGrTwaYxYmNf3oOLaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1NtjYWBJ; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9I31Cy0w2QnszmecYR8OJ2A+neXSvkFlMUQdhrRnyG8WgsO+5g8io84+QB1qZjgm7o1iOb9lv2HxtDYQDxz4NIdgw/bXnSQEozcAc738zVSDKj+HXdtTKBH1GS+dklNdnp1foSrxiSt70OcbKOf/mtbRhhDdz5jmA61Ft3eJBLfWK+m/pxMTjGjRgKoVFR7gtMj0adztfDNtkCPvtfUbtSJgBRHw9pUgCXFEvF74ONY5yO+L/NFUvWFQjd3lU3HvjANyVVC9z/Oql7oLODFGrugbbKnDSksfgBTNgZZswgRZRY8iS5GKge9bN5jluc1Z/BJVjQziRrUjH1HqhMQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JXhxc1Qd8IlCmhCWtSGsgygq7asU/Z+YbGeHkdPLjk=;
 b=WoOwgWOfclv0kYSc+W5JsXrz1zRMffNv/bOHWlhnt8GYyKa5/dYIg1UzJKOPZyMp5XSCu8DfGOZ8hl6qcJULvXq+64SbJVnTNWg2YZnzDAKamT1B6Z5wnTACJahPvp1joGRNxgpn9FS1sv7FVmZGzaMi4Cor6tDxfV+kLj+DoI0DjJBhEOzsLY608kJUoTDeTknv7Jweym0tV0GMAVN4wGvDiEcWC2zD5vR1N09z0NefzTWdfz4sPA9C0YrvbId4vQQK1xeqNZuBm1CUNT3SdtZWBd0+HiBpkKjwWy+3jSAaCsAy+XzIvEQC92Gd4cM7BCx9J6xouLlccYBKCvxEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JXhxc1Qd8IlCmhCWtSGsgygq7asU/Z+YbGeHkdPLjk=;
 b=1NtjYWBJ3vANNyduDST0QBzL24jjZvSm6Uqcz1+gacx2oRTUNGWAqhJcaFAYQbSJswyAQ2IYC6K8M6eYZKUsCCZ3L7UbDMmcgwn4lP8no4WK/wfjsjQprHgiNXQqbOAWAcPCGcL3BkMQl945d8p+z/6OUCLgOq9yja8Y6dKaLeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 08:31:15 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::9cff:98b9:1e88:d07d]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::9cff:98b9:1e88:d07d%6]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 08:31:15 +0000
Message-ID: <7035e229-569d-4cf5-acc3-6ea575e859b0@amd.com>
Date: Thu, 14 Mar 2024 14:01:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdx: Convert to platform remove callback returning void
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Puneet Gupta <puneet.gupta@amd.com>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <5d40f57e978bcce003133306712ec96439e93595.1709886922.git.u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <5d40f57e978bcce003133306712ec96439e93595.1709886922.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::16) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f0804a-6a0b-4332-4055-08dc44011ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d1m6ZAxyi+7jkh67z1eXYBxmjYyLlVtjYBXweD/w6q/wgRremtFsPbiSGBCFOselMQxTqjRRgbZz4L9/Pxg7+dT0zulQL2P/iPsadw3JWRV2RG1ZH+KfrsLe/jD0n/DnCQRyuzhCT6KV+a7VBArFimYbW6qC9s/uPmdOTOglrR9F7DPdF11A1SDFfRkHz7bsAsaAD+INmGMJSUeIbxnxAIRJKlRHk5MOWAxM5PTqtOOi9lL2a9BDCHvZw1cuLdjlsbpCQRoAJU9rYKvDFfArUmnnUNhaACqqpkcE8XkAwaa+R7XLQeF9Nm4CmQgUMMrw28sfuhlgBIzeIKSl5NV/94RjWhTENm8s4zO0k0cCG7pBdfpZ3Tfgs4ptEba+5aRlF1Xd52IcysQ4bZYsUVydOn5NkIA/M7ieJ9K4jDweicVBaeYJFa+Dsg7FRCDL52MOtfb0kiJLytGw0vcCSOIiDkeADqwa7Wx6IOaZW1UaYBHH0IS6TbESv11wCBhz0CscpoLU84UALdbFcRVLcHhMtprOYxX1T7/gC6u99+QiP61jTUKltIWp1Ix7afcPIAmQ7FyWseVfQH/uSA1sQzKaLmOPwCOFJGLREl9Och6525SRsuVRvut0y0JK6yjZJE+GxcDMEWffpUhFOT0dalcbFeL/4IEgU98DPeGfuPq94pE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmJHem9QQ3lXeUd3Q3QrWWMySU91YkhnSGhWWU1TRjBLcWdtT0dQbWtuN3pr?=
 =?utf-8?B?N1MzQ3RzV3ovOWloWURpcEhYNGxWUkRNNWltemdROG14WDMybFdLQjJuUnlq?=
 =?utf-8?B?dlptK0tDUWZ2NTlCeExteFJrN203bzYxL3VrUDZlSGN3eEVReFRNTnVleFZj?=
 =?utf-8?B?a0xkRi9HZDVIcitIVTVRZXpGeUw0RXNHUVY4S0tzTVVuSUc0ekIzYWZ6clF2?=
 =?utf-8?B?eEVrTWQxMVdBamZ6V0RocUxmdFExNThsdWs0dEk3aDBHT2ptM1VkMFFmaHdp?=
 =?utf-8?B?UGdjb2tUVDFmNHg3TzhGQ3Y2L0o3NDdYdTRsV3dvZjBHUTM3Z3NhSTc2Yndt?=
 =?utf-8?B?UXN3RU1HV01XbkVhMHlqeTYxMUFnT0d3VW1qSVVTYXgvSnFQV1BIbUVQN3FO?=
 =?utf-8?B?dk5BaXJsYVk0a1g3OG5xNXpoMjhWa0RsR3JudTR1aHJpRm1ranFoMFlScDho?=
 =?utf-8?B?RmVzUlg1NHl1bVd4L2xKR1RodWhkeVMxc21nK3V2Q0w0L2pmV0F5SWhHNDhV?=
 =?utf-8?B?dC9EdWNLc3pMenFWbTlGQnh3ZlJUVmJRKzdlY0xZUkdKdFNuNXEwTGtPcTFU?=
 =?utf-8?B?MG95SldSTEdpelBDNXl1bEtQbkU2a0hkRGJTY0QvbS9SLzhqUGpQTmh4dmda?=
 =?utf-8?B?TGpjWkpIN0kveVF1WC9JcXV4cnRsbnZnZXIyMGJVNXBnTHh2b2ZDb1pKWkdz?=
 =?utf-8?B?QmZBR3YwUTd1emtkMjVPM1l5V0JkQnM3eFhBa2lBcGlSN01WdnBydjN4SExO?=
 =?utf-8?B?U0JEMEpweXZYeklseUYwRnhISnFQWExoZmZveGxrSmdpdlA1aUdPZEkvYlRI?=
 =?utf-8?B?QXowUXhWc3Bvbm8rNlR4YnhhSVlHK0ZSdWZ5QnEzWmhpOGlOVzhlWTYyVnZH?=
 =?utf-8?B?QXc1S0lkOGVSVE43bHV1elF4TGtnY0lzNlNaZWQrZFduWHQrTDZpa3ZIemV6?=
 =?utf-8?B?eExudDBseUthaXUvNTlKZzl2SnFMZGtZdStpVFQ5NXhSWFo0VkVCS0k2M3hQ?=
 =?utf-8?B?ZHVnSnFQUEtaU2ZhN0VsRk9yL3Y1Y3ZZVk1hcDhmNnM5dzVPeHpLZWp3NlRS?=
 =?utf-8?B?SW9HNzFmUXVobG5VM1FQUXhtUWFmejgwb25yRStPT2F4bHRQT2NtV1pRK1pp?=
 =?utf-8?B?ck8yUGFsVHVManQxWW1aT1Rza0NGdG9oVlRCbzVpV2dKaDVoWlVSV0JoZUww?=
 =?utf-8?B?eEwzOVJMcjdLZzB3bkxHSERSZVNQVmZPRlZLdXJJTlkvLzNnRjI4NGdkaWQw?=
 =?utf-8?B?bFlWeHRPK0x2Y2s1M3hIVUE1bStTWjdkai95NW9WTCtQZWJjNmU0MWlZV0ht?=
 =?utf-8?B?VFVZYzJ5QnA1TlR5SUFkK3ErTmZWWU9VMVpBdWNRZkhrVWlVYjZidFBmS0ZF?=
 =?utf-8?B?YzMrdGtZYlVBdG1tMENFR3BHYkdMeUlHSk50ZXQxdTBjRWI1M0tORkgxeVR2?=
 =?utf-8?B?NHd4L1VPdlVlUTZYNHdGeWhTaytxb29vRlNWdksvQXhzTHp1WFQ3MWlGRURt?=
 =?utf-8?B?MGlpK29ucTBkMk8rcmdQa1NnWmVjSXk0aXkxYUpEbSs4S2EraGw4WGk5TWxy?=
 =?utf-8?B?NmZSanhYY2gvOGQ2bEVNL2JDcDhNS05aS1VIdXlzV00vbUdlMnZ3RkkwSmxm?=
 =?utf-8?B?aXFJZGp3ZE9scFFUcVVRQktGaWc5L3FKcHkwWjNrWVZxZ0J5ZUJlb1Rxc0Ri?=
 =?utf-8?B?cVp3K21CTjJrZk4yb3YrQ1g3Wjh1bE5FN3Z5YVo4Yld1eFJ4b0RBWS9yd3NG?=
 =?utf-8?B?d0liMUFXZk9hcmJkay93WENhRzd6SG5ISVBYclR1MHJHdEQ3dmtuQklZOUdX?=
 =?utf-8?B?VXY1OCtCK2p4UWp5OXpiNEppSWtqZW1OOTVIbDliZEo5T2lzN3FHT082aXpt?=
 =?utf-8?B?eWNIMyt1S1M0NDlOUWVEemV6LzNJdkhid0t1Vi9kc09MeUJUQ1g4ay9NR3Fs?=
 =?utf-8?B?bW9ZeXdGK1crN1d5Q2syY3dPb0VsOU1xTUkyZ1RQSDhyNTE4em9CcVhSSXVR?=
 =?utf-8?B?ejFjdDhCMUhzbFgyOGhkU0hKdWFNbTlBQmcva1YwZG9TUjhocUlLd1Rub3Vv?=
 =?utf-8?B?QTM1VUFZRkt2aWRkS0dkY0licTJCT3l0MzBMeStxbmgrMCszZE1KOHgwUkc0?=
 =?utf-8?Q?hhquoE4SdYO7iM33uUm1QVZMx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f0804a-6a0b-4332-4055-08dc44011ca9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 08:31:15.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyUJEclSm3KlpCLuoGpO9jRNb31Qy6ESpQUyBISZgU+CsBcwum3yYmuJ7gkE2XL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751


On 3/8/2024 2:21 PM, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Nipun Gupta <nipun.gupta@amd.com>


