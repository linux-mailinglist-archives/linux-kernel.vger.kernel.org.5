Return-Path: <linux-kernel+bounces-98483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D453D877AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45494B2101B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DB0F512;
	Mon, 11 Mar 2024 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jGw3YXlN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3A9446;
	Mon, 11 Mar 2024 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135525; cv=fail; b=VYhw/MAECJKgveK605FltLsU7wUM6LXDKLPwy4bLepDE56lffsyDesApQmh+yGivyLaur1eEJRKyEGV+Oa+QspLAPcQSyqbd7PSRqzqRibY2M4RvQHWKeG9UabIqYVlZ1ZuB0jkgw2NDD/+kT2mHGWIeGwmKm6iPq+l3sFjj6hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135525; c=relaxed/simple;
	bh=UgGLNsatvrcE7OGoAqLkYImx95hTjJPbY1XBH0Q4z44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ujAAFuG3HIvl2JD7N1s47pdEWAmTS2idBtd9m4bjMbT2wfZHAn/HyZE4J3o5b6iGd33XJY7jZAp3RBx5w2JFA7tDcH9T5MVlHG54HSkhHtSH3Vfl7mw2+lDzGcdl+dN9iDVpKhTv32mITFxGHoqUpJCVpFE2l3TVQg3AQr1af/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jGw3YXlN; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8IK0gcV+ArtpoSOgdyAP9KiQkJUHJ1P6WG6ViWLDN6YSeGFZZKqkPtxCzJZYOA1AmGtZ2+k2gRbMe6DI41P2zVgddB2cHY0iZuOuEJS/6BKggeCJqLfcAJF/e6w5e+MCKuL3fN1RCMCRYujl8SGPTFbhdPYohmurvLUL/j7g8w89grAHZ3R3r36lmLm1N9D6qorWDhAx6dd245bOpJsSCAiBm7DfJP+/l+vxUDgroBNxDJ+gXQJBmU1503yhiWp+aomZ0kH2IkBBDvSby/w5rsfjyCjfoZ2IIhx1w9yU5m6xFNhjTAYciz+JxlCBE7AGvl57fFOKIvXUF12U5QhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5ATGtcE1KBPqsAT7EZwO/6qf5d8eRuxbNTqm+1cDC0=;
 b=P7OmOnaS8cHQ+dI7ACzWkV7JxE8jairLkcb0i3UHfgL/Q6TUJWCI/xZecT9VxuhvcMuvADAVidAAAAA9y01sG11+WBCXdFCL762wM214n+Y4U5LLkcHBDRJm7ME2g9SmoXT4JmUNee9ayk8WMaM8dYmROcMQdHvbnvA3ODf/mKuj6PVhgztA4oXMxUIrH0rCrrrU0eyUIzzJyXGFYvprQKDqmnDFI5BmxWQ4XID5DzjmeztgIsAwMaEESvCBswkJ40qMLJHQ6BKP1zcMVljPbLzv2J7LoMTQ6se/eb61QB3C+julllSjfrsyl2zvDvTehJnaMGq+BOmSNAmobWHUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5ATGtcE1KBPqsAT7EZwO/6qf5d8eRuxbNTqm+1cDC0=;
 b=jGw3YXlNl4h+kt5XXhi46hmN2wtu2Z2oTu5fQNKTRY7i/saCXDePurM4zA5UyN5uJKCCvLBo6dURt3WZEbSmRloUNqpBY9VoYKqN3XFoczL2Y08pSfqIofLyuak8zELqN2zlBEXCCjldbNnNO3MLVtDCLIJ3y505AnKOdWn0jfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 05:38:40 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 05:38:39 +0000
Message-ID: <681c0e19-51a7-452b-a6c6-f89c9c4dd254@amd.com>
Date: Mon, 11 Mar 2024 00:38:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/mce: Dynamically size space for machine check
 records
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307192704.37213-1-tony.luck@intel.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240307192704.37213-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b684218-d0f7-446e-0350-08dc418d8151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Oe7Eov5Yw25ImLHPN6O2f4nhdbWWnoTlm1EBMUDOsupW8dE0/38b68/Ky3hp/0IcE4/uvs5D6fH8Tjtqsy5cShKtjcRbthYStCTD4JzAyobrFrHN+zzRpeHTwabQcpV9njrJqeCqz2hM++C1SsrggLHwe8hbi0ZAMNp7Yn741y68jqwOUlrGppGLSZPloze3xD8lxYNLT60DqNjgqod622O/BA6Mm2SvYad4TUrqKRqMDSBxK5nCNwzxuYvM4dJ8KPWZr/Us9KM1H4qvpV8koOg7tD2OhFXndWE8MGrbbIFSPjakN8l2j1/h6VEG8FF3LGnPPPEah5S9d6eMVOCx6g3y9sOeutqpxggUpYk0i/7cE0oPTXQauuGdmI7KaiN4w2q4Bq6QUZxo/1HOoCAtFsJbDUvl8iSrxI3LeaIUZ6Hp3CBSAFERh+gDXnMT1oWyax5T2n5PPgPHM5wyn22a1XF6bud+c5X7yykILZIkeySdUwIKmP+/pPm8ZcJo4sQGFbT242KLooXSmXO2F6Qk4fCtWMBe3j9fq5KRCFRJQmjcZHpiJ/lv9oqa6uoQMe8hAQ0s/ql8OcFlQWdganj8zCd9hcPHeI1geYzHtdldfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0RmaER6YTNHZWVUZG44TUhqeGd5NW4xeWpCMHYyUHRoRVJqc2pJWVRMK2t2?=
 =?utf-8?B?YW9KejA3Z3AwdG9xOWlrd1RVVHBGYzJxampzcHdrTnlyTWFDSi95SVM4TnJK?=
 =?utf-8?B?T2llVXVXQ09wUFU3VlBSMmZOYmRreTU1VVZCNUkrMmJob3NFZUFJOUsya1BZ?=
 =?utf-8?B?VU8rMWxMM0RtV09IQ2hacWpZem4rajBXemlyMmxPWW1LekpMU1hraVlubGt1?=
 =?utf-8?B?dEs5TjNwMGtJTmxzclArZm1HUWNCTXFKSW9VMHVTdCtlVlJlNFVDdWtxSUIy?=
 =?utf-8?B?aVJDRUM0MTQvZ0NDWVhDdVBGdHV5QmZmVXo4Wkg0QXgxdVdTTElldDUrc1lO?=
 =?utf-8?B?YWNSY3Q5RmZSQkxyOGU0Vk1hTzk0NlAyeFpBa05zczNzZGtnSCtXM2xocHEx?=
 =?utf-8?B?TkNHbk5vRjMzZE1KcEtINHBXMUJWTFNUNU9QRmVuOE1md0xTMDViY3BDM3N3?=
 =?utf-8?B?VXNCSlkxdFJrRkRTR1hBYU8wclBabDZPbVpBSWVNMGEramhNQi9jeDVRU0JK?=
 =?utf-8?B?OXp3TnBndWVkOGEvajRxR2tFekd1NE1ZYitjNjdCMXNsZ05WTXFETmM5Z1JD?=
 =?utf-8?B?dTJtN1E0SjhtR2xFWjRMVzJ6LzdybnZUeDFpaTYrZFhFdEdFZXd0OXJzNEZV?=
 =?utf-8?B?TlRvb1dtK3pHc09OYmY3N3JYdHBtQVI3Z1ZaWi9rWk9iQjhocHFrT3hPQXBz?=
 =?utf-8?B?SnNPVFRQSXhsL3pKZXZsb0F6bHUwdFNSdEpDZE5ROVZpKzNROTVSSHltNGdG?=
 =?utf-8?B?aUx0Y2NqWHg2ZE9sUDl2dEhnKzh1d3IzemxRV2FZYUNSamM1Q1pyd1VnS0lI?=
 =?utf-8?B?b3hDYTEyMnorOXlrWUNsUWYzUkg5N0EvRFNCejZRTEtqV3BhQmE4VFphRUdq?=
 =?utf-8?B?SmwydU9xbHhobjNPblkwZmJ1a2dpT21TZmhSUE1YUkFsbXNJVEk3d2phWjlR?=
 =?utf-8?B?bXQxMTVwQ0dOeitra1VlMzJTeEpTN0lDYVlQeGlxeG5vVE0wSFNKU2g0ZG03?=
 =?utf-8?B?Vko4NHl2MDJDMVZWOTNERjNPZG1RZVYvZW5KMlhCc3BlZEUyRitxTUFXU0lq?=
 =?utf-8?B?bTBSbFlpOHVGSGwvMXBMeGQxcm42eWZNbWFiVWJSTUIwd1lZb055YlEyaUFi?=
 =?utf-8?B?aDByVFhBaS81QlBVeGFJMlVjTG1wUk11RzJCVXRQNXFkY1Nyc3g5bEltY2Ft?=
 =?utf-8?B?Q0Y1alRSMkxzVXRsREU4Q1VmekJWbVMwTTFiZzlKM0lrdjFWZVE1T0J2ZDZa?=
 =?utf-8?B?d1RTY0NhT0ZLSmh1UVFXakFpc2xqdldMNHN4TytodW1tNU1WVnBxNmIxV3ZE?=
 =?utf-8?B?VE5MTnlZVm1VUGZ1OGo1RFI4aVY2S3VkbmlaRGxzWCtuVEVFcVliVldxdmFW?=
 =?utf-8?B?T2JxaGhjNEw0UjFSTGNoaitHTXFJZWcxb3JMeTNIZ3VCQW1OUzVFdU82TUgy?=
 =?utf-8?B?a1k2eFJiUGdCSnlRdUs1dzJ2Z0ZIQVVqQnBvSGtaTTZSRGVpQnl2aFVNQkhT?=
 =?utf-8?B?TlBIS1dCOThQbnVhN1BKcFUzWkJyWDF2aFhyZEQrbys3Z3ZUYi9QYWlYa1BC?=
 =?utf-8?B?VGQ0Z3A5WVNxNUNRYUNsV3g5dXJ2d0I2U0xydlBkV0JsOWxSY3R4bDFIOWli?=
 =?utf-8?B?aVNHSm91U2RqbnBrVHp4WEtmNGt6Mm1KNEhqUHF4aFU0d3lueUs0V2hERjVi?=
 =?utf-8?B?cE0vekFEZmdHeWVrSFlzRU15WCtjdy9UYWQvSkF1RUJMdDhXdWVnLzFBalhZ?=
 =?utf-8?B?L29IeHNQQnZmaFJxL1ZkVDBTVzIxaUxCRDNLK1UwQ2ZWOGVJZkpFV1ZKVndX?=
 =?utf-8?B?Qys0NVVUb0VjVFNTaCthUit6bmNBZEE0KytmaGxhU3RGeDBJaU1pRGRRTkI2?=
 =?utf-8?B?WWN6YzFXeWZYb2VNN3JWcDVqR2htdDRCZXlrNWFTRFhrSjJPSnZpUjdlRzA0?=
 =?utf-8?B?MENCUk1UZkhVQ24zLytFZEdpVHBZdHJ4ZHZhbHltTFhudHNRN3VhNjRmaE40?=
 =?utf-8?B?ajY4YjdXY3Qzemt3ZGJwVU1ZZHVKdy9taVNFdEdJbjhTZ0kzd0RwOUljci9o?=
 =?utf-8?B?ZUppN0tGYVhvd2t0cFBzRlNDT2dqblIwbWNScHNFWTJNNGpvdURESW5SSnIv?=
 =?utf-8?Q?8xc46glvWtfaJyWkPyvCw8Gmg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b684218-d0f7-446e-0350-08dc418d8151
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:38:39.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Bhomo+oR+4fc+qICWLZ5BLL1nYyZKGuRsZVRQbdblfVpYpiD8yveBTxEucTa+nUQvS1+IJnatqie7YEw+FXUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016



On 3/7/2024 13:27, Tony Luck wrote:
> Systems with a large number of CPUs may generate a large
> number of machine check records when things go seriously
> wrong. But Linux has a fixed buffer that can only capture
> a few dozen errors.
> 
> Allocate space based on the number of CPUs (with a minimum
> value based on the historical fixed buffer that could store
> 80 records).
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> 
> Changes since V2; Link: https://lore.kernel.org/all/20240307000256.34352-1-tony.luck@intel.com/
> 
> Boris: Eliminate "out:" label in mce_gen_pool_create()
> 
> Sohil: Added Reviewed-by tag
> 
>  arch/x86/kernel/cpu/mce/genpool.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> index fbe8b61c3413..cadf28662a70 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -16,14 +16,14 @@
>   * used to save error information organized in a lock-less list.
>   *
>   * This memory pool is only to be used to save MCE records in MCE context.
> - * MCE events are rare, so a fixed size memory pool should be enough. Use
> - * 2 pages to save MCE events for now (~80 MCE records at most).
> + * MCE events are rare, so a fixed size memory pool should be enough.
> + * Allocate on a sliding scale based on number of CPUs.
>   */
> -#define MCE_POOLSZ	(2 * PAGE_SIZE)
> +#define MCE_MIN_ENTRIES	80
> +#define MCE_PER_CPU	2
>  
>  static struct gen_pool *mce_evt_pool;
>  static LLIST_HEAD(mce_event_llist);
> -static char gen_pool_buf[MCE_POOLSZ];
>  
>  /*
>   * Compare the record "t" with each of the records on list "l" to see if
> @@ -118,22 +118,32 @@ int mce_gen_pool_add(struct mce *mce)
>  
>  static int mce_gen_pool_create(void)
>  {
> +	int mce_numrecords, mce_poolsz, order;
>  	struct gen_pool *tmpp;
>  	int ret = -ENOMEM;
> +	void *mce_pool;
>  
> -	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
> +	order = order_base_2(sizeof(struct mce_evt_llist));
> +	tmpp = gen_pool_create(order, -1);
>  	if (!tmpp)
> -		goto out;
> +		return ret;
>  
> -	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
> +	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
> +	mce_poolsz = mce_numrecords * (1 << order);
> +	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
> +	if (!mce_pool) {
> +		gen_pool_destroy(tmpp);
> +		return ret;
> +	}
> +	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
>  	if (ret) {
>  		gen_pool_destroy(tmpp);
> -		goto out;
> +		kfree(mce_pool);
> +		return ret;
>  	}
>  
>  	mce_evt_pool = tmpp;
>  
> -out:
>  	return ret;
>  }
>  
> 
> base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b

LGTM!

Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>

-- 
Thanks,
Avadhut Naik

