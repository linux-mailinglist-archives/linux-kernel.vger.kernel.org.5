Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5B76214E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGYS3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:29:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2AA1FC2;
        Tue, 25 Jul 2023 11:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3dVkOLpHYwatvrXxqx5LOroa1XfHxZRuA+30SdzKeH7r8k01QNmpxxOxkBFOycQnAvJ8D493NeKrmNWt3QZ4O8rRLnNnkqTUeK0O/6cs6vOO9ALxxXsxtu3WBrn1iUdWvYkND4UdOxIYyIIuYq0N5V3QbtD4N6KoUoESRPNas1Y/YZcXYzwPyDq2R6kFJGYc/Brr+pVhTBA2lTccWFJ6DqsGeqWgrF7G2XwSlYAzN5v2brwpBgcSGENAOkLH3tJKTgo5ajl3kh4pq5ly9NHrq1mh42ys8JeEn3zHEq1nFBzKRWxFJ973Li2+u5dN3aVFa3CH7fhaGFAAv67jvqrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FNgWxkBrrO8prou4EJ3XOxh43qJl5qtY61iWxSe3Iw=;
 b=PgS7dYuxhRpkRImeBvDppsrjsAT9DSfTH7G2IzFsNTv8b1rkW+zL8I3APvDg739o+OyQzt4TN/+P0TJVgE4Re+PYeEVRHqIF4PNIy9rU1ob1W9VP/ddiHoE16oHdKdwBq784ig0iw2aE/Q46Pv2BkI3/E9ZMRy/zM4L9AdYc2G/eW+N7ph9pudRpaMgy6RnOgpTPB0cdrZvrDGcEYkS1LH9hefIQyaTs9MJTTPgPcbGDeeAzLPr6stV/szhO1c61I6sWM0610uGcwTaTKDkpHifTuI3aaZ9eu5Sv7gQuhECKfnvwQ50OsPuzh23ZsOarCfYLlg6xmDnVz0DiLgYJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FNgWxkBrrO8prou4EJ3XOxh43qJl5qtY61iWxSe3Iw=;
 b=mMbq2f5MUxoHWxDRLi3CG/zS3wVswTn085YQQ2xYLfNdh+/lTUmiL7M+BCvvQhxg5SpmlZ4a+GwhsFNcUYvBkUR4I6JIhVab+Wpy2ez+88OaNj2zdLU1mflPNVgBUR/5uzjsjvmwS0TfbHPZnW212gHBpOVW7io9G+9NIMURea4x9WsAYKvwf6D6vJk5J9pu8E7dXIlGS4A8cQMY5xSyUeNHrif+vW5xojXvqXEo/fsKQCdYqowcr5sfN/duc6oN4NFdS0UoG75ApdlRb24XzVIqSeeyanATcFceZSJ6kg/olZncd8LA+jZYBtb1LcnGBbBS6zA0KwprcbRN4lUs+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 18:29:43 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8833:f1bb:7d8b:dce7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8833:f1bb:7d8b:dce7%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 18:29:43 +0000
Message-ID: <df57e126-fe89-8a43-42aa-f0b4a5a404dc@nvidia.com>
Date:   Tue, 25 Jul 2023 19:29:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch RESEND 4/4] memory: tegra: make icc_set_bw return zero if
 BWMGR not supported
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, krzysztof.kozlowski@linaro.org,
        treding@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     bbasu@nvidia.com, talho@nvidia.com
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-5-sumitg@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230621134400.23070-5-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6d4925-b2f5-4666-bcf2-08db8d3d1d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgaU+6MFACocdWwkwEYRUY6hO4hpR7Mqv4Lx5cVTVnsZa/XFmSCja1KDxW6VasVIutJd/ImgoPxgQg+3M9w0QCOOe7TodViASwRlsepEbebXz0ugwEzaPV5BiOcdcBD/g8FqVBoT/eaDcOUfGpYid5zRJX3Z3DdI/qf2e2W4XKBXZaIT2OWkV6vYYwxp81EFaIldUV/1xT1d0XJh2+ZH/Siohc5CL3gCB1q8VL2/5r8M+4+kWjYcZ47I+lq9ZYadOyABpSgH37JpIRvdT/NQPPSVfStijZQUMXQs3ETuzAMgwaJyr6QVw2iUey5cuhm32zo9mopO8YizI28Xc4WuYLGWTv7YXmfzKWYCf6kdB9sA5KVwIw5rXM7AVHRi8EmMuVEUeALyz+phwfZQ/bNzZthddV0116jQf054UcTYGKo/59sPkOVb3EGRvm59BfpknnJU4ej70pufexdrAPrXXom0QP4hExGGOM7PGPI4eNnWohwEaruewF8osH2zq1uDZGF0F1NktaBGU/sIwBk1p7pRKCyIin4rl6nRp5pT6a9AS9J6+5iurYMt2E2SHR5ohR/kXU/19JdRuHxQ5P4nurmjP/z8GqaxxpF58jez4WL8NR+k5dVFcg5ljmBoiWC6Xio4PJWtXVk8M0wUz5nUsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(83380400001)(478600001)(66556008)(66946007)(66476007)(316002)(4326008)(2906002)(36756003)(38100700002)(8936002)(31696002)(55236004)(86362001)(26005)(31686004)(186003)(107886003)(53546011)(6506007)(41300700001)(6666004)(2616005)(6486002)(6512007)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBlb3dQMjcyZllrNEp2SVhYZWMzYnZIUVBKRUVUQnB1ODFoWjNMQ2V0RzFo?=
 =?utf-8?B?cGk1SjhjTS80cjZjMEhwV1ovOTNBejJCNS9ma3lVWDRwUENjWXNsaXJIdzFQ?=
 =?utf-8?B?dGpZVTAyWFk5ZlVBQmVZTTlVVGp0RXNCQXVxUFBRRzFCRnhXenBHSWxEVXA2?=
 =?utf-8?B?ZnRLSXFaQU9vZmdZWms2R0xIa3p3L3A5YW96eDJWSVdkeWJ1elEyaHRLSkF4?=
 =?utf-8?B?VkNEeDNmWi8xOFhRTngwc0xDMkxjMnpyRHhGSktPUUp1aUM0TitpRUFSamVI?=
 =?utf-8?B?NmlEUXF3TzU4b3VjZnBhbEZSYkN1MnI1c29MYlkyL3hobXNLRk9tQnBxd1hP?=
 =?utf-8?B?V0x3T1lzTE9TZ3orckVZU3ZraUVJdEMwL0ZvUkd1SHRkT0Z2MlJzcE9kYnNJ?=
 =?utf-8?B?aFpvYy93Rll6YmN4eWN0TDF1UEFpOFhYeHVRdU53OUttaFpqZ1ZnMVAvTncz?=
 =?utf-8?B?c2I2NXNzaWVQVjgxb2NEWXlLcENwMG1GVkNjZXFhc05tdDFoTEg3QzFtTGRX?=
 =?utf-8?B?Z1dPK3BOWm40VFRUdllzVEpkcnhLWWNJMlgvREt5NDF4SUU5UHdTVVpmNy9W?=
 =?utf-8?B?WVhpN3UrcFBKZEZGdWJRdVExN2luQ3F1aE1icGNmK255OVFEL2FNaFNCMmJx?=
 =?utf-8?B?L0M1Uy9DVGJWcGRlTTZoaFNwTHhBTVMvK2ZyVU13QzJhVk1kTjBZZUZ6RC9t?=
 =?utf-8?B?Z25XYTl6dXZKZFhveWpVN0dPSnpGUEkvUFZKcGpqdE85ZlNjOW5QRm9pZVl6?=
 =?utf-8?B?ZWd4V21PdXpuNXVCOUErS0dzRTlabXVIdlBMZlIwSFQyZHRGajB5d09wOEhm?=
 =?utf-8?B?cTJXcWF1Q3ZBYW1MYTcrZFVyV211Nm1XVXdPZy90NHdkRlV6eFQrbmtCck1X?=
 =?utf-8?B?WWh0UWhYRkM0ZnlXMEcvM010VzNVYzg2cEtEVEtMdDE2M2hrbXJiNXN3U1Vj?=
 =?utf-8?B?Q0NrUGVaSTZLNDdzM1FseEF5dmZMRnpFUU1oUHFSSTMrcU52cXlIVVgraFZD?=
 =?utf-8?B?a09WS2RUYXEzYVNDM29kUnJRbDhqZ21PemFpQzlkaENLaEpaSzdmaFhQdTcx?=
 =?utf-8?B?ZE5iOTBEcDdjZ0JiK294eUJheUtuTERJalpSSHNUUTVpWGsrYXluVGtuMkhr?=
 =?utf-8?B?MUtYbkpFRXdMdXBOdlFKSExyOWgwNS83cUhmcHhxbTJxL2wwK1JwN1kvWmVO?=
 =?utf-8?B?elZRVlRMSkFYUFdsT1RVNlZxcmNxUzF2WVVCb2xxMUFJanpvYkpiMExSS1BJ?=
 =?utf-8?B?dnhueTk1WkxKVXcySmNZbDZZV3NVYktEUUN5aEJGYWwzcTBaZVp5Mm1mSEtr?=
 =?utf-8?B?eGgxeStXRXRkcXpreDdkSDZjbmM2YVNsWHUzQ1JPTncxUUJnS1FDTlBTZDh4?=
 =?utf-8?B?b3ViNUU5RGRIMzlobnVGcitjcVJGSGU0NGkrODVQTGIzbnRITlZHRkNJWVB5?=
 =?utf-8?B?REVMMmtqNm9pNjBTNklHS2o0emhMZitMcDdJWTBvV3UzSnIwV2hHUlZuVGJQ?=
 =?utf-8?B?YytJWWU3dFI3LzJmYU1mYzEwQVpmcDlHc3ZpM3lsL25SL1dCQ3lHbzBvamND?=
 =?utf-8?B?LzFwR29LVXJFc1huRmhKMkwwNHQyYjdaaHdDUUhZTDk4TWt5Q0RrN2h1bkYy?=
 =?utf-8?B?a3QwTHhxZkVDUXRyNjRiSXVEWU81VkR2b3RIUkRmV1pCMVEyL3BSbnFraVlu?=
 =?utf-8?B?WkpzaHpLeFlYKzBYeklMNEp1Tk9YaXNhTG9UT3VMbU9WL3JUOW11T2h6WjhO?=
 =?utf-8?B?bWwzdW11ejlrOGRIdlpPbStzSnFhWE1qOWczaWVSR1FnbzNFOTNSYlpXZ01q?=
 =?utf-8?B?Nzl3TG5sUGlGQWtueVFkbjFYM1YraENPVTU4ZllmT3pNRitzNi9UV1hEdmRU?=
 =?utf-8?B?S1I1elVzS0ZUU1RWTkxXcytIaVFTOFA1b3JvQVgySG5meFczZVJKMUNZRDZE?=
 =?utf-8?B?RGRxTmFNd3N2T3FwdUlTeStVSnFTbzVWQzlDL0FteDJrMzIvdldFNVI0U0Nj?=
 =?utf-8?B?QThOQVYraFc0bGRpNzZTZWwzM3Jlb09OTHpVNGZIejhac1R5ZlQ2TnROY2Rw?=
 =?utf-8?B?eDBwaTlYemZYWitSTUhocjM0dysxaG94K282aVo3OVZIeTlweXZmVVl2QzM1?=
 =?utf-8?B?c3k3M3pXcGZoY1o5V3NxU0lsL1lIbDkvdWwrcVZDcW92R1dTTlJveWVITWZy?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6d4925-b2f5-4666-bcf2-08db8d3d1d98
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 18:29:43.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFq2joyV24RmcIL7ECVx3A5pFXS41DZPskVxnx1nfOj2OiO03fj4MHer6UiG/rjptikHAqc94oJrhLXozgbBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 21/06/2023 14:44, Sumit Gupta wrote:
> Return zero from icc_set_bw() to MC client driver if MRQ_BWMGR_INT
> is not supported by the BPMP-FW. Currently, 'EINVAL' is returned
> which causes error message in client drivers even when the platform
> doesn't support scaling.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/memory/tegra/tegra234.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
> index bc73be7fe143..07aba301a173 100644
> --- a/drivers/memory/tegra/tegra234.c
> +++ b/drivers/memory/tegra/tegra234.c
> @@ -951,7 +951,7 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
>   		return 0;
>   
>   	if (!mc->bwmgr_mrq_supported)
> -		return -EINVAL;
> +		return 0;
>   
>   	if (!mc->bpmp) {
>   		dev_err(mc->dev, "BPMP reference NULL\n");
> @@ -998,7 +998,7 @@ static int tegra234_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   	struct tegra_mc *mc = icc_provider_to_tegra_mc(p);
>   
>   	if (!mc->bwmgr_mrq_supported)
> -		return -EINVAL;
> +		return 0;
>   
>   	if (node->id == TEGRA_ICC_MC_CPU_CLUSTER0 ||
>   	    node->id == TEGRA_ICC_MC_CPU_CLUSTER1 ||


I have also found that this change is needed for Linux v6.5 in order to 
work with current BPMP firmware. Without this patch PCIe does not work 
on Tegra234. We should probably also add the following fixes tag for 
this patch ...

Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra234")

Thanks
Jon

-- 
nvpublic
