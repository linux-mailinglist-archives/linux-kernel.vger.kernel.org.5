Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539A27FA850
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjK0Ru5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjK0Ruy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:50:54 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31E198;
        Mon, 27 Nov 2023 09:50:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKnp6lQA48cKSw6XZs1BqDy52P7agehpGOmotj33qiQq/Nw6pZHyNVrEpuuvevhEs+QtvLZyGflsK202Y/Xhz6TgFonzBblirKpdAFV4S1AIvoFFj1mei5UxIf0jTENc+JunIg8pYff4baLRmHETBhkMOcW4uEZPFA9lQil6J0HNK9H2ihrSJ0ME3k6shnSK3FrWZBDleUihcnUV0By6uHHVZZCnLllYw/umWcath7JBQ4T6RE+D/+KxUDjV2hBZuK/z2V/nXqfRMaV4ZVjwGw2NGM99bo+MbpNUNYN/Yv235ojfWA/fvstSMycBXTelN4PU4NBokqyHH9Clk890LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY0wcNBWy4I2Z3rdShI5IWJUs0AYRuNoQfDwT9AkH3c=;
 b=KJfXxdyNuIf0W7xePZfYKkYy2rWKIzw2swnfeN5z0wwQ9XXzHLNDOPs9k3AXtBAg0NjI5AG1xWeGgUPVcm17gT1GH9QLdQkD9Mlzs4eOZWVKCENeBXKpIOB4Cvuir8bR3zFEgqmsXK7tFmylZiEYPQ0FX219YFqLs4fRhxd3iGwTEnxv9wOP7cQ4ZTE96gMBFvAH0ahJwujTYdkx2erNW1qJv0/HdZrbQomZXSlx4VoFhm0CXrNI9rFm0Hvg6qAUicw1D1x8QlbVw7y0UJmcVDtECgx9aPpUvcFefzbhObO2UHAFuOJJjAm8AcLnuHrV4vaDi4liMBiCJle/D4KZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY0wcNBWy4I2Z3rdShI5IWJUs0AYRuNoQfDwT9AkH3c=;
 b=pBe5UHLKJBzdmQeEU4GeDkRm61gVIZYrRYHas2Ub9Z5z8YqlXnLMSr1O9tf1DWTu4XsGLt0GeCMbkYrASxUhpLrLfud+S59ikQ1HpzWLB8i203wZEVITOKKywc54pzjjt01DjWUNQ+ClQmm4R/j6bFARFqnIfk3XxFon2ns20sTcyL3Xl+qyWzA/D9avw8j/fXLcDsvtGC+hutLGlmD+qVi1lLsQJ/0neWOr5ClAExOfuJfErMN+qAh+fFPpSzKVLbt7YLaja9sr/LtOaReTZglhyPYTQ/pUUik2Gm7APAZXO1uwPNDLJqDiOOyeqjrlN6no3v9m20BmQwmKlhuaXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 17:50:55 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:50:55 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v5 1/1] ptp: clockmatrix: support 32-bit
 address space
References: <PH7PR03MB7064DBC8094260993E1B524BA0B8A@PH7PR03MB7064.namprd03.prod.outlook.com>
Date:   Mon, 27 Nov 2023 09:50:47 -0800
In-Reply-To: <PH7PR03MB7064DBC8094260993E1B524BA0B8A@PH7PR03MB7064.namprd03.prod.outlook.com>
        (Min Li's message of "Fri, 24 Nov 2023 15:20:23 -0500")
Message-ID: <87fs0r84qw.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c78e5a-b32c-4862-d2b0-08dbef716772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuE+o/JRswkicDAQQrPDRxalpsY8SZgx+F15+fF2UXaBqy2KufmX9l0K8F2Mz7eIq08dGPCKTCKkHPEyQ8sOc2+v+/VQP08S4O43TgIRSgrkuxSzc0s8msDmDb5Gs5qxroySWIyMYlkDITJhcMC4RPT54CForvT3kYnwx8CS7lU8kzHpsqd7Uu34NDiOd+DjhW9bp8e8fVvwjAVztdwO7oRzjbHFGJjD1vNexUm7WMwerARt/gsWXjKyp0e5nk805Jj6llXckVtS+hY78rzIunJIgUWF/swEZ/Tfhnrzba8Y6pm4D9L0wP2/6rflyeHmOsB9j33SkzcvGtk2l6U30xewwtypVlJGXiAuWepyyKLS2p+s2siMJ5nRghzPLe8f1PSp+ZDEFSqbAW5xQ7qvR3JRBRR8IG6ZQNWLeUymMIlg5eCZruuVKHyR35nNfTlMxHVG8/XlfmeaMjxSPN8Gh7f29QHD4lV3RHA+bXtwPMUuulP8ZlqzsN6MXUIxjOCWKiTuJy04CodwpZszmjnkFjhVdXp8SlblBoFKjzb+H8UFAK4CvOSoKuF1aDBwtVgK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6666004)(45080400002)(8936002)(8676002)(4326008)(6512007)(6506007)(66556008)(66476007)(66946007)(6916009)(316002)(6486002)(478600001)(2906002)(4744005)(36756003)(38100700002)(41300700001)(86362001)(26005)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AiN3567Ixssfgc+sFdOp3E8xXxbg5cd6fdaGSzL+uKEbHsxO07J2geMhWCEM?=
 =?us-ascii?Q?M6PqL44fam0Ov+RRVNqUg4DzpgRwr6P6pJIIn+RG46YQ3VG/bNCAzlqiDSIW?=
 =?us-ascii?Q?9c3NLbsgCA5RxUc8kmkCX+LPIljTfYBOhPooz3QTFhIIS/jGfu2PShiXbMLS?=
 =?us-ascii?Q?lArsR5FcbMhJh/4TIl6gaF1CmB5wUGnZkl4FhOBU3BBhhh6HPIziLbgAHTwl?=
 =?us-ascii?Q?k5FaL3kKPwmswoD8LZB4ZN2mafMT6lNnvnr9Sd967ZB4uzBYCEgZB7RBRXDp?=
 =?us-ascii?Q?ECM8i3VtEk/jRAosCrxCwXLZ74lGg0IW9sWlQOfn5DoD8wtefIWr565lHPRr?=
 =?us-ascii?Q?lAXaKR5etSk5IAHtJZZ1Dy6DvXz2kH2eR1/q4PBrucrsCfisDgQjWm+C2ql1?=
 =?us-ascii?Q?9BKvdSnWI9khBbNQV9P/TFmxP3Qthvmud9ikiVO6J4QbrOCfMYkGBxcLD//2?=
 =?us-ascii?Q?dT1ve7dKHEC9W3teb4Eupq6/lZH9Il1Gq5AqFrPApIJocnvTRHo1vOWu6DZn?=
 =?us-ascii?Q?AYZFUSJDiIt6ITP3lug/41XokML0NUvJKCOQ1ZIrXw1r+sy/1dAOzxefh3mC?=
 =?us-ascii?Q?zML6cfWgE9KVdmKVFUKXs1Mor8ZjsJ03VcMU3qSjGN25P6wJ/sgk33uQiBpO?=
 =?us-ascii?Q?vQLg+D5hCDNve/fjydktEz9X+iSeVwCCVo3PJgPsKIVaH8Xwy2fvTzyhZ9fw?=
 =?us-ascii?Q?7k/c8oWIZ3A5IlJ24/pvNIr65I0DdwNYRCnzasiBRDCcanwGBpcnvgdK+2My?=
 =?us-ascii?Q?xvOhGydGRLS8m0eHeq797VQxss2IoMMVvvIuMcBF9qpjYzqZO5DCH+Rd7uXI?=
 =?us-ascii?Q?AIyVD7TsDOyM/shSLgv/KzHDUIRREJ9hp+wIvBGVLIpOklSFC5fjtI7Sq8+h?=
 =?us-ascii?Q?AQVgwR0cE21InrUpDr5UraYGdvL/5PfNqsj5Ip9Awo6PaM5vVS0RzbzGLT7H?=
 =?us-ascii?Q?x7BsTF/kS/g73QAdpRzzKq3nj492Q02VuvJCwgeB7BHTnzjQnTAIB1jCgw7u?=
 =?us-ascii?Q?3Piujm+pfJvBcUjJPbha9Uo+/BB4mViIME+BEp2WG7gotvzv8oas5SKS20zC?=
 =?us-ascii?Q?KzTT6DgMvvEtyK4DgSNccw0R8MJg+hyzrvUF8oSqO7lAB+yXKcf3FIpilDBY?=
 =?us-ascii?Q?ZAFNFgR4f07rDU7p/RhdmKqx9wjpS6Wkvp1dnSfGbG7ZBJ+jpAHibIIiyRwh?=
 =?us-ascii?Q?3JyC8Zeg7OZ28Mi0yW28XDJa9YXSjx0oyeKUvHl/LuzZdomAOa0JYml2rJ6r?=
 =?us-ascii?Q?/EKv++2riSwgMRbHXA5X6+Vax2xjdyjijkpZkYRjn2YYe7vJ0c1V/xrhw/ja?=
 =?us-ascii?Q?RAI7iEqQfC+M+xZumoXbAPGBSNz/y7ckMqACef2H/8F5I5CWEeQI9QJkU5ft?=
 =?us-ascii?Q?gGzMIIyWrKTvLOe3HlFdRnCOHb8X0xcgpNXg7UcqJjzoj6cc0CRvNKgusduc?=
 =?us-ascii?Q?BvIyq6xYun2gPoN60glpaFe2HAn6FqFNM0jmwK3TBGG+9Ii7xq2Tv2tK6mek?=
 =?us-ascii?Q?7gkTOBFMQaKa0kmaItcpsCYLpnmj77qCNpqr+FW3kmHHPZTKP5EzDi6cwC2X?=
 =?us-ascii?Q?y88Z7E/FGWNskSClKf5uQkAQujVXoupXq3PtO10QFb3B1668ppaM6ix/T+qb?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c78e5a-b32c-4862-d2b0-08dbef716772
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:50:55.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZsi6eovg2DFK086zZ9ifiO+0fTwicI7H5tJ+e7owZk5wsuBCqH6jisDZOh3KOIG91sjdEqOxfStH3RH+qHE6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov, 2023 15:20:23 -0500 Min Li <lnimi@hotmail.com> wrote:
> From: Min Li <min.li.xe@renesas.com>
>
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.
>
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> - Drop MAX_ABS_WRITE_PHASE_PICOSECONDS advised by Rahul
> - Apply SCSR_ADDR to scrach register in idtcm_load_firmware advised by Simon
> - Apply u32 to base in idtcm_output_enable advised by Simon
> - Correct sync_ctrl0/1 parameter position for idtcm_write advised by Simon
> - Restore adjphase function suggested by Rahul
>
>  drivers/ptp/ptp_clockmatrix.c    |  69 ++--
>  drivers/ptp/ptp_clockmatrix.h    |  32 +-
>  include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
>  3 files changed, 329 insertions(+), 314 deletions(-)
>

Looks good to me.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
