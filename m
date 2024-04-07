Return-Path: <linux-kernel+bounces-134505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B9189B24F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C468B1C21161
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677773C6BA;
	Sun,  7 Apr 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JwJerti/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2121.outbound.protection.outlook.com [40.107.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E93BBFE;
	Sun,  7 Apr 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712497282; cv=fail; b=RX7aWtind0E/pfOvjqzALFIY8vrOnTzbqGJOHG+jCKyp0pjVtx+2cpZnQZA/fv0UDWiT+qZIAj5wB62aGBKwOVdXzPacqedX0JF72Swbbya8YDLekyKltTp7oG461z5sEv5ldr7O4xIj4PydowNVChPeTivhbImHzYEnAB8PCPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712497282; c=relaxed/simple;
	bh=f+jwZy7SmhqUGMDpIq4K8Kp/gE+NUejJ5U1A9XZAhls=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bOx8O66jhLHMQjuaxJfC6uZzfPs74ZlC06rYqFgIArOGIaE6rPHU+GnP8ClX+9m+v6dHwnp1UPjUjY9YSwYDiJeImKSEKqrU+i5FxhtxOfeJFtegWzVmNX+bR7TfCkFYHAXSxOCD9M2Bm7rC4u8wz1uR5GczOgG5AZu5XgytmW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JwJerti/; arc=fail smtp.client-ip=40.107.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUcAx44sjnMCiXSM31dkVpLnLV0FfNb5Zx/apnkv14Gz8FRGVGymo5ntPk0PcctGODVfSuW07cb6tzvdesJk5FaalJWe8RJniAnrNmDKgRhQOKPW8EacQCGAY84siQuHwa9eWYZ1OAQyeO8U+w3Keb2UvivDPZb9YZMbopK9VNpBgP7eBkVdNWTNGzgzbc7Gf8LH5UT/WtSDVQ0LmPFfErHcAetiwiAzV7V/nbvJI1TPU6/L8nkQfiO3/cALdk2vwcFCCIvFCNhCqIGMVW94S9VWP9sqFdW2lyrYtCiXqocJJepZYEOaDN8LshTUlkZHxvEwz1Pi83VQLQ7R5PpDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haQ4ALnzqSPLGd1tLgU7PX80bOEBqWr8dtL5OCwmAqI=;
 b=Bxa7IUy5gJQ1Ihvk4wTHJkX7POkcs0g7XkZyKlf30I0SEQezY+g9N+T6hnIe6zosFnim6bJvyxbLZOTEpvqoNDpfzV2CBoSAticylDWCBuov3BbmuW00o6IZ6ggsV5lTODVQdqPfLtFuKkg55ykVLLkYeDkFEOUmU8FjZFn7thNk/uixRjOd0JClYqAsaSyhIumqgkS4io6epPF8Fi6XE5Xj4V3nDrq+6dCeJ9Hx5MXG2ekJe2V54/Hp3b1TMg9zqS0syKgsAm/Mh3QRjDrsgPDjUkyYV0pZ4zC5a2Watc3MVGRLP553xXzVyQjQkph/xchmafaeafoaDYLMdOvrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haQ4ALnzqSPLGd1tLgU7PX80bOEBqWr8dtL5OCwmAqI=;
 b=JwJerti/BvePOnQOlWNnnAAJQL2+wPqw9jC8uevF5HTAY0j4No2zFiPgAH0IqSV5a+icksAEP5uZsWOsKuQjWjGgf6Yux6JNwZF7bZSEHrsZje0XyMgsX9wU5xaw0EXzz/H2pkdUrXeyuU7WWKvo1loPKOw1Sv3XhVbFU950FHM=
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 13:41:16 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 13:41:16 +0000
Message-ID: <7091aa90-f924-4d71-a127-9cee9941c1c6@amd.com>
Date: Sun, 7 Apr 2024 09:41:13 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: PRM: Add PRM handler direct call support
To: John Allen <john.allen@amd.com>, rafael@kernel.org, lenb@kernel.org,
 bp@alien8.de
References: <20240326212640.96920-1-john.allen@amd.com>
 <20240326212640.96920-2-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240326212640.96920-2-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0587.namprd03.prod.outlook.com
 (2603:10b6:408:10d::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB5855:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rwyZ8BJQX/w7x5he5uA1eVEhKvY4bEZpiNx3UuzJUuibCw/tEk+U4b9j5JeEl29vsHHAfS9uw2pddkH0yGWS5Z+n/zjSHBIKJq0CPGmd57VFKVvuZTS8DyIrV1JfmRNPI125PxU08GBmBxDH5khULs/o914itJP/YCoFbvyE3Tb+OHD/WPdLTFjmyUVAfI/R/G9drAfBanABo57CVb4t74UlnPpx6GL01RzCIRXSn2ZRHv4aMbBfB7vVetY0pbLhYoy5biiNAeixYuFLSk6Vng3OvyhSVrO3jehMDMSf+QBlQZ7g+kVvVkolzKDYXQc6213+TtYhUFZS3GrXgIT26kmcOnAxOTEVfqBfRQjPi80hdu2QA+wzC1yde7trek/wWUgPxwn6MqHtC+1MSIkmjQMOjQdWQxbfCYXXIumZcA7EzeJOtWEmVd9evuFgyaRF0AoJTutWvYkJbNEBoeV3miiybFauzU7B2H/cy982dUDzaL6j9+6N7+gDlPvj9+AEGb6mf7RulkbffYWkkPRtcfnrOb+IGXGc+jomW+QhtTfK64RI3DxZcwtUNMgC26juJOGIvUE6HlSjuHOnK1zAbC/SMR19W6l2LI7//vcRLVHPmyMLVi0rYXnitK8m/+pOn/ZDMtZZFQW3jH++5Y9MjWA0bVTpMqRA5TF4/Vv4B+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDIzQzRnOEJYL0M5NU5MVmZmL2lDQVd6YnRJaUJzTytSSnNUemhmVU1ld1kx?=
 =?utf-8?B?NnpES2pkT0JSbFdiS2YyOXBXRDVUd2VLRXJUZ0dHZzVLNEJjaENqbDg0bzVE?=
 =?utf-8?B?a0h5K09uaVBNNHJKWTBSTXVRNXFHOU5ETHg4Sm4xem5CcFJVdTdib0p6Z0Nu?=
 =?utf-8?B?cVBrUFpGM0NYMU94UEFxWG9CNDg2dDEvWDl1eGptM0RsUTVFZ1VJQU54R3JI?=
 =?utf-8?B?S1VJdCtJdlFCYlBuQTFYeXhBMDJrS3pFYWtrVzN1UVcrK1VIMHpVdmp6WEpa?=
 =?utf-8?B?UFFRVThiNU1RS3hEbVZ2Titkb1NObWIzdCtuZW5FSDFsSEdlMDJrM3Awc1ZB?=
 =?utf-8?B?OUdWNTg2c1hwYmIyMnVFSmxiTzNZektLQXhIVmhZSWJEY2cyeSsxK2gwa0xr?=
 =?utf-8?B?ZXdSMStiR2VhUDlFWHA4NFNaZmN5SVhxTVpJOTl1cUVnbnRZcU5EU1BaUUhv?=
 =?utf-8?B?b00wYVMyRVdwaUppK3B2TFM3N09EeFordVpLV2lqcldqczVVb3JYMjVIYUNH?=
 =?utf-8?B?VER6TXRRRGJ6R3BBK1ByTmN5MnpPaDV5WitWWVQ0ZkNtdW04TzFoOFMxcXU3?=
 =?utf-8?B?Z1hPeUN5cVl4a1JaY3NHZ3RDNHJScm52VnlhRVBYNFNkSjhWUmx4cmRnNENo?=
 =?utf-8?B?WlNQSFYyNXFHNXArS0puYytSQk9WU3E0TnhBdktPU2tPTTVmUDZEK3B5NnFS?=
 =?utf-8?B?dk54WjVnMzRMSlJGQTBJcEVDVEdKOFpKU04xVXBBNzVydjF0cHBNQTlOQUhr?=
 =?utf-8?B?MTAvK1c4Um9tbEs3WXlVU3ZTcUU3ZkFwVlZQNEZhVy9kSndVNFhxcGsvaDZZ?=
 =?utf-8?B?SG9jSGJYUlBHTktXa2t1UGlidFR5RURXcG1hVG5LSFhsK0JHaFJaeER4NFFR?=
 =?utf-8?B?VkEydVpreXoyT0JkdTJJWHYzV1dsL2pNaXdxNHhDa2E2bXIzWFJZWW9lSGcz?=
 =?utf-8?B?RHJKUENlRWNGSHVTcmc0TDMzQ05oQlRVSFFiN2NEWlYzMVYwVmJ6emJ3WmtH?=
 =?utf-8?B?RXBRWWl5NnhXVWFIdjludVVBSkZPQUJzT1JUM043SjEva3JLTHhjemw3Um16?=
 =?utf-8?B?Nk1yNlgzNWsvdjNJWDBWcHpOSkcwWmY4alVFUmxEaGxOWFRXcC9qbStRV3lB?=
 =?utf-8?B?cXVYbzVYVitvaGF2Q0ZtSE03RGM5bnJOdlpldFlmNDRqb1pLUDBaRVdUbGta?=
 =?utf-8?B?WCtrdjdtVFJJQU5CZkJIUVFCMENsdENSZmpkUXJTVGwvb0NTckRrcTNUOXhj?=
 =?utf-8?B?bFJjQ1U4NVVHTjZXcW9ydXZ4VEpiVWd4MldiamE5cTVHbGFLUTl2Q1FSVU9t?=
 =?utf-8?B?aGJhOGJtVWI4U3d3VG85Um9IV1hDaWpEU3RhcnMzeFpQbUQyOVlPalk4RkVZ?=
 =?utf-8?B?cHZOdll4TU9XTmlvcFJ2cndkblRhU2p2L2hoUnc2cXFmU29SdzhWR25odHN3?=
 =?utf-8?B?ZjV5OUpaOHV3SlRCMFhUb2pBQzljTHZTNmZ2K0JFZms2ZXBGQ3JmdkpEa3ZL?=
 =?utf-8?B?N3plVWVOdDBFS0lHRnBLTzkwTG5xYlZ6TTFrM2djSEx0QmlqZUptczk3U0hT?=
 =?utf-8?B?YkJtNTRodFhJMTBaeWViYTBTQTVLQTBiRFBwV0x6YzFKblZOcmJhZUxMVHFM?=
 =?utf-8?B?NEFCL280MWZwVlExdzZhbnl5MnEwTFpGNWFQa1V1MVQxY2lmOE1SSVVHU0dl?=
 =?utf-8?B?OFdzTm5CSENMZGJLcThhYmUxRWZtNEpTL1N4bEMydXUwNmw0YXlEQnlSNXFr?=
 =?utf-8?B?WEFMVUdWZ3dNcFhsRXZQK2h2YzRvNTNPcWt6WUpoaDZ6aVV5ekExS2NxOG03?=
 =?utf-8?B?Ym1pWVpTZGRHVm1UWVpHeTQ0Z0xpaVZ2d1V0RlNIR0pXeENDWTNKVVozbTlZ?=
 =?utf-8?B?bWNIMWtqbXZiWUZTUWhIY2hsVElML3BMeEtmYmNOb0hUQllCUnkxL3ZCWEZ5?=
 =?utf-8?B?QjUxcXhITUF4VXplbUFQT0kzWGhINVRuOXdRS2FCZXlCU2w0TE1RM09mTDhW?=
 =?utf-8?B?dC82ZXdaZmFIbVQ5T1hVNUhpSjRyOVgwL3YyWDhiTUhCVDRPZkw5aU9aL1NR?=
 =?utf-8?B?MHRBS0pkMS9DRno2NXMraGtJdkROM25vbmd6aUYvUjFNRFlWTTYzcG1hNVNu?=
 =?utf-8?Q?4+DWmh6AuPE+4U9ke0M/FQEhR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb80a9e-6edd-427f-4fbe-08dc57086611
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 13:41:16.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6h7aVMpv9Pvc3f8fvL1+iliUUVeTW6ASVPxZnvnrt488uafvoUXi3IdW3f3GRFSfsFDbNJ79JL8MPqujcDCiqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855



On 3/26/24 17:26, John Allen wrote:
> Platform Runtime Mechanism (PRM) handlers can be invoked from either the
> AML interpreter or directly by an OS driver. Implement the direct call
> method.
> 
> Export the symbol as this will be used by modules such as the AMD
> Address Translation Library and likely others in the future.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>   drivers/acpi/prmt.c  | 24 ++++++++++++++++++++++++
>   include/linux/prmt.h |  5 +++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index c78453c74ef5..9e548426cc22 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -214,6 +214,30 @@ static struct prm_handler_info *find_prm_handler(const guid_t *guid)
>   #define UPDATE_LOCK_ALREADY_HELD 	4
>   #define UPDATE_UNLOCK_WITHOUT_LOCK 	5
>   
> +int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
> +{
> +	struct prm_handler_info *handler = find_prm_handler(&handler_guid);
> +	struct prm_module_info *module = find_prm_module(&handler_guid);

I wonder if the module revision should be checked. Maybe this is a
future problem to address if/when the need arises?

It seems like versioning can be done a few ways for a semi-stable
interface.

1) Keep the module GUID the same and change the module major/minor
revisions as needed.
2) Give the module a new GUID every time there's a change.
3) Keep the module GUID the same, but change a handler GUID if the
handler's inputs/outputs change.

I think #3 would be the way to go for most cases. So the onus is on the
caller to have the correct handler GUID. And no changes needed here.

Just wanted to write out some thoughts in case others have feedback.

> +	struct prm_context_buffer context;
> +	efi_status_t status;
> +
> +	if (!module || !handler)
> +		return -ENODEV;
> +
> +	memset(&context, 0, sizeof(context));
> +	ACPI_COPY_NAMESEG(context.signature, "PRMC");
> +	context.identifier = handler->guid;
> +	context.static_data_buffer = handler->static_data_buffer_addr;
> +	context.mmio_ranges = module->mmio_info;

Minor nit: I suggest aligning these lines on the '=' for easier reading.

> +
> +	status = efi_call_acpi_prm_handler(handler->handler_addr,
> +					   (u64)param_buffer,
> +					   &context);
> +
> +	return efi_status_to_err(status);
> +}
> +EXPORT_SYMBOL_GPL(acpi_call_prm_handler);
> +
>   /*
>    * This is the PlatformRtMechanism opregion space handler.
>    * @function: indicates the read/write. In fact as the PlatformRtMechanism
> diff --git a/include/linux/prmt.h b/include/linux/prmt.h
> index 24da8364b919..9c094294403f 100644
> --- a/include/linux/prmt.h
> +++ b/include/linux/prmt.h
> @@ -2,6 +2,11 @@
>   
>   #ifdef CONFIG_ACPI_PRMT
>   void init_prmt(void);
> +int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
>   #else
>   static inline void init_prmt(void) { }
> +static inline int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif

Overall, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

