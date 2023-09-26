Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D717AE606
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjIZGfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjIZGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:35:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C85DAF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAjNFpit4Ck5PibMZH0b8Jtxk5PS1+FmcYxmGz3/znduqygxcW0JpHP5oXAJaLyogN7B5ZDYXJu/Buzni4f6Gw72ITdG1KNVFmaDPki0qY6ofvUaIdCnU1iO3FOHTkVyhpMtj0Vtw6goluDMFdkdzJyrrVVnRsQhx8V9hyvdzPTRL76KhwlirlePH8a7pKG2cHYNK9MvOpMSMzUekKhSSIthfHuy8cWT7nNuowj0+vj2+GLGzjSsDS6P+KNQ9A79r6KxYsf+rwltdvOle8TgkXPvIxYko31xn0NtoSK7xtzbQwwRsERXgK+92NvA4QuvYCp8sT5enbZf4DZFXESGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXtDvstoKHn/PeeTWUSmlO8GR8CdNSuis4dSJ/O9aWo=;
 b=GoHo4n2IHoYMJJV/6S2C248JrcjU/vYBz3semmyaaWU0e96Z2FWUA/RmnGiwK1LS2e6TbWXGNLWWOUYfjHntU0VD4M8o/MOI2xtnIGOKLJUO43P17N3khzK4kI7sf7Lh1Zr357AxUu0uXny1/qDtmXeXQDFpq8Nh2OHmZYCOktF0N7RwzMkQFry7+VAO5DP3wMxhr4GiqCbnk4eATfNYxPREuRIw0hqjby3jqtV9QyacSvZ9b0TokJsgayLc0u0wTpj/8Ih0tZIAHEQHUDzGzIhE9e288JIJoaRRsObxzebJ6JcltjafitwEou5GXyVHpBxyedT5LL+rWdiAgzKtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXtDvstoKHn/PeeTWUSmlO8GR8CdNSuis4dSJ/O9aWo=;
 b=V7tmIDHaq0UJZoL4b9c8KHix7/qcl9B93VIVwS38x8f+u1KyqdsKz2DhpKQ6hK56DtZptOJanz4lJ7HsDmuic+D8Wie6rnaZnGYMeE9ApQSZAo7F9am4J+VcPA1jhv6YG8DNxrXCwFMBqqDKh7OEBBzhwUqK4225HaftwvLGQnV/lnj1DFZfp7uNqfkQxCCck2AuwjnKIcn5k00O2pjZflJZu9DmpujM0DGdDekQIsY1gkq3C5zKgInZlpK489PvWKfup60uC2dEubN/a9j0ZLEor3+mlaSKMB+hkUM4aESyBh9kInDSrrMHqUihPEZgRWnqqfhEkz/6Wad0PPHXnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:35:02 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::5612:ffdd:6052:5817]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::5612:ffdd:6052:5817%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:35:01 +0000
References: <20230926060628.265989-1-ying.huang@intel.com>
 <20230926060628.265989-4-ying.huang@intel.com>
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
Subject: Re: [PATCH -V4 3/4] acpi, hmat: calculate abstract distance with HMAT
Date:   Tue, 26 Sep 2023 16:33:55 +1000
In-reply-to: <20230926060628.265989-4-ying.huang@intel.com>
Message-ID: <87wmwda1de.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0064.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::14) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: b678280b-e7a8-42f1-a780-08dbbe5ab566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUUvrQvcXjKBFtrd4Ep9DROKgkUFImqGCg2cwOTodJpFFra7xZFc4xef0PH7kG6gYUhBzrEtN57/nbEt70V/0UEUntoDMQIKBzG/W6T/7qwAFcSrvnbAm8rm5msAgGmqGZRtLLpcU+I9JdthyS7AXcjisSzjR+qlfjzjtL+yQBWe1ehXdkXyclGJTfveYXZmJdDP+kBt97uu8qaElx17Y2l7H+VBfazZDg7i7cpYvuG5eT9KqLJrTQzxJj6d71cnKA6CLkI5fJkH7Gh/PXiWuClmk3kV5bh1U50yMjpHtjng8OrvERI1tPIpXmLlGybVZp8Y9wZ2NAjK/tp0ZIeO01olTskj8o8apFh4Sch1WFZHos0BP0x7Hayo1EQD6GYcyElcd+l+XCiWQBNycmaROOPJb1COkJoqU7j4kCzAflj3cMTeuMFUrT2SAYqTycIsphywcIxKEmS+qKsYhZraDTqYHmPPt99IUSb0lsh92bLXsMY32+I6Ki2joR5/vXLaVfdVGt64yB8u9rxHJZGLy89GIQ+1lT3Oq6xkgLECH1om5zKPoeobg84Lz4SQL6uv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(6506007)(6666004)(6512007)(26005)(86362001)(66946007)(66556008)(66476007)(6486002)(9686003)(478600001)(38100700002)(83380400001)(54906003)(2906002)(5660300002)(8676002)(7416002)(8936002)(4326008)(6916009)(316002)(30864003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmPhkq4pFqdo2hROOC+S3XmBLGNicLz2fOKrhajJ+J3lSNUh8J+Ei0EdL6PI?=
 =?us-ascii?Q?8mzhjPfvS9+qOwwRZ5guypzDl8ozIn1FDQ3Iys8Cgfx7TnQM0wfH7/b2nmoe?=
 =?us-ascii?Q?P3LPn1zUxU2B001FR/GQOGPwjdlxCWaYvKygNvlCVAq331tWlEBSM4kebmqT?=
 =?us-ascii?Q?glzIJgiklNVpqpyt0Gb2O7HmVkGLFPRxvk7lftvCpRi6fpyB1nQTzsZjAUZl?=
 =?us-ascii?Q?ojI3F9Yc1S+zRrzy4mzBpQUnkmLO9Il+QAcUSMHnSjyZIyVMbHI9SZFtXX3p?=
 =?us-ascii?Q?pNyoFyAhfJHTG8YY4XLIwlm2sy3w0XLzkI+GD8NY1KrymgCMsrfU40MPeAoo?=
 =?us-ascii?Q?SeLUbyajrlBI21xGLSa7FiD5+whQfNHYTtrTjUs36ZfDgaV+CGTRo1zrrvbP?=
 =?us-ascii?Q?BtnJFeQTxaegwHJFzkvFUEsORe8qqHmRcw4QNWGZWVkvI5bIfXtRaLz1TSF2?=
 =?us-ascii?Q?vF7fPLoBoMzsOne1RTKhXL5b9QTzdTLz+CWGcQTEQ677D8tG7koG0lOvd53Z?=
 =?us-ascii?Q?b27cjevUHP0yeMmAMIaTYAk01jzRrehIy31FzWAPLKIMT2rZ46x6qjnFAgTN?=
 =?us-ascii?Q?Ib7GkFxgfQmxORcvvq/v+KxNvQrjNnf8aTk5VORDtY50Q2MtkAfrHSQo8Gpc?=
 =?us-ascii?Q?Zz4JC3YmMAbhJBoLD1XEOwHLW2zdPaZ+Wuxanw1bwao/doaYyOYZq3k1y0Jp?=
 =?us-ascii?Q?d97WJVtuNIxeXnXzkV09lCLOnSmP0/HeA/HT3DsgeEuDuUhxCou9gQ38kyS+?=
 =?us-ascii?Q?i0O99vVDoMg9dEMjZTzxfJipMBGlvfhx4+ct2m1cKRvuyzCCDyxBLGCSeJ40?=
 =?us-ascii?Q?AG5rH+fBa5BN3g1GZ9j4kaNmKSgXAkGCAPS7fMT5etzRo4ITH4oYeOI0kzqi?=
 =?us-ascii?Q?/nodBEcXXI6yLVhpwR6fECvu98MpQcKNywADCciouyFkvAzbAb/gqMiTNPaL?=
 =?us-ascii?Q?DyBRqW/gUMCIXfX1oAUwl8Bup7jWGJLFJRyUeyDKILg7AlZIwDIoZc27kZL5?=
 =?us-ascii?Q?cPlsJVeRwrl66QIYgP7Ki/oYKBS5UwUhKk1I3wXpHqCEwn+08/yo5AJmyRPr?=
 =?us-ascii?Q?Q5xc5xZvxJvaGNW5wTzrk3Z3KpXpRSll4r0bzw+cHrNiPtnA2x/jjKvdErT4?=
 =?us-ascii?Q?8oeNewHoEOlh6r38bOIaroqo9SCwq6CPPCvwNIWEgZqhEA1gCxWM4QPHDb6W?=
 =?us-ascii?Q?cQxnc+SoGgW4pDeA/E6yWAQqvL/+xcKza5I29RZfEfvt1NrDpmCcxc92oSD6?=
 =?us-ascii?Q?a0hBbqVWzt8WxukZ6LfiE2HfduKsNnGDQAbWEwOSgN9w4BPN+ZPvr7VggOQI?=
 =?us-ascii?Q?qcpAwgdvwATyHQGDu2a0IVbDfaBgdko8ldmj2w4qi3Y5TD7TumPpO60bNE2M?=
 =?us-ascii?Q?9zZEUV8cD2njJRPtQROdjrXe1ETXygzIAxAYipDJQ/BXf1C0sw++aesx2h+S?=
 =?us-ascii?Q?t3d9oK4EmsCCD+B3bDaZZUnEaw5lEIbXUnnE8sFuktC4G93cOlF5rHNo6Q8y?=
 =?us-ascii?Q?VlLcVDUG7zLT8QkCMWQF0YsD5N3G3UunulNjuYv1YK9uXH1uT5oQll/tOEbs?=
 =?us-ascii?Q?4wfvJ7tNjmxcVIlug3Pxx6HwvkeIoyfwoSb5a3As?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b678280b-e7a8-42f1-a780-08dbbe5ab566
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 06:35:01.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NNritkH/KE52OH8RSclirl/zB26w5zYaOyEKLM7urZPupi4OjQLPjT01sehoi7v7GbXQARVTNnUfavlq0zw2g==
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

> A memory tiering abstract distance calculation algorithm based on ACPI
> HMAT is implemented.  The basic idea is as follows.
>
> The performance attributes of system default DRAM nodes are recorded
> as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
> Then, the ratio of the abstract distance of a memory node (target) to
> MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
> attributes of the node to that of the default DRAM nodes.
>
> The functions to record the read/write latency/bandwidth of the
> default DRAM nodes and calculate abstract distance according to
> read/write latency/bandwidth ratio will be used by CXL CDAT (Coherent
> Device Attribute Table) and other memory device drivers.  So, they are
> put in memory-tiers.c.

Thanks for addressing my previous comments, please add:

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
>  drivers/acpi/numa/hmat.c     |  65 +++++++++++++++++++++-
>  include/linux/memory-tiers.h |  18 ++++++
>  mm/memory-tiers.c            | 103 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 183 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2dee0098f1a9..9ef5f1bdcfdb 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -24,6 +24,7 @@
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
>  #include <linux/dax.h>
> +#include <linux/memory-tiers.h>
>  
>  static u8 hmat_revision;
>  static int hmat_disable __initdata;
> @@ -759,6 +760,61 @@ static int hmat_callback(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> +static int hmat_set_default_dram_perf(void)
> +{
> +	int rc;
> +	int nid, pxm;
> +	struct memory_target *target;
> +	struct node_hmem_attrs *attrs;
> +
> +	if (!default_dram_type)
> +		return -EIO;
> +
> +	for_each_node_mask(nid, default_dram_type->nodes) {
> +		pxm = node_to_pxm(nid);
> +		target = find_mem_target(pxm);
> +		if (!target)
> +			continue;
> +		attrs = &target->hmem_attrs[1];
> +		rc = mt_set_default_dram_perf(nid, attrs, "ACPI HMAT");
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hmat_calculate_adistance(struct notifier_block *self,
> +				    unsigned long nid, void *data)
> +{
> +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
> +	struct memory_target *target;
> +	struct node_hmem_attrs *perf;
> +	int *adist = data;
> +	int pxm;
> +
> +	pxm = node_to_pxm(nid);
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return NOTIFY_OK;
> +
> +	mutex_lock(&target_lock);
> +	hmat_update_target_attrs(target, p_nodes, 1);
> +	mutex_unlock(&target_lock);
> +
> +	perf = &target->hmem_attrs[1];
> +
> +	if (mt_perf_to_adistance(perf, adist))
> +		return NOTIFY_OK;
> +
> +	return NOTIFY_STOP;
> +}
> +
> +static struct notifier_block hmat_adist_nb __meminitdata = {
> +	.notifier_call = hmat_calculate_adistance,
> +	.priority = 100,
> +};
> +
>  static __init void hmat_free_structures(void)
>  {
>  	struct memory_target *target, *tnext;
> @@ -841,8 +897,13 @@ static __init int hmat_init(void)
>  	hmat_register_targets();
>  
>  	/* Keep the table and structures if the notifier may use them */
> -	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
> -		return 0;
> +	if (hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
> +		goto out_put;
> +
> +	if (!hmat_set_default_dram_perf())
> +		register_mt_adistance_algorithm(&hmat_adist_nb);
> +
> +	return 0;
>  out_put:
>  	hmat_free_structures();
>  	acpi_put_table(tbl);
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index c8382220cced..9d27ca3b143e 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -31,8 +31,11 @@ struct memory_dev_type {
>  	struct kref kref;
>  };
>  
> +struct node_hmem_attrs;
> +
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
> +extern struct memory_dev_type *default_dram_type;
>  struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> @@ -40,6 +43,9 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>  int register_mt_adistance_algorithm(struct notifier_block *nb);
>  int unregister_mt_adistance_algorithm(struct notifier_block *nb);
>  int mt_calc_adistance(int node, int *adist);
> +int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
> +			     const char *source);
> +int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -64,6 +70,7 @@ static inline bool node_is_toptier(int node)
>  #else
>  
>  #define numa_demotion_enabled	false
> +#define default_dram_type	NULL
>  /*
>   * CONFIG_NUMA implementation returns non NULL error.
>   */
> @@ -116,5 +123,16 @@ static inline int mt_calc_adistance(int node, int *adist)
>  {
>  	return NOTIFY_DONE;
>  }
> +
> +static inline int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
> +					   const char *source)
> +{
> +	return -EIO;
> +}
> +
> +static inline int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist)
> +{
> +	return -EIO;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 76c0ad47a5ad..fa1a8b418f9a 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -37,7 +37,7 @@ struct node_memory_type_map {
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> -static struct memory_dev_type *default_dram_type;
> +struct memory_dev_type *default_dram_type;
>  
>  static struct bus_type memory_tier_subsys = {
>  	.name = "memory_tiering",
> @@ -108,6 +108,11 @@ static struct demotion_nodes *node_demotion __read_mostly;
>  
>  static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
>  
> +static bool default_dram_perf_error;
> +static struct node_hmem_attrs default_dram_perf;
> +static int default_dram_perf_ref_nid = NUMA_NO_NODE;
> +static const char *default_dram_perf_ref_source;
> +
>  static inline struct memory_tier *to_memory_tier(struct device *device)
>  {
>  	return container_of(device, struct memory_tier, dev);
> @@ -595,6 +600,102 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +static void dump_hmem_attrs(struct node_hmem_attrs *attrs, const char *prefix)
> +{
> +	pr_info(
> +"%sread_latency: %u, write_latency: %u, read_bandwidth: %u, write_bandwidth: %u\n",
> +		prefix, attrs->read_latency, attrs->write_latency,
> +		attrs->read_bandwidth, attrs->write_bandwidth);
> +}
> +
> +int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
> +			     const char *source)
> +{
> +	int rc = 0;
> +
> +	mutex_lock(&memory_tier_lock);
> +	if (default_dram_perf_error) {
> +		rc = -EIO;
> +		goto out;
> +	}
> +
> +	if (perf->read_latency + perf->write_latency == 0 ||
> +	    perf->read_bandwidth + perf->write_bandwidth == 0) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
> +		default_dram_perf = *perf;
> +		default_dram_perf_ref_nid = nid;
> +		default_dram_perf_ref_source = kstrdup(source, GFP_KERNEL);
> +		goto out;
> +	}
> +
> +	/*
> +	 * The performance of all default DRAM nodes is expected to be
> +	 * same (that is, the variation is less than 10%).  And it
> +	 * will be used as base to calculate the abstract distance of
> +	 * other memory nodes.
> +	 */
> +	if (abs(perf->read_latency - default_dram_perf.read_latency) * 10 >
> +	    default_dram_perf.read_latency ||
> +	    abs(perf->write_latency - default_dram_perf.write_latency) * 10 >
> +	    default_dram_perf.write_latency ||
> +	    abs(perf->read_bandwidth - default_dram_perf.read_bandwidth) * 10 >
> +	    default_dram_perf.read_bandwidth ||
> +	    abs(perf->write_bandwidth - default_dram_perf.write_bandwidth) * 10 >
> +	    default_dram_perf.write_bandwidth) {
> +		pr_info(
> +"memory-tiers: the performance of DRAM node %d mismatches that of the reference\n"
> +"DRAM node %d.\n", nid, default_dram_perf_ref_nid);
> +		pr_info("  performance of reference DRAM node %d:\n",
> +			default_dram_perf_ref_nid);
> +		dump_hmem_attrs(&default_dram_perf, "    ");
> +		pr_info("  performance of DRAM node %d:\n", nid);
> +		dump_hmem_attrs(perf, "    ");
> +		pr_info(
> +"  disable default DRAM node performance based abstract distance algorithm.\n");
> +		default_dram_perf_error = true;
> +		rc = -EINVAL;
> +	}
> +
> +out:
> +	mutex_unlock(&memory_tier_lock);
> +	return rc;
> +}
> +
> +int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist)
> +{
> +	if (default_dram_perf_error)
> +		return -EIO;
> +
> +	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
> +		return -ENOENT;
> +
> +	if (perf->read_latency + perf->write_latency == 0 ||
> +	    perf->read_bandwidth + perf->write_bandwidth == 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&memory_tier_lock);
> +	/*
> +	 * The abstract distance of a memory node is in direct proportion to
> +	 * its memory latency (read + write) and inversely proportional to its
> +	 * memory bandwidth (read + write).  The abstract distance, memory
> +	 * latency, and memory bandwidth of the default DRAM nodes are used as
> +	 * the base.
> +	 */
> +	*adist = MEMTIER_ADISTANCE_DRAM *
> +		(perf->read_latency + perf->write_latency) /
> +		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
> +		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
> +		(perf->read_bandwidth + perf->write_bandwidth);
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
> +
>  /**
>   * register_mt_adistance_algorithm() - Register memory tiering abstract distance algorithm
>   * @nb: The notifier block which describe the algorithm

