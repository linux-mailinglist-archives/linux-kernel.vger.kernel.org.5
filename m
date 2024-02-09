Return-Path: <linux-kernel+bounces-59916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D684FD4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F961C215B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980485C65;
	Fri,  9 Feb 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wkt+S9sT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C985299;
	Fri,  9 Feb 2024 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508985; cv=fail; b=PAmmwloQKoBz3T+kXOPfgrX1ZUOHFbbKFaxFs8vgaH8gGtdklquW//072KKCBNUip2rRU9GDqqwS0/d5x2lUSEvNJ4fEqcijJj468qT236B4TmaaLLnHkbGME5AgkDj+RNu+DdDsZ5AqBDy8CYUh1jkSakiBgUNInGsfZn6PS4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508985; c=relaxed/simple;
	bh=hicL5xHZkgZAGV1CWTfx2GYQktrz2iKrZKXs8UZVAEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dOM4WH1TP123vrZk3tSSqz1conU4BBUpP42mhObUTM01nPMMckRXxcjuVMpqUROX3KUhs19Ts3r7wXIK3fABOJKwocNC20oY1SOGUPjOdNQ/rrVVRIRLOfjWdZzKWSXv+F8mzY+OM7rRuafGLRX7+x0AN55JrbiX9m6wF7hM6RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wkt+S9sT; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgFtlsZZYhSaxXiTu3/BUg2GFdl/+yUVPle3Ra409gq/1CPzEJ5GBDTxSEqiDANxIfHxRDbmP5/ecXjQxAOucwhK5ceJqHnCu96XnmJ6URs6bS5rurwU8HNfg9p/nXHMA0UXiPBSPQm3yr50v0H8S4GRKl8RGRQAS074Q9SRC5+Dm0wdbKOuP95FNr86bNNHwH+WMKFf9EtRYPI8yIIvQgMehtMnaln97Tw9SmJ6EwySOglAX9zmb9QnfK+zcisQj0FtksZeYvDGywswUGiH9cq0hOZuDw+Thn88QI0XUO1aS9rlF9aew7c4Xlj7n9KIUcTAZSZOJzrtacMOkokR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGnkEpcCMtPYbWrkBTcP2Jng/YyBXBjufBRRUZAkJ20=;
 b=NZTLc262iFMz/MR/sRRiu8jEmRkjNBc94d18Qq93Tbr9sf8JrIDqJcc4zJviZV7GEE0sfF1Lb2qy8kKxJF801kvd/w2AuyNWzVlPIDRsGE0EhdHEA5utClE9r+1pjFa+3EqHvtZDn3m0DXuPNTP5Tw5A8uuuARf0Nfyva6LfRfkCuSIzRorFPOYM3A1Tohvk3ipgMeiK0EmS4D9s7+ndcWrGcACOReztT9Cn5dhYMqcYOhVJPFmWgGvm5jxibT4CvbACtpbC5ae4O+3MVWF/f1IDvoeNtE9XvOhZBnmYTsBhIl5U2j+IbBUvn+rxk9Tdbar4XO5EpoMGYPHzERSfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGnkEpcCMtPYbWrkBTcP2Jng/YyBXBjufBRRUZAkJ20=;
 b=wkt+S9sTvPtHimr8hJN2m+cZGt2MICM1dKUnzjGEiz8bva6mlt8DARBov/dMZxeTxzlkfarIqHLWGX3lxk/sSicanA2XClYEar14xEpQmoBbMehkhjvAWzt8UtQy7OoUl2v5YMXQoNI5HEUbKo6uOJ8jMCYmLTYelJhi5BUzP9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Fri, 9 Feb
 2024 20:02:52 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7270.016; Fri, 9 Feb 2024
 20:02:52 +0000
Message-ID: <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
Date: Fri, 9 Feb 2024 14:02:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Content-Language: en-US
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-edac@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::7) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8196e207-bed7-41ef-a68f-08dc29aa18e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ORddpt+olnU23irbp+VYaMqj6Zdz/lsR06mFA37FM9N15tRMM2ng7n2gSpi+HPI1uIzErIDlg5WkeSikVXW7Wghm7wX+KBAnl6MLcLAsnv3zeIpqIjGeqqir6W5tJlxChAJkBrHHlCQf9Fvk7z7hHquxwPHoROo7ruvDgNyZ+aRGhmb1h8wMSy2l/wm7nVnpKBfAnr5kbKZpyvIKOaLB2t/6mNlHfvhBoUCKdOSuwRx8Ud5LJ7CgG2INYJiUPxwqpV7/LIWLm5GUf+nBLVFCdGLKh9mgLNNz9vprY5h7LqkcL5GPWbn4YTvKgl8YGcVwqksojL8YtLatxUMxSTWo63iSyzalupoIT99c4v7lQon2jvS7llsRQ5yeXrceanLKYkeGDefBBnDibrSABJrrUeIf2RCQyP3mdxEjgIa6iUz7abO8Ua1Rn6a2piNKd8TzKxa1FZAqv+1ITaz7gRUCfMndzDeM5CXEW9RERKI6ROvRaQ+i0JBHR/gHbsPYwpdGd7L782A5dHRhBoLxi4LgwwV0ZRRiWWpQtCt6oH26AGezOuw22eRZMs49itOwLNqw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(316002)(41300700001)(2906002)(2616005)(26005)(38100700002)(31696002)(36756003)(83380400001)(66946007)(66556008)(66476007)(8936002)(4326008)(6506007)(6512007)(478600001)(6486002)(8676002)(53546011)(6666004)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEtEYUVaK1dzc0ZITG9VVW5tU0N5eGh4WFJPcGpWT3JRSnlVNk9ZaEQ3ekN0?=
 =?utf-8?B?VnUzM2h6QzM3bmRWU1AxOXVaa3ZuODF6K2FRVkh4S1Rhb21oNEsyWUZlU2lH?=
 =?utf-8?B?RDZDalh6dTYybXIvanp1ZFlNZVIwUlhnby82a0t6QUZMYW5wa2YxTEVGQ2Fw?=
 =?utf-8?B?aDRyN0ZRMmZjMElOVGJBZnN5YkpjOGxSeXRaLzJXQ3NhS1pIR3Y2Y2txdUZF?=
 =?utf-8?B?VXB3TWVMQk56L1Bmay8rOTJRVVpjMktieEVHRktITDY5OEZzZE1MRG9laG5P?=
 =?utf-8?B?YkFPYjV5Uld1bzRTYUhuaUNvaGNmODFwNFBUbEdMbDlCUmRhMW95RFd4cm9F?=
 =?utf-8?B?NVlJbXkxTG1SaVcyUW5XSWF5NE5sTVBHMzk1d0Q1VmJ4c3VwYjBXUHVBNUV5?=
 =?utf-8?B?dTlmeEM1UEVlc2VSNnphMVRHclVHVE9xNi9nSTJUejhxbHdlRUxTaXNSNklx?=
 =?utf-8?B?aE9rS2Zoc3I4MGVXZXp4UjduZFBqNUFVcUZLNlc1OTZkU0hmTHYveFRZbEFt?=
 =?utf-8?B?TDV0TWxTeHM5NEJVR1FJNTNlaGkvL1hqZ3V3Y2F3NEcxRHhQR0JwcTRyRGFq?=
 =?utf-8?B?T0U1SVhQSEVsQ1NRTnowNE5LQUZYNWwxc2pxTVNhM3hIREgvZUZLaFJ0MDhN?=
 =?utf-8?B?cEhQMmVBdzRjb08reUJmcEp5NG56OGxlK2FyNjhEa25nUm1yTzhtTFJuamgx?=
 =?utf-8?B?djY5VG9kM1Fnck1OUnRIK1F0VUlvdWtpTCtvbjQvV2d4cEZzMlVoQnVHekl5?=
 =?utf-8?B?VE9ETUZIYlVyYW50TTB2MS85N04wbUo1eTlIQTZPS3diMXpBaTIzZEt0TERu?=
 =?utf-8?B?ZlF5WVE4OGVmZzlpR092a28za1lNblExbHRJbUZWUkYyYnZwOGludjF0RWMr?=
 =?utf-8?B?eHJucmVtdi9CcDNlSk9PK1R3SnZSN1ZCakhKUldyZVpIV1A3c1Ztc1pCUG54?=
 =?utf-8?B?YUJPZjArMzYzSWlzNTB0eVdQM296UkNsQ0JUaFVIbEJsNmVPY0NtVC9velh0?=
 =?utf-8?B?KzhzR1l0MFlwdXFEQzNhWFNiaVQ4cVZaRENYQnNJTVlZMzRHOFNtMHJKemlk?=
 =?utf-8?B?M1V2UlFYcTl5WXRpcENnaUJWR1J1QzJNalFYUnJhREpZLy9DYmFqSnJOd1U2?=
 =?utf-8?B?ZVJRRVZsd0orK0hoVmZSM2ZjU2ZYeDRnelR1WWZCcE96bHRnRmFVeXIya2pn?=
 =?utf-8?B?TnB3bUVyekY1dmpXdTVhWFF2Y3p0NEUwcVNpUWVibWROdCsrU253VkZTTGJI?=
 =?utf-8?B?Q1JhbExHMDZXWHdVSHBpMWJubHo1dVlEbDAwZ2pPNkhPL1JiQWtuMEJVQTJh?=
 =?utf-8?B?ZnVydXh1OFVRWmcxVFZiZ1dhS09Qb0xVZ3JSdXNBbDhwVlNpYXVEemFwQWJR?=
 =?utf-8?B?WWdtSkF2V0RSKytqNFp4VFpRZjFaUjF4eE1TcXI4RkgwbXFKa0J6aE5PblFO?=
 =?utf-8?B?WUhoRkdaY05tbkF6SzYrWHdSc2UxZEF5bC8vV2JBbGRENm1yRTlGU2hMWkty?=
 =?utf-8?B?RkdESmp2cVk5bW4vSUYxNTdtVHNUZlg5ZjBjelpNTXNlWkh2RUs0aDBoYmJx?=
 =?utf-8?B?VDlRYnRVdEkwUWd4bGZydnorWlJYVThtREZXdEJPazRkN2VvdElHalF3dXRj?=
 =?utf-8?B?WENnd3JoUWRIQldZVWtna3Fwd1ZRKzdlZjI0SGZ5SHUvR3I5YjFkcVBNU0ds?=
 =?utf-8?B?Z1QrWkEyaDNybUxrTU54ZnZyZkNka0NkTkhZeVhQcmViZ2NkWlZVa3h0aHNu?=
 =?utf-8?B?NW4wZ3liY1NTclZpeHlqZnhrU213Y2hsVjNJbjFuVm82NnF5ZGd3dmVpaDVI?=
 =?utf-8?B?MkRMUmtkaXlXbTJnS1dFVHROS3htQVZubkh1Y0JXaVVISFU5bTJOOUsxYnYz?=
 =?utf-8?B?ZHB3UVhlMlUrTXR0Qk1QTk5MNUM2L1Rib25Jalp0OHRFTHArT3pSeDJpazJy?=
 =?utf-8?B?d0R1cVhCL2VOUEdTZHo3RnRyNE5OcXpOSXdSQVVGcnVEMzVpcytSajd2OVJV?=
 =?utf-8?B?VmZvUUVLSjNDS0d0VVQ5TnpZOWRVMEI0WjBPNzNQQVVJdFJodEpnWC9rQXdi?=
 =?utf-8?B?U3AvaDg0NWlyMDB6UkFudXlhQlZ6MVBoa3oxL3BzOE1JMmpqWXZzaEFQYSs3?=
 =?utf-8?Q?PPF3B6/0sjy+QtsCiEBj+Fbra?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8196e207-bed7-41ef-a68f-08dc29aa18e8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 20:02:52.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe+EllZzVfspl7hIR3un+W8XQz7hDgAB3Ok4ngDJ1rfb0acjhfrIBFJkEan6jCx1Qg4S7aDAF2ggI/O5yBvAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

Hi,

On 2/8/2024 19:36, Sohil Mehta wrote:
> On 2/7/2024 2:56 PM, Avadhut Naik wrote:
>> Extension of MCE Records pool, based on system's CPU count, was undertaken
>> through the previous patch (x86/MCE: Extend size of the MCE Records pool).
>>
> 
> This statement is unnecessary.
>
Noted.
 
>> Add a new command line parameter "mce-genpool-extend" to set the size of
>> MCE Records pool to a predetermined number of pages instead of system's
>> CPU count.
>>
> 
> Like Tony, I am unsure of when this would be useful.
> 
> Also, why does it need to override the CPU count based extension
> mechanism? Would just adding more pages not work for them?
> 
> If there really is a good reason to do this, how about changing
> mce-genpool-extend to mce-genpool-add-pages and keeping the description
> the same?
> 
> mce-genpool-add-pages=	[X86-64] Number of pages to add to MCE Records pool.
> 
> Then you can simply add these many number of additional pages to the new
> CPU based mechanism.
> 
Is it safe to assume that users will always want to increase the size of the
pool and not decrease it?

IMO, the command-line option provides flexibility for users to choose the size of
MCE Records pool in case, they don't agree with the CPU count logic. Just added it
to ensure that we are not enforcing this increased memory footprint across the board.

Would you agree?

-- 
Thanks,
Avadhut Naik

> Sohil
> 
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  2 ++
>>  arch/x86/kernel/cpu/mce/genpool.c             | 22 ++++++++++++++++---
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
> 


