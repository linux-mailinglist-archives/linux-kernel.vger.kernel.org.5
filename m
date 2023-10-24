Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF757D5CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjJXU6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjJXU6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:58:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8CEE5;
        Tue, 24 Oct 2023 13:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJJZkI+E6B70cwLuwkzJztPpydBmNN2zVZWw2Pq+4OISX1g7M15w73xKjPFVERAKv4yn4GHXZQlszBRD2OBFSzAbEIf5YLIISBLyKvU4xKhdmczYt6KarqDdP3zdz3gSg/0P6ZADbLXX4iQHAjsimny4zclIZxnGleSHb0ElvrLi0zimuAi0w/ndMNPLrl88hhoD8Fr7Dyp4kq+zro2zbMQNNlhWycFLWhqLixfXx3qz1HAUOTu12vLXICgHFo8Ivq4Le3jWtAa6ko5pHwCK4dcDdgTzNVvEGYJrvNPOG5Zg7XnZzkhf32C95ApS9WOHwN0mzBfWTscC9CHmrOfoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTuw1hZXtOTINltcUsdgTW4XtPdXmLCObXPMnryJKKU=;
 b=XTen9RjhoHMC0N+69cNq50pIT6Q9X3abN0P0SXMeVTv2+bGZk0FkaunbRRhxFNgFr7gnaOD4vYwMaZPytOMUoeKPZMaB/T3TBYnAy8v3w1jPBUJG/K7hWJA4+O6zuB6mgrAijzbVIjNcDsX2KcLRufxWUMFGAVXfmqkzKrXXQvk9QMSnjAVo8qy1Q83ej7mJY0+40HCLVOGIU7neFWOdlpXgBlXeUK6AZJhAAEd7BUS+06rXYNGOF3pw/qkoKAYQQbEydFYccHHlJXOyhSjs5wNJ28zm4X8Fx7lGHxEDWQJnzbgrrPOMp8Q/zPiZTCCzuaUV82bE4LPW26RM9tsKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTuw1hZXtOTINltcUsdgTW4XtPdXmLCObXPMnryJKKU=;
 b=1OR2An/b5hQEL5gOInI5bgZvRCe4QvSIfSOwRQKvInhnvrP93J9NqFxMeZLjTVobxn3cbf0Aq8QIyt73EL+bi/QZHshDpg+xKdiIKu21hpBCyRE0liROGM8FEzo4xsNry5EMvwPpAcT0jcnir5L8d7o9oOE+gRVgjrjmvra07G4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 20:58:03 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.6933.019; Tue, 24 Oct 2023
 20:58:03 +0000
Message-ID: <c50f2d3d-98dd-4194-9080-81298dd0563c@amd.com>
Date:   Tue, 24 Oct 2023 13:58:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd/pds_core: core: No need for Null pointer check before
 kfree
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231024182051.48513-1-bragathemanick0908@gmail.com>
Content-Language: en-US
From:   "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231024182051.48513-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: a31801d8-21b8-4ce6-fc2b-08dbd4d3e9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG6H9zH5Lj4e2vGcxXKamJ6Jrfl2tFMu9XryWmMl1AQx+6Q5eZ0bDH2c4EvRHYx/HH4Bhc8OoL2dUgZzlMI83mAtJmbXly9x+oRhdIcOL8ISXzjdMGxntu5qmOZeVu2PyaANHZoZSEhiJ4hptv+qhYvSJR6f3yrPK+QyIxBpE4F18mLulYLC7ovVL1ndxJNIjkDaJADXdzdLvvwD0NYrs2XPqMfbLIzPJq4g5nLG5pAoq7bBox90YWdK2ZyFEGemL9FU3SeHm0EgBq2HDh557mMSc57LNyN2XOoTsFGi3xYwxk7wGwGcv79F8Fc2MsQirpPl5ql+Fy70kE9siC3jt41+OzWTq6sJ0e3rarHZiAtOXWy6CbWvlxEcvIpy2tRliFxg+4DEIvsfDOnDHJizzgORHIa9nHGy2drtsMEuEUuDCznHLYN5jBOBjpls/E/iNvxIhoZ8z6/LdVyQmry9b93gjYH9azNKnLHSooCOpRhdmRukFlZPMomQSI8SUMcv+brTIFwqz6mNmIADZVCgFOGxyo5SJaC9PNe6+s+BD+e+GN/rdzk2XBGjkuy4KBwaDxQJCRJhNnOPWnqqaB37usacjNO1yLhXQhOYk7GT86mR0iBhvNiPT2o2inqcciGETNd3+nntXl/4fvPzfcsXqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(31686004)(2906002)(36756003)(4326008)(8676002)(26005)(53546011)(8936002)(2616005)(38100700002)(6506007)(66476007)(6512007)(478600001)(6486002)(316002)(31696002)(5660300002)(86362001)(66946007)(41300700001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJKSlc4Q21mN0lVV2ZKdVNkN2tMRzBPNTVjMHljUEY1U3VnTkZodGVzNFVE?=
 =?utf-8?B?MGlxRDQ5ZEtRa2lrWkhJMzZmMGFTYlJrTDRYVDZwZ3Bab204MHYrVlpuSFow?=
 =?utf-8?B?VUhIQUlLMzJ0QnNQaFZWTkkzY1FTT3c0ZGhXbU5kQW5LdTB1bmQzbExyQ3dF?=
 =?utf-8?B?aTJzWVpoVURaai9RNWJQVU9oS3ZHcjk2VlZoY3ZOZlhRS0d4K0wwbEh1VlVM?=
 =?utf-8?B?RWwwOHNOaG9QSUJ6eHI3cTBoYysyY0YvSDdIaW5jbjF1K2VNVlQrNkFEOHJW?=
 =?utf-8?B?RjY3WlhKWGxjbmdOUWNrYk5pRGFsOHQ5VGN5TDBXYTYxT2J5VEUybm92YjNn?=
 =?utf-8?B?amZzQXlIWlRwd2JtMzJEeWl2VUVPc0sxdkdnOHQwVVZic001SE03T0xmdjc3?=
 =?utf-8?B?TTFpcWxnUHFka1Z5ZVFFZ2c2OTJyWFJxZjV6U0JPYVIyZ3F0QmJCYmxLS0Fa?=
 =?utf-8?B?ZEw5NlJXdkpHUWNRT09mU1Yzb3FqTUU0TmRlbGJHOWJDN0s1VGJqQU82dUxL?=
 =?utf-8?B?LzJVRjBzR0dVcDdOUjVMa2pJc3JhMUNUS1FJN2hheEVsQUlva1lRWjF0aWNK?=
 =?utf-8?B?amVPUS9LV0NIRUxUV2hKYmpzNm9NdUVSMVJGMFZXZ3pVOVFCQloyRGtiVERI?=
 =?utf-8?B?ZVExOUh5QjZRMmlBUDZtMngzd1BrNFl3azhjblYwdzdhK001SE1sUjB6enpU?=
 =?utf-8?B?K2tvb0s0RDEwK0Z3N2t4R3QwOU1vS09LUkd0bFY4UTZKYVVKejVLUzVTL3JU?=
 =?utf-8?B?d2tEQkcwWk14UjlMQ1BnSWlxVkt1cklRSFpERllZeXU2YXcyOG9FZG11SkJK?=
 =?utf-8?B?c0hGSGEyMEN0UTEzT2h0SG5UM04xVmRxUHVMMVQvRjl0cGlKUUI2UnNkZmc1?=
 =?utf-8?B?TEJwN2xtOVFQWmpYRkJsTjU1UkpxcitOSkJ4dmFacEtwSHVOb0VDSEhjdjZn?=
 =?utf-8?B?YjRpSlNGVHhQYUJJNFNiSFE5R1VVK1ZiWHJvMi9hZ2g2b1A0dVZaMzNmM2s1?=
 =?utf-8?B?Y2JxMHVtbVhWaXorZldZWXk0YWNqNVE1U2pIcVNYTkhlNUFKbHAxbDVMeVhB?=
 =?utf-8?B?V1hhNyswKzg1NldSdFZ1MEhZRnRXdGp3aUZUMGExbFkwYTJZeXZtYWE1Mkc3?=
 =?utf-8?B?amVNYXRiT3pQUFc0MjgxMHFMRjhCQ1hZT0VOemIxeUlBNC9nNmRBaUdaeVNa?=
 =?utf-8?B?SXVHKzlZdzc0a3NwK3h3TlJOMHhSUGlYRHdLMEdveC9TNDdrd0RyL3YrcFEx?=
 =?utf-8?B?cmNjWWM5T1NSNkVVM1UydXEyTzBkb25BeVhMWmNubWdqOW4zWDJTTjZEbktW?=
 =?utf-8?B?UXZpRE5HSldtUDR0K3MyKzhURmFxOXd4YlpkZnBwZGZPNmVYaTl4VlZvY0VX?=
 =?utf-8?B?dFRoUVd1aW5jYWY1UVl2T0E0QXZwOUY0aGpUM0c1bHBOUFYxZmlEeVZLNkNV?=
 =?utf-8?B?RFp4VjdTbmJJQU5BWmtjbE1PNkNITmtuOXhIdVBHS2V0YzE0SkZETVpJdXpS?=
 =?utf-8?B?WlNGZGdhQldDNTR5TXlEcGhjZXB0VWk2TFZtS1d3OEZzbU9GMXJ4K1dFQ3Bj?=
 =?utf-8?B?MENTZW92cGpBakkrTk1ZZFdEenRtbzNab2RqeExqUnVFcnFTbmR5ekhBeGZ4?=
 =?utf-8?B?Um1CQnoyVERDVGplN2QzaGdlYUtYbFZDbExKRktVVVNWOGN5dUw2MzRXNDVG?=
 =?utf-8?B?ekRqMnJBNnZrQ3FlckVDbWg0L1dJM1BpYVowYjJkYlZJY0s4L3NNY3VmWDNl?=
 =?utf-8?B?dG1KbFk0ZnUzNzFqbjFEejJScUVPL01XNGsxU1poYVhqQ3dGa01Hek05MlBW?=
 =?utf-8?B?QzdRRmVmVXdwK0VKUEUyVHFkUjlLZWF2OVRBc0EwSHQ4dUVucGtkS05JdWMw?=
 =?utf-8?B?aEVnUXBVc0ZXOS9LcDZSZHc2VHh5ZUFnK3hkKzNyVmtUM3lQeGhrM1o4QW5a?=
 =?utf-8?B?RndKcElWSDVxSXEwUFM4U0VKNmxVL1hDQjI5bTZNUkxuNHNvbWFycEZrL1pU?=
 =?utf-8?B?T3pkTStsVmpsTFZ4WmpoRkZlU0d6RVc0SU1PNFZmbTN3UnpISjRCOGc3S0pB?=
 =?utf-8?B?VUF1WE50cDRrcnZIeHlmYTcyQUczN2w0N2R2ZWtTZ0tIdG1BN0UxWnhvUlpP?=
 =?utf-8?Q?4BRaFBH46fxuqoAC0wRa7UFHO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31801d8-21b8-4ce6-fc2b-08dbd4d3e9be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 20:58:02.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F77bqHzjDjTPuUM7phe0uh1WzXWJuuX36I0Ems6RY+SOpNrQeiuAmxrk29QGdme7vjSnDdc1Kv6iMf6TIGpXgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 11:20 AM, Bragatheswaran Manickavel wrote:
> 
> kfree()/vfree() internally perform NULL check on the
> pointer handed to it and take no action if it indeed is
> NULL. Hence there is no need for a pre-check of the memory
> pointer before handing it to kfree()/vfree().
> 
> Issue reported by ifnullfree.cocci Coccinelle semantic
> patch script.
> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>

Thanks -sln

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
>   drivers/net/ethernet/amd/pds_core/core.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 2a8643e167e1..0d2091e9eb28 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -152,11 +152,8 @@ void pdsc_qcq_free(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>                  dma_free_coherent(dev, qcq->cq_size,
>                                    qcq->cq_base, qcq->cq_base_pa);
> 
> -       if (qcq->cq.info)
> -               vfree(qcq->cq.info);
> -
> -       if (qcq->q.info)
> -               vfree(qcq->q.info);
> +       vfree(qcq->cq.info);
> +       vfree(qcq->q.info);
> 
>          memset(qcq, 0, sizeof(*qcq));
>   }
> --
> 2.34.1
> 
