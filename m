Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4079F7B3C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjI2Viu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjI2Vis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:38:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85998B7;
        Fri, 29 Sep 2023 14:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJr6tye+5wO4/i/dGFxjNef+n+LOM12XabhA+941hV0tYjI0U1kG7MsSNB5A1ZNrqipy5BPKPUlZTmwEsYnGVCG65o3fA+I6ylFQypWDQ1X3/EjyWRc1LdJ01Jbhuy3iTkOY6BAUP1YXTqazy/b5CuuQSJCXjEpdz5Psc7oZ/Zx/Wq5LhEeBfzTnht3+G9fybA1/6HdOqFnWHfhv/aFdNmqHSXDamPOsdcLinRv5BPb6JpenDnlwO6yK5sQxVjfQYJYdYWSzV45ViqYfHt3J0T8iNbgiNow94acy0A7wfItA75NUnMNGv+PdDRLsCPrcDRZPPUfBnN9fMDUV5EO4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9y9wp7MJ945Ql3bNSB3pfEEL2mbvy1npG3q4uva4HE=;
 b=odyPkzkJ6jT00jvYjblxei+BUlRZe1/Ln+wm8yvmHnHjofgJySTCfjfcAPGfXPkrWrKzLzqQxLJzVx38cO+UHux0F9IvzfM7hbZkZNx82chsoS68fOhf9ad/OQp4J4Y/FmyALp68FIaQv9hn3VtL242g6h2DBQEWFjH20tO9EHMDHZqe1AhDqNLxm+iVVq/M22g7z97S8UbCFhnVdD9K0d8oQ6jeJVS1Y3t/w9+znCFFcBftwm9iQQYiVz5EGxugIg/DrJEGNyTlky69cYjMus1g8jsc+SA4dgL5dorOrSSVyfUjmBrAlxkjxPy8ewIpmgz2UubZCnel+q6F6qllqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9y9wp7MJ945Ql3bNSB3pfEEL2mbvy1npG3q4uva4HE=;
 b=h9tsl8UGd/Zo05wKcUTtfcXcFIhnmV3+6vzh3WQzLOmXvuAkchxl/y8EhKCR7oPaj8Ai7p+3pYNCv1xPmSG2C+mZb7oFHFzixa/4ktMQd/Ri6Oyg6DwuiVcgI/u/ui5XHLt1J2r9NOa+SG5ikRU1BQaYAYjLVdvUZP2CtUX7+8bHNVMOms41C6ghQyzpW5+namVJtrzF+BU2S3AFvGmFkxdgHDMwE1I1OWm02zhzivVCSunzz+ET49e9zFAwH8z6fD7nY1GTnVe928G2jPQeXmsjSQYlkRZJiKBP7PhV3GCSN+ZM9egHLgm3S2aoMg9+/DLyAbzMqRKJhjHz/MUlQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) by
 SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 21:38:42 +0000
Received: from DS0PR12MB6607.namprd12.prod.outlook.com
 ([fe80::3ce8:e189:f31c:454]) by DS0PR12MB6607.namprd12.prod.outlook.com
 ([fe80::3ce8:e189:f31c:454%3]) with mapi id 15.20.6792.021; Fri, 29 Sep 2023
 21:38:41 +0000
Message-ID: <cd4df23c-cc02-6723-e36d-34ca03409e6e@nvidia.com>
Date:   Fri, 29 Sep 2023 14:38:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hte: tegra194: improve the GPIO-related comment
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230911094443.14040-1-brgl@bgdev.pl>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20230911094443.14040-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To DS0PR12MB6607.namprd12.prod.outlook.com
 (2603:10b6:8:d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6607:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: add3ce66-c105-422a-b5c2-08dbc13472f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwhBiQYQPkrya9r/S8bS3GT0QmxfqyjIHj3fzkZVRQh1p4evgI+6uNQVpaJm9/AFHyLBpJVu1F7WbdPba44H6BdSWsmTqVdtIxvqQV+UagPPNMTPI9kOhfvpQMran2zQvl6JV8uAmwYg8I7IHUJrswgXOiMQaOYKWwJT7dX55LOoFm7fLpqKJlq8YDIwlmmu0NfeZfk8MpvAWDyJRqONVCMZTu0VnXRWVwkfYoFu/l5IGEv5rpZlR6/+ihHfiARLrcfTkRepbmDDKItnd0Pnwb0Awhxv+LiQPUxTGB5sFVJ3/pqZ2aK46nZDvCcp0g8fdLoz0tl35K+tZ/5PuSrPXqnbkZxz02C255aW1vpE0vI2W6NkcNNxsRnzGbIH+Ad1w5PV8jypv91Ij8QlqfJtfgsh3BxCaIGfYOW/nrxFDV1XQNbJmcBOUXIDr3u9QDXD8MaJb/FAgZOmnEIlEAHL8sh0TfALnPOxLqMg1i+7WeRRHMvQ0w3Lp1nefEXFcSwktXyL1NmvqeS/Rfmzd2yWKV9GkO6/bGKzufm+R79IrAXmK8jMfGexof69LdF93z6tlJ7fdZrzPNplBZT2JLEh8O2qGREm82/eerhLB+zF4xTpJeKjQqgz6X+azqSm6fJYZAAVgSiKKxLSQXFN8skvoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6607.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(6506007)(2616005)(6486002)(53546011)(6512007)(86362001)(36756003)(38100700002)(31696002)(2906002)(26005)(6666004)(478600001)(83380400001)(8936002)(316002)(41300700001)(8676002)(66556008)(4326008)(66476007)(110136005)(54906003)(5660300002)(6636002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC8vRXMzNXhnZUdrVUNUU1pRZGxZMEFmekc5TWRJTGpOVGNXZzFxRDNzaUdm?=
 =?utf-8?B?Y2gxc0tGUjV3YzBoa0tQdWFQdWlmMzcrdnFrNzQ3dUlpTnZybmRlNlVLeC9a?=
 =?utf-8?B?ei9zRnRSY3dRKzhKSTFubUdEYUNUUGxXVGxXbUhpSnEwTGlUdmhwVkw0L0JF?=
 =?utf-8?B?S2xJQ3RvUDRUdk13Q0huVW5GcTR4WHVSMlBVN1d2dVdtRVA2WWR2VnViMnNP?=
 =?utf-8?B?bzB2TFgzbEZnUEZKeHBDaVVySmdXQm9Kc2t0M293VUlQNlA5cmNTYUxQMCt0?=
 =?utf-8?B?YjM4VUs5NEZQb3QvTm5NZ2FBeWxYL2crZE1QYmo2bndObkF0MlMzdFJRRkxV?=
 =?utf-8?B?Q2QwYWRiU0UyZzBWbWRldmtPenBHNjJuZDBGWDFjWHVDL2V5ZDJxUUpnTHJa?=
 =?utf-8?B?Sy8rbW4xZ1l3bDhWK2JMbTQvYUNoZ2FiOUJzN2xYZGZSakdtS29FbzhYZ0pi?=
 =?utf-8?B?bHVxWDdlak1sQ2xjQTZCNi9hOUdLbmZ0Q3lCYzJGQTFXMTgwTG5XMy9QWGRS?=
 =?utf-8?B?d0dEWUdDSzVWSzVvN2FJblB3dDdUdElvM0I2cENrTzJGVUkwTDRBRVEyRDA5?=
 =?utf-8?B?T0tpQWVQTk9kWG40RzFRQjQ0dSt0RlpjQ2QwS083eDFLem5RRE5GV3lMVk1a?=
 =?utf-8?B?YTAydmNWbzdlUFZUaTd4OVNqTzRtMDhNazVqNUpFdkFCbHllZmpjWXBTNS8r?=
 =?utf-8?B?MElKWjlzUDEySURtRk0xUnZ4WitRYnUzeWpzUzBaazFlRnBoWkI2RlVlcVhH?=
 =?utf-8?B?SVBiaE9QNmRXbng5Qnc4d1Z2bldiMjhHNkRsbzhNa1RRRWF0OWFFajRJY2cr?=
 =?utf-8?B?Y0xneWdOdTlnc01GOTNiNnJ6OTZWRlhibHNWNDY2WTVFQXV2V21SZVFpNTNy?=
 =?utf-8?B?L1M5UWtCWXpzTFcwMWhIYU9vc1RMMlNVTmZjNlZOWjZjejlWNlo2c0c5WFcw?=
 =?utf-8?B?VmdGOTFaY0ZzbFg1MFVJN3Y3VmJNaEttdnRma2RpTmUrMUNVcGpUcU9GVmhN?=
 =?utf-8?B?RjhzbHM1Y28xK3lYR0ZHdTlVbk04MVZDUzA4Q1VtWVQxTWhOMnJRRVFpZVZS?=
 =?utf-8?B?aG14UFpwVHUxQ24vMHVlRWdtUGhSQ0Myd0dkRUZnT1VRejJFNnZ6MzNuMjBj?=
 =?utf-8?B?dS82VFoxMFVrcUZlazR0VkFtUTdyUjI2NlZWTkFyTkhGdFRwTmdGd1V0dTd6?=
 =?utf-8?B?N0NYUWhNWlVVQjdzUWt1NkliazFjalJObmRaeUc5ZE9SeTZybzQ1R2RDVHJo?=
 =?utf-8?B?QkhYVXdQM2QwVlIrTThOelhzd0VtV3l3TG5RVEhJYmhFZXlVdWM5bjY4bVJ2?=
 =?utf-8?B?Q05USUVvOWYzYm9hYWR1OE5CdDFlTUErNGkyemJySTVxMng0YlNQUGlNNk1o?=
 =?utf-8?B?TDNQWkorVE1DaW1WdkRQUXQzdG9wMkxmdisrNk43RzVyOWRkQkd5ZkJ1NzZM?=
 =?utf-8?B?Q1BTeFQ3dTJ3WThqcmpPNVJ5ejR6eVlPWi85RmZXMFB5MVlMMTNLS0FBQmYx?=
 =?utf-8?B?QlBMTjQ0aFlYSFlHK25UNDNLMU0yd2hQQksyZGtyaGxSakJYWHlyUktrUVBn?=
 =?utf-8?B?Rm5MbHFhMmx0aU45VnBxeWZRclJKSHhWVmttNjNwcFowOW44bkdscGFDT1Bv?=
 =?utf-8?B?Um1HSkVvQmdCYWlROVl1UnlrTmFpbUM1SVFTQWN6NjVMaEtBUjZVUUZwQkx1?=
 =?utf-8?B?d1AydmJoUndPWHhDTlhZc2dlamtGY1JqNnpyU25xZ0ppY0NrajNGNnhXTnAy?=
 =?utf-8?B?Uk9aUXVOTkRJaVMwejdESW1aYlNCM1lmQms4WXJlbk4vTDdYTEpneDhQays5?=
 =?utf-8?B?c2xodmVWVmxwV2EyRGlFQnRrKzJDR1dXaElydkYxYndnU0QxUFNvV2hYQ3h2?=
 =?utf-8?B?dXh2VGducEp4c0R6ZUlJZDM2VWg5cVNMUXhjQVNNbUF5aVBxdkxvNWdSUUMz?=
 =?utf-8?B?eGRYYkVvNlIzVyswdGg0WURvbzdNZ3hEV05aNnMwdllBQTROVUJiTFkyeWFP?=
 =?utf-8?B?d1N0OVQreVNmdEF2NUVGdlNxS3JudUw5UDhTWkZaSTZFbFdVcGM0c1B1Yy8y?=
 =?utf-8?B?MmQ0OWpPdmRDYmg2U1hQUkVzbyszdEloUkprOUxzOVB5aHgrUy83NzhtaTFM?=
 =?utf-8?Q?uiPjV/LDfXu8jpcwuxB2OBuGY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add3ce66-c105-422a-b5c2-08dbc13472f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 21:38:41.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfzR9Z3HBn+GrRB8raPeyYakoFidMw0lqZsN/AJTIJ8YPb4lI0ygOQbjFd6UDaYqLD77hyMlIQwcPnsgqEB9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 2:44 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Using any of the GPIO interfaces using the global numberspace is
> deprecated. Make it clear in the comment.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This was part of a wider series but since this is independent, I'm sending
> it separately.
> 
>  drivers/hte/hte-tegra194.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> index 6fe6897047ac..9fd3c00ff695 100644
> --- a/drivers/hte/hte-tegra194.c
> +++ b/drivers/hte/hte-tegra194.c
> @@ -407,12 +407,15 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
>  		return -EINVAL;
>  
>  	/*
> +	 * GPIO consumers can access GPIOs in two ways:
>  	 *
> -	 * There are two paths GPIO consumers can take as follows:
> -	 * 1) The consumer (gpiolib-cdev for example) which uses GPIO global
> -	 * number which gets assigned run time.
> -	 * 2) The consumer passing GPIO from the DT which is assigned
> -	 * statically for example by using TEGRA194_AON_GPIO gpio DT binding.
> +	 * 1) Using the global GPIO numberspace.
> +	 *
> +	 * This is the old, now DEPRECATED method and should not be used in
> +	 * new code. TODO: Check if tegra is even concerned by this.
This use case is to do namespace mapping from gpio subsystem to hte. Few doubts:
1. What does deprecate mean here? Does gpio subsys not use global space anymore?
2. If yes, what GPIO number is set when it comes from gpiolib-cdev, as based on that I may have to
reflect in the mapping, tegra194_aon_gpio_map for example.
> +	 *
> +	 * 2) Using GPIO descriptors that can be assigned to consumer devices
> +	 * using device-tree, ACPI or lookup tables.
>  	 *
>  	 * The code below addresses both the consumer use cases and maps into
>  	 * HTE/GTE namespace.

