Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC5C7CFEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbjJSPxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjJSPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:53:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2AE93;
        Thu, 19 Oct 2023 08:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Stx5/N+dezBItwtYnDtY+rLledCd2/I9e0dcTTGKn7Gsv3I/JEOXPz7lepLoV1DJi3EjAKu/SWbHe3DCs54W5g03NAQxcFwbDGgDshDYPaZRmpjQi+MQc/p3WveQQM0hKy9PicZdGaatJps1y1sDqWKPidXxs96Y2lXKOyXPGD+AxN/W28RTuOIu6/536shoQEPREqfSsx2Na3e3vMrSMhlWurONXKxzsnygfVd/SM1Co1XjlW1cxpe+Xnx4/T2US9ZJnME34Lel7MfNkhFElIFXuleusNd/BZwje10kKB/syAx/Mt58yogzvUEurD3bV7WCdW6p6YH3Bw7U0a8rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6HyOtaYVrGZp/sX39K3pEqkmVfgIuuKL3KesR0ck9k=;
 b=Uk8rPMWe+Y7Jzj8dGY3Bie/7M+fxxntZ6yJcvgvrQBoANNi+KdNrsIyobfTj7pG5o4GKWt44HMRHE8bbfm3uwqdOC22vX/HOhUgLfSKHFypsHZhOG8op/b1B0ucu7UifUJ7i6f9A0Hycliwg5znuV4mdG42lhTOoZfNuj6lavrEleWW2uLLN4msmxLKq1hnaVdS+p0bFSu2PVF24jG3pNwV3ivCN520ai6pjeIo7TxAJ5SL/iT/lRXmtxA/5yslqfQDrH+UGJF1LZ17CjVLJEax7kEeXx0AzduY2JlGqeMG+HG/nAhdCEPhzEkg/Fn0XOTIiVjObg/dfJm4k73AMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6HyOtaYVrGZp/sX39K3pEqkmVfgIuuKL3KesR0ck9k=;
 b=yIW4Akfd0V3X1XdljUPgbgfjU0gE3pnV/4Uv4uoUUGsN0wPuY+tHFczpxzygckPUlBhgRH0f6cSDH+3MxINExz/wYEXmOOtXmF4rlT79BiIkc6JFGm4f/C5IFUP+RIYULRuUMZ7Zi2iNOAEpIoZfR5cLfTaCgF6LNMIR/A95svY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.40; Thu, 19 Oct 2023 15:52:56 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e31c:de3c:af9d:cd2c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e31c:de3c:af9d:cd2c%5]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 15:52:56 +0000
Message-ID: <c418625c-755f-4e2f-93e7-f2a5d8c7fba3@amd.com>
Date:   Thu, 19 Oct 2023 08:52:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pds_core: add an error code check in pdsc_dl_info_get
To:     Su Hui <suhui@nfschina.com>, brett.creeley@amd.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20231019083351.1526484-1-suhui@nfschina.com>
Content-Language: en-US
From:   "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231019083351.1526484-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:510:325::16) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb85e3d-6780-4fd7-a8ed-08dbd0bb75fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGoNHj63UTSRb4+N2iV3FemDhbvN31tU60JdIAp7B8thwIU6+c+2jLxOSrMSJ9rwTa5eUrOKbrdSjxCYvNp98i6qaqzgTlyO0EpWwUb+gWLBTxCEjsOxCrXgwjDz3QST1QLSRFElynV6kuRaUqBC/Ok98CkN3irW53d3oTS+VNjiUuTsqXUrkb/SZslYfjaCGRcszQjiV9IufHmJlUhNs4/jjCWJJy5bQ1ioyTLj9fyNgs9w5Fs1jSGXT0eIaJt6ww/Cuegpn+JonWYYXJJaNeATdGF3E5ebGADj81nTMZj9j8H0e/g6efN9rKgR6VFryQZAjx6SA9DKDmM2l4yooV6BqeItgBHYqWGnr2U5wM4mbpP71B6rmJ0NAkVWZA72c+eYz4F9OQc1llyPG7KEhrHuxFC0lnYvMwpFa8yhe+zrRsovd09F7ZLPy8EfRT3eZnDjEFUX605541v5qjPRZrxhyI3oPy1nCjUcNAfWDDlYDYOkpuz6Yk+iG4xxPeFKtz/Af/QE1PKv7hRQhAO5JPoSxthVF6t+xKkzP91rgnZPDhRx3ahgYMQHi+zOyKozDAPQD+uFXyy1ESpeaqU4DQCEJ/PLsA7VuKRD5Mu27T0HeO4mouL27k/Z54Zx+dSfSoQkJtiPArq8bkHEEm6pOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6666004)(6506007)(66476007)(66556008)(41300700001)(66946007)(6486002)(316002)(478600001)(6512007)(8936002)(36756003)(5660300002)(8676002)(4326008)(2906002)(86362001)(4744005)(38100700002)(2616005)(26005)(53546011)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFIyQTkydGVOSFQ3OU9tYlJCU3RONko5UkVvL1Q5TVhPWm5LYXBYcEZBdTJh?=
 =?utf-8?B?c2doUWorYUhKRmsvSURLVllYQTNxbjVYaFMxME4xcnpwenpZV1JhSTU1Z0hy?=
 =?utf-8?B?dC9OT3pnZnlKZ2JWWjNjTzhRaVBaMWRRVlAvbFZ2Y2dMRzJ2WXk2VXV2QU5C?=
 =?utf-8?B?L096d29DVkpMNzQvUG9EQm5XTzVXck5RWmV1b2c5OThsM1lzT3UxY0I1dzhG?=
 =?utf-8?B?bm8xL3NGZ3o2TklzREQxalA2c0RIVlVmMmtzSUNkaGlKamwyWjNyeThYS3do?=
 =?utf-8?B?ajkzczlIV2tPMkxWTkFFQTNjMHVLNmMzM0VTNkpuNytaR1IvTExlWTFmZEdv?=
 =?utf-8?B?UTVScXRBbCtPNWFBcXJUM2cxNlZqVHBuZ3lDQmhYRGtyQ0ZjeWxwcVdycmpI?=
 =?utf-8?B?bDVVTmtweE96NmVvK01Ld3VCYlBsTk45MUZjd3lmMFF0a0ZIeW5Pakw3bUhH?=
 =?utf-8?B?dFN1QW41VzJMUWFNS29HN1BGc3VVRmlxelppNzRxNDVYR0JBRHFLOTBOeUt5?=
 =?utf-8?B?UXhjTlJFb2NoaEc2UmdLUnZyTmNPdk14dzA5N045NFBJZzBnNWxCdzRPZSti?=
 =?utf-8?B?UTZ2R3RFQnFsNXZneXIzdnFUcXU1eXg1TnJKQlQ3dUJTcDNINUVxUW1wT3BJ?=
 =?utf-8?B?RWJiREx5bWk3dmRrWEQ3SlVYSTBHM2FRTk10cFZVQ2Z1L2xuZlRNUGx3blht?=
 =?utf-8?B?T2xjMDRPOUQ4WWdUZit1bHN5L0JsZ3BvcXBVZmF6aXhhVDEvUjM5WTR5bXE2?=
 =?utf-8?B?YndyOEZaMk1wbGxKdUYxV1ZhcDJKeU9xQ2ZOa0hzNDlaWXVxdWpHNHFGTGVs?=
 =?utf-8?B?aG54Y2s0alN3bW0waURKRjRESStPNnJOWmNoQlB2U1lyQXRHcmZKNVd2MHdx?=
 =?utf-8?B?RC90UUc5REl4QTRiS2h2eWZsNEg4MW5NeWFsUkVMNXpJZDFFWEppRjV0Tm5M?=
 =?utf-8?B?VnozaG1xa29xSmU1eklCYjBjVHRtdlR0Qm54dlBUbnA3WlpoTkFzclZLUjhN?=
 =?utf-8?B?V3o1TVEvVElwNFk3aWlOeW10bTBka2g1U2l5RGN5bVoyTG1zTFJuR2FuNVVI?=
 =?utf-8?B?TjZTY0U3elZBWVFkZmxKeVVPbm9mRGpXNS9IaFlJNEl2UnRkQURtTUpwbmFz?=
 =?utf-8?B?K2YzR3Fuc1VwV2Q0bTVNYWtVbGRUeHZFRG1Ud0VHVlFUR2IrOVJtdW9mcjBY?=
 =?utf-8?B?Tmp4UmN6QWpzZEFqRHhxZ01zMWQrNWQ3ekwrbG14c2pvbW9DWnpmM3VqWDc1?=
 =?utf-8?B?NitFTkhONkQxelYwbVI2bHVPTVFqR25NMGs3U1B3cHdXbEhaSGNMQzdYalFp?=
 =?utf-8?B?M3dKL21RYW5ja0J3ZkNuZExQM2wxNmRBeG5BRVA3ekluNG5KUFZsaEYzSXZ6?=
 =?utf-8?B?YWIwVWJtOEFYU2ZqaGp1YXVFaVhwNkhVV2tCbDYzeENGd3NkOC91YVRFOTlv?=
 =?utf-8?B?T20wYSs3a3NIak5QaTUzTy9PMzdDbkQrajVKQTZURGhrWDlyK0FHSkNVNlRm?=
 =?utf-8?B?eW9EYWhxRFNDTVBiR2VQb2JSdVI5ZmdnSHRFM1c1dnNmR2RaV0M1L0JEYWtI?=
 =?utf-8?B?S2hJKzhYMHl4eEFuK1pPYzVyY0plN2pyb3dXWmRIZWZpTFNQeXlRekpBc0NW?=
 =?utf-8?B?clRBalEvazVIVVBQVWs5YnpSNHNnOUFDMmxXZDF6cmpXUDdadFVXaXlmTmlm?=
 =?utf-8?B?ZGVjOXV2YTlpYlljNDFrNFY3UnR2RjlLZDM1NFlaa204UFl5VWYvVUtZK3NF?=
 =?utf-8?B?Vyt2enB1dklETWpRL3JoUzl3S2thUmZKaUZsdjNmUDRZZnp6ejZNdERvK280?=
 =?utf-8?B?UHJldmhPZU5HT3pMMTA3T2xqOCtsa05Ea0dYbUI5cjhvQ212c3pTUGRET3VO?=
 =?utf-8?B?TXhHaVZpNCtLMTAxTERqTlBMd1hjOUZnM2FXOUNVMEwrMFk0ckc4ZnBGUHVz?=
 =?utf-8?B?Mm1mMVN4UXlCT0FydGs3Z1ZaOGVWZFZIVDVGSjcxQjhVUGxGZjNQZ0hmN1p6?=
 =?utf-8?B?NjM5YzdjdUZIUDRwdDVMeXR2bFNqWGtBKzk5dGNldFIvRVhJVHRKM3dCUVBO?=
 =?utf-8?B?QWpTUGtkNERaLzdvdU1tOTlLQU53VHBvK3dHN0JkRHQxSDlqVWY5d3NRNE1Y?=
 =?utf-8?Q?UGxCVBoQxudsbAFpE6L0LKix8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb85e3d-6780-4fd7-a8ed-08dbd0bb75fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 15:52:56.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrMjaly2loqpsSLtY5VBoek+Sl94qaBfzVzj6rD9DXbj+ywoNGky7M/SdLw6/HzMQmAC7ZgarPndNnqeYepQow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2023 1:33 AM, Su Hui wrote:
> 
> check the value of 'ret' after call 'devlink_info_version_stored_put'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Thanks.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
>   drivers/net/ethernet/amd/pds_core/devlink.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index d9607033bbf2..09041f7fccaf 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -124,6 +124,8 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
>                          snprintf(buf, sizeof(buf), "fw.slot_%d", i);
>                  err = devlink_info_version_stored_put(req, buf,
>                                                        fw_list.fw_names[i].fw_version);
> +               if (err)
> +                       return err;
>          }
> 
>          err = devlink_info_version_running_put(req,
> --
> 2.30.2
> 
