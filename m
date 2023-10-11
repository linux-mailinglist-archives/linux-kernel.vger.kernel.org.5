Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046EF7C47B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344796AbjJKCTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbjJKCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:19:21 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E8894;
        Tue, 10 Oct 2023 19:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3SauPiKYDeiowuFil25TsWxbgZNnHl6EBoeNP+/f5ntNB4eARMFFk9iuN+jcslwOn8MxIRJkaiwC/NNPsrbOL49L8V51hQIzd/0eY9L2bWtcH16F/Agiendn43nhhdA2PmK3xwtY/Rtl+l/Y0hAf3KUwyk5puwxebcybPqT1qL9KDvEF4XUcznrw6PUUdGNYYTR0K2n6jGJwiYyINqH6y7x444ebLpacI2momU4aju1mr5aiYYzMtFOhPVId4he46hkg/iwSpz7fx7ZB6DB6XocBOrsyNJYidIhpDxaG9Rsipzb8NEEv5urXl/YoRSiZ7gmSxNHh7Tc93bPM1HYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU1NcBH9MazxTsy3LzuO/bGFhdZmBTc+h+rHARJ8wQo=;
 b=fznxvCqqMTj+yzxDEcNbB6c5GQ1t5Q2vO0uIksKBuR1Hz/Tb0u00KbQLdeZJXvgPT+g7tNRBOfLSUcX+35pocZukQMYjYb5EHbf3WH8Pwp8v8Jf50jwTxU9zcgRo/bs6sBW4gPGupcoYJ6dHe+5QHttEoP2d/xugGEIq4rsWG6ULq91rRBiIUZcI4Y+pAtIUlG1yTphPSAEGVuVh/eequGWy8peeoMCgW0TQCC3La6lRBOzUXh8gmL7kFdh8SRG1X6Nvls7ZvwhbzrPlQWvSTLbNk04sJDYMS5JoN1qjb4+2wujtzi8P6aH1TRaCupzF2W79rwTSUwcz0dNEVROQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU1NcBH9MazxTsy3LzuO/bGFhdZmBTc+h+rHARJ8wQo=;
 b=S8D4svpb3Qbt2tp1O+auymOF+baL5Z7AxYMEe+XxIzni97FDEuWvGo64MjkbSCaVk71rf242oup3JlkP97JoSsOZv96iRK87/eGlNC+U9ZoTUbt9Q8Wq2PxKcwreYKzar5APc5qjAtZAyIUtbgVge80ktCQw5VDPwwN+lbs+4gPXN4++iNNMJro8pW6FqU6WFnMUqAIlgD0bkFG5/EpHh98upGoyWVsHnskVk6orS3/X8lFQlhmhQD/qR92BLulroa4SLGK+9YBgP1mLF9Lk6guVCCB3caiWUXPTRPDatYB3y9QdqY+58TqpuCMeY3vAkXiCNwu6gezQOPCLEUtO4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 02:19:18 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 02:19:18 +0000
Message-ID: <d378d545-e14e-7e7a-8085-1e4dae87d66a@nvidia.com>
Date:   Tue, 10 Oct 2023 19:19:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/4] hte: tegra194: Remove redundant dev_err()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
 <20231010151709.4104747-4-andriy.shevchenko@linux.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20231010151709.4104747-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 54128e1a-e30c-4da1-af86-08dbca0078ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lerNfGbuc+NcChFovicFhOZ6yT2/A25IMCBWMVxQ93z097dGuiNpy4XYiJC0ZCiUO4AxXE1lxpfLgOe6emAqPrpbCC6EAUDjUtZ4ih/eGwbPij86Fz+M/ToEZ7GF/JKy6v/3hM2yVRlOSp5SgwujwjueyVdZ9XgTT8yWnVtN/thpIIYux0XaoI3r0psUxYGVriNfrc+ge04DVaBahKNBtkHYgJIc6oEAlruKvaUCpMR+8SfEzMNYcaSC8WKpHKaoGbagFN7mXQtPshohV2QuD6eAjkShOTdVAbPT4sAhWF92HUKlJ+ZXkXTiDKUB4LOGUWZXluRzF2Bhjcs2qQeJ90UZZtaVdJ4DDxO5L2hBZU6mLVw+atBNokf+Ts9idfrfzQDznoSmQplBHmtsGJKgkTPWv+CvGsgtkHry7rBT1hASYZF89bqXEV9e99BLmM9SQQU38An7Fs5ghWuHQMyrzF6M5OI3FhB3HGdFGOXXNjo4dfnr5kWttnEnFGEUO5Df69b9pKBD/HW3LgwRLb4CMZ26v4AAzer1Iv5CYiO22+MWdGdRCt93UopGH5d/0Z+Wz6B6/eE7snb6mC4ZZDxr5/uK3EKOkx9LTAWY2023hJhWsWrhCztrHKOD2JhGS8LVWMdH1qwfl0NiXSQ6w7jKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(26005)(86362001)(53546011)(31696002)(6512007)(107886003)(2616005)(478600001)(6666004)(6506007)(36756003)(38100700002)(83380400001)(6486002)(5660300002)(41300700001)(66556008)(66946007)(110136005)(66476007)(316002)(54906003)(31686004)(8936002)(4326008)(8676002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0lGQ0VZaWR3RVVEbkYxQ29YelZIZ01QU3dmOG1RZWFId1I2V1pJZnFaaDUy?=
 =?utf-8?B?Y0w5UTZ3Y2llbm03aUNCR0l3eTlFK2ZBSFdCcWZyeE0vbmVCMmJiK01tUHhu?=
 =?utf-8?B?c0ZSS0xnUFpBeWs4ekxLSHY5WFVTMmNWRjVTWlo3eXJVQ3NOR2ZzUEpKbzRy?=
 =?utf-8?B?Tm85bHQxMHU3RVNwYVRJbVE2eVJramlabXBsZFE4cllOWmgyUlBUQkxaTDg1?=
 =?utf-8?B?cGJ5emxSRkwzN0x0bVFmakpBNlVJTFQ0NUVKOXhWcUt4L0l4bVRwbUhVTlgv?=
 =?utf-8?B?Z2Q1Z3o2ZVJ0WFRicUltcjdmUklkb1FseUplWFhFd1dTZ21PdktBVWkyRUFD?=
 =?utf-8?B?VS9vWU9YMkt2QWt2WUxsRnI5aldKbk82aDdxTHg5NDhRa0pGcktlREdtUUhY?=
 =?utf-8?B?aGkwd3M5MmxUWHdxRjZqK0o0NFVhTXR1bHdRZG5aZ3p0TE53VXlOaTA0Qm5G?=
 =?utf-8?B?aXJIYUdSMHFMSlYrL1YzZCs3RlJhZHhGcnpTWXNqVVUyVVJGL0lnS1VhN2tI?=
 =?utf-8?B?djQrcnl0NS8vWEx4UkFzL1doTjgyazVKQkdZbldXMnIxcXJYekJ4ZXN0UTdj?=
 =?utf-8?B?cXJzZEtvVndPU2R1Q2NNRXJDaGo0NVVGbUVJeWUxaFVsUm4xMGJPRFN1WGV5?=
 =?utf-8?B?Vkk1MjNRMUdlUVY0cGd0bUhmb2VBWktmK0VMTXF6azVSSEZobmVYRmpoMXc0?=
 =?utf-8?B?THRXdUt0SkdqWW5lZ0tIOWJpc0UvaUE1MDI5L1lFZW9sNVczV1Z0RHB5TmxT?=
 =?utf-8?B?MU5DbjlROWdqamZrSENXT1dWL29tN0N0WG5NMWI4RzlzeVZMSFV3U25LM20x?=
 =?utf-8?B?ZXBmYWVWUS9ud21tK1pqVVl3c05iUmhhRytzdWhaZWovTE5vUDd6ekVxRkFu?=
 =?utf-8?B?R1BFTEZMVTZMYm5qY05qbEJYS2tWa2pyQzdOWlMwZmhGNE5ud1hnNDZWQTh0?=
 =?utf-8?B?ZW1FaWVoK2IxZkJTQzVtRFBBOVpUTllNd2pBdWJXeDdKbkVMU3FRTWFxa0JQ?=
 =?utf-8?B?U3Z3N0U4NW0zVnpUTENzR1c1NExUUlVleitJaWk4dUk4aUxlYkM5Nnh1REI4?=
 =?utf-8?B?MXpTYVFSR05lVEVOZzVDQmhLTjNyUmMxY2pXSlBkTi9BUUt4eXZKZUVhT0I4?=
 =?utf-8?B?bk5SYmVXVjJLMXpDaVlTeUNXbnQrRGQ2TWVIemJaTHREU2xsL25qai9GUndY?=
 =?utf-8?B?bmRMVmpzRjlwbHFOUFdza3V5Z0I1aFhqblJkUEpxeWY5bnZ1Mm00TUQvb0Vk?=
 =?utf-8?B?Mll1c0FFV2lqZVpXcGVrb3l1ZXpDT0xmMEhTT2RKYStuT2l2S0tCTzFDcEVo?=
 =?utf-8?B?M1dzVnlUdGxLODFoMk14WTJlTzBpdXpyZllGcU85YWFUdkNuQjA2WmlOdnk4?=
 =?utf-8?B?ZnVIdU9JMmNIblJORW9URmRVbjZoVzJEei9QeTJMdHRRVDBoOXdVU3FJejZ3?=
 =?utf-8?B?WndReERPb2hHdm1BV3R3dk5xMzJDeU9SbHJ1RERwS3FqekVrK1MzMkJSeG9l?=
 =?utf-8?B?dWhSbTZkSXBsczFLSzZTRmxSNE03NWx1V3R2WmJQM3hJbkhUYlQ2T09EMm8y?=
 =?utf-8?B?aGZXOTg1aThTTzA4eVNMQ2NNS0hSa1VURXd2cXdkQWxObGhsV25NYzc3RWNz?=
 =?utf-8?B?ZW85NVBmblY1V2FWNkU4TDhjVGlSMk9wTmRCWHVVYXozYjYzS2tHK0h6T21K?=
 =?utf-8?B?SkNTT21Ga2I1bndZVjI5eGIvVG8xZDcveEpSM2hkZmp2Sm1OSHJzRlMwVFFD?=
 =?utf-8?B?VFRvWUlWQSt2ckFOV3JyMmNmejNEYjJ6QVRJUi9JaVJSYzdiajVMTjJPaW5L?=
 =?utf-8?B?S1NZYk1XKzhiMW81ZVRlSGhoNSt3cm5YZEprVmE1S2hibUNsWlRBUkYyc1F6?=
 =?utf-8?B?d005NWNaRGpvR08raFdtVWdOc3pxc3V2aXZwWjE0d1R4aksxOEl5R1ArU0FS?=
 =?utf-8?B?N2gzcDQvcnJ1M3J3WEhVcDVKMS9idnMxeERqaElmZDhXN1NLTGRNWmRKZVEr?=
 =?utf-8?B?c0M1b1JZM2o2NXpZZGJENW01VzFJSTFYNmJDNDdGQ2RkQXlzeDR0OHRvaElu?=
 =?utf-8?B?T1lyS3poS3FuR1pwR1hob2swaVdRZzA0WjY5YWdBQmdsdkh0NzF2M3ljSjB2?=
 =?utf-8?Q?26EFUK81d5HAB+2ddJpQF9stm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54128e1a-e30c-4da1-af86-08dbca0078ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:19:18.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Cih4hfMxuAT+O9ePajcrK3dW/dlVDQvni6uihLODTxxKRxZ46an0O6NjW5+xxHJtL6uAxI5DlC6kRwA+bF8tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 8:17 AM, Andy Shevchenko wrote:
> There is no need to call the dev_err() function directly to print a custom
> message when handling an error from platform_get_irq() function as it is
> going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hte/hte-tegra194.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> index 339ff5921ec8..30ef1750a9fa 100644
> --- a/drivers/hte/hte-tegra194.c
> +++ b/drivers/hte/hte-tegra194.c
> @@ -731,10 +731,8 @@ static int tegra_hte_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	ret = platform_get_irq(pdev, 0);
> -	if (ret < 0) {
> -		dev_err_probe(dev, ret, "failed to get irq\n");
> +	if (ret < 0)
>  		return ret;
> -	}
>  	hte_dev->hte_irq = ret;
>  	ret = devm_request_irq(dev, hte_dev->hte_irq, tegra_hte_isr, 0,
>  			       dev_name(dev), hte_dev);

Reviewed-by: Dipen Patel <dipenp@nvidia.com>
