Return-Path: <linux-kernel+bounces-55508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D5184BD87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AE5B213F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699A13AE3;
	Tue,  6 Feb 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ppHifgY0"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F138EDF59;
	Tue,  6 Feb 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245817; cv=fail; b=WvEZbqUsjy0qB6MjsnnB6OoQl6ttn//L93DrnYSJkUSFUO+NEkmLB0H5skoqHfUB60jcjx30AoTYFvc75F/kjYZOS13s0brn9K9KORN0WizBUUG5A92Msphpi83KH+pXNSlSvrd1apogbrVAAwmT6+EQAF8ZsOPOAD3IH6YFk1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245817; c=relaxed/simple;
	bh=//4ocZTZpFNDtFgMG25bEK3Qlt08iI08dbMztL+QGXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lW2y7WyUscGtUN3NuGqmVx+Z5UmhvE5+TMe097qj19MbGTMEolClsXms2J7DeKOq5JGHHAuTtGHolfMZbYjB+Sydi8B3Z2PtbdQB4Q8eAMwURF9CYvKAyGIfkmFGLJf09Td5LLvfBzi4MbREBPbkezeXi3j1WoVWZrLFVvZMfn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ppHifgY0; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmZ7+fFs7ojdRq8VdOSHnv8eqHcmhyIqDV03qBBH/ow72YnJGzsRZgBL0bg3r8HAJHlDofcuV4WiePMSszDdeR9U8oYSbHdmLshkvylzzTxGvSwPduNq3XsLiizqjivwzf5ZCXgjioArquup51iAayjc4oQcT7QX35Kl6oBCelM9bSea5DziKiGuwt5haYwwJyv+OnTjN5Uqd31Q8uvnUjfRzNgiRvmXCMcAi3kQK+ueChtMD0c3onkg0g+aYZS6uG2cEvOBkGNkZCrxrunCicB1oWWB6CmoydCdbtlOkRL+kORM33DOeXyXxkQ2b64XVjpyG0Py/k/9PZ1NYItZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeSRwqZ0HxYPlzhvS/8uz7sOIy7HshfCs8wZufv1oOo=;
 b=hlONnYf3ICkE08/8MANdVIZFjeWtYTqVwxazPJoEAxpIBw4KGaHJMcx6zs4nBwUoA+XTb6fcbNfxO+c7r/R/vhpssVTQhJlF+4V6pc2jxOVp3QS0DnkXSOWndlWK8hgBds2vOEQpcmD+hKjA9Sgm5gzk40IVQ9orhUk3WQKD2213DwyBFvcKr6cikuGBSy7MiwuYD/FQfewXfg1x89V9s7M5CR3YWj6+XwStYgV/TCZ0juGb9oxWl5y0sigUpvM1lnbpNK/crqlb/3qmlXx3jZ8DM6SzEBqAeOBM5WnhCJOLNDAtiA9zkCraa7dYbBtgpqnlNuYB8sJZy7cCgK4asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeSRwqZ0HxYPlzhvS/8uz7sOIy7HshfCs8wZufv1oOo=;
 b=ppHifgY0ZjwEb32CsQ3IeRS0VST5uhmMOU7MBmgZpwUdLDYfw6kKqmkUa0IzZ3IAHSnu29xLD8BzQrRu1FVFmrcyqxn/JJIaaw/ufj7ZOLc91rUEYazJXFlP6yH0yZzCXTCKccObDeeWG7E9T6a44hlwVmL8nTIjxVRjuJB4PaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 18:56:50 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 18:56:50 +0000
Message-ID: <28f55bf4-4ce6-4913-837e-2d04d53ff2df@amd.com>
Date: Tue, 6 Feb 2024 12:56:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: ccp - State in dmesg that TSME is enabled
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: John Allen <john.allen@amd.com>, linux-crypto@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240205154602.21411-1-bp@alien8.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240205154602.21411-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::9) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0cef81-8e5a-44f0-3b66-08dc27456070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XRnlJAxcNJl64cjxVlYbGQFI9VrwU0mkNuRaZfA4Wz6s2sNDJccDZuf86fM8d7W/q8ESoivjMprpZqfF7EOpVdru1Fxlce7Bo6V2mrLpVN+0WvqAOM5bTh52kkBF+xrlny/JYf8mNpZfeAJlUuMP28kqD3cqMDBZ9WiFr3lS5YIqPDh6WZyUvU6ACZwtxJytaDLmb+HI5oeVLh3VyeDhFgcet0bSwCJuQrVWVMxei/tzuMz/NCYuEpGqxjtkCydLBchSsYoaN3Ea+VT3jiF0b/SBQTK/6CYq+9hO37o3gM9EToNASnmHPHczxKmA2qmDQ/8o/Hnp/wys0oiDybCkPmBWHqkWmhNAbnlBwRSO1TsucVF1xc8bNXVP341ZUFR7xOmqdeXKo2HdH8fUvYg6TWvDodYJqWWAPqX/Lltm3y2gjrjEx7oZc1rGRsJqXLq8r6ohuPWvcAjbk+4+n17FrW6Yg0G0DiLxEg8FXEG2sMgrGn2VSqL3qQ/1Q/uV/T6y8hViVVFjf/RxN5r6+rLgCYQaLSGbAUhTNUQmV0hi9c99OdgLBv/H3UgA2aNh76Vv217zPhthTLJhfiBLiq78XUuFkXy/zUay22NXJ6F3uPUnsZeVXcs9GBshgPlkT5iUKMr3gdQfao2QuVCWnJVJtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6506007)(86362001)(478600001)(31696002)(6512007)(2616005)(6486002)(31686004)(38100700002)(83380400001)(53546011)(26005)(316002)(66476007)(54906003)(6916009)(4326008)(66556008)(8936002)(5660300002)(2906002)(41300700001)(36756003)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUpHeHpPQ0hRaFd1M0Y5MGRLOG91dXZoaS9TL014TU9SaTUzRWJVZkV3Ym9G?=
 =?utf-8?B?eHZSRzV6NEhsNTh1dlBRY0VvQm14T21lWW1GcitSZWE3aEhvTE5RSWlIRWxt?=
 =?utf-8?B?bWtzU1BBN0twZXJmZlhuN0Q4eEYwTUE1MXFuTm13WG1ZN3RqaUJudzQrdkta?=
 =?utf-8?B?V3VjMERPbnZ0RCtZYjIrNVQwTDN3RTZwZ2R3WDJNQ0N5eVoxcDVwczdGVUYv?=
 =?utf-8?B?cXdKUlFiWVJ5U2tqVXNjVjZlbkhqWTZrcXBQQklNeXIzbXFGZml3eFdWY2wz?=
 =?utf-8?B?eUs3SjZFSEhSNmR2UFZGNm9DVisvV1RWL1FSUUdNMmJla3RjRlBFQUNaZmx5?=
 =?utf-8?B?eWlHMjdKb0Roa3B2MGczNUhTb2hNNytUYktrb2o0Y0RJU2lhS2dobWxBdDUy?=
 =?utf-8?B?WkFGd3lnd2liQTF5cVJSV245ZmZVUUVXLzNBTzdoL254U3hqNCtNdHRyRGFm?=
 =?utf-8?B?VFpTeHlnY2Z5aGdWY0JodjZieUNFMXdQaTZuQnBoazYwZ2ZxV0xOQUpMSlNM?=
 =?utf-8?B?eDRvak9pR2s2N25FRDZ4aHBXalVLcDNaVEhsRTY1aGI1d3g5Q1VIRFVlQUtP?=
 =?utf-8?B?RlhBR3JjajBOTkxzYXE1cTBoamJEUmh0WDVVektJT2pMTEUwV2MzK2J1YlBp?=
 =?utf-8?B?VmlBaEdUL1N5enVkZnYzZlk3WFBERGFhT2RvRTNLWlFBbUZaM280VVdYMmYy?=
 =?utf-8?B?bUZSYm91NW9QM3B0T0pCTlc1ZWxMOGYvZUNtUjdBdnFoNG00T1pBaDgwQVha?=
 =?utf-8?B?dTRyeS8wd3A4TEp5TUVFK1Q1czBsZ1BITGM0Vy9SeEJCcUZ5NG9WejZqTzJB?=
 =?utf-8?B?VzVLa3VZRXNiNk5rSHNqZit1T3lMTS92d3ZqYVZIT3hKVGdqb3R5UzdnejEv?=
 =?utf-8?B?ZE5EMHNCdjNrVzZmNWR4a0lGL0hpU0dhVGV1MThpcUFSVjR1ZExuSy9ja0Va?=
 =?utf-8?B?MW9ZQnN2dDY2NjFHaG9Gemx1L3l3UnVqdFVxeEJnbjRmVW1BOTBYOE1jZVBK?=
 =?utf-8?B?cFRVRDV2ZFFLNXJFZHd2QWF5ZTd3Z3UxMFlaMHNKRGQzSkY5Q1hRamh4RkdL?=
 =?utf-8?B?RWtUdUNEeXl1MVdaRTE4dGYvZjlBVjdkTmZzR2FOdjh4NHhvYVdJVGxmUnha?=
 =?utf-8?B?NlMvZVRnSllodmdmQUdpUE9XdjNQak54MzViQ24xTVN2YUV0YWFZcjRsa0k5?=
 =?utf-8?B?MVM2TzBUSXBVTkltcTRyWDZZcmF5OEU5cnp5c0p6a0hVVTg3TFRNRm55d0p4?=
 =?utf-8?B?Wlk3UEpuR1BKY29wTTlJeFZic2x3YlNvTFNaeUJ0ZjhEQTVUN3l6US9jZFRl?=
 =?utf-8?B?aTdJNGM5N09yTEo5VTdSc0Z0SStobHQrZ2R0YmpScVpPSFBIOGRWUVl0eXVW?=
 =?utf-8?B?S3VNeUlEaHFmQ2hDZyt6V2FDcUxiVkNnSFZXYjV6dWhKZGRPd1grb0RJa1Y4?=
 =?utf-8?B?SEtvYkxvc2dDSzVtOVFQTnU4RDcvRFNoQnJCK1ZoVndBeGFzMlBvNTk3ckhT?=
 =?utf-8?B?dmVUNmxiUUNQdVV5UjBhcWJ1c1ptei9ZQ1BSREZsanBUQVAzQzAwUFF5c2wr?=
 =?utf-8?B?dTREb1JuWmIyN21WOHpaZlN6OUI5emZqLzd2cmdmNWJibG93RUN3RkY4S1Ns?=
 =?utf-8?B?TmR0NVhEQWZTWjRiQ1JUcnVjcTM4dDdUYUN1NmtvRkg3SWNoelZSZS95OHFj?=
 =?utf-8?B?T2xselp0U0tkdEMxTmxDN1gvZDE2RHdVVVlpSnh1dnFBVjlYaVlxY0RSZ2wr?=
 =?utf-8?B?RHMvT1JPTGJVRkxJS3F0b1QyRjdic3pZYjBjczFQZWtwYnlIL1F5R0lNaW1n?=
 =?utf-8?B?dk9kUGV4L096TjNPbHlYR2E4d0RqemNWbEkrLzNqRC96ZUs0WXJuZUtBZk1H?=
 =?utf-8?B?bk9pb3Fod1dLUWhDdnduYzMrWm5LWkptMlN1REhWRW5QU1JrU0pnTHUwOVFN?=
 =?utf-8?B?QXhDT1krMXBLTnY4WlhsQmw2SXBKb21BaUlVVTFVd3FsbEFRM25jMUwzdzZj?=
 =?utf-8?B?aXJTODA3S2xQU2xSYzhXVkk3MGlVa3JhUGV3STY5TTVDc2RrbVlHclR6ckVn?=
 =?utf-8?B?R2tiSGJJQ3dWV1Q5WGJWTUxOTlFnZHlJTFV0YnpWWDVDS3Z2bVBxaEh3cC9i?=
 =?utf-8?Q?3wyPQzDf/Q1dPjgg6qURFiXfr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0cef81-8e5a-44f0-3b66-08dc27456070
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:56:50.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGxn3xcQAn9AT5VXBRaaDY7MB5gMJ1ZJnuSSqGIkGVVKX1ukIEV0X+pz0os5jboI8UckD+OEqXqNBp8wyjeppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

On 2/5/24 09:46, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> In the case when only TSME is enabled, it is useful to state that fact
> too, so that users are aware that memory encryption is still enabled
> even when the corresponding software variant of memory encryption is not
> enabled.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/psp-dev.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index 124a2e0c8999..56bf832c2947 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -156,11 +156,14 @@ static unsigned int psp_get_capability(struct psp_device *psp)
>   	}
>   	psp->capability = val;
>   
> -	/* Detect if TSME and SME are both enabled */
> +	/* Detect TSME and/or SME status */
>   	if (PSP_CAPABILITY(psp, PSP_SECURITY_REPORTING) &&
> -	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_SECURITY_OFFSET) &&
> -	    cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> -		dev_notice(psp->dev, "psp: Both TSME and SME are active, SME is unnecessary when TSME is active.\n");
> +	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_SECURITY_OFFSET)) {
> +		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> +			dev_notice(psp->dev, "psp: Both TSME and SME are active, SME is unnecessary when TSME is active.\n");
> +		else
> +			dev_notice(psp->dev, "psp: TSME enabled\n");
> +	}
>   
>   	return 0;
>   }

