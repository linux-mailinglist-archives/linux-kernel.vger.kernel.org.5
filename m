Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA707D8C09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbjJZXFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJZXFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:05:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC01A7;
        Thu, 26 Oct 2023 16:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZCdLMG82eTyDMSkSnNX3pQGMCaN3LpYCGPcXE/6XTJWb1xt8xfbXRWirtXTkerC6IcfNQ43XXNfd7yXKvJ5AwThMPsAlGbI2fHPSXWmC5ySHWeav1QqQ4BnBqMBcr+PZjfCP36HqIImemZAVeQGL0g5rmsowimnb403Gt6tUr7MTxxz8TBbcVsbrLbXPZWj2MHOpvNqhev6JuKWZM8EoyuH2bH1MkHHD9e14RHi6TEF7owN7VA1vhOMd9PwMjVLVtUrm5eon3XIORzfwUD1Lo7hCCRW9gvQj9JqKntCwMKyLalo6WMxe/aLEEYaggXbMDQt4g3L4gk4y2MKY/7Byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzSmm7BVOqdMePxZ/24VRo+7s7kctwfthrsVrvKuw9A=;
 b=Pblv+2tsigAgugXYmB6hZDCDD8gt3GXIpAC+TqUYbFKLVDAK1ayfpNbOmV6VtSL186t1nEh/MVpj+3FaXHY4zhe+mQw3FBgO0iGNi0yONyjE90rToUwGOiD6M3fKsT+PFQvZ48HVPqX1LzkT0+O1LizSet8FyRYkEGy3SmCOtc3hHfbr6W0ctCQtVeVU1hoKE/TMBnWgShF+EWD0/RXUa+DQhYJi8bhppwCjAD1v9eOMEMOKVZJ8+UK+t9mVzCj3ehw5c5oWfZBOB7rbdiaYehNR3iE66Bu4uk1X0W6t4ICRuJdvwlRH0YMMCOdJJMdVdaIQ4Ib6GzeTrwZbB42rdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzSmm7BVOqdMePxZ/24VRo+7s7kctwfthrsVrvKuw9A=;
 b=gCT4WnCR+V9rronmu8ec/ssTBbMNz+RgNsnlJCbu6/50ifh6+iE1nXdA5GAU/OwDMIMGo5WLvVWhouwBHzPur+kx122ho/nnDa3n6t8mWP6azLBXQziI3bIvAEYho0EGhU8xWkKy8+GXBH5kbJGlZRUjbPPyOoZv7wG6AKpXLfi2qBql7gEPdP/QixQNZadd2VTQG8SzOLBqJB9mpB04aGM2LfFqCm3hLltbv/gHVAV3+4vGTWmadI19cTeGObRYfpfdg0nTnmiZCobHXGCNTUvjc4EmmT53fFf8uFiQFCNAeQKcj8y4xl9CGk8E5VA9T5c22+BdS53WZoD0mKZxEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 23:04:59 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::16f8:183d:56cb:ba69]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::16f8:183d:56cb:ba69%6]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 23:04:59 +0000
Message-ID: <f545e695-d838-ec28-d319-e4e9a885f8cf@nvidia.com>
Date:   Thu, 26 Oct 2023 16:04:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hte: tegra: Fix missing error code in
 tegra_hte_test_probe()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20231026075328.996704-1-harshit.m.mogalapalli@oracle.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20231026075328.996704-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d0e1ca-ef3d-45cd-2e59-08dbd677fa29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvCl3GbbgVbJRKWPminux3YekXFNmSkhWg2Ieyy9PXYaZC3bf7gcCRtDzHemcbyupfGtPBleiyphmd477UTpfIJ32PIEgFrTRMvqA0WujqKgI2bTOsDHI3/ozhT8IMCO0VITJGUzu4W8mhUWA09s+TtLhU68CInj/CntCR2PRjAqKzXGIzQHE2pDBgCqj7LjBqwhGEm5UuqSMy9grgyvMKMp1D+tVuP1OavLLoNqyZMO+XkLwF1IENNuoA3r/bEQyqhSgMRzUfwDBL/a3+2MdejpRQt5qq9sxXLHTbyyWBC4ioS6JITm4Y4TT6xjTGf116DRH9x+nH6UgpOmbY2wtJJ6UqwpBnCl04zm/jqO9s+Q+lUg3FWw3lyALY/VwBbPrmrAQJo7i1C7Ixct7T17T6Eg0iE8K74XJnTwEbnMVwngKuG3FtMqbcd9iubmEp0Ap6dp+TPeI7OSkaRfyrRO+2fJzYNrECDvQiJmshabH/nqV6D4Y5eOjg2u+EXen5antzCVsmeDLLR18vNW1lzHJtLlpu0UGodedbxyzk3+mD+z9cMTD/1gTSskr6tVJY3Ie1nnaveBjcJ/TgQfbCekjj6GCssbW7Q+yUh3XHU2zoBu9iEQZ63qoZz4SNDsd+6S/O4mLIr6SPhW+TBciAnChQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31696002)(6486002)(8676002)(8936002)(31686004)(6666004)(66946007)(66476007)(66556008)(110136005)(86362001)(4326008)(478600001)(41300700001)(5660300002)(2906002)(316002)(6506007)(53546011)(38100700002)(36756003)(2616005)(26005)(6512007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEhVQktnejJjcjRqSy9nNXRyc0daQm53QmxtdHY4ZGZWMUxUb05pL3JiYW5z?=
 =?utf-8?B?bWpuSUNZeEJHZ2VSdHg5YzdDb1FLYjJPUWVvSCsyV2tUVzgrVi8yVGVmbjJT?=
 =?utf-8?B?TXgxeE1lN1VMdWxyZmxMdCtOeUR6bE8zM3c2dnVXazdPTjRvNTI4OVVTZ1Nm?=
 =?utf-8?B?MS9HRTJKbVhzcGs1bnJHbTlJbm9JOTNrZHNLbmZITkdDZTFXSStRejYybWIx?=
 =?utf-8?B?dzBkeENCZHZoOFZVMStGV1MyS2JlejdtQTNlNThPdUg0WnZkbXJRM2lFVHpN?=
 =?utf-8?B?OHYxN0ZTMWRSYUdXNytDT2o4bHl4dW1zTGZDMjg1anpJNTRQT1VTcjBnSGFk?=
 =?utf-8?B?bSs1MHk1WlVDbWw1WG5QM3Vtb2JySCtwNHVKSW9YSWdFSzZSN3Z0ZTBhWkRk?=
 =?utf-8?B?anhPTW14ZGk0TFZOZGxRbUFCL0tqU2VFWkFiemxVTERxRGlVdTJwRzFLQm1H?=
 =?utf-8?B?b1FSVDEydjg4WVN5TGRUcHEzSFIzS1JUcy92TWk3SStVbHNwN210QXZVRU9V?=
 =?utf-8?B?TForbE1tOWZIajdIYXQzakUyZ0xtTkwwNXAzR1VGRzdpU3U2a1lYY1Z1REdV?=
 =?utf-8?B?allQT0tnbFkxUzBuaER3eVZhOTRxOU8wNk82Y1ZzSXFFeTVTQU5GYlg0VVMx?=
 =?utf-8?B?K280dGRHR1ZaS0RtOEExZkh1QmpTNnlIcWFHN0pISUFwVjlDMnZudklsMUhQ?=
 =?utf-8?B?TVhKbVdLanN2M1g1ZnA5ajUyWUFqbW85VzBmYXNseng1OW1xeEVDVG16OTZl?=
 =?utf-8?B?N1J0QmlId2FyL29LcTBLNVkrQ2dZT0dmb3hGVkplb0lPd2dlNzM2aUhiNXZU?=
 =?utf-8?B?VVZZVnlNZFU5a0wyUW1aQnZpaXRmbEpXWDhMUS9RZHE3a29SWG1DaGRBd1NH?=
 =?utf-8?B?U0FKR3JwUkdqWmM2TzJtTVplS1I0VlV0RFQ5S1NPMjkwWjFnUTAyRW5vRzlO?=
 =?utf-8?B?RC9Damt2NUI5SFlGNkRtNjZmU2Nzb1VOTUFGTUdxbXZLd2YvVWVTLzVxWTNh?=
 =?utf-8?B?OVV0eERzejFPbWhOVlhEZm9IekpUWlM3dy9Ldk9aWFdhQXdFVXVWN2djQUNX?=
 =?utf-8?B?ZmxmZHVXTFZwN3BIS21STWppNlp2Zmx2eWhLNEJSYXpBYUM1MWN3MTFpZW5S?=
 =?utf-8?B?MGhuZk9oeW1ZZXFLUUkzd0E4djlhTk1uQW0vdGNFWWVpbTdiZXh2SUpuK1FS?=
 =?utf-8?B?YTl3WWUxSFFlTnIxT2s3YUNTUmx4aWQyT1FseDFNS0wzMERCWFl2UjJKMnBP?=
 =?utf-8?B?aFV4WTlmN3NhS1QxZ2RNNGVIaTNUQmZvdnljWk5OUTVIWURtblVxKzVuTENH?=
 =?utf-8?B?SnZPTUt6RkpPakhQQklma1B0clUvc0tvbmVreXM1YXFkZjRWNnZSTUNjV1Ri?=
 =?utf-8?B?eitTQi9wdGNHNytuN2NRd012elpURjZWL2dGaVZ5bmJWbklKUHpGZXI1M0Z6?=
 =?utf-8?B?aTRCc1RlbWZYaTErVkpoRDkrMmdHaVJ5ZnNKQXovU0hvL0ZUVjR3d0R0bXJl?=
 =?utf-8?B?ZmNSSWdYR1d2dVNDTS9aajcvTHNLYlZvdEVpeWp6UGxuYUVpbXZ4R2IvU21S?=
 =?utf-8?B?Ly9mNFQ2NlR0cmhCekI2MHZMRnRoYTdkQlJmOUxqYVQ1OStHbkVwSys3Mjcy?=
 =?utf-8?B?T2FDdW1jSG5ON2hrOU1xTS9hTkFReTZTMnhmRVlqL0wzWkZPcS9vSDFvVVJO?=
 =?utf-8?B?czM5cVg5WnF6RXlTVVc2Z0UvbGRlTVBHQk52Z3VIRDNKYWtBWWl0T3JjY3ZT?=
 =?utf-8?B?V0xjRmZsczQzcjVDMitrUlJIWC91bk82Tmh0WXdKSmtUaEZIaXV6cUlCRmE3?=
 =?utf-8?B?L1NEQmd3YU16Z0l1dVZvLzBlOHhUN0hWTndoU2Y3dDRFQ2txQ2JVS0taaTV1?=
 =?utf-8?B?OWUzay9YVnJuSUVJNFJFWkRFenBSMitGRTcyVU4yU2ZPK3ZNSVhXWFhZbWFy?=
 =?utf-8?B?QnRQNUtsbUN4Y09xSnc3WjZSbFhpZVdtRGRnbWNUUDdMYklKcWxMMkkydTVW?=
 =?utf-8?B?QTRsR0pJTWZGbWVVSlo0dUIzTnV1ZlVOWDhpMEJqUVpocE5DWXY3aUxZVTE1?=
 =?utf-8?B?eTF0SHF3N1RxQlRFQjVJaFdMY0psbC9UT2J1ejlvbTdaT1krWDlNYXlheUdu?=
 =?utf-8?Q?EKXR1NJKKf6Fn5oGNLt3sJAqN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d0e1ca-ef3d-45cd-2e59-08dbd677fa29
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 23:04:59.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/QQvBy34QqQ6jQ1IEMqwi2c7uEF+8eTlHS+UM80FOYXMW2svekyyiS8oaJxHSPqmoRPBS6FBeneuBkVVMag/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 12:53 AM, Harshit Mogalapalli wrote:
> The value of 'ret' is zero when of_hte_req_count() fails to get number
> of entitties to timestamp. And returning success(zero) on this failure
> path is incorrect.
> 
> Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is found using static analysis with smatch, only compile tested.
> ---
>  drivers/hte/hte-tegra194-test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
> index ba37a5efbf82..ab2edff018eb 100644
> --- a/drivers/hte/hte-tegra194-test.c
> +++ b/drivers/hte/hte-tegra194-test.c
> @@ -153,8 +153,10 @@ static int tegra_hte_test_probe(struct platform_device *pdev)
>  	}
>  
>  	cnt = of_hte_req_count(hte.pdev);
> -	if (cnt < 0)
> +	if (cnt < 0) {
> +		ret = cnt;
>  		goto free_irq;
> +	}
>  
>  	dev_info(&pdev->dev, "Total requested lines:%d\n", cnt);
>  
Reviewed-by: Dipen Patel <dipenp@nvidia.com>
