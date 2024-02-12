Return-Path: <linux-kernel+bounces-62280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02EC851E05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8201F21418
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0863247A52;
	Mon, 12 Feb 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2T9syo0P"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89A45BFC;
	Mon, 12 Feb 2024 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767015; cv=fail; b=kXJEE4icVuTMaVbiAogNAVXBfgP/LdFwo1Z8XODuVmxiAKLMMU1Bu66FOVLM8xQlXrJf9RaTZPRoQ5j9Av74xdJBERHqJLzdCLllMmLn5vadrVDeCInPR48fQgIMeLcRLEGhbVjlRvejFYPZwbKBcLHmQEX2AvXVGmdhIR/bWoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767015; c=relaxed/simple;
	bh=IDtG98i2A3RfKfNzW7pbzSoxFjaxOLHiwj+Fnu3FmGc=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9RxMNLr6KyoX2HGe9ldSlxGhYDceWyamuJxex6/p0+In2bAL1DiJOFtj6H9z1ilNjCkBuI9aG+xhQ+LfloTGI/2hJAXCAPrHLW809sqU3DcYnZjikHYRt57Wzs/1Xty60OgykI12A5/nQq46ewHJLjOYaBVUqD0vYZiIrEDCYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2T9syo0P; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6CzsSz7DWSgG7qjQ6YDMrOvDPB25DL8fgzFbtpPowfpX55iVA635S2J20j/5CGDRb7/UUTOCPfjAW6h+/ySX37JOjjpsBxQYypfscYlT515EWB7nf+TJ6wO7PH9VNso46PvKLQv2UWpNV2pSOz9Oz5kiRUfQhLJyY8Nb1GYGqEVtSSnBB1zTyWSieXxswh4l14RccMDp7c2xQI67Z5GFHoTc8toTVYjiAklCHhRfqffUDS8hp5qdtlysBgs4d44hV6pAUr5RHZU4HXV8DkhuQ/LaTXpc9yoQMGsEgB/mzAhZwNt7ThcU10U/mpayrVnzekg6S7iF9FAtaWb3Gz2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3EH3/nEYd/FW5i/4wQumoYMbM3B4XE4mTKzLnjxghc=;
 b=OwySCy1ub0iZMvg2uPQ1dspd8aAwdzg1DQsJ1I5pG5VpkxEbSFvr9xGFJbKiB4tIXKnsdQWK7SFpcMN0xa5Kdll/ltynrlByw0KClELzhqE/VbnA3tNZ9RQGlQa3BVnF4MiTYGDDd9u4R2lPanaAynYZVQN9a2/pC4NkV0JHCUg4if7S54CCk0YmpzPyyrE9pnGpKv/s7UrHhhXaueSkD/xzdwNjaN7+C8zmEGN3XMwqGBfT0ndIVnPnJStUPR+EY4lcjK4A96La//9ym80FYtCSAJxXgw3BT+uU2SOyYclACnFJp9qtTCFN79U0prEG5QnjY7uCjZHyU+DFme7bDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3EH3/nEYd/FW5i/4wQumoYMbM3B4XE4mTKzLnjxghc=;
 b=2T9syo0PIW+nE0wHs6gfew4IYbQnRUsCEE53xGglakOd9wi1lq/Eo0pWas1iThaW/7L2+khGFRogGhJ23YYQHSCjLh9MXPoY0Dd8Y8gfA4ltavAI4mfR/XSU/024uyfYOClCvCY7Tvb5ZMFdTvJw7salncSHRNCT9VOD1WrP/D0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 12 Feb
 2024 19:43:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Mon, 12 Feb 2024
 19:43:30 +0000
Message-ID: <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
Date: Mon, 12 Feb 2024 14:43:28 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 "Naik, Avadhut" <avadnaik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0527.namprd03.prod.outlook.com
 (2603:10b6:408:131::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2762d4-3f63-46b2-3aa2-08dc2c02e3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K0PTf2cT2cU04hi4iVY8oQ2AWO8QRTYm4a7OJwRnpyrqEcSO06TJBJ8thEOVd9nDMfMtCPd1QXjw9/xr2q6su9wum2WM4U/GFtE4dPJlFLEOyKJqMHaST3ia2NTQAqzkMedOtKzkbGcO3W2+10TcinNjxlex/uW1L1PPnEU11fNPjBoB3gWqFJMME3+YEiEKSeW5fCqQz0ZDSo6z3IV6GByTrxfS+xTZg7wUiIRXrcibKSdGssSsPmzIjiP4G+KSraoWF0DpwcsqMAI6WOfm3yE6zs8Pmn1y3F8aA5GArCij04/WuyJEY1yYM+TvZK22+XGMdUIO0mb7q1edhi+kXTMynY7K5VJGYBaKMz057fB4fwBf4tXnKvZuaoPV98O+iTu+8K0gAD+jBG1nKENxttkDzNJTm+QGO/VzgwE9B7wA4Rr93Qu0jwCn28CpKQO9/HogZW4f4t0kpyH2T5kUcK4MG/qZQPEKVjOcA1YElQlmbxh4vF+dinAKygtpc8R9Cw2D5Iu9XfzCvAgVbNn9AcdVxTyr4VALSzwV0yl6Oi13Fzj2DkKpL0/I1v86tUvQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(316002)(66946007)(66476007)(110136005)(54906003)(66556008)(6636002)(31686004)(4744005)(2906002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(6512007)(31696002)(86362001)(478600001)(6486002)(36756003)(53546011)(6506007)(2616005)(38100700002)(83380400001)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1dwM3MzR2N0M1lVQTUxV2F3eUp2L3kvZ1VtZi9rQW03dWxFa3RoenRmU3Jh?=
 =?utf-8?B?N2Ixc21vRkp0TE5QRHhYdk9KTTRqZnV4UU51Uyt5bHo4ZTYzbkg0MDZCNis2?=
 =?utf-8?B?Q29rZkhpWnJndVhyUWRVeE1yQ3VzbjZkZ2JYeldOUDZoN3dGaWpvSGtlUjNz?=
 =?utf-8?B?QkJiazFuOGJzeW5ybjZCVWJjVTVNNitmQUJ6a09HWk12eHdXMllqam9wbGx2?=
 =?utf-8?B?Z1l0Y25nZVRudUJQTjlhU0g4SUwrNmhjWkp0NVpGMUxxbzZlUkR1bVM1dGhn?=
 =?utf-8?B?d0VITHVvOWlvUGVZdkNEVmxyVVVQeXhZbTVFTTIrcFMwY0FMQ1BXeHhCcVdx?=
 =?utf-8?B?Vmp0Wi9hVldRUEpySlczRklpWkVNOGpWa1hXRTBJbnREVE1kR0xqNS8wSkxI?=
 =?utf-8?B?USt5b1E1OTk0ZkQ0S3NnSTZVZmdIQ1I4TDRhYzBnUllPLzJ6cWZLbzR3U0d0?=
 =?utf-8?B?SU14RHVEcGY3cUVjYkdYMFZWcEVoWEtYbllHendjWUttazlzbUJweStIOTY3?=
 =?utf-8?B?UXFwcTdyMzJuUVZHWFVobXFWNktPOU93ZEdubzl2c0YwK0Jtb1RKNWpUY2Z3?=
 =?utf-8?B?YkFaMUp1VUFWNWZ1VG9tQ0QxbXlFaGxhSDBTYjdWQ29MRzd4ZXFjS1RRdmRL?=
 =?utf-8?B?bjd5TWdsNzZEMUU0aWRORk1qK1Iyb29HR1RkMEV1RkhmNkljNWVJWkZPUzBP?=
 =?utf-8?B?UXJQWjRYaEtOeEVXTEpZUDZMQnJ3OGxHRjVReWFINVR1RG1SYWRjaGRYNW5G?=
 =?utf-8?B?dW8yQUFGSHlSQVlreVczYWhOdERuZXpJMlBQdVloaG9xb0JLczI0anRoL3NJ?=
 =?utf-8?B?S1dXVUdDZE4yVWRZaVBrV2JUSmhncjNtbXlrWkp6ZjlNMlpaK004alpkYTJD?=
 =?utf-8?B?UlA2QlZJWm9INXlOcG43K2ZndEpzcThTakJTVU44aFlpQkdaUUVRdlNWTUli?=
 =?utf-8?B?MTFuVkZLSzlrZjRaR3VkNWNCc2pDTHl2aDh6NlpPR21KUEFDdFQwRDh5OVlt?=
 =?utf-8?B?QkJKZUtYKytDMnZLazFldzAwMjRadzZGd1NRK2t3UmpNQ0NXL1hEZldxQXpT?=
 =?utf-8?B?U01mT0FJZGZndkxpcFM2T04wNGJKWDgwUGpFdjVuOXB1UFFEdTVHYis3a0cv?=
 =?utf-8?B?dGVQUG82d2ZsdFNzMUVZdmsra3Vtd1dxaEZTUWhSeHIycnhGK3pwVGxXZHRq?=
 =?utf-8?B?NldqU200QW1XNE50SEpyVHRYZldvcW9yeDRGNDZQSHBtS05DZ01oeTVXNzRw?=
 =?utf-8?B?L1BOU0d2ZVBUSlRMUWhZeEpVZ2EwQXE5TjFQN1ZzWUZmQ1B5U0doMEtlaXNn?=
 =?utf-8?B?UURySjZ6K2FFUTVJa1REZWRKTHlHeGtxcDA2NStDWnBRZFJYd2psY2pMVTVS?=
 =?utf-8?B?dUkwWGpPdmtjcXVFV1lQMTJNdTFMUTdyQ1JSTTN5NEFGRVBJNkxnSTI2SUFQ?=
 =?utf-8?B?YmltUWVOM0NHQVRQeXhRREFuYjdnUlJiY1RLMHZoa2hEVGowT3NXNTAwNFU1?=
 =?utf-8?B?L3ZZODd2WUc5eHRyVjZUNzlFV3FnZzJFRUJpZ3cva1M2OEczQW5CQlFzS2Mv?=
 =?utf-8?B?VFhEK2R5U2NjbmVZdDhMWmZraEZ2UVpyVTUyNWJ3MmhHM05TZHZMelhyanBo?=
 =?utf-8?B?SXBIdkZ0YVlMZkdSdHZOL1B3SzMyQytHNjd3SGFKdDh2ZzFnT3pRdjNKTVpX?=
 =?utf-8?B?cTBLekZWV3pEYUhBZUpsczNUb3FZaFY4SW9JcmpsYjJNMDk2OExwWWU0dkx2?=
 =?utf-8?B?VVFqbTNQYkxrdjlzdVJ1M0lTaGp3R3ZsZmlOM1BPMm9vSUsvTE9GKzlteGNm?=
 =?utf-8?B?UVd4eG1GSEwzV3R0WnZ2dU05cGRxRERhTk1sVVVtbHBtMVNuNWg1d1hPeEpB?=
 =?utf-8?B?NHpTN1JFY1k4Q0c2bEdJWnpTaWFQelE2ZnY5NkN3b3lIT1Z2NVRRWERvQThm?=
 =?utf-8?B?eTB6ZGNYR0RRWmRZZjJreXFTMWJrb1NzSk4ybXVSWlR1WFhCa0FXRnFYT3BV?=
 =?utf-8?B?eEhmOVZSMnJLSzVtYitIZlpQYmdqYUk2cnc1VEVoYWJtRHUrTEQrd3liWFMx?=
 =?utf-8?B?L1RvZXQ1OW5JMDhsYTlsTmI0REQyL01hKzU3Z0MzZUdTMmpYWnF4Wkk3ZDJX?=
 =?utf-8?Q?VC0yF35jbQ9JCibhdMRNQQDwU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2762d4-3f63-46b2-3aa2-08dc2c02e3cb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 19:43:30.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWvNqHQQPUGnRmiAcUAyNoxOJMOkkhv27ps9G5u5c71URJoTKCDnWlvIfXq/xUcK7gkfMWc5lFj6EgM1t5vR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

On 2/12/2024 1:58 PM, Luck, Tony wrote:
>> I need to look more at the genpool code, but I thought I'd ask too.
> 
> Yazen,
> 
> gen_pool_add_owner() is the code that adds an extra chunk to an existing genpool.
> 
> This bit doesn't look obviously safe against a #MC at the wrong moment in the middle of
> the list_add_rcu()
> 
>          spin_lock(&pool->lock);
>          list_add_rcu(&chunk->next_chunk, &pool->chunks);
>          spin_unlock(&pool->lock);
> 

Thanks Tony.

So the concern is not about traversal, but rather that the #MC can break the
list_add_rcu(). Is this correct?


Thanks,
Yazen

