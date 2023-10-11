Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF527C5ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjJKSFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:05:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95309D;
        Wed, 11 Oct 2023 11:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM5/ZfJZzfLFkiiSYqsLxK5tzpM8w3elTQKjkcYptK95XEO3wQjWx7fphvLbepmCN+PFKn9YvWFUU0f455v5kbO32wKmb0a8MHHykpIgFohkD7yFOMRR7uKwwsBbOyJFB00LENsXAR5EXofV46+ebbi7gImwhrAnJds4q970OS3TwGL7s3q44wM9pyupIJz5LD3Q4eJYEY/8yO9i7l7xr/Lj6FFQ2aYuvY0PZ+yJx0t0fnt3U31RiCOeCb05lklajhHJdfpnplcbBaldLui4iPCMyCuxB8EpdQC5y2r1fOZTNH0uqhSioU6A+q05/Z2uVp81jm5INNimgr3uvOA3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrp0JCpE98MwTXHwqo1G8FlIMvuLLOlgZdYDk7aADPI=;
 b=a2AK/uEQM79IlJvX393t9FL4JcYRdNm4Mb6G1/3qvxkVvHraXOTg5nNHPsj+k/uXCyv4/ox7cmph2r8/uUvj09uXhgI2lyHU9IcR1okRT9XqpsMERTNZPpuFIIe15XbrfQtQf7MIvtg40XpFlo37aFChf5sBX/YZuZZGouWH4VbSpmoMlqo2dJfP5HwRuMd/4O+aUiH+wLe3ALiSpQ6QH0xfIp9zUb6mrRhewsF+JI1sfUPtv5NvrSefZsHR4Qt8N5/NYr9BViN4GxlTbMxjQ7QrQ4feNcfMryvgRNJrXi3y0cAQwG6A6hoIqw4/a2uv6CtQqPJPrS0iFHfoRt4caQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrp0JCpE98MwTXHwqo1G8FlIMvuLLOlgZdYDk7aADPI=;
 b=ifWSjHn56mpM+U52cEWmv/2tQ0D25L9iEFkP81/4e5/FLq37Jspqd7HcY8n0OBPzkbviVGiK1p4Fl5+gRswkkiybmiimWhM+qibfnussCXlXXjipcJgd7O+iIVhBVJeP27ADgRHALv0gWhB/PgG/uOjfKxCsaXZlxBZOJDfEHCdVfEfQHnm2+Bh0EYoqGNau31e5dY9UOF4HJ3gyvSue4AkNJitm8YQrPr3C3PtcRZlbSfRC92MUaYpaQvL+rI0aj2mq5+oT/HfDvJyK0+U4SKM63V2OgyEp8UpUvllN3GyLrk7EiuMoIlcJJhe8JAtad/vA7yXyH+/jLJtD7BdhXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 18:05:15 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:05:15 +0000
Message-ID: <e6f77c6b-2879-deea-e696-41dcd89f14eb@nvidia.com>
Date:   Wed, 11 Oct 2023 11:05:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/4] hte: tegra194: don't access struct gpio_chip
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
 <20231010151709.4104747-3-andriy.shevchenko@linux.intel.com>
 <3e1e6acf-5862-9f35-cbe6-72bb17cf3851@nvidia.com>
 <147fe15c-13d3-60dc-bd49-cd0cb40126e9@nvidia.com>
 <CAHp75VdgM0riV6Y2PHnU14ZTN_4-eiXevFhi-gsbQPwrkicArw@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAHp75VdgM0riV6Y2PHnU14ZTN_4-eiXevFhi-gsbQPwrkicArw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 0becfb95-8024-4501-696d-08dbca849ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7HGYgD8ASoCA2VFvJMAxP+vCfmOnWMEh3b36/um90HgUu1fHIOyLxM3lA9COavN2oh4ZDf4C4yym/wzmhkpjqPjDkxWiLpAQHn2TT6XAqO4oT6LjtYhhjuMLdfHHbJxWXFJ7viXx4Ve4iURSrx5LsISfRI9NQitj3/1W1I9F21gD8M+OhcAf7CXTCFK5AYDxMo65BeQKCMfw0+fcrnYjyHVIV5kvug1aMDjWtA1gAerNNe75YD6i9gSVtcTlAV1yfLaVggLbPjM+vFmqDPgY/vEuS6xBfAK+veBdbQblfRDzJSWjS40bXPlZm18XapWvRi6araXxtJ/mvJftNJIFTqPTR6yi38OyZTh0DFBxO/IRMm6ek5ITLZh5An7a5Vbo1+kFBXuWpK7sNccRReZhWWYXFD9LdFfPnn4Rb4DxxTQoyfPs339Rl3XroQx25wtLLlz2vcLexfyzjr9X/ngBhPODl05J11l0Eyk/SRzV+65sn44hO5puoA9KrYWgx3o4+RfnnVlo+GHfq09Iu6J3YTHtsWuw16SEyfZiQZgM1XOXWO2GGhNIX+4IprXbnhG/dV+kmZg1IkweDw+OBiUrrS6ZWNTzpgU6sF8VFki9n8M1vwBc2zFaJDGph/OCW2HsjIelCPM5rQruJ5MxgJgHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(54906003)(107886003)(2616005)(26005)(66556008)(7416002)(66476007)(316002)(6916009)(66946007)(4326008)(41300700001)(5660300002)(6666004)(4744005)(478600001)(6512007)(8936002)(8676002)(6486002)(6506007)(38100700002)(36756003)(86362001)(31696002)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1nTjRRNUlITGtyb2doQm1CRnlINlMzTmRLSG4yNXpFVmNDNk1ETU1DdXdQ?=
 =?utf-8?B?bGZNNzhyL0w5cUlJOXJnNi9OZ3hTMmtHSGlUYnBNb3ljc2ZJdzYrOEs0WHNL?=
 =?utf-8?B?amlPMk9yU1BCV1FjVHR5bUpiRFRhZmxQUmlJYXlPRzMxajFrRFlmUngwb3lX?=
 =?utf-8?B?ZUVpKzFuVmw1dmUydkJkTTZ4Z3MxMDFETnRjd0RodCtoTGVxQjdFd25YTmNp?=
 =?utf-8?B?dW5xQ200TmcxOWJLMEVLZXUzVlRRN1M5NEVuclNLbFdwS1Z5UmZVL3RBTFpV?=
 =?utf-8?B?NThBekl4SEVsVmp3Qmx6RXI4WGZUVGhseGxoWGo3Vi8yaVErV21aMStQNFJV?=
 =?utf-8?B?OS9wdFBpOGZvZkdLRnl5bnA1MHhWL09kMUtTTmdjdytHQXJOQXVRSnAvRTlW?=
 =?utf-8?B?OU5IOW1abDAzdDFjdW5mb2JtN2xCbHdqTmFWd2VJSkxKV0FrdHU4czVENWd3?=
 =?utf-8?B?R3VhRFV5enlFUVZibEZDMG52R0RIZUlkYm84T2NFeVZFNVA4aWsxYmV3VFhF?=
 =?utf-8?B?L0VKcURwbm5HTWtmOVVlNDJ0ekRxTklWWmRWeVNxaGQrbG0xK1pPd3ZEei9W?=
 =?utf-8?B?YXNHL3p3WHh1SkFiN256Q1hkSlFRRVoyQTJaQUhLNE4wWmgyVTRhZHlRdjRZ?=
 =?utf-8?B?MzFyTzF5RGRiU1FxZHo4VCtsVmM4TXljN0dHcWtZWWplWDlyVmJJZk9XMGVm?=
 =?utf-8?B?QzArUm5DaVFxaTFmUFJtd2cvSzcxbDhyOUQ3WXNOdWZKQ2VHcStlcWl2ekE4?=
 =?utf-8?B?ZDFZa1owN3dGalNYMEpJLytYZG4yNkI5TStYdktNYVZram1aMUZPWGQrWHJR?=
 =?utf-8?B?dmU3RGplVy9RRTl5YW8vRnVkUTUzOEdqaU0wc1ZZQVFEUG1TUkUwdFVhRFBX?=
 =?utf-8?B?ZmNRTTNaNFRvcGNYUDB6SVEyYTFZR3k3NWVycldDbnZJaXhYTDNUQzlQaXI2?=
 =?utf-8?B?QmlGd3hEWnplazliMjlzU1BQMjZsUk9ZeW5qaEE2T0dNN2U2NXhIRWRRdUJR?=
 =?utf-8?B?K3ZIeEVCRHJVUWl5V0VZVGdHelN3WUpKc3R2dUNIcXRiSS95OURMTjVmUVBN?=
 =?utf-8?B?ZStTMjB0NEp2OGpIVHBzc1JPZG5IbzVrSksySTI4aHFxeEhYaWYyVkxZR2Ey?=
 =?utf-8?B?SXN4VjNZallsdnNLNGFFY3RncmYrVHREM0RGMW8wWlZpWkk3Mmw2SHdjcmVl?=
 =?utf-8?B?QmhIQ1Nsc2h4TGJZaEFaMStVUmRjZFlwbENHQS9rODEzTzhVVVZFT2Jubysr?=
 =?utf-8?B?eWZraDl0QnRmNVFEYVVrRnllY25CcDlsd1UxUk1lYjczM2FueFFzMTJNSUtM?=
 =?utf-8?B?VFRGWG9rRkdiRkNtdUxXTkQ2ajh2VkFqaE1aQ1lxbW9wczF1QmpCOVMzOHJq?=
 =?utf-8?B?Y0U5YUZwdXVyKzZsZVBQeDRuUEZlbUN1VUlGU2RIanNqWlY0OHoyYjhLeS9L?=
 =?utf-8?B?SzNVUyt6cCtCeld0alBCTWczKzFUQWFITUsvR2dCaXNjMUpKMTVkdGQ4Yk5R?=
 =?utf-8?B?VVVES25PbUpYWnZrbzJMRWRvaFhjUUdUTzcrbGs1YSt0QUNPTWhrNlBuUlBC?=
 =?utf-8?B?MEt1YXBEeVBMcXNLdHU0R3lDdXlnMlZWSHhMb0UyaTBDR2pDdnJ6dTBoN3Yz?=
 =?utf-8?B?Ukw2S3ErUGY5ank4MERJWDllSkZ4TFFqOFUwNkVzMUFCeGNTNWQ4YVJTMi9E?=
 =?utf-8?B?WkZoMWxMV0s0aWVUMmU1RTFDZ1VIMVowd0hhekZMU2U1OEhScXFJRy9LNmxO?=
 =?utf-8?B?QWZPNlpuQVVweTFEbEN3ZVlvUFFhMFVNdFRDakJsMlhEUHFjQ2Y2NWQxRjh3?=
 =?utf-8?B?a0pvTm1tYXNDd0N3ZU05ZExZNzUwK2p0Ky9RR2xHSUNTcC9aNkpCd3hmZ2xw?=
 =?utf-8?B?c2FGQW8xQkhJRkg2UVZ2eWZmVTJ0dldIZjhrYkkzdytzdmRYZGlkc1laYnMw?=
 =?utf-8?B?S0NHMHh1UDNMRFgrenZBbFNmMWhGcjBBNmQySERuRHpPZm5ESnFwOGoxN2Q4?=
 =?utf-8?B?RzROWjZYbHdrcmdHYzZOYTFKZFRnUkhIS2xiaUVydHlLWU5vR0N2S2dDdGU5?=
 =?utf-8?B?K1E2cnVjVHVvc2pWT1ZhNVlUZW1yRFdqbHlOMVV4QndXZnNlV3Juamc4ak5Z?=
 =?utf-8?Q?J1BJpxJtQjKCEX5wH9+cDOOHM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0becfb95-8024-4501-696d-08dbca849ec7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:05:15.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdxsOg4xO0rcwnQZGR3NM++dewzpw4PRxqvaW26fTXqC/yS3gDS6JiQokSweKwEjXiaJsM8SzXCHBHfVPTri4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 10:54 PM, Andy Shevchenko wrote:
> On Tue, Oct 10, 2023 at 10:31 PM Dipen Patel <dipenp@nvidia.com> wrote:
>> On 10/10/23 9:19 AM, Dipen Patel wrote:
>>> On 10/10/23 8:17 AM, Andy Shevchenko wrote:
> 
>>>> +                    hte_dev->gdev =
>>>> +                            gpio_device_find_by_fwnode(of_fnode_handle(gpio_ctrl));
>>
>> I think there is typo for of_fnode*. Should it be of_fwnode*?
> 
> Yep, it's a typo, can you. fix manually for the test, please?
> 
After manually correcting the typo...

Tested-by: Dipen Patel <dipenp@nvidia.com>
