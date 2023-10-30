Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B457DC290
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjJ3Wkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJ3Wkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:40:49 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 817CEC5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:40:45 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-b0-654030eb2bf5
Date:   Tue, 31 Oct 2023 07:40:37 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20231030224037.GA900@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
 <0138328C-74D5-471E-A2CC-7675CA692F42@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0138328C-74D5-471E-A2CC-7675CA692F42@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsXC9ZZnoe5rA4dUg3dtKhZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CVsa1v
        A3vBea6Kn5sWszYwbuboYuTkkBAwkWjfeZQNxv7/ZB87iM0ioCrRdfg/WJxNQF3ixo2fzCC2
        iICixKH99xhBbGaBd6wS3z9pgtjCAtESn/a+AuvlFTCT2LXkH5DNxSEk8INRYvnUy0wQCUGJ
        kzOfsEA0q0v8mXcJaCgHkC0tsfwfB0RYXqJ562ywXZwCdhKvW/eAzRQVUJY4sO04E8hMCYFd
        7BI7W78zQxwtKXFwxQ2WCYyCs5CsmIVkxSyEFbOQrFjAyLKKUSgzryw3MTPHRC+jMi+zQi85
        P3cTIzBql9X+id7B+OlC8CFGAQ5GJR7eDT32qUKsiWXFlbmHGCU4mJVEeJkdbVKFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MG7wmVR+w1JIMXy9ivyF
        vSsW/244KfTo832rspkfphzuWWLT/qj8zv1DQLP3X5RZHPhiD4sy35eABUv75mtaVO56mzdz
        5Ucz7X2ckSXsLy3crC1tqwIStXvfKCZt+swfyJjKH3r8rPgynaY3sqs3icuwF9w8umXO3ghr
        +wCTV0z7Yl7XLA95pMRSnJFoqMVcVJwIALrJRpLWAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC5WfdrPvawCHV4Egjt8Wc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBnb+jawF5znqvi5aTFrA+Nmji5GTg4JAROJ/0/2sYPYLAKqEl2H/7OB2GwC6hI3
        bvxkBrFFBBQlDu2/xwhiMwu8Y5X4/kkTxBYWiJb4tPcVWC+vgJnEriX/gGwuDiGBH4wSy6de
        ZoJICEqcnPmEBaJZXeLPvEtAQzmAbGmJ5f84IMLyEs1bZ4Pt4hSwk3jdugdspqiAssSBbceZ
        JjDyzUIyaRaSSbMQJs1CMmkBI8sqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwBhcVvtn4g7G
        L5fdDzEKcDAq8fBu6LFPFWJNLCuuzD3EKMHBrCTCy+xokyrEm5JYWZValB9fVJqTWnyIUZqD
        RUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAuDbvb5rBggW1qzSPz/9lIBi6R2NpWmwik+iM
        o6YMis3yWZ1XdR62CE65uvbzvppjsgam282+zJRu1T58nzUm6m7xzGXSNpXCy7gqtk3TWrZn
        ouTbR1MuLi57E7Jywsv8nRLTH8UvjzvIbnqWy2LGfqcf969VSim1vLIqCVlUt/mP87eJe5dd
        eKnEUpyRaKjFXFScCACyQ1lNvQIAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:58:44PM +0000, Nadav Amit wrote:
> 
> 
> > On Oct 30, 2023, at 2:51 PM, Byungchul Park <byungchul@sk.com> wrote:
> > 
> > I really spent a lot of time hesitating whether splitting it or not.
> > However, the test result cannot be stable without those. I'm still
> > confused. I think the test result should be stable at each commit,
> > right?
> 
> Of course. You can extract the optimization we mentioned, and perhaps
> have more preparatory patches.
> 
> Just a couple of comments that may also help breaking the patches:
> 
> 1. The “stopping” logic is a bit not great. Try to see if you can
> somehow use shrinker or OOM infrastructure instead.

The stopping means "temporarily pausing" expanding migrc's pending
queue, not shrinking folios.. Yeah my fault. I will rename it another
not to make guys get it wrong.

> 2. Regarding “overflows”, it’s not always a question of whether an
> overflow would happen naturally, but whether a malicious process can
> trigger it.

I understand what you are worried about. However, it's intended that
the variable is going to overflow. And the overflow doesn't matter if we
are aware of it and careful in handling it. See time_after() in
include/linux/jiffies.h. That would help you understand what I mean.

	Byungchul
> 
> Regards,
> Nadav
> 
