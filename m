Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4078D760521
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGYCRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYCRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:17:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A38FE7E;
        Mon, 24 Jul 2023 19:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqQW+Sy5pLs1Ofvn9dDXm7hWSjk/eK7smglr2rafDV6LpkI/qQ3X+hZlIliE9u0/CZWHFL0vqQI1mm5sYoSiY+9BVPVv5G8Hw85ysYmWgemxjOc/CSbo8BsxEPOrmlLrd+WaCSzXL++mRt0zZhkNeAizFEJJRveIOS4o0AOo3EI7yvj1IHEwlA/ls0VKtpcOa4XMo073QDM9WavEfG0ClJhLflTV9CRvPtdxfYe37/Kr9P0KpNhbDUqIoUdtrWX4s8rlVtXMNJXZtgqwYg+Akc2B/HRFZcH5AUyShR+GQ3+bnSKXOx3nkqfZ9ra7B0LeQrEEF/iUzcxNuUVVw62J5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFVGuylfZ26Us6gzddI9CZO4IpXcZlrin18Cor20CJc=;
 b=ljI0ZBCRJUsdYtiJ63qN9mwjFk+Ow5dp1iVtDJ2M1E0tI0oQwM3kCyedHVqHDolnh9neMjCEQAxiepnHA1ye2laVZc1yN8fzi5QlvrBQlxCP1PNrImfWiHfKfGXicKpyxzxwcoo4DYYT/VWXJdt23ArWqpjYgkZOZrCy7pffwU5G9j9ZHw9ZCTipkbewT4z8jy03rUThpwaY0W2r/tvea6j1PIwpihs2fFKR6UmGsCHxi1EQwcf2+Xefd18OCeDY3R0YAeTTEb9t3NHpl/Cv+/Y9W4duFEvhyJS37ASfHX7aQZ20Ja+k79LeU7RxdO7fTtnqKL8ff+7HJIdQurglZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFVGuylfZ26Us6gzddI9CZO4IpXcZlrin18Cor20CJc=;
 b=N07GTSDp7BS783GcbAy8RwQEzbfJ/zbaECcqicd3aQS7R1g5oQHbS/3Ns/4+EfqmuQvOcTb7WBxTdX2BzJ3E+Nf+OmklB7GeC+ZzKeUsh8gBxyBXqaFjDp0vXBv6HiWpGNPbHSavlmVCx9JwhoNEGRTMXLPIZLEfTIiC3ZttEA1JPpDvYhVLGup+duOF/hb1P4W5wxngTkoY3Y9UlJpZfpNwVE0x0wkU9lNBNIVnRWRx+6ObNCTFHwE+BVXvWR8Y18lF3l2E+NuxhqyXn/rWzjRwwY6H4oxKw8PbvBjgGo5VI/5V9Jh/XbmZgARN2ba2Dwsp9csw7w1yDXsB+lRYfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 02:17:42 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 02:17:42 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-2-ying.huang@intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 1/4] memory tiering: add abstract distance
 calculation algorithms management
Date:   Tue, 25 Jul 2023 12:13:49 +1000
In-reply-to: <20230721012932.190742-2-ying.huang@intel.com>
Message-ID: <87r0owzqdc.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0040.ausprd01.prod.outlook.com
 (2603:10c6:1:15::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd7d531-5832-4945-c5e9-08db8cb55375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbMyfkVxRO9N2i3CpXVuB+95cxIj3tF5/xyxndH1x2tWy93DWwT7tM+8YOTX5bOx+n8WzZVik7shxsE3it/qgMgxiPuWM2/Q/qvazBpRX6H5r1b5ix6JryympVtuBZGO8r5TWwm7M+c69SqWqKUKYKVOYBJFNwpGMzY3cLftYJRJwIUt1H/b5wsfQPu0vwu22qCs5ZKadoFnWH5RL/NA4jGbSfNb/AF5kHCcpKDPWEh9t8x9PdfvI8mc/XbYF4aiJEKkCj81wuRluZApDQHv3cY2LzidCEPIrRygGQRi263jrNtdrc7jZ50xIWzbiiNuNhYv9TwGqVzT/vE6yIrD5iHd6czCZ3VktuCVVdUawWULB3SPm1gKNHThhRaXVuMPmchJSadIZ8IoJ8raQ1fa1xKfbMSLjR4V0cCOyZB7UykRB9w5E9yKplC2NRJ9JqYcoP7c0mopt2g3rhhIpUDswskVdjXwJI2oHJ5aW+RDvwVl+rFa2tOAYu+IclKwJFtKsMI99nc6RvHCGy1vHO2hVmja8RNYK3PNUu1OjZwqUr4FY1Stp68BJTa9rea6XzzS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(9686003)(478600001)(6486002)(6512007)(54906003)(316002)(41300700001)(5660300002)(8676002)(6916009)(66946007)(66556008)(66476007)(4326008)(38100700002)(8936002)(186003)(83380400001)(6506007)(26005)(86362001)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W9cb5LeCO/Ub4qEyEnrTu8vBVrat0oCpSnB8Bn84u2AMu6ZoSd+4xjPaznf9?=
 =?us-ascii?Q?KlK5SrnP7xeUxDQQ0y1SV4KehJUIIYZGLFceW9ujNg1ds1CiTHr96KwJ1fXb?=
 =?us-ascii?Q?sdzCabWN6Cx0IdjWyUR4I0QrXx2pSGHq26azncK7KjmSihtlG8UnOZNvu57g?=
 =?us-ascii?Q?5lgRl7SyQr7x4lVFSO7ci72T2NgTRqEUQlAh/4dBTz5A+yZP4vFWHYl9/JbY?=
 =?us-ascii?Q?vF5owdGYndWuR14taKhK/FBcsMPb57/5XH4ggDFom0N5Zy2QAbVXnuAt3WMe?=
 =?us-ascii?Q?gcj9KsTRaoonqT014Fxc/vrpCjx+3SYCRFrQR7jr3d7XHYCuHNL6hAyf2uzD?=
 =?us-ascii?Q?d1DoJlh042wfuda6LoE1eFrC/9UxftzaaxAUFsLf6VEkdjmEQJDk86cSP0/E?=
 =?us-ascii?Q?oiV1/TZ799MqEyzwWIlMJ4oADjQoyQLBMP7x9XUGsHXMdjb67Vdmh6LsC/Ab?=
 =?us-ascii?Q?dIpftMoNIDT/4OeoCqfJ2x4ZJHePMNRj11Gw68PGFUBbXTuAiAW9r3BFlUFL?=
 =?us-ascii?Q?xBEHvcwOCpEh3q1EhORTHYFDaN5nX2nNdK8cyaHV/y7kEsetDCT4DzRsNlSu?=
 =?us-ascii?Q?xjl+366RUHgUIByqqIdIeeIt1fKgp1HY7exmRaL3Yd1KZI6qtotqN5zmzLNm?=
 =?us-ascii?Q?vMMhySeg9aox9Tp1GON9OW8humrdHSszeyYF5Qh85J9VPhGHrnLl5+5na7aE?=
 =?us-ascii?Q?xX640AMORjIT5L+FJGRlb4okHLnebQtqaTe1B8W+crTgE7gdHU/8FSE//vgx?=
 =?us-ascii?Q?jyqcc6fw7HNkWe9gz4wvqUk3jAe4/qFo37bkWEBBSEFIb4e1n6CN54N2icAn?=
 =?us-ascii?Q?YlELPeZvSLfjq31eIFhI9MoFNi289oNz6+xe/h26SFBss8qdlJ2cxDaDtfjH?=
 =?us-ascii?Q?QLR69y+yYyiZbs0U/WcISpEwC8o/R6K9PGjv18A3GKcKTWLRlhmQgclSeJMB?=
 =?us-ascii?Q?AT5LvnWED8JNcg2DzINbuBpvr3Jg8JFLbbjhLxP5KrjIFvii6F3JkJn59Lzy?=
 =?us-ascii?Q?QQqvNJdkezsox0nWPzKELj/afEAu/o5J9jr2gEOGOBnOzPULikRsfb/28ZTH?=
 =?us-ascii?Q?rzhyvukOW2MCZX84pbaWje/d+weRP/BDCmfD8Feifn0JPDRH4HCBnEQfivzM?=
 =?us-ascii?Q?fF+gPbX8+vFgsFHK2NzQIIduOfd+M/UvvTLevm/9cIuwB6JH9TPm2/ibAVtj?=
 =?us-ascii?Q?no+wjX15mpmGiXBDiFFhLmAUud/HkSNLRwYo6fDRE9/rXZuY7go4Tgy+Lvjx?=
 =?us-ascii?Q?gMzhWGVYeTcV+FfZVWaVPKifbZ95aymcCcGzISBM7W3/CGr3/n/KPtJ0fPGY?=
 =?us-ascii?Q?4Hy2uVau9Ujah+kQtgNqA2H+GaT2k4XCF+x87YXhdRbFUIxVczXQoi9Mm88E?=
 =?us-ascii?Q?Y9JB4us5VzVuFneIM6s8qQu/fkMAgARMBUkVDifXSQ2csRm+33HjqjsZZIeZ?=
 =?us-ascii?Q?p0KUD/Ddn0zPbmmKU6/dyZK9pyUpvwMrlbCqurb3yaOwRyzfUhEE5yiwWz3x?=
 =?us-ascii?Q?BkSDzN10pjL1cjQFIPv3agfGnWrrVsORNvP1wfAMF2BKB3XV37ZiqRXuvkV+?=
 =?us-ascii?Q?op0XximRrX6QZLqiCql/wxC50g5wP2toHHV8oVU5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd7d531-5832-4945-c5e9-08db8cb55375
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 02:17:42.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqobDbjf4jeeIvrd0BkgJoKeU6CblBzOTw0+432uJlGckzdaOZKL2BGTTqMnII+kLsEuDePu7LB4iNWeLYP7vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Huang Ying <ying.huang@intel.com> writes:

> The abstract distance may be calculated by various drivers, such as
> ACPI HMAT, CXL CDAT, etc.  While it may be used by various code which
> hot-add memory node, such as dax/kmem etc.  To decouple the algorithm
> users and the providers, the abstract distance calculation algorithms
> management mechanism is implemented in this patch.  It provides
> interface for the providers to register the implementation, and
> interface for the users.

I wonder if we need this level of decoupling though? It seems to me like
it would be simpler and better for drivers to calculate the abstract
distance directly themselves by calling the desired algorithm (eg. ACPI
HMAT) and pass this when creating the nodes rather than having a
notifier chain.

At the moment it seems we've only identified two possible algorithms
(ACPI HMAT and CXL CDAT) and I don't think it would make sense for one
of those to fallback to the other based on priority, so why not just
have drivers call the correct algorithm directly?

> Multiple algorithm implementations can cooperate via calculating
> abstract distance for different memory nodes.  The preference of
> algorithm implementations can be specified via
> priority (notifier_block.priority).

How/what decides the priority though? That seems like something better
decided by a device driver than the algorithm driver IMHO.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/memory-tiers.h | 19 ++++++++++++
>  mm/memory-tiers.c            | 59 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index fc9647b1b4f9..c6429e624244 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -6,6 +6,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/kref.h>
>  #include <linux/mmzone.h>
> +#include <linux/notifier.h>
>  /*
>   * Each tier cover a abstrace distance chunk size of 128
>   */
> @@ -36,6 +37,9 @@ struct memory_dev_type *alloc_memory_type(int adistance);
>  void destroy_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype);
> +int register_mt_adistance_algorithm(struct notifier_block *nb);
> +int unregister_mt_adistance_algorithm(struct notifier_block *nb);
> +int mt_calc_adistance(int node, int *adist);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -97,5 +101,20 @@ static inline bool node_is_toptier(int node)
>  {
>  	return true;
>  }
> +
> +static inline int register_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int unregister_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int mt_calc_adistance(int node, int *adist)
> +{
> +	return NOTIFY_DONE;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index a516e303e304..1e55fbe2ad51 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -5,6 +5,7 @@
>  #include <linux/kobject.h>
>  #include <linux/memory.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/notifier.h>
>  
>  #include "internal.h"
>  
> @@ -105,6 +106,8 @@ static int top_tier_adistance;
>  static struct demotion_nodes *node_demotion __read_mostly;
>  #endif /* CONFIG_MIGRATION */
>  
> +static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
> +
>  static inline struct memory_tier *to_memory_tier(struct device *device)
>  {
>  	return container_of(device, struct memory_tier, dev);
> @@ -592,6 +595,62 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +/**
> + * register_mt_adistance_algorithm() - Register memory tiering abstract distance algorithm
> + * @nb: The notifier block which describe the algorithm
> + *
> + * Return: 0 on success, errno on error.
> + *
> + * Every memory tiering abstract distance algorithm provider needs to
> + * register the algorithm with register_mt_adistance_algorithm().  To
> + * calculate the abstract distance for a specified memory node, the
> + * notifier function will be called unless some high priority
> + * algorithm has provided result.  The prototype of the notifier
> + * function is as follows,
> + *
> + *   int (*algorithm_notifier)(struct notifier_block *nb,
> + *                             unsigned long nid, void *data);
> + *
> + * Where "nid" specifies the memory node, "data" is the pointer to the
> + * returned abstract distance (that is, "int *adist").  If the
> + * algorithm provides the result, NOTIFY_STOP should be returned.
> + * Otherwise, return_value & %NOTIFY_STOP_MASK == 0 to allow the next
> + * algorithm in the chain to provide the result.
> + */
> +int register_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&mt_adistance_algorithms, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_mt_adistance_algorithm);
> +
> +/**
> + * unregister_mt_adistance_algorithm() - Unregister memory tiering abstract distance algorithm
> + * @nb: the notifier block which describe the algorithm
> + *
> + * Return: 0 on success, errno on error.
> + */
> +int unregister_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&mt_adistance_algorithms, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_mt_adistance_algorithm);
> +
> +/**
> + * mt_calc_adistance() - Calculate abstract distance with registered algorithms
> + * @node: the node to calculate abstract distance for
> + * @adist: the returned abstract distance
> + *
> + * Return: if return_value & %NOTIFY_STOP_MASK != 0, then some
> + * abstract distance algorithm provides the result, and return it via
> + * @adist.  Otherwise, no algorithm can provide the result and @adist
> + * will be kept as it is.
> + */
> +int mt_calc_adistance(int node, int *adist)
> +{
> +	return blocking_notifier_call_chain(&mt_adistance_algorithms, node, adist);
> +}
> +EXPORT_SYMBOL_GPL(mt_calc_adistance);
> +
>  static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>  					      unsigned long action, void *_arg)
>  {

