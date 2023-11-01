Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9B7DE72F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbjKAU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjKAU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:26:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C70124
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwnuY9Ctb/WUshtX97EllodJH4QDG8K3spDbIGyS6RYi3XUnRJRWouZ/8d42G4BhNLTgaLh//X+FhC7Q2NLJaCtJBNVZka6a0puXyLNnB7XOnEXBx9hpLTEIclQu+497zekQAUF955yN0XxGpGpgIz6R5fSnOLjiO3Ia2BU/+rG7rnMPquVwrklwk83ND9dBJ3HzNuBAnb5PBw46JlfeHaBlsbOid21oIFhfatPiKUqVRmgpqEQIrH2nbVG3gu2UB879PENu9L4cpN3fLv7a4jfKRtptuggkLQjw0k4NAHHKprjqVNp3Y6J4I4tjxOKqCogkNGDpjRA4HB7c/TPT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UkkqjQIGeKdDL/p2h67CoF71A7nFgwc++Rtnqc/JRw=;
 b=ls+QQDaepnGv2FiyRwari//DMWsUw8Dxi8DQ8GHtqPFmVasRgF0nQYUz8AoVJ1lmMnB9ldtzlqrhlnKVtIr2+qzdAdDac6OBy+PSPdaDptc2CsiHUST9tiu82hOeF/ta3V9UNWqhCWTSklrJBZriDTrFWrNnHbWT9ie1XJfCmqAy5UGAcxd/Yn3UhjGe1Sp2zgvNpiciwrTH/60lFigjq/qckEi6qeUX/z3pUvRtiMmQi32cS2ca+4BIX45oeOzIm48HctOh9JBSt6gNNt8+f9HAXmxYa0B+yX9Z5gduJ6GxJz32GKyX767MoDXySPtx8+Ib8nqixC/P0BCV5TNRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UkkqjQIGeKdDL/p2h67CoF71A7nFgwc++Rtnqc/JRw=;
 b=XRJ4pem8rJHbmnoI9QekA3zJWGuWf0Gy0sQ/VN1suBTS2P257p1oXTChCILix4193x6WxnBmkVnf7YVVPPHCzjh7PmbQUoihVsrA3RH4kVbyac8rCowzfLWrHcC9bP9y9+OgVVeQd3rtEWHE1KcACOhAppMgMEMnt8HIRckci6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:26:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2ba5:fd62:f75e:cf66]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2ba5:fd62:f75e:cf66%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 20:26:26 +0000
Message-ID: <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
Date:   Wed, 1 Nov 2023 15:26:23 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20231031220534.37730-1-tony.luck@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231031220534.37730-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:806:d0::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: de668b1d-8850-4218-86b7-08dbdb18d2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EWwo1xfPWoDeEG/mG2V6qUXLprGs/g+7dSNN2II/wnlmT/QUqS9EeBhv9ednnf0yJnT5jkH4VQm74cSbtCTp/KjqcPr/McQhE5EocRyYTrbPxeDDyLpu9Doj4PM1ZaYkk70WCl9JP8b2PJTqkhxce1lxmrgnXD2IkbnKklmOZkM10ET9PAhua/S369CNCUwXuHONOQaJ+Jg5OYOsaX1wNIw9qY0/d1zgsSMtxbHgZyGM+fNxRiJFej/6tSObB8bfxRffP+xCR0vSbt+cNFby1X3/eVu08lgYYTsBHND/GOJ6wYY4+eBNN20P9DVrPjpfmF+aT5/Ltvn/gKKFXYYY0wFrnQDf64BbknmS0xkXkawve9aM42/rcXeOeb7G7MS1EGTo+/+s4Ygl64w0TvfZEZ25KuyCPahhXmjEBtGDi4g5VoAj4np++l/MYxpEW3wnrpciKAPt2PCJDAhldhZ9vKBS1oc6SF4otm2A8zqCxRZkPUZ6fH/nCE3zmgyrUmnOKQv+OWknsT/v6tBYp2MaCrH52oNHrVQ5yTWj67IZ5A3Day0qHNZ3mZ6vwoSw4Jvo0lDJWuEoqfh/qXhD/fRJ+sFiFKAL4lRFEjUZolLdpyq3h7sgWfuodVpLlDR5YAxyhyjI6aEgUJddnnVlvkqz/qF6wj73IHE5E/bl+vf0Jv2l39JaQZ4uHGECIKnNjgM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(6666004)(6512007)(478600001)(6506007)(6486002)(53546011)(83380400001)(5660300002)(4326008)(7416002)(3450700001)(8676002)(2906002)(8936002)(38100700002)(26005)(110136005)(66476007)(66556008)(316002)(2616005)(66946007)(31696002)(36756003)(86362001)(41300700001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3piNWpGdnlGSlJXVzA4NjVNZXN5MWFUVDQvajdjMmsreWN2S21qK1hYSGR5?=
 =?utf-8?B?dURpRlRCNGZPZHh2NFdSNktMWFJvOGF3YUh4UTdkY21scXcwYkZiNHExQ24x?=
 =?utf-8?B?enZudTBIQWtVQjBhaGJEUWVNUVdNOERyNDZaZy9JUVVteSs4L3pjS3B0ZHBp?=
 =?utf-8?B?ZFlKWmNINjNEek5mVGsyM1I1T1FTM0gvamNNNzJEelpSWFpVSWkvNmxSY3VE?=
 =?utf-8?B?U1BrT2IvWFFnQ0ovOFBkZ1psSmdiYnJwYnNpeTBsSUVKcFdKV0o5MlBKMkkx?=
 =?utf-8?B?MkpwNFpjZm95aGMrVWU4NlFDUnVVekpJRjg0M3NYMzA4c2Z5SS9yNzBPeHpG?=
 =?utf-8?B?WTBsTnpVeHNvUS81eUZYWDFpNWpORlFIeVllcVkrdGx0ejQydWFqYVV4VjVL?=
 =?utf-8?B?cFdYNTJyeHVDcmo5a1U3ekhCdU1rWEZEcXI1aXZmMStmUkNVMDRJd3N3Z2Mr?=
 =?utf-8?B?Y2FUN216Rmx0VGI2bWFhVUhiMDBEMFlzaDhWQWxjUlVSay9veGlNVDI3RkJj?=
 =?utf-8?B?N2hBVXlYTkxKYVJUN3JtZmZRMG11b1AzMThRVTFuS2M0d2N4ZGZVKzhiOTdY?=
 =?utf-8?B?RzJDQVZ0RnpFQnArbmxlbnhyZmZ5MkR2Q3lqN2VyM3FNMUIxL0ROTXNPelVi?=
 =?utf-8?B?WXpSdXpDa1dSVUlNdDB3L2Fla01iQ0xiSnpSMk1kNkNnQ2s4VWFONkVTNnY2?=
 =?utf-8?B?d2FDb200QlJNMm5QOFJmTlNWaFk3b1JYbWNwbFpXSVptOTZYbG1MdzFLalc5?=
 =?utf-8?B?bHhwbVZHTUZzNnJ5RHp3Y3d2WjRVZzN4VjlPMURKQUdRdHdRcjJhRTBFUkIw?=
 =?utf-8?B?TUw1SHJ1WldEUnk5a2lDOWxRTnNsOGZ1OVRaeDFhSFpSQWt3ak81QUVvaEF0?=
 =?utf-8?B?MnY4VEx2ZWRjVU9xZGJtZWJRS0duY2lsR1FTOU9USjlZcE1OKzlvNHdQajg2?=
 =?utf-8?B?eDREWnBPSU83OGFvK3lqbGxmdUdjanRCdzJDcVdvbG9PTE9ra1JrdTFsMm1p?=
 =?utf-8?B?TkNoL1M1RGx5RWFmTzEyM0FoOTNjVFUrRWhJSjB1Z0c0THJVbHJoOWJkb2FS?=
 =?utf-8?B?Q1ZieFduTk01MU5DSnQxQ055N3c5bFpmakxGc0gwT1psVVBIaHZoTmlQOFo3?=
 =?utf-8?B?dXFLd3F3a1ZENElPaXdVUVRqZHBjQzNQUWV0VVBUbzBvUFR5QUtSWU9qVDVR?=
 =?utf-8?B?R2gxaXNLaHhSZ1VMY1k2eXJ3Q2d6dTJtZmlLVGp5NDBOQkkvcStHcnhrM0lp?=
 =?utf-8?B?bnVBdk5RbnZ2U3VueHBYaHhTVFA2WW84QUhtRXlBVHNJQ2pJTC9DNUlhVlB6?=
 =?utf-8?B?L2RzQ1dPc2xWUWZTNzVMSWdVanNDZnExNU5XZjFYN25EVDVJYlZRT2NlSXI1?=
 =?utf-8?B?MkNadGZCZmpJWVNqa3p1Ujl4TmFxNHkyckk3K0k3TmV4bVVnRWU0eHJvbW45?=
 =?utf-8?B?WUp6Qi9JYzRxeWtnSGlKUmFrL0RhbGVDL0FwTXRsdy83aHdzdldnS1pWSmVL?=
 =?utf-8?B?cFI3b3crK3RCdW5SVmw4Y3pJZGMvRmpPYlBLNTJDWlZBZVczVTVhQW80N2dY?=
 =?utf-8?B?Nms3Tmd3YVpoeVg4a2VUWjc4VFp1VWZwZFVnR3RWQjRidFV1dGZCVWpwTjB1?=
 =?utf-8?B?SHFVRFpNTU1BQ0lteDFZK1dHNFVPSGhSS2ZYUmdjd3kvZ3VmdGUxbGJ2bkg4?=
 =?utf-8?B?YUZ4OUZSMzBjbU5oK1gram1SKy9xenFYV0Jmd0w0YXZncUt5VTYvcTRoRkdC?=
 =?utf-8?B?cnBhaXFieWY2ckswMDg2L1BGMlBCeHhjbnFkQWJZL1BnandZT3hTVEJOSDVK?=
 =?utf-8?B?cnNMSXlyVm1lQmZMRkNzdFBYcVR1bEJTUXduSUlad2pkdzZzaUN6d2lxL1o2?=
 =?utf-8?B?UEV0MjN5NDhUa1pRcTU1dUJwRUNiM0VmN2ptS1c2TjZKY0Evc0VBVVFidUlu?=
 =?utf-8?B?VzNxeFVlcUZIbmJkdEYzb2VuSzBRRmJiMXEvaC9TdWdLOWhJU0thd0Q2R1d4?=
 =?utf-8?B?c0R2anJXWXNEc25uTFM4TVIxbXIzQ29hVUdveC9Ca0Vqck1kZm0zSmF2U1dp?=
 =?utf-8?B?SGRETVhKckx6NDVHUmFoMzhJc3lhUmxQVFZFeUx6eG5MbitTd1poYk9RS0w3?=
 =?utf-8?Q?KFqI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de668b1d-8850-4218-86b7-08dbdb18d2a0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:26:26.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMrkQTA5mX4JQICnJgIYfQ05wsEfhz3oBb/COyHCz/czdykxMZILbVjVnp1OoyBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/31/23 17:05, Tony Luck wrote:
> In a "W=1" build gcc throws a warning:
> 
> arch/x86/kernel/cpu/resctrl/core.c: In function ‘cache_alloc_hsw_probe’:
> arch/x86/kernel/cpu/resctrl/core.c:139:16: warning: variable ‘h’ set but not used
> 
> Fix by switching from rdmsr() to rdmsrl() using a single u64 argument
> for the MSR value instead of the pair of u32 for the high and low
> halves.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> This has been annoying me for a while as the only warning from the
> resctrl code when building with W=1.
> 
> N.B. compile tested only. I don't have a Haswell system to check this works.
> 
>  arch/x86/kernel/cpu/resctrl/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 19e0681f0435..4084131d391d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -136,15 +136,16 @@ static inline void cache_alloc_hsw_probe(void)
>  {
>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
>  	struct rdt_resource *r  = &hw_res->r_resctrl;
> -	u32 l, h, max_cbm = BIT_MASK(20) - 1;
> +	u32 max_cbm = BIT_MASK(20) - 1;
> +	u64 l3_cbm_0;
>  
>  	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
>  		return;
>  
> -	rdmsr(MSR_IA32_L3_CBM_BASE, l, h);
> +	rdmsrl(MSR_IA32_L3_CBM_BASE, l3_cbm_0);

You are writing 32 bit and reading 64 bit. Why don't you change both to 64
bit?

>  
>  	/* If all the bits were set in MSR, return success */
> -	if (l != max_cbm)
> +	if (l3_cbm_0 != max_cbm)
>  		return;
>  
>  	hw_res->num_closid = 4;

-- 
Thanks
Babu Moger
