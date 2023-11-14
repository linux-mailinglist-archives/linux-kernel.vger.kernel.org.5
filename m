Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D907EB5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjKNRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNRuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:50:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F5D94;
        Tue, 14 Nov 2023 09:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi2oL2vOpqZT7gq5HmTv7aT6/1n76pU4ELGiL1PHoK9ufX/W7WwNIYbeVZUfSx5Yktr8JgfgXFmSrMySispmj0J7uMMNpKUirMQrRAndE+ywHGY3MwXTZTNzimkTDiQEjZtKrrE4QkFGLOTOoZYzm3XO1eWppLL8q8MnKZTZHB1JfdwAA+3nFDH/AKUI0UYgKGBGMGka2QhNAegVnAnyfFdsnThZJsxUgc/TjQu76ZAlavU1oCALXip70LE9v8EQyJB5shd2KnES5nQwVjVB9AoDWxEKdgG5K2uf49Y3E08QK+e3MZ6Sw3YEe5OCQSQJZmfk/ra+v23t38KfED652Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FylOm7FjvRjEOQJtoTBgTWErNycCvQ5hgLTGsFA0IbE=;
 b=RqLaGrZyzxssSPFd9Li6QaTWMA7vo9T2gvTXw5m/Xd/SQko4EepLzYU+llyaC30Hpn4ZNYXRiUyS4/ThhF1j7o8jQgdT2TaB04Q/tp/tMfJfZRGD0Pqm6ujJTDmHi839NFiJfe3bMhsOQXFDoAlcb2ve4y3kh8MBCTMYsB8okLIrYhY/9rL/L+uZ/Tqre7gxNCaWoYKfbx96oiaKOxDYvFGna+ILX/jLYOcLK5r2qcDVanHBPB12uAHumQX+uKhUx4nKqqMBRofPoqUwbp06vf7BHkfqlGAdnivahH5sVGyIFB/3rXvQdkEjnvyBPYF0Gfi6EsziTn62PSSC/CE/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FylOm7FjvRjEOQJtoTBgTWErNycCvQ5hgLTGsFA0IbE=;
 b=D5ixf4Cv2AFentjTAnymC+td9rcjork/JY2/RYXC1JIm/hqWigF+h9Nq2EHZBSXilW3o+m2V78KYVg1ebAYxifQjUsbKVFEI30vWYzHoDwpuET0uueHFjF9qfTM0LsniB4/I2LDbAvsJicGE6hkjAx3iBvDK6tIupPcMevr6eMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5653.namprd17.prod.outlook.com (2603:10b6:a03:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 17:49:46 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 17:49:45 +0000
Date:   Tue, 14 Nov 2023 12:49:36 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, John Groves <john@jagalactic.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZVOzMEtDYB4l8qFy@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
 <ZU74L9oxWOoTTfpM@memverge.com>
 <ZVNBMW8iJIGDyp0y@tiehlicka>
 <ZVOXWx8XNJJNC23A@memverge.com>
 <ZVOn2T_Qg_NTKlB2@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVOn2T_Qg_NTKlB2@tiehlicka>
X-ClientProxiedBy: PH0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::25) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e29f6b-71a6-40b4-0393-08dbe53a16a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WMVuJ9JjszrI5ZZwNogLB5Cisbg22SKR4A5dSHxdyEMp4BidOBMDE6pQgSLyTaZUB29l5fYBwXWlIsFTu5LKEqNwrbPojbLqnnWp49tYtSzieTlbEtAz9IgZ10ITFaWxmHh2E0lT3CTT+qHTqGvlzd42OQqhXVoulu2KUDsuJ9Bb3gjxbzGhCXG6qq0SM70ayLxuB4alxHeiiWUo8xg7XFNeqvbT6Sh8PtbZOzJ0QwAxUUeKUDN138v5KAZFkFqggrkCpVSV/fv7duOWgv/h0EADmkB8EZLhjnUu3aiahSDm7qwGSd38uoI3tE5DrVJtKYitXhIZA/Nh21JvrKYQXn6pSKEOZJERLwG3Y50kRxbG7HO35pxtwAzeUF3yXv96YQB/uTrgTO7hnw3YoMtUpBhZjUji5x3CRHeNnNMHtLgUcMk09plXe7OamQSk0t9BH77lfFKGD6JeHor/khZogqWoQsEHeh3MxhCwmsSs8Ukshw5F6CR7C+Dob/rzl6caQqJxI5xX/ch1MehxUyhSy2RFUw4odRzLTnZiCpTgQ0PXyzu8nX0G4+7AZOYRByMYq7ni5Vpv/oEMk/WzFdjjKWPQDmrXNIPq/9UXgn00qo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2616005)(6512007)(8676002)(8936002)(6486002)(966005)(478600001)(26005)(44832011)(36756003)(4326008)(86362001)(41300700001)(7416002)(5660300002)(2906002)(66946007)(66476007)(66556008)(54906003)(6916009)(316002)(6666004)(6506007)(38100700002)(83380400001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1rN6Of1TuXIsomIpZN4Lo3DR/7aUISuRmT3aRV+AfE06KIW2bL8clhHB9/On?=
 =?us-ascii?Q?6i5RLYXJAo/5KnsLx1s8bjGDa4rYDmKc4WZzWRFny0P28Bf0mCf3+H2ErWLw?=
 =?us-ascii?Q?WETmjFvlIf3IgbQZEBSSi4EsBj3G9kMnBkqs5zU6btsFUxfc2be72WmCqPD8?=
 =?us-ascii?Q?G8OLcizIup8cCEm2k1bUlpvjC1ln6O1zUUVP8s0EynNrLcu/gG7b+dBXtNuV?=
 =?us-ascii?Q?pUCTernyG3zKCn0pqao8cHiBLvukpa1MEXJvm294EI6BjJpG4Kn6C1GCtsls?=
 =?us-ascii?Q?wxSmN6roEqxuDFm5gmqrWPo/KsCKMgGUsMAR9ApNHmCB8P3BvgjasqcYLYl0?=
 =?us-ascii?Q?rLs5yz+4puX8PBmHi0LaxiI1k4et2Y53GH1AkEABH5HpgIGfZGPsZVeNrkPv?=
 =?us-ascii?Q?T1onJP+F6uXSis4FCuxhO8y3Q7cZxqWTTHNFQvK7Cy4IHcZxh1tBIGDJcF0D?=
 =?us-ascii?Q?ZX7gbz/+hJwr1byo8KWt5898z+iJ1ar7wTCD17D9ZVvbH+yOS54vKOL+HU5V?=
 =?us-ascii?Q?wkWDgcOrrapH0fnOyZmbqbxwESNXuLTizodEVD/iin4t+/W6K/wIGgSBZ+GY?=
 =?us-ascii?Q?w/Ok7CHvyfU0knOCkse36a2E6picz73IdhVV/wvmbzU+NusRXGCUS3vBrG2H?=
 =?us-ascii?Q?FjYaV54gYDadzW7V05n8D1gCDmtEZWQkWqoAwmWPKJavi69iMlpmmOtlPFH8?=
 =?us-ascii?Q?eksy+O1xsCJ5rpWkhNuCPgMumUQCJzmvW08HGljm9oU7B2W8rAZi5OQX49ak?=
 =?us-ascii?Q?N6mvKLTVnGUcqbV4OLUBNO7rVqyk+q7hWULq9bbLXTjgfIQhZYkw7vsIuCtL?=
 =?us-ascii?Q?y6AxweChYhSZepfnJsEwi52HGxfp30RJWEDPJzzwbD1d83e5+JDuHZpAwSxJ?=
 =?us-ascii?Q?dT6BfY/Cgax+HyzWjQ0DPqKpR0wxt5A25lX0kMr8CgsvbBN/Q+wauT72anxr?=
 =?us-ascii?Q?0/gnj/gCI+1aZeayeQ8vkCN3lKDEb8bBjqViMcxGDwSephTt9z2eEfd2FSaK?=
 =?us-ascii?Q?r5hjwc8H8jH+H3PAKbzn06RqiW2TeZ1nQC6x7cBuQFktgxa2G2iA3PbdgGbR?=
 =?us-ascii?Q?OSTVZCOdf6TFaKIsDg9KcPhGBwonSjFPL64EgRLi18cqQIsON/Cgj6G5zKB9?=
 =?us-ascii?Q?UM7O7Sv+LbVtlDh5fGQd6I4JoG1QNR2qN8mxQUEnjilvyecF1hZjaaq2Y1FO?=
 =?us-ascii?Q?zuLxGIbaTN7wwbTgrVrvoLB3v2Np3NkqId9/a7Gn6CUdQvOEMiCHgyy+BTqX?=
 =?us-ascii?Q?Cr5CHEbTCWFVr5MgcgziVW2vEes/qiAv4JwGi44vNIBgYepDu3a4L8hsnD5K?=
 =?us-ascii?Q?lXuCR64i2UmPU4hmE1Uch49MSlZnnsGUEH3LGDzWaxumBcpGbQd4vdbQKxUw?=
 =?us-ascii?Q?rOwk5ywpcwY9giwnYrVd9xnzZTR79vI0O9oVsZWLIuinSDX4ECI4DWXBzY+f?=
 =?us-ascii?Q?pUmqUlyvD6lIM3Ekdsfg6lyBmET08OBVvnt1ACmPWNh6ErFiOg27x3kGL3tD?=
 =?us-ascii?Q?U2EpBboSN8ARVACghhRfbWwe6Xyrm5WT/Siywvs6letdu1DKbzKiCfvHE1ip?=
 =?us-ascii?Q?5FVSLob/ogm73ucdoAJkWFjSXyCdEtv5Gvx5CFYM8jXad8eC4wda3tIxFal3?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e29f6b-71a6-40b4-0393-08dbe53a16a1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 17:49:45.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjsiqJxYGuDevKfjU5heqUfS1vPdORSFG6PigprhOUX/c9s6kMAlmCsABjCdo9yPOCTRy/EuPolWCtW5ly4PWJYfEGaixIcWjGWMhl2uuBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 06:01:13PM +0100, Michal Hocko wrote:
> On Tue 14-11-23 10:50:51, Gregory Price wrote:
> > On Tue, Nov 14, 2023 at 10:43:13AM +0100, Michal Hocko wrote:
> [...]
> > > That being said, I still believe that a cgroup based interface is a much
> > > better choice over a global one. Cpusets seem to be a good fit as the
> > > controller does control memory placement wrt NUMA interfaces.
> > 
> > I think cpusets is a non-starter due to the global spinlock required when
> > reading informaiton from it:
> > 
> > https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L391
> 
> Right, our current cpuset implementation indeed requires callback lock
> from the page allocator. But that is an implementation detail. I do not
> remember bug reports about the lock being a bottle neck though. If
> anything cpusets lock optimizations would be win also for users who do
> not want to use weighted interleave interface.

Definitely agree, but that's a rather large increase of scope :[

We could consider a push-model similar to how cpuset nodemasks are
pushed down to mempolicies, rather than a pull-model of having
mempolicy read directly from cpusets, at least until cpusets lock
optimization is undertaken.

This pattern looks like a wart to me, which is why I avoided it, but the
locking implications on the pull-model make me sad.

Would like to point out that Tejun pushed back on implementing weights
in cgroups (regardless of subcomponent), so I think we need to come
to a consensus on where this data should live in a "more global"
context (cpusets, memcg, nodes, etc) before I go mucking around
further.

So far we have:
* mempolicy: updating weights is a very complicated undertaking,
             and no (good) way to do this from outside the task.
	     would be better to have a coarser grained control.

             New syscall is likely needed to add/set weights in the
	     per-task mempolicy, or bite the bullet on set_mempolicy2
	     and make the syscall extensible for the future.

* memtiers: tier=node when devices are already interleaved or when all
            devices are different, so why add yet another layer of
	    complexity if other constructs already exist.  Additionally,
	    you lose task-placement relative weighting (or it becomes
	    very complex to implement.

* cgroups: "this doesn't involve dynamic resource accounting /
            enforcement at all" and "these aren't resource
	    allocations, it's unclear what the hierarchical
	    relationship mean".

* node: too global, explore smaller scope first then expand.

For now I think there is consensus that mempolicy should have weights
per-task regardless of how the more-global mechanism is defined, so i'll
go ahead and put up another RFC for some options on that in the next
week or so.

The limitations on the first pass will be that only the task is capable
of re-weighting should cpusets.mems or the nodemask change.

~Gregory
