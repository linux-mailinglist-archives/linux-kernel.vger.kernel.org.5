Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A97DF326
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376416AbjKBNCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:02:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345D9189
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELFjWaQLeXuo9AZ0dtoyjpMaRgtt4yuHmaFOWXtAEL4RaruxTuMInaVkPAsaGERCOtt/TczdMPsvoCVPOSJm9WoamrVZPCHCHq9bgFTmrgnOf5a0K7N6vPQICKnlNwvMCmJ160C4JKhejAprAZAi3J2rqP5khGtn1VNVGeLaawRV/+UIo05D9HRkBxp/qtoDUSp6ZJmeVKRBfoSRN0Fh8vaWz1XhaZtW9WEjUZqVqZB/9ZfGkGn+sTluwEdxmI16bW6H+TlHVdr0Cj5Nym2z83aIivCY1vrqgp7nL5Zn3RG66VjLhC399+qG/IPKGGQGO9dEuogR3dlxaJ+PNbs28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWDPUv1ZypQC6SeMpVx2QV4qWPDizmY9M3Y6MyuJQWQ=;
 b=gnqkWtXD772qNbaUQOnC1g/ABpX6EthzqlgmvZbNMD6mXvVQj3/dRbWtRJgK9VC4p7MEryc7PUZ5PqAkyBx086oINKCkakllSx9wCUa1DAcsl1EEL6BoYZhg5JmSDdKO3MSxac7gUr3AfejJFgu3FmUWBnzUqhoy//NypmO+2F9W1fXVd+3gRVzQHB5uTE32yTt6cEjM2MHF2Sz3GMqQt2Eh+JcfPbEAv3VWI4RuPdplSpTbq077Btf//jj5qxldvZrepdjszfuQMQjdbJfVn2gUE+0Mtedq0kyxeYLGyXN91PB0jSz4jI4R5mT2E0RiaAMI45DGPV01MC38Mj/qOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWDPUv1ZypQC6SeMpVx2QV4qWPDizmY9M3Y6MyuJQWQ=;
 b=0gVbQWRZsp31cXzHeNR0Dc3TVVLR8S2lkoBPei5+rhg77HucHpUx8+Lq945ARykXE7YvbExcV6rIwMix8FhgFSGBF0FhPJrgq35CK8R3sA5ZCWGbtEo6/TclSnnZ+AaqIz31wBnDMJ48vQS1juj7m80m+LphjX/e1tzEpaFKeek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Thu, 2 Nov
 2023 13:02:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2ba5:fd62:f75e:cf66]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2ba5:fd62:f75e:cf66%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 13:02:39 +0000
Message-ID: <79afcda4-507f-4439-9093-814a6f6b2926@amd.com>
Date:   Thu, 2 Nov 2023 08:02:36 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
 <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
 <ZULCd/TGJL9Dmncf@agluck-desk3>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZULCd/TGJL9Dmncf@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0123.namprd11.prod.outlook.com
 (2603:10b6:806:131::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 3045687d-c022-45ae-d21c-08dbdba3fe02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8klCSHIvfOINBgtVMIz02aE7QPDhdHMNFcmbMTSR0hsVmjp+QQ9W2SDvzAVAtcMgj3SH/2nsrpjveO6vcbDEY5pABy9IPU2OwjcUcA51pG/D9HO4l3c+jcuASo72xXxMaq0x1mXHwBCK+5+pnl9BxvzoW4nmg4ym+fL77NjL1nPxYnpOoDR1g8/SY/9VP1Fth1FZEoxFq3T+qGa2BYM/7qXnAQyp3VvKCFES4O760QS81ApF1ZCoEGX6FZS2HG66u5lu4mF1zdhvVfyC7I/y1Vk0RfWzfra2oERtDqgIXe0qznNYC+4LjY8bAJYRDEBReMumCB8ui5XU6HJOQZ5J2GF+wgMMIs7f4keCMNH/l3aqT3hHMkZXYx+kvR/lLvqKE/KFiBPh3HCmMK1mOxMZI4gQuKW+rE4lGkrqWygg7ikSEibWiePwSwJm1G5N497DC0bxis0U1C4jrVqGbflamTEJCJ4q4CIXlr3Sy0EcXN1J6oB5VAtjGZnoQlgwGNnWD1TfvX/ZZEHgmjRXf92MUxdbMRTLxmSEHD+57B8/onFpCGsHNcdvqsUZ+M7IGLgZ4pgX/by80C/8GYfaTXQskGeRRgaqSYeXAdFFElzqDTOgdq7mMVye8ZLFiDK/q0iBZKUReHHcajUCR6UAeyBge2oaLRNhodi6z0Puh/KHBInxC4rP00jSAGehom97xiSS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(31686004)(2906002)(6666004)(6486002)(86362001)(36756003)(7416002)(3450700001)(8936002)(8676002)(4326008)(31696002)(53546011)(2616005)(6916009)(38100700002)(478600001)(54906003)(6506007)(66476007)(316002)(66556008)(41300700001)(5660300002)(83380400001)(66946007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1dsQWVuM3lwRDVNNzBmeVo2TDN2VFFyY3lSN0hRQUI3R0ZmQ0tzaWRValF6?=
 =?utf-8?B?eFJMS250anN2STRuVXVINzZJVXVOVlQyV2RTMWJodC9QMy8ydWovL2FkdXQx?=
 =?utf-8?B?Z2FyMzhtU1BsbkxLUlozbFFUNDFVTHh1M3pONTNIMGkxQ1R4WWpadVFBRHlh?=
 =?utf-8?B?Z1hXM1IyNDRVTDdPUHkzYXVwZ1dzdU41TXE5WTZIQWVBR2tXTkhaZUVCVDZn?=
 =?utf-8?B?a3liYnJKSzZkZFNQZW1JQTBUckdVMENHeEFFVW92bFlFVG02VUlHZTIrMU1T?=
 =?utf-8?B?STNJSHIrKzRpcGxpN3ZuSlRhZEdJanZIenJTTWhvSDlteG84ays3MHNlOHU1?=
 =?utf-8?B?YVArR21nRmlQQWZHN3poMFQwc1VuTmZmczRUS2tRTGQ0MjRsV3BMVEZkQ2gz?=
 =?utf-8?B?VDhnVlBZZEoxS21oNFZqV2NRVWg3ZGxaRG5oK21RRHlHOUtWN2VZeHo0eUVG?=
 =?utf-8?B?eXhEOEVKTlBqQVlhV2hGeG1CMjNVZHNqRkZTZmlndVNjNk1NN1dtL3k3a0ZK?=
 =?utf-8?B?aDk3ZGlVVFZrNUF0and0K0NlRlQ3UGJuUG0rSGtZRHdVZTYxZlhkbnNKbFoy?=
 =?utf-8?B?Qkd5dTBWZHBua0JEQ0c5cnlVc1B5eFVDbUQvRGVuNkpER1h0ZjBQdldLNnY5?=
 =?utf-8?B?ZDZnQ1NiSU01RWFqdHhHbDFIWHJyNmFMNmx3ODl4RXcvU3Nrd3ltQXVZRHdE?=
 =?utf-8?B?LytzZHpjc3VINGZ1M2pCRFh5UWJGSDZIQW9hSGJLK3hqWXJHS1lpNTZPZzdj?=
 =?utf-8?B?TndxK0lSc2tmWnJNRHVUNW1nUXdxZW12d3NTQzZuUmUxeC9hcCtlQ1VJV1Jw?=
 =?utf-8?B?NDU3Zm5HTHFjd3REeDYyK3pFZDIzWFpvbXV5RWc5K1NaZkxnaURWRXd3bGlx?=
 =?utf-8?B?UjlqOEdhNjZneDlJTytVL1BQcVoralpjZnlEOFYwRXhGYkQzOUVqZmRaeTB3?=
 =?utf-8?B?anBIOGlJWVpoakJyM2hvNlNaRE5xTk9wR3c4T2M2aFB0c2FPMXlEWWFzK1py?=
 =?utf-8?B?OHhPWEt5NysrQXNIdWZTUGxsL3Q1RjExWHBUSzlSaFozQXdOVXhHNkFGVnZ3?=
 =?utf-8?B?WjJSOGhvZ3NpZkYzZDJBU0xrNVVSamdPcUZGemFhY3JNTmo3Tk1XZzIxTlZ0?=
 =?utf-8?B?QUowR2NtMlBZdkdsb3ZpVGFId21RK2IvdVFxQkVpLzdHY05hUTQyTVIwUUJu?=
 =?utf-8?B?REhscTNlYkl3cmdTTUtPOWdEWmppT0tFZFgzQU1aU1RIb1V3UzA2QlVORVAx?=
 =?utf-8?B?b3Q1V3VneHZBN2xxSnE4WEtUeFdmRDNYWFFNbWk2RkNaZklvbWpzcGl6eXY0?=
 =?utf-8?B?WGZrNDdHR3IzR1c0SFdzR1Fmb1NnUVJhVXlkNnlzM0xjbWFGSFFOVDU0LytM?=
 =?utf-8?B?dDU0M201KzRTb0pjeXBrNWl4QkdQR0lJbStYL1BjY0VjdU9vZDU3OXhxMm5x?=
 =?utf-8?B?SklpRmZNOU9NQnVqbjIybDFrQ2F6dWVacUhDV1F5MndFYms3NXhucVUyWitC?=
 =?utf-8?B?MVRqNFFFSjMzVENndVZpUEFOQUNRQmhQUUhkajg1OUs5QStpa2dXNHdNeE12?=
 =?utf-8?B?MmFTK1FkMEpDdlFHWFZUZFFsMjdEcGFoN3JleWxTK1JrcFJ2M2IyTjlwUW5I?=
 =?utf-8?B?Vm9hUEk5UG9ScjVuUDdmNzNZS1d4V1AwbkY0b3JLcFU3NGkxV1MwUjNQOFY0?=
 =?utf-8?B?cmE5NGkxQkR2aG1aMGJYMnp2TktxWFZOR2VnRzEyOFY3UnVsL0o5eWRMcVlL?=
 =?utf-8?B?U21aNWdFVlU5Vm9PTFJuYnBXMnN6SEk1VGFaRktYYldXd0o3TjU5UFc2UFVJ?=
 =?utf-8?B?SWFvYU9iSnU3dGR6b2hVUUVtS1Q1SmpWOHpTTm5WZjZUTndBU0hySkhEd2JR?=
 =?utf-8?B?UUR2UG53QlJIaHcrOVBNeEh6MGV6RjV5VXdHdGsvZExRUW1QbloxSFlnYjl5?=
 =?utf-8?B?cTNOTDB6WmJWckpZZUo0YWtCQkZkL2FyQlNJUFFaTTNYTjNNS29mTCs4S2xU?=
 =?utf-8?B?d01TaVhUeDVzejZ3TFNzM1hwQS9jdnBBa2YxbmVWN2ZGM0pwWDhETzhoK1Ra?=
 =?utf-8?B?WkdBSXlvYXVnVlNpRTJUK29KTXlBcVYwNE12TFQrMnR0dWV0d25jY2l5NmtQ?=
 =?utf-8?Q?VQFI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3045687d-c022-45ae-d21c-08dbdba3fe02
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 13:02:39.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkbF5HeQacoWFFQXJ9OhmhEdnkch5wT0ToVSPkSiIV1iJYoRnudSzYMnJfvb2LXF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

Looks good.

On 11/1/23 16:26, Tony Luck wrote:
> In a "W=1" build gcc throws a warning:
> 
> arch/x86/kernel/cpu/resctrl/core.c: In function ‘cache_alloc_hsw_probe’:
> arch/x86/kernel/cpu/resctrl/core.c:139:16: warning: variable ‘h’ set but not used
> 
> Fix by switching from wrmsr_safe() to wrmsrl_safe(), and from rdmsr()
> to rdmsrl() using a single u64 argument for the MSR value instead of
> the pair of u32 for the high and low halves.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v1 (suggested by Babu)
> 
> Switch both the wrmsr() and rdmsr() to the 64-bit versions.
> 
>  arch/x86/kernel/cpu/resctrl/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 19e0681f0435..d29ebe345de6 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -136,15 +136,15 @@ static inline void cache_alloc_hsw_probe(void)
>  {
>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
>  	struct rdt_resource *r  = &hw_res->r_resctrl;
> -	u32 l, h, max_cbm = BIT_MASK(20) - 1;
> +	u64 max_cbm = BIT_ULL_MASK(20) - 1, l3_cbm_0;
>  
> -	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
> +	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
>  		return;
>  
> -	rdmsr(MSR_IA32_L3_CBM_BASE, l, h);
> +	rdmsrl(MSR_IA32_L3_CBM_BASE, l3_cbm_0);
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
