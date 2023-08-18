Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D47781017
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378542AbjHRQQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378583AbjHRQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:16:00 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2092.outbound.protection.outlook.com [40.107.96.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED293C04
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0kA5oTx96O9hQ7opsQ10o3mFnhVOlhjbtaAI+b9v7k3rbgzeXvmbzCowp+zek+VLHTzg/oBNs076L0F8Z2pq6hWssHR6KpouxWnY/SKMbtHcUgR4uPeIkV3I/3LxfFPlTMhlWKEPV0j1w2aD0fCG/4MiNusKenaVawjNJ4uRhPOsYKTyKn2uBl+vChXBYBwnsLk1mrCbQpbvCh9APn9kOOYyyV4X1PNR6DPZDPRMqcPLmsEUsXPCGbpx7h9R+9fcR1uVTCV/CeVrAqnaUVv/i6HoC2xhfWDT3KH5h6y6aEVD/GaNxQgS+irmfKArxS5tTjIGLnYPV+7NVAtjm+Beg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfpeB5e370EHjRPrN6oc39mk34uTPRd7rKSZijB2buM=;
 b=L0BjzzZ9gehg1RXB45yWrNYlahtG/fl2Wy6S/L2LsU2UfgrG/qpnwYzFseEQkX1UKKLdLinj36PJXcD/aHnjFin3qqQIP2KTS78VcDsuzxvvXF7LIe0NNAxeusnq/S+UBzSRjuEe2L1RPAe1yeWSeOdgIHMO3piQEQSywwIgyl9kjCOFUHe6kv+K+7uFUyitQhZjeNXHRymwFuLgPtyMgljviRhx098YA3W21dZR9Icy4xlirJN7FW/eW7GZ+wAtYci3KhfoVNXbjB9dComlZr1TCoGmOgdDIBDZ56WuppAMe7HzKl1CgKhKPNC3DKNs5jmX3a3zgj3IZfdSxFqBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfpeB5e370EHjRPrN6oc39mk34uTPRd7rKSZijB2buM=;
 b=coOK5dAowOzaeH7PvftPNOtyhVVMYqhO+s2IhtO5RMpW/xMr27zxYZuZSyKMUpD+b4QY5sYGWN3y6/OPRd/fjO8iXELWxqJafU8gyAKF3bZPkpAWESUpDk0tIJYXEOJwsyFhYe4sohlq7aYp4P3hlhn/aE1EQo+eVovY3GGC1+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB4780.prod.exchangelabs.com (2603:10b6:5:6b::16) by
 CO1PR01MB6774.prod.exchangelabs.com (2603:10b6:303:fb::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 16:15:53 +0000
Received: from DM6PR01MB4780.prod.exchangelabs.com
 ([fe80::1f9:1d97:19f9:40b7]) by DM6PR01MB4780.prod.exchangelabs.com
 ([fe80::1f9:1d97:19f9:40b7%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:15:52 +0000
From:   Carl Worth <carl@os.amperecomputing.com>
To:     James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc:     "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        Akanksha Jain <Akanksha.Jain2@arm.com>
Subject: Re: Initial testing of MPAM patches
In-Reply-To: <86bced4f-06c1-73de-9aa5-bb23998479fc@arm.com>
References: <87lee8l9pb.fsf@rasp.mail-host-address-is-not-set>
 <86bced4f-06c1-73de-9aa5-bb23998479fc@arm.com>
Date:   Fri, 18 Aug 2023 09:15:48 -0700
Message-ID: <87o7j4ba2z.fsf@rasp.mail-host-address-is-not-set>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:610:33::10) To DM6PR01MB4780.prod.exchangelabs.com
 (2603:10b6:5:6b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4780:EE_|CO1PR01MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b70b17c-2334-4cc7-d2dc-08dba006645d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+YBSJNkDKDh+8x+I36dqaY6ew57Q8kyVRldcYJ5S3R2wRZDXFjOY6bfjXJOefX9h+gNvJs8mPARWXNx1Z3acF93atlLNHlec5DLStC9QX5OiVXOvz493Vs7ZnUDFy42ZQDnK2i/7l3tUZ6IAq5mVtGxkCTVF+9K75h7T8hBHHSHxPJcWga8lHmPF4GsRVpbiyFlub0Si2VyJdQyNLP/RTwTZRcf8PJsfoTma9FNPTTyRVyohBkd/tbEWz6GW57ahOx7XNJ+5IwMixRQ1mMCgVK/64kfQNLP/hjj68hbd+Y/Y9OVlieWVGJUWE0h0qR2whyah5ecDgR5VE/ERWYTj1E4rjyRNeZ6BzAlvQo6U0ZUH69K8ZgdKjqn5D0WB/gJbgdccpkR7lIJUUsgWMt12AeSU5L0/aVNOG6s9iYWtP6Md808onDN48P/5Hyg9UvCOZAh/pVNeLS4Q3da+Jp4IuIwL1ZFtLwBmA12iHRexXbxuA4KWnq+PhwUc+yBrGtdT8lfgBhOIhBzurRSOL30dX2y9qwzMjSqsfj6N4PnFKzl595HN0jURtCh7e2STNZ9p+a/vzc/wyQTHVbM0ibS2jUR0ht6AYomyqwxdDEai9dJr6LXBY3ZLh3U+R+YT97F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4780.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39850400004)(376002)(186009)(1800799009)(451199024)(86362001)(66946007)(54906003)(66476007)(316002)(66556008)(478600001)(41300700001)(38100700002)(38350700002)(6486002)(6512007)(26005)(6666004)(6506007)(9686003)(53546011)(52116002)(4326008)(8676002)(5660300002)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FccUyN0FGI5rQvx/3ac8iIswZ2LJUc+KEYGk+evcsMcINGmb3x1QEkupYq5K?=
 =?us-ascii?Q?fiIGdTNKpROrFyBSnEXo3frzUbJvnraUEdxv2q9WS536sUbo+WcUjlsW/kC0?=
 =?us-ascii?Q?k6bfjftZt8+L9Ict258wQEMxqSsRI70UzqfyGDo3GD/AWrnvogDxbtVv1Nt+?=
 =?us-ascii?Q?fUFht19lBZ2YTyz9Q1yFy6EYXvT6zPgY5lGnm22U60L48CxgLTDcUO8i6NIh?=
 =?us-ascii?Q?NFl73GPwV2HP9bKkeKUm6VOvnr2WQ7zvRPIYOI26TPZuPKYDix7+ZCsO3+R2?=
 =?us-ascii?Q?ckzmopqF2//BEd9oyq6Z6vksNmUwaNAQ47uv/ZWfuSpglawL4PCU4/shDhn/?=
 =?us-ascii?Q?oj1sHphxQaqDdV9GkZnDwIR4Qb9mSyrPBL7gNimA+qPVG4v7FlFIUmUPCh3+?=
 =?us-ascii?Q?xbJpsUlhxpGGVAPWpP7ABCbcD+8WKK42sQI6BzcwDzMfyFgfU4dub8eTqbR0?=
 =?us-ascii?Q?Za773m6KutH2oHg6rKH75ehpo7VVpP//5HkmFw5qgIxwF6KRuK6wrGIy6kYh?=
 =?us-ascii?Q?JSAEEZg8/zej9R71R/0jeurmTLWl17XSVO9UXEmQm2QnWC8tAVbSEuB+rgmH?=
 =?us-ascii?Q?u47uZvJx1PocwIIkmjnTa2cBg76TYVc3+jTyf1QZ+OmyGDK34SIdLXRKhVzB?=
 =?us-ascii?Q?4xLqzn+cj+N0aMeL/iHnVpE3D1qc1T99k3Mj97dJX4ZxXdpgxgwm6yz6N3wG?=
 =?us-ascii?Q?QDrx4eXpsA5S+lNEMTWvjQq26WWWspx47Jf15fYsrSjGKe4LqvQgme3pJQd5?=
 =?us-ascii?Q?38F8fHqTUHXJQv0HWj2YKJ3s/hY4FvS+11YqCKVsE3KdDT0cKzdWFs8CXjUH?=
 =?us-ascii?Q?2FPPBHX3ZVZ/BUhZzfX9ExmjopLtHqJUErue2xjgHPtznlfRplYk5tsJLKa+?=
 =?us-ascii?Q?YDi4hRaHyZQywTcumiZbCBoVTqejfGC28BcvOqkFR6Bvw7b9J1giRAm6eu8/?=
 =?us-ascii?Q?acTRBYYN2S0x5k8RzS7IIEp6fD6TA5tWjioToBJoG7Jc74+N4sdrPLda2qDt?=
 =?us-ascii?Q?XUexG5SAn10kHya4bBoOOaQykLPzHq6Esj9mWsdbXpGEM4Z+JHxAbUIkEA/Q?=
 =?us-ascii?Q?E/75D2++HLNvfbefTGMOi2wfTf+motCm2BuqTPMcZi4GlkvwVg08S0J3/tXe?=
 =?us-ascii?Q?0+RnK9bGM86n20T+KO0RwS5ZyeooQJpL3He/juOb3EeF3YQXTb23RQ/8U2Vn?=
 =?us-ascii?Q?KD8KzCtc8EB8LnCnD1n+kNnHr63e4IMAbA9mjRJckroAM80LLCbtHnrvPKc9?=
 =?us-ascii?Q?rbFkpYbLdMG0+X5s0xffL5I76sX5UrbPo3umK7utUbbGlVo2YOQ39WK19qTb?=
 =?us-ascii?Q?TapaxEJRXmj+OR1staMwWxuF85m1ZEbFrUN94brgfu/iIad8BFiVWLuhEUGd?=
 =?us-ascii?Q?Hp7uNjBo72K5rzfTQcrZWlR5jqvKMZYttQGiqGXQWInWzm+mcbsC/c1MWoy2?=
 =?us-ascii?Q?8OW7swV3i/8ZEmEiwwXIzLwv0qdRWYfFbWW1hQom8J9Ye36nJYY04uVUdwZL?=
 =?us-ascii?Q?fkzWO7qg1xjJw3UJ3UJcnK6pmVDwT2Jprx4ku5gmrKvihESBXeXQuBWkXa9h?=
 =?us-ascii?Q?Sh+e+fNBCU8oCIrTCvBMXn4AWVoC9U6gRjtpMuGDL/qJAEOD1hOHXXK+mFUo?=
 =?us-ascii?Q?fB9NqCpcGrPE/aIBc/qAH0k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b70b17c-2334-4cc7-d2dc-08dba006645d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4780.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:15:52.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgs+EYm+chLE71TBFcjc9EbYSH2/iXHjG0m00Da6EaNbiPujhwge6TlYYXQivpGOO74u2wym7RMKm8rNO4SNaTETJmPUPRlJaIGtrB6y7hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6774
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Morse <james.morse@arm.com> writes:
> On 18/08/2023 15:13, Carl Worth wrote:
>
>> 1. Is there a way to query the MPAM PARTID for a particular resctrl group?
>
> Deliberately: no.

No problem at all. Thanks for the explanation.

> The general theme here is I don't trust user-space not to depend on
> any value exposed.

Fair point. I appreciate it.

>>    I don't know how much an end user will care about PARTID values,
>>    (so it's nice that the driver manages these implicitly), but for
>>    me, while debugging this stuff, it would be nice to be able to
>>    query them.
>
> This would only matter if you could somehow inspect the hardware - which you probably can.
> - but users of deployed systems can't.
>
> Sorry if this isn't the answer you want, but I'm trying to only publish patches to
> kernel.org that I intend to upstream in some form.

No, that's fine. Like you said, with me doing bringup, I'm in a special
case, and also like you said, I can hack things to give me what I need
in the meantime.

>>    I know that PARTID 0 is treated as reserved by the code, but is cpu
>>    0 given any special treatment?
>
> No - can you reproduce this on the latest branch?

I will check.

>> 4. The current schemata allows for cache portion, but not cache capacity
>
> See KNOWN_ISSUES:
> | Only features that match what resctrl already supports are supported.
> | This is very deliberate.
...
>>    Is this due to a limitation in mapping MPAM to the current resctrl
>>    interface?
>
> It is. Getting feature parity with x86 is the critical path to getting this upstream.
> Supporting other bits of MPAM can come next - we'd need a discussion with Intel about how
> any changes should be done, so that they can support them too if they ever have similar
> features.
>
> This conversation can't happen until we have some support upstream.

Got it. This approach makes sense to me, and it's good for me to
understand what limitations exist in the current implementation and why.

>> 5. Linked-list corruption with missing cache entries in PPTT
>>
>>    At one point, I tried booting with the MPAM ACPI table populated
>>    for my L3 cache, but without the necessary entries in the PPTT ACPI
>>    table. The driver fell over with linked-list corruption, halting
>>    Linux boot. I'll follow up this report with more details.
>
> This kind of thing won't have seen much testing. Any details you can
> share would help!

Yeah, I figured as much. Since I can replicate this I don't think it
should be too hard for me to give in and root-cause this bug.

Thanks again for the quick response. I'll do my next testing against
more recent code, and I should be able to follow-up against some
specific patches for the couple of bugs I identified above and that I'll
look closer into.

Beyond that, I hope to be able to provide some Reviewed-by and Tested-by
soon.

I see that you've been going several rounds on the earlier portions of
this patch set, (the parts that refactor resctrl to prepare for
things). I trust that you've got that part of the process in hand?
Otherwise, let me know if there's anything I can do to help with there.

Again, I haven't been looking into details of those patches yet, just
testing to ensure they work, (and so far, the generic parts of resctrl
seem to be working just fine for me).

-Carl

