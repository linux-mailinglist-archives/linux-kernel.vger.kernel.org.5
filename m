Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20D7C60C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjJKW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKW72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:59:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41660A4;
        Wed, 11 Oct 2023 15:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol3Vsqx7OyZZSOfcoX8Gdxx4ljyP1XkScUez9sbZLnAAYjybg4PPFhdylxgvi+4DtuLe8EyjcIPcTkHcs5Ug62u3gVlRsd5CAI3NcBiB1/9NMT7yjaFUCzZlGapaNUs+xstvVlmDJyM9FeneBqejvNiB6JlVQU9+H4Ms5oBKZ6la8psxhm/gejcPI4lHbqKR7FiyRWkzTnbnA6qkanSXyiBqsPeAN46ubfKDKoMrcWazi3ejOkSZTCm52Tu1EybticbQ6kqjC6A61Vkg38Pc5syHP+p/LLhYydlWyKPoM/paZ5nIJfv9g4yz3fITiq1EIk6C8hleGdR9akjvOqS/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enkz/F7UVbdEOyaSXgcbFrKsQmiBHN9G3AVVO5o7Xo0=;
 b=Ly9fKUaJLh/s2DghYjo2ic3rcozXZ2AbrZGE0cAy3ZTuD+24OmvNz7WJKKbp+zSLKddGHpHXyZIIPFyrH0bfd0G6YnNfDbEBcjD+K/lPEepqPT/5L8RCq2A4HpqNry+HJddR/SFvlFzA84co93Ko+lO7PxIyWd++19D7W9hnA14xkFUbQUURIbPxSFHHxZXI6FLxWGRnGEp1N0S43i1LkooS7iiZ+w3MQNpK+o14+bOizxHF8wrh1CLHhlYEpVCYnAfm4U3P5K3Q2pwz2YnGCDeIjadNMaY+LlOwVNR52WyqLE0Fk0GsQPpgbfpELS92YOsAiJwtxnxmsQEDnRZSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enkz/F7UVbdEOyaSXgcbFrKsQmiBHN9G3AVVO5o7Xo0=;
 b=T2gcITvgunQDZb2XacpXM9LCUNzrnqImnAW5jTmPBvBB3fusNJbQWyTdx68TbIv8zkvnmdsWRTV1Qyw/Xws4sK9fgpFKl6043k/cE2VB/qpoAI0t0P4zW9JkggAERQzH8ozhfq+u3AX/A6MNVAJQh+8rwbW9FCVxMiukryug4TQnJJ2mtk8G2c778Z9SE56/I4BASsZfarPT13NB8VGD7/H7jSSIB8MZfDAjdM5fJUhcxDY9b+BaF25nlJ3EetlrpAmQWpDMUTPKfUAIO4C+Tid+oU0YZIOW4pPyS4Yt56QSrtFlbb4FsVavE1x9PCUj7r4tA4JSklhBSbmcJDftyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 22:59:25 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 22:59:24 +0000
Message-ID: <75fe5f3f-41d7-76f8-47f9-9178fa030804@nvidia.com>
Date:   Wed, 11 Oct 2023 15:59:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/4] hte: Improve GPIO handling and other cleanups
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CH0PR12MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 40798249-44bc-4c5d-3525-08dbcaadb68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1g5CixCyvQvJmcvzMeB97QlRCl9OJokOE9NGJoH3f4Qwm6NZzhgXmnFxhxGh7yOT5qfCETVgucjzUbKvA09q1i4kVZhtlaLWjWmUNQLLRnqJ6/LnsBemXdCMwQkvtoVTSvFagCSPwpCOnEZbhDuktrSZw5t+YL2mlIo5YlhMugkTWX8IV0NME6Pu1b4LpdQLNRzVxsYsXIHYRDwdnM7aTaJnSTkjM62tAMT++wOJfnc8RdKMEdLlMPa7z99KxaF4/cCe6JpdJrifUvaRPIKwKLm2kxSGyiCGi0gARTyVKNRZdb//LcbJJgNWd0nwjPYdacpgzjr4h1PCWgX895hMlSp11CF2NGxSqDDFQOzq2zuBd8dvCq5PfXKAYv0fCqYfjsXB1gcKILi0Qm6XjS7dp827eefblXp5HfVLiw6cNlr+vg/XVvJTLZlOKepZoxvMgEuN2F17hZOPCascG1/7ybSCehsVzhJpahggrVx7LdCVBHIm4v3OQ74pW+b5oYFgbEtXQUnovjTr4usJi2d0qH3UUpFO5uxNmCsJoitSvAu0zNhpFKxHjI8mz9kweRtgx+/oVCEy9uWPlZ3sonGOMj/XA9SBENG5WPahxfLKR3MDFDxNVrZvdnIo55l4mj43BPMedaCwts5YfZw3owsNQLAdtg3WpnpLzARKf94FekQSjfUmCGQzWAF2pyhc7t8c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(107886003)(478600001)(6486002)(86362001)(36756003)(31696002)(6512007)(6506007)(6666004)(53546011)(5660300002)(41300700001)(38100700002)(66946007)(54906003)(66556008)(66476007)(7416002)(316002)(110136005)(8936002)(4326008)(966005)(8676002)(2616005)(2906002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHh3S2Z6WEFWQ3RVdSs3TktKYnhYK29TWStIVWtIcFhZWGd4aThJMGxVVnRZ?=
 =?utf-8?B?cGZmbzFJNmxvNWZ6Q3M0WHFCTkFBK1FhK2xVRHRCSmZ5TzIyNWUzcGVNbEVX?=
 =?utf-8?B?RTVDRGpPSS9oL0tZOUNJU0oySEQ0VGxSVmRzSFYyb3hFSlNDaXBCZjZMbC9y?=
 =?utf-8?B?THRXeU1hRnhhUEhuNW9KeDVWRll5bUUxL0M1ZTMzK1dPV3JqK3pRcjg5M0Rz?=
 =?utf-8?B?TDUwRjQyeEsvZGo5QXZxRlBQSDVyN24rQ2tibmtlUW5PSkhOSHprNVh0bWlj?=
 =?utf-8?B?dTluNHpqQ1RZM1FTOHpaWEdPTE1IMnk0ZktFdUtEcjVkZnpIUmkyR245M1JK?=
 =?utf-8?B?bStaUEdYVGVzMVdpMEdFNVU0cHo1Y1ViWkgxQ2FqRFFOdHJrUXVjM3dpVFl4?=
 =?utf-8?B?bFQrMXEzWmdJTTd3b0FzME9nNUczM2Y0OFlEalVHVGx5dkZuKyt6NjVkOUlo?=
 =?utf-8?B?QTdwYmgzcXEzWmcvaWMzbEVNamNlZmc1a09oSnFEZUpSYlNqRHkvSG55NnU1?=
 =?utf-8?B?ZkVhUFc2ZDB2Sm5oUzNFdGpIOElqZzlsaHpnSTlMRzB6TkxPK25iWGU5K0ln?=
 =?utf-8?B?RCtuMWNFb29XMy8vYnNVb1RqT2w0V01ySHdaMzVHM2lTaENVeS9FNEtRZTF2?=
 =?utf-8?B?TVk0TGVVNE84cDE2QW5FcEw2YVkxeTgyS3orbjlNVFhoTk9VNmROZllNZXEx?=
 =?utf-8?B?dnNIZFlkUTU0RDQ0STNXVGJ0dmdEZWROVWhGQUJBY0FqTUJYSzRqcTRxbjhP?=
 =?utf-8?B?U3NieWhHUWNicUtTV1k2U0VpTUViL0VtbTBadUNWamNmbkZOM1NhRXYvbDRT?=
 =?utf-8?B?Rzkra3FoOGJyalJOZWdzQm1YTkZieXFGYzM0akxneTkyTkRPWE5id3Uxc0xH?=
 =?utf-8?B?Q3Fad25xTk1POU8vTy9EOVE3VTFNZXA3YmZGWXRmRkhVZEZFWThydWhBL3hw?=
 =?utf-8?B?a1ZiQXZWSmRiNVd2bDdLbGdyTUtoQ0d1bWxpZVlxTzByeGZuUkRUL2pHK1Vt?=
 =?utf-8?B?MEVJRDl3ZDVjeUl2czZrUzV3ak5pUC9xd1RXT0RyK1FLL29CaUk0QkRYZWF5?=
 =?utf-8?B?OG1ucW5FejZ2T01aNUs4dmd3L3AzLzdLc3BSUnh2NUpwVGozZkVrdDRyVUVp?=
 =?utf-8?B?SithL3libGlmelNBMXhDKzZYdjdGd2svY0hrQmhJdEpRQ0ZVTnh1L0tnZEQ1?=
 =?utf-8?B?clJLMXY4SGM1b3ZySjlxR2xlNkYrcU5jNGZ6MmFWeTk5WnZyTk9XSUkvK3RJ?=
 =?utf-8?B?Ry9mcENLWDk3K2ZkUm5XSzE5MWtrZzFtVUJiSzVGTmNtMERMeno0aE5KNU9P?=
 =?utf-8?B?QXE3UEVJb0dHQXlPbWlXVDJ6bHpHUGhRM1k1eldMQnAyZzB6ZHpnVnZOeGx3?=
 =?utf-8?B?YjJkNEd1dVJMZFZieU9TRU04aFU1ZEY3cXdxWGFvZGdsenllQWxiWHo1MmFK?=
 =?utf-8?B?bU9YSWVkVXdrYmQ4R0pieEtCaUdHK3FwTU1DdHQwSkx6UW0xaXJNYUc3eGxQ?=
 =?utf-8?B?WnVGbnV3NkpWKzZXeTdTaUpMRVY5Vmgvd09UNHRWVm5KZGprcmRrNjhpNmpB?=
 =?utf-8?B?RzFlZTB4TXRFWXpTTThwZnZ5RzAzSkJrem1QWlVVTTNYVS9pYlBXOHZ5eXo3?=
 =?utf-8?B?Z1pzUy8xbFRRTk9ydEVhS2p1dlI2OVZzUFo3cHlwWHIwTjVJNWtjRG4xQ29h?=
 =?utf-8?B?NEJKVzgxTHloVTdTWjh4Z0lJck1IaEZaMXhoeWdCQ0g0UnExU0M1VkZuam9l?=
 =?utf-8?B?aVFiSzdQOHZvTjVCWXMwMzY3TWNjUmNBazk1OG8rcVFuNUkwSUhKZkJPU2xG?=
 =?utf-8?B?NHV4MzJxOHVSRGhzWEV1TGZDVjl3ZVozaHJtVFlPVmw3M1h2UnErZ25BL0Zt?=
 =?utf-8?B?Mk93U3RXNW5QN1dKdlRobVo4MGd4R21nQUQrYmJxa0RQV2JJZXdVMTVIMlIy?=
 =?utf-8?B?aTRDSytWWGxzeDdpUVI5OWdxVG9kMzNDOFJadEFZMkFXd3N4WnNadFhmTzNH?=
 =?utf-8?B?OGo4VUZMQk41NCtFUjZMMldJQUdHbW9uR1c3K1Q2S1lUZmNLUVRMWTlHYTl4?=
 =?utf-8?B?VUREZm5pSW91dm43bkZPTGNra0NQWjhLRHoxcVRHRmJnNllSQ0lXckQyYk9R?=
 =?utf-8?Q?C29ZFEOYa1pDoKOc6/pU/oh6J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40798249-44bc-4c5d-3525-08dbcaadb68c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 22:59:24.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9/9h3BB1tkBauyZcBGK0xUWqEPs/G9JBjJ+9Sd6ZszALNS8XjA8CpkOVVXZ+NY9Rne9U5MlicTnDs58qTYtrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 1:26 PM, Andy Shevchenko wrote:
> This is a series that provides a new API to GPIO library (so far only
> available in the GPIO tree), and respective update to the Tegra
> HTE driver. On top a couple of other cleaups (patches 3 & 4, they
> can be applied separately).
> 
> Patch 2 inherited tags from its respective discussion thread [1].
> 
> Due to dependencies this either should be applied to the GPIO tree,
> or to the HTE when GPIO updates land the upstream (optionally with
> the first patch be applied even now to the GPIO tree independently).
> 
> Another option is to have an immutable branch or tag, but I assume
> that was discussed and rejected (?) in [1].
> 
> In v2:
> - collected tags (Linus, Dipen) 
> - fixed couple of typos (Dipen)
> 
> Link: https://lore.kernel.org/linux-gpio/20230905185309.131295-15-brgl@bgdev.pl/ [1]
> Cc: Dipen Patel <dipenp@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> Andy Shevchenko (3):
>   gpiolib: provide gpio_device_find_by_fwnode()
>   hte: tegra194: Remove redundant dev_err()
>   hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
> 
> Bartosz Golaszewski (1):
>   hte: tegra194: don't access struct gpio_chip
> 
>  drivers/gpio/gpiolib.c      | 20 ++++++++++++++++
>  drivers/hte/hte-tegra194.c  | 46 +++++++++++++++++++------------------
>  include/linux/gpio/driver.h |  1 +
>  3 files changed, 45 insertions(+), 22 deletions(-)
> 
Looks great...I am going to assume you are going to push patches 1 and 2 through
gpio subsystem and rest through HTE, right?

Reviewed-by: Dipen Patel <dipenp@nvidia.com>
Tested-by: Dipen Patel <dipenp@nvidia.com>

