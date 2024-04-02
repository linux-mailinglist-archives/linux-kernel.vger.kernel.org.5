Return-Path: <linux-kernel+bounces-128295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087F8958F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DB91F21C63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228B132C1E;
	Tue,  2 Apr 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zKdZL6S7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D0131750;
	Tue,  2 Apr 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073297; cv=fail; b=povvcXrHCpXja3gRXu81su6smfohcyNW69MWlR7jpM9eZfPZNCqdZb+YYzdbarVNPYIFA9MRw9TKQNl8QBeK+hL4gyiAc+4AsK+CWnnRIdCvoYG7z7m5gCRFSc06T0VzNn33SNIs6GgtVRhUdQrTDYyxWQbMqpv3NGuifubh/Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073297; c=relaxed/simple;
	bh=l8p5oHlSDKTvR+0QDJc6G0cc8Ol0v8foa8ysC7UDxlQ=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=KuBiKvZBzecfeZGDKFbro8J4I+Do2gbhwmtpRZwekm5Gp/OKVmQEy9tBcxM6LuBAUq7B7SwDg/jx+IghUB5bN1f506/OkO/vlRBDBPFYmLgWKva+vvRwyGC3cx9S/5UD9R3NaGzt3nBuW4BDxKBaFKy3FvNnLH9oLH7xXkHz2xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zKdZL6S7; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISkVgGWwVHy10wCPgsKsT68mKdgOXZTGaH3e1yXMzJ7UGOa0mHXHgbynK/tWPLepoHXL9OMviZyD3hPcMOljdu7iLInpY59fK2pRGBu+alEbmgW+epoWeUW4rivOnCwdFuXk5eJ6JowkTziySVVkdS2vessVDCvkMZHYwfiZfzkm5gDeUeu4++GrxZcezcHo43nTVufeKX916TXOEg3iNaaHvdaRIx3NBu1hbeaewnM9RlyDErk+70Lz4fk7yWYDdSxS4wXuySVnGdaBh5IFF6AoOp4vWtoW+umtxm4uUOh3htYX0PGsjUFzFFi9DyvbSl5julnd+9L2nZKwaNDNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJesKUHa5Ed/cZ/FAXhBzw2EV0M90lpkyMVd1BZQBmE=;
 b=k7+xL4IJDbyb1jzYzPsfu3kW8aTtTV1V4BVGY3m14gnLMgWix/aviRpnmEnXT001Dlw9mbZX2stmBwedncwaVE9DkNQ4PqKpViP2O5nMHSrkdX5JprXFuGFvt+AeHvWDy1zW6dIcoxZFjGeV7jYz8cQslm1jgGzLFUWlitjRm5Md76RInGTN/x5qOa+8+Ql6H0eMDo23QjvxFj83+o+r04uIhpT3xt6NMiKtNwShB5EkfKufD19/IEW1efJllgSQTGnNeoPpj1lyMAs8LPPlvknxo05Xr3K00Ng0VKVy17siG8na+Kl8A1qc0ATvP5A3535muZRRwRoKUUpKxwvDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJesKUHa5Ed/cZ/FAXhBzw2EV0M90lpkyMVd1BZQBmE=;
 b=zKdZL6S7FMHmsZzG2xFYIU2YkKqz4qZ1JMmixKJvvQYFF1mv9ERciJvu25UFHQ2hOpESsgOUMPDQwdwfiPzIVzSMLEJOZ6uv/oW22JAnJCthNMlGjV48zEm0uW6VPWYpgqhXafvqg+GMJe/UrdAvXUDTAUrHrNKy+XIHcO3QEVI=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:54:52 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:54:52 +0000
Message-ID: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
Date: Tue, 2 Apr 2024 10:54:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: bp@kernel.org, ashish.kalra@amd.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, michael.roth@amd.com, x86@kernel.org
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
 <20240402144547.18869-1-bp@kernel.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
In-Reply-To: <20240402144547.18869-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:806:23::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA1PR12MB8120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R9ujPQFUUNNmdq1VHHhet+sFO5DUbGIIOq1TGFkXSvtuFHLmjP3FC5ef2YBVKkNewdmSZ0WHSBkGQPT2zE6TfdD7luLe0aKm2l/OMv0ZYdWBOYZ+0a1PkeaqNOqvXdWbFUegaym1lheQIYgRXLUgeS3138KCrJzYHKLYMt5zn7M0gwGnazvtw5DOOJE0T6u6TtvMrAFAVn+cmqF+kEoFUnyzR5xZT/nCI6J9+zOK33HhKdunNQdk0Rxh8qm/yINMPLdrO6iBJsN8Ppr8T8vKyjinbzxp5XU9PXEwr+FqYfLEHdi0Iftf8EbKBq8Asc04nZXM4i11c7LgZEewZPYGLpDU1HQPhiFXI+yIe4C27pOK6kIC/s2n/BBsYtpirFWikr209vHDnmU/HpfyRFAUQ8JOofa1Cpg6mCgyCLJDvu1vTMI8Ycblng+4tVgRf4VfBDj32EtaMYFTVK6bPpE2EowKQly/VbZwwkwkiM6NviSTHeYQouWTj9DZFM0vJwTVk7SSu+cWd7hIskWacJ38KMp1m6jPc4v/SVjRTqA0vS+m3UFGrc2O/vpNc/91yt3N3O03YrhsaiquF0GxVCDGtslmMaHtSkQRI0D/0aGjWU+QCyZ6rPmJ7XrHqLhiYLgKtq0IyvmEcUzaCxzjdjrXsr3epEauQMJ/lAVihmaqcKA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzJVMUcwekxreTd1NzE4ZVpoQ3JVRXJRdUhDZm5rK2kzdlJVbDdxTkRtS1NW?=
 =?utf-8?B?UHJXRm5ZUjNrUlYwZHJnZU9aK3lPOWtGR3Q3ZWQ0QitMNm8ydWRIYldQaDVt?=
 =?utf-8?B?aGRoRlp1a1cvZVdvWFFFYndDNTVIYTlNaE8yQ29kTDlROHRUbkRTZUlOTC9Q?=
 =?utf-8?B?ZVpNZUoyV293alJLSnZ3V1U0RXhZZ1ZPUUUzczRCRHA1eWlleGo4VTBaYVhh?=
 =?utf-8?B?alU3VDhiZzF4TjV1Q0JNNUlkN000Ymlsd3dwaUJCd3JBNEJ5bFZBRmhmcWMv?=
 =?utf-8?B?b3NUM2NYMWJ0TDk0clRzSnk4NTZGRnNnS3ZtUVZoNTd4V2lkZ0djckVHZUQy?=
 =?utf-8?B?YXVrMnVBNlRTQmpHeHI0dW9rTWNoZTFtWktxbmxFOWYrRmtIbWoxQVhhWXNL?=
 =?utf-8?B?cDhRYTlxbFhleGNneUJ6MlNFMlBEa3VKdEN2Y0VSdnZKM014ZkZpN2lIQ2FY?=
 =?utf-8?B?WExabDF6QnNHdWQ1SHoxakh2Nzkzek1JRDU0QXpqYnlacnFpM3VCOXJQUnFP?=
 =?utf-8?B?VUMzVmlLZGkzV0lOZkRkYVljb2VjQTVObTgyODY2Q0U4dzRVb0o5ZFNwelBm?=
 =?utf-8?B?MEw2dFBsclJ3eXJqSHlGSFJJcXRwSFNrSkNiRXRodWJmcXNkRXhzWFo2RGJL?=
 =?utf-8?B?OENWWkJPdG0vOERBSjlEWllYUWdxVEF4WFRpaUJ2SkRyYkpFNTBCK3pzTG5n?=
 =?utf-8?B?eGdmeDBIV1d0Vkp6Q0IwN1k5d3hRMm1NWkx2WjU1NUlGdktvNkYvZ2dlaTBj?=
 =?utf-8?B?K3ZhbTVNNTdUUzd5VTdXTkFXRGM4Nm1yanQ5TUs3QTExd3NoNlB0NVVRYjlp?=
 =?utf-8?B?QVE1NEx0ekdFNmxoWk9Rak5YZ1E4bWJlNC9vak5Ja09xRG0xOFZVMzBtYm5n?=
 =?utf-8?B?V0xnZVRHdTBYWkRKb1p3ZEQ0YXdiM2tQWFhJK09lb1FEWVdZaHNLTllGV050?=
 =?utf-8?B?c09TL0doejZocDB4WjZVWTlpdjIzdVFEcERDQ2xFSnhaS0E2NkYwS2YydG1n?=
 =?utf-8?B?S1hvbXRWajJxQ1pCZnpiK1YvZU5JdCtRWnE3NndHNktCQTJsdVFrWEdDMStm?=
 =?utf-8?B?R3F4VUR5SjZHc0U1a3B2eUllZ2Z2MnF2Z2NENzAzM0EzOWhvdWw3aUNaZGpY?=
 =?utf-8?B?OEpkM1NSWTdXL0JWd2VWek1QMVhzUU5NSnRzT25sQ1VPTUpWS0lUdmVSUTVT?=
 =?utf-8?B?VkExbmF1cTg2RUUvdTZrQWRoZG5qN2QySUl4R09rdkRjQ0dpT29KbWZKOGFM?=
 =?utf-8?B?WmV6WkxPajJaTlZZcmhVZTdpZGFQTnZMa0U1RjZqcWVOdHZqeUhrMlpidThm?=
 =?utf-8?B?YjdyWlBKRit5RFBQelJvRzRwN242YjVjMkc1QXdEN1pCMFh0ZGt0VU10aWk3?=
 =?utf-8?B?UE9Uc0pJdW9NbS9lQ2dwOVNKZG9JZkNWall0N1N0VDBmRk1LRDZqbThsZndt?=
 =?utf-8?B?bVlGL1NVUnVGVC9UVEVQVFh4RGR1NFd3M054bm5yaTZLazdpN3BVUVdKdGhw?=
 =?utf-8?B?a2pISER1SVloZkZiVnM4bVUzU0pHb3o3S0FlekJrQjFxUDRRejlzNlRUSkNE?=
 =?utf-8?B?UjdocEpNWkJQaHlid2N6STVicEU2bHFuSElzYkpjOFFjeFJnYTZRNGhOKysv?=
 =?utf-8?B?enFwU2VWUVZGSE11ODBOWWlyaUNVZWFtQlV0Q2hwNzJyV0xtUC9OMGdCSXNs?=
 =?utf-8?B?ZkJ5YkU0RXllNk55NEZnUlhlNWRhV0FZR3JKWXlFNXBzR1pNTllPZXpCWGJX?=
 =?utf-8?B?aGhFWjMwWGdEN2FQVnBjcU5PdEE4Y3c0Qzg1azFENllUcEhkSmRoTDV4VW03?=
 =?utf-8?B?b0YyelgwQmx3UytlZTg1R0pPaE1iYlBwQ0pVRWY5SVlPOWdwMXpFZzlrY3dt?=
 =?utf-8?B?VDF5TmdVQU94am5iY1RoZmQzdDlrb2c5Tkd6YTk4d2doQ3NNNkp3d0J2T3hJ?=
 =?utf-8?B?eGM4Wmw5SnJGUWdCRXJmT0R0SzZ0cUNHT2JFZHBYSlNEb2RCeWhjczJuUVoy?=
 =?utf-8?B?NHcvOEc2YVVpNjVrTUJFanMzcEhWV3ZHM3pxTWdmZVB0OHpEQmJrcG1vM1p1?=
 =?utf-8?B?eW1HVUlLY3N3TmFaM0Z4ajFINVAyWjFJMkVHblRPZmtUVG4yVTRYa3V6azk2?=
 =?utf-8?Q?W3p+ch43SSQvmtlRILA50akmc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6a692a-221a-4fa4-e273-08dc532d3c10
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:54:52.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wg6z3XEsBOkpyX6e6YrSQ46a+FmulofJZex3QzxFVxoE11raw/eqVU1emQfApKY5JY+y+Fm3MWjwS+pMw4gWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120

On 4/2/24 09:45, bp@kernel.org wrote:
> From: Borislav Petkov <bp@alien8.de>
> 
> On Tue, Mar 12, 2024 at 06:47:57PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> RMP table start and end physical range may not be aligned to 2MB in
>> the e820 tables
> 
> This already sounds fishy. Why may the range not be aligned? This is
> BIOS, right? And BIOS can be fixed to align them properly.

There's no requirement from a hardware/RMP usage perspective that 
requires a 2MB alignment, so BIOS is not doing anything wrong. The 
problem occurs because kexec is initially using 2MB mappings that 
overlap the start and/or end of the RMP which then results in an RMP 
fault when memory within one of those 2MB mappings, that is not part of 
the RMP, is referenced.

Additionally, we have BIOSes out there since Milan that don't do this 
2MB alignment. And do you really trust that BIOS will do this properly 
all the time?

I think it needs to be checked and mitigated in the kernel.

Thanks,
Tom

> 

