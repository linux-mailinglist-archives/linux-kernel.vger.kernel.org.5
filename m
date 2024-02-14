Return-Path: <linux-kernel+bounces-65369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91544854BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D21289BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311965A7AB;
	Wed, 14 Feb 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDCxt9tT"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1175914A;
	Wed, 14 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922581; cv=fail; b=DxemoNUE+iraArDknV9tfVbXzCwAFzzE/jloPWRY3gXFJbc/eUzy18juUzpaMX8BJeO9jV34x4W4o+sGB3Jgb0mAWS7OjEw/6WQC2vdjSwXYRWZwE+DC4+7V+PVgGD5P5EQyWz3g4uLDsIlkWKSXG9WQad3+5mBpOwUMHhqk4eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922581; c=relaxed/simple;
	bh=1XOLBH8VxL4XJ7OAb0DT9zdDIVE5PggQX0NrlWuvPEA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sA8F6xs9mEJnyvw3a897bVDYlq0zpwQ4uRNVY7ScYLN+/hhPAuq+xZtzytvMgb1HAhzn1md+KHqgHvokAaz7Ge1XztY0tsr/3mrpl3TdSWLRB5q/DEeEk1+8UXHAOSD0ENEeRtPhQai8EL/w2FMvUefProXlrITTOMGb5MvZ68I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDCxt9tT; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJhrm+wbz0pTx8myJfO+EficKsv26almAG1ivxD2GwocfBjgC4eiwwJ4kC9/eRPFeHZrK6+q8SUARpe1i++qYFT4IJeeDG/EdzDKIFb9JhPyfxACcpRvtbU1uJsq+fhVRxOEwIWwio6VJuvL5sqnTbpieiZzM314EwgKw17D/34dylbK2sZeoVii2NwM10sXi20DpbkZ8OCzPx4aExiE8jYhHjQGX6VKJUfUyp7bWh1Tz3EoUSVmzUdYa8QdURG93KspJCFPXbPr8RMoI5ODCzm2b7sLepk+kp9hGSSlHHvJQJC4O4KDfe6wFoLR5sxHlcCEZsXgBU2yHdMkZjf/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSAY/BpcWboU1bh93JHrNjvp2NPxSNWLbXR8ZbMaLG0=;
 b=KR0IwddVkHB0XTWX4zJnuwh4fKsSAJrknpQ0KkGq35l7lj2StJZSgGW7G4IyHXTpJhvmNuh4ppbuCeu669j3bNvxr6n4UsC+qf8jGX53Dw+PcSWFNELMqKmbLpSp32JiiVLkATLRXoLOfkg4P75AvMwXaUmyc87iiAgmGbbmVWIFNjPnaCZc9QKUVrH5AFjCic914sikObVWkEI4z0uLvsnhllnc1wyYmg5sLSSX5A2qa4WSr1zb1dKLmK9K44+MYOj1sb/qAsUBEE4Peo95/FE4PI6im9JOuZUFkhc3atP912/QNWeLp/ri/shEBVcBFiv6mU36lrgYKC+CCaUMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSAY/BpcWboU1bh93JHrNjvp2NPxSNWLbXR8ZbMaLG0=;
 b=IDCxt9tTUFMbvLr4oXfnF5r6Z7VgH0QpqJGQxHVxlbl8Zq+IiLtX0FHwqa/zqfH9CbCiMDwF5U1eEH9CECPohbpD8m+Udp2xdkNNLO0Mx6/CN9ppNplVn5JuiPmZL1OHHL14NnObO1lR7aFprA9OpziWTUD4/yKAr/MOCPIjKw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 14:56:16 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:56:16 +0000
Message-ID: <3f793ed7-b65c-48d0-a556-f51bdf4f5add@amd.com>
Date: Wed, 14 Feb 2024 09:56:14 -0500
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
 <20240214110541.GFZcyehY44eSSYsW2l@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214110541.GFZcyehY44eSSYsW2l@fat_crate.local>
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
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH2PR12MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: 904cfc52-24fd-47e3-160d-08dc2d6d1835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mfLAQObSD6IeQA0TPHSwDYDzHTOzWD/n+M0sPsHaelatt0h0zvclBG1poslmWanuguc6VGFKSKdgqHDNaOsaUR/3lL6ZQprmnZjsR4tmB2o0uDWamjibwewomrtZUkxs4kLtcZ0/Y6w6RzEmBcaTYMWS0P2P+3Ygle9ll5TFgxRY+zHWkO3en6fsLm9acXvJDxXC8c+xuBpwo0IgIU3LYbcCUPEIHNRa7hfBlWwVTz9jvKaL9rtAaDaGuHEuww+Eb7wKvDFy1KjdnVm8Cy9kutxtYzmvz+5ygmY8KO7/V6+dAuefqwEdkV05IEUNWl9MsggR6/lQOHAM9ljJWlassDUInIxXU/lboY6pHvPRC/HT2KbhKmmkrNciTeirSJaNoEbblMf52hHU2UoPTipBgTsAxRktvvcUO6Q3tPdqm19+PC5NxMibJ6rA3JtnQnBX/yWt8N93XgYlEX4jxmIkskDM8kkwCnvaupoRdnHdEtaQCXMJyJvnNQAjVpCOBGdlFxWe2Yb3tDBG70NcnIzqzfvXXe2Fo7tYXHXQq1kEQ12Q/YugNzaCf7O33+e1/l+0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(6512007)(6486002)(478600001)(41300700001)(44832011)(4326008)(8676002)(8936002)(2906002)(5660300002)(53546011)(6506007)(66556008)(66476007)(66946007)(6916009)(316002)(2616005)(83380400001)(31696002)(86362001)(38100700002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0NsT05GVWN5Y3dVTGIvS0ZvV2xYTWM5WFFWUUN5Y0hVUzFsOUZEdnJjc3Nt?=
 =?utf-8?B?Ti9jMkYwT0d1dmNFZjhuSEhFQ2ZieUIxZDlWVEw0eXFENDBwUUhGcmpKN3hq?=
 =?utf-8?B?d2owTDlnSTNudTB6aGlYNjgvbUliUityQTkwWDIvcVc0OUV1RjFOWXBwTGR0?=
 =?utf-8?B?Sys0KzFQU1ZYMzJ0VW1SRkgrZG9BTXEyWHJuUndLdkV4UUtvRHVjanhGbDJl?=
 =?utf-8?B?K09reTZUbnl1eTgyRFBCbjVYY2g4WEF0ckxFV1lCQzhkc0JwTHZKT3R2QUlv?=
 =?utf-8?B?QWl2aStCWGx4dXVNUUlqVWFLKzhpOFdMaEpFV3VTQ084Rm1ySDVUZW4rS0Nu?=
 =?utf-8?B?cDJMNXAyb3dEN0xtbXMxeGMvL0l1WU42N0E4NHgwSDFyV21rdXV6QWc5OHdU?=
 =?utf-8?B?ODhxVUJjcGZHcGNjTFpVemVOUDJoVVY4UkFaNldBRlhjRnBIQzFkRllNTWw1?=
 =?utf-8?B?eEt5dEhTalY0TnJoaS9LcHB2OWRRcTFGa3NnT1lSMHV0QVFYN1dPWUtLY0g1?=
 =?utf-8?B?dE1nV3lRV1JMU1dBREc4OVVaZndaWmFWemgyUjF5Y2h2RHJQSXdSMzJSbUha?=
 =?utf-8?B?ZzJPd2NFVC9QRFdQalJRR3E4WGU5bm1mOHQ3MXFaYzc1YzBQVFJRdW4xeG9M?=
 =?utf-8?B?RjFJcE9YRVJ5V2hPblBsUDFpd1VQWjdRNm91MGFQQ0sxUjZWM2l2cXZucmtG?=
 =?utf-8?B?QnlEdktlYVJrU2dyRFUyYlduUUFqWHI1RVdaWVdJMWV1V3hyS3NjcWhNM01l?=
 =?utf-8?B?aFVVNGtNbllYb1NXWk5CQWdRdUlnU3g0Z28wdzhlcHRkUWZsYTBCUVZTZWow?=
 =?utf-8?B?blo1d3U5MHV0ZTlWU2Q5L1cwZG1ZUWpDRCt4WkYzSk96VkdzdDZBQjFETW9W?=
 =?utf-8?B?QXA1algyTldSUHVSMllQMHZMMUFNZHRtUzB4S0dTWkw2anVWSVVpY2s2ai8v?=
 =?utf-8?B?UTlaZGtVZFBSVnBQY05nUmtaNGUyOWdudEtLWlg1WFlLOWxTS05nUDBMODBK?=
 =?utf-8?B?MmNpcHNrT1gwbFpKZWwxY1YzRTRoakRNc1JOdFNuamd4ZGh4eTBBemNwT0hm?=
 =?utf-8?B?Q0ltQ0pFYkJSNGVSbDl5b3VQZDU2NUthTmNCSjN5TFRtN3dFN1gvTjNZK1M0?=
 =?utf-8?B?ZDlRVyttck1rL3hLK1p2OW5ocmxmTmtTSUc2WlJZSVhMaFZnUTNrNnpxQmxS?=
 =?utf-8?B?djJ4cHVvY0NsK1hxU29FZkpBa0RJcWhONTBHMys5K2pacXI5bGpIOHRDMzNu?=
 =?utf-8?B?KzJyazJHVnJZTWhLN1BIWFI4V1RoWU5pSml0em5kY0UwcnNZVjA3L3hyeEs3?=
 =?utf-8?B?N0FwUEEyUG1DNG8wdWVKekRUR2VFUnFhMUJldm96RGdleVE3b010aUVXUlR6?=
 =?utf-8?B?Y3RXTkFKRGtWM1lIRS9vem50QThUMDgxZ1hYQjBtdDkwaWdyRHhMRGd2Q1Iw?=
 =?utf-8?B?eVZOVjI4V1c3U1RVZ2YrTEh2WGo1N2NLallUY0VJazIxVyt6d1dNa01hTlZY?=
 =?utf-8?B?bWdha2hFR0JtRENGdzJLZlFVUVBHOEV2UERQNWFNMEFaWXhBZndLVVhtY0VD?=
 =?utf-8?B?LzA4TWFTVDRMME1KQVZZYmhMUmN5M0tIR3l2Y0YvWkR4Y24rZzFxMjZFWWZK?=
 =?utf-8?B?WEhJczdndDI5NjU5YVhKUmRUaExDRTFLMGxWcTY1N2xjSWdxSXp5N1dDSTk5?=
 =?utf-8?B?amJ1b0V1ZEozQUV5RDdLREIyS3EvOXVXYXgvUFFtWVp4TEw3cGhlaUhkSm1v?=
 =?utf-8?B?MC9QZGpsaDBSamlpb2xtQWthem1vNS84QVhmM1BYMUtBN0xuZ3VsaHpoN0hG?=
 =?utf-8?B?WDEwOHRRQ2Q3UGsvbkFrdFFFMkNvZmdCRU0yT2pvcUpLZ3d4S3FBUWFBMUIx?=
 =?utf-8?B?T0VXNzJMdG9Dam1XTUd1S3hzTU1VdVFQbXBHb0FhOTFnNmhsQUZCaVI1UUtD?=
 =?utf-8?B?bkRYdi9hUHE5RGx0V0lWaC9ZeldUY2JRNVlMR2p2d0lySTlKcThrbm9rTW9G?=
 =?utf-8?B?eXlJSlA4WXY2NmxlOVA5ZVI2amZnek5WZFJSOGJWaVNLdEtQT3FwWmp4RllB?=
 =?utf-8?B?enlHUzA1d2g2cmUrMHU1bGRCRVB6SWxyN3pveVZpTHZJSjRXVjYxa2ZyQ0FW?=
 =?utf-8?Q?+oxsf8N7AQdYHi3POcM/7gbhY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904cfc52-24fd-47e3-160d-08dc2d6d1835
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:56:16.2561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zt3jtkUWdnwNMxWpy9TpY4sp8sCmuDV6DNc9weJ6o1k52SZdR6/O6DGXiBwm5jqZ3ZOS8M9KdYOTs/118c0tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924

On 2/14/2024 6:05 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +static inline struct cper_fru_poison_desc *get_fpd(struct fru_rec *rec, u32 entry)
>> +{
>> +	return &rec->entries[entry];
>> +}
> 
> This one needs to go too.
>

Ack.
  
>> +static inline u32 get_fmp_len(struct fru_rec *rec)
>> +{
>> +	return rec->sec_desc.section_length - sizeof(struct cper_section_descriptor);
>> +}
> 
> Oh well, I guess we can keep that one.
>

Okay.
  
>> +/* Calculate a new checksum. */
>> +static u32 get_fmp_checksum(struct fru_rec *rec)
>> +{
>> +	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
>> +	u32 len, checksum;
>> +
>> +	len = get_fmp_len(rec);
>> +
>> +	/* Get the current total. */
>> +	checksum = do_fmp_checksum(fmp, len);
>> +
>> +	/* Subtract the current checksum from total. */
>> +	checksum -= fmp->checksum;
>> +
>> +	/* Return the compliment value. */
>> +	return 0 - checksum;
>> +}
> 
> Let's get rid of that one.
> 
> Also, I think it is called *complement* value and you simply do
>

Yep, good catch! (compliment)
  
>          /* Use the complement value. */
>          rec->fmp.checksum = -checksum;
> 
> I'd say.
>

This was my first thought. Other checksum code in the kernel does
the (0-X) thing. So I wasn't sure if there's any odd side effects
of one over the other. And I didn't take the time to dig into it.
  
> ---
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 9eaf892e35b9..f8799beddcc4 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -195,11 +195,12 @@ static u32 do_fmp_checksum(struct cper_sec_fru_mem_poison *fmp, u32 len)
>   	return checksum;
>   }
>   
> -/* Calculate a new checksum. */
> -static u32 get_fmp_checksum(struct fru_rec *rec)

I made this a helper because we need to validate the checksum when
reading records from storage too.

> +static int update_record_on_storage(struct fru_rec *rec)
>   {
>   	u32 len, checksum;
> +	int ret;
>   
> +	/* Calculate a new checksum. */
>   	len = get_fmp_len(rec);
>   
>   	/* Get the current total. */
> @@ -208,15 +209,8 @@ static u32 get_fmp_checksum(struct fru_rec *rec)
>   	/* Subtract the current checksum from total. */
>   	checksum -= rec->fmp.checksum;
>   
> -	/* Return the compliment value. */
> -	return 0 - checksum;
> -}
> -
> -static int update_record_on_storage(struct fru_rec *rec)
> -{
> -	int ret;
> -
> -	rec->fmp.checksum = get_fmp_checksum(rec);
> +	/* Use the complement value. */
> +	rec->fmp.checksum = -checksum;
>   
>   	pr_debug("Writing to storage");
>   
> 

Thanks,
Yazen

