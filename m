Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0A27CD7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjJRJ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjJRJ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:27:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D89FA;
        Wed, 18 Oct 2023 02:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYLAgEq1qS1tJFvwoAH9wwUqiVonHO33cOimon4W5qCEOdQ0ZrSmmDWCvGC8QDiNKVQyI20chTt8xwMHE8kibK/TyPWXHOWeTIEsgLXmsOoYqBxukM2DIQgpSHJvC2aERi6XZUlac0oeS+XBr1whrGzj6CcNKWHofTtCZWSbd8SF+MHA3TT/V4cwctbqWUoPeFCTbtNTtXrhx2qrhX9QqcDFYvICt7eqZbZnTUeSCei3ZkFZgbPl5htnWCnhBGKaai3Cz8Hv26P+ZkDOG9sYucHAKneegKTS0ORpoPOzxxd0Cc1lnk3aoQCXgeDLCom18uhzX9/HwaA3tf/QtrLH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A6T4ndpemkdwu3Hj9ACHVj30sDHG4DqsknvGn4cyk0=;
 b=li/XktHqS0P2kVZuLxRGwpy+ZM47croTvjUXa0okZHRlxtwpMIONk8MDPPjToalMOG4+J29Vog68sjc8n1GYMTT/NbH14FP0RUwjLIKWmCYK/PJTenekfCRI+thfK+7ZThuUtNGR8smNBDMNCq5r4d279nyyT5N+wM/rfWNqDEhfmDn80LC9XlabfVZFYIgL87tqcKz98SkLiG/ZOpf2BLYh6ZRurxmjgaLGBk35og5oELtPTRtmAF4oK9l/FNUhSYYmvV5xChO5C4PaX7oWO7nDV9wT4iQNFbBk6fwKfEVdqZsYjZuixyjcKWniXErHzPbod6l4iqrYCauL+ZAikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A6T4ndpemkdwu3Hj9ACHVj30sDHG4DqsknvGn4cyk0=;
 b=SlRfN2CGVcREjGVGkfoH487KLHI9LZ1pQHCGKD8usvdDD9IyTXpFOcyNRusiQSeUmHwaAeI3YO5Uy2PS3Yoj+019HnJ6nl++GvD+dRyUdshoeLM8FTC1iG/gKnynMcsAM/ZPVdUWeQQ0IFpu7zkI4wU3/Ezj7HDI/IzduVwMSMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY5PR17MB4082.namprd17.prod.outlook.com (2603:10b6:a03:230::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 09:27:23 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::3cf6:989a:f717:7c20]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::3cf6:989a:f717:7c20%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 09:27:22 +0000
Date:   Mon, 16 Oct 2023 22:52:58 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted
 interleaving
Message-ID: <ZS33ClT00KsHKsXQ@memverge.com>
References: <20231009204259.875232-1-gregory.price@memverge.com>
 <87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS3jQRnX4VIdyTL5@memverge.com>
 <87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY5PR17MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: f874aefb-6603-4115-cf09-08dbcfbc6eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXOzHjTYqgp3ieJvztk4J9PL/k55flhGncGDwBTaBBZ0N1JJ8fDiFOqGfXTp2N7c3UoB9S99/+OCjjiYrLfCXC1qEC4mChxBD55jKbjOBBrT/Yja0HzEY6o1T5xvojrhdqJ6OrLfACfgUQ3PYPkrNmcvNhaqJNeeZHw7+A+yW78+HgalJy18/ECtlRHPeuTrFhcxlp4fDY1gk5CSEGymL7w4e/X6h0HFPgYmhyuPN+r2IXMqP90m6WILM9XHy5AAmq/0r2DMQMWkKRF/ZEUtcFK/S2GlgCsNF6yeowUPmU4gMZGLKAV14vpt/jPJ2WgJMOp6pdNSfyJfyUxzbURA4CL0DGNwYe2cP+RwkufSrEaKCJ5Z54KK50YuF0LdAIqPGce44/IUc8vjjoL8O6vcXTE3OEO+heyS/2oiZKMaZuUV6XI3vAgsnk/f+jadBHukLBxH/nW14tBHLUhCdAXZEVthSsMvglHFqzzgLF7nzVyd+s1dgY8cqTv8W/f2H/56AJ/kLUneEmW5Gp6YyiJ/xCJpCjELj72e/5WuZchLhcAEjYT9/wNoVWxeChdD5Xr+dyPSc0vQAHowvzQTXb0BTWgeloa+Obu5EPyYIYK3Uuwz/qVDd1ZCilct84MCez0nyj1H/Dw8sv1JzFxizbuUH6U3Zqpfi2bUD+AECFQx378=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39840400004)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(6512007)(2906002)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(6506007)(2616005)(66476007)(66946007)(66556008)(6916009)(316002)(6486002)(478600001)(26005)(83380400001)(38100700002)(36756003)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cFPissPbREKybmJTeOCKPS8KkmgEJWyhIcuvq4i3XCT4Lf9Ap4LV1sYmZVFb?=
 =?us-ascii?Q?iK8uGvbkkjK+aQjdqvbT/IJcnlkP37cqloJ1jqwj/KKVN6b4vEcce2QUglvY?=
 =?us-ascii?Q?OXAhIRNhkdP249URd5yKX6FnWCmyYWGj0+Jk5K0aFmFnZfZ8Pn7GXV1UVjyz?=
 =?us-ascii?Q?DTr0KwiezNlAB+bbKA9OkHTcvcvtEQCS0ntnKzk5jk8UAUi2phDpR1dA9aIy?=
 =?us-ascii?Q?Myq67uLtDJ87t3o3z7BOxM2sJM6ui1l1FBw6f4hHIQLVNlnishjzV5SgboHQ?=
 =?us-ascii?Q?qzev/bdkmz/gQUCgvOqc5vLTPkME1wowMQy9RUA+F8IcT5kKuIzuM63VNjZ3?=
 =?us-ascii?Q?nDlsrsdDk/+A1KZWA3eY7J8oQVLBCod4LoAg1MRNv4wsR/L6KGo9QkfIUPF/?=
 =?us-ascii?Q?iW4n8diXzWE7QrNzqKJllqQ4+bGeJEmIJCmNJ24wjOBAKUBOq0NQWrYDJvDd?=
 =?us-ascii?Q?EGs3YkZGvLt70Ukf+PnsDuIMCOVt9xgP4P4VzbbsKnWi4Dw85J1vzoiho0Cs?=
 =?us-ascii?Q?ARLIN3IPBtJqXNVl3DiB8CnAkszCVSZVrYqTi8gYWk0Nxji7uKdLNJ/qE4fU?=
 =?us-ascii?Q?3aEKVtY2Ytbz0uedYTiZ1KEVdR2JKnS6aXeux0/gCTphKzgYNUVLnFrkiEky?=
 =?us-ascii?Q?e9LBZxp37OQymk4QtoowM/q7OUrL+2yufmIjc45nEiJjm64kdVlW0WAgDxQ8?=
 =?us-ascii?Q?8pMqdFECuQj1ogzjIqBAWyYuF5WGXwJ97LFyp+SCv2sq2ASQapI5FiTJLEY+?=
 =?us-ascii?Q?I2Deb49x5g0ZMrmP4hR//1pWtykLbxAz/1OQ5/5V0HPt9l4cERpnqx0VhuWi?=
 =?us-ascii?Q?pkC1W3T1GDSiRfHb+8uAsfcN3sWnrIPju4UxeV9y3hXKjj+DPAOEoqyOV13V?=
 =?us-ascii?Q?ibpNwRnHVg568CO2Uv+aZogh9OPj+/sFv9nhocBORlovTTTk+ncZrJJkuNS1?=
 =?us-ascii?Q?PyOltfvwngkAPqZok05SgRVvwFmx0Ox4jGtaqZp+u0WA1MjZOhhAcm2tCGYM?=
 =?us-ascii?Q?wUqY70PLEEDqMbCyFsyIRxpwxb+oXduItOpDUIGCtZu3lM3JM5/9S6RcbQKx?=
 =?us-ascii?Q?cEHU9vnGcHRXr1isKctxqjSXhRraQM6/+SlWpocLInekgcR79w8md8TzLR+2?=
 =?us-ascii?Q?jpmRj7ozggo9krjiNUrq6jWhzhXeNnEKTwKTShPLLyGeFXGgc44+BXX7W7w6?=
 =?us-ascii?Q?ZS2LC1PJAcwS8irHVY/MzcTBoqntT11mrYSm+MYAuS6fFGDF/kiWVYh9ovm1?=
 =?us-ascii?Q?/wdnHksDWCxQpygnZvt1yWyTViJ2wyhqcqM+NKf/orIPxi7TL0qmmQuc4Qo0?=
 =?us-ascii?Q?31pgJtQD7BarUPwLwKfW0zj13P7Hc3s0twnecmvGvKpLZKomrfQdxN21SoEJ?=
 =?us-ascii?Q?2KEqLJ4wFpe0860RcPM4dKGk50Tg5EezXzLuxJ518FpIeKUtzDt13D4+ib2z?=
 =?us-ascii?Q?P6HKCRUvFRnrApYiBl/4RIsLQNa8oo119x9zp/z8VX+Hnf6GvVSOQCq8c5bp?=
 =?us-ascii?Q?SFJkWTYY2NenQ+wAFfTGLYkILkRSjRZcP+JDMcGlo+4pAxiPaH7ntZ1Ao/lP?=
 =?us-ascii?Q?qAZMAp/90tkCIK2fAAPMJ6DyBJexC9E4zbtb+Y2Vc1AkLPtsgsjF3nTc5DUe?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f874aefb-6603-4115-cf09-08dbcfbc6eae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:27:22.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfEIxCD+7SaTJ374G5WHv5pHVwdLe4lp1LZyDJSR6FGNA7eTxG60D4kaKXXynMBtsIB5kOsiJYrFbzZHSKacdcN0pjGeuGogRawg3zE7BLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB4082
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 04:29:02PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > There are at least 5 proposals that i know of at the moment
> >
> > 1) mempolicy
> > 2) memory-tiers
> > 3) memory-block interleaving? (weighting among blocks inside a node)
> >    Maybe relevant if Dynamic Capacity devices arrive, but it seems
> >    like the wrong place to do this.
> > 4) multi-device nodes (e.g. cxl create-region ... mem0 mem1...)
> > 5) "just do it in hardware"
> 
> It may be easier to start with the use case.  What is the practical use
> cases in your mind that can not be satisfied with simple per-memory-tier
> weight?  Can you compare the memory layout with different proposals?
>

Before I delve in, one clarifying question:  When you asked whether
weights should be part of node or memory-tiers, i took that to mean
whether it should be part of mempolicy or memory-tiers.

Were you suggesting that weights should actually be part of
drivers/base/node.c?

Because I had not considered that, and this seems reasonable, easy to
implement, and would not require tying mempolicy.c to memory-tiers.c



Beyond this, i think there's been 3 imagined use cases (now, including
this).

a)
numactl --weighted-interleave=Node:weight,0:16,1:4,...

b)
echo weight > /sys/.../memory-tiers/memtier/access0/interleave_weight
numactl --interleave=0,1

c)
echo weight > /sys/bus/node/node0/access0/interleave_weight
numactl --interleave=0,1

d)
options b or c, but with --weighted-interleave=0,1 instead
this requires libnuma changes to pick up, but it retains --interleave
as-is to avoid user confusion.

The downside of an approach like A (which was my original approach), was
that the weights cannot really change should a node be hotplugged. Tasks
would need to detect this and change the policy themselves.  That's not
a good solution.

However in both B and C's design, weights can be rebalanced in response
to any number of events.  Ultimately B and C are equivalent, but
the placement in nodes is cleaner and more intuitive.  If memory-tiers
wants to use/change this information, there's nothing that prevents it.

Assuming this is your meaning, I agree and I will pivot to this.

~Gregory
