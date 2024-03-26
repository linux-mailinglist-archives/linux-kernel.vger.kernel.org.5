Return-Path: <linux-kernel+bounces-119092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F288C412
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE9B1C3226F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBAD7640C;
	Tue, 26 Mar 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/phD5CT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2105.outbound.protection.outlook.com [40.107.93.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109374BE8;
	Tue, 26 Mar 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460847; cv=fail; b=LJFQXf0E08m2fWjt3JghyXfRUHp51a/JmXxkcNo5SfCmvmS7hm25t4qWbvDDVIXGZvfsvalZWOWA7ynu1QxhDlr2U2ZCGZ0VleODCDGLI4dypwPAvkwg54Rgu7+3kt35XrZDVIagwZ9tAWlL3JyJBeomKEPb9/Bdi8ZJPq5/y7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460847; c=relaxed/simple;
	bh=tBblZa16JdDFiGVQq2gU5Hmgp2UTlvUY6UxCTwrcQ/8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eCXNlXm5GTLG4uSR5uXrKOzk6gafBGWQ7RyuKChlwupKxdn68UB/JW4C6kj29ZzIVSozYosDkCNGVppbKbcQIQEgakV5CEWDbIkFqmI7T5tMHgMcyBgkohAhoa/vK3XLaxUp9nikx1fUrRm+bYbk7wu6rmqA5yB3e5pJUDdFpTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/phD5CT; arc=fail smtp.client-ip=40.107.93.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4pOcMVzseuojEx6G7s+9tQQQsISi2vX0Py3A8gKP4gIWOoAJEgVmL4u2qgEqMHIEsnBO/u5GIJDRMW3ObAPELJm9X8QZpQKpk8HO9GpnQ/PAQ7gDPzuTYVejp5FQOdLx/uvXnuYxY0ibkE7PzIZITJnCupj3/bac30KgOxpvzE9JJkMhrHKnDHqVd4ayXpc4ekunW9jLZeHu90PL4fPXBdbAuuMErH/GEb8TMVgj0JjyZZTfsO7v/q0K6uiNcqcyIqKuhBrFYLwSfDuVoA0Lm4NQZ6eDYWXh6jOymyQfrO2+N8VBRoBL/xqwTrCVeT4ANbOKUBQQftYP7PtWT0DhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcBstimaPNGF4amWrJLizoD/cXgPrZVKFKKw1AcuXGc=;
 b=YfZkM96SgXp/IVLRUKF0PxAF4IV0mswFIU7FAEOqWtOcxJYk5DrOm2NNkJMqwmo7jSP62qbe0oiqGvn13QYaGLUV99sdqVDVQvSX3zZ9mSEtPGetmuwuQXnM2pSyOXkBLC/AFzshOvvoXrDsYpMKsCpmo8H9WsToR9rWkNroYveo7sBNEbDVHkeR1GO29CDz6yZuyDiW33dVJMcarXmbvgD52DezGJaGRR/E7mPysdtxlI5m99TzrqDWkCiz6mEMqfVAnuzc0nEsVh4v25Nop5HqtQX+Fz4g7vi+6yB7NlMiTInOfGCPlJWQsxJFPt+FVK9oNuKQsj8JLL+07e3nwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcBstimaPNGF4amWrJLizoD/cXgPrZVKFKKw1AcuXGc=;
 b=o/phD5CTP4P48vCtuEOQ27dm1RbAHMAPHIHx+KaiscnJTOY1FUqa6I+782XByfTdlRGWDWcCJtviWl6VptBsBlC+HhOHLrLTvsbWwWpLjq/pNT0yQ8Zb3r5B7VG1EkIUZqz6BQEggYPBVdfV6fAMvMSyhJ1FiMT0gVoLXMNzsGU=
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Tue, 26 Mar
 2024 13:47:23 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 13:47:23 +0000
Message-ID: <2d0a3e4c-cd1a-485a-8d36-cd449e73bc68@amd.com>
Date: Tue, 26 Mar 2024 09:47:18 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, bp@alien8.de, linux-edac@vger.kernel.org,
 tony.luck@intel.com, linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
 muralidhara.mk@amd.com
Subject: Re: [PATCH 3/4] RAS: ATL: Add map_bits_valid to header
Content-Language: en-US
To: John Allen <john.allen@amd.com>
References: <20240314163527.63321-1-john.allen@amd.com>
 <20240314163527.63321-4-john.allen@amd.com>
 <893141c6-41f8-415a-a1a3-d3e4267ec333@amd.com>
 <ZgHXR8O7CIoOmfvM@AUS-L1-JOHALLEN.amd.com>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <ZgHXR8O7CIoOmfvM@AUS-L1-JOHALLEN.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:408:eb::16) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|PH8PR12MB6676:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V6W6auSOhxQ/bTQpHpDFnDrMwQJHFKYAeKF08JPjcoLh2o0bjkCjfk/5hzry5DHbf62kZJ8Zxo4lsmIH98PiyUVgNLb36g2GXKtYigjjEEK/OMXi3gUaOPYxFhYTcGXZpcqe3nsghEP2am1wd9etZxuTROpwKdcbq+EV1RZVF4e9Sh7jGBNa4UacjVXcZ3HTlMsLEFZQC4AU8XjAe7O3760sNbFFJbYRByOmc1ngeTzDJWhZc8jzbECW5rXjlklADqT28BbayBeLWAkN6X4yt10mc+3OmYreg+BKU3QZ9F4bThVVc70lobLSV3ITxaCDKDYGrtCVnNleIID+tsD505kNlUC2YgIyvF8M6g9X0u9J7nf96Tn2KVKOmeeD2BBejvvVGW4BlCuEA+LDkICZycwFRExZaBv2aW8W6lmxgVigVqBogHhW2Jx37TS8WBxErHnQSRjF5cTpzAypxl6U2BoDTqZBjuXjkDZD/oTS/ZQdn3vaymwepIxsUDIikmyYysd0bwsfElo1oQbJnKI5R97TiSixexKlRKrIbFExlV5IPmIWzx1RK8tGSAe1DO+VPRQXw7M786HuJd9icggi90+gju2K2mC5XWl4BozYra+Kix7ztAgA/7yVd1ByMJubAyDh+jBg1UhwfCLIBtC0n8LMNObLZO7A6eBmveg4rjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azhNREVkNUxpOFJ6ajlxNHlaaW9RN2NnMSt6Umw3L2haV2FoOHlSa3RkWW1J?=
 =?utf-8?B?dlBnOFltREtxWklhUHdhNVFyVU1OVS8vUm5ieERjcWRUUzVZeHAvcXp1MkRa?=
 =?utf-8?B?ZzVxZkVxd1N2MGJOYWlDeTlJU3JBbGRCTnJHSW8xSFh0ZEM0MnVFQUVmaVJB?=
 =?utf-8?B?Q25OS0V2c2hlSFBQMDdPSU8rTExYOHJuR3pBeGIzV0ZDejdlaERTQXRLUTc0?=
 =?utf-8?B?STJZNkdxc3prUXJiS29ac0wrOEZaNUhjU0ZFRnBiREVRL1c5ZlhhbXlQT1Vy?=
 =?utf-8?B?azVFUDFheVV1TWp1SmgreGNjQzVhRjdpaE5iWU13ZTJURDErZHl5S2ppajlC?=
 =?utf-8?B?U1VKQ3hOb2pybllhaWFXeUZNZjQvQXhIM2srVkdtSHQzMTA2WTA5bWZxWGgz?=
 =?utf-8?B?SjF6bzErTlgzSTZSb1ljcytVaG1vOEJZbU1HV0dydU82THYyOXp3b0VRelhp?=
 =?utf-8?B?Sng0KzhrbnJnNTN3c1VvQjFYenhaWUNWMzhreld6VTlJUFFTQ3lHNi9sd0pI?=
 =?utf-8?B?KzVQUENhK052MVJCVlJmN2dvS29STWlpOFRqVGZjZnlibnVhcWtNYjBMcC8x?=
 =?utf-8?B?bGdCRWY2bTBCVHN6RmNucEdDRFhBRGF2ZkFnTk1hbnRhZE5BK0o5QjJWQXI5?=
 =?utf-8?B?Q3dYWW9WZHZnS3dEQlhpb3l6bWVxZDgyWHFDMm4va3FmbWErcEk2Z3M5amkw?=
 =?utf-8?B?UXZtUmFrLzlPZENJcGZqblByZ3BTaSt5OFdZa3Rsd0wxbXpsZmpURk5RTUJ2?=
 =?utf-8?B?OUR6M3ZrT2tBUTdTMHdieWlFQU9LWkRONzNVQlRmcHhZZk9FWW9qdE1oYm5m?=
 =?utf-8?B?cXhGWFZiWGRqWGF0cC96UWU2TWdvRkpERldVbDNQS0xwQ1JoUWRoQUY0bk5H?=
 =?utf-8?B?WkJqK3hSU2dxRmNudGxna3o4Y1ByZVpKRWhmQ2haREdidlpUWk9zLzdoNlNh?=
 =?utf-8?B?bnppK0lJbWxPdHBQZWwvV3F1UVpyYndNRTlTbGxKdDFNTGtIdkJyWmxxTEhh?=
 =?utf-8?B?SzVHVlpsTTJFUFBoRnFRRXBlSUdWL3g0b0N0UW1VSkwxWDFQOGtZcFFqazFI?=
 =?utf-8?B?YmFaZEVyeWVyVThoSXdIemxNajVtby9tZ3ozTHhaZERUQmV6ZGpvVHJ6WmlC?=
 =?utf-8?B?dklxa0N1c1B4NUM0NnBmMlpLaW9lRllvZlVjNFdVNGpuS0hQQnI5bFZrS0Ir?=
 =?utf-8?B?MlBNSm5hNzBwcGM3bHU5ZDM2U1I5Zlc2TkR2dFJqM1dmZmI1RzloNXV6V1BC?=
 =?utf-8?B?Y2JpSUE1SXVEYUpoSVoxOWJHb29YYzBTQUxmdlF5YTBLK2UrYXo1UnJPSXFx?=
 =?utf-8?B?SUxDcDJkUVg1YTJPMkFjS2RzM3lEbDEyTVpBdkNDNCtGYmJuUDVHK1NTUVVK?=
 =?utf-8?B?ZHFMQ3JlK0pUOHhmTmVlQ3J0VlhBRDIva05sYnNtUmF6N2lLWnBVY04yWUkv?=
 =?utf-8?B?bThrcVROWW0zNzltWms3K2xQSXFiTjBOdXFMTXB6T1AyYUtPMmVmaVRrcEdO?=
 =?utf-8?B?MTkxSUhMOFBDUDhscUtPR1d3Zll4OVQ5ZFFwcUtwam45MndBMnpCL01EZjFm?=
 =?utf-8?B?QWhlU0pCRWpGdlphRmY2ZXVzc2VNR2ZBVzVrcm5Xd1pXUGNuMWZjVTMzT3Zt?=
 =?utf-8?B?WSt1Y2FxVG90amNqeHFwcEEyWlVWbjBSMW5KWitUblVKMDFXZDQ5U253bzMw?=
 =?utf-8?B?ZUNJM3hTUEZMeDg2WU84MmpybE5sTmw2QzNITXN5MEZmSlpuemJGSnU4SUZO?=
 =?utf-8?B?b3lvM0x5VWt5Uk1mWnVvR1F2M2cwL0J6bTBqY2xheVFFNWxrT0g1UmM1RHNr?=
 =?utf-8?B?RFl4akZrME4rd3ArWEt6WnhZbWxTT25oWXkrai9JZnVlaDVkdEphT09nV1pn?=
 =?utf-8?B?czdFSXJvbHpxQXNPb3A0akNEaWNxK2tMWThNSldyQnJBVUZvTFdwaFpmVzZM?=
 =?utf-8?B?dXhGUUlqNWhTZ0NoMzNOcGlJeVZjSmJ5MkNuK3NvemM1K1Y3ZkZoQkppWUtO?=
 =?utf-8?B?b2VZL21xRTZFVm5yUkErQVRiQmxBaGFjYS83Y3pxQkFGTHZqbm5BMkl1TTg1?=
 =?utf-8?B?UlhMZ1JyV0lWR0VabXZLclREK1lPTVRvaStSWFRuNkt6WHF4MmJRSk5jdS8w?=
 =?utf-8?Q?S0p7DsAhfAUw9glEwTwjkfJ1L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5c606c-e512-49d9-0d18-08dc4d9b4388
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 13:47:22.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vDshX4070UgiBY2U0CBC69mAYm20PWL8a4ReClx8c7WK128wxvPVGyBCQsUMv7QuXf942thyu7JzhJD6DKt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676



On 3/25/24 15:57, John Allen wrote:
> On Mon, Mar 18, 2024 at 11:46:39AM -0400, Yazen Ghannam wrote:
>> On 3/14/24 12:35, John Allen wrote:
>>> Make map_bits_valid available in the AMD ATL internal header as the
>>> function can be used in other parts of the library.
>>>
>>> Signed-off-by: John Allen <john.allen@amd.com>
>>> ---
>>>    drivers/ras/amd/atl/dehash.c   | 2 +-
>>>    drivers/ras/amd/atl/internal.h | 3 +++
>>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
>>> index 4ea46262c4f5..a20cf615b83a 100644
>>> --- a/drivers/ras/amd/atl/dehash.c
>>> +++ b/drivers/ras/amd/atl/dehash.c
>>> @@ -19,7 +19,7 @@
>>>     * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
>>>     * respective interleaving is disabled.
>>>     */
>>> -static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
>>> +inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
>>>    				  u8 num_intlv_dies, u8 num_intlv_sockets)
>>>    {
>>>    	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
>>> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
>>> index 05b870fcb24e..4681449321de 100644
>>> --- a/drivers/ras/amd/atl/internal.h
>>> +++ b/drivers/ras/amd/atl/internal.h
>>> @@ -239,6 +239,9 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
>>>    u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
>>>    u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
>>> +inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
>>> +			   u8 num_intlv_dies, u8 num_intlv_sockets);
>>> +
>>>    /*
>>>     * Make a gap in @data that is @num_bits long starting at @bit_num.
>>>     * e.g. data		= 11111111'b
>>
>> Ultimately, the maps should be validated as soon as they are gathered. I
>> figured we would do that later. But that would wipe out this change.
>> And, after looking at dehash.c again, map_bits_valid() isn't used in too
>> many places right now.
>>
>> So I think validate_address_map() from the following patch should be
>> done for all modes first. That way we don't need to add and then remove
>> this function from the header.
> 
> I'm not sure I understand. Are you saying that we should just move the
> map_bits_valid function to map.c and then make the map_bits_valid calls
> that are currently in dehash.c to validate_address_map?
>

I mean that the maps should be validated once as soon as they are
gathered (in map.c). This would happen before we get to dehash
functions. So we don't need any map valid checks in dehash.c.

Thanks,
Yazen

