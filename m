Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496D27C0176
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjJJQTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjJJQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:19:35 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F02AC;
        Tue, 10 Oct 2023 09:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+pHb8h3arVAJp9Vpl8RHQSa49jYDqCu02P5uJVc+0HcZEYylb4Hn1NawQ0Er5HTegEnj27JasT2gkqjlOkyuTlk4yCcokNsk1PSJ1QX/unAGevp8kCeU1LLqiWcbCKd+84cka6YCPbVtS5chBtxlVmi9htRrKX2402CIqn0s33F2KZRk/VCtdbzZ8zk3X5FZpqluoahf8vtl+jwyyNKGryEU2BF9unFKoQ2v0+jWfRahxJOrUzFL98MQcQKhco+XSzXKCAPVw/XiKw8pPf9EJwShtCOc+FLBPaNU1NYTrLzUhpo6z5OmSNjD/Dh7yLNEgrLPZwCw+LFhDN6UXdIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfzkA0GQQLXO9CL/qP+sLdO+j/ZeJD4MDPWdzhJAQ4s=;
 b=XGxsT5VVAp5Z+mx03ZIK69DQwiyPHCP+aYCfO4qqbBv4HAjVpjewGVoo1+q7LXmtdZqc52mUGbVfRsQvKPp0tpZ2j6DcRXJtgaDmL35NqR1/M/RIQDNKQKcdQ6bFwbYok79tNPFdEtC5w9u1kJxAflbmJnRpotn0ZZOrSiUm7Na2lyQab526Gey91MvM8L6Q5vqGOEXjXhzacqlnyg5xI4TCzCtZ6QgSqPwetUuICSEZ5Rh7QQ7UR1/lZCMa/EIxVR23bBwlFD00pP3MK1WaJwG7HEVJWQPLRo7c9VxLau8JYZuIINFeUXMSI9N+pofjqJhNxncHdjATyt3D3BFzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfzkA0GQQLXO9CL/qP+sLdO+j/ZeJD4MDPWdzhJAQ4s=;
 b=s6i/WZpEpAl5KHCBn/cMQocr++nj5ze4h4W47ZxDL9lo7DN1DBpBOuIynRPHxsrkdxcFrtRzF4KZrcND7BY/+B4O2yesdCabv/cKl6tF5X46T3otRRUvbi24u5JleatzhCguodSFi8+Q58MDcph/jZ9XVQtms31j6+gVUx3g6Y0hMTnDFoRjFL91gXcGGTtwbfWIh2mrBnRVSLhmQLafHtwRSbZ4Mrqr8yq7+Jw8d28Z8HapWMVVo50MsXdbUmg0vUcv18ooZdnTG/9U0OF0pmXfa/iwHO/jWO0wO4VNBwg4nJxCMBzM73fg8dEgMnkFtU2VlLz5x6DV115Mg3lUgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 16:19:30 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:19:30 +0000
Message-ID: <3e1e6acf-5862-9f35-cbe6-72bb17cf3851@nvidia.com>
Date:   Tue, 10 Oct 2023 09:19:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/4] hte: tegra194: don't access struct gpio_chip
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
 <20231010151709.4104747-3-andriy.shevchenko@linux.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20231010151709.4104747-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ba1320-dc2b-4946-52de-08dbc9acae88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhP6fR+yRFeHgNj5F3wBDYHe4jigT1BvqIyPRr0iz6fnr1NwpgBJ0DCzajQcE6dfRy20bK4J+5QoFcYHJGyNQA43112Q0fgtRGlQTRi7SdpzoYZDLAA+zOXP3BKiLl03mZksh/TpoLBNAxkxPJWX6mgkXc103YYGMhTq8QHvVBSFk88gTiQqVvSj2I+mwv9/LCqkVRbQWxXqidRoPpOVlvb/mte4h/dPiFxDW7DnFqk0JFuDI1UNfJnT0yEGd3wHvWa/PhzkCDw/4T8R3NW0zoIv2S0ir7DLplWyaJZ8WCfNrovzpeRtnMxnmk+7etUZe7Vf81CS6yIFQ/EIb6s+seMvJRnfz9k27zmbQfp69R2GY4yJ7GD9LGskz3YiTgIWXy++6kktuyPqITkdzfFf2oPG/qXfoWQMjxybkR7MLrT++PrM+yiI9e76CLA7hnX6lP77ylAolZTaUVHHcrugtkdrXpM+Q4uD6fDg/3ZoeyWRmuRf1/sBl/lvtWrGWo8Pd25wSQi7bruzMz4z914KkgdrOd7D9ZFqHcV6uwivc0beNUdsaIH4z7hjDyG7Uv1Ue++EAmfYeOJa52BKNTxnhiC+goGkwH2WK0oEq+GTa+/0EZ6/uD3DFCfKLkZokUhGv0ub76GQErMxpyWVZ15Rtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(83380400001)(38100700002)(8936002)(4326008)(8676002)(110136005)(54906003)(66946007)(66476007)(316002)(2616005)(66556008)(107886003)(2906002)(5660300002)(7416002)(41300700001)(478600001)(53546011)(6506007)(6666004)(6486002)(6512007)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjV3T3N0M2dzblJ2cnNNcEtOakZ0Vyt2djhlOU5tRWhuL3ZhV1pDOCtFRnRt?=
 =?utf-8?B?WWZVSm0vbWVVbGFubDk5cDMwSnE2QW9aaUs0eVJ2RHF2RmNjaFB1M3BuZEQv?=
 =?utf-8?B?ZmVsc0lNalBuR3BhRzU2NWpzdkUwMTJFcFRPek9rUkJMcGR2WU5xcDRhQk9s?=
 =?utf-8?B?ZDJoaGpNOERBa2FhQlFPTUtiVFh5OTJ0NWptQVBSUjRlV2tiVnJXTytjQTRt?=
 =?utf-8?B?M0FZS3BXNEhGc1pVQlYzR0NuT3pMdzRBS2tpMnVFRVZlYnlsUGdhNko0T21k?=
 =?utf-8?B?ZmdqVVAvUmlZRGhCRVBuVUtRNVBUaUlXbUNlMnI2OFdOZkMzNGRwTW1oRGhL?=
 =?utf-8?B?UGVQVnRWV2tuWnVnK3JXK0NiZi9iN0d3VHJxaXozQkRIQ3FmNGxNL1NSNHg5?=
 =?utf-8?B?RlJZTGdIeUI2THorUmNRbWdYTy9IMndjQTRxRWxBYXIyL0JTcEVOdy9ZUEww?=
 =?utf-8?B?N0ZxK2pwUit4MFNGdCs2Mm00YUMyaGM5a3F4OEJTa2h1cU5lZnFpZmpXQlZX?=
 =?utf-8?B?VCtpMno1YWVGek54WnpyU1g1aVVVTzdiMnNIZGptYU44NVd1WnRVemRRRENV?=
 =?utf-8?B?bXZJeFhVZUMxbWduUUU2cm54MTNRaFlWRUlqci9SSnVCOGcrK2drOVJaYlpK?=
 =?utf-8?B?aldPMHFvZVRURE54K05oVDNsLzUwWkpHUzZ4aklraUFyZTNZL2lZektWN05U?=
 =?utf-8?B?eUhDL05SMXJjK1FkTDJkdmpwQjlkWkF2TnZZTk9KaldUZkpWSVpFTjk2VWNz?=
 =?utf-8?B?QTdFK3ZJa0NldkFJc3hkNVFvZ3R0NzdmWktDaHczKzJPT1h5R3g3amd2Nk56?=
 =?utf-8?B?V21GczBhbkFNT0c4emFBejdqbXJ6TDQ2a2hqWE4wQlR0U3VsQytEZjZ2d3VI?=
 =?utf-8?B?aFgxN3hzV3M0VlY1cXNCcmRVeTVjckZKOTNVQkNnOXhYd0pSMlcwQjIrbXhi?=
 =?utf-8?B?ZVRPdXp3bkFxMHVCRjFaT3VOMDQ1Z2VyY00xdzNlaGxrRDZ4L3pVQ0hMZDVM?=
 =?utf-8?B?RHRUcmtVMkJTSkREeU5CaVgvRlFJL2FiY1VOZElJZUprMWcrZ1lpUEJyYldw?=
 =?utf-8?B?dTlCOUVGV21GbjlMakhKU1RXbjdkVjV0OUpxT3N0NEQ1ZjRFUjJIeFJMZlF5?=
 =?utf-8?B?amwzN0tpbG5WYmRBSUVSV0QxcS9ST0VjYmdRbTNYc2RuM3hrb0pnangybmFp?=
 =?utf-8?B?UHZqRnJ0TThtQkhEdFZ2TXdaUHJyZ0Qrb2JnUE51VHMwUkZ6OU1UdURSMkMr?=
 =?utf-8?B?R2huVy9QaE9UVWgxaFRINkViZU4yOWVQbWxKbHh2dEtZYkR2REtwQkp1SVND?=
 =?utf-8?B?c0pSVDBzdmtFUlYvcklKK0VqTVdrQ20xWmI3bzFnRlMwQmNWeExaRys2RFNu?=
 =?utf-8?B?TTF5M1JDMkNXNTBGSzZVWmhDMzY4YXNJaDBRS3RXcFozZ3gyOWxDMmpSUzNK?=
 =?utf-8?B?QXNRenB5Z0xVVjNuRDJUNHptTmgzVzV6Y2tndmhnTy90WnJoZ2JPUXpaTWF1?=
 =?utf-8?B?SzhnY2g3dHdiOVJILzFSNzRSUzQwSmE2YStaVWhmaCtackxKOTBmV3QzSWlx?=
 =?utf-8?B?SGkzSEprekkrNDQ0MGxZRGZVTWYxWjVpeVpFckNxQ1Z2Znhjek4vbkRDbnox?=
 =?utf-8?B?aDdkVUttY1E2aklOaHV5QjFLVHNLZmF0MVpmR2JNTzVSVkM2RWhmaG1SVmhp?=
 =?utf-8?B?NnNMQSt2bEpwTERnWVp2eFBST1VmRjdNdkhVRXZrT3Ixazh5NTdKTzh2bGQ0?=
 =?utf-8?B?Qno4cTgrK2pHNWk5REJSUVhkd3dZenFld3Y3UWVXb0Fkbnl3elo1MU5WZ0hN?=
 =?utf-8?B?RkhqYkxKZzJYa1pvcSs1UWp6dTJGTVZPOGxaaWxsZi9hcjhrL2FydUZMTkl1?=
 =?utf-8?B?b2RreVVvYmNETHg1UU9aMmFjN1Z1dUhTSDJzU21DRm1kWlNlWEw2THN6cTll?=
 =?utf-8?B?YytBZTBMaDU1eEdZMVMwZWRQYWJIVTVLU0ZhODdQQkJmWW5odnNBZXpsUmtY?=
 =?utf-8?B?UThkMGdrNWY4dUxhaE0wWEVvdnQ2NGlZS1U0MXNEREt0R2pZbzluK0lxbkps?=
 =?utf-8?B?eHdsbWxiT25vVU5pSzZrVUVaM2drZUcrYUtMVmQwejk1VVBDYlBOQnBKTEhX?=
 =?utf-8?Q?TCVhEAv0OvK454Kwc6CmshlyP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ba1320-dc2b-4946-52de-08dbc9acae88
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:19:30.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXMj9n4sj/FW7ZoqWQkVB/7hCTXzR84hcl2MWc6iJINM1O974i7aYOMLkXKIJPYsepazjkcqCJBA+Nr7VIoeRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 8:17 AM, Andy Shevchenko wrote:
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
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hte/hte-tegra194.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> index 9fd3c00ff695..339ff5921ec8 100644
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
> @@ -421,7 +421,7 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
>  	 * HTE/GTE namespace.
>  	 */
>  	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && !args) {
> -		line_id = desc->attr.line_id - gs->c->base;
> +		line_id = desc->attr.line_id - gpio_device_get_base(gs->gdev);
>  		map = gs->prov_data->map;
>  		map_sz = gs->prov_data->map_sz;
>  	} else if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && args) {
> @@ -643,12 +643,15 @@ static irqreturn_t tegra_hte_isr(int irq, void *dev_id)
>  static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
>  					  const struct hte_ts_desc *hdesc)
>  {
> +	struct gpio_device *gdev __free(gpio_device_put) = NULL;
>  	struct tegra_hte_soc *hte_dev = chip->data;
>  
>  	if (!hte_dev || (hte_dev->prov_data->type != HTE_TEGRA_TYPE_GPIO))
>  		return false;
>  
> -	return hte_dev->c == gpiod_to_chip(hdesc->attr.line_data);
> +	gdev = gpiod_to_device(hdesc->attr.line_data);
> +
> +	return hte_dev->gdev == gdev;
>  }
>  
>  static const struct of_device_id tegra_hte_of_match[] = {
> @@ -676,14 +679,11 @@ static void tegra_gte_disable(void *data)
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
> @@ -763,8 +763,8 @@ static int tegra_hte_probe(struct platform_device *pdev)
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
> @@ -775,14 +775,19 @@ static int tegra_hte_probe(struct platform_device *pdev)
>  				return -ENODEV;
>  			}
>  
> -			hte_dev->c = gpiochip_find(gpio_ctrl,
> -						   tegra_gpiochip_match);
> +			hte_dev->gdev =
> +				gpio_device_find_by_fwnode(of_fnode_handle(gpio_ctrl));
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

Looks good to me, I will wait for others to comment and will test out (2,3,4
also) probably end of the day 11th Oct.

