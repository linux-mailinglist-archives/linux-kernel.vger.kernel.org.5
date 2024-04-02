Return-Path: <linux-kernel+bounces-128409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F7895A70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E171F21FD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3248159915;
	Tue,  2 Apr 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o6TKM3p1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAAF132C38;
	Tue,  2 Apr 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077870; cv=fail; b=O964OXvlhDdjvVUYS28yOZSvqcNGPlM8/tkHQ1J0yr/0tMuSy7TDjSwhsxBljpme75tYSJod79Kd3mTLGolTdNM74QOImjb4ZTlm9erHNmrF8BOcRK5RMt0PBSVtNk2TPPUz5U2MIXY918cfWt0gYXnnWLnHJORE9VGj0MdyfkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077870; c=relaxed/simple;
	bh=S5Ht0ngUjT+5A0BjJOKhcDBxvuNQNAvF/2H+vqvm+Zw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ty0PIHvHFiaQQtuFdPmT3nJsB2OFkX9IVwfhOEo5KLkTDUYgK9CBnV6mQQq8UKiqreOAp3cGLxGxTEhP3ZMSdQHX6Po06+vF+YdWV7eAa7BFz1U9E+/IRZ3fpgke6mRt4pu1er3BGaon9csuwpnaV9hXdMJqOggYX6Rb9jToaN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o6TKM3p1; arc=fail smtp.client-ip=40.107.94.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnwI42YM+mkNmdVDn5LNT6r1FzF6C2h5eAsYIcpqVtZ2F/1AK82CpN4trwBM5u9UIX7WM+0CO/a4jVzVtSP5opxHQnQ5JtgXU4RxcVb/6lxBHT31UuGD+WrxHJmsldpKo1XMdVXDXFbOHOYf9vvYPTaVKEXhiG/Px4KPtD6EgpEbQqpt//sF7X3FNBVTQHDG/zVHRVkdnJ1UtuxxymPTIiHmPW/hq23SRx3i5S2ewczmID7kK/4+uyxZnKdStrue3xXTZ7vqJoIzIoJYtq9U/n2coYCjLGsyBNwdmxhyr72hwpFusA7zZGdVDSo7XMTjE3CId1WHM4UiwxDI5lOkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSTm6iB1c0p4nn/l7mWKjVa0kFYGisoFyim5qoGslXk=;
 b=jsg+iW3DU5zKuiqksGkScwouCjlOM5SyHEZDAMkSkapVF/ozDU4OK9aixIKOpl27GC9PI8XeCu3eSEx3FMMGPk3yCGrg3rHSq7kSqAxm+0OQFlZx0gaX01RmwC7por3Dw9ysv1dWE/5ZJ1dBQWZYx1XNsEkkrRj2Gjjjnjr6EC4mY9ekTngRh+fU+DMGP9SaaJfP/3+cT5XuQSTAk0pJtINOiY87/HHgJlOmh8qn6VfiRby7wpcdwXydrMwvGEEIZv1ZQFWzb/4CDy7xwGr/8v2q/hcME8kDWzJkKA6mFKdbZ0krOBGb+DNihnTw33QHo9V+kGL1kU6y7I0hdQebEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSTm6iB1c0p4nn/l7mWKjVa0kFYGisoFyim5qoGslXk=;
 b=o6TKM3p1xUklwIDWXBIkySj45G6zj5IdBsmM7k9O5JlsyoRMZzjW808CNXQj9TWffInpDDXSwvh2YknHSrTVRD+DZt+4gkxezHCz7y0cXpKQhooBBhJ40D4VHJByevgDa3sr2nCA5qHU0H2F9GHSlIAFdzKbADK1VL5ls49V89g=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 17:11:06 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 17:11:05 +0000
Message-ID: <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
Date: Tue, 2 Apr 2024 12:11:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
To: bp@kernel.org, thomas.lendacky@amd.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, michael.roth@amd.com, x86@kernel.org
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
 <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
In-Reply-To: <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8)
 To SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|IA0PR12MB8207:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6s4v/18DEDvHuoQes4hDsYMS72O8OaYCIi4/pV/1zwUObl0PoQXX7xQvcnhB/MgrjW83VW/UEwQrj2Cbo2W10G8LXOILXIuLV5mWeZvdNbudLpsmT8/HXCDeTyjejRIaosOayk6tTxFdAN643Tg0cSIWa7kd1V6OoF320Xfeq+708DgMvDoUWFdyY67MHEfS5k60sBDQPiNmlCErNh1IofBMbbtZajAhaA1bsGGv5iT1YksvymGQJ/p6BFExIMKYn54QYGRf9PS7tBJgjkjHpO21Nc2KyqTdbAwfJl5cPIPuK5osBPSuYrlXs97mIYFfnS0AsLvysAkmk/Er7//9eep+q5vQwRPMIQdmJSTa9/gYyYHER9vQNgvzYqY6V9VvfIOfT1kft1G5gGD3T9TTCREZmmF1NREsrlHQe4RYjZis8Hk2greANlU/ERSKoxysSJ7RrLpmmws/TqtzyTR3iiMGJca6P94NJ/8k3q4EN1b0tHdC2pEXGnT1b91WvkqrxEX58DaVUZ6o2qMDDgSboyMySfpXFmCt/0UWDBnoQ8ZHUOUmI+moa0XTCATkNqtsudi584S2BjUWgb+JrBWWRuCzm+bns9gnKBCLfS79utA/fF3PstN3sUfJVyX1Eh9sEAGiZEt6dpzGsUKArEHianKbxbFwzpCdq1hRzRXWyYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGMwSXdLY0VaeXNsWDdiWUlSc3Aza09kRGluS1pjSjlkNGVMWjE0bFU3N0VS?=
 =?utf-8?B?ekpDaG01cjlOa3BEU2tia0tuRHhPbGpoSVdMVDkyMGZkWkh3Z082Q2xPRHVH?=
 =?utf-8?B?VVNTaDlRcWhxTFEyZnZXbm5zWjdaczA2RFpNK1lXOGt6T2NDN2xyZDdyOThw?=
 =?utf-8?B?K2hkR3RqazltdmdEbXJGbEFTUk1qOEM1MGZuUkhqckFUaXdkaWwrNk4xWXlW?=
 =?utf-8?B?T1gzUzVuanhNMWdxSWhxb2hhZjRzMzJDWFF4ZkpsdEMrY0dsaWdSQlJKTHZK?=
 =?utf-8?B?V2FOT3AvY1ZoTVE3eXM5OXRCbExLNGxmdlA3dmtpRUpQcnlnUkZYeHd4RUNi?=
 =?utf-8?B?YlZ3N29RaXBVd1U2ZHdFM1ltR2xCejIwWkdYU2Vxb3piM3AxaVN5LzZhR3lr?=
 =?utf-8?B?TFdHeWxQcm1TdVl4SFRCZGVHcFpicnVPY1hQTUNHdWRKSS90K3Y2Sk93dlVm?=
 =?utf-8?B?WU1wVU54ZVRMQVZQaVpYYkt4MlZ6VmkranJFclpvTHlaeWhTODNUZk05aG5B?=
 =?utf-8?B?RXh6YmpLVUk4TERKL2cvSFdQTENXWXlRcUwyRjE3YVJjeXU5QTNrdzJmbjht?=
 =?utf-8?B?M3U5N1l0VERyQ2VvN1VhZkpEakdPeXdSRFM1a0JYamFpL3ZsRXVhZjV3Q013?=
 =?utf-8?B?a2dFb2lyc2VpT0ZCYkdVQi9CcFk0ZThwVEV0aEROSW5RVUY2a0NxdUM0WHBU?=
 =?utf-8?B?LzBSdkYxWmphcFdRa09oQXBWdjFSNnIrMTF0TmFOclJ2N0xqSE1od2h5ZnFS?=
 =?utf-8?B?V2dnZnRYRWhSUmZoVDBtOExwVVM5VmI4ejRjNk1IRlhOVWVnQTIwU21wZE5L?=
 =?utf-8?B?Z0ZiTkV2WnNPYUQxcjNFbGJoaHNmM0lGRkU3Q2xMWkRsN1lhL0N1NEFFN2t4?=
 =?utf-8?B?Vi9TVTFPS1JJeFlpL1RYVXlSdHNpWTZoNnI2Y1NZNExTRFNjcS9BZnZlRlNh?=
 =?utf-8?B?Y0JzQ015OExrbzZJSHhKYUdzZjFjMm9FbUh1SGx6Qnp4SUx6NmNsSWpTYzFh?=
 =?utf-8?B?cWZFK3gvYit3REV0dy96d1N2QXpCai9ZK1dacUFMRG1nMVgySDB5VVF4WWxm?=
 =?utf-8?B?TDVpOXpueW41YzMzQWQzZkluaHp5dGowMFFHOVVhMW9nMk85K2tMK3FjNEl4?=
 =?utf-8?B?cmp5ZTFuSnhqeGtMdCtQYkNhbngxR2ozOW5HQ0k1azdrU3BxYXppY0FkZzBZ?=
 =?utf-8?B?OGtPdGl1TFhZQTUyWW02SkhMSTZQYUlLYjAwVHZaNWRpQmdYQWdVNXowY3l4?=
 =?utf-8?B?L2w3OXVmb3c5KzQ2NHZWZFZ1QzdvRS9sd1JDMjA5NXpOczZ3Tk5vNkRxdkta?=
 =?utf-8?B?S3I4REJQQVYvSCs5MkRpR0tUMFhvaXk2S0M1Q3IwOTZWVzQ3UlBGM2JwVFUx?=
 =?utf-8?B?bjJnZlBLTUM5VmZKNUg4YVB5eFBxcEYvdnpmWkN0ZmJtNE9KczFkSWhGVWtH?=
 =?utf-8?B?RGJqcmE3b1dyWjExN09CQlovcG9ZMjNub1FPK291U2lNYmdTTFlaekxlMnF2?=
 =?utf-8?B?N21xWVU0TWppSWNXamVrbkdPeWFldzlsY1Z3dnRwSCtDcWNnb0g3OUo0QlZn?=
 =?utf-8?B?UEY3anp1RFN2WG5oUzlGaDRneThvbE03b0NyZGtmOEJENVR6WDZkYnc0Z2xh?=
 =?utf-8?B?QlB1RVFSUzBFY3JzQ0pDay80TFhxMzZUbVB0b3ExakV6S0pKd3RKS0tWdUh3?=
 =?utf-8?B?eGlhTmRySFhvRFRZN1krMDZHbTZHT2I3TU9UZnJ1V0p0NkFBYWJrNUh6b2g0?=
 =?utf-8?B?OVJjZjltRlN6TlY5M2tQakk2d0ZaeEsvV1I0RWJUSXd5eGNYTk11L3VKbExZ?=
 =?utf-8?B?TTdRbHVuZVlLT2VOZEVSd2pBQXVhc2ltUmNnR1VWQk1VdmYxWG4xM25SN2Nu?=
 =?utf-8?B?TURTN3FpY3VtQzRZY0FsbmJFQXZoaWF3QW82VXJ0MGVvc1RzOEVvaThwZ2di?=
 =?utf-8?B?bTdzTlhUd1N0Q0J1bnJVMXd3bzRNVVlzOTEyQTcvdGV3Ky9FdUxaMUNLOENH?=
 =?utf-8?B?clVheWwzV0Z3K3RIbzYwMTRxVEtES2FhbEczc1BBMG83K3lwbitYbElyY3A0?=
 =?utf-8?B?TVpybW1PYlJ6KytGZUhIL2tIcVdPaEhPTm5lMEpKV2hOUFFWSE80T1RmR3F2?=
 =?utf-8?Q?dCAU7CgZE8UbebkYvMlNH8cZl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd7a7a0-df9c-43a0-ceb7-08dc5337e1e0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 17:11:05.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZWBZjZ+mBofhtMkhDXcIOrHwgiYShGUqOq9jzw1iocYz0tx561uw2ETO5DNKg2Say+dmuAYH0Fc4aN9UvZLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207


On 4/2/2024 12:06 PM, Kalra, Ashish wrote:
> On 4/2/2024 11:34 AM, bp@kernel.org wrote:
>
>> From: Borislav Petkov <bp@alien8.de>
>>
>> On Tue, Apr 02, 2024 at 10:54:50AM -0500, Tom Lendacky wrote:
>>> There's no requirement from a hardware/RMP usage perspective that 
>>> requires a
>>> 2MB alignment, so BIOS is not doing anything wrong. The problem occurs
>>> because kexec is initially using 2MB mappings that overlap the start 
>>> and/or
>>> end of the RMP which then results in an RMP fault when memory within 
>>> one of
>>> those 2MB mappings, that is not part of the RMP, is referenced.
>> Then this explanation is misleading. And that whole bla about alignment
>> is nonsense either.
>>
>>> Additionally, we have BIOSes out there since Milan that don't do 
>>> this 2MB
>>> alignment. And do you really trust that BIOS will do this properly 
>>> all the
>>> time?
>> I don't trust the BIOS to do anything properly.
>>
>> So why isn't the fix for this simply to reserve the space for the RMP
>> table to start at 2M page - even if it doesn't - and to cover the last
>> chunk *also* with a 2M page and be done with it?
>
> But, it is the BIOS which reserves the space for the RMP table.
>
> And if you mean the reservation in the kernel page tables (directmap) 
> then that will not help as kexec uses it's own identity mapped page 
> tables.
>
>>
>> Not this silly overriding dance.
>
> This overriding dance is required to fixup all the three kexec tables, 
> as there is no interface/API available to do modifications/fixups in 
> all the three possible kexec tables.
>
I meant the three e820 tables out of which two are used for kexec, the 
e820_table_firmware and e820_table_kexec.

Thanks, Ashish

>
>> Thx.
>>

