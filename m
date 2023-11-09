Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1887E72E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjKIUdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjKIUc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:32:58 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452A3C15
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:32:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrvUSNOvHpm0WzZ2jctjhxzHgXUaMq2Ie8PpR/98D86YgCHnGxjNBX/MNjpbNuZxbdbeZImAlYFXHXVW1UWtzF/PDbUmxyl2B83+om/DY1KJkByLKiMJDDx3HWmPuOtcNfuBZgXzZqc9nl8Iawuahe8Echu0TldWmIbMLK/9TMICCqLhYcM/AdLD16GDWeImhO0xKcx8xGS9mox3zD0pWV2jQpKhd5HjphhbQZDkckIZr27RcDKjOHH1Ye54bjpe5wSM4j4wz/0Z03fG+O8IRc4qWhrVdso9HzOgbRA95dN/O7/iXG1qYqbMLX7VflHAlxKNYJeEHQX8AbuP1N7XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLd6Zhq/jUd2C9YUpvAcoibrW36XwHi6DQb1YUWh9lI=;
 b=QSO1/mUfyWXr0xz2Exsk0X3HTNL1SoObDoDInM/nCFwcHyVjQLiB4528ReVOjQxyJSoxMTsWDKdDishg8tMXiysjYA/MBIy4htJ2y1JtnZgFZSmRoBc8tqILUn9Q+dRgzeyhU7D9nfH3PiiJhusJ79SdRRRTTBOK+T5/zrxRj5sF0yOwklh4peHKkRxgZggciBkUxqpZQYopPP5y8ilKcN4LpHbzOwpNrpmeh7EIW7v59Rn0Dv7J2s3IGTGrgt9p7JE6gP5hdbvgfvXzMW0yKMJI5UwcOt4oaMZprZaPqLNzdCOAE/6bvfhXvqzgElT/rIVZuMnci2YHlBGJb2llcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLd6Zhq/jUd2C9YUpvAcoibrW36XwHi6DQb1YUWh9lI=;
 b=mFvr6U1IupstB2E8Y7x5Q7upMcNfEnQGlZIlwd5K77G0wRfAwa7kyGW+2PAjsiQswV21SAqKAyBuo2eb/2vwKlgXIF3eLG3e5R+0OCcczrAMrlTPBoOC74Kv3p5V19G/qyC5lG25F+Q75ivPYMYtCDTbN9bSVUPVIa+/y2sH2QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 20:32:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:32:54 +0000
Message-ID: <8c608bf5-067c-4089-8669-9eaf3b73d33e@amd.com>
Date:   Thu, 9 Nov 2023 14:32:52 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 07/24] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
Reply-To: babu.moger@amd.com
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-8-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-8-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: a55ce437-0cc5-42d9-8169-08dbe1630cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQ8Y7izzl+az1QwBiMmwxm25/QjHM9FujAcj2qlORFl68lrPPNmmPYvfwqjKZTcaGiMbRh5zRJPunuvNLR9S2MJFYEMt0PB7wkvSAFSg0X4QEcNbznw6liJa3ou8nuIxs1khgr6Qta2Hz93QQaxc7n6cHf8IMCWIDguzZexFn//0hbSrrsqQYhAxZmp7JyRF02WlD4cxskydg42GDwtazfZAgBkDRcPHUPxngBw3eYZ1dhElEJJmOmg1+dY7VvGu4PSmboJaqFJUNr2HeA8D2E/a6kN8a+foOsQSMoMC/7j6Tzx4bzNGeHGrujygViz9cpi5FSSlrx7P3XiWNsnSV8MIx3hDiELwKqfocTEntzBSBsYQXlwGJagqM3BCyb/VtyyQaEKQvoQdOvjexaBljA4zPIyHCVs4ROON7W4hz90XXYyzDD28EsbfI+Xn9VR9tEqJWXXun15Ahb/ZpLv1VDPg+sLV6QH+A7YV+3oAsCR2ZrOfFVEewgS4Cd/ACDtnQznIf0z9ha2HCHgsRRHhyPsfqy+orWzeIPf5vQFWX30Zc71mOo0BpfM1pPGB5AFyRa3izcSyRDm71zhSM6R9jD2BDA9PaGkxEgjq6+CgjYbpeFy2M7dn1ZNQEu23/jtsrEcQzGr3v+oq9gXHelItMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(53546011)(26005)(6486002)(478600001)(7416002)(66556008)(66946007)(2906002)(66476007)(316002)(2616005)(6512007)(6506007)(8936002)(8676002)(4326008)(5660300002)(3450700001)(54906003)(41300700001)(36756003)(31696002)(86362001)(38100700002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUR0ckRFbUpadG82eDJmU2xtN3dLakVIcmVrZmRuNFRGRzlKRFhURzlpWlYr?=
 =?utf-8?B?RkM3ZTY4RlNiNE0yYnBsSS9EMWZicThuQkd0VXAwSkp5YXB3UHBEWTNXTVBP?=
 =?utf-8?B?SlVaQjg2T205RWJ6NnBmL2tUanNoaGFpNzhyd1U0cm40MUcxSmUzUk9ERWZw?=
 =?utf-8?B?cGtaWVZpaEdLdFBSUVM5bU56cCttUitqMVhhNmlKQk80VmVoQVlSb3dBbm9t?=
 =?utf-8?B?UllINVNOcHpHNUNuVThKdGZwWmluckFPTnhKazNScUU5c3dXY3l0M0pZTStC?=
 =?utf-8?B?Z2ZiTmhqaDBjbHN4UXFVZkZkUFRZMjJSdGFzNFlCT292V1hQaHMvaGVMY2xU?=
 =?utf-8?B?QjF0MU1xcmJrU1VCVkkxUE0xNGxoR0Joc1Y4MllneUhyeXJFa2ppc3pEalpC?=
 =?utf-8?B?MUZxaVBSQXAveFllSkJaU2RFUUdVUXhxaEs3MWN6YTREaFBsVytpeksxZUsr?=
 =?utf-8?B?ZS9GSVkrNWtXQzdVNXFQVmV1c2F5ME1mVVFMWGlCVmZmZXFZbXZ0UWVJVTE4?=
 =?utf-8?B?TTE4V1BoUWp3d1FkRzRVdHozQ1NmQmpyMzlUVTBEdlRINCtFSjk2QytDRmVZ?=
 =?utf-8?B?REMxZGdtZmQ3dnhpU3crSVg2eGF6VDhOQzNJOHZGYnJEclBsWTIxTmk4MWdV?=
 =?utf-8?B?QlBCQnQwcStDc2dvNXJQa1BFSTdPQ3JnYlM0YmZtRUM5UE0vek5zd0Z0eEJL?=
 =?utf-8?B?c2svV1JudGpObWJhTGMvU3d0WTg1NnY5cFcvTmlUNHVPNzBEaE9ROEZua0lM?=
 =?utf-8?B?NmtoU3BWRHBvcXV1aEQyYzk4dlNzMnhyK3cwYnFacXVyK0ZUSVBlYit0VGFr?=
 =?utf-8?B?dzB5WWJxMW9FOFlYd1BleVp1YXBTWXl2VnZXNFVubVRRamxoUUdTNms2Rzdm?=
 =?utf-8?B?bHorTnZCTDhNNVJWdGtyRStPR2szWUptdVU4QmlpQ2J1Z0N0ZDVyalVwUmxC?=
 =?utf-8?B?Y0JoalpkNG9neHhPV3BjTVVPWXlkcld2NEEzNmhRNmtPZU1LcE5pZGhUb3No?=
 =?utf-8?B?T1R3TmRpTlF6SUYwT2ZnNEkySDh0bHJQSko2UlJsUkNidWlXaHZvakU4dlJ6?=
 =?utf-8?B?bFA3U2pGK0d5MXh5Q3llNmc2QW0rd2piWnAwNTFHcTBoT2VFNEcydndYbUE4?=
 =?utf-8?B?aXZENGcydUtKMVRpWEd5ZTY2ekw5Q0F3WVdJajRwVTI2TXlzYzR0V3VDbCt6?=
 =?utf-8?B?WkFMS1Y0SFowSmQrTEZFYmNndWFKUnVOWWNFQkh2UVZLbXhHUUJrQ3EyZnBS?=
 =?utf-8?B?K0g4SGJCNjJFbmRFbzd0bmZOVzE5b1JMSXFGZnlsRzhaRjhoM0xxTHV2NjJM?=
 =?utf-8?B?L3hmVTU5bHVNM2lNUTNGL0MybDVMWVRka04ybXhIRVQzSUk1a0xlUG9SVy9u?=
 =?utf-8?B?LzJ1Z2RyeUljSG1UOGVGcDFXdS9MWi81TEVwY3pIdHFpQmpnT1RZWk03V1Vv?=
 =?utf-8?B?alJ4MWhpaU11U2wrK3VPeVJtZU1pQlRYZStDaERWTDQ2bjdUMTJCa2JsNnMv?=
 =?utf-8?B?L25lbjJPcFkrdTc2dEhUVnFMWUhLemhIeDdjd09PdU83c1pBVER0a2gyY25u?=
 =?utf-8?B?U2JaaUdMYUdJSlR4SzFSWlRLdkFLNkNIbEJvZlppU3FDMEdYNWlQTUdvY09j?=
 =?utf-8?B?bEdKcTZtbUlqMzBxRXZaY2Vpc0dUYnRZS29sOW9ucm8xTVZtdXhRb01uaUhy?=
 =?utf-8?B?YlcraCs2YzA3aTlOU2NzVk1nRWhNWmdIbXVpSzlwNjFuV2c5ZFlNdVFoQ3lo?=
 =?utf-8?B?SGx3M1VZUjRpSzVPbUxPM2xndUNnM01sQ1pZSUpGb2hkY0UxN3M0U2hRYStZ?=
 =?utf-8?B?YUY4bXlIWVlyZW5rcU9WaklBaTJoM0wvWEh0NkN0dUtjdTVPMWZ1QXZrYUtM?=
 =?utf-8?B?UGtCZXZNeDVGSDZQWWFkY1ErRlphQ1dqVjlKZ1F2Z0JQRGJRdnRMTUkzWlpz?=
 =?utf-8?B?TFpEU1BnNnNNSTc4SU1jcEo1bEdpZzl0QkFrYVREV3ArOHk5Y1hGSDUrN0s2?=
 =?utf-8?B?N1YvZE1rSVJ3aHFzVjA2UU16NnF4ZEgwcGFNU1Z5OGdWTUFLZE9DR0lxQnc1?=
 =?utf-8?B?WUhCNnM0aDY3ZTM5Y2hCYnZxOXAwVTI3eUFmMHAyL0U2c3pMUVFlckhGMEky?=
 =?utf-8?Q?bZfI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55ce437-0cc5-42d9-8169-08dbe1630cfb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:32:54.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp7L02Ubkxc7Ygfyrl2yDLFmiuPG7N91zIvfyztBfOMAOphYvVQgul5+cQjriTHC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> MPAMs RMID values are not unique unless the CLOSID is considered as well.
> 
> alloc_rmid() expects the RMID to be an independent number.
> 
> Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
> allocating. If the CLOSID is not relevant to the index, this ends up
> comparing the free RMID with itself, and the first free entry will be
> used. With MPAM the CLOSID is included in the index, so this becomes a
> walk of the free RMID entries, until one that matches the supplied
> CLOSID is found.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v2;
>  * Rephrased comment in resctrl_find_free_rmid() to describe this in terms of
>    list_entry_first()
>  * Rephrased comment above alloc_rmid()
> 
> Changes since v3:
>  * Flipped conditions in alloc_rmid()
> 
> Changes since v4:
>  * Typo in comment
> 
> Changes since v5:
>  * Reworded two comments.
> 
> Changes since v6:
>  * Fixed a typo and some whitespace.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 51 +++++++++++++++++------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
>  4 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 97ec24f91ac4..2f1d4f141dab 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -545,7 +545,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
>  struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
>  int closids_supported(void);
>  void closid_free(int closid);
> -int alloc_rmid(void);
> +int alloc_rmid(u32 closid);
>  void free_rmid(u32 closid, u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
>  void __exit rdt_put_mon_l3_config(struct rdt_resource *r);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c02cf32cd17c..3c9343dffdf7 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -344,24 +344,49 @@ bool has_busy_rmid(struct rdt_domain *d)
>  	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
>  }
>  
> -/*
> - * As of now the RMIDs allocation is global.
> - * However we keep track of which packages the RMIDs
> - * are used to optimize the limbo list management.
> - */
> -int alloc_rmid(void)
> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>  {
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	struct rmid_entry *itr;
> +	u32 itr_idx, cmp_idx;
>  
>  	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? -EBUSY : -ENOSPC;
> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
> +
> +	list_for_each_entry(itr, &rmid_free_lru, list) {
> +		/*
> +		 * Get the index of this free RMID, and the index it would need
> +		 * to be if it were used with this CLOSID.
> +		 * If the CLOSID is irrelevant on this architecture, the two
> +		 * index values are always the same on every entry and thus the
> +		 * very first entry will be returned.
> +		 */
> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> +
> +		if (itr_idx == cmp_idx)
> +			return itr;
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +
> +/*
> + * For MPAM the RMID value is not unique, and has to be considered with
> + * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> + * allows all domains to be managed by a single free list.
> + * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
> + */
> +int alloc_rmid(u32 closid)
> +{
> +	struct rmid_entry *entry;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	entry = resctrl_find_free_rmid(closid);
> +	if (IS_ERR(entry))
> +		return PTR_ERR(entry);
>  
> -	entry = list_first_entry(&rmid_free_lru,
> -				 struct rmid_entry, list);
>  	list_del(&entry->list);
> -
>  	return entry->rmid;
>  }
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 65bee6f11015..d8f44113ed1f 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -777,7 +777,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>  	int ret;
>  
>  	if (rdt_mon_capable) {
> -		ret = alloc_rmid();
> +		ret = alloc_rmid(rdtgrp->closid);
>  		if (ret < 0) {
>  			rdt_last_cmd_puts("Out of RMIDs\n");
>  			return ret;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 22dbdfe569a1..9864cb49d58c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3300,7 +3300,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>  	if (!rdt_mon_capable)
>  		return 0;
>  
> -	ret = alloc_rmid();
> +	ret = alloc_rmid(rdtgrp->closid);
>  	if (ret < 0) {
>  		rdt_last_cmd_puts("Out of RMIDs\n");
>  		return ret;

-- 
Thanks
Babu Moger
