Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B156C7AE60A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjIZGgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjIZGgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:36:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF5F0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvmjtCsQQJP92O/UZ0cACMTHlSoW224AyCSGRUQoj8a98uGCzfqByNnfucqzEokUj3xNswKtbFdz6RHOOgoU+5rlw2NaJfUgsPb1l6ipCs3NENrbNpeGsmbgTpWmx3vU6WaYwE0aIGz1levhmq1223YssYomE8MWrtmoDG2ak7sTM6aFZ9k9NGeP6GpZNJXQ/Atj35OUeVPzCZW0hE3g6c6ZKCNWk3WNb/ZZYRZYkZ4LMt+aM7sMbuB6Zoza8WKpXLqTivwTeJ0HCKAixf5znNvm11oMxIPtyC5bUYrPkfTjqZlr0UReA2BndewxEys/vkvT9nbqh85SyFrgWQI6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB5wiOni1uZBea+zj0SPN8nKR19uyQacfkDgaWol0e0=;
 b=QJaNf7yGVA27Q8y5HB8jEda6RZLlg66M7MbiTbZycFIqpFwj4pMumtsnIcyn0PLK7ETTsywheB/b2HEzAIuMki47B/uTZkcNHpPEfq30T2xg/ZqYJErkF4wdlc0evsiTHxtiJoxy/caTufCuolB5fi21M5q18rwz3dZw8WMJP/gcmjKZw6VOZKbkrE1LiOqROrWcxZ2Pf5DLPc8ds5xy51M2d8dc3ScgpXj7YUi+txWmYHFrhVgqxdcDPkDyqm4m/JlrArB+h3CIpgAiOOfHZ5/FpUDiJAFMQ5zUIh5R8vj96tU7uOhAN6QvplcM7TvLXgoWEG6T4wPMXhnVoPvG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB5wiOni1uZBea+zj0SPN8nKR19uyQacfkDgaWol0e0=;
 b=LQrnknr9vm5hVRKanXmJmAN27+qt/ETgpkResXL0KHUHtmR4UPRTQwnugfm0EUgjwH7f2IMWrjd3fI32kcFn0j3hJKjSRJ1Iz3hMbuRjXIneQ8znPg94HxMyXBPctxxItIwopw+qDfL8xQkes8DhubOkLwtiyPmdvVh8d26mQktQq71Ai/tUkFo+EW/5RWXyobHLEPWPfttkTD/wE1LX5mees6pyadiGH3Rc6+WtiSWfB3D36pSTJnxL11H/WzBP98+mpxpnlfkmKfPGLYUnCK0fmQ9ltmEOSXqJQeo2ny9uyrOkAWkFYvvPgSfb+OaUbvugTiMIjEpOuKOVWRAK8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:35:48 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::5612:ffdd:6052:5817]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::5612:ffdd:6052:5817%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:35:48 +0000
References: <20230926060628.265989-1-ying.huang@intel.com>
 <20230926060628.265989-5-ying.huang@intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Bharata B Rao <bharata@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
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
Subject: Re: [PATCH -V4 4/4] dax, kmem: calculate abstract distance with
 general interface
Date:   Tue, 26 Sep 2023 16:35:06 +1000
In-reply-to: <20230926060628.265989-5-ying.huang@intel.com>
Message-ID: <87sf71a1c3.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::20) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 621816dd-7d8e-4ad8-5fb1-08dbbe5ad1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUtWbedt6V1CrfFVt2AX1UEDIU8ieFsB5dVK4+vSXYSwH4zXIoKE/HuYE7m6U5EAHag2f+omuu93jMpCsSjssg++fKLNsEmtmWi4WRdYXcwFvQWk0hSJBp1p2FxN44orSbgdz7QMrR6mKAVNa+ZhU4/tHUHfGLecaYnTgMqLe7JzkxgVvaAwY24GITe7eKOmzY4o9cGHaZVA5WjfldvD5KXB7C04VohpHOdByaGZZEThgnihyFw/gy+i+l2Mizk7OtmCElfMUM56he2cqD4qpSn2cSbU7fYbXC6VrRcHXRVz8eKzP9H/PzV1lhDdx5cjsbPNuekSZnrowwyiolX93mXkAlcdmrCZJ8K6yEpC4x1XFp/FyxGkdkuCXbuD7TpdbTDAfXVlbhtesr7P0naR0Jvl+CcjByV14pCJpsfba3N92fCurqjGkBQ2NPOpB4hA648jsNcq84zaTJJzi0hMqa8CGq7U2LyQG7UhMznosl93jJWQPAErtcWURt9lbq79eqV9pVZJuVDRAWbwmME+fmjcQPHihHchfkS/Nc246vtBZLr8oUiiLDPAQXRAQZHp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(6506007)(6666004)(6512007)(26005)(86362001)(66946007)(66556008)(66476007)(6486002)(9686003)(478600001)(38100700002)(83380400001)(54906003)(2906002)(5660300002)(8676002)(7416002)(8936002)(4326008)(6916009)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cp0sXyQtpRhJIkQT+FD55/ijqCjUEFm/V3K5YoP54fZy3sWhOuIk9LEmuKLz?=
 =?us-ascii?Q?B8V4zCnGig3XaHeYVoyyLtwc0XcqwOF+bq0dfD7GYqQ/sFt40x1jJXD0OwwD?=
 =?us-ascii?Q?x1waGMNzlqrTolI+fpx/UFPmknJIJKd+itcewEAw014z0Q88bJ5XTXngWYo0?=
 =?us-ascii?Q?Q1sy3/WIL3pP3AeGa3hhy2O0CHlFPqsmxlFxOs21vCWOkWam7BfIq3JF2jjN?=
 =?us-ascii?Q?AE/WiGS7NZnqY/2CFMuEAJ1Z0EtMypDPEVsX778gcnCB5yMiEVb7I5y6juNm?=
 =?us-ascii?Q?jCtVSaTPCJ/s40tG2vDMWwultCDQxRCM/wl6QVjyzwky0irzZpprERUXTY0U?=
 =?us-ascii?Q?uCQsvrWmAwFZXzZfFgHmDMKhZLrR5uTT4tJAgtb9fXdWRKZGo9x+sbcfC/qm?=
 =?us-ascii?Q?SZVEJyUd5+Elyqb4MwTAvWeItfkurzyLntkSzabEra2ZvvZ2HAD8sHI2w+eC?=
 =?us-ascii?Q?gTKdZSXHnZNQVZjT8fQPZUQb//v7qANLbSARpbHKGP4gkLQfI3u9EnrSd8XT?=
 =?us-ascii?Q?Io96gGiGbfK9URAeFC8/LIgi7byTqj8s6ENG+rXkvEySiZYo4HfiMbUPFVaZ?=
 =?us-ascii?Q?GRiem2EyB8ECpAOODYay5vLmEU9hKUBEfoWHmiBxsdCUONVm//Ch4p8vF7Yx?=
 =?us-ascii?Q?gByvouiKDPMDTdXVtrsxzPUmt37QABUpOXYOLbaKQrbUjdN6GjansJnTQJqE?=
 =?us-ascii?Q?k8bs0wHcbPpo1mAgTrQ2pzX+kNjhs5SX5DFJkcqTDyVIrmRqzzPUb53wyWD/?=
 =?us-ascii?Q?BVfiVvqz+66+42/ljmh+r15/GOVz8dcy6HKsHbf4KG23wPKGSdMrIISo3qIh?=
 =?us-ascii?Q?0B51xLowAP2hDTJNxh5qdd5rOYLStBKr9XF8WqYNJe9YsCSXOmzi8CRtj7VQ?=
 =?us-ascii?Q?dq9rF1T79+bZMy+nKHGdOJQOo5yLUpSFWSPlZuzIxApVxOol3GO22kSHsVYo?=
 =?us-ascii?Q?2VrHjLz8w+jfBz10Q7ZGirD5cF17Zggrtaz//cub/AKk6ZN9QlpEAm8jUtgw?=
 =?us-ascii?Q?SD8tcj1e5x4LdsjO4qgRsiKj3NjUrCkrUCu3tC+axjN6R+rmskD6+xXqEWeU?=
 =?us-ascii?Q?VTsLQH+FS9g1tXbx9PM+xZlMWBN407VA7eI22hHrUWIGRY6y8/Co+yCK4JO6?=
 =?us-ascii?Q?OjZLoSom4Tic6/6jv7xRAqNGrTRnEs4uqVkf/6RVnDXimHQulSCZUZkru+g+?=
 =?us-ascii?Q?VS1bTkXpyJYEL3lsLEoRG1xv3jVm2qPBhypJK5MS0P/pzeKVeHcAuDuAuhE2?=
 =?us-ascii?Q?iHYnTYxJpAUWH84fmfNFekl3eMnHGUDdubvXduN9i16TyoZBcnQvCghnjfP0?=
 =?us-ascii?Q?mW0BXBX94txpU1I/3hvLW8m2rISZbSHGEJgIKyww+/xIpDZ+JbnDgRlmVk6T?=
 =?us-ascii?Q?kxalNdz/LoeP5955OInj4v7Oky6srctWhDt9ECTqrE3UiJBFBNBSzvX0dH3L?=
 =?us-ascii?Q?hIap8aEkY/ySA/wTJyjy2BvLEjSgMD0UZVMskN8Z93my+7AORW2vMk8SulXV?=
 =?us-ascii?Q?dZN1rOQMfCefsi4SxHAz8Qycm0wkMLd9rc1/0JIHTJapKx51mKTOqH2xsR2x?=
 =?us-ascii?Q?YKTsnu1CTtlu/w5hcJPZNe8W50t0TLNX98pytrsj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621816dd-7d8e-4ad8-5fb1-08dbbe5ad1e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 06:35:48.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83KrRR3bjSB2ZBiDHqDqzlLaztzR5I+R2u4YvMiCbkOoJVPouCbI9s36XtFqbL2vlJQfQ8Wj4V1RYvgQO79AKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

Looks good, please add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Tested-by: Bharata B Rao <bharata@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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
>  drivers/dax/kmem.c           | 62 ++++++++++++++++++++++++++++--------
>  include/linux/memory-tiers.h |  2 ++
>  mm/memory-tiers.c            |  3 +-
>  3 files changed, 53 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index c57acb73e3db..369c698b7706 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -49,14 +49,52 @@ struct dax_kmem_data {
>  	struct resource *res[];
>  };
>  
> -static struct memory_dev_type *dax_slowmem_type;
> +static DEFINE_MUTEX(kmem_memory_type_lock);
> +static LIST_HEAD(kmem_memory_types);
> +
> +static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
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
> +static void kmem_put_memory_types(void)
> +{
> +	struct memory_dev_type *mtype, *mtn;
> +
> +	mutex_lock(&kmem_memory_type_lock);
> +	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
> +		list_del(&mtype->list);
> +		put_memory_type(mtype);
> +	}
> +	mutex_unlock(&kmem_memory_type_lock);
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
> @@ -71,6 +109,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> +	mt_calc_adistance(numa_node, &adist);
> +	mtype = kmem_find_alloc_memory_type(adist);
> +	if (IS_ERR(mtype))
> +		return PTR_ERR(mtype);
> +
>  	for (i = 0; i < dev_dax->nr_range; i++) {
>  		struct range range;
>  
> @@ -88,7 +131,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> -	init_node_memory_type(numa_node, dax_slowmem_type);
> +	init_node_memory_type(numa_node, mtype);
>  
>  	rc = -ENOMEM;
>  	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
> @@ -167,7 +210,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  err_res_name:
>  	kfree(data);
>  err_dax_kmem_data:
> -	clear_node_memory_type(numa_node, dax_slowmem_type);
> +	clear_node_memory_type(numa_node, mtype);
>  	return rc;
>  }
>  
> @@ -219,7 +262,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  		 * for that. This implies this reference will be around
>  		 * till next reboot.
>  		 */
> -		clear_node_memory_type(node, dax_slowmem_type);
> +		clear_node_memory_type(node, NULL);
>  	}
>  }
>  #else
> @@ -251,12 +294,6 @@ static int __init dax_kmem_init(void)
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
> @@ -264,8 +301,7 @@ static int __init dax_kmem_init(void)
>  	return rc;
>  
>  error_dax_driver:
> -	put_memory_type(dax_slowmem_type);
> -err_dax_slowmem_type:
> +	kmem_put_memory_types();
>  	kfree_const(kmem_name);
>  	return rc;
>  }
> @@ -275,7 +311,7 @@ static void __exit dax_kmem_exit(void)
>  	dax_driver_unregister(&device_dax_kmem_driver);
>  	if (!any_hotremove_failed)
>  		kfree_const(kmem_name);
> -	put_memory_type(dax_slowmem_type);
> +	kmem_put_memory_types();
>  }
>  
>  MODULE_AUTHOR("Intel Corporation");
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 9d27ca3b143e..ab6651402d7e 100644
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
> index fa1a8b418f9a..a28606e65ef3 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -586,13 +586,14 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  {
>  	mutex_lock(&memory_tier_lock);
> -	if (node_memory_types[node].memtype == memtype)
> +	if (node_memory_types[node].memtype == memtype || !memtype)
>  		node_memory_types[node].map_count--;
>  	/*
>  	 * If we umapped all the attached devices to this node,
>  	 * clear the node memory type.
>  	 */
>  	if (!node_memory_types[node].map_count) {
> +		memtype = node_memory_types[node].memtype;
>  		node_memory_types[node].memtype = NULL;
>  		put_memory_type(memtype);
>  	}

