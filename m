Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A47760672
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGYDNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGYDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:13:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0710EF;
        Mon, 24 Jul 2023 20:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcotN0DJJ5ZSx4kavhL4SvQO7cjoGnhSS0k2r686icTOBg0KsOPSYkTwihyaxOOvVN+a5tR9EEm8ZdNExCOhdAfCDkitvf6JystJWGoWk4VqotzG7vNMx1kezNK786lbV7gx8NhazcFuy4v0jwYFr2ATJ4z/XmTNiBUCRkwHE+obfxRUNGXneP8j5kaxxPnKO2tQeAXurLtKeXxjLZuzo1giUStA8h/AXIZorLLoD21z6SW9pZ+vnW2YsD3iesZTR9ntEIBoGdcZ2xKZZbbJSPfmEXWYWGVuLTbK6bli6V5BP1gEGKPvzY8TkBZguPRfKQ6XG+kLsrxnGOkTRuiiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTG+WHebqnf/uQSAIt0zyzkg8NRDfITUu2ByngrFuMI=;
 b=BoXqVWiaRJaEY/ygg30dk5bEs4CNzhmV0iDw97QMvOX8h6BfxLwr8GBzD4AKrXu8aE2ZX87cn0ZCOZ62JV7DZfNDkYPjdf3+P0l9gQRERe7IKKM44NOAJize7/XHS8KpVpRb4g/4NqP7mM1K4/gx5lkHAc48GYCoWUlXGVKaixUP9WjX1ZuSXpEYb+rALfB9RaNn3j7rsRgELnNgPpgupNvnHYdcN7G9IQIbDqTnETwjsASpfEBtcotpBvTQZGeaIKysB1aRLmsneX/8r2wtlmW/+KrL0fv4uY5VrF/9Dz7XztPJUMpFr3RBQpCJTP5PbBzMJAyt6iV64pUj/o0bkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTG+WHebqnf/uQSAIt0zyzkg8NRDfITUu2ByngrFuMI=;
 b=d2+5u+Qz/L8q1AfIWJ6TPMRO/o43ItdR/CHJ3VMHF/dKVcIYiLFRSIphz8VBE2efFp34gsdphSIbBgpIOacotB5HiEGlVtqGcg51Ry3xuUKavEdNp9yTb4lfzxQAlyy6YsdXeosn4bhKfC6sx7bgZ4lHBUQi/NHqedJn+rXQ/NHzjooVtHy2Wd9OgWkBc6Enpuq30BuRJGKFHl1ZnJwLZjvoNPlncaov/CzXXdAuRFcZbWfZJW4BRbV7tUZ0Y7Iz0mDfmUiAfmpd3qt1hj4LkqSg4FwE8HBbuQyrKSTCNcPBMLxL7QCFV2qhWKW/H3ra3Ku/xjIMKdrnLGSOLsRs7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 03:13:26 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 03:13:26 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-5-ying.huang@intel.com>
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
Subject: Re: [PATCH RESEND 4/4] dax, kmem: calculate abstract distance with
 general interface
Date:   Tue, 25 Jul 2023 13:11:12 +1000
In-reply-to: <20230721012932.190742-5-ying.huang@intel.com>
Message-ID: <87edkwznsf.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0061.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::6) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: cced934a-644a-4472-1c0f-08db8cbd1caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5m2coJuddC1QlQOS8ILSUxOX7LworapqOPn6ZEWTfJHjHZuc7hb94QVgcH9BYGt7CAR5ls9YZbxZAMJIwnyRAU2paluj2+YA6wijkIEsxUZUXIvQMajZAM8iD90wrlbPey+uWySiOlPj/IusiLvp/0KORT94q/V7oxc8WkaMpgSusW/n6C1yW3HyavX/U+6/TLbcl57hMvQHQqRrLwTvFp9AyvTjFx/WtgAb5+7+RNeVBauvgeTqX5TJfwEvCXYSZd0/NZzdNrkbUqMXecrC3rLnnlJl8SdjL6Lw5KciHP2WEe8vcbMmHf2egJUbuMxKUYLpOcfRtm2j/EJP/FRBVI9z3JedB/bricYnpsp+Y4+Vo0EqUMrL97rTKeqi01aMYq4EswH1rytaXLBBY3ehSPJTqgGIOu6fVVo8v92YxJm9MHnzUvgMpd93jyyljhIoVpzdoYwbz1O85CsQN3yt3U41SoJY1ZBMWctEwveC75vlAIl1zWluSSb2douGVwSKHejYTj+gDj1eIKA2vzbHWc7c7ZoG9HPqg2pcpqkMttbcFkHUuElEFdLRgZuUGm6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(6666004)(6486002)(54906003)(38100700002)(26005)(6916009)(4326008)(66556008)(66476007)(66946007)(9686003)(6512007)(478600001)(316002)(86362001)(2906002)(83380400001)(8676002)(8936002)(41300700001)(6506007)(5660300002)(7416002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bwTZ2QR2Q/hO+0Ed2k4HO8ItkIkMRha61UdEKu8u8JIYUnwqxhE2l5kioCYm?=
 =?us-ascii?Q?VmvGzK1HRpEAAE+mFXn/KUFgQg1lhV/fGfxYsi0FquSUfKovrZCWwPrfNX82?=
 =?us-ascii?Q?k7vgCeCYwY+zioNeq7m7+z01MkrT8rcwjSTXHkVmpZ+7nngLiMcCUlvweMJd?=
 =?us-ascii?Q?zTT8r3AyMRBkjYRFYhvbI4Io2HtV2G4Oh1eWvTjCxPK9UJzegtvrAQYbVth5?=
 =?us-ascii?Q?bdKBB4fFJEEfc+aWD58O8tMZIBmtkWqN3Nqmp+ECT/uz7G5+t7uvA0DMbAsq?=
 =?us-ascii?Q?mEXTNTO7a5sGtuWpLzSajk2l7HlTmBvSQsL8MkskWbctKhqj7RK2RBws5g1Q?=
 =?us-ascii?Q?vqnwiQFm11H+/8NlieSbXVumyOh4fXwEwPUvmH2wjoI9Oow+FKgm8mZtRKES?=
 =?us-ascii?Q?3KEVB3YJFofDLaaNtSGRZEQIlkNanOTx7nWaQR7j996NBgmBRgp6VBm+BC4D?=
 =?us-ascii?Q?qMuKnK3lrq2PGgdvrAe8vZLjk4IoetCLenOn2q10kQWREhZKo6h/SiDbeFNz?=
 =?us-ascii?Q?bgx7vcNA28gD6aDDy7YsKyYBwx2a5A9jUl/UYyO8bKCKbyKlnVsyEbl35e+4?=
 =?us-ascii?Q?aX58+hB7UINJZlbIUj46WAGOcxLDbCE9ZeaiIQLHYqHn22fYm2fitZJyETFl?=
 =?us-ascii?Q?aDw4OP1XiyLNoyy4F9PdGCGMUq07logLAbuvG+S/UbShZWAtYbxQtySMn/+w?=
 =?us-ascii?Q?DCci7BgKozibsP53V/0vsBIx1VMKpHBbuln07s5q39HacOjHBZt3v5RLhZrH?=
 =?us-ascii?Q?6u/aSONK4HqGEsL64eyzBqGTFLFByFQJdhecYpFUPXuQ/7YPZi/k8z7hofjB?=
 =?us-ascii?Q?C3XOuz8u6AsMNoPwIEkSvewbe9T1zBrwe3ok6ydqomkj/j+stDKHgJCYbhkk?=
 =?us-ascii?Q?xcDmcPLdkynu3LKBfBaow2yk/sGS6BFpWnwfI9u5DTz1S4PtwBpex8gQWWQ5?=
 =?us-ascii?Q?2Cf6gqStHuVaf7fs4D6u8cy4Ym+CsxblXKez8+zT5aRnYJnzjxeWUIvVCfF9?=
 =?us-ascii?Q?lisQtTt8SguAiQ87x1+eGhY0Bjt+cdxhdBVidmYlpVSAHE10207G8AB+MPZ2?=
 =?us-ascii?Q?O5CzR7K4gVFXoQ2azqBFelWWTPz5SmqquixgrChQbT3qCCXAxLHnxf+ShszD?=
 =?us-ascii?Q?5N06Pj/kaKsHjdZUzSkFETqoy7qe6ll1JQYrkDcJwhVYQI0BOSh/WmMBziMj?=
 =?us-ascii?Q?NERXsPvEQ+RRwVEXUtGhTUymGr0fnCRr2/Fqz570x/VMQi2j0SV4CDwMBlj4?=
 =?us-ascii?Q?WAYAyuSi3VqwuhRc2/eWrG7z0L2juVIzTfZ/zAonWoKxrWE9kvq3JfU/0tA2?=
 =?us-ascii?Q?5JzwZupDRFYI/5zgRpdz4GVDY981F3732sTYLQxUiJToIin58Mew2GnXVBZQ?=
 =?us-ascii?Q?ODmMXDlx4gbm5grJfvyY1lxxv/r1xq+M475cMCZw24ty6WlmKvkrFSQW9voB?=
 =?us-ascii?Q?qaEcLFyHyVfwlxQP8ipqH7XgTkC0+3K/eVEKaez+DERFNG3O1wPadHlX8tbA?=
 =?us-ascii?Q?OlllQRMmFwwdZfgRcrQN7Ajh3nb/j8JLdDhnO9q//w8Ux31rgfFOyjGdgqks?=
 =?us-ascii?Q?CtbTtCILPOkqmwpfrEwsGwzXBWVMKmxKFthukkDb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cced934a-644a-4472-1c0f-08db8cbd1caa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 03:13:26.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fly4EyHP5cS2ZYpdmuUTqSA/4XLz6jQeHT4d9NFmvJ8oT2aLOPq/nW5Pe0GDSuA7HTxrrV0QRQmbm4UjnmpgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Huang Ying <ying.huang@intel.com> writes:

> Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
> used for slow memory type in kmem driver.  This limits the usage of
> kmem driver, for example, it cannot be used for HBM (high bandwidth
> memory).
>
> So, we use the general abstract distance calculation mechanism in kmem
> drivers to get more accurate abstract distance on systems with proper
> support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
> fallback only.
>
> Now, multiple memory types may be managed by kmem.  These memory types
> are put into the "kmem_memory_types" list and protected by
> kmem_memory_type_lock.

See below but I wonder if kmem_memory_types could be a common helper
rather than kdax specific?

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
>  drivers/dax/kmem.c           | 54 +++++++++++++++++++++++++++---------
>  include/linux/memory-tiers.h |  2 ++
>  mm/memory-tiers.c            |  2 +-
>  3 files changed, 44 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 898ca9505754..837165037231 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -49,14 +49,40 @@ struct dax_kmem_data {
>  	struct resource *res[];
>  };
>  
> -static struct memory_dev_type *dax_slowmem_type;
> +static DEFINE_MUTEX(kmem_memory_type_lock);
> +static LIST_HEAD(kmem_memory_types);
> +
> +static struct memory_dev_type *kmem_find_alloc_memorty_type(int adist)
> +{
> +	bool found = false;
> +	struct memory_dev_type *mtype;
> +
> +	mutex_lock(&kmem_memory_type_lock);
> +	list_for_each_entry(mtype, &kmem_memory_types, list) {
> +		if (mtype->adistance == adist) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		mtype = alloc_memory_type(adist);
> +		if (!IS_ERR(mtype))
> +			list_add(&mtype->list, &kmem_memory_types);
> +	}
> +	mutex_unlock(&kmem_memory_type_lock);
> +
> +	return mtype;
> +}
> +
>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  {
>  	struct device *dev = &dev_dax->dev;
>  	unsigned long total_len = 0;
>  	struct dax_kmem_data *data;
> +	struct memory_dev_type *mtype;
>  	int i, rc, mapped = 0;
>  	int numa_node;
> +	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
>  
>  	/*
>  	 * Ensure good NUMA information for the persistent memory.
> @@ -71,6 +97,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> +	mt_calc_adistance(numa_node, &adist);
> +	mtype = kmem_find_alloc_memorty_type(adist);
> +	if (IS_ERR(mtype))
> +		return PTR_ERR(mtype);
> +

I wrote my own quick and dirty module to test this and wrote basically
the same code sequence.

I notice your using a list of memory types here though. I think it would
be nice to have a common helper that other users could call to do the
mt_calc_adistance() / kmem_find_alloc_memory_type() /
init_node_memory_type() sequence and cleanup as my naive approach would
result in a new memory_dev_type per device even though adist might be
the same. A common helper would make it easy to de-dup those.

>  	for (i = 0; i < dev_dax->nr_range; i++) {
>  		struct range range;
>  
> @@ -88,7 +119,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> -	init_node_memory_type(numa_node, dax_slowmem_type);
> +	init_node_memory_type(numa_node, mtype);
>  
>  	rc = -ENOMEM;
>  	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
> @@ -167,7 +198,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  err_res_name:
>  	kfree(data);
>  err_dax_kmem_data:
> -	clear_node_memory_type(numa_node, dax_slowmem_type);
> +	clear_node_memory_type(numa_node, mtype);
>  	return rc;
>  }
>  
> @@ -219,7 +250,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  		 * for that. This implies this reference will be around
>  		 * till next reboot.
>  		 */
> -		clear_node_memory_type(node, dax_slowmem_type);
> +		clear_node_memory_type(node, NULL);
>  	}
>  }
>  #else
> @@ -251,12 +282,6 @@ static int __init dax_kmem_init(void)
>  	if (!kmem_name)
>  		return -ENOMEM;
>  
> -	dax_slowmem_type = alloc_memory_type(MEMTIER_DEFAULT_DAX_ADISTANCE);
> -	if (IS_ERR(dax_slowmem_type)) {
> -		rc = PTR_ERR(dax_slowmem_type);
> -		goto err_dax_slowmem_type;
> -	}
> -
>  	rc = dax_driver_register(&device_dax_kmem_driver);
>  	if (rc)
>  		goto error_dax_driver;
> @@ -264,18 +289,21 @@ static int __init dax_kmem_init(void)
>  	return rc;
>  
>  error_dax_driver:
> -	destroy_memory_type(dax_slowmem_type);
> -err_dax_slowmem_type:
>  	kfree_const(kmem_name);
>  	return rc;
>  }
>  
>  static void __exit dax_kmem_exit(void)
>  {
> +	struct memory_dev_type *mtype, *mtn;
> +
>  	dax_driver_unregister(&device_dax_kmem_driver);
>  	if (!any_hotremove_failed)
>  		kfree_const(kmem_name);
> -	destroy_memory_type(dax_slowmem_type);
> +	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
> +		list_del(&mtype->list);
> +		destroy_memory_type(mtype);
> +	}
>  }
>  
>  MODULE_AUTHOR("Intel Corporation");
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 9377239c8d34..aca22220cb5c 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -24,6 +24,8 @@ struct memory_tier;
>  struct memory_dev_type {
>  	/* list of memory types that are part of same tier as this type */
>  	struct list_head tier_sibiling;
> +	/* list of memory types that are managed by one driver */
> +	struct list_head list;
>  	/* abstract distance for this specific memory type */
>  	int adistance;
>  	/* Nodes of same abstract distance */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 9a734ef2edfb..38005c60fa2d 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -581,7 +581,7 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  {
>  	mutex_lock(&memory_tier_lock);
> -	if (node_memory_types[node].memtype == memtype)
> +	if (node_memory_types[node].memtype == memtype || !memtype)
>  		node_memory_types[node].map_count--;
>  	/*
>  	 * If we umapped all the attached devices to this node,

