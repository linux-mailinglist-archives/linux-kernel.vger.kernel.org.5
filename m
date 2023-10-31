Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4647DD397
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjJaQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjJaQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:58:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EFE769A;
        Tue, 31 Oct 2023 09:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxZLTqYFiR/JTDbpKtPNHsNu1i8RoX11SBnkac0P1bLOL+JGOYTqNyAQH4sdkQeyRvi+Iyi5qtTbzg9VIOmQaDZQ6uSCkfASYbmMTrUV34eK5oLX+rtQXPh2G8fDJ3D8wdyOGcEWkmwrKy3A2OUZYR5qUiYNXZ+14qh1T6Qz4BlZWMEbLe2EAc+QgBOgjx9Aey3t2DUPRqA2DL9pjW7SfzT7f+WobMg6SpDAe9mhMVZ+53uyi0T4U3OQYgmXbvx+d8CRdGz4iy3ng7bgWtxECVO2IM7XjhgjuuuRIjSlsik/bazDvTzlCdtMdV1qgQzbvQASCbRnEdkOaJ/cnN75fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msg+9xgAdhPpoLXLzD5dP4hmfxNWB7eIUNanfQoyTok=;
 b=FejL8XAkWQz+j9pL/AE+Q3yHgo2Yy/lhk6r+BerpoI6gakRRSo1B0uQkQ3kz3P035RMl89otCEpBSk8V2xfqYmDcDTTr9V7uekJSTe4oDTBNZiqnVXfQWsqTsT8kpWIEa2y8YbzB2yDiY7akIP7hSpYN20K+Vw2obzeEA1noBZjGp2gRB5StNzHHBwqv7sSYn0BgqsJI0zCDEfsMgC2YHEjWyggLttDMqcGMpSzNP9xKYz4BdByQr4xkG6zd5hmwguVjCM+sXvF7fBJDzYgXqMDBKACZSKDrfLLtELPNJ/v3e3MMrTZNIumT3vSMLbOwPJHMWK8RIRF1tH+6zZPEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msg+9xgAdhPpoLXLzD5dP4hmfxNWB7eIUNanfQoyTok=;
 b=Is2Vstn4rnConKfMdSY8ZnmjycGoVq6nyVs6DDUWZlX9gvBow10z2ky4V9H3axbE4A2NbdAjiAmEQUMIIezU6ee7TrSO1WTIySl41h3qQ2yHX5M9gLdTHx4elybMFqroNwT+sijWwZjm5nylPEEt6pz7mQ8LgLmwGt8RDyR1M/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB6476.namprd17.prod.outlook.com (2603:10b6:a03:4d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Tue, 31 Oct
 2023 16:55:53 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.015; Tue, 31 Oct 2023
 16:55:52 +0000
Date:   Tue, 31 Oct 2023 00:27:04 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com,
        dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <ZUCCGJgrqqk87aGN@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bba189-a97c-4c83-b2cb-08dbda323deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpPfL93qpAcTHwJOjv4IZKVZ7pLRdDKhokM8KSS9pcTnTVfD7u2ziIwSG9uB5+wc95TyIgF1mGEXfq7PatjrOsDtEyoVGr8H6WPMtIqbjjEf7rsv/uFytKWMheKa/fv0wT1WocCnKOE3UlfXgeSUE6WdAuGUsmR7ua1iSEVADwpCKf8wtUlkO5JnBa8qKjmHbeMbDhsYEU4Dmlv+zbbbYxHnkmrQszib/hPNQkY+arfcTl1QSTJYLLfECcCTvpeQKy1e1kkDprozvx+wq5rqoX6wlepulaFQFDrPNY1Mt9rFj/KT8MINBOltugxm+FS+Mk7T5XsQNzu/jznZO0op9QjwYAvZoVZmLJSQHTc2Fbdv0WcHaOa1t9quEpBYWmOmyExqHzsQYC4xUGxyQSkd8WNurEAs8lcl4s4riBkmiolhkwJsMoRvA5TVu+atXXK8DgeTPMqoDuuhPvw2krrGkr8ryKQhW+Etitfb5L5FYqBf6wv5GLqFY9uKv5T3hGftvg5eqw+k8agF/qUL6hdYVX2hOWmpakijJSOizr6nS8ZXRPKw61r5vjsEq4VPHLiL9u5O7M4b0jxfansyZhTlPq+gA1yZlfk0lb2HSi0dkbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39830400003)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(66476007)(66556008)(66946007)(2906002)(966005)(6486002)(6506007)(6512007)(86362001)(36756003)(6666004)(38100700002)(26005)(2616005)(5660300002)(6916009)(41300700001)(478600001)(44832011)(8936002)(8676002)(4326008)(54906003)(316002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6hHyL5VmSw1thS7sWgdCFikJH2JWIP7PHDo6rocPvNxisnsSGa46+VqPa6c?=
 =?us-ascii?Q?RomZNsHUtLFYqxUZ+w0YUnvO986mTg2gQFvpSFbKLOCq/Uy5bC8CVCkJ6Dzq?=
 =?us-ascii?Q?lFz66qtS1nrOWBChCI96Idh2X8eV3yV4zuLeiE6lIOn/khkCinRcR29eM8R4?=
 =?us-ascii?Q?qDLXpMY40Lx5prOhJ5hWrV70IQaBvNMVZF29Mr97VuCgP99H31dbTtNjXG5d?=
 =?us-ascii?Q?Mtxk4ZDr66Uvz5GV9ZhcjiZGNov5Vu2qSB5InfpniBL3ZTzNsYIywftSWITK?=
 =?us-ascii?Q?mvnpE6vTY1Zm9NmJBjIZhM+Y9g8bPL1BSgJf4IsqasooaJMGvLx5c/EFKHCn?=
 =?us-ascii?Q?aZyZdiZMQTDeYlxyBLFLMui+jitN9Y8/4RY2B+x0rujmq3iA+nzP1gKbI7Nl?=
 =?us-ascii?Q?VJgirsucLW2c2CL+d39l+PvmU0sw3cqBRaefIja9DhoXJdLqKr+ExLBcSnYj?=
 =?us-ascii?Q?0G9kZJtBf79WBiIljUhX/lXdi8llFuJrHj3V0xYnwbM2ohEc2+f2G6gbL2P4?=
 =?us-ascii?Q?7te5XkqP9mCUa2ZbJhQfq7ibuo+C/l8h0nGat1Fztd7ee0GozBCjbE0djfpb?=
 =?us-ascii?Q?ADm3OboRFHBNbHKtQe8hLcvb7Zqd9/SrpnvbLma8r+zKFGx7Bg+IP/la+Tf0?=
 =?us-ascii?Q?q2UHCkI/kr/uLulJ5xVvSAoVopNC3EHD16f+zbxpuepjBAUyYu0H6ccOd3Oj?=
 =?us-ascii?Q?o3bnuOWQfspHH6eRDfDfUSWjhdPgK5zPoPMo3ywLlw4odwcvrYFK06WJcKW8?=
 =?us-ascii?Q?H8YLPA3OX7pGOJT5srTNhYMM5mhPlVkoU0PrYHlscKc8MVpbJcSgQvhc3zhD?=
 =?us-ascii?Q?u55vVPkoJkWtD9C3q/uQl6tLlaMI61rflML+S2rBs+CX8C91eMahy65po0zq?=
 =?us-ascii?Q?A1QbPhrbrKlqY2fVEzdksE1qVF1BMHuY6EjM/21N2tpi1pG+DtUD1se9MPY1?=
 =?us-ascii?Q?grxLL/rAP8s8LeQYbipC3V8E11gxC0nU0gPY3K371q1lODXdKnPJg9LKz/le?=
 =?us-ascii?Q?YrPJqEjKPXLKXVMry4YJ+CfV++GwB0DsD0CS8GlWTsbKkUXTtkgxFDugmP35?=
 =?us-ascii?Q?I27vh+91K6uJ/mraMOQne4S9SI34IZNqn9bBhxnSlGzGgGzb3DWYfE7AHeWR?=
 =?us-ascii?Q?e2fK4uVknihj8LPlxztnnXhMtIQIY2u8pOjwy6XsjwT2jWDA0JNd/fjgDu9j?=
 =?us-ascii?Q?trCSbyG0Yt7QSc/xp1xIOMXzqeSQBZq05zopDD0cyXsaRfGficIC85PzAVKZ?=
 =?us-ascii?Q?jsLoaqn3nmg2LtM0wbWHoB/tdMRDYp8pK1ksjl2WklF+PHThlbhVyblnD36M?=
 =?us-ascii?Q?6sIhD/Tc2+9NX7oCoInItlVKUHi4KUEVuB3a/bBzFXdkPr1MrkXmpNlDDzTV?=
 =?us-ascii?Q?1Sh8holsnIG856XkYvevts3fOwgcsg6sKas2a6gmyMDHcJqMWWFuf7+EJn/s?=
 =?us-ascii?Q?xE1BXl1mHbvBpmxDs4zn8rtVrXgI1r787ROfHn8DEXwfuLOYW+Ad3BegRdGt?=
 =?us-ascii?Q?UVSQkOzyywttgy+Yg0mBozqMZ/CUZh1NJWDIRpxX0oWe6EswPyLI6EuOd1W7?=
 =?us-ascii?Q?3kRB6PbFFtmNPBnxq83wRLs1FGnkt0KrGj4MNy8qUdhGFn6lC3l8wMAjElld?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bba189-a97c-4c83-b2cb-08dbda323deb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:55:52.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XLH9BpTeoolzLPk/hwzHl00RS26OIsOFZYXuEb11yO+imrV7Stm0Xu+7GkVZ26wCf1TQmDcQMiJ475gOarG64ZOfH4tVFLYaOQMzQkAg9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB6476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:

> > This hopefully also explains why it's a global setting. The usecase is
> > different from conventional NUMA interleaving, which is used as a
> > locality measure: spread shared data evenly between compute
> > nodes. This one isn't about locality - the CXL tier doesn't have local
> > compute. Instead, the optimal spread is based on hardware parameters,
> > which is a global property rather than a per-workload one.
> 
> Well, I am not convinced about that TBH. Sure it is probably a good fit
> for this specific CXL usecase but it just doesn't fit into many others I
> can think of - e.g. proportional use of those tiers based on the
> workload - you get what you pay for.
> 
> Is there any specific reason for not having a new interleave interface
> which defines weights for the nodemask? Is this because the policy
> itself is very dynamic or is this more driven by simplicity of use?
> 

I had originally implemented it this way while experimenting with new
mempolicies.

https://lore.kernel.org/linux-cxl/20231003002156.740595-5-gregory.price@memverge.com/

The downside of doing it in mempolicy is...
1) mempolicy is not sysfs friendly, and to make it sysfs friendly is a
   non-trivial task.  It is very "current-task" centric.

2) Barring a change to mempolicy to be sysfs friendly, the options for
   implementing weights in the mempolicy are either a) new flag and
   setting every weight individually in many syscalls, or b) a new
   syscall (set_mempolicy2), which is what I demonstrated in the RFC.

3) mempolicy is also subject to cgroup nodemasks, and as a result you
   end up with a rats nest of interactions between mempolicy nodemasks
   changing as a result of cgroup migrations, nodes potentially coming
   and going (hotplug under CXL), and others I'm probably forgetting.

   Basically:  If a node leaves the nodemask, should you retain the
   weight, or should you reset it? If a new node comes into the node
   mask... what weight should you set? I did not have answers to these
   questions.


It was recommended to explore placing it in tiers instead, so I took a
crack at it here: 

https://lore.kernel.org/linux-mm/20231009204259.875232-1-gregory.price@memverge.com/

This had similar issue with the idea of hotplug nodes: if you give a
tier a weight, and one or more of the nodes goes away/comes back... what
should you do with the weight?  Split it up among the remaining nodes?
Rebalance? Etc.

The result of this discussion lead us to simply say "What if we place
the weights directly in the node".  And that lead us to this RFC.


I am not against implementing it in mempolicy (as proof: my first RFC).
I am simply searching for the acceptable way to implement it.

One of the benefits of having it set as a global setting is that weights
can be automatically generated from HMAT/HMEM information (ACPI tables)
and programs already using MPOL_INTERLEAVE will have a direct benefit.

I have been considering whether MPOL_WEIGHTED_INTERLEAVE should be added
along side this patch so that MPOL_INTERLEAVE is left entirely alone.

Happy to discuss more,
~Gregory
