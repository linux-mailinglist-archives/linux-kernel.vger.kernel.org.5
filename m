Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17FD7C04A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjJJTbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:31:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFA93;
        Tue, 10 Oct 2023 12:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kq5o5JryZeE7zX22VNu4ah+lNJDuD9jfmwEbUfHB8tKLkNApz8gwuOJZ6grBkcDt3QUHjbM8XmkAy+hUuzxAkqmHEfKjkG7sZn5XlNb2+5V2SCm+GJfsMDf6avJWBmo9BpBp/7hNTYd/uVoForWRVuZBRQgi0o7mncK5xjaFg2EbO5NbZvQW50PEsNxbW1SM2OA527S0EopGFZsvlB4v8c/MJE/DEX/AK9Ws2pD1xHIwSevfBOciniVjHEef0piYxzhf0K3D9oTtNV2KEZ8oieZTTsnOIXNV4g3lp5QInrtKHEjFQaPrMEhOMqc3uXhiImPZ8uUc9QsNWQWxp56hsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPMqpFmL/qkDeTPh1Uruw88jf+UrHdRvT5aQ4P5ctUc=;
 b=auENzkKKpxfYWKZOj9+7/5hF7rLB+qh3FU31T2DnmCRJUnJAqJacttt3bUEw3H8k5CsznJ0sjuI2om79ottrJ6KFj+Ovk2Q6f6GVfFw8AlCPSm6Xgus5JRo6oUReibRnnqID5EmOrX2kdI2OVQbSW6C6i89YtCEvqJU+pTxeUmIELSDCw2OVYwu3NVlhQz640QlpTF5ebiottUHeFbrblbSDJp0oAeoe1kj9L5Fox2mo3D9+b810hYkhv+fw+FP1Vw0ej1e5/WihRhAJbXDrw+G7mu04sisXFPPxY4tApzery6CFAsIwm/d6n3//enRTId60hYshVq8Vnj3HCZdkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPMqpFmL/qkDeTPh1Uruw88jf+UrHdRvT5aQ4P5ctUc=;
 b=MDbFga1ghejwW1Th44y1WqdgUpHFTxsVh6EjLHkj9IMQvQsnCpOsfMonR8jRbrK4dmjNgH0ukLmtrHlReSYt9NjAGBCV7kAoDfYIH5fH8sgPYCoMi+6fcuWnQKtNUqACXKOasyX44qCU8GvxULbGC9JCft7Z6emhXpemnf5Mdng7/qz7UVKU56ni/rr090bCgx/DdBQN9XSbRNL0fLgO3yjCcf38LBbftpAe6x45NxD8+U6mMSOJlZ8cgEzPq5IUR/oCMcjAsa6Qr9YlOnugIzl8C3augIZ1iY1fOfF674xMp9cz3ffFQRDEGbqNp76Q9qlSYwG9SDytvwQGDmRwnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 19:31:33 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 19:31:33 +0000
Message-ID: <147fe15c-13d3-60dc-bd49-cd0cb40126e9@nvidia.com>
Date:   Tue, 10 Oct 2023 12:31:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/4] hte: tegra194: don't access struct gpio_chip
Content-Language: en-US
From:   Dipen Patel <dipenp@nvidia.com>
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
 <20231010151709.4104747-3-andriy.shevchenko@linux.intel.com>
 <3e1e6acf-5862-9f35-cbe6-72bb17cf3851@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <3e1e6acf-5862-9f35-cbe6-72bb17cf3851@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 23343a93-402b-4ba2-6e93-08dbc9c782c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLuvtKWZcLCKcNizNWOr2YPlELvngbLGBNjYb8TVLCIPcpd6pkBvauFNdZZ0JPyytgVpnc3vV6QjG7uhzpUoBqmt6nKFk+6pb7umHKhDM7SXY0aidoF4exvWj31lpu11ema7H2et6d/3jEHKmljsVotM6/wDYz5KdU7BNkOMWtQooUhc3y41CTQ+kzgHSc/bAqCq2Dz2VRvu8Q9GqV3T23Cxnb7KM0HU2toM3WfbtqaV7Jxv+yYo4g7mcGLr3pDzKVpzz1hxjx49Onzeb0cndT72+sEKpJRp6scdxq29sD62wZ0l/WnQP3UNrFWFIj8zYxPjKBUvp8JUYYv6vcBlHJ8vhUKk0sOz0Uq/JVv1d5g+bx1hvHoLQc9rNOo2LRVn4AN7q12q0SLXlTZz63ZKDthGZjs/oDnIYUYHm4A+KwTZi+dZxG35ytxyJXMUmq3M5ZJkeqTiiX+ACobm82bN9fR9dFgSQpnKN8ZsdMQmM42RkFa1nVVxIuJkSIWdCVOJLxPJoJgDJJ7xWtlV++Kr0+b5HTOpiP8eBmqTdDYV9OVTyS1vh0BEeVSXutbPk0Q2LXZTIrZL1qokxHgaI7nmoccyS5EWRMSUj+E/Us/tl8zMhxA0iKQ4MWeKzBZURoCaAuwisERLa+WcKMzMIdAXAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6666004)(31686004)(53546011)(2616005)(107886003)(6506007)(6512007)(86362001)(36756003)(31696002)(38100700002)(83380400001)(2906002)(7416002)(41300700001)(6486002)(478600001)(316002)(8676002)(8936002)(4326008)(66946007)(26005)(5660300002)(110136005)(66556008)(54906003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2paRkxCa0JlTFkyUTJvcnlabzIzZjZScjlVUk0vRWV4YnhZT0hWY3RLK0Rq?=
 =?utf-8?B?anRFbjdZU05wRXFzaWNueU5wTG53aU5xVWJYd3J5VHo3Y1VuUXBudVRMdXcv?=
 =?utf-8?B?SXpHMEJtTU1jcmFQekd6eFg4a2U3MGFMNjVpVy9nWnhWZlh6aXA1eDluOWFx?=
 =?utf-8?B?R0Y1c0FBeGVnQWdkbXA4eEt4ZXRPbHQxdWJabjNKK2Y0RlFEUGxwVW1GZHZk?=
 =?utf-8?B?NXV3TkwrK2lkUDBVdTRIQy9pZEtwZWdnZWxGVFAwbWlBRUU3TzdzazBJcTd5?=
 =?utf-8?B?WFMzdVJpbnA5RTYzSXZaWUE2bER4Q3BaY3N4QUd5VWZTM3lzSWttY3NwUWFh?=
 =?utf-8?B?a1pPT0M3NjV4bmdzT2tpdmQ1dVJIckJ0ZUNhdE1WNzZNZkNkUDIxb0VyT2tt?=
 =?utf-8?B?QzA1M1I2TmN3eE8wWUk4Z0RPdUR2VE14ZEEramNQQk1qMHJ1eGpOQjVLOWJ0?=
 =?utf-8?B?N1JxcjNVMnVYYzJZZDZuYTZvL1p5dEI4Q0dpa0lBUFJtZjI4aXBVdWpxUVJr?=
 =?utf-8?B?SWVqREE1b3J0QmxGYjJ3UTdsOEVIWEgyY3B6dVF6OHNkQXU5M09UMyt4dlRT?=
 =?utf-8?B?NU5kMEhlZVRMZzhsOWJ0NUR2RWJvekd3aHI3Vy9lRXRPOHp5Ylp0NUM1ZEVu?=
 =?utf-8?B?dGFwbUNzTVgvNTEyTzB2dlFYbnBRU2hYRUVoYTkyUWx4T1V1aUNIM2x5R1ht?=
 =?utf-8?B?aEtOWit1V1dRakRrZklFQVpPMlU5Nkd0S1l4UEVZUys4Q0xDU1BnU1p4RGdT?=
 =?utf-8?B?bytaUzRHS0d1WGtBMlN3c2tnUEFRbkpTVXEySll5TXVUcHYycGhCSkUzMjBL?=
 =?utf-8?B?TEp5WkNXazNWNHdHanlCMkg1K1JrSVBZelVDTHJGT2hEV3YwZFFrdkU1ZzJi?=
 =?utf-8?B?U2s5VzhQL1crLzE1M2JoSXVYMExjY0EzNkp4UHNMbEZWaGgrd0x1ZDlJa0NO?=
 =?utf-8?B?cTN1N0hCQUluQzNUQUw4VWExNUdUSXdhUjB3M1M2cFpSZ2NKNXR3WmFJOE5w?=
 =?utf-8?B?MjVqeW5CdFRUcUlMM0hIZnV6L0NTZmx4WHZYVHF5cWxZS1ZwZWhLcFR0K0xm?=
 =?utf-8?B?YldIWGJscFdyeGo1b1VuMjdIUldGcXFsbHlkSmpWZ3RyNHRFamsvaE9iTjhl?=
 =?utf-8?B?T1dyOURxV0RQTllCSUpqdmRhNmgwU1hFcGRLUzNUMW1WRzRMa1V6cmM0NEtn?=
 =?utf-8?B?akI4RUtTVFlESFlCK29IemM3WHVFUHBuUTZlUzFOWm5hVGpua29FMzVPbHVJ?=
 =?utf-8?B?cVpjbjFpZ1RmNlI3ZmgyeWJXemVtbTc0WEYvbURaSlVVeGJ3NExIS2drVXRu?=
 =?utf-8?B?RzdkbnhYV3hoNnFGVnpWamdpTFJsSklKNk9yVThQSEtBRStsSE5xdFl6L2hQ?=
 =?utf-8?B?T21MZ1R0ckdEZ1A1amE3OS9CWDJSUE8ySHJFRXE0cm5yenJZMy9Fb3dBL3JL?=
 =?utf-8?B?VkZKSUhHeWhqSWNyZmtmRWJiWk9rTXYzcC9UL1h3QlpERkgyOW5Pclo2aCtI?=
 =?utf-8?B?by9qdUVCMjNkOFZodlg0NlBHa2JyMjU2Yk8wQS90eGQzUDd6cjlOeXZQZUtt?=
 =?utf-8?B?N0VHQm0yZUNJWTAvMW90amxGZEFCa3hyZXlxWXFpSUx0clBSU0xRZFRLZGZu?=
 =?utf-8?B?c3A4bmU3Qk9oSFV1SkhlTTdhSlVua3dvcFM5bXkyajl6Z2hRWkhCM0Npd0Vw?=
 =?utf-8?B?OE85VXlkdUMwZk91eWx4VHdwRzRIbGwzaERHNS9wbmRSODV3ZFRMRzZpQUFl?=
 =?utf-8?B?anRySkRMdWJ3dGkwM0cyMUJ4aXhCMjRaVzhXM1FoYnpLMndBbXdYNEhSR1dP?=
 =?utf-8?B?L0tCZWFCLzNieGVaTDlTUWJ4bU0raC9hOC84L0pMZzNGTXE5SEFaVFA1ZXE0?=
 =?utf-8?B?Kzh2dFc1U2FtT25OTS9ZOThhVEZHWlJ4Ky9rRGZJMXZxQ0QwV0pRQ0V3VXJ1?=
 =?utf-8?B?RXF2ZVIzVmV4YkwwRTJZSnZZU3FUWVc5Uk1hUVJXV0Q1aFQ1UzNZTXJlcVlz?=
 =?utf-8?B?M21qV2dCNWR1NVVNNnBPb28zdTFlVFNQcVlZZ09NSUpUaWpzU3VLSEErV2dK?=
 =?utf-8?B?S1NqUFlEdm9Odk1zbUczd1JpTjRWSmNHZWQ3VzdON1pJWktva21lWTJSTENj?=
 =?utf-8?Q?y2WS5bMlLzAIEUcZCTezDZRRE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23343a93-402b-4ba2-6e93-08dbc9c782c1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 19:31:33.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzQwAUu/v+qN7AXZcYCb/nWbBt3praXRHfJN8p8tQZXXWOdwcI6Ah1AEES25r54tWK2lTGcc+OVbNQaUOjL2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 9:19 AM, Dipen Patel wrote:
> On 10/10/23 8:17 AM, Andy Shevchenko wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Using struct gpio_chip is not safe as it will disappear if the
>> underlying driver is unbound for any reason. Switch to using reference
>> counted struct gpio_device and its dedicated accessors.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> Tested-by: Dipen Patel <dipenp@nvidia.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> [andy: used gpio_device_find_by_fwnode()]
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/hte/hte-tegra194.c | 33 +++++++++++++++++++--------------
>>  1 file changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
>> index 9fd3c00ff695..339ff5921ec8 100644
>> --- a/drivers/hte/hte-tegra194.c
>> +++ b/drivers/hte/hte-tegra194.c
>> @@ -132,7 +132,7 @@ struct tegra_hte_soc {
>>  	const struct tegra_hte_data *prov_data;
>>  	struct tegra_hte_line_data *line_data;
>>  	struct hte_chip *chip;
>> -	struct gpio_chip *c;
>> +	struct gpio_device *gdev;
>>  	void __iomem *regs;
>>  };
>>  
>> @@ -421,7 +421,7 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
>>  	 * HTE/GTE namespace.
>>  	 */
>>  	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && !args) {
>> -		line_id = desc->attr.line_id - gs->c->base;
>> +		line_id = desc->attr.line_id - gpio_device_get_base(gs->gdev);
>>  		map = gs->prov_data->map;
>>  		map_sz = gs->prov_data->map_sz;
>>  	} else if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && args) {
>> @@ -643,12 +643,15 @@ static irqreturn_t tegra_hte_isr(int irq, void *dev_id)
>>  static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
>>  					  const struct hte_ts_desc *hdesc)
>>  {
>> +	struct gpio_device *gdev __free(gpio_device_put) = NULL;
>>  	struct tegra_hte_soc *hte_dev = chip->data;
>>  
>>  	if (!hte_dev || (hte_dev->prov_data->type != HTE_TEGRA_TYPE_GPIO))
>>  		return false;
>>  
>> -	return hte_dev->c == gpiod_to_chip(hdesc->attr.line_data);
>> +	gdev = gpiod_to_device(hdesc->attr.line_data);
>> +
>> +	return hte_dev->gdev == gdev;
>>  }
>>  
>>  static const struct of_device_id tegra_hte_of_match[] = {
>> @@ -676,14 +679,11 @@ static void tegra_gte_disable(void *data)
>>  	tegra_hte_writel(gs, HTE_TECTRL, 0);
>>  }
>>  
>> -static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
>> +static void tegra_hte_put_gpio_device(void *data)
>>  {
>> -	return !strcmp(chip->label, data);
>> -}
>> +	struct gpio_device *gdev = data;
>>  
>> -static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
>> -{
>> -	return chip->fwnode == of_node_to_fwnode(data);
>> +	gpio_device_put(gdev);
>>  }
>>  
>>  static int tegra_hte_probe(struct platform_device *pdev)
>> @@ -763,8 +763,8 @@ static int tegra_hte_probe(struct platform_device *pdev)
>>  
>>  		if (of_device_is_compatible(dev->of_node,
>>  					    "nvidia,tegra194-gte-aon")) {
>> -			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>> -						tegra_get_gpiochip_from_name);
>> +			hte_dev->gdev =
>> +				gpio_device_find_by_label("tegra194-gpio-aon");
>>  		} else {
>>  			gpio_ctrl = of_parse_phandle(dev->of_node,
>>  						     "nvidia,gpio-controller",
>> @@ -775,14 +775,19 @@ static int tegra_hte_probe(struct platform_device *pdev)
>>  				return -ENODEV;
>>  			}
>>  
>> -			hte_dev->c = gpiochip_find(gpio_ctrl,
>> -						   tegra_gpiochip_match);
>> +			hte_dev->gdev =
>> +				gpio_device_find_by_fwnode(of_fnode_handle(gpio_ctrl));

I think there is typo for of_fnode*. Should it be of_fwnode*?

>>  			of_node_put(gpio_ctrl);
>>  		}
>>  
>> -		if (!hte_dev->c)
>> +		if (!hte_dev->gdev)
>>  			return dev_err_probe(dev, -EPROBE_DEFER,
>>  					     "wait for gpio controller\n");
>> +
>> +		ret = devm_add_action_or_reset(dev, tegra_hte_put_gpio_device,
>> +					       hte_dev->gdev);
>> +		if (ret)
>> +			return ret;
>>  	}
>>  
>>  	hte_dev->chip = gc;
> 
> Looks good to me, I will wait for others to comment and will test out (2,3,4
> also) probably end of the day 11th Oct.
> 

