Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD447A235B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjIOQOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjIOQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:14:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09ECC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH34Hayc7g0NSvvAZV6VqOlre5f7GcUQUraSUZixFwesJJTafqi4Gc4+syOPPCd3ON5g8jzemGOwi1uZqSnxvTFTE0a3h45opKyCDpUScVeJQJOY4NkdeqQwZR8jEVtjRn/ACyDW73hNAPcOwASoS7mXdpUFdL87iclPOfSAZb8q4a+ba/pJi2PDoLz2j+WTtX5i8lpqbpRuIKusCERyVfFhxH8+OcutaalAdATlUyYOGIDHQR/ovXJTXU88MyMvhHUHs7QKiuRjofdOTsT568U29iyLrR4/xO6J2wFfVZKo3uZkOq+zGxi++o/mpZbcJgtdUXHgyOO7uU6oQ57Ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grzkt8Ohk9KqrjXBgqRmoGEoVq3XH5jNKN6oaQ47P68=;
 b=L0O2ekMazskK3faJBo8K5VfZacVrQOeGpunQsVrrz3PQ0dIvSrzIumOmDnZe8aMuaysqr4Fcz3/qKnMIjslVDPVGjYK9O4Hy+hjJfU9ETkgry3p30wFa3x8B1VWpwNTc9Tl3MuEQrnafaVd8udV9y3/SuGueV08+HxNx7AeGXcTHDmXd5gtmlv/2H+xs7S/H1SjWIFRxvGjt0SMEMWx58rnEwyvrmPP7peZx9YPdxZKKGMbrsewwhIl6QcsYGvHeV+tj1PeupGDtBVgykStrSm+iW4bKLAH9eMBtZrmGK/liomoMh36iVDBElvJ+S8pi+Q4mbdSQq98AScxCiB0+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grzkt8Ohk9KqrjXBgqRmoGEoVq3XH5jNKN6oaQ47P68=;
 b=uaywm/cPDir4kQXTUTaFWl1tXkt6l0XEji1igh9dn30WU5V/oodlNrFrPH3rvHtYDb3q2CCFD6CBRW5oHeuSrj5C4X6mLhkeJmlNSto5qS8tXCUPiIIvnBAdK64UP/GbFeTe9Uy1RiJ5+7BP7h8AaghZDVsW9dOQF0pbZzyRXwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 BL1PR01MB7602.prod.exchangelabs.com (2603:10b6:208:391::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 16:13:53 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::66e5:a568:4a5b:c19a]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::66e5:a568:4a5b:c19a%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:13:53 +0000
Date:   Fri, 15 Sep 2023 09:13:49 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     Feng Tang <feng.tang@intel.com>
cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch 3/3] mm/slub: setup maxim per-node partial according
 to cpu numbers
In-Reply-To: <ZQPmFcmaRSrbK45H@feng-clx>
Message-ID: <830be645-5051-1be3-f632-57a77dbf150b@os.amperecomputing.com>
References: <20230905141348.32946-1-feng.tang@intel.com> <20230905141348.32946-4-feng.tang@intel.com> <CAB=+i9RWVvUb5LyoTpzZ0XXWoSNxbKJuA6fynvOd4U+P5q+uaA@mail.gmail.com> <ZQKwu3TrorCvgH9b@feng-clx> <21a0ba8b-bf05-0799-7c78-2a35f8c8d52a@os.amperecomputing.com>
 <ZQPmFcmaRSrbK45H@feng-clx>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::14) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|BL1PR01MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c970996-f617-408d-5684-08dbb606c182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdeqZAkln2BWNeXwAXq+C3z3jfDV+1wzsM1ZkAqrRSVV1Pe2y3bdozsNNAX9goRwm+jRDVN4/sr0aDofQ22DO5UTc3xA6p5HsMYHlZZWyY+ZY+GaozlBUp35fCUCnOQediw+gqlbvLdhwRB0Tbmq6E4NT1ZzsvzdJI5/v3xiF2JFKuCxNxdyz+MQ7J62rMYiu86yucrc56G3uONqSmxZ6Bx0pAUJ+hQ/9aty2Is9oNsfArRBQV7LvTzckryD3F2JFKKbB68fogZJYD/WKuKRJuV/wezNblvXYPUcGcDPFGltmbJ0umCix0c8Cpe+7QUl+aVetouTytXfmEolupM/WjA4V3Yl8Zpmk1r3iH0wTvnA3mYJrJhf82xtxxOh9m9KLZBz/REl+SoagrNm32EZT7NOlJlw/mma9d9CUx9n4qcUqhui+2FlWOHdw/JO+mdYMdmf9Gte75Q6pXAzVg6XoWgq7mclWB8hznipeQJVfrj3Zg//a6B8OcuG9dzTrqq+pCIgaU+gufF1omMo8PY/fw5lYKK3gMz4+DGH5B/CQ8pGTPe2FH8TdT8hoMztxJGc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(366004)(346002)(396003)(451199024)(1800799009)(186009)(31686004)(6666004)(6486002)(6506007)(558084003)(86362001)(38100700002)(31696002)(2616005)(26005)(2906002)(6512007)(478600001)(5660300002)(4326008)(8936002)(8676002)(7416002)(41300700001)(54906003)(66556008)(66476007)(6916009)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xPNiLsKhZFLuEEd0ej6igbUI8rDoyxQrahHxQleLAfVQw0dJlx1+QfHEPS9Y?=
 =?us-ascii?Q?MKOm8gEAEqpJvzEgEU/H5hC2qo0e4aoKS7TuEs7GkbFxkh3VLHdwwQDdn6oy?=
 =?us-ascii?Q?couLfKkPM8TZ8CA6MFBEn3Y2tAsljX8T3KGcrkCz7AW4ctTeYTZVgQ0u6uQ1?=
 =?us-ascii?Q?O1Ryuo3Ab4O1sI8OQlaOpdSNAPuAjwX8EJCxEoRcMncMeHp1fixtr6f60yfS?=
 =?us-ascii?Q?kO7eWmwsyjepeum8mMTk4UirHZ3Oh97wz9nMxLM5bVc8A+bIw+1rnvaOwwZU?=
 =?us-ascii?Q?iy59N2YHv/DzrpoobqXa53JfU8dhvvbFXBzbV1bb7T63tanT93xuO6jusJZC?=
 =?us-ascii?Q?Lzt01VrcI7vlISUGqb6H3bajjYOeuVkKwLvrSQE6xZWNezgOhk8ViWEbOTcj?=
 =?us-ascii?Q?XSVCKnVu4ERBJyjb0mPUshtkxtM+57SrdqXG/hkyXNy7E6w5XBYaqKkihXrs?=
 =?us-ascii?Q?op7TOcmImuOSJz/Ka8aCapOay/C8SQIznL5P4ETQY7HkPIztwwUcRkm2jc1k?=
 =?us-ascii?Q?OuFd8J2pLdvlZBcVai8ymhfdNKjzo3HxKazJwqVz+Gz2YaYUMKn1DNtG/nnt?=
 =?us-ascii?Q?+/YZqEjIP9fzaxO/QBSzqRvGDwr2fcOLtIyiJ4kJu6nFt1zt/MTj6bJLMGPC?=
 =?us-ascii?Q?GOeRK/XJtwZgz4LdwULZLodDkCtT7uyDoICRA52STVc0jVIimjDsC+t1vqd7?=
 =?us-ascii?Q?sY2eVQqVqpW+LjGgYpyd4+uqjrgn+j8FneYmWZ0o0g7T40eCIqbye3fokhtU?=
 =?us-ascii?Q?AlvGJwo0IltGJ9rcU9v2jR4JrO7vp8ag9822OI0vFybzB7ZV05lZAy1Q5A1Q?=
 =?us-ascii?Q?fUYqFF5aFeqJ+srlae4PUaJFyVelSsbylC52t7FTdwPzq0TCrQ8AagcIWf90?=
 =?us-ascii?Q?GRjXYk22mn1ORp/OcOUecrEDgZRp6xlRxf8EadQ19GZBc9kDbFKxzhLfUzHQ?=
 =?us-ascii?Q?YKqxrghXxZw1eaLx1ZwMIoyPMC9nLUwttWxmqY9jm/kUq8eI9iGVizx2m0uV?=
 =?us-ascii?Q?k8Qd6CUrWvjksQ5SaGXARHUxFErPCCD8ZJ37uCC5bfRJdx5HJ/Bx1gR+OSL1?=
 =?us-ascii?Q?QTqoDNntZ7thoAKEnuHgH9NQkCs2quiMcat0N05V8xpX7RIXrLGiuGFU5SZs?=
 =?us-ascii?Q?mZFGR9QQkJbESnxu0o+acc4a/vy4kmtm8kzvXF9LpE6hjI3dyeZwePhjYeSP?=
 =?us-ascii?Q?GbFNV+betvk20J3ARXvehoDXtnRy05j6LhAK+rH5UAlqV7r8zgBD8UATnRh9?=
 =?us-ascii?Q?jgWDKrSgRFBqg1gXvSfGvDQeRLQWImEs8aa27N/8+mhQl2pQJHhjsE6duw5N?=
 =?us-ascii?Q?WYPkJCTjrf3I44x9k2jQ5AXVAkM88kEo11QHv/ogDIols30Mh6VCpdYrJZiz?=
 =?us-ascii?Q?G3I4qACs+gaFFRxjXvfCcVfCU14sHCSOPFyW8BqbxdkBnS31VhHD2TL1DsKw?=
 =?us-ascii?Q?SSAI08ZQnv3OPWpE9iBvCfQlk2fpBR+ni6g9nZf7cKidC9dMXgZW9bmxslw1?=
 =?us-ascii?Q?pCf6IyM9+hHZX600g0y9lBzqnjBEvS49cCDYRVk27SdY6AEP5bnqnwGhicVd?=
 =?us-ascii?Q?Jl0LM3mG1nb6Gp0t7QHykTOWZD3aKUnxpQIQtC16BfjHeCjUERHhMWT7FFWI?=
 =?us-ascii?Q?vIEbyehIT8jL4Y9ShILoxEc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c970996-f617-408d-5684-08dbb606c182
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:13:53.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmmQhOmyUBacLsHNI2L6nW1DS5slAcr88lhI9XELMu0tHip3xY7lk78MwlVs0ByZvY7wzNxQAv4vvwM8HaxrinLaaa0bO/3+arATnnG6GtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7602
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, Feng Tang wrote:

> Thanks for sharing the trick! I tried and it works here. But this is
> kind of extreme and fit for some special use case, and these patches
> try to be useful for generic usage.

Having a couple of TB main storage becomes more and more customary for 
servers.


