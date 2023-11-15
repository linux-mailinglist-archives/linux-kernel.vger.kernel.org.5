Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F97EBCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjKOFs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOFs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:48:58 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77E41D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 21:48:53 -0800 (PST)
X-AuditID: a67dfc5b-d85ff70000001748-7f-65545bc4131e
Date:   Wed, 15 Nov 2023 14:48:46 +0900
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
Message-ID: <20231115054846.GA74107@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
 <20231108041208.GA40954@system.software.com>
 <C47A7C40-BE3E-4F0F-B854-D40D4795A236@vmware.com>
 <20231110010201.GA72073@system.software.com>
 <20231110031347.GA62514@system.software.com>
 <0EC1ED50-2370-4EA6-9A02-D36E1913224E@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0EC1ED50-2370-4EA6-9A02-D36E1913224E@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsXC9ZZnke6R6JBUgyctkhZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CVcfby
        J5aCWRIVl1feZ2xg/CnUxcjJISFgIrFi2xk2GPvCl8tMIDaLgKrE/aZmdhCbTUBd4saNn8wg
        toiAosSh/fcYQWxmgXesEt8/aYLYwgLREp/2vgKr5xWwkNj+qg+ohotDSGAns8TNKROYIRKC
        EidnPmGBaFaX+DPvElCcA8iWllj+jwMiLC/RvHU2WDmngJ3Esm+nWUFsUQFliQPbjjOBzJQQ
        2MUu8eDmfXaIoyUlDq64wTKBUXAWkhWzkKyYhbBiFpIVCxhZVjEKZeaV5SZm5pjoZVTmZVbo
        JefnbmIERu2y2j/ROxg/XQg+xCjAwajEw9swMzhViDWxrLgy9xCjBAezkgivuVxIqhBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbG9Y7Zbfcv/HnibXZc
        ZPkBz1f1U4QE3oR8kNgTuWKnabAem8a+WTtOtDU1RqVfbzrmKeu4kcmz+OmSx7EltROasmYm
        ySjW9J0/cljzfAcnn+VhDZ+Eg7oX9y76bnPP5OftB6nvFP/6G5l+v7j1+sVLxjt/K6WUBAbv
        Nt23bY3E6T2nFZ4+CWbhUGIpzkg01GIuKk4EAH8DeNPWAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC5WfdrHskOiTV4N5FVos569ewWXze8I/N
        4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
        jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
        sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPxS8+MHls/WXn8XmTnMe7+W/ZAvijuGxSUnMy
        y1KL9O0SuDLOXv7EUjBLouLyyvuMDYw/hboYOTkkBEwkLny5zARiswioStxvamYHsdkE1CVu
        3PjJDGKLCChKHNp/jxHEZhZ4xyrx/ZMmiC0sEC3xae8rsHpeAQuJ7a/6gGq4OIQEdjJL3Jwy
        gRkiIShxcuYTFohmdYk/8y4BxTmAbGmJ5f84IMLyEs1bZ4OVcwrYSSz7dpoVxBYVUJY4sO04
        0wRGvllIJs1CMmkWwqRZSCYtYGRZxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERiDy2r/TNzB
        +OWy+yFGAQ5GJR7ehpnBqUKsiWXFlbmHGCU4mJVEeM3lQlKFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGDuX7xRKqedfHr9I+ejipXtn+BsbrjluyhTp
        lP/Lz+X1HaWc2zbLrkjy3D5UmZx5Qs2G7R9LBOsvtdW3pn/ITV6y0vFF1gdtXq6pJ/ZpKzc4
        X5kWEdSjvcXGrnRh0S1Hg4Ssecz/yzcpL1zh/esrk+dtzebrS3OWSkVdP/vK9vRftUD9E8s2
        5iixFGckGmoxFxUnAgC1o6PhvQIAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 10:18:06PM +0000, Nadav Amit wrote:
> > On Nov 10, 2023, at 5:13 AM, Byungchul Park <byungchul@sk.com> wrote:
> > 
> > 
> >> Here,
> >> 
> >> mprotect()
> >>   do_mprotect_pkey()
> >>      tlb_finish_mmu()
> >>         tlb_flush_mmu()
> >> 
> >> I thought TLB flush for mprotect() is performed by tlb_flush_mmu() so
> >> any cached TLB entries on other CPUs can have chance to update. Could
> >> you correct me if I get it wrong? Thanks.
> > 
> > I guess you tried to inform me that x86 mmu automatically keeps the
> > consistancy based on cached TLB entries. Right? If yes, I should do
> > something on that path. If not, it's not problematic. Thoughts?
> 
> Perhaps I lost something in this whole scheme. Overall, I find it overly
> complicated and somewhat hard to follow.
> 
> Ideally, a solution should reduce the number of TLB flushing mechanisms
> and not introduce yet another one that would further increase the already
> high complexity.
> 
> Anyhow, I a bit convoluted 2 scenarios, and I’m not sure whether they
> are a potential problem.
>
> (1) Assume there is a RO page migration and you skipped a TLB flush.
> Then you set a RO PTE entry for that page. Afterwards, you have mprotect()
> that updates the PTE for that page to be RW.
> 
> Now, tlb_finish_mmu() will do a TLB flush eventually in the mprotect()
> flow, but until it is done, you might have one CPU have RO pointing to
> the source page (no TLB flush, right?) and another having RW access

Is it possible for there to be another having RW access even before
mprotect() is done?

> that were loaded from the updated PTE. Did I miss a TLB flush that
> should take place beforehand?
> 
> 
> (2) Indeed we encountered many problems when TLB flushing decisions
> are based on PTEs that are read from the page-tables and those do
> not reflect the values that are held in the TLBs.

Do you have any example to help me understand what you mean?

> Overall, I think that a solution is to consolidate the TLB batching
> mechanisms and hold per a group of PTEs (e.g., 512 PTEs held in one
> page-table) the deferred TLB flush generation. Track the “done” TLB
> flush generation, if the deferred is greater than the “done”, perform
> a TLB flush.
>
> This scheme is a bit similar to what you were doing, but more general,
> and easier to follow. I think that its value might be more in simplifying
> the code and reasoning than just performance.

Worth noting that, at the beginning, I tried to reduce TLB flushes by:

	1. deferring and performing TLB flushes needed in a batch,
	2. skipping some TLB flushes that have already been done.

However, I gave up the 2nd optimization to keep only architecture
independent code in the patch set. So the current migrc version couldn't
skip TLB flushes but does only deferring and batching TLB flushes until
it's inevitable.

To cut a long story short, migrc let any other TLB flushes go performed
as is, *except* a special case e.i. RO mapped folios, during migration.

	Byungchul
