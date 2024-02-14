Return-Path: <linux-kernel+bounces-65370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81540854BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC41283EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B55B5A2;
	Wed, 14 Feb 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DCjvrDQV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0635A7A9;
	Wed, 14 Feb 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922671; cv=fail; b=h9LQIsSlVmh8T59YEDFxph7Xyzic3jrxuYpOqttnkSHCAR3muA4nOII5cSG+wrDqmRy9WiSN+qlQQz5sNv4QokCDRVmLy4aRDGrpO32vwAfv4qgC+1JNYLgiOJ/GAi+6JhHdgtDFlXr8OvAMdyq9juiF5/uxa2fTJKyRtg47gi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922671; c=relaxed/simple;
	bh=U1WLEsB4bpNNg6RHiRWQKsjUvjkGAA5LDXmzr9jxLHk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CYvlUE3cPR5j3+yqTHxun9+aGEq9fubouUObtQ39G/oDPd6ZmswtsTgnZ1AXlxUzc9Sz1Oy5zGCKZqkkTSEyJmLwBwyqPzHX/G2DNSGm7VDOj9IEULYo11Dxs9ZSUQqWhgHjnLP6F2zjmDT3P0scnV+09Tf5EUqRetRKswKR9LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DCjvrDQV; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH/uryrebqc2r0/gboCOSodODki5K6QbQssR1GDFh1Zs8GFXNHHhoUWTSnMyK4Pctl82mwX9J6h99STuk+0gKGy6b95D9QzqBJlJuB76K9c90HZNHy5rQ9DOaw6UYqSS0uHmh316yfL8Ei1qxbcWHwztoF7uF8ziSRzssVxpHJSB94udkN1gC6QCh30V1BDVDaYjrQMeTuGTlhYUIZweALGxq2d4ZhI8729lw2RCygBi4YW5SmtOMtMVOOV1/ZERVqoZ0xsh7wqKczEFr0s+V0Z6E7VqMPGQIM/4M15FKmFe3DR/7SlDF0a0WD2sF+X0kJswVjovehBHhPEIgtiktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuLwYxo3X/mpfL2Xd8UJsJo1ticvDGYKrqBar0XZq9w=;
 b=MK1SGS297u6xuglUWByK8Bql0OzQEMwQEmiLPBxsYLH76zxLE34Yp5U1q4rF9ReWoezmmLMPFDfyd8OSpvTQxunE5UJJNAwPvRFxF2JMAJIAsPk2ulm1sSnZDzcXGc1spPK3cwxGTQK/wB6HELPKcIG9VXH4dErj1iXgLDq+RMKwsMdEJA/k+/bDrIHOuvbXCqDp/lpB2bIQ8VDnf/zCrXIBdXWFJinUMYc6GAnfll9RVhk3RACVngXWWqYW+JW0/TmHp21GrXopP0vHKM6KkMeoI/9d92hGERuFTkUWtUvbxr2TzN8VM+Pu0Ti8a7riEdswyfROn9tBE/MtFi7zAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuLwYxo3X/mpfL2Xd8UJsJo1ticvDGYKrqBar0XZq9w=;
 b=DCjvrDQVgPXim7Jn7AiywJMgZqhhLPXuccFLIyDFA5EwM1IqzzwWukrQM9VneXHgJm8zYkXpsGMZfhvUh78/QbxYo8XozhGar/AjoUWhD3jJ1KCJ9nwwXcCYF4o2sHspqgPAF0ErEZB6Lmjb0PHhEV/0t+jY5/CpVu8y4CE7i+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 14:57:44 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:57:44 +0000
Message-ID: <b1007e63-6c86-4e24-aab6-b0a08acaf7ef@amd.com>
Date: Wed, 14 Feb 2024 09:57:44 -0500
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
 <20240214111032.GGZcyfqFqsW0j4Yy3a@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214111032.GGZcyfqFqsW0j4Yy3a@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0032.namprd15.prod.outlook.com
 (2603:10b6:408:c0::45) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 36437493-9137-43ce-f5b2-08dc2d6d4ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jWz36yMJuFwwVxfwxgMsFCYQ+isGYJph3L7LxBIqXr7Bq3FKcl+JTvlK6tx+BWHHxosmrb5mWnaHvldHzmb8sM05w0u3NEro91ESUaBcs04eaRADKcb53kiRpHh1CbWKeprZUfK4AeFoHJe6tBX/gKAQMXoDoF3YiWfFYozwSIsspc2eNsPYb9GPJiDFhhEgIc/1YELj3/lFOPdOEQNt6aTunxkqAyIqYkiXUPZ1jKY34U5i28cARz1A5moi4ZEhx9sqG80wEzzt0N9AIptmHic0A/C0qegixVqgbf8wVlh1avPxEcLC8MOLfsT4CpdWeiwSUTLy1LjI18ZJMYDbeMvVp+l8ZDOxU9WsbTUJM5+wzyQx2z6A+7it6glVeiPs+S++VpiUvPB6k58mvVYJTmFCuBlzrKEhfkaG7y57ZeoktXy+QTTqt17oTco6D9+isOAdpR3J908W6ND3FF/F5xuddj9aoNDvN7DXcq3ywDr3y+v80YUvjFTiJxZUYDx/J6UMA4C8TOpI6e+qb0gAqdWSTE7ETNftCsGpgES16dJuXqpwfvYsl1LSreUx1UVl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(6486002)(6512007)(478600001)(41300700001)(66476007)(8676002)(8936002)(44832011)(2906002)(4326008)(5660300002)(6506007)(53546011)(316002)(66556008)(66946007)(6916009)(83380400001)(2616005)(31696002)(86362001)(38100700002)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzNRN1BRVXNkNHd4RFRpUDA2cEFHbVVqRTJ0aC81MzBuSWg3TGFocTFCWFlQ?=
 =?utf-8?B?eWZCcDZWb2NZTmNySmY1c01JaVkyc2Y3UFYwZkFnSExhVGJXYnFrdWVIQWhT?=
 =?utf-8?B?bjBrNDNzYmtpWXRUaTVHRDg5NEJNbDFpTkZHNHRZS1VaOFVEUG9ucCt2NWl6?=
 =?utf-8?B?MXhIV0U5Ny9IbFFhbjVlZzBpQWxKVW0vdEg5K2JnSHFVV3N0b0g5VHFwTG1B?=
 =?utf-8?B?TzRGRnY0Ni81OWU2eDNBM2Q5VHN2eXdQK3VKckU5SUlBNGtQZWxneFptNXl1?=
 =?utf-8?B?MVlmdExZeFZSWmZLWllGSkk1MTRxVmx4bkFEREg2dE9JUEkzc0M2QnVlU0lh?=
 =?utf-8?B?eng0SmlxNVpNdHlSS3NMcmNvWGJrMXN4TEJ1RGxpVkh2V3h5WDZ6dmJ6UWZh?=
 =?utf-8?B?WHFSU2h4S3lFdzVDdXJRZ3hweGhzZEVGbm5wVUFmZS9uNmZNZ2M2WkR1Mno1?=
 =?utf-8?B?NkdZUWVwMHF5clY2bEdzNkNhRUR1MFZTRGYxT1cvYzRXSjRldmg4WTBRZUY4?=
 =?utf-8?B?YlZvTjgxUUlRT09hc1NZc3J6czlVaWlvcjV3OFBHN1F1dWRpNUp1eFdPVGd5?=
 =?utf-8?B?U3VNRjBsejc1WE5sYWp2WVVYM2QvOXhqNVBXSWg3SWd6UmlrUlN4UkgwMEJD?=
 =?utf-8?B?eWNoclcwdFdQNTFxTDFZMWNEc21FRXlqa0p3SldLcVRwSDJGb1p6NGZGWWxp?=
 =?utf-8?B?bEtRYVJBZlBTaEhsOEJVZUMwMnB6ZzYzaW1sQ2wwd2JvQmZvcEhFeVplSXp4?=
 =?utf-8?B?bEQ1Ukd4dHhSYUtMRnZYOUI3R1JiMERWUXlYdzllNTN0eWk5QXRmN3pJdnQ5?=
 =?utf-8?B?c2hGWjk4YkxLUWd0VmlBN3VHTEl3eXVRcXRuelRjZzJyQmt0R1RHeE1zTjJH?=
 =?utf-8?B?U0xQVi9MbG9JS2gyS3UwbkM4NFVyYXh1enhaZkJtSUVYbWpyRGV4aWM0b0xC?=
 =?utf-8?B?T1dPUXROYW9FM3djTVhJQ2U4QmY5bGxVV1VuTHU5dGtSdW9mOVROMUNHWVNM?=
 =?utf-8?B?L0FyNVI3L0t3elB6bjhseDdldlcrQmtSdnR6amdINUYycDd5cDFlSHd5bmRn?=
 =?utf-8?B?RUtjS1RLZzRUTFFHSVlidjdyc3FuWUtiUFpnUFNobWtEMmxQV0NIZWZ1MHYx?=
 =?utf-8?B?MXZRUTJKTEg2WlpkaFV5bUROY0FyU2V4WHU1YUJlTnpmdGtSc2k1Wnk5M3BC?=
 =?utf-8?B?UlZNYTJRNkxkbHY4N1daWVFWTEFtaEdiUkIyd1ZqRCtHenM0V2dLUHBvZHRW?=
 =?utf-8?B?K05lbjVEdWgwWFcycEcrK010YlhXM2VsS2cvelpuMzZiUjVUU1pnT3Bsb3Zr?=
 =?utf-8?B?SERmZ0RsNUxKSFIzVXVWUHZkWFd5ZWN3Z21JN2FrMitaNmhhemZkRUxlelNt?=
 =?utf-8?B?Rk5pZzZTRnhXYmVLTi91MHBtVDlJa2RiZkE1TW5MeUI1Y1FITUZabEdvRzdi?=
 =?utf-8?B?UFd6U25xWVVrWjVtRDlHeThnaFlBenFkazJRZG1uY2loWGFyeU5UM3pNQWdh?=
 =?utf-8?B?SC9aUXFnWEtXeTVrTWxCRm5jMGlNOXlNeDRKZ3B0bCt0ZUQwcThqanpTZnM2?=
 =?utf-8?B?akdsNGhCb1Mrbi8yRTNWcjRpbnlYVUxpWTVwanA2MFdTa09HY3RZV2ZlanBm?=
 =?utf-8?B?WkZJRWJ5eHhhYzczd2gzRFEweXRXTW4xZERKdHJ0SHphWkg1MGY4bnRoeCtl?=
 =?utf-8?B?MmFxdVBrM0FTTEI4ZHo0ZXcxUEYxOXlISUtSQzFFV1FsbHNBRFZtZFJQQU9p?=
 =?utf-8?B?V2NtaXQrWi9CTnVuTzRDandlazRkTVpTNTZ1SXRKV0MwMDZ3d28wenoyNms2?=
 =?utf-8?B?L2g1UW52R244NmI4NUJKTWZjQXdlNVdDV1ZTQWttVi80Zi9YekY1eWVOamlo?=
 =?utf-8?B?WnZJRWE3UHdTTmRvNm9YQ2taczQ1SUlUN09VVDBpQ3cwbWJEbEgxeW1nUXpK?=
 =?utf-8?B?c0lzc2wyQkNlNFR2bTVBM3ZLY1ltei9VNEloRXcybTZHTTR4R0c5MDdwM0dI?=
 =?utf-8?B?dGxlTDFzUnRISThHUk1xTG9rZ1ZYYjFkdFR6cDZXOVNKOG1kZHVUSllTem9w?=
 =?utf-8?B?OXFXWUtoZGYwaVIvZ3NyZHdHVWMyTTF0Z1BENXBmemFBNFM4ZVFIaitHTU1t?=
 =?utf-8?Q?7qh+liUrbPFSYBewUpdQWcAwB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36437493-9137-43ce-f5b2-08dc2d6d4ce5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:57:44.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oXhB/qJhhVcby0vnyv1yeS0xCvRrqmDm/EW/oR9p+fCxP/X7TMzUxjFQC/5MzWQ0ROr9djnrZyzzP9yodfb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

On 2/14/2024 6:10 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +static void init_fpd(struct cper_fru_poison_desc *fpd,  struct mce *m)
>> +{
>> +	memset(fpd, 0, sizeof(struct cper_fru_poison_desc));
>> +
>> +	fpd->timestamp	= m->time;
>> +	fpd->hw_id_type = FPD_HW_ID_TYPE_MCA_IPID;
>> +	fpd->hw_id	= m->ipid;
>> +	fpd->addr_type	= FPD_ADDR_TYPE_MCA_ADDR;
>> +	fpd->addr	= m->addr;
>> +}
> 
> Get rid of that one:
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index f8799beddcc4..090b60d269e7 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -221,17 +221,6 @@ static int update_record_on_storage(struct fru_rec *rec)
>   	return ret;
>   }
>   
> -static void init_fpd(struct cper_fru_poison_desc *fpd,  struct mce *m)
> -{
> -	memset(fpd, 0, sizeof(struct cper_fru_poison_desc));
> -
> -	fpd->timestamp	= m->time;
> -	fpd->hw_id_type = FPD_HW_ID_TYPE_MCA_IPID;
> -	fpd->hw_id	= m->ipid;
> -	fpd->addr_type	= FPD_ADDR_TYPE_MCA_ADDR;
> -	fpd->addr	= m->addr;
> -}
> -
>   static bool has_valid_entries(struct fru_rec *rec)
>   {
>   	if (!(rec->fmp.validation_bits & FMP_VALID_LIST_ENTRIES))
> @@ -288,7 +277,13 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
>   
>   	mutex_lock(&fmpm_update_mutex);
>   
> -	init_fpd(&fpd, m);
> +	memset(&fpd, 0, sizeof(struct cper_fru_poison_desc));
> +
> +	fpd.timestamp	= m->time;
> +	fpd.hw_id_type = FPD_HW_ID_TYPE_MCA_IPID;
> +	fpd.hw_id	= m->ipid;
> +	fpd.addr_type	= FPD_ADDR_TYPE_MCA_ADDR;
> +	fpd.addr	= m->addr;
>   
>   	/* This is the first entry, so just save it. */
>   	if (!has_valid_entries(rec))
> 

Okay.

Thanks,
Yazen

