Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09C7EBD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjKOGnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:43:23 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AC74B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:43:17 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-52-65546885ec9d
Date:   Wed, 15 Nov 2023 15:43:11 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: Re: [v4 0/3] Reduce TLB flushes under some specific conditions
Message-ID: <20231115064311.GA41022@system.software.com>
References: <20231109045908.54996-1-byungchul@sk.com>
 <64cb078b-d2e7-417f-8125-b38d423163ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cb078b-d2e7-417f-8125-b38d423163ce@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsXC9ZZnkW5rRkiqwcaFIhZz1q9hs/i84R+b
        xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
        HO89wGSxedNUZovfP4Dq5kyxsjg5azKLg6DH99Y+Fo8Fm0o9Nq/Q8li85yWTx6ZVnWwemz5N
        Yvd4d+4cu8eJGb9ZPHY+tPSYdzLQ4/2+q2weW3/ZeXzeJOfxbv5btgC+KC6blNSczLLUIn27
        BK6MjdeCC5r4Kl5MPs/cwNjP3cXIySEhYCLx+HAjUxcjB5g9Z6IwiMkioCpx6JkiSAWbgLrE
        jRs/mUFsESD71Mrl7F2MXBzMAk3MEtfWb2YFSQgLuEvsOnUHrIhXwEKi9VsnE4gtJJAhcfz1
        HHaIuKDEyZlPWEBsZgEtiRv/XoKtZRaQllj+jwMkzClgK7G/4RkbiC0qoCxxYNtxJpBdEgKb
        2CVWTLjIBHGypMTBFTdYJjAKzEIydhaSsbMQxi5gZF7FKJSZV5abmJljopdRmZdZoZecn7uJ
        ERiJy2r/RO9g/HQh+BCjAAejEg9vw8zgVCHWxLLiytxDjBIczEoivOZyIalCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGHnNvSceYXvpabTD3WTfemVF
        v8/bC+pqJQUezq4OUVBb82pmVM07a/391yIdD/z1utcZolB+dZ/166QLn2zanx7iWdOXJzph
        9aRYowuTyo0LWzgS5jl+/7QwMFSi8NW3xrzqJB8l5xDOl/cyHn3fG7/pxpHUt7c8YgSnXgqe
        /l/Y2Wa5cucvNyWW4oxEQy3mouJEAL5nD2zAAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsXC5WfdrNuSEZJqsHyjlcWc9WvYLD5v+Mdm
        8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/Vovzu9ayWuxYuo/J4tKBBUwW
        13c9ZLQ43nuAyWLzpqnMFr9/ANXNmWJlcXLWZBYHIY/vrX0sHgs2lXpsXqHlsXjPSyaPTas6
        2Tw2fZrE7vHu3Dl2jxMzfrN47Hxo6THvZKDH+31X2TwWv/jA5LH1l53H501yHu/mv2UL4I/i
        sklJzcksSy3St0vgyth4Lbigia/ixeTzzA2M/dxdjBwcEgImEnMmCoOYLAKqEoeeKXYxcnKw
        CahL3LjxkxnEFgGyT61czt7FyMXBLNDELHFt/WZWkISwgLvErlN3wIp4BSwkWr91MoHYQgIZ
        Esdfz2GHiAtKnJz5hAXEZhbQkrjx7yUTyC5mAWmJ5f84QMKcArYS+xuesYHYogLKEge2HWea
        wMg7C0n3LCTdsxC6FzAyr2IUycwry03MzDHVK87OqMzLrNBLzs/dxAiMq2W1fybuYPxy2f0Q
        owAHoxIPb8PM4FQh1sSy4srcQ4wSHMxKIrzmciGpQrwpiZVVqUX58UWlOanFhxilOViUxHm9
        wlMThATSE0tSs1NTC1KLYLJMHJxSDYwh8ZqOhb1X+eabrPsx5Zj8Mcu3+UKzUvbNvuTtnrZ9
        dcy+pdMuFJ+tnrdrq7Uq646VnSw3/Fdy8r7ImNzGu8RGIni61aRyV+/L29+5HzRkW691pt+c
        NV8j2PLcuoMOG2xO6Pr2/Pzozvy96gQTi/O/FPGPGlNv7u9YJDQxRHTKw82PO7kEF05WYinO
        SDTUYi4qTgQA1c1wOacCAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:26:08AM -0800, Dave Hansen wrote:
> On 11/8/23 20:59, Byungchul Park wrote:
> > Can you believe it? I saw the number of TLB full flush reduced about
> > 80% and iTLB miss reduced about 50%, and the time wise performance
> > always shows at least 1% stable improvement with the workload I tested
> > with, XSBench. However, I believe that it would help more with other
> > ones or any real ones. It'd be appreciated to let me know if I'm missing
> > something.
> 
> I see that you've moved a substantial amount of code out of arch/x86.
> That's great.
> 
> But there doesn't appear to be any improvement in the justification or
> performance data.  The page flag is also here, which is horribly frowned
> upon.  It's an absolute no-go with this level of justification.
> 
> I'd really suggest not sending any more of these out until those issues
> are rectified.  I know I definitely won't be reviewing them in this state.

As I expected, I got a fair better result when I tested migrc with a
system with a slower DRAM to make TLB miss overhead stand out.

   1. XSBench execution time was reduced about 7%.
   2. iTLB flush # was reduced stably about 90% while running XSBench.
   3. iTLB miss # was reduced stably about 50% while running XSBench.

https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/

Of course, I can reimplement migrc to replace PG_migrc with another
thing like hash table but, IMHO, it's worth having the page flag if it
gives such a good performance. Lemme know if not so that I'll change the
way to implement.

I'd like to note that no doubt migrc significantly reduces TLB miss and
the impact depends on TLB miss overhead that varies according to the
system configuration.

	Byungchul
