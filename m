Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7617761997
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjGYNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGYNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:17:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43891BC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRe8DSpRF/HTSMLv9weqJTToexnGEfwxlgLIc+22/zvkHxMFJKJzfee4YU78n/hpoEGtRj8UJaK2GB6tOXwlQFmlsDZ47BTngiXlU/Aoha1nBCFRYHIgIoJ5t71yv3sIXs4eSzP/Jxni9uI4c1IDzhNWmG9d9NfisbFM4qaUGrdZuUB4HkKI5zXPnHrnGHujWw2XGPw4NoB+qPznmnKVSpKTVLvvvX78+qCPmSPEHtaCK48DKQTpKpe5IPAtX4FYqB3MGTBhSDpDplmZKNQMueVd/w8qiy/HYTl8z2+VjJor9rVHRRaYDGIcjD5YnwJloTrQATmrc+QrP3f26m7a1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE5baoe6obWt5ZjLf2oxGI1e7i6AL5yVoIqxENpGsDM=;
 b=krM4SjfNR4JmAVYT81tWP97ox0OVQUG8hG3Y/g6veFr/VoJn3fnTCIAXn2w1VuQHsCgzRq6Vijw95f2p05ZILz7j9y+BFaBC9eVgMXhybrUNmN+UZO+9FyE2ZiMPZ2ZFatOBXKQhz0mqQiFQ2BxvNux0r67a8c7J2+nwat0ebVQX/YCnz0bMPzWZ9uihYMGgfpa3PybnHx75PjjKXYpuelUrt1fs31DKadIZ4gk9rOVucDv8GVqrKTF03xcGBg5kg60WckBccri7eb6cC/xOnhPajNZ4OsKqjrSPAwQFexFM9GdasO7guZ0K2DjhQbxxXpFw5pawHJnPm0NDEQ3GrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE5baoe6obWt5ZjLf2oxGI1e7i6AL5yVoIqxENpGsDM=;
 b=XF0MaIvUaJxdT8rHwelibeyGhZDzXRgEeSBg+7UZs54RzU6588u2VtjxZPeR76MEwjlFrmoSfId3P2LzF2goTF9zo9m29/wh6RMxOcNkspjhXbarzlv5BvhabDdRhpCRzA2t/JXRdvmRp0iWRI4jDhP6uzx0pdpLbBZUDbWFBF+nPu/4kZ4PIzAmsdA79EYeQzlsIIKbXHoQwodnbaQ8VYa+RUS2zjqWYFRd0eVUH3xxKMzVP3G2pXqdHKRH93YEChNRqFBbnOYZLUR1E95Ck0bx9wCLwx+BgpPcSZoflRXC7lsRiQ0QcWALAqf4iJgtNtLjoWRjnYpJR7JPyskQOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 13:17:08 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:17:08 +0000
References: <SJ1PR11MB6129592BDF5D06949F99816CB95B9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129A7F5C08E2C47748F2BA5B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612980562220A376CA90E105B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB61296D265E3407D447188EF6B903A@SJ1PR11MB6129.namprd11.prod.outlook.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc:     "Yedireswarapu, SaiX Nandan" <saix.nandan.yedireswarapu@intel.com>,
        "Saarinen, Jani" <jani.saarinen@intel.com>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, dan.carpenter@linaro.org
Subject: Re: Regression in linux-next
Date:   Tue, 25 Jul 2023 23:15:25 +1000
In-reply-to: <SJ1PR11MB61296D265E3407D447188EF6B903A@SJ1PR11MB6129.namprd11.prod.outlook.com>
Message-ID: <87o7k0xh9u.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0016.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::7) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: e9718717-d483-47e7-222c-08db8d1172c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzuD/x0j19VoG97jiEpVkVw/ggjWN+iyrccaF+eCbPDr8PGLYVnj5Bek2WODpU0Kr3psloExGeGwZicA6yVDduFjwUlZHON8qHsqkmW27FQFIVaLf2L4YeSulP2B0qal3FiNWkoZqUUVvUZt0X7A/D2GZmjyzxPdSb57h2i0V1O8YWkGOH/XAZmno4Nkjr2f8i5tMjIy4wwS+KAg1PEUJv5b0ILzLqmTxBWhFiAfKOXX2fswFCwVYVVDYIzjLewDveBCw5k/L8vOhX4B2yBKEo7KxbMXv2igt0Y552AvybSO3/IL0Pi0iAIMM3bOFba+On0fO97O3iW7rmdcQZlTBbhk/AaVdODNvgIvNvwp/ZuU8szV3E4usF5VlLoKfHsvmI009a5qFzf2YlT3Od2bct7A08evCqxYoUVvQAuk5T/U49kABTIRyy94jYyQeDP9wbJgtXCg2QKkpncbnX39YTj7p8p+SaG5Da+wCtEvTfVVc2DJEXAWiFhpk+JMYnfYLHXO9xj7lA5qcYWQ6rxY8GG3nZyxkUJPOiaaqTVrO/BKWCqVVIyD9TBHOE5+NcxnjK2Hokhi1jhdqRGlidkemaxOBEN5D2YNYMXAj1CgFg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(6512007)(966005)(38100700002)(83380400001)(3480700007)(186003)(26005)(8676002)(5660300002)(41300700001)(8936002)(2906002)(6506007)(6486002)(66556008)(6666004)(66946007)(6916009)(66476007)(4326008)(478600001)(86362001)(54906003)(316002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zw5MW+TaL2o+gsED6GEqS0uQIqhyeXZgGGiBz7wIIqbsZO4TpbAPOJzXYXKs?=
 =?us-ascii?Q?mOzCMkHvK5b7N3ZQHMxiqf4Q69x8Zm116QUGilGvIO9zE7CxkG/OA7XUUfUc?=
 =?us-ascii?Q?Hp19FSGGPkj44aHB+Pbc9b67rZWJNqiVbNGEO/xy9Mi9SNUF3pR6/K67Hr57?=
 =?us-ascii?Q?7iOQJzXIlesDdvGteT2JN85WgpwxrtwpAqkjfaFx2QYUxYR3jQbmLkCpuNyB?=
 =?us-ascii?Q?39b8vJEUvcd5QDvl+NEI0fPilkO1GUL32B0dHRr1vwLrzmshkQj+8QB5KQcE?=
 =?us-ascii?Q?OJYSAIDRFFU0yI3a7J+Stu082nsvnX2uUfl490nl/ahTSzNdA8RUfkwfB/1k?=
 =?us-ascii?Q?MRUH3o/6vdjqnDl1/IvKGV+nWaqD38tUabgUD4HNR0AqJxsBa5vrgjJFfPgu?=
 =?us-ascii?Q?abdf79JIMu07bn0/Weww/rUE6xAfutsL5YUeQkcNFWecbhSqLyWrDHO5OF6h?=
 =?us-ascii?Q?gg0xZ2IIoY0ffbQd9dDhUr8s+TpE45amVN8WXZ6wJ7DsSJ7spkG3MbJlxraJ?=
 =?us-ascii?Q?0NFhRhmtvaeBh2NIl6kXV6mpsF0xZkKHvBT+WZSqqBbtbtiD8DXxZ8Zomdrf?=
 =?us-ascii?Q?99MQTd0Xs3IZ58y1Cl35qEE9M2hGv7+qKD5UL8GsNNtMhP5crhojGwNJDd7O?=
 =?us-ascii?Q?xpoiJeqT8jU1w4TkXbBXnGBlyRPKJxnSnTMll44DqWLgqyu492wI4f4dezgL?=
 =?us-ascii?Q?e38yjtV0Fis2ijBsEbWzQcRH8G5t01dBEdK761y2cNlAnlyOgt7t+W7wQFuz?=
 =?us-ascii?Q?/tR45LFvvZAukP80+dnjPzbm996oXYnXuVAWSD79SxnAsi6oLWBbbdCH9DSd?=
 =?us-ascii?Q?tV3lHpk+CmcHZBgQMIyGW8CzXpjnN6g6NDnCUWTUEh8XRLANM8ORFPnVs4sy?=
 =?us-ascii?Q?4HvbvEIfAKgobnNvle+VzDwZBZYOrtomdWuRgDTuHINMfrBGaHKvzu/oQVVG?=
 =?us-ascii?Q?N5mn5QbSAct8A9fKfUpS0+xZ9wY/zZLi8tyZmrySZFr0kvG8nSQtOHz69Cdq?=
 =?us-ascii?Q?FI2X9FU3h3atN4UAvFoayqoTkc4an7IE2fA6xc7Ix32VlIg6rkgMdLe+X1Og?=
 =?us-ascii?Q?LyW2GxpPhAJ9ckYGdQfVHCthgRNoTDN6swftQ3vYKtwlkPsAqHTANm9Fhekv?=
 =?us-ascii?Q?OWM6mcxc2+6uLX/+e25L2cJEylFFTXKtxQU1YHfjU7+HLhxpzCLSGNTb71f5?=
 =?us-ascii?Q?pLQOhfBpi1ZOSJZpgP/tCYu9WNa0FCxFE4rlPdWuGxCAVEGXIOD9LqvtvnBK?=
 =?us-ascii?Q?gAjUIHO7NJjW/SAL3rWX2GcpUlwQoPQqqUkpcmLZJyln3PwrDYHwe8LUs32f?=
 =?us-ascii?Q?4qCgVtUlJvhzCW5yHhX364imm3JcctV4tIZCuu7pn6/wB0Dbgink4XJ+wfob?=
 =?us-ascii?Q?U0Plp33nh9YlDRBC/mut5v4EBTnMeA9Hw2OMLw4CzuxM8Xk29gGYwxjjwgC0?=
 =?us-ascii?Q?2uC8Fgy1hVNTyClNXdy6DEcFBnQsHhkcQ1OlxKDz6Lxk7fgp+Fv/TpVLXK+K?=
 =?us-ascii?Q?7IHjaiM0L4g51lh1fHjk3Xz/g2HknSUvZpOcysZjt5/27+6W6f6vbklHHnUW?=
 =?us-ascii?Q?UcszcqbrmB4LVInzSGqylD5oNlcJ6P+SRw4z63SY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9718717-d483-47e7-222c-08db8d1172c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:17:08.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAQJLyfm0wXTX/xZ/rEUe/6wtGqWZSYXsgmSdiW8qDBYgoTeZvmOxijK25/uaWk0lK6RmqP3HPpA3Lek1h9WWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
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


Thanks Chaitanya for the detailed report. Dan Carpenter also reported a
Smatch warning for this:

https://lore.kernel.org/linux-mm/38ed0627-1283-4da2-827a-e90484d7bd7d@moroto.mountain/

The below should fix the problem, will respin the series to include the
fix.

---

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 63c8eb740af7..ec3b068cbbe6 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -621,9 +621,10 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	 * Subsystems should only register for invalidate_secondary_tlbs() or
 	 * invalidate_range_start()/end() callbacks, not both.
 	 */
-	if (WARN_ON_ONCE(subscription->ops->arch_invalidate_secondary_tlbs &&
-				(subscription->ops->invalidate_range_start ||
-				subscription->ops->invalidate_range_end)))
+	if (WARN_ON_ONCE(subscription &&
+			 (subscription->ops->arch_invalidate_secondary_tlbs &&
+			 (subscription->ops->invalidate_range_start ||
+			  subscription->ops->invalidate_range_end))))
 		return -EINVAL;
 
 	if (!mm->notifier_subscriptions) {


"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com> writes:

> Hello Alistair,
>
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
>  
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next
> repository.
>  
> On next-20230720 [2], we are seeing the following error
>
> <4>[   76.189375] Hardware name: Intel Corporation Meteor Lake Client Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS MTLPFWI1.R00.3271.D81.2307101805 07/10/2023
> <4>[   76.202534] RIP: 0010:__mmu_notifier_register+0x40/0x210
> <4>[ 76.207804] Code: 1a 71 5a 01 85 c0 0f 85 ec 00 00 00 48 8b 85 30
> 01 00 00 48 85 c0 0f 84 04 01 00 00 8b 85 cc 00 00 00 85 c0 0f 8e bb
> 01 00 00 <49> 8b 44 24 10 48 83 78 38 00 74 1a 48 83 78 28 00 74 0c 0f
> 0b b8
> <4>[   76.226368] RSP: 0018:ffffc900019d7ca8 EFLAGS: 00010202
> <4>[   76.231549] RAX: 0000000000000001 RBX: 0000000000001000 RCX: 0000000000000001
> <4>[   76.238613] RDX: 0000000000000000 RSI: ffffffff823ceb7b RDI: ffffffff823ee12d
> <4>[   76.245680] RBP: ffff888102ec9b40 R08: 00000000ffffffff R09: 0000000000000001
> <4>[   76.252747] R10: 0000000000000001 R11: ffff8881157cd2c0 R12: 0000000000000000
> <4>[   76.259811] R13: ffff888102ec9c70 R14: ffffffffa07de500 R15: ffff888102ec9ce0
> <4>[   76.266875] FS:  00007fbcabe11c00(0000) GS:ffff88846ec00000(0000) knlGS:0000000000000000
> <4>[   76.274884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   76.280578] CR2: 0000000000000010 CR3: 000000010d4c2005 CR4: 0000000000f70ee0
> <4>[   76.287643] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> <4>[   76.294711] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> <4>[   76.301775] PKRU: 55555554
> <4>[   76.304463] Call Trace:
> <4>[   76.306893]  <TASK>
> <4>[   76.308983]  ? __die_body+0x1a/0x60
> <4>[   76.312444]  ? page_fault_oops+0x156/0x450
> <4>[   76.316510]  ? do_user_addr_fault+0x65/0x980
> <4>[   76.320747]  ? exc_page_fault+0x68/0x1a0
> <4>[   76.324643]  ? asm_exc_page_fault+0x26/0x30
> <4>[   76.328796]  ? __mmu_notifier_register+0x40/0x210
> <4>[   76.333460]  ? __mmu_notifier_register+0x11c/0x210
> <4>[   76.338206]  ? preempt_count_add+0x4c/0xa0
> <4>[   76.342273]  mmu_notifier_register+0x30/0xe0
> <4>[   76.346509]  mmu_interval_notifier_insert+0x74/0xb0
> <4>[   76.351344]  i915_gem_userptr_ioctl+0x21a/0x320 [i915]
> <4>[   76.356565]  ? __pfx_i915_gem_userptr_ioctl+0x10/0x10 [i915]
> <4>[   76.362271]  drm_ioctl_kernel+0xb4/0x150
> <4>[   76.366159]  drm_ioctl+0x21d/0x420
> <4>[   76.369537]  ? __pfx_i915_gem_userptr_ioctl+0x10/0x10 [i915]
> <4>[   76.375242]  ? find_held_lock+0x2b/0x80
> <4>[   76.379046]  __x64_sys_ioctl+0x79/0xb0
> <4>[   76.382766]  do_syscall_64+0x3c/0x90
> <4>[   76.386312]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> <4>[   76.391317] RIP: 0033:0x7fbcae63f3ab
>
> Details log can be found in [3].
>
> After bisecting the tree, the following patch seems to be causing the
> regression.
>
> commit 828fe4085cae77acb3abf7dd3d25b3ed6c560edf
> Author: Alistair Popple apopple@nvidia.com
> Date:   Wed Jul 19 22:18:46 2023 +1000
>
>     mmu_notifiers: rename invalidate_range notifier
>
>     There are two main use cases for mmu notifiers.  One is by KVM which uses
>     mmu_notifier_invalidate_range_start()/end() to manage a software TLB.
>
>     The other is to manage hardware TLBs which need to use the
>     invalidate_range() callback because HW can establish new TLB entries at
>     any time.  Hence using start/end() can lead to memory corruption as these
>     callbacks happen too soon/late during page unmap.
>
>     mmu notifier users should therefore either use the start()/end() callbacks
>     or the invalidate_range() callbacks.  To make this usage clearer rename
>     the invalidate_range() callback to arch_invalidate_secondary_tlbs() and
>     update documention.
>
>     Link: https://lkml.kernel.org/r/9a02dde2f8ddaad2db31e54706a80c12d1817aaf.1689768831.git-series.apopple@nvidia.com
>
>
> We also verified by reverting the patch in the tree.
>
> Could you please check why this patch causes the regression and if we can find
> a solution for it soon?
>
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230720 
> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20230720/bat-mtlp-6/dmesg0.txt

