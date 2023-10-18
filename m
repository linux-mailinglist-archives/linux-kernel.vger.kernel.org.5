Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F77CF14B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbjJSHbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSHbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:31:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34319F;
        Thu, 19 Oct 2023 00:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEzKdbJ+HM6ewKS1jwuUmi86JaUmfgPoLvGhWVE0bRBRKbfAm3HLSgzQCU7hzwVhGjFCo9FYBn71jMe55F3hAzzcDBCYaFbO13Rm6uYVKO8Hkf0o9ocmfBs1xcUQ2pbw+EdTP2tApO2pj/QRVEueyNe7N2iiN4gAGam2CdIGqNXg6WPLdMwMdo9ZBDbkb3Ktp2VKqQuKBFFRW453TYoHuFZHZz8dU+HJlbCM/hSH3GH1dpUmV4UsyEgobvcHptbWDFnTxCWYMo3ra7z2+Cnv8z7R6NrBJWA3CO+lJ4h5qrGtdkYr4qpsi9+dtxe8NUeMNKmk/IBbSPRle1dQi8JqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EduItXhT4mFITPfq8eYZO2pXMdqsElIyXRALgboTp1A=;
 b=LVaGZfuhG4oYuXp+qFhCCv6QzgJs5T2WqYV0ycvGDxxQ6R7hJ/mqWusEEWc58o1eZW/V6fMGkjEKsIEBVzCVdtGHUq68DwbwM/IL0etSVJ8SIayJh88eWtKDyHxthMaxedm5qkIeVlfnYDOHJW3pHJeYtH3h2mxKxtH/D95cL/fl9WpfXwHfxmDgyKyIE4iKLzVxI/vrBRpJfMgV4vcCeipB9TXZ6tT7IbhsX1NLiZUTbTnlzavARYu+sSsYTZwDGeA3Mme91C0B/1geJVTYW9mLp2bYQy8U1eAof0EhDDgH3JhKYsochxMimeP6OP1+7ICmqaCAMK1h9VMSus6W3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EduItXhT4mFITPfq8eYZO2pXMdqsElIyXRALgboTp1A=;
 b=LsHeqPqPQcpkvDKB3AE6rXdQcRE/n9JkHy5T94L9ypZ+fPVK/KyAkaYeo+BASw8f6XtdXyb/KUaRE5PzcxOJ7U50RS1aqP/1UahVksa3gAGkh8ocCKQivYDQMoqK/AFVCHundg59cifrAKlEzC9aCWhndiXzRbE9eAllghhZ4xQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY5PR17MB4002.namprd17.prod.outlook.com (2603:10b6:a03:23a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Thu, 19 Oct
 2023 07:31:41 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::3cf6:989a:f717:7c20]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::3cf6:989a:f717:7c20%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 07:31:41 +0000
Date:   Tue, 17 Oct 2023 22:47:36 -0400
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
Message-ID: <ZS9HSIrblel39qrt@memverge.com>
References: <20231009204259.875232-1-gregory.price@memverge.com>
 <87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS3jQRnX4VIdyTL5@memverge.com>
 <87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS33ClT00KsHKsXQ@memverge.com>
 <87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: PH8PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::20) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY5PR17MB4002:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ada4090-7b2e-4d56-4c10-08dbd0756faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHQ8a/ivJPn1+jscygJfgn722bLbfBlwUStcSO2gkwX0UVv294jSj6GrwsFcZmLeHHy6vvMEkH5m0pK/G5eEdhOFWdS15sWamxAbQSmCN5EgxSbvA9+4KEwRBakED/2APWkze/qom+CO6fT+lqYybBd14EdIaz+JB950J0fqWv665KZPvsIulR72woHu+vMWGwDh+KrpcTqmXeKm087VsspSe2Tm4W6/uZovc+rVi6h7wKW4k8p0hfKFXX0GphiJGTIJU1RNh6zVO5QccX4D2djDVOB65N3141bhLVcsumomwsu+3E7LsP1mpFN8fgyKyR5jtJEmIHN7v81eW4EbnN6wzYpnYeKc9+kxxRV952RvxBegsT+OnIkyApKtP+SqGWDdKCCbO9c59uK6NKQsFTJ1o11DImfCVjD6vwCKG9zH4J7YlkmLtiwXPE39F7Acn27zbdM1OfwmzXWtM9kKNqV0OXsbVNnB7yV/svQkYjzB3/bxnZVVONfBN5lX1sancKPv3SumQGFXORLXteJ5MVJVFTBDvpp15jqkjGihmQGvD3CddbOhT6G29nRZ3zk0CLdDDywA+tcyvUs9eLL3Q2Ij8xY0YljdrrVTBq1+PtEZtEPV5zny6benwOjdD6ll
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39840400004)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(54906003)(38100700002)(2616005)(6512007)(36756003)(41300700001)(316002)(2906002)(86362001)(44832011)(6916009)(66556008)(7416002)(66476007)(66946007)(5660300002)(8936002)(4326008)(8676002)(478600001)(6666004)(6506007)(6486002)(26005)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xfCzuQA5LxDtvlscESE9Q7AlvCi+Hrl0VIt8bTmfC2FDLn9Ed5u8vkHMCBlR?=
 =?us-ascii?Q?ewjrIMoYGQBD0JfJefsvkayGB3rwFKkCZHCi6VE/iF5OaOVKjfucmHD0uJEH?=
 =?us-ascii?Q?O5brRUILWDZ5AzdtmJn9cRjAEeHb8xhkmjA0ISLeSQvzrFSHPy2y6nnX6g4H?=
 =?us-ascii?Q?qZhbXhqVZlINyY2WQN5xtvSmjYQTZ3K9eIPYa7qgeomXRim1r5u2HVS2K0Eq?=
 =?us-ascii?Q?ZLyeHtSq3pxNBkoz1uLMFhh68GpG9ZDD/gIlnrvyKuF408sLBCnI82O/kafB?=
 =?us-ascii?Q?ZvqrTaylntJGVDYn1+Bcq4yT9lXqPqhsu9p046Gfi8VuUntUSLkBXvY/igR9?=
 =?us-ascii?Q?342uCprdNd317s86qX20kmhBVNg4ZrHfbh+I01CYobpfihyzrini34+CMjIL?=
 =?us-ascii?Q?JDyM5ItorB6gkU4vt2NEdoH2fGybyaPR9U+0S3Y8b7JJJAipF4LNbhkeAsDZ?=
 =?us-ascii?Q?h4vxscliKkNLeGukaIuj9Yq1yKGv9gi3AgTCo3zaLLIKLspvTenIlS3Hyd3p?=
 =?us-ascii?Q?34T5tbjxupQpx4ltRzgJ79jEUkGQ45vNh3Nkz3p23j25iBCJRazQ5mO5GRed?=
 =?us-ascii?Q?uiXpFizzjJ7LBxh4KHZNodDP+iEOgOtnRZnhu2da2E99917lwRwKlWanLPxs?=
 =?us-ascii?Q?Tvdnhpsk/Q8FUp25rF+ANPNh907GpY3g13auC4a6hSzekCV4tSJsm9HM3nVs?=
 =?us-ascii?Q?p10YSe+zdjIoX/pxtVXx9zc1NM+EZzIwfXXArgTIr9XAIAxOWr/tg4T73dHe?=
 =?us-ascii?Q?LsZsbwlYLDr8Yzxu57l4Z3E9kdXLLXYAvaVd2OPuIVqWh9Q2QQCADsXeM09k?=
 =?us-ascii?Q?0dVGrhLVlk4vgCVDSYD+Dh5RuwXO/d1odrJU7gMwxMSdp01xk5nyvFWo5pjW?=
 =?us-ascii?Q?oJwsfLEWZ4Y1tBPmFjFDeqL3PtaNoVU3vwZR315YhHa/99JKap9vyVVrXMs+?=
 =?us-ascii?Q?st9ubqQ+jCtHrcqwaJzevZSXURk8FqcqKg4xn5tkEaLcC4fGMKHi9NY79gKI?=
 =?us-ascii?Q?hUiueSx0BBsCLBxFP3h8a3qKgq9s5mnWtzHPY7fMvYDrd0HpQaiVebLjzHu7?=
 =?us-ascii?Q?03XNepippapVUIhMigNI7NI23M2O+ikMuy+LkjFe2SZGjK0uDXaWkjwsR2mR?=
 =?us-ascii?Q?+5qUwpkYuWobv/KBTkhPPp7pybd8rdY+cC4ss0zuzsIWXuhtPDxaeLMHaygh?=
 =?us-ascii?Q?9D8TfSL7eNP4ph0EZaQy40q7nMYM3MnuXefJ7MZNGPniNvRbtjwzndi9J/lz?=
 =?us-ascii?Q?rKWhTa3X0Ip3DBSI8/szsWUTuXdyHHyPBSbbz02KdFu2J/pRGNeqoPjS7Eru?=
 =?us-ascii?Q?K2/IHecRcZg56zYVEHJZ9AW/n49yXuEuDblulrQTtvm3T6E1w1KcVwCAZNkq?=
 =?us-ascii?Q?YBTCh9mpMMn/DlGvDwVFOEdLWglH4YcJeLwv6L/B0Hma95+UIVYDuqGoKHF9?=
 =?us-ascii?Q?Cb1DNmrSyv4tkHEn5OO/hLX8bNGlgDZaHHiiX57KD/UUG4xuQp1SPbvm+ik1?=
 =?us-ascii?Q?q/BBAU3eNMm88TmA+d1f+TXKJpj/BF5r7fHnQEkeXYB+E2qmsDlC4LQQ0+3f?=
 =?us-ascii?Q?jLXvuuUt71d7QcX7Relfb93dNG2Ukzop0GP44JG81anudiGQAGk6Nts5wnoF?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ada4090-7b2e-4d56-4c10-08dbd0756faf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 07:31:41.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9KMUyFp51zwM9+ldtCl9bYTTh4s5RwGOWL6OFK3hQgDHCfuKRpX+hhK5PKT2eqZKNj8BiZnbcs6Fo2EMfyJbIzE77nerAAgkObjl57k33w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB4002
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:28:42PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> > Were you suggesting that weights should actually be part of
> > drivers/base/node.c?
> 
> Yes.  drivers/base/node.c vs. memory tiers.
>

Then yes I agree this can and probably should be placed there,
especially since I see accessor details are now being exposed at that
level, which can be used to auto-generate weights (assuming HMAT/CDAT
data exposed by devices is actually accurate).

> > Assuming this is your meaning, I agree and I will pivot to this.
> 
> Can you give a not-so-abstract example?  For example, on a system with
> node 0, 1, 2, 3, memory tiers 4 (0, 1), 22 (2, 3), ....  A workload runs
> on CPU of node 0, ...., interleaves memory on node 0, 1, ...  Then
> compare the different behavior (including memory bandwidth) with node
> and memory-tier based solution.

ah, I see.

Example 1: A single-socket system with multiple CXL memory devices
===
CPU Node: node0
CXL Nodes: node1, node2

Bandwidth attributes (in theory):
node0 - 8 channels - ~307GB/s
node1 - x16 link - 64GB/s
node2 - x8 link - 32GB/s

In a system like this, the optimal distribution of memory on an
interleave for maximizing bandwidth is about 76%/16%/8%.

for the sake of simplicity:  --weighted-interleave=0:76,1:16,0:8
but realistically we could make the weights sysfs values in the node

Regardless of the mechanism to engage this, the most effective way to
capture this in the system is by applying weights to nodes, not tiers.
If done in tiers, each node would be assigned to its own tier, making
the mechanism equivalent. So you might as well simplify the whole thing
and chop the memtier component out.

Is this configuration realistic? *shrug* - technically possible. And in
fact most hardware or driver based interleaving mechanisms would not
really be able to manage an interleave region across these nodes, at
least not without placing the x16 driver in x8 mode, or just having the
wrong distribution %'s.



Example 2: A dual-socket system with 1 CXL device per socket
===
CPU Nodes: node0, node1
CXL Nodes: node2, node3 (on sockets 0 and 1 respective)

Bandwidth Attributes (in theory):
nodes 0 & 1 - 8 channels - ~307GB/s ea.
nodes 2 & 3 - x16 link - 64GB/s ea.

This is similar to example #1, but with one difference:  A task running
on node 0 should not treat nodes 0 and 1 the same, nor nodes 2 and 3.
This is because on access to nodes 1 and 3, the cross-socket link (UPI,
or whatever AMD calls it) becomes a bandwidth chokepoint.

So from the perspective of node 0, the "real total" available bandwidth
is about 307GB+64GB+(41.6GB * UPI Links) in the case of intel.  so the
best result you could get is around 307+64+164=535GB/s if you have the
full 4 links.

You'd want to distribute the cross-socket traffic proportional to UPI,
not the total.

This leaves us with weights of:

node0 - 57%
node1 - 26%
node2 - 12%
node3 - 5%

Again, naturally nodes are the place to carry the weights here. In this
scenario, placing it in memory-tiers would require that 1 tier per node
existed.


Example 3: A single-socket system with 2 CXL devices
===
Different than example 1: Both devices are the same.

CPU Node: node0
CXL Nodes: node1, node2

Bandwidth attributes (in theory):
node0 - 8 channels - ~307GB/s
node1/2 - x16 link - 64GB/s

In this case you want the weights to be: 70/15/15% respectively

Caveat: A user may, in fact, use the CXL driver to implement a single
node which naturally interleaves the 2 devices. In this case it's the
same as a 1-socket, 1-device setup which is trivially 1-node-per-tier,
and therefore weights should live with nodes.

In the case of a single memory tier, you could simply make this 70/30.

However, and this the the argument against placing it in the
memory-tier: the user is free to hack-off any of the chosen numa nodes
via mempolicy, which makes the aggregated weight meaningless.

Example:  --weighted-interleave=0,1

Under my current code, if I set the weights to 70/30 in the memory-tiers
code, the result is that node1 inherits the full 30% defined in the
tier, which leads to a suboptimal distribution.  What you actually want
in this case is about 83/17% split.

However, this also presents an issue for placing the weights in the
nodes:  A node weight is meaningless outside the context of the active
context.  If I have 2 nodes and i set their weights to 70/30, and I hack
off node1, i can't have 70% of all memory go to node0, I have to send
100% of the memory to node0 - making the weight functionally
meaningless.

So this would imply a single global weight set on the nodes is ALSO a
bad solution, and instead it would be better to extend set_mempolicy
to have a --weighted-interleave option that reads HMAT/CDAT provided
bandwidth data and generates the weights for the selected nodes as
part of the policy.

The downside of this is that if the HMAT/CDAT data is garbage, the
policy becomes garbage.  To mitigate this, we should consider allowing
userland to override those values explicitly for the purpose of weighted
interleave should the HMAT/CDAT information be garbage/lies.

Another downside to this is that nodemask changes require recalculation
of weights, which may introduce some racey conditions, but that can
probably be managed.


Should we carry weights in node, memtier, or mempolicy?
===
The current analysis suggest carrying it in memory-tier would simply
require memory-tier to make 1 tier per node - which may or may not
be consistent with other goals of the memtier subsystem.

The pros of placing a weight in node is that the "effective" weight in
the context of the entire system can be calculated at the time nodes are
created.  If, at interleave time, the interface required a node+nodemask
then it's probably preferable to forego manual weighting, and simply
calculate based on HMAT/CDAT data.

The downside of placing it in nodes is that mempolicy is free to set the
interleave set to some combination of nodes, and this would prevent any
nodes created after process launch from being used in the interleave set
unless the software detected the hotplug event.  I don't know how much
of a real concern this is, but it is a limitation.

The other option is to add --weighted-interleave, but have mempolicy
generate the weights based on node-provided CDAT/HMAT data (or
overrides), which keep almost everything inside of mempolicy except for
a couple of interfaces to drivers/base/node.c that allow querying of
that data.



Summarize:
===
The weights are actually a function of bandwidth, and can probably be
calculated on the fly - rather than being manually set. However, we may
want to consider allowing the bandwidth attributes being exposed by
CDAT/HMAT to be overridden should the user discover they are functionally
incorrect. (for reference: I have seen this myself, where a device
published 5GB/s but actually achieves 22GB/s).

for reference, they are presently RO:

static DEVICE_ATTR_RO(property)
ACCESS_ATTR(read_bandwidth);
ACCESS_ATTR(read_latency);
ACCESS_ATTR(write_bandwidth);
ACCESS_ATTR(write_latency);


~Gregory
