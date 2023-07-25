Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93617605FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjGYCrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGYCru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:47:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285C19AF;
        Mon, 24 Jul 2023 19:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmQVVbo6fcssB7EKnux5fa6MlB/pxO2Vt3g90KXPOO64NhRNyezaZATaJTlXs0DJRGzUfDHdCoyME7DVWO6nbZqpzEIivu1+9VZSUko4aNOQAJi1lOwiRYSz6HyRLx2U3WKGMsIXrymsOvtRLPNHweJ5ZIMvot/TmbkKayWeq/zdK+wwj6qtWVZ8kFqxTAqLOsJbrMDB3qED8u4zkBmAYzZU7wt8uJwu6phkRCGvQHYcCJgZof7YajRvik63PiiolSCr0uLRlG27vGi2vGq1W7HAzLCQ3XGw7sy7r2rOrgpM+sTtsVnM+rZrQ4YkCAFl+AKEjaI6puVwDfLn6NGrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDVjQ+vZxs8PI9VsoqnUR0ba9MQTgOXEBF/SPiVFWO8=;
 b=X7KjKcIh7CnvgFC/1dC5SPHLHv+ld9/0nOP+zH01Ty6EuD9bkMUdevht43HoH2wS7xI9zCN92kJFazhwhPW376ObpJWMqV70S6pzqtRLkDJPkkj3Lu3siaHG+f8D0EwhRJxWcsxliHXbS4nI+dsWLsD3cWY8ZZofAZjfI1hoT3ExsOE29q7jN3z5ZC6WTT7o8GQdwSJun2B0nYRrVsvJXdTGqkcHY9RiLdJV99TzwzQ/kj1h9gRd7AmtBHVDIFfKTkVyGz1G7PdzIEAz9CgvzHLq8j2dlCBl7GQZ6QG3Tne02ENuG6pZsQmSBptk9qtr4vjgdz/XVnJZYSmREdg7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDVjQ+vZxs8PI9VsoqnUR0ba9MQTgOXEBF/SPiVFWO8=;
 b=R2s+vchcPAS0Z+zgZRVR2YdEgua4NXYMGjs5Ef6P3n6xVNcCzB5r7kpGdkzZpgeildVvGlBI5wNejjHXnzkEHHVlQWCYrrJiQLMdFusYiywgFu9XN1kNf5BHaupza0xQSfxCqEr3ZoP7aVdYcTuLKWKgiR3ZibxQmtI+ul05pWIYG6e2vxlvmVKXl5+C4p8JNfvjBA2+wQ4SMF/byZ+ysOh0QPFwWgf0liWlaqww/2qvJ2zYETj75OM8qu/UBP46Qg30N/YXcxRybseV+f4mJ1aZdXuaZQnEFi4VmfI/L1YvyC2ysgufMAYsAjt+s938MjrbimD7jyJv/TwWzZTRkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 02:44:54 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 02:44:54 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-3-ying.huang@intel.com>
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
Subject: Re: [PATCH RESEND 2/4] acpi, hmat: refactor
 hmat_register_target_initiators()
Date:   Tue, 25 Jul 2023 12:44:20 +1000
In-reply-to: <20230721012932.190742-3-ying.huang@intel.com>
Message-ID: <87mszkzp3z.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0143.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: cb156b32-907a-455e-e218-08db8cb92013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CafUl2ydF4ViaFCErKC8LqFmH/o8r/XGg7z/O8XC7yFXvcreZP+iSb8C6aQrwPicexeDM0hwAwjoLT5cJIVknJdDkIBpIdLS3Ix7BIyyZjutlsx2DidZErpaOM58gMg8d/nepTGsjuIKCKBQ1LEvekhgXwD3uXLmblvBOP4s/A0bkFWQHJN7IAX7wr8fmcq6XgtAY407DHDOTW+2/711k46Z24GAXOS0nttTKVVSF1xhQAhKu6QGzxOys0WLNt8oTsvC2hqWRZhburKaLxDrUg1RmJh8MIO1NyufECYGCWrjV7S/uALttML97/13T8GQ+aZ9aY1MNC/cUlAQQIpUMrVfaeD7XNI54wNgo4SbA4j0uxBDxoWWx68/j6kSl4uiEN71HfKbH9vhYlcr9DimvwkLlcAvP6uDsFeNJcBMjNiCfBkY8q3reqIM39gUNcL6dNeEGgzuLJfwWsiBXUeKJXwsYghME8eFi15BXhDff/pxliwMsWqbBdcnZnifovG9eyTzCWJZORwDXezw2om8JH6tTjrT3bLGgDX0MZbwKEfsbIEyCjX/ObKyspe4eY50
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(54906003)(66476007)(66556008)(66946007)(83380400001)(86362001)(38100700002)(478600001)(186003)(6512007)(6666004)(9686003)(6486002)(26005)(6506007)(2906002)(41300700001)(5660300002)(316002)(4326008)(6916009)(7416002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGiH4/RiMP6+Bh52Zs5FN+vN0nJIOC3jQDeMax6FM+VrVCGN6tzuEQnJEUiE?=
 =?us-ascii?Q?zBXaRROuV5JqgrUemfz6ApRiZ7QmMv6SBBFtBnBkiSFwJwBgfvmf3aqNcnF9?=
 =?us-ascii?Q?s4iaAx3cLfdIbkoINmGOG3U9uIlC1LssFZeRdEvSnTdR9pRucZ5XMyiGwRE0?=
 =?us-ascii?Q?CbwKdwJDQA0Pqaq1Bh1oB03cvp9WiEXruR8WzCvR1uzg6vN/GpA4M67NAgyA?=
 =?us-ascii?Q?AcpuKo/EbIQfBP2Agq4v7uHVhYj14+HayvSZQY1WrPFT2SLG5o6cpmZw8tMH?=
 =?us-ascii?Q?Idw+UVvdS0NPHOwrwtJkqVzWjjXJMYEEVnk9p4fUyJdQSMnzKjmyYP7eGPcs?=
 =?us-ascii?Q?A5zqPbzt01ascS9nBVqJ4+IBklQZgexPgY0m7YPa+g2mIp4PXMNH9Eg0SZ12?=
 =?us-ascii?Q?n1jjOg06wQpKNQz5p2oPii/l2IOK0rrogADfOUvBJXP2OkpY++GhUr0H9OU8?=
 =?us-ascii?Q?uzinYNleOaMVyUDpTrZ0WKaUzcgn7C+gZtPKb/vjWdfKIbEXQ3VM7Vfk1MKY?=
 =?us-ascii?Q?Rz8wQtwiU18IaoIsatqBbssf0Yh8+xS43d5E2gg36iMwqHGq5HwUCeN6BR/P?=
 =?us-ascii?Q?bbZ8z+A7Mn/dQRDXQlPRDiFy0sd5hKGwWEEbWYZqYEh992sK4klF+TBGwoRK?=
 =?us-ascii?Q?r9bHPE920o/Hwh39ZGGPoyMvCMAeQ79sax3xb0T/7eXoeDAg/OpAc0DY3yUv?=
 =?us-ascii?Q?/OlO9TfDFSey8kvs6IMqqyosXUD9IGuQ6pw6tjJMK5gCMVB6upAd9utajW+a?=
 =?us-ascii?Q?KnzfIVzSpniahhCR+7onIA+4j/StcmIPnixlXriM4coQgB8Q3YKxeQvfmZpC?=
 =?us-ascii?Q?VDTZyrDWD/mX9I0MXHdTcbu8sPISrqJsh2dL08HfpY7WEtZSkyONagE1mXik?=
 =?us-ascii?Q?KYHeIvFge4VO4tUj46kAAtkhqD2yMqrk9IGXGyRf6PpesYgZLZ5fqscZ5di2?=
 =?us-ascii?Q?uKYJGpufzIGgeyJprSPG44oPR3lbw85vIku4tN2pSUGhY9MjmILprSJyUkB0?=
 =?us-ascii?Q?01spqw81gDUqsrRGdILyNSg8f76PwPlsOQNH2K5YTWT9HWPtFnG2U5SOYmVW?=
 =?us-ascii?Q?qfiYRajoW3B7yK4FRXy2u4HMq0jtnSTaVISg3A1SfiAzOlYvX+zUrYPEcl1c?=
 =?us-ascii?Q?vgM9mNytCO2vXb/CgAe/I4rbjaCAFhr4O5U+jjKdveWDfN5tyuZYTmYEdCC7?=
 =?us-ascii?Q?lDCGcmYwCVK9jM4jR74wu8vG3vqeb5owNl6dIfXZOMSaJOpN+z6JCcQ1h3xN?=
 =?us-ascii?Q?r+y8h/y5uxAUQzP5cjGLf8wR3rDdGuHRqEcU4+QiQDlwcyBdJWH7r1+d2MJh?=
 =?us-ascii?Q?V+fjpVMYE0CuIA0fixJws2EoytDdcqbo71qlzE3nFIQYTH56z6SpKHBYyvZH?=
 =?us-ascii?Q?S37ccch3XOgumfpBO90oYf2dGbK/MBSobNBCJiQ6RBcGo0k+6VenIKT5phqr?=
 =?us-ascii?Q?jM52VNH3lKx7gPC0tHELlaG8ojhCHuOaRPTJZB/MUUFTIwiaS39scgQ1wMJd?=
 =?us-ascii?Q?rYkp/gHRGt3LH/Cem3Hwjr9gMXMLNqpp0vbfsYWwOw/RCWnjZ7g6wzI8agNy?=
 =?us-ascii?Q?RQdAVXdgR6AIJA4TWRHjy+HF/QQiKniaO5u1Xbeq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb156b32-907a-455e-e218-08db8cb92013
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 02:44:54.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+HZOzkGeLDvktAgACqSD2rlohrbmwa5Nha+omlblUdGmcmzqp1aVys3nVUyKQDBxCVquz1Y3LyczXE/nw4S1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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

> Previously, in hmat_register_target_initiators(), the performance
> attributes are calculated and the corresponding sysfs links and files
> are created too.  Which is called during memory onlining.
>
> But now, to calculate the abstract distance of a memory target before
> memory onlining, we need to calculate the performance attributes for
> a memory target without creating sysfs links and files.
>
> To do that, hmat_register_target_initiators() is refactored to make it
> possible to calculate performance attributes separately.

The refactor looks good and I have run the whole series on a system with
some hmat data so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Alistair Popple <apopple@nvidia.com>

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
>  drivers/acpi/numa/hmat.c | 81 +++++++++++++++-------------------------
>  1 file changed, 30 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index bba268ecd802..2dee0098f1a9 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -582,28 +582,25 @@ static int initiators_to_nodemask(unsigned long *p_nodes)
>  	return 0;
>  }
>  
> -static void hmat_register_target_initiators(struct memory_target *target)
> +static void hmat_update_target_attrs(struct memory_target *target,
> +				     unsigned long *p_nodes, int access)
>  {
> -	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>  	struct memory_initiator *initiator;
> -	unsigned int mem_nid, cpu_nid;
> +	unsigned int cpu_nid;
>  	struct memory_locality *loc = NULL;
>  	u32 best = 0;
> -	bool access0done = false;
>  	int i;
>  
> -	mem_nid = pxm_to_node(target->memory_pxm);
> +	bitmap_zero(p_nodes, MAX_NUMNODES);
>  	/*
> -	 * If the Address Range Structure provides a local processor pxm, link
> +	 * If the Address Range Structure provides a local processor pxm, set
>  	 * only that one. Otherwise, find the best performance attributes and
> -	 * register all initiators that match.
> +	 * collect all initiators that match.
>  	 */
>  	if (target->processor_pxm != PXM_INVAL) {
>  		cpu_nid = pxm_to_node(target->processor_pxm);
> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
> -		access0done = true;
> -		if (node_state(cpu_nid, N_CPU)) {
> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
> +		if (access == 0 || node_state(cpu_nid, N_CPU)) {
> +			set_bit(target->processor_pxm, p_nodes);
>  			return;
>  		}
>  	}
> @@ -617,47 +614,10 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  	 * We'll also use the sorting to prime the candidate nodes with known
>  	 * initiators.
>  	 */
> -	bitmap_zero(p_nodes, MAX_NUMNODES);
>  	list_sort(NULL, &initiators, initiator_cmp);
>  	if (initiators_to_nodemask(p_nodes) < 0)
>  		return;
>  
> -	if (!access0done) {
> -		for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
> -			loc = localities_types[i];
> -			if (!loc)
> -				continue;
> -
> -			best = 0;
> -			list_for_each_entry(initiator, &initiators, node) {
> -				u32 value;
> -
> -				if (!test_bit(initiator->processor_pxm, p_nodes))
> -					continue;
> -
> -				value = hmat_initiator_perf(target, initiator,
> -							    loc->hmat_loc);
> -				if (hmat_update_best(loc->hmat_loc->data_type, value, &best))
> -					bitmap_clear(p_nodes, 0, initiator->processor_pxm);
> -				if (value != best)
> -					clear_bit(initiator->processor_pxm, p_nodes);
> -			}
> -			if (best)
> -				hmat_update_target_access(target, loc->hmat_loc->data_type,
> -							  best, 0);
> -		}
> -
> -		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
> -			cpu_nid = pxm_to_node(i);
> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
> -		}
> -	}
> -
> -	/* Access 1 ignores Generic Initiators */
> -	bitmap_zero(p_nodes, MAX_NUMNODES);
> -	if (initiators_to_nodemask(p_nodes) < 0)
> -		return;
> -
>  	for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
>  		loc = localities_types[i];
>  		if (!loc)
> @@ -667,7 +627,7 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  		list_for_each_entry(initiator, &initiators, node) {
>  			u32 value;
>  
> -			if (!initiator->has_cpu) {
> +			if (access == 1 && !initiator->has_cpu) {
>  				clear_bit(initiator->processor_pxm, p_nodes);
>  				continue;
>  			}
> @@ -681,14 +641,33 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  				clear_bit(initiator->processor_pxm, p_nodes);
>  		}
>  		if (best)
> -			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
> +			hmat_update_target_access(target, loc->hmat_loc->data_type, best, access);
>  	}
> +}
> +
> +static void __hmat_register_target_initiators(struct memory_target *target,
> +					      unsigned long *p_nodes,
> +					      int access)
> +{
> +	unsigned int mem_nid, cpu_nid;
> +	int i;
> +
> +	mem_nid = pxm_to_node(target->memory_pxm);
> +	hmat_update_target_attrs(target, p_nodes, access);
>  	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
>  		cpu_nid = pxm_to_node(i);
> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
> +		register_memory_node_under_compute_node(mem_nid, cpu_nid, access);
>  	}
>  }
>  
> +static void hmat_register_target_initiators(struct memory_target *target)
> +{
> +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
> +
> +	__hmat_register_target_initiators(target, p_nodes, 0);
> +	__hmat_register_target_initiators(target, p_nodes, 1);
> +}
> +
>  static void hmat_register_target_cache(struct memory_target *target)
>  {
>  	unsigned mem_nid = pxm_to_node(target->memory_pxm);

