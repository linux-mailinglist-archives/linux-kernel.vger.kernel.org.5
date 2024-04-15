Return-Path: <linux-kernel+bounces-145874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD88A5C36
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FDB221D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA715698B;
	Mon, 15 Apr 2024 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rwu7vvL3"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79F15696D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212870; cv=fail; b=pUPIyD3Qrl6jgeI/S6U9bYcCrpyzdL+COVv8J4q15ToWIhkNiAsxM6lWL+YSOHoXZSCGGmsHBbfHzxJa/evSOEANKYGv6Q9g9uoI7Ck0mycHvsoNIdOHL2smuevnn/g45cGceiADJXN9LFELsKgxzKwSycngDjAk4dti+6JnD6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212870; c=relaxed/simple;
	bh=luFd3UhV48orqDS0MtX0vVZuWWNZaqXYF7x2sLxz5Tw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MGE0OaOdbSkYv1y8aXc0WreSHvThZpcnIsP2kjpmgjM7MusC5wAPOiVol8ggX4DsUBMb/ojUJJVNOa58BiBKV0KxWAWsn20lLCuIFL7JAwxTpd7/rfEtY747EgAGiJZJKMrZ9IuNx14qAWBa0AYdKa5ntq47HpGiVoxj+70ustg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rwu7vvL3; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePIpuB9B1BkqpBDxB7J3aD0KgaOEo4iYZHtmAIDtHtWKLpWY9sMVSuYpu43Pj4d+iDE/ng2JLTfLIgagxpAIssXjix8l2aIRSa94zNO8RqM46S/gJtV7DLb2/jkFQIRJ+6RCQpAG46pSkcEMINc2CP9PkfDrcoInO85GBkvc9sfIvDhYesPWceGyNcd7qTSo5ZEwg/4stMegR50Fs1CH3xhks4/cD9Ut+0hej3+epT47yq4htX7PydQnm5Y29+oNKUYPHgkKe8uESC+Xp/Gi8vTV6SifSrs2pl9m84YXUle9D9+CBtypkyRf6xkvmVwswZQAkTO6B4AUQ16ctMY/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvVUjPcv/t7Mfd+sRw/MfUZVszyj6sOC3R+54KtRAqY=;
 b=YS6jYnu40UDrbAlWBMDuxBPJ12OFKjEN3PCcSB4/Xcl+z+ObYAdDP/4uO0uBGijO/X1pDeDlxzAnt9b2aTwGG8wJnF5IJxtgvTZR/tdPe5b3SyT7RiIAP0qUZ/OiYCCbjQQnHtpST+kiTDr5qIpddyXlLI6i08Eafigj8TJ0ifUECcgzeXWwZb/d0v5FetnFNDwcjW2ThSWf8pdTel+eaiyhDHG4qSqcUEmlYZ7pJQgBKhZXU/5gJj0mnR9IcIyL3MfSH0oB6ECAvz04i6xL6oa+ZMBqABkY1f0KCg/WZKYfFKe0VIGXHCYFGEMEbh5XOkDzAD+lh/M7SxjSMpSFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvVUjPcv/t7Mfd+sRw/MfUZVszyj6sOC3R+54KtRAqY=;
 b=Rwu7vvL33t7xD+2H52+GG1jpr9AggBOalYR6iYq40Z5l16pnFrTvi6Z25VGNUFW83vxQj4e3xmPwLv+swvSTAYcOLoNHltP4YlnrzvLUncEiVh4UvJuWLgbYfqBHs2/W3+L4h926cx9H8EclZgGQ3gd0x5PX5tn4jMegDFaz4KI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 20:27:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:27:46 +0000
Message-ID: <36bdfb3c-2828-4188-88b1-b9d01b2a114f@amd.com>
Date: Mon, 15 Apr 2024 15:27:42 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-2-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:5:333::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 564e803b-8965-424f-b81b-08dc5d8a82d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UFbnaXqt7l6KO+x7t0bGMF/UJwPell2lYXk560a2UCy7FeFhgAeCRhVHsFm7i+gm4zWtnkV2RJ8204QyhiuWOl/upKsi8HOY4NPgoB5V2LZAVAFuOxjqaIc29XO5fs4jcMfYe7no94nEUdHEIwdTMTc7mJIrkNIQCu0qnvVZjzzkMXGcbdO4H+0TOAL60JUxyWGjZcv9g0kDrbBX3mUWwPM0azrmzHqFAZ4edvypDNOoq048rb4qkagBJ3bkAjtYEvxCnAYVy+Fj616MrSm2vjLR85XEJitJDHXQYVx2YJ2a67BagEV2TcVkoj+c2V7FiUJpKSFln0IddeyLxCWO0eaJ9HaNcFU7O9mcCeJqFwJx7yV81K60GQbPm36+M2vfBd2xFVsPl4tx13KDAwPZrkTzZM8GCroq53zQkwRuSno40UpOToTnIM5LTElIMlr042xn4ZVUhJ/0RXzIeJDoxwwAxRyleFztiK8yxpmN79kbOLu6xnW6OzIsZRgWpj+zQOF/RHvgxQ/RV3vXX3XBk1F8EXjAMLxbL21sKEI0sytlb3gScAwk1tDifkaUITab3X37CCK05+rkbiyXw1sKeHk+cbZCwo1G7v9PkZ1gRdyGr0LONE3o5jEfgIP8/hfw5fGQu1JfauWKoL/N4+CqtM1b/BaKvIXP0+llMzloOL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFZZL1RPOWoxamZGT3psRlZnd2NiSk5SQzUwN0NhckxmNDBLa0VIdFY0RUF6?=
 =?utf-8?B?ZGs4VWowQlZQREtQdXVEem1vUk4rcnI5VHZqMFk3RVRRQU01WDNkdFFLcGdy?=
 =?utf-8?B?NjBML050NjFaR25oZzJOcHFkRWJPeXNjZ3l4bkkwVHZsY2lTQXcycC9Ua1h4?=
 =?utf-8?B?dk16VC9FbXcyaTF5VHE5eGZUNlowYTRXYnBLT290cUFucUp2UURkUktoQkFN?=
 =?utf-8?B?SjE5K2pGazE2T29qYUpsdStqem5DUU1zS0hlMHI3WUVWNGxqaVY4aW9qK0JN?=
 =?utf-8?B?MEpKcnNrdmxNaVdUOGhZblFxRmkrQytIWW1TZGZiQXJFYVhrWDlkd05tT093?=
 =?utf-8?B?S2dwbjNDNEZxRUxta3YwbWV1aFR3c0JoTllmblZjZW4ycWg4ZmdxNEdkN2hr?=
 =?utf-8?B?RVVQUERPbUE0NXpBOEs1R3p2a1J6M0w3anpYdUdsK1pYM2hmN2JudnJxU3Iv?=
 =?utf-8?B?SjlVVlo2Zm9qNGxTU0oycW9jcXdEeTIvNGJWcVJIT3hzT1FCUTluenJzZWVT?=
 =?utf-8?B?ZnlsN1ZRN1QzdTZ0NVFtY0ZOM1NZT1BQYzR6NjdnWFpHRnArODBEQWp6eTlK?=
 =?utf-8?B?dm9yendvOVRjR3h6K3M4b01mR2RxQnpGSWM3MTdqYjhJbHlsdDVQWDNJNmxB?=
 =?utf-8?B?cFRVWFNFdll5dGNMZXJIZ09BTVh2UEZ6Z3pIbUNxTXBMWXBqaVM3Y2R3QnJJ?=
 =?utf-8?B?RGpqQXlsSUVUVmxwTmJDaHU4RnJneUxtY2YrUGM1S2MxbndreDcxR3F6S05i?=
 =?utf-8?B?WHI3NmtJTVIyU3IwbCtVTWJhK0xEN2NWZ1dpOUNDNmlLN2ZEb2Z6SW8xUUdC?=
 =?utf-8?B?Z2FnQy92azRkUjZVR1dxZ1huaEIzWVZ5VVNCWnRtaG50bVQ0UXFqOFhJaEpD?=
 =?utf-8?B?blBBRGhFaEQ1Ukc1YnVCZERBYkdRRXVNVXlWNEJtaTdyOEN0VGFGaC8wNGVU?=
 =?utf-8?B?Q3dxWHRrOWhabDZ1Q2R3Rjd4dm9VRmJQdTdPZFYrUGdHRk5VQlpTblF0c0Jw?=
 =?utf-8?B?bEVaU3RiVXN2YTdPL1VCQ056Vk1VdHNISGFiYjNKcWNraXpybXhKa0N4ZDc3?=
 =?utf-8?B?RDUzNS9aemxmNnlFR2ZCMG84VkhjWEwxOTBNODZzaWxJZEhpcHd5RHRmaTRi?=
 =?utf-8?B?aEJDSEJnNXVEQ0lKZEs4a1N1MTBvcnl2MTg2dGFQSjFBSVUvTElnbXd3MExB?=
 =?utf-8?B?ck5mSkhKd0VtdnVkTTF4Rm5tdm1kdlVwNDRLOEZOYVp4dWFzQ3BRenNDTTds?=
 =?utf-8?B?b042N0h0L0VFZE1ObVM2TEF6ckNMdGh4MVhaMCtGbWlZTU1hTFRRRGloVXJP?=
 =?utf-8?B?aXdFVUt3U1BpeWhyYnM5ZmU5VHNKSmFzYjZVcitNQ0xTM1RBSGo5Q0llYSsw?=
 =?utf-8?B?YXRxaDhOOTJVYzkwaGg0Y09FUnpmcS9LMEJ3WUlHVzBCYlFkS29HWENwdGFL?=
 =?utf-8?B?bWFBazdyU0FicmJ2Sko0UGpCVUYwUzRtVEpYQVp2bk0rczRRcXFiVTRFMXZh?=
 =?utf-8?B?VEtIMEQ4SlFXT3FielZiNFZmODQ0NEpTaStCZXhCdnJYWk9haTZYalorclNZ?=
 =?utf-8?B?eWlNVUJBLy9weHI2bWROY2Y0Zk1vZXRLcDI0eWFhdDdmcjZld1cvU3BoclhB?=
 =?utf-8?B?ajVvR3hWUDltalFhZEMyZVU4ZjhaSmJFejZEQy9rbmt3eCs5ajdSRlVWZHc5?=
 =?utf-8?B?T2h4RmdDWnYvL29GVC9zVzRNZGI2TVJkWVYrKzY0aXlWcmtCZFlDZ3N2R21U?=
 =?utf-8?B?K2wyWGd5NVhwQUN4OGtqRmpXb212d0hSRXdLK2gxNUJJL2kxQk1MZGszR3ZV?=
 =?utf-8?B?aHZRczhGVzc0SnJEZVcxQnkyMURibFVNWmpOZm9jNjdFc2E2NDloZjJHakg5?=
 =?utf-8?B?ZnNqQzBsYUhKYWh5VWRtUUh6c3gxRFpwbloyN0NsR3p1cEN1eVdYamNEb1pR?=
 =?utf-8?B?OWw0NVJGTXdRSlVTTldCN3FEVCtzNlZRVDhNS2V4aG1WQVJnSWFkRkpGSE9E?=
 =?utf-8?B?QzlxTnVIdS84bktBR3dJZlVHOGZkTTVvNkh4ZmMvU3pOUENka29QK1FGN0xQ?=
 =?utf-8?B?a0IzYmxmMThxV2JJWEVseUREQ0hHMVhSYVl6UlVMQUN5WmkyMkg2RnJCVHZu?=
 =?utf-8?Q?aL/s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564e803b-8965-424f-b81b-08dc5d8a82d2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 20:27:46.2943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9XJ8YplQOjlXAKOqAwYDJa5P0eswjT+cj8yq2e3kxj+Ht0M526iRVPs/1GwI5e+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859



On 3/21/24 11:50, James Morse wrote:
> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> searching closid_num_dirty_rmid") added a Kconfig option that causes

This is not true. The Kconfig option is never added. It is added later in
the series. There is also comment
on this https://lore.kernel.org/lkml/ZhecyLQsGZ9Iv8wU@gmail.com/


Shouldn't the Kconfig option added first before doing this change?

> resctrl to search for the CLOSID with the fewest dirty cache lines when
> creating a new control group. This depends on the values read from the
> llc_occupancy counters.
> 
> This support missed that some platforms may not have these counters.
> This causes a NULL pointer dereference when creating a new control
> group as the array was not allocated by dom_data_init().
> 
> As this feature isn't necessary on platforms that don't have cache
> occupancy monitors, add this to the check that occurs when a new
> control group is allocated.
> 
> The existing code is not selected by any upstream platform, it makes
> no sense to backport this patch to stable.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 011e17efb1a6..1767c1affa60 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -149,7 +149,8 @@ static int closid_alloc(void)
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
> +	    is_llc_occupancy_enabled()) {
>  		cleanest_closid = resctrl_find_cleanest_closid();
>  		if (cleanest_closid < 0)
>  			return cleanest_closid;

-- 
Thanks
Babu Moger

