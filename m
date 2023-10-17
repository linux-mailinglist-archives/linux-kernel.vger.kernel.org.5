Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BEB7CCA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjJQSXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbjJQSXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:23:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63C95
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZL4oSAWCaksAxYObQVn7Cw6TspcHXMEO23joWH9GVpPBhvlhA7Rj17yXZkZsWxWff98yND1r6xz89uH8krsiogeAjlIE8ExHzWGfQMpyvE8JZALgTyofZT8qyArcZydVBYinnh5DHlY6bFMXMjY6M17nx/3KtpimVMApg2IBJ/KIJ4q8EOkMnBC1R4F5FiYtLgLySQ0A+OG3ldC3lGKAptiwpaDSoNf/QWz8rYhBjuqDfUV+9DXx7zcIMc6Y6TtPPWfKK2LI3X0w+LUFbDSuaozfz8URFzBg1QCgy6yWbNKMLCELXBYL0FJFYXXRHQ/MTA7CTRWq5Qt2gCDQoJhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZw9p1UmRNkyjSlhsvKorIebmTZBjJX8ajiSCcgPPsw=;
 b=R5G6FTeoXJ598v2ORck5sqG4neUb7hioBQetafZyUaoIe28Z1R8L2ujGKB1yM0vvpdY3rG2OwPgY1XphnGWZuLaX44HWuMgP3a5fXVdPXp3XFGeroIFzJFSUlTc+a6R163JiU9TbpeyFWzFF4R9gONeor68/ih2fq1twyzMtKaPEt8aY1AhQvdd4SqfSrAW9ba104HpStrkLkK8Kwta2K2IUKxmK4VOuDgI+U39tdxTQu0b8AObyDj0h83aoYaY03iQ2QYe29b28JuAzD7caTIhJl7Uw7rM6kbNCDBd+lA9zRN5t5SryqRUN9pN3S1qNuip5rPeFflDe+lVhSnt5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZw9p1UmRNkyjSlhsvKorIebmTZBjJX8ajiSCcgPPsw=;
 b=ct5+vTE3OIZwky4QMnrnln4obrgx0Au1W2RtWMshvAa6hMUQXQJwWz64eoxymL9JMrofrs4R8tP5BfvN2wztEah+DbnlET5iaDEp6N8JbT51NGrbYu3zqipysuAetIc9LgaRm6vJioAABQh4ckfCMZKvZGa/e9714HksJXOliaGB/us2DDAiuuW3cZUuKTXdJM9JT8LBf9uoii4oz67LNCbK0sbvYXQC/i2ddAgVqs8menctXQseMTVcpPBPVhT1/OUVKMomCFEubhw4N19wiKZwl+NOMSjy8urIeicuLEpKJ9vQChpIPWjcZPoeD8vzryj6uwsOgy03LRUJOFjo+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 18:23:35 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 18:23:34 +0000
Message-ID: <74a8acea-1064-a759-53eb-ed0ea0fbb7d6@nvidia.com>
Date:   Tue, 17 Oct 2023 11:23:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hte: tegra194: don't access struct gpio_chip
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20231013072340.16411-1-brgl@bgdev.pl>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20231013072340.16411-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::32) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e925017-445f-4d6a-bc98-08dbcf3e2bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2IuPR+zvzIKAtZz7Vrh6KRuNvBv8t/dZ02P/rhguTrz+KkGZkxcFpIIZd2c3g0W01lZtVShXQSud7uz0YbpH1JcjU8IGUQfKjkkYJrXRX2u10x1pO1hNcEUQBXAOFPasTftSrEE3ockRNfYvtE3ctH+ojpAWJ2fnKGl18d2K/ZWWZXvFcinms0Gi8QgnKW1R5uYosrDFSBEnyfDaiBHFgU89gtb1BbUBckNLCOqeNBADcxlb7xuQQCnMZF9sGW4LPpvVFeJyN0z9lPGhLDlP3EMyggn5rzdrgRdfRXWa+64MTZ9S6lkTrQ9vsY0d755mFjPFsarS8T4MQ303G43bK/69wOAsC9+Xn45vepw7SW/Mj2QDgRv+QiBMlThU0dkMhBPAXrKV+7ghDsH0Um90lKdFqVMqStBcpqqr6/5dBj3wx8PumH8csvuk6je95ik3mjZAn66b9PhtMA3pEskKVP6beRg8100/46yKi2E87jU/fD5XzPIV6Irm4yqIANPffRBViCHQ4fGB1wbMbu6oSBV+TsWJH4f7lhPxLJ9SjECbXydbkS4Op7oxKwmUam6aTP17mg+f7dE2krWwx+bJoJdOGCf3B1yLoEcHPYLEKQVmO/E5U7m7VILjCK8CFImmzSrsk7tdg/+B02M5DnTONVUOE6AC+ZKrsS7ITdS6FtfpsPG/RMdpEr+qlgm255AZn6qsdnMtYYpJ3dZLia4rQwL4040aEhuZcy3WP4lEbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6666004)(31696002)(6506007)(5660300002)(2906002)(8936002)(6486002)(478600001)(4326008)(8676002)(110136005)(316002)(66946007)(66476007)(66556008)(54906003)(41300700001)(36756003)(83380400001)(966005)(26005)(31686004)(6512007)(53546011)(38100700002)(86362001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdCQmFCb2hSdVdXb05OZXZ1bUwzZG03SVV2S3Y3V29hdHIzZC9waWNCWnp3?=
 =?utf-8?B?SkMvcHp1Ynh6aUNWNklNTTEvSUlTOXNnNW9ZSnNMYkJpM1Bla0ZDMlQrMzVu?=
 =?utf-8?B?S2kxQzBzSjdnejZhVnBaY1VwbVd1ZVRrZjJYOGswY2djTzRxcW54RUFDT3R0?=
 =?utf-8?B?czQ0M0pYOXRYdndtUm9HVTU0LzBvQWJKWWJ3NWE2REVzUkxyVjBxRm4rZGJC?=
 =?utf-8?B?b3FSejhxNkpvSjRlWklRcTlDdXk4VDEybmgwMFI4V0tJeTBra0tYRy9NVWtw?=
 =?utf-8?B?eGVSWXN5SkFJa2RFd3EzeXY5WnBuZHYvR1FKL2lHSGhVa1BUVXlScEJKbjUw?=
 =?utf-8?B?QkJ1SzlMTlUvaG43aDJReFNERzRrVXV0Sm5MRGJqUTEyZHFGdDRrSHVhZC9k?=
 =?utf-8?B?VzEwc1NuRTRSZDdNVHZjQm0rUWRKS1dxdytkTXhyL09INjVVVWszVnZneG83?=
 =?utf-8?B?QkJWTHFXNDdLWlFiZmFlY0lEWFcvRjB6SmdraVFOSmxXbjhwYlZ2WGhBc0R6?=
 =?utf-8?B?UklHeE5qL1hmeTZSamZVMXNnemlQZ3pNWVduclFiNU5BVWJjQ21ScnFWVHoz?=
 =?utf-8?B?SHVzSXoxSkxBWDUxWHVxdGJaU0hzS05Oam02L2c3aU85NGdXcGs5VXlhQTZD?=
 =?utf-8?B?VnF4Mml3NEdmNS9EYzludi9Xek1saWJzQnJrTUJJQU81byt1djZpVDc3L3ZQ?=
 =?utf-8?B?eGZ3YlZoSFI4a3Y4TzhTd1d5c1lNd0pXUmhWbEw0bnZEYjVoZTFOanZ5TFFE?=
 =?utf-8?B?UnVtZ2huVkR6a1pEeExXQWhHUDBwdG4wbEZZSjJ4Sm55a3ZZbXU5Zjl2bWlM?=
 =?utf-8?B?TU5nT09XQWs4dmYxZjFJblNsR1U3N3pSTTdwTmVRVHBIMjNLMW5Rb3ZjWWE5?=
 =?utf-8?B?R1QyYUxWbEs3ZnBac2swamsyTWpqWm8vTE9jUWZ6TlZXVWUxRjNDNkRCMkox?=
 =?utf-8?B?UzV6ZTZjTklDa2Uyb1lmd2Z0S1RTVGFpamRjVUdsSEo2QXZyNGxHcUVQbll0?=
 =?utf-8?B?M2hEaWQ2QlVoQmEzUDhkaGhETFRLalJJQlNaN1hTV0dOZVJEMGcwL3FiaHBy?=
 =?utf-8?B?MW94UGcwb3Zzc1hEVWxGSEVhMm9Kd3VTWDIvN0RXTithN1ZyR0V6cFo3akJh?=
 =?utf-8?B?ejVXbHNGZEhDYU45amN2UHNKWEhGUnh6eUxGK2o3MVFUcTlxZUNyTmlNMjd0?=
 =?utf-8?B?WTZjaXRMS1pPT3l1QWovL1B3VTh2UDF1b3ZaQ0JOVE4xb2JlWEdJRXZHZVNS?=
 =?utf-8?B?VXVMWVZuMzZtZzV0NFpPcmJKcEU0Z0ZYckJKdVhEM242WEIvdysyL1BWSkw5?=
 =?utf-8?B?emVVZTJ1VXJ6eS83R3E2OVlzNmpQRld0S2lwQk9VeUh2emlyMlN4QmlvQ0wy?=
 =?utf-8?B?SXFpdG9hOThzalJLOFhzT0t1S0lHRnZDSlNMOGw3bXc2M2VBU0E4eExzWkpX?=
 =?utf-8?B?OUZBWWs5VklBbG1BN1JHazJuRldIOFZWdjd6RVk3WFpuNWF1Z3ZINlV4ZE5X?=
 =?utf-8?B?WUNnZ2dYOWcrWTArUlFFUWxNUUxEVWhTSXdVTHFZcHpOUy9haGNKTElVNkdX?=
 =?utf-8?B?MEJxUHl5RXJ5a05NMXZUSjhWQkMyV2hDdVAvU2grcG5vNXozMVlpM3k1Y0ZH?=
 =?utf-8?B?Nnd5eGUxWEhEMVBybVlIWVM0a1lQUDNwZHF6bkN2TVd1bTduZmhSWHdNOXd3?=
 =?utf-8?B?aU0rM2NCUXZVMWNPOC8zNS9hQ2lNS2VtV1E3dVNiUjdYN1RvRHhHNEszRHlF?=
 =?utf-8?B?MHFtYXVlaGtYTDNkQXF5c3hLRTNsV014SEw1Tlhub0dhV0IvMk9oZnQwalhW?=
 =?utf-8?B?eTltbUFsVVpXSURMdFd1VU91ZFUzK3JldW5JdG1tYWJBeTEycXNJTnpKcDBJ?=
 =?utf-8?B?aTdrN2VkYWxuMWNrZTByRENvMytsRm50aEQ5a2M4Qm9iV1didTFVUTN4RFRG?=
 =?utf-8?B?UmV0aHhESktpQ3lMMjFjV3A2dVpXN1BtdncyMDhTRXRweGZKRDYzalArSkIy?=
 =?utf-8?B?bndNUVJRbzlXNjlnbGcvVkI5K08xcUhEbW5hdGJOWjFrS0luTUhKMVRVaThO?=
 =?utf-8?B?eHQ3U2xrVHNRQ3B4K3NNMGdMcTk3SjNhci9YTklFTUpOSXNJajkxOGo5eThE?=
 =?utf-8?Q?hgGCd1iAhl/J+ZHA47N5LZOy5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e925017-445f-4d6a-bc98-08dbcf3e2bd3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:23:34.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aLhc1ONfUlRWpPAO5QNqrRCrT0HK2WRj4J+uuDPnzgf7y6WYMeIEz7cbDU6PlhurEifahjFDlDFK7UDpP3n2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 12:23 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Using struct gpio_chip is not safe as it will disappear if the
> underlying driver is unbound for any reason. Switch to using reference
> counted struct gpio_device and its dedicated accessors.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Tested-by: Dipen Patel <dipenp@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> [andy: used gpio_device_find_by_fwnode()]
> Reviewed-by: Dipen Patel <dipenp@nvidia.com>
> Link: https://lore.kernel.org/r/20231010151709.4104747-3-andriy.shevchenko@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Dipen,
> 
> Can you retest this patch now rebased on top of current GPIO for-next?
Tested-by: Dipen Patel <dipenp@nvidia.com>
> 
> v1 -> v2:
> - rebase on top of current gpio/for-next
> 
>  drivers/hte/hte-tegra194.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> index 6fe6897047ac..341a134cb7d0 100644
> --- a/drivers/hte/hte-tegra194.c
> +++ b/drivers/hte/hte-tegra194.c
> @@ -132,7 +132,7 @@ struct tegra_hte_soc {
>  	const struct tegra_hte_data *prov_data;
>  	struct tegra_hte_line_data *line_data;
>  	struct hte_chip *chip;
> -	struct gpio_chip *c;
> +	struct gpio_device *gdev;
>  	void __iomem *regs;
>  };
>  
> @@ -418,7 +418,7 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
>  	 * HTE/GTE namespace.
>  	 */
>  	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && !args) {
> -		line_id = desc->attr.line_id - gs->c->base;
> +		line_id = desc->attr.line_id - gpio_device_get_base(gs->gdev);
>  		map = gs->prov_data->map;
>  		map_sz = gs->prov_data->map_sz;
>  	} else if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && args) {
> @@ -645,7 +645,7 @@ static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
>  	if (!hte_dev || (hte_dev->prov_data->type != HTE_TEGRA_TYPE_GPIO))
>  		return false;
>  
> -	return hte_dev->c == gpiod_to_chip(hdesc->attr.line_data);
> +	return hte_dev->gdev == gpiod_to_gpio_device(hdesc->attr.line_data);
>  }
>  
>  static const struct of_device_id tegra_hte_of_match[] = {
> @@ -673,14 +673,11 @@ static void tegra_gte_disable(void *data)
>  	tegra_hte_writel(gs, HTE_TECTRL, 0);
>  }
>  
> -static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
> +static void tegra_hte_put_gpio_device(void *data)
>  {
> -	return !strcmp(chip->label, data);
> -}
> +	struct gpio_device *gdev = data;
>  
> -static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
> -{
> -	return chip->fwnode == of_node_to_fwnode(data);
> +	gpio_device_put(gdev);
>  }
>  
>  static int tegra_hte_probe(struct platform_device *pdev)
> @@ -760,8 +757,8 @@ static int tegra_hte_probe(struct platform_device *pdev)
>  
>  		if (of_device_is_compatible(dev->of_node,
>  					    "nvidia,tegra194-gte-aon")) {
> -			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
> -						tegra_get_gpiochip_from_name);
> +			hte_dev->gdev =
> +				gpio_device_find_by_label("tegra194-gpio-aon");
>  		} else {
>  			gpio_ctrl = of_parse_phandle(dev->of_node,
>  						     "nvidia,gpio-controller",
> @@ -772,14 +769,19 @@ static int tegra_hte_probe(struct platform_device *pdev)
>  				return -ENODEV;
>  			}
>  
> -			hte_dev->c = gpiochip_find(gpio_ctrl,
> -						   tegra_gpiochip_match);
> +			hte_dev->gdev =
> +				gpio_device_find_by_fwnode(of_fwnode_handle(gpio_ctrl));
>  			of_node_put(gpio_ctrl);
>  		}
>  
> -		if (!hte_dev->c)
> +		if (!hte_dev->gdev)
>  			return dev_err_probe(dev, -EPROBE_DEFER,
>  					     "wait for gpio controller\n");
> +
> +		ret = devm_add_action_or_reset(dev, tegra_hte_put_gpio_device,
> +					       hte_dev->gdev);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	hte_dev->chip = gc;

