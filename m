Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BACF7D1406
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377804AbjJTQdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjJTQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:33:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB2BCA;
        Fri, 20 Oct 2023 09:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYB8nF8bdQOKIwa97XwBFp35Lg3wFUXzwJMch3U1zwnVRKpDcqjVo25y7JXC246ucOMnhNgaUZ7YeUX7+N/tjvJEvQgd0mJhm+4oxPc1dYz+dgtHSjVYOXjFI4wc+kdK9XJQysaU1w1ojpe5pbsP233j+m5I+hyI5KdXk6yillqxswe71oX7RDyVEY+qKMLQ9l2g77275pWbLmTDsD8w4446a9aSXV/ZqJ11cmvpJq7MFUuVT6MrGb8hCPi3t3XMdmu6TpagXrIvLul7kJu9izZ641USiIZlzcZpC20QvMcUIkzODTkVB8BEWpW6Ii/xOWmFb73O5zTTqCQAD2yrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SUxB3vUbMPnwPi1Ud0MQolns51Ic8Eds/tv1AqgrE8=;
 b=d3t8KWBnT0ontexpZ6znnrDtrF+J0Tr5Voq3KbIPZQkCC+QdhFFBy7es7GVcIM2i++2gjwSPPAvuxr8TuznSe2GJPWqCZ8S+lcP0KlEEvPfPSaAXja/sWmIyHtH9QxBbwpHDh7P1DztEh+/Y7q8G6Dg/ycvmh+Zz0+0yDNz2ykzeQAvDFqJv5NtdH12ICRBChAfHdJ6sGhKg5XwGwwUGDfvO1upxD3Uf6+f+GGkGmc8Xf9RazFFX9aYEfQ1VByeX9+aAhFLvPIRZZsibsXQYlA8K3cQW3pX2O3eniTkDRWregsqaBUHWHs9J7EXgegXHceYZlaNXPwFuyARPhWVo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SUxB3vUbMPnwPi1Ud0MQolns51Ic8Eds/tv1AqgrE8=;
 b=F3pu49GxJWPCjuH/X0hROSRWhE1D/SmYsPr0x/zZGqkISdY8ocPghlHyNNSqi9llan+HUBZijnT9PIoWal5LxDWUUL4VyiBJoJNU4SD/MsOGMo8vljBqnuB72shX5koQOblLOdZrVtIHgVTqNnaIezxNdQY6LR9OmUfRwg5krT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4640.namprd17.prod.outlook.com (2603:10b6:510:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 20 Oct
 2023 16:33:38 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::3cf6:989a:f717:7c20]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::3cf6:989a:f717:7c20%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 16:33:37 +0000
Date:   Thu, 19 Oct 2023 09:26:15 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted
 interleaving
Message-ID: <ZTEud5K5T+dRQMiM@memverge.com>
References: <20231009204259.875232-1-gregory.price@memverge.com>
 <87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS3jQRnX4VIdyTL5@memverge.com>
 <87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS33ClT00KsHKsXQ@memverge.com>
 <87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS9HSIrblel39qrt@memverge.com>
 <87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: PH8PR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::9) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bf1aa0-4603-4c5f-a1f9-08dbd18a4faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkUc9n3+2oFg594TF/AkFwLvkDICYt2ZAooasFWuBHuTvi0WWSSRSooGLbwVO5kaskSMKcZU/mFfRWXQ0RZWmyMFr/URU0Q6bs/LKw5gzCtfo9Gk+nddwD0CJCQ7VHG/PI9nuWmsJzqoc6fMmJLmI308nH5dDAgL2DrFjkIVdJzurqASLGxI4Vs44xjp9ushjWKkDzBfefJeA/XPTcYi80tQOsoZQKspFOhc2zxB7AC+fw+KCptOIpBpHV+Ma7aMF39DAuEQMbSZKhzRgNM+M2uw/Z2UuhFqYInCWo8BMGwYEdKHkyQTStXpBwPsB5BO/z1gv6mrfDiFFf9UGudJavTMLhJzhsRcT3O6qoV6GOR7okcQtkzQKwtdbHVnyjEwwNTZPDjmGFnUSyfWRn8jrxkKWxhcpgsEOecySe+pwlJuXpI88xSq1NXXRgJBrgoLv36Pd1XLaH56GUA3LqngoNayCOATGcyfFDr3Z67uOnXp8rvIMUiEh6xs8LFgWGok0Ln9H8PE8ZU7k/APHSqreeqF+FNVHQMdiBJA63zR+Yrzlgo54pEqaYnLjszlHUBNh7fD9688qEXgwzqVPl3XrG9md14VkgfGtuIPJi/l5tpwZxu96UBHqWAUMPogfxTAua/ra3+eA/FqfYaA6I2wew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39840400004)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(6506007)(6666004)(83380400001)(6512007)(2616005)(86362001)(2906002)(4326008)(7416002)(44832011)(41300700001)(26005)(8676002)(8936002)(66476007)(316002)(36756003)(66556008)(6916009)(54906003)(66946007)(5660300002)(478600001)(6486002)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERVkUfyJ01JTtjBioN4D2LG6XLYVzPgPlZeGl35bwMV4Q58CbQhnLA4hKGQp?=
 =?us-ascii?Q?XXxLCmGGk7Aj3k9beLG3OXwHC8nhT9HkzwRabFJjvSva1yX6GjZy6g4GF1fA?=
 =?us-ascii?Q?/BzNMvEVwwbMBQqufQhyAeSC/rdrBVEz4EeibqgtAD0trdExzU2a98n11ooQ?=
 =?us-ascii?Q?mVjF/hKTjWnzIbW5W14OcZKk+Zckv1ZVElCzELqCfFtW8LnSAqymGce/Ynex?=
 =?us-ascii?Q?6mN1XuB9WIdpcAxENQXpNRFesJMwPDCUN9P8clVN45pCSvfYdJC8a8GxYbD4?=
 =?us-ascii?Q?ATYSuKevF+OKs4xlj0O6g0vD8SlSoQK5ofiNZPeyT5Dgr1XtzVHprXDt7JJT?=
 =?us-ascii?Q?DJCOSmKU2/L6rZKK0VcNX6emrk69i1+cLmLv8om2Ma2tnfHlDrej7zeVCy/l?=
 =?us-ascii?Q?1+LdWBXgWmKyablqaXSQqShByGs1cE9JyybTV3yVafqWTFnbE4oRVKWJw8aN?=
 =?us-ascii?Q?1LpSeyu5LbrNh6nG7tKNADyCKkL60TBgX5bTkj7JdnDc1PPFk2hlv46xiG2F?=
 =?us-ascii?Q?c/JSV2skMYFt1dPXPeZoc/Xrgv7sd6wygITfXrIwP0yO2QIdLP3Jh3HTuqJa?=
 =?us-ascii?Q?i9FeTWbygLOVlWRZsPEV46jtnFcfywxgNcugDQnkgTNCm3E5lN8GtToarmaC?=
 =?us-ascii?Q?Fz7qYUjCMTNaNi18+oEW+Vc3oTrzMSytA3EIUKk5WWKZzybyxnnfXuutTXJ+?=
 =?us-ascii?Q?AAqMQaEms8WxiWRAz/8eHOsbq3fI4YOy+g3Eg3PqCxaDJDy39/jRb225SDIe?=
 =?us-ascii?Q?C/gvoq9SVkU9p3nfESl2Li14TNAwmYbqwZeN3vo5mFUc6A7bF3WnXxun/nLk?=
 =?us-ascii?Q?BKKNzOBmwqv0Dnd8UbPZ5sj0FwflAEFziShxBSxlrgeBg+vMn2P+MjWooOGb?=
 =?us-ascii?Q?9KOMeGynU2V0Fy2cRO9/Urw7QpcZ0sID3hJ5n0vNMFOLQXrVybLr/T0jZ2sD?=
 =?us-ascii?Q?87q2L/oIOl/ttb4QeOo8+uTylRMq8zC78FvpF9uFlpgbt/5oScxIb+mXOzfz?=
 =?us-ascii?Q?YDBmLcYXViF5oWpD7lTnmi2q36/WhG+Py08xrWggLFVFdlDCuAshC7cWZRd7?=
 =?us-ascii?Q?KzUGVyoESEuiEJUfp6qzBQ9fV0TjGPBVD2v+XFcCzf4Xp9u4jAULA5fZxm01?=
 =?us-ascii?Q?7KTmE7aFqtSIsUrll330612MQXXJ+O+cN2w0Amz1nlIjPOQYsF9BFoTLqwlV?=
 =?us-ascii?Q?60SxdrHW0IWNYfset/guGE4hfnKksLjDIu8bdeBhkyMs4m08OwTaTpw0vbZX?=
 =?us-ascii?Q?XSjAm+r1mTpiKFsTpBUUpCa143z+EUlA8o7PqCk424/y3aYon+oP1fhEdLko?=
 =?us-ascii?Q?6a05/aCFCESigMookYM+5a+MB33QgBP7VwcyVyyBnYJrNSQb5MhkSzbuTHrh?=
 =?us-ascii?Q?Uq2ex2SNeVa5fV6BtuZxYHsJVJGeRdhoFK81q7pefdUPNhgmeKtwilhN2o3F?=
 =?us-ascii?Q?QfD16h4C4KdsxajtCCX/dp2PMMLY6MGgWoEHZRoz37+Va9Ysgn2g45pQ1F7o?=
 =?us-ascii?Q?bzUZhDF+pQHJu37zW5aunAy2NqeKuicLWSUW1H2HU0d+9eMSMrgcU3XrUSzr?=
 =?us-ascii?Q?Uf5DKD7Ss1iMS3dZDY2267O8qPgjdyb2QRhdJpa7+8HgFafImfwAmrOhBMNa?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bf1aa0-4603-4c5f-a1f9-08dbd18a4faf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:33:37.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7ZDN19NR7P7ngirqopE77Sv+zaqVYO+x81ykZ/xT+EhhSP/AJ2foNr8I1kH99LtozWdmBCUPl44yNSauRxaTB9l504QyTZNMmtZK0+jcN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4640
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 02:11:40PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> >
[...snip...]
> > Example 2: A dual-socket system with 1 CXL device per socket
> > ===
> > CPU Nodes: node0, node1
> > CXL Nodes: node2, node3 (on sockets 0 and 1 respective)
> >
[...snip...]
> > This is similar to example #1, but with one difference:  A task running
> > on node 0 should not treat nodes 0 and 1 the same, nor nodes 2 and 3.
[...snip...]
> > This leaves us with weights of:
> >
> > node0 - 57%
> > node1 - 26%
> > node2 - 12%
> > node3 - 5%
> >
> 
> Does the workload run on CPU of node 0 only?  This appears unreasonable.

Depends.  if a user explicitly launches with `numactl --cpunodebind=0`
then yes, you can force a task (and all its children) to run on node0.

If a workload multi-threaded enough to run on both sockets, then you are
right that you'd want to basically limit cross-socket traffic by binding
individual threads to nodes that don't cross sockets - if at all
feasible this may not be feasible).

But at that point, we're getting into the area of numa-aware software.
That's a bit beyond the scope of this - which is to enable a coarse
grained interleaving solution that can easily be accessed with something
like `numactl --interleave` or `numactl --weighted-interleave`.

> If the memory bandwidth requirement of the workload is so large that CXL
> is used to expand bandwidth, why not run workload on CPU of node 1 and
> use the full memory bandwidth of node 1?

Settings are NOT one size fits all.  You can certainly come up with another
scenario in which these weights are not optimal.

If we're running enough threads that we need multiple sockets to run
them concurrently, then the memory distribution weights become much more
complex.  Without more precise control over task placement and
preventing task migration, you can't really get an "optimal" placement.

What I'm really saying is "Task placement is a more powerful function
for predicting performance than memory placement".  However, user
software would need to implement a pseudo-scheduler and explicit data
placement to be the most optimized.  Beyond this, there is only so much
we can do from a `numactl` perspective.

tl;dr: We can't get a perfect system here, because getting a best-case
for all possible scenarios is an probably undecidable problem. You will
always be able to generate an example wherein the system is not optimal.

> 
> If the workload run on CPU of node 0 and node 1, then the cross-socket
> traffic should be minimized if possible.  That is, threads/processes on
> node 0 should interleave memory of node 0 and node 2, while that on node
> 1 should interleave memory of node 1 and node 3.

This can be done with set_mempolicy() with MPOL_INTERLEAVE and set the
nodemask to the what you describe.  Those tasks need to also prevent
themselves from being migrated as well.  But this can absolutely be
done.

In this scenario, the weights need to be re-calculated to be based on
the bandwidth of the nodes in the mempolicy nodemask, which is what i
described in the last email.

~Gregory
