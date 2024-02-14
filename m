Return-Path: <linux-kernel+bounces-65372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4092E854C02
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABCCDB2132C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFAA5B678;
	Wed, 14 Feb 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M5ILZVgz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83B55C2B;
	Wed, 14 Feb 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922795; cv=fail; b=ObjOhZtJKrVLG1/h+JOhnt0/CtZSGLrhGmSPDm425jlXGj7nkIkxPO15GVqD+UtHtlAEuHnBkpLgWwJp3RbwmujNd/qEf2U1PFCkp8xT+CPCN5bPvn62vsK50JWY7PH5eeaTPoGGiKpL0LXK+K7h2V0CszM2FNmMo5ADLWZUois=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922795; c=relaxed/simple;
	bh=c4bPOy58t4DPY9aYeEYNLSNr+DsBF+c1F43W1Sb/PSQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3EQEvHNa27ENx7be7zyp9/j4tMsSr2aVQZeqqg3N2x2ZE9k6O+PtU40XqAyI6LadRyQ5PAm7KFe4UgYBtPwnjl+dSy4oHYovt2nZiJLTYxdPbKDKZavAOnXkKXdj4hgcyv24XiKfCXRp1+jC+yAKot90lvKZtj5pzY3svfJndE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M5ILZVgz; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwY24QKgGheuxS/rs0hDCjXTqVO8DV2MP4jmW+ssqxGJe3O+FQ9K2s7BXouGkSpHevQAzni5sy7eswObV0WNU+CHWWjwVyrYWhUnSJbyyY/waPkGemo6f5TfRACuIhL0u/0fgV7vK12hf5nNdydzOtO6a0AFA+YVkstC4UvJj+TVfQI5krVHNH/RtnUi0sW6qB7vaq7zJxcvrC7Yi/E0Bw4B9IT7K9sVRtBbHktkHZtDs8Rl9EvE68hpU7SUk0kzcYgCRfeZD9AQboHdtCkR57DtihcLHT9MviX3DsSj8TaPejdpqPh5EqUURZSVnobcOENuFLRhDrFbad8bp0xxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELIPqh9Mg2pVtUEcOe/GIUIjWsZqKtbgt5OXxs7HoCQ=;
 b=WaFlTelRU8QU/ptCRvisWIWkaWWyWydDW28DX8Oydyk6S5qp7eNUYOcE70Sp2JjJn0AC6VzfB132ol3KUirBBSsxofDLCpYyhUTWaifpiok0wWwPgBo0qmfgGIQnwoZNOaFZqibk+YsYErY0JVaS+jNbNQFwuc1Ono4KMhAnwXQSyu8Ztu/Bvfe1Uu4KTBYM2qd3mSU2dCsmg89cc0Y+T99+b1NGueTbpdk3g9dwUIfOb7B0oCyd0PHwu1W6hxmorcgWUeztSwxMGmrI6cbDveDGkToes3GwaDy/nhOyyGnOpLR//rKAJHPTDFrYqch7OdEtQh5n+BodDLhriLopKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELIPqh9Mg2pVtUEcOe/GIUIjWsZqKtbgt5OXxs7HoCQ=;
 b=M5ILZVgz8VaD0kOK9cZrMZ0OtU5T/yRgMhtvlH8XnLVU02PJPg7yKIxU/xbgv2MIzPPg9JcnedLgQDt7pw+1RK9ptPe4eWPepLkEFEhsniHDeYv6LjhTYfwws6xtOY2RS33ULoNo0j8u4hJsf6e9avbwx/rGXm1VAYjklJlks0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 14:59:51 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:59:51 +0000
Message-ID: <078a6305-415a-4c89-9c5e-096adafded1b@amd.com>
Date: Wed, 14 Feb 2024 09:59:48 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214111555.GHZcyg6y_CdpA42a91@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214111555.GHZcyg6y_CdpA42a91@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:408:f4::12) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: f24cc168-7cee-4c92-c44b-08dc2d6d9850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UkdXKoNlqWsN5WG6TT8xKpjK9lj2rmlXN1D5RBCzaxsDDGu1OoQ+T1nCZs/sjkOxcBauPu9eVEb7SEeeAzsIH3PtXB8VFmHm1tfK8HOrku3DCPXHvZvXEOJVcLX1RvWHDsC/ITni5X64/j/7ZdqtrzPfZRw1eHvIdxbh/iY2fxLysJOCsNyZOBZF1ZvnfeoSqvMYH6fXS9NCFMBolaWVW2ienFXTfCQyFW1OTdBQ1F+MkYtjnLBLVkgz80kwYpBfuQedAlvZ3HKE1Qijxvm73ImmPu8UYrXbS64Pps8BcEv7HtAkzZVhIUUIDQpDm1+hff1ckc3ilJDtocasftTm6cBYqDYPJJvilGGPn30F2N47K8XicleoFK1WQcTIHWCspz/BpVc0mhmRiZVdomCVLYrpZNzV2cPOyKK/sPGHjq15/RzX09w/sfrmlupSSw+TzSSdZedFPIHZEJnxNMu5P+fzkPQ9ihZz6cJo7F9ig2v5SMVzQK87rUa6w2XFHt5tFfhWXDc6ydFB6CdXnxLAn15a01AIuSWASBqM2B7NeHZg4BNSYqEuN307OELkp04V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(6512007)(6486002)(478600001)(41300700001)(66946007)(4326008)(8676002)(8936002)(44832011)(5660300002)(2906002)(6506007)(316002)(53546011)(6666004)(66476007)(66556008)(6916009)(2616005)(83380400001)(31696002)(38100700002)(86362001)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?US9EZEZrMTYyZGpmUndmQXBQUllKcjAyaWd0MkVZaTEvNjBIR2RTemJxYmZW?=
 =?utf-8?B?eVJNM1hETHU4cExlVCtZL2hjY2tvbGI2ODlGRkpJeXlVc05tQVZyRmlVKzlM?=
 =?utf-8?B?Z2hTUEVmNWpwMFY5b2w1b24wb2xiU3pBYVdwZjRuTTVudVQ0bHdCdzk4c2Rj?=
 =?utf-8?B?OC9CVEx3UlU1R08vZmhWS1B2bExobGU3bTZRd2pSQVgvR05XNDBCMDB0b2Nh?=
 =?utf-8?B?cyt5bXZOTDRWQmF5YnlBOUpRNVdQQmZhZFMycEhycThXcHBFMStGQ1h6TVpx?=
 =?utf-8?B?aXovNVRnNmVqZFExdC83M3lJWkNQaEIzcVhpeitCVTlPN3RWVWNmMExkeE5T?=
 =?utf-8?B?V0tQR1F2VWtDOWtYcTR5N0tVV1h4YmQwdmxXN3ZrV1FYMDJlY1JaaDRubHpj?=
 =?utf-8?B?bVkySXZpS0k1U1cyL0FOSkx0OUx4S1FFemY4eTBRTCtHQndmOWVCdEhEMXkr?=
 =?utf-8?B?UGR6Vjh6UDhHQXhNNE9nZXd2bTJ2Z09VdU9waytTN2Y4Rk9BSFhZZGlWTGFl?=
 =?utf-8?B?OEd4VDJUbms5OGIxT0lpZmpQcmRXSG1SZzRjUzdoTjlxT0JKbGlNWGRxNTcx?=
 =?utf-8?B?UGttOW93RlN0NEk0OUJXa1VPT2VoeE14czdCRUs2WDlqcy9ZT05yY1NBSDRU?=
 =?utf-8?B?aUVFSjBVL1lVbmFnejVrMjBENmd3U2JiWWNiNXVRK3U1QnpwdTZ3NnM0ejh1?=
 =?utf-8?B?M2FwZWlOSWxhSmpMa0pjaU10bG5UWWJUZjVTUTZkN29tZTRqdDRpQ1Y3K2hB?=
 =?utf-8?B?RG5nMUhlZTBVbm5QS3FyM0tuazVmSlh2U2pHczQ2dlhYbDZoNFEydFJNMjVa?=
 =?utf-8?B?N3l6bWpUTTdyei81cjEyWTFrcnk5YVlWa2drYnkvY3c3cStHQzFFKzBTQ0cw?=
 =?utf-8?B?RG1pNUt6ZHJoUWdNWHQ1RjNRUW9lNU1YMy9CYnZvQzNqK3ZLRU5reDNwbUpI?=
 =?utf-8?B?UUswKzNham51cEJxQ0FwNnIva3gvK3kwWjdIaDhwcTlCT2E1OXd6RFR5ckV6?=
 =?utf-8?B?TlB5MStiS05yT2M4K2d6eWw0Vko2d3V4YjdUdkJPSFZIaVNXdDRxOG9zSTg5?=
 =?utf-8?B?MXNmMlBnUTVMTzhHQjQ1R3NxM0xWYWFBT0NjaTJBRm5GUkNoMDVzOVBMd3M4?=
 =?utf-8?B?cGJnMjVzQmNtaVVIUXVTRkdzNFVRaUowZHBtMS9kSzNCYTFERjRKSDhGeXZU?=
 =?utf-8?B?ZVZ4U1BtUERyY0JCYldUWE9qYTd0aWVuYjRXK3RRSU1MWkZJVmhsTXBLV2VN?=
 =?utf-8?B?ZlZRMXdDZkJxY0hISi9WRDJobTd0L2VRTVNJNS8wWHhIcmJmTk1oRHZ5T3p4?=
 =?utf-8?B?Ni9RbkQ3djZZWTZIYjNSNXEyR0tVWE01cGgxZ1c0QSswNkdjeUdJM1loVHpz?=
 =?utf-8?B?bCs2bW1BTWZzWXh6RXNud0tDcCt3OWlHcTZPRzJ5SmxEWldjaDFsT2kzSFph?=
 =?utf-8?B?SjlaVk11aFhGbnZ1bzZJLzQ4OUpQWWhDTHhocndzaDRzOWN2bXhMd2VqakFu?=
 =?utf-8?B?dWMrRkgzSGVRZmdGSFZ4QmNuT0hlcHlHMW1tcW0ydFk0elFLRmVYN3ZZNmlk?=
 =?utf-8?B?TFN4V2JscXhBdTJWNEpkS05jMzE0VHlpRFdXSTlQSWlLYmN0cDRhUkZIOWg2?=
 =?utf-8?B?SnRDVXlqVzNkSm4rclBGZTlWRkdMclRtUnRZK09xRHJ4MjFtMTREUGVPNWpp?=
 =?utf-8?B?QVNKTklpSjNpc1RtaHlNOEJuUk13SWVkMnNJckQyL1FpWi9LaUN0UTNUeGto?=
 =?utf-8?B?VWNJUGhoMG00bTNlcWRjWERsdHRsNmxDVEsrcVlUdE9aYjgzR3FzQXhST1pC?=
 =?utf-8?B?NVdqSWVyejBVVzdNVE12Qzk0T3NnS3V6NTlDbzF6WWd5cVBnM3VxQ2VaNlVE?=
 =?utf-8?B?MElmcmVzSHZwaEpncmk0Nm1DT1RDL0VSRkVaT3UrNFVUN0t2MDF2NFpjVUxx?=
 =?utf-8?B?QjhFQWZhM1NqTDJrQlovMnNqWFQzcU1WTHN4emR6ZHh5eUdFYk1UQ0U0eGZh?=
 =?utf-8?B?Q0lsWXdqdG4xcmwvbG5sRUVkY2ZkNTh5eWdtUWdTYUNxSHVKaFhxWmZVVHE4?=
 =?utf-8?B?dnZJWXJkZEZpdjd4d0xqazJEQ1hWb2NSMUZWNGQvTWtvS2kvWkhjVjZOUnJt?=
 =?utf-8?Q?1rxTnRlEdtamYh05/H7tp6nKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24cc168-7cee-4c92-c44b-08dc2d6d9850
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:59:51.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5ESt6lo5jnqkGkQ0Rf8W7AjV7Wi/eZrllLs02VKg0Q9tC4RqWKYbQLdQoPer9VKR1q4z0hPQ/zuqpA2JeOvoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155

On 2/14/2024 6:15 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +static bool has_valid_entries(u64 valid_bits)
>> +{
>> +	if (!(valid_bits & FMP_VALID_LIST_ENTRIES))
>> +		return false;
>> +
>> +	if (!(valid_bits & FMP_VALID_LIST))
>> +		return false;
>> +
>> +	return true;
>> +}
> 
> Rename:
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 090b60d269e7..3da3f40f1efe 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -221,7 +221,7 @@ static int update_record_on_storage(struct fru_rec *rec)
>   	return ret;
>   }
>   
> -static bool has_valid_entries(struct fru_rec *rec)
> +static bool rec_has_valid_entries(struct fru_rec *rec)
>   {
>   	if (!(rec->fmp.validation_bits & FMP_VALID_LIST_ENTRIES))
>   		return false;
> @@ -286,7 +286,7 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
>   	fpd.addr	= m->addr;
>   
>   	/* This is the first entry, so just save it. */
> -	if (!has_valid_entries(rec))
> +	if (!rec_has_valid_entries(rec))
>   		goto save_fpd;
>   
>   	/* Ignore already recorded errors. */
> @@ -397,7 +397,7 @@ static void retire_mem_records(void)
>   	for_each_fru(i, rec) {
>   		fmp = &rec->fmp;
>   
> -		if (!has_valid_entries(rec))
> +		if (!rec_has_valid_entries(rec))
>   			continue;
>   
>   		cpu = get_cpu_from_fru_id(fmp->fru_id);
> 
> ---
> 
> and this one:
> 
> ---
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 3da3f40f1efe..813cc6a4f435 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -255,12 +255,12 @@ static bool same_fpd(struct cper_fru_poison_desc *old, struct cper_fru_poison_de
>   	return true;
>   }
>   
> -static bool is_dup_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *new)
> +static bool rec_has_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *fpd)
>   {
>   	unsigned int i;
>   
>   	for (i = 0; i < rec->fmp.nr_entries; i++) {
> -		if (same_fpd(get_fpd(rec, i), new)) {
> +		if (same_fpd(get_fpd(rec, i), fpd)) {
>   			pr_debug("Found duplicate record");
>   			return true;
>   		}
> @@ -290,7 +290,7 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
>   		goto save_fpd;
>   
>   	/* Ignore already recorded errors. */
> -	if (is_dup_fpd(rec, &fpd))
> +	if (rec_has_fpd(rec, &fpd))
>   		goto out_unlock;
>   
>   	if (rec->fmp.nr_entries >= max_nr_entries) {
> 

Okay.

Thanks,
Yazen

