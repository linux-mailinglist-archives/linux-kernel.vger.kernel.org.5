Return-Path: <linux-kernel+bounces-48325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA14B845A63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26E71C255DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E15F469;
	Thu,  1 Feb 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YjCYAojm"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4553392;
	Thu,  1 Feb 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798120; cv=fail; b=HqkS/E78ziUDULNIiSNlFUkI99gpNCq9WfLWn8iHbNlvnnr8mLF84duqJp6V1xlGlBcaRmFq6IULeL6vZ5Rgjq4cmMSUARhBvBqiFQ61fBdJImBz9oqAq3Bt1fk7L85XdL6yQYLYU9gPaaG/Xycl22ChU8wj5GLiStiCJU/4Nqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798120; c=relaxed/simple;
	bh=EMgPe8c9XgwP/KE1F0xc76ATd1J0Smxrxgt9kQe7EAA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GMwF75uzfTY3UXJh6gouzgT6OcGlAeoCzjlmz4DadstEKJeHMJDrP7kGBM6iRDhehohPtF0BtEqTmImQgYcPfqRCrePS9F4/122TEb3tt3K+awk36LxzHz8nH8s3E15EjiPKqaNaLVHXGBnXNNe5ofgiyXvxPPbwaNvx4EZAxZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YjCYAojm; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D98IvCaKmgv4fd7j0i/BuaKZU4Siy3oCRSVF6HnQD0D+cPEFvHIiS1F9cnTbCwTPXD/RAl9A5AV/GkXKf5SddeyC0zjijK1HczwYegG3na6/3RrRtU4a0weznsLeSxubcH+YWcY5QjyWpdpPFPgN4GY+beG7tXzufkDr1egzY6hq+ws885mkZNg3rWJ+p/YfSt+Vbfmw5b8/OKI3e2QWNtVYU5GHyrWlXl5zzdh47xiOknIz7C8sdqRs8pqufdgfGDyKhyBSStf2Boj460sdTeLSTtJ0tTQTIABHeadkEO/73MZ07Q8tQxsCkic7MSBBW89bny8YTLVgnQkeRg54Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqyRk8Gaqv4gSozfVJxawvBOnCALgwWn9cyW0sVnl/c=;
 b=nuu+6pnkDr7IzpUfAeOmZLtg2+/hpGY7xUOme7c8Qos0yyS23lez0g3sCivFn/LhoGUSLhonr0NPpTXQE4EsIIoP6SnBnXPs24DzhnP24uRopjT2BQx6VxXz0Atg5/hTcgjL4s1/1NdUMODyh95RXeaH0CtY9Fd8LPqc6vyil+0pTJYjmp2lOAvHFR8Pbgq6CZTJyTI1eed458A4XoEHmn0vE9HYgow9Vvponb/kLpa4GYMQr+tVVoS+5la0r4zjOmVHjQVaenZQrn4qDDrPJG6Gto2WsQk0GLEIjtNlGvMMyAR7qOiolGWF6WU1jWDLSVrXeSuzYWZb5USh/W8zNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqyRk8Gaqv4gSozfVJxawvBOnCALgwWn9cyW0sVnl/c=;
 b=YjCYAojmsYx4Dcbb/Xy945BHLiMPYUC5AqxOC9zSIHGSNFCA0vPY3H37qHmHxtBqpUWHohBYY5M9CbzZlR11PWDBYwC53T+4Wqju4X3MRIQDnooqscyjNMzRtffbjXpeUu0qJ552G4IffUQYJv7SKKObUDcsDXINzN5J2Uu0gsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 1 Feb
 2024 14:35:15 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 14:35:15 +0000
Message-ID: <132e22b9-2e42-4d8d-a2ea-14023bd5dae1@amd.com>
Date: Thu, 1 Feb 2024 09:35:13 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com
Subject: Re: [PATCH] RAS/AMD/ATL: Add MI300 DRAM to Normalized address
 translation support
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240131165732.88297-1-yazen.ghannam@amd.com>
 <20240201092148.GBZbtirOfNAR3SYmht@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240201092148.GBZbtirOfNAR3SYmht@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:408:112::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b932c36-f903-482a-c281-08dc23330164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G550ot8uBDXtA3qQ4ymKCvTjQytnGxJrck52r+BXq3n3if4zpQOxjM0zrgRjDZ1fdyTmNolz84d5xA/jZC8C4CAoUTH4atvFCMS8NVityk8FZ/+RGriSGZjTAefnvjSY5MHPFK/CWGfQPUDGlZmkD+/vTpgOzkbo6zuuEvENj7plKClq9gZ7G62Sjut5c73Dxjd9Or104y6CpZiOxeU+JK0LqwKGEcY3BgTfyBQaJItKxAag2RH7NRRqXeRt5AaGcKHDVXJuzcd0W2y0Z8c9A1NXx6ZcHe1PMVnaLksMBJtF6mhJE2nt2YYfWS0XHVK6GbEk5prW0Jt373Kh+Lpd4X4tbLySXFZ26FEZz1oZOn2bgQpcWrCiPlOHZ15zkv1e0pUs90QUjZHE0cfb7Fsl+3vJuvLXdSqj1gT2HUZR11MCpsbU5scqaJbxOrqLffT9FqJe5y24Aa+nzKVssGJF+IzpxXSKpxNSnApt5nzShlJHtP0LJHFwlhdysyGpttO+yhnjHV+axlOlJfbfXsi8iqjD2Ob+TaTl/R16Lvwxmgay9hc+iH8oawIY4wmShWoGysArX6xyZH0agIpZIts+bcBm9/Zabuu4LTu16818XAZFhDigHgUYLPqI3BdnFZOSJR/JZOoBvntD8pQbgjuRZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(41300700001)(31696002)(86362001)(36756003)(38100700002)(26005)(6512007)(2616005)(6506007)(53546011)(2906002)(4744005)(478600001)(6486002)(66946007)(316002)(6916009)(66556008)(66476007)(8936002)(5660300002)(4326008)(8676002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YytqUndwZ3N6ejlYcUNKaHg5aWwxajZzTm0wL04wWmJOTFd4Vkl3YzAyYmpL?=
 =?utf-8?B?aUp2aUsrMGpnMU9WcjlZSTJITnZYd01JcTBzcy9idmN1T2lMbHVxcm5CTFVv?=
 =?utf-8?B?NjJ6TEdhMFUrdkFZaGc1UnBpOVFSWlhJUnFRMml6ZDZ0REJ6aXNOTXZFdkZa?=
 =?utf-8?B?akxYUzE3ZU9SRTAyZ3gwN0c5VG9jbmRtZXJTK0JjcEF1TU5uczZyMXBmWmdU?=
 =?utf-8?B?M1k4cTR5VWg1SGtmQWtGNERYaUVhQ21yazh6YTNvRC9VYzBNVE9qZ3pNcWla?=
 =?utf-8?B?Y1RvR2s0UUJDVHMrYjczdnhjTU0zSVpTSDlkVklGK21qTjBtSUFXcEVZYnZ3?=
 =?utf-8?B?eko4NTJuWk5kNzF3TUhkSkpxUnZtOE0yaFJOTmoxSkt4ZUZSMFdwZFYrOFNW?=
 =?utf-8?B?ZXI0MTJyek41ek1XQXZTSlBPblpuN3Fzb2szakkyOGV4VnBhU05JWnpZVXZO?=
 =?utf-8?B?bEtCMG5vNjRNSUtleHA3eUd1SWNSd1ZLWlBVclB2cUVxRVJ5YXNXL1BmRERV?=
 =?utf-8?B?T1Q3WVhTMHozQUxUSVk0SnZtYlB3QVk5emlRd2JBSW9YNjdmcmZpOWgwNmow?=
 =?utf-8?B?Z1g0MW1sMDlVUEJidmtJbm4wYkJvb3Z4VGdkM0NUVGg5Q2hPekl4MmpnRWMx?=
 =?utf-8?B?VFZ3SVlaMEYwSFJBSTM3QWdtOHBid3J3NC9weVdEbHZsMFd5Yy94WGswS0d3?=
 =?utf-8?B?cVI5Tkw0dC9Mdmk2ODZHMkJYNEs3clVCejVVNC9USmxmWkJtcFpPY0xISjJk?=
 =?utf-8?B?ZDg0RlJJaTV6TE9yQ3IvMXc4VmFHUGI2VmlPbWZHcENKZGhsWUJEcGRZWW1F?=
 =?utf-8?B?L3FUcWYxalhLdDFkMzQ5dGRMV1RuUUtlcmhIZ05CcjdBU3laYTI0VjhzY01v?=
 =?utf-8?B?SmNlNlc0SGJBcXBvenhERWY1cGtqVlBxRy95R0pWbEllNkErQTg1V0R2dzlj?=
 =?utf-8?B?OTlMRzdyem1LaHllZ3ZhSlFzK0QwWE1aYWZvdHd0eFFScHVKZ0d3eFZVS0R1?=
 =?utf-8?B?OHo0QUtxLzA3amlVMkNDU2l2d2RPTENRZWdITzduWkhHaUFDMDE4T09peVBK?=
 =?utf-8?B?bXg3VHY1S29MM3d4V0NjTEg2THJsZngvcm9WcEFybEt5MEpoR2tETW1EN1hz?=
 =?utf-8?B?UGppWGxwNEVzT2tWbGxYbEdLSjcwSnhJSU5HMGw1dEdmRWxUUU45c3Bqb0V2?=
 =?utf-8?B?YWdaRldmejQydUZnZFRMc0VxMEtoV2JjcU85Sjc5WjU0cWFtRGhrQ2Z3QTQw?=
 =?utf-8?B?TXZxV2NZRlJJNHBYa01NVnVjTXlEdlZXQTlibUJrUUtwK05acFErZjkvMTVv?=
 =?utf-8?B?OHZMWkRJaXVicTR1ckJ4alNJbnFyTytFdThkZlhiRG9WZzJvOC8xOXlFdDFs?=
 =?utf-8?B?T3lNcHp1QXNMN1FFYkdMMlBEZEFHbDhBU2p3c3hqaiszYnFNSzgrZ2UxTWkv?=
 =?utf-8?B?YjZnaDhGWldHRWttaE1RaWhwUk5KbFV1ZWp5d3FldlcwSnBGNGttWjh6c2tz?=
 =?utf-8?B?aytvMlFWM3V6ZTRVVjlHU1JqY0IxL2NKQzh6RzdPbTVVMi83VlNOUUFFVXhB?=
 =?utf-8?B?a1ZNNFdhK3dvTTNZQWE0dFZUU0p6WWNSVWhxSDR4d1dFRVI5b2ZTK3ZRU0Fs?=
 =?utf-8?B?YmxoZ0kxZ1dabXFtbk1KcWJueG5YeVRFN2RHcTFDVE5vdFlpUWhXak5KRWUx?=
 =?utf-8?B?K05GcTlxVTZNbStyVzZSWGJsTWxNaG12dVV2Rk5WakNRL2tJN3l1T0pIbHU4?=
 =?utf-8?B?NXFTSkEwaUhhU0JseFpISkFOMDE1Rml2aERTVExOTkdoODZTWWlVR1hEclpn?=
 =?utf-8?B?UzNFcVlSRTE5cWZHbjJLVW12ZnVPdHdid0NmUzdSbGg0TmExUGs4TUVtQUl1?=
 =?utf-8?B?SzVmOW5zZnNGK2piYkwyK3Z6Qzg1alNwS1Ixek03SGFpdStDN1JkMjU1SWVV?=
 =?utf-8?B?Rk5PYzBGRUlpUmhjVk5BTHcyaEtWYWxQTjZBaWNCTFFIdWlXS082a24yaWJT?=
 =?utf-8?B?VXppZ1hkWER4T09ORWZ6bXhaaDlqVmxuQmdYV1V3encvRWYxdDMzZHZja29J?=
 =?utf-8?B?NzhwSGR4Snh0a0htd2tFNWFteCs0dGs0UHpJQkZUSWpXQVBiaU1OZ2pOYmRN?=
 =?utf-8?Q?EmL/HlPM7uxFDaWu65RVx1r0h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b932c36-f903-482a-c281-08dc23330164
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:35:15.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANw6DRZ+p1qEI8MVOBRKSicFLKriIxwmYQoP2rBqMOYJAFsA2drR6bhNxCI15T2CHgvGy+VtQdg+6XwXnBNKoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672

On 2/1/2024 4:21 AM, Borislav Petkov wrote:
> On Wed, Jan 31, 2024 at 10:57:32AM -0600, Yazen Ghannam wrote:
>> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
>> index 7bfa21a582f0..816c2c5c683f 100644
>> --- a/drivers/ras/amd/atl/umc.c
>> +++ b/drivers/ras/amd/atl/umc.c
>> @@ -49,6 +49,203 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
>>   	return i;
>>   }
>>   
>> +static u16 internal_bitwise_xor(u16 val)
> 
> Why are we calling it "internal"?
> 


It's an operation on the bits within a value rather than between two values.

BTW, I looked up "internal" in a thesaurus, and nothing seemed much better to me.

Maybe something like "xor_bits_in_value()"? This has the verb-first style too.

Thanks,
Yazen

