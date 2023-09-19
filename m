Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2272D7A5965
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjISFfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjISFfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:35:01 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787F102
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSulnhnFYXEZZJBBBTQdgkv020CwpW/psf1KPLkenl7Y0j/NbgrzijEKmEiEwIV4Y5QED9PVsgatvjTTFbX1qNF9vO4qFRkDXMGAM1P4n39B7ZsoXuCoQnraljqmf5cZ2HkabJUxcGmi5jovmvHkv9JCJIUNbpUJRfACzbbCj6cnK6Jg+ahce7NNQ9XiF3InSWjiJfChUfJL+nDCQBIQe5gYmF0RdzJsO7c0/3SRoA24S632IBfbcDdexfHnB4vBZnNLr8iRshxJCvtUz/8AbSrP5E4nvNejND6/J84GaM05O0jTMH6bdjhS4r51IsCfeRd5U1AozYI3OhijqtcgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbd/2Z50QJm1cWJ4b45m4w4tTOOtMvdWS43siHLvuaQ=;
 b=AXAmFbylqqwXVCiUoEz+hmLhGTddo3J2nc8qug3avECmBrqOcqs3hFYOkJMErY2d16i5U7t1iVtXRDQPVoZSQXCSSuIsAv9GNmAG9gDdZ6y2GRyWODr7B/whdyQ+c5jFLyKp4Nv/dMEWraDKQTyY1u6xqmjGqVTzIXYwAgJnoIr3Swa9hOxDfwyk+sgH+ysfAbo47fFdRiFtpzRB3p15DWemv0VQQ6hXL/XONhIv7LACMQM2ujX8OkiaQ52Izk62go9t7GurDF39s0Ty/vFJpE29LZ1sEei0b1CqowWlveL+kVSJtxer3u5H+In1mzcZGjkob+j92s0oCRA8PNuMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbd/2Z50QJm1cWJ4b45m4w4tTOOtMvdWS43siHLvuaQ=;
 b=ZPCncOsp8AN1AhpYgsjRt2ZB9LDDc720m/v2I4LG829WZLnNFXC5e63magvJOv771cfAWaLP9DdU/5Br2WuhJkKQZ5jQ4YLzHCa/ARH4anztYDmTgFwL4VHk6V08suVViuuwBOsFfmVhaz84BAXGwOrwLmocWrLAz/KJ98V5BBfMZaVWSedFuEs12lrPHJEtSTew2b+S2RZgUKcP7j4YhVT1tQfOM53VWF7UFDOEMfSSi1olgd4gZKhqUOMMGGBhNkenAavX0Nd/SzNvl/923CBhOeUclkXMJfdhnK/d61jh6ASxU1jOdvhKw/rkjcCZHpbHqzq9W0ooBmP8m2ZW8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SJ0PR12MB5504.namprd12.prod.outlook.com (2603:10b6:a03:3ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 05:34:53 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 05:34:53 +0000
References: <20230912082101.342002-1-ying.huang@intel.com>
 <20230912082101.342002-5-ying.huang@intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH -V3 4/4] dax, kmem: calculate abstract distance with
 general interface
Date:   Tue, 19 Sep 2023 15:31:29 +1000
In-reply-to: <20230912082101.342002-5-ying.huang@intel.com>
Message-ID: <87y1h24tft.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:10:111::8) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SJ0PR12MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c77615-a920-46fa-88b0-08dbb8d2263f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlHBQMeksN9zu/pwiVOiostq7LUVWsKPB/WXoE/DTzfb0k9AwtdHz5uX8pFjzXvEvATBH4wZVqDd+5a23fRQIY3nELJA8E5W/1lvmyw+enYnPCo5WDdgi5pQK5cSNKEgkt4lqSxTW4uXDewYUR1HAFY5KFpwT1ufVcn1fjT8X7ytyXVnOa8jLxGlij4vU74BPXhBy016bcWhCrgzXGVX7yiF0MX+BVZIeb/1TtebvkNPyss1tMacs2s3VBg+z9WsfSzj8ILrnZ8bkX6c4+eiqS2eEEvgM4hB3J0ybVPqr8YUaglgCTGeeeUSCWGkWkxSoN874rIpxCckLkIGZ0PxldV9e5ivAqtlBmbg3Tl0rMLM94EMI/TCmaX1YhgTTQEdk+M6LFGCwkPBBBfCgkIGwnzCNmwn5Gbg0d1itqu6jecYTsAlKNXMfp+kBNZBQg2Cz3ZjrkrEdcGQjSurja0iYi5JRV7zX3TFgmcuI/03uFXGnWUsSvS+oPX461hqSg5lwaZon66AUW/To5PXPkiUd7vnyh2D04V1BQ05Khshr9VjnbyeB84iZbvHOEjmbqsf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(2906002)(7416002)(5660300002)(26005)(6916009)(41300700001)(66946007)(54906003)(316002)(66556008)(66476007)(4744005)(4326008)(8936002)(8676002)(478600001)(6666004)(6486002)(6506007)(6512007)(9686003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2G8y6VlnY0jRcBZiXKOmy0qPnWrjoUg13ZTkXI7E/uehubDplItgsEf8nq2?=
 =?us-ascii?Q?YRaIFkhUwW+JiiTamtoL532e4EZQCQZOhX0rtgK+FggIlg5FjQYMr9xz4gq1?=
 =?us-ascii?Q?f6c+Dx4cTARi4p34cb1C8l/faCKdrb2Fr0ZXwNIaKqZ598ubpPbZFqqcx+k4?=
 =?us-ascii?Q?vkQZ4GkDmv3lS2AD+f0J3fXPbPkQ66jjsD+Ghsq4DohjBF9svBwCOJdvI6LE?=
 =?us-ascii?Q?Rvvk0NYVJIEGdtSaLD1kuvlV1TM6oh5EplKeZhbLk6avWtYoCjsKVpMk/3BR?=
 =?us-ascii?Q?/QC+Ewp7nHfllkfKSMzRsnMJg8tU+pe4i3fyXxNFWxe4LgLrBL/KOrgA7LWe?=
 =?us-ascii?Q?HgYiXVi/lHry7szqFN04SUHCrUDUyaJN1sF2Hf/znoRbLWOuOAAG1RpVinR9?=
 =?us-ascii?Q?HcK8vBcgpmp1N00GMYvGB5JfE8cPoTakPxnAxNpjsuNuV3KGY4MD2RTX7lzT?=
 =?us-ascii?Q?xNRGqidP5Js+myuOneRxBpup16vyzH1V0aOs6DNTDZDzE53oSgoeEZ8d5hwH?=
 =?us-ascii?Q?jljEIEf6/S2uSytaEU9vt4tVo5N0WUgk0NRQoqEQEeP8y/fshdSGVryp78jN?=
 =?us-ascii?Q?j6Ubjcr0fYY8XXtvubdU9d608T11tb15ptBokgANh46rduKQh3SBE0U1Fjq2?=
 =?us-ascii?Q?W8GWniKvKAJI3FL3koE+Mvx8Nmcfs+vxrxxKz4Qz3l332Akzx49y9HPjNIQ2?=
 =?us-ascii?Q?j+tZJQxCUa80fnIC47HMRsihus76mRJ7G1VIIGAgTbJ7tEqzzA0Lvf1BSEs/?=
 =?us-ascii?Q?be84D9/WkBl98L9qi4qFtFKuWKY6Xr02CNZjPd5u7D91hRrypuk87jukifuT?=
 =?us-ascii?Q?czqGg2Ny17+DIoOIUVUaCk58mZYE5Wjx6HbbNhEnIi7rBoCaByogxzx3sPx9?=
 =?us-ascii?Q?rtm8kmRuTB3T7ufwMrtLq5I6oACHTvykGEaCDBqm0Moa9XJYpzHLo6nrvG76?=
 =?us-ascii?Q?yMuXw7L36eeaL864viRcws1mdNKO6//qNSdvDofgdgUhYweI8+4j6SNe8Q4Q?=
 =?us-ascii?Q?429dU9v5hGTM1oUcjey0euEbTxXUMwMbEsBuZg6sGWKkTJBjbPLcaqyKHqSD?=
 =?us-ascii?Q?4+DhztLTLigZC1wg9UATnS63CwBe23Lh8s4q30lEtbkn08HiTMH5B4cckSHY?=
 =?us-ascii?Q?CRJB7kHVObwu8XKIFCG9aJqP6rm1OEV2gYo6O6NICvWR2H8wUFCAVmq+HClB?=
 =?us-ascii?Q?2pOisocCGBgBw7jWpiVHHNgcihjrfUNM2hBUaptHFGzSoXmqWx7Qj7WCe7KY?=
 =?us-ascii?Q?w46iNnY03+HOMrBve3rawEd5FjXsMxdfb6Mhw7eyTnEI2xBoqU8hokYU5lVa?=
 =?us-ascii?Q?KbbIYlTrtSI8ZvQEGDedwaenBoh363c484PCCBT08MfW9mkPLvzPFoBnMdRu?=
 =?us-ascii?Q?vVskQ8hKKmhX3wLzVH42BSNCSNw58sHSQDPm2p7qjjSRSFl/jOZp8IL+By3S?=
 =?us-ascii?Q?pfCWSst7z8qXoeEmW7PEzUND3RnkXjQjLEdUjYpcKzrVP79BUWCU0WHJ0q7F?=
 =?us-ascii?Q?ig6o5Ylbc2b+NxP4QJgyClPmJQ4LOdkXhGrPBdnmEep+09oZUOtqnl3JqKt1?=
 =?us-ascii?Q?p4gvg/jFHO2Dsj5ujCNRsbqppfn2zqfB9t1GEQPP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c77615-a920-46fa-88b0-08dbb8d2263f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 05:34:52.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIG610Jlu8BAQJCSPAvIO+zACFqnEg7AH791BAlfrxgQPV14bFFyx8w3cKpYf+EU6WqJzy3ov0hnmvW6C1dgqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Huang Ying <ying.huang@intel.com> writes:

> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index fa1a8b418f9a..ca68ef17554b 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -586,7 +586,7 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  {
>  	mutex_lock(&memory_tier_lock);
> -	if (node_memory_types[node].memtype == memtype)
> +	if (node_memory_types[node].memtype == memtype || !memtype)
>  		node_memory_types[node].map_count--;
>
>  	/*
>  	 * If we umapped all the attached devices to this node,

This implies it's possible memtype == NULL. Yet we have this:

	 * clear the node memory type.
	 */
	if (!node_memory_types[node].map_count) {
		node_memory_types[node].memtype = NULL;
		put_memory_type(memtype);
	}

It's not safe to call put_memory_type(NULL), so what condition guarantees
map_count > 1 when called with memtype == NULL? Thanks.

 - Alistair
