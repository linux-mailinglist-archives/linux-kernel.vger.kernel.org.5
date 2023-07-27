Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF756765E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjG0V5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjG0V5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:57:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789B1FF5;
        Thu, 27 Jul 2023 14:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObeTvOxFFP2pssbzRyqzwTSmUYvl933ySbHAF2Szaw2BF86q1KF673+d4UCeHtlhQB9Gc13PBtsOU+J8W/zgppAz5gLHGTPJ+4UKek91j4yDc3GzNZaXL5ydZXghPBPIr6zxTeBVbyWaW8SLJdg7CxQp79at5X+udXMpIRejXkm0fqnLJvPcR7e5H4zKzd9PW39Y2Xpx5Z3CLo8q4fmuiV9xLzr/o/FCBwCN9LFL37+IRcfwoIGcBEvqDT45yss06O38lSwnpmkxXedR5K+C6VO9KiT7FtDM1NSvqIsBSABOgG3MB8NOmXx7noWNOB25WZFDeDoHDPcS5wcZecNUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymhV/9TeveNlLpw8KJRK5AAP0WlUOPhgcAVtHWk9ALE=;
 b=TiwPOA3wnwqP2kgeHmhuX+NrPBMcVImHt7ro2V5ZkoehYa4/aSso1avfqGQJKNvk/BOhSQaatSkcfRKWxOomeePIVY/Fg3LZgdeZ6FmNSRdpYB+vx8HVyOoXYBlRgyQVoxzUhpmD1bCq6zaVfMkGkveApr+WV/93Vs2LFrOQTN64hmE/tQrJw60LsErtdkVIvgH4oRSZx7NE7gabo3YWI6QNElUMxxwpGMwsTD8044QQIhlK5R7O2HfNvXP1f8xxQk+MhIesK0org7BgvllKrO61vKWym9kNwx5x1W5PClS37saJsUQQUrYx9WQ5CTHrsOsQEp07RkDQW8n3IZixWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymhV/9TeveNlLpw8KJRK5AAP0WlUOPhgcAVtHWk9ALE=;
 b=UEVzpS33Qc+zSFWkc+etBw/QDW7LC/9G2Pd0se5GCfQyjwVRcxhhgIhFB/FCStGnddxJkNw5H4oCeKd8SG3od9mi2Nhb694u4hDNrfRzCFg8grdA+P8bTG9YmjcIJCyPqDF28P8qjIn1gnyIqrF840HU1ehYCwr0WQpz/Jipyyf3ukQ2BwvPK7JOC8INzpjDxXqYXt3WJFWELYtBR7uWjQwtF5kUBG6IPdiVr7oj54EPS0CxyDYrqQQ4L8HuhnDXD5q47uN2dmvObGnzB/MZoLuGHGs0Gbn04ag3z7u0ZzvMWp7S7EFb7+dMFc/sVCHxtgIolBOL3eY8khDHGSaXlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 21:57:43 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::7d22:3b01:5ff:1ac6]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::7d22:3b01:5ff:1ac6%5]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 21:57:42 +0000
Message-ID: <132d5dc1-6104-1d2e-543a-e92177b01fae@nvidia.com>
Date:   Thu, 27 Jul 2023 14:57:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] hte: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230714174600.4057041-1-robh@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20230714174600.4057041-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 43701772-3e9c-428f-c01a-08db8eec80a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vc2twhVZ5SPXGHbKEyEv2tPuDi9N9btGlBw82mET5pgn/AiO8dYRFQ/88xZNoUsWPaossgs548xGi3g8yNBofDfcGRlkZyhSX4ylHcB5psNVrjP5OvEShk+EO6RocTiGoJp7ElcJ08T8F/QY4IxhrHdC4AwdMp+Bz2d7NfO9olFo2SUbr9NY7MOKIbwnHCgZOIeaij8TIzBZPrEdrdWuMRLfQmF/gIFzCujfj35CLBFM7yRZzIsZWBQb+uCssKKLBj0Z3O95baNrbfeeOXkeBgMOe5KZaw4moqg2fNiAvhsyP9x+wz5USKn5RoEstCKeGam9knhXlH+vjhz7Uu3YgqpZTll19XhdpJ41aEMSH10TlNUn/O9Tncp6GJwTl2UVFEJLKZ9u9CMHcuV/n/WFU2ymlk0mPzLW46KexajHUC7htVutLHi88IcbGQaVOs4VQZqiqj0dc9yee6L6BEjAD7r8TVUui061YW5r8ZybbFUpxgesQLeiTEHFfDsTMm9RKhItkCC6NP6fugPa5XmZ/Jj/48z3RlGQ2I7FaVTnV2K/cbGqAAmxwSwq6Tz4hd8WrYqCfB0i3QJM93T/bLWJXanKH1H3SgK/BrM2tqX80MKe3Uty9XCzT56rZuyLGIesBMV9rpfDlR2D0PUlyt5WuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(83380400001)(31686004)(31696002)(2616005)(110136005)(5660300002)(6506007)(53546011)(86362001)(8936002)(6512007)(6666004)(478600001)(6486002)(316002)(8676002)(66556008)(66476007)(4326008)(66946007)(2906002)(41300700001)(186003)(26005)(6636002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXdDTC9LR3FzYUVZQ2RnZUZsNlBCWGJoL1U5ZjNUVG5PMUUzU2VOeWdodXN1?=
 =?utf-8?B?YlBFc0JVYW5FSHNzcWNYVDB6TEMyenpwM1E4eEpubDBHbk9JL2pBOWh5MmE0?=
 =?utf-8?B?STNSOGhwY2g2OUZlU2plaHAzWGgzeUxsczNiOXNlaWNKNTNwNmN3TnJzUFhn?=
 =?utf-8?B?emJNcUVzVE8zZ2pKNVFZR0JuR2VUSVVUcnlJcW5FL0JRRzBwekFydi9hMEtZ?=
 =?utf-8?B?bDNCQWpwQTg3L09sc1llZnNVVEtlcjNMSUR5RjVrYXFsRkx3YUlxVzFtR2N5?=
 =?utf-8?B?Rzk0eXZkc1BGZGhzVm55RWVhV2lkbm1FNFREKzYxb2pYV2pzb2M4dHFJWWF0?=
 =?utf-8?B?ejhkaklIdTNEdm5xb1l2eUZoNlYxREdFeUUvTnJleENuTmY2UTlGb0RNSUZB?=
 =?utf-8?B?RlNhWmZ4T0dHejMyMUgrbmxkQjdBTU9SZzRXVy9qaVNnckNabitCQVlPd3pN?=
 =?utf-8?B?S1dMZW5GNmI0YWt2M202QTl0OVQzaGY2Ym5WT0RrSzlOcVJYM0hDLzZRWndC?=
 =?utf-8?B?YUNSa0hObGRUTERtVHQ4QXI1M0V1VVJIalhCQTdEWmFoeit4MlNyQ3RDSGh2?=
 =?utf-8?B?MDJuREdXNFBzZTNiaUYrWWdIV1FiU2Y0elBZSmNRSFArNExXUzQ1eGFKNjZt?=
 =?utf-8?B?RmtXdmlpMGFGRkxIOTloL2YzcU9ZSWxIbm1FUW0rd0NwMHVtZWMxNzRtbFhn?=
 =?utf-8?B?MlBGZHBUOEFDWEpSaVhSQ2RKd25LNE9NVEdRbXZHaUV3QlJnTHoxbFZRaUs4?=
 =?utf-8?B?b2Zkckh2Z1J1SlF0ZzhUM0hWeFlCSi9hYmdBYjYxS3JLWHdBeHhrTE4yVjY3?=
 =?utf-8?B?eCt6SG9LL0pqZlJJVUwzR0ZCMitnNWV0WmpnRWtlcnNnTzFBSjh3QUtOTHRN?=
 =?utf-8?B?QXRuRUI1bDNJSGUycE1Pd0JNU2RvR0xoTGd4RFdEUlhmak90OHFiWU1TcXQx?=
 =?utf-8?B?RkxNUkxUQm9jNVA5aDJmb0pXUEYrNkZqZHJDb216djNFeGZKaEpaMEthN1dj?=
 =?utf-8?B?ZWpMTTVMZFZaV2lIMTF0SHJoU1RrYnArVzVSc3lZaDZQb2toVERKbUtUZm95?=
 =?utf-8?B?WG9COFZJQnpwZnd1UUoybXpwYVUrc3BGbVZwd2xvTzhhWll2Qll0Ry92N0xa?=
 =?utf-8?B?ZFVKQXRacUhwNEN4RXhoeFJEWGxodWRKU0tCK2NtekZSV0N5RjU5Qnp3R1Ny?=
 =?utf-8?B?SmpQVkptcjFZRWdGKzN6cXhGNklyd1VOZjRoOEszL0lURDRDVWtscU9rSmJ6?=
 =?utf-8?B?L2JXdXhVTlJDaWFuV2xnNXpQS2VPbHNWQWNzNW1MWnlmNXlWMmtSSm0zLzJM?=
 =?utf-8?B?eUsyU09qblJ3UXVMUllyeG5TdnBDWjc5WjFSZVJOWmpOdkM2ZmtTN2xmRnJN?=
 =?utf-8?B?bS9sbDdCaDlyUEZUV1BhNTg2M0JEakJ6NFRjdTlNTjZZd2JGbnlwRzlHaWdY?=
 =?utf-8?B?Tm9KVkQrU0hWMEEzRkZOVFpGRGFaTEcrZDRBakUwWGo2VlhtRkFRZmtWazU3?=
 =?utf-8?B?QmtsOE9USzV1V1RyZkhDSGxxb2VSemVsMDY2VUh3bFlMZS9KNWtBVjZ5RW5L?=
 =?utf-8?B?VjcwN1lKYm5jTG5Va2VMYTJWVWRUbVBpL3NNK2x1TTMzSnJYdzJqRnFmNy96?=
 =?utf-8?B?c1dxc0Fvbm43dndQT2x3akUzRUg1VjVQZjNtakdsd1JGMlFvUEQ1b01iQ1Bi?=
 =?utf-8?B?V0ZqRy9oVUV1WVkvS1drbW5MQWxjemJmbVkxRVAzOEh5SFhlQzM4d0l5RWpK?=
 =?utf-8?B?eEtPKzlmRzZZSUVBMGpzTzBCY0dXckl4QUxsZWRZWXdWVkdEZmRVV0M3WFFV?=
 =?utf-8?B?TG9xQi9iTk5VTURQMHhTOC9wTEptemxvWEs5SlVVdGJEcjRhYmsrclVtSFI5?=
 =?utf-8?B?UUYzb3hXZXFTUzVwenpYVlREMUo1MkhCUE90Y0xDMzlGQzB5WkVnUnQ5akxJ?=
 =?utf-8?B?d3J0ZWRrdTVYN3dKZ1Q1TnNOSVBnakQ3dWtzZ2xDWVZpQ1ErdW44VllHSGZi?=
 =?utf-8?B?STJqRnFEUmpUWWZxVUJHMVhoT1NJVkZvWGJJSVdORFJSN0oyZ0V5NFVpeVRO?=
 =?utf-8?B?NzB5akJvdkJ1K3czZXFuVlM1MEpwNEdBYXFWZXpUSmRwM0RCTHRrNVJXNFk4?=
 =?utf-8?Q?dcAa675oqCX8qW1PXYxA0qRU3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43701772-3e9c-428f-c01a-08db8eec80a1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 21:57:42.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQanWyKcQB9hvvdiBc55mtv/32Shw5hxAhKIrWpY3jsEX2PhSz77m/hTCgaCQXe6TfOcr0DTeB4no28nmcs0mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 10:46 AM, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/hte/hte-tegra194.c | 1 -
>  drivers/hte/hte.c          | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> index 06ef349a2265..6fe6897047ac 100644
> --- a/drivers/hte/hte-tegra194.c
> +++ b/drivers/hte/hte-tegra194.c
> @@ -12,7 +12,6 @@
>  #include <linux/stat.h>
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/hte.h>
>  #include <linux/uaccess.h>
> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
> index 67c15724ee78..598a716b7364 100644
> --- a/drivers/hte/hte.c
> +++ b/drivers/hte/hte.c
> @@ -10,12 +10,12 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/mutex.h>
>  #include <linux/uaccess.h>
>  #include <linux/hte.h>
>  #include <linux/delay.h>
>  #include <linux/debugfs.h>
> +#include <linux/device.h>
>  
>  #define HTE_TS_NAME_LEN		10
>  
Acked-by: Dipen Patel <dipenp@nvidia.com>
