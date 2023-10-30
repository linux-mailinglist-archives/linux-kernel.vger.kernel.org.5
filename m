Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4087DB281
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjJ3EYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3EYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:24:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DBCB4;
        Sun, 29 Oct 2023 21:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCKFkpnbEKwHwotqYvw8jPIj8t4KsGb5jLxnw/xY9O7cmrRRCDjJkHNCw2rDfmyTeNAs8ob2wdQAjOjZVTcgtHTuul5busCDjTwYZufCZ1l/NoPWKvak4agupWzVgRQOvEgsQAO1WCghoTrGblBTLmG/rHgD2Dx5JyF+vjF99bRLvMZxcfrsDWPDNqanf0RC4tosl2UNJethhPtDC2w2lQeyaquKqH7dkzHE9ThpKRIQB8NDEn5UTDCe9tbJr+m0wCRNL+oSwpFftm3LLjp2nv+DGz/R1EBvc3MoUV8OJRTK+UsOAPIsq/g0eKIs7uHMm/LH6NJg4RP3nD02YX3YBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ9LnQ+uY3eBG7M4nyDlMzv2l2lTUtyumg2o6d1ZBVM=;
 b=KebdP7VANGDVyGraj6ybdIcFFCGFzzOCwdszwGKzjhwcP4wGksHji16A4mBoU/AoDTH5JpOYvsWSPmf9wElKAH9yXgamWm3eIginP9rz4+mx5RphpqbxI1YdBD2Ru/zLSldEg7NBW2/L55fr8XIg9lV6Ua4IqqLpvMIxxiT43DvDZUym7jV5dypknROziB2rQvsJdJvCv4Ku6eXse8z6dbQAgBpj4aOJ7TIOIrr6ayWVfpHa+EtxM/qOSHzW//5r7j+89s/iMT6uyDvfmh8/ialYJoU9OuaqiU8xbBd5yyOkose//X2allhx+Cynfnxtvku6Lw59wbHHuVs+j5yXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ9LnQ+uY3eBG7M4nyDlMzv2l2lTUtyumg2o6d1ZBVM=;
 b=KaysYbuhXkHBDUULv4YuF7u9h7HYmM5J5WDi+pEvJow44P+cj+qdjLrZn73mOa1j3rvOJss66N+hrC6dXoYZ6ahzvfsE5klXaL9MPDOdgZD02h1PJAmWNeQ7OWeDFFh5sicDxTBxlvRAZAXmDk99CjJpv2/Pg0wNkk0lZiMyeAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4683.namprd17.prod.outlook.com (2603:10b6:303:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15; Mon, 30 Oct
 2023 04:24:36 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.015; Mon, 30 Oct 2023
 04:24:35 +0000
Date:   Mon, 30 Oct 2023 00:19:39 -0400
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
Message-ID: <ZT8u2246+vkA/4F+@memverge.com>
References: <ZS33ClT00KsHKsXQ@memverge.com>
 <87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS9HSIrblel39qrt@memverge.com>
 <87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZTEud5K5T+dRQMiM@memverge.com>
 <87ttqidr7v.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZTfjqoEZXQWs/rxV@memverge.com>
 <87lebrec82.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZTlxxR0ntEzBPwre@memverge.com>
 <87a5s0df6p.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5s0df6p.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c2affa-9940-4f34-2548-08dbd9001f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znZH7VAs9KZd9eYJGIFOoLDT7D1uipMOF+SyINFrahTWpNzXVBlfmo97IT3DPAM/wsv1G8VKO5r2azDGj887hwWvb2LgbX3niL2bymsuAbFq5xy4eAU1i4NTF8EckFYPIAv5zmhAROdIcgQlpUJ7EIBY9GkS4RDfV0TIG/xlavw7f4Sw6GA7Bj3cg6rcY4j9EmonrL39ko4MflaNOHpzrE/Gzq86/OemB2109a1e4dUBFnUeKbeyonBt0W/hJB/1aNdfnBlexRHhDE+khvJQsrHehbXXQhGm/NOJAjbfikzkDYPHh0lppK57wPC6tR5Y08pMZYxDJ6FpM8lObCbfPKxz0U+6+195zGK8GYipvVkmO8yna3TwrjDQyO0gQrvCNOsG8Ru35tohfgJ9w3CxKnFAQD/9BiasbftGwn7sq3xM/JdL9KlArCiL9y02lFf2nyc+iO52wl3H6Nt1gSab5ZJUMDscxyWhVeKJWIiLPK/u7BJlthBU4iYHxhFZbfW3zWNn40AGUgbfFLOo5pMtXYCqSo7G15Hprah/UlQTrOQ9kgUgtDIjbooAV4/9bxv2wX7NWYNF42hXn+lqtqZiOMcb79zbS+OMx6XnVMM2Icw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39830400003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(41300700001)(7416002)(2906002)(54906003)(66476007)(66946007)(66556008)(8936002)(966005)(6486002)(8676002)(4326008)(44832011)(316002)(6916009)(478600001)(66899024)(38100700002)(83380400001)(86362001)(36756003)(6512007)(6506007)(26005)(2616005)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYlhymq8cTF3qWV7CZ4qZEtW8/qv/SF8vOIsneI5FQxfwnfZt6QS1WaP/9qz?=
 =?us-ascii?Q?HnYobMy3FUe/uo+0KSnYD5UZivpbmPH4ADvyHRaZiDtEOidYrW+8DZCN6OsM?=
 =?us-ascii?Q?DAA5zKsHTSnE5stD+1vT4SPWSNBGC5rCsTnf+g2LaYFCyM84Yo7lQ/hlML2/?=
 =?us-ascii?Q?Y6vhjlfqIj0j31DZIDU6rp6uOIHVxGJV37l7bo6pSzi9ZQmd5wH69YuGUcQy?=
 =?us-ascii?Q?fi8Qv9pL6Heg59ORVb88wo518mhJGFHE66tRiDofbQp3f9QandY0YlHNGd+6?=
 =?us-ascii?Q?TvrH+ruqhFaytSsBScj2rQeDZYz5/lMnQqyoGrguMsfZ/oowBzJpfwkoHqd3?=
 =?us-ascii?Q?VXL9HL4o1xDaxhBGMJCIbXLf5wE8w7znxMFjkad8mT8qn1HbNetTKkqPgijw?=
 =?us-ascii?Q?D+uHau3DDrnO5ey0OOpsOfq/eycD5Hp7IA9uR4CibyCmsnJKk0WAN85Ja9lM?=
 =?us-ascii?Q?+CI6VGawq5S+PEZco9V0IkV1bNGfkMQ5uxjrq+9t6Qab/3y/SPSjMHj/I8VX?=
 =?us-ascii?Q?/CJ0PyfPEs2OCFEHJ9M9FKmjArPa5jh3Iiu6tkcuvBhrOj1ZTaIJ/2jnLVcM?=
 =?us-ascii?Q?L3K0XZ53yj/ZZUX0gAvZ3uGxBfxaEtc6s9bpTqtXhKOtBp+CfgVEiQ4kDdmn?=
 =?us-ascii?Q?mBCJ4ZRVu2VtlcGAcoXgRyRRa+7srTXYQZ+lV2bWBWCgG1NkDhiV8g4F/x05?=
 =?us-ascii?Q?X5Q0ORk0XKdiRaMECsiD7vaDfFplrvu331oZsDXomW9l4p4ShFsJwJuEJiwx?=
 =?us-ascii?Q?kqffIdbspOKXLxMqhdPOEukCVS3wWI6/v/W+8v9x8iMXnOAN4RVVK4wtzPGW?=
 =?us-ascii?Q?kUZojeCUpv90sgquWB579QzeZ3JzSC2HPijsiRxQPetTcwxP+MBGD6ZyrF0T?=
 =?us-ascii?Q?up6wiWuUh8WGrNLa2OW+yftx4o3OZY7ezm0xjmewOAzfc5VxIXaq29Eh/AXT?=
 =?us-ascii?Q?moTfPy+XCiRVY0aQ9q0QYa3AGcuwDL13yQ8Pd90mkbNcGOSBOWV5VxBqY1tv?=
 =?us-ascii?Q?C36J3dICASZR562jZ/LD4ZOSIYizN/R/UnESfM8xwrX4s7x3YSFPkZ2+9pah?=
 =?us-ascii?Q?lpRTfzBvRqyDN7eGGqRQmhv0XfFv/MZ3mTjbRV0pVtjmx04z7kJVFNQgi2Py?=
 =?us-ascii?Q?YTj6h7ROqc1yYstCn01hNLL8NZgY4wO2Uzqp8n+eFAWC2aVul4gZEZ0tdYEZ?=
 =?us-ascii?Q?pa469X1e5z1ZCnL7OEAYE9Eh/E73t2DR9uPVp9DbOpGICIVhZIMqzo+BqYsx?=
 =?us-ascii?Q?9B+Zay9jBk6LysmaOE/4sRojXDc6Dd7+/76dIXeX8DTdTt6N2LRHOp9Aat1U?=
 =?us-ascii?Q?z/wb2lKQ+uNry8Qko9WtZmh/cNQtkwHcMxgruex6HH7BlT6oK+tZYE7CQ7/Z?=
 =?us-ascii?Q?vBcu8LSym3T60PDgw8KbMJ1zMrA2zujvOWusMrq1rH/gKZoxi6xVCh2LhVqD?=
 =?us-ascii?Q?O/GbTz2xmJvk7qAPNfFxogOsye4IEwrlFegblGHYHG9IzS/tBqPLAlhQ86TF?=
 =?us-ascii?Q?1M7HR5uQEVwnBALe42pOI2QSCjhp3MGPsi+OQU6x4KpX2WVUbk6CWpW3kwKq?=
 =?us-ascii?Q?DPXtd68jlBAWOKAqNMMjiHCJkbW+yVh0+n2OSnjLecGzlQR1AqdUDa51PYbn?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c2affa-9940-4f34-2548-08dbd9001f70
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 04:24:35.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wegk/qus82kCUDx0QDQzVXXKSIjHdHbl3uTs9vGun6eTx4HL3qGzyEgdfnn/Y7Cn0Mgce4qbjLZ3aaiC5BECFWINs04z7mZayOoZ1VfD138=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:20:14AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> The extending adds complexity to the kernel code and changes the kernel
> ABI.  So, IMHO, we need some real life use case to prove the added
> complexity is necessary.
> 
> For example, in [1], Johannes showed the use case to support to add
> per-memory-tier interleave weight.
> 
> [1] https://lore.kernel.org/all/20220607171949.85796-1-hannes@cmpxchg.org/
> 
> --
> Best Regards,
> Huang, Ying

Sorry, I misunderstood your question.

The use case is the same as the N:M interleave strategy between tiers,
and in fact the proposal for weights was directly inspired by the patch
you posted. We're searching for the best way to implement weights.

We've discussed placing these weights in:

1) mempolicy :
   https://lore.kernel.org/linux-cxl/20230914235457.482710-1-gregory.price@memverge.com/

2) tiers
   https://lore.kernel.org/linux-cxl/20231009204259.875232-1-gregory.price@memverge.com/

and now
3) the nodes themselves
   RFC not posted yet

The use case is the exact same as the patch you posted, which is to enable
optimal distribution of memory to maximize memory bandwidth usage.

The use case is straight forward - Consider a machine with the following
numa nodes:

1) Socket 0 - DRAM - ~400GB/s bandwidth local, less cross-socket
2) Socket 1 - DRAM - ~400GB/s bandwidth local, less cross socket
3) CXL Memory Attached to Socket 0 with ~64GB/s per link.
4) CXL Memory Attached to Socket 1 with ~64GB/s per link.

The goal is to enable mempolicy to implement weighted interleave such
that a thread running on socket 0 can effectively spread its memory
across each numa node (or some subset there-of) such that it maximizes
its bandwidth usage across the various devices.

For example, lets consider a system with only 1 & 2 (2 sockets w/ DRAM).

On an Intel System with UPI, the "effective" bandwidth available for a
task on Socket 0 is not 800GB/s, it's about 450-500GB/s split about
300/200 between the sockets (you never get the full amount, and UPI limits
cross-socket bandwidth).

Today `numactl --interleave` will split your memory 50:50 between
sockets, which is just blatantly suboptimal.  In this case you would
prefer a 3:2 distribution (literally weights of 3 and 2 respectively).

The extension to CXL becomes obvious then, as each individual node,
respective to its CPU placement, has a different optimal weight.


Of course the question becomes "what if a task uses more threads than a
single socket has to offer", and the answer there is essentially the
same as the answer today:  Then that process must become "numa-aware" to
make the best use of the available resources.

However, for software capable of exhausting bandwidth with from a single
socket (which on intel takes about 16-20 threads with certain access
patterns), then a weighted-interleave system provided via some interface
like `numactl --weighted-interleave` with weights either set in numa
nodes or mempolicy is sufficient.


~Gregory
