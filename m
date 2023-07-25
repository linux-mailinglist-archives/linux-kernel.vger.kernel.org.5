Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADB876063F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGYDET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGYDEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:04:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E955E69;
        Mon, 24 Jul 2023 20:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKLXeaOzN5erKof+OaKfFE/e9GrGYc6aqUXMHb4Sdwar9H88PEYFaWOL/pT7DepXficU+KPir2KkU1Wd/WNRdG3LomaEN2iKD/iO4Om06ELi/278mRbEK9mHjLOlRPggwB1mUHQZg/H1tXwNcTYz7l4Z2LVud25SPs0Yip6LZq60VEVcCoA2FY5Kx/polw3F+LlD6RX8IebFJN1VT3cEffF20VW7uAx4xc6Rq7+SZodffAf/tROue4Ns2e4S51J3XiDS8PzpV/ia48Wd/pumSd6H3+qkm5OLTREq0Y0cTCcu9DcVdd377J5PHShdxtQeVv+xGyAFxYyPWidrOKx0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrnHwoVVPVOHFa/vG7K74qUD/AjrS9Zw6Wn2DcSs/8o=;
 b=EX/7Oy0vWBEI3lf7YkS22CVH+FwbN01OFQdhdynDsH56b7BqrtPDMuCVRaEz8BnoHOTUbX4mqN2ubn88ptKgSQTDVSyK0qtJLNHqxND4xd2gX40mx1kn+2JxDVvEJeWp2UlDI+YW54PFOt0KuF0mLxXPLN4k19R7DWcPhB8BFUNrgCYRCowRmvAyI2Ydada42XP78BkTC5jwn+C8zCpbyIwBX9f8mTHz+41lm3VN8E+MPz6wel/6yGXLxJd3ziOpM4mux+1l5LmkBu4sRugMMMT4ZS+qMHoPvqFPnpmHLgZ83oRRhdOZH3TotL1gnU/B2eB5vt/uuMOuL1vek176Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrnHwoVVPVOHFa/vG7K74qUD/AjrS9Zw6Wn2DcSs/8o=;
 b=btnDyBBRu1tpmkusZ5riWiOA16XZZmIDE8C4czOa5VeXwS6tNHNiMzz3W8bAL2H4KEN+rdS/WxzBitcu5oeBHysRmgBxlPGmFy5/zNIGwsggX8UAxXO8J/oQhJNcFutafbgGit346LKfd34M+ISTmmZ50WFg4jIyqGT/NMOPMq11CZGd9v4hpxhjF45tpR0ErEhylcCFKeD2iBLxDNA385DN+GuiS/xrcQIQG7RqYn7DM1MHjxAoazECzc1G3I9kMrf9oCx3caHXYXs5mkPhAd4k1lqF6IhU1Nt+09DRHYK8jxUzx2rtlEc24VIlPZa2rtvvg8G5Op2HIDkzPQSrqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 03:04:05 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 03:04:05 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-4-ying.huang@intel.com>
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
Subject: Re: [PATCH RESEND 3/4] acpi, hmat: calculate abstract distance with
 HMAT
Date:   Tue, 25 Jul 2023 12:45:01 +1000
In-reply-to: <20230721012932.190742-4-ying.huang@intel.com>
Message-ID: <87ila8zo80.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0040.ausprd01.prod.outlook.com
 (2603:10c6:1:15::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e978a9c-c70e-4120-71ca-08db8cbbce47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqueYIuHUtG0ipGFjkRHwQd4Bq5SQO/2Q4jWjRvgfCpOatipGTdFyOLjJ8HDyErS3lSp85BcCPllC+8RpLQhFgqyl5rfbJz0ufodoM2AX2B5gurBVPCEBkPBiAoDM8uWjU5OeSoNwKQmSCv1vk9Ree2izsn9ohyBx/KUa8El6EtIKpREg7j9+qtRcBbYkcL/sgou2c2wQoIBL0zpOyWvOR7unO6T8niVphSMzxmd7oPlR2MJYRUEeqsxCR8JNvTN5sGLt4NqSj7Dpu8n7CNKeSC37okZDEmmIAu+4OMnydx9gqo84njzE1fm2JHcsv3P0ZR1qIf6ESG14GRODFaA3GfU31+vcCmAHQuRAACZhDlciTrVRm9dqdzj2IWZFIfuaTfsgVvjRorFXnG+ThAXgliIOQN7un8O2V3Le053NvT13EvvA9/kM6v/VqtenST5VVobFF9Z/1duTeuSkCKS/6mv7lcEs8N/mCAyJDmzW4kAgUCkgFpWE+ogIxU/C1RHr1a7o9Nx14b6HNximqMNexclkwt8mZ5tUR8xTfPYU1tJTDJOctUq7CEucy8Yunh9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(2906002)(8676002)(8936002)(7416002)(5660300002)(41300700001)(316002)(4326008)(6916009)(54906003)(66556008)(66476007)(66946007)(6486002)(6512007)(9686003)(186003)(26005)(478600001)(6666004)(6506007)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbEYtdWz6SOpcuesybcq8tTBFYeWV8mlmkfa8AJRiEljkTPWo/Tbe1CeMYlj?=
 =?us-ascii?Q?iuds5UTKcDMrU5HZr2bj8JiEKNIYO7kbmtg7DHumz6KXOfoQvvIXlVpBnwGs?=
 =?us-ascii?Q?1BwF0ODZPOE1q8OAasU4TOpFUQpB6vQCovNyEo1St1EfLtCXkesitkjvVX62?=
 =?us-ascii?Q?XLKM3vsYzjUjPXxIcopqlP//10VJ8dDaEz4jm2/hfbwUJBA/v2KX7/svC2U0?=
 =?us-ascii?Q?0dPN0HvcfX4sSZ6BQA8VGqg9M5GFqS6wc/kVRJDMilHZr+1yQsZbgslH2iW0?=
 =?us-ascii?Q?cZzUXkVg9fBZARi4Ut14RAr00DWbfQxfwfocNvzXi/XfvZ/WR+7RGigSiNR/?=
 =?us-ascii?Q?AGNXqOIpZqTWU62g+nlnY/+wKjHJ/2R5bPclxB7WfxD7HcKbz+fTkVEbt/Go?=
 =?us-ascii?Q?8KE4oSUV6RC4JvoRPBsl2WzNvDKk2zQO0kSesoXIFtMFJsahauKZwK68dC/P?=
 =?us-ascii?Q?ilPMjinrEtYcqrr+OFbU6OsTPGbpLna0YZJwuX6GAWHr7/KTMLyquZsahZRG?=
 =?us-ascii?Q?+tot+pBPUfC1ZcVUAwdvESD+4e4IlOdFWQO3w0ZG97Q3BZqk9OjEBWyyHETK?=
 =?us-ascii?Q?6QAvLHh2FrAd/hU/qioXe5lMJnW8VCkO5w4JpiSNhNVa+IZXw4B1Uc2ukbht?=
 =?us-ascii?Q?VF7w6RDNZicBCiEdg6qhWeX8ROsRtZPgzrCQ27mPx0nYHy+/woVC2MqyRY7t?=
 =?us-ascii?Q?rVM6pPh6/pUeVHjwPnuwH3qK6rTK60ucCHSw5WgCIoIVW4BlqIdj+XwjXZ24?=
 =?us-ascii?Q?KploraesQeRqqycHDds46UCUpDshxEcYpTYLwHFzT/d239GAQnELP9Tzf+qZ?=
 =?us-ascii?Q?L4O9orZNI+Q+lvZxTIelv6bOfnUtfUmS1ETEPUVSL0DfyXc0cA2NKQL5qaXV?=
 =?us-ascii?Q?u+sPQzsyw3J2H+3lgGykIah01d76AX/30JxWcvv8piQvFupsbDX/9seTcupK?=
 =?us-ascii?Q?21iVD77DjlSNA+9cINA8J1xAiIAO0F4P6mbz6tuY0Le8O1Ery7YFUphB4GPn?=
 =?us-ascii?Q?Vt010fX20B5SC6DfSDXuEKilWjixoh+diacHS8J+UYC7mv70Ltu/sfs68vD3?=
 =?us-ascii?Q?gmCKauNgd5eKonryOQrxNCbsdDf3wX1ubvO7o0dKOA4mDWKfbKSehFj/m8rq?=
 =?us-ascii?Q?nOpwsy0/8Z+2XLsdPcx67s1oNJT/QHnxgoaC14xo/cF8KEEnWpQOipszwV51?=
 =?us-ascii?Q?BNqVLNyGT1wzm5DB3NjGUMlnyVFXuCEcqm8coYSD5l7kTCIBqA6nf7VowFm+?=
 =?us-ascii?Q?d5o9DvovIR2HaTPgAuMYbYm/cEuNZWWnTjT2VcniaIfByZAfQUGBAbHKOVzb?=
 =?us-ascii?Q?KZ8AvFlPz4fozPcWNEu2W6M7cjW91v678mDjWTi3CPiQV9R89/fmagsuXOBQ?=
 =?us-ascii?Q?f98AqUOPGwbCxw/rchqqNY6UsNxIHrCWlmM4Zjzk7pfGSBHK9oFw5PVxdhcO?=
 =?us-ascii?Q?hR+lXrQddTdQF1wmSgEJFVRXQg59lnuO1UWSLDJT/D1hpQ5KHVMpZkq8yitZ?=
 =?us-ascii?Q?ANa5f/aw0SeqO4/UfT4QfqW1ZoBXXWF8Z3zVDTsptXwPiWDtrjYbGdBimBDb?=
 =?us-ascii?Q?UyaHZk5ajClLqjt+VL7Q03H/EAX8vybYr1loR21u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e978a9c-c70e-4120-71ca-08db8cbbce47
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 03:04:05.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ8nyMocue4MAbe1YOYGwSxS0o72NVvQIXmmQZfu9xMtni4UkpXwQ0x5tRg7UzXhTQ6hPMu3PBgMRrrGs7VkCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
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

> A memory tiering abstract distance calculation algorithm based on ACPI
> HMAT is implemented.  The basic idea is as follows.
>
> The performance attributes of system default DRAM nodes are recorded
> as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
> Then, the ratio of the abstract distance of a memory node (target) to
> MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
> attributes of the node to that of the default DRAM nodes.

The problem I encountered here with the calculations is that HBM memory
ended up in a lower-tiered node which isn't what I wanted (at least when
that HBM is attached to a GPU say).

I suspect this is because the calculations are based on the CPU
point-of-view (access1) which still sees lower bandwidth to remote HBM
than local DRAM, even though the remote GPU has higher bandwidth access
to that memory. Perhaps we need to be considering access0 as well?
Ie. HBM directly attached to a generic initiator should be in a higher
tier regardless of CPU access characteristics?

That said I'm not entirely convinced the HMAT tables I'm testing against
are accurate/complete.

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
>  drivers/acpi/numa/hmat.c     | 138 ++++++++++++++++++++++++++++++++++-
>  include/linux/memory-tiers.h |   2 +
>  mm/memory-tiers.c            |   2 +-
>  3 files changed, 140 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2dee0098f1a9..306a912090f0 100644
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
> @@ -759,6 +760,137 @@ static int hmat_callback(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> +static int hmat_adistance_disabled;
> +static struct node_hmem_attrs default_dram_attrs;
> +
> +static void dump_hmem_attrs(struct node_hmem_attrs *attrs)
> +{
> +	pr_cont("read_latency: %u, write_latency: %u, read_bandwidth: %u, write_bandwidth: %u\n",
> +		attrs->read_latency, attrs->write_latency,
> +		attrs->read_bandwidth, attrs->write_bandwidth);
> +}
> +
> +static void disable_hmat_adistance_algorithm(void)
> +{
> +	hmat_adistance_disabled = true;
> +}
> +
> +static int hmat_init_default_dram_attrs(void)
> +{
> +	struct memory_target *target;
> +	struct node_hmem_attrs *attrs;
> +	int nid, pxm;
> +	int nid_dram = NUMA_NO_NODE;
> +
> +	if (default_dram_attrs.read_latency +
> +	    default_dram_attrs.write_latency != 0)
> +		return 0;
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
> +		if (nid_dram == NUMA_NO_NODE) {
> +			if (attrs->read_latency + attrs->write_latency == 0 ||
> +			    attrs->read_bandwidth + attrs->write_bandwidth == 0) {
> +				pr_info("hmat: invalid hmem attrs for default DRAM node: %d,\n",
> +					nid);
> +				pr_info("  ");
> +				dump_hmem_attrs(attrs);
> +				pr_info("  disable hmat based abstract distance algorithm.\n");
> +				disable_hmat_adistance_algorithm();
> +				return -EIO;
> +			}
> +			nid_dram = nid;
> +			default_dram_attrs = *attrs;
> +			continue;
> +		}
> +
> +		/*
> +		 * The performance of all default DRAM nodes is expected
> +		 * to be same (that is, the variation is less than 10%).
> +		 * And it will be used as base to calculate the abstract
> +		 * distance of other memory nodes.
> +		 */
> +		if (abs(attrs->read_latency - default_dram_attrs.read_latency) * 10 >
> +		    default_dram_attrs.read_latency ||
> +		    abs(attrs->write_latency - default_dram_attrs.write_latency) * 10 >
> +		    default_dram_attrs.write_latency ||
> +		    abs(attrs->read_bandwidth - default_dram_attrs.read_bandwidth) * 10 >
> +		    default_dram_attrs.read_bandwidth) {
> +			pr_info("hmat: hmem attrs for DRAM nodes mismatch.\n");
> +			pr_info("  node %d:", nid_dram);
> +			dump_hmem_attrs(&default_dram_attrs);
> +			pr_info("  node %d:", nid);
> +			dump_hmem_attrs(attrs);
> +			pr_info("  disable hmat based abstract distance algorithm.\n");
> +			disable_hmat_adistance_algorithm();
> +			return -EIO;
> +		}
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
> +	struct node_hmem_attrs *attrs;
> +	int *adist = data;
> +	int pxm;
> +
> +	if (hmat_adistance_disabled)
> +		return NOTIFY_OK;
> +
> +	pxm = node_to_pxm(nid);
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return NOTIFY_OK;
> +
> +	if (hmat_init_default_dram_attrs())
> +		return NOTIFY_OK;
> +
> +	mutex_lock(&target_lock);
> +	hmat_update_target_attrs(target, p_nodes, 1);
> +	mutex_unlock(&target_lock);
> +
> +	attrs = &target->hmem_attrs[1];
> +
> +	if (attrs->read_latency + attrs->write_latency == 0 ||
> +	    attrs->read_bandwidth + attrs->write_bandwidth == 0)
> +		return NOTIFY_OK;
> +
> +	/*
> +	 * The abstract distance of a memory node is in direct
> +	 * proportion to its memory latency (read + write) and
> +	 * inversely proportional to its memory bandwidth (read +
> +	 * write).  The abstract distance, memory latency, and memory
> +	 * bandwidth of the default DRAM nodes are used as the base.
> +	 */
> +	*adist = MEMTIER_ADISTANCE_DRAM *
> +		(attrs->read_latency + attrs->write_latency) /
> +		(default_dram_attrs.read_latency +
> +		 default_dram_attrs.write_latency) *
> +		(default_dram_attrs.read_bandwidth +
> +		 default_dram_attrs.write_bandwidth) /
> +		(attrs->read_bandwidth + attrs->write_bandwidth);
> +
> +	return NOTIFY_STOP;
> +}
> +
> +static __meminitdata struct notifier_block hmat_adist_nb =
> +{
> +	.notifier_call = hmat_calculate_adistance,
> +	.priority = 100,
> +};
> +
>  static __init void hmat_free_structures(void)
>  {
>  	struct memory_target *target, *tnext;
> @@ -801,6 +933,7 @@ static __init int hmat_init(void)
>  	struct acpi_table_header *tbl;
>  	enum acpi_hmat_type i;
>  	acpi_status status;
> +	int usage;
>  
>  	if (srat_disabled() || hmat_disable)
>  		return 0;
> @@ -841,8 +974,11 @@ static __init int hmat_init(void)
>  	hmat_register_targets();
>  
>  	/* Keep the table and structures if the notifier may use them */
> -	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
> +	usage = !hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI);
> +	usage += !register_mt_adistance_algorithm(&hmat_adist_nb);
> +	if (usage)
>  		return 0;
> +
>  out_put:
>  	hmat_free_structures();
>  	acpi_put_table(tbl);
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index c6429e624244..9377239c8d34 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -33,6 +33,7 @@ struct memory_dev_type {
>  
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
> +extern struct memory_dev_type *default_dram_type;
>  struct memory_dev_type *alloc_memory_type(int adistance);
>  void destroy_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> @@ -64,6 +65,7 @@ static inline bool node_is_toptier(int node)
>  #else
>  
>  #define numa_demotion_enabled	false
> +#define default_dram_type	NULL
>  /*
>   * CONFIG_NUMA implementation returns non NULL error.
>   */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 1e55fbe2ad51..9a734ef2edfb 100644
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

