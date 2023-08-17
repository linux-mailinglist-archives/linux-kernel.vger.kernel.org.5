Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C869077F1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbjHQITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348871AbjHQITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:19:37 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E8D42D70
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:19:29 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-8b-64ddd81085dc
Date:   Thu, 17 Aug 2023 17:16:31 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20230817081631.GA48308@system.software.com>
References: <20230804061850.21498-1-byungchul@sk.com>
 <20230804061850.21498-3-byungchul@sk.com>
 <877cpx9jsx.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cpx9jsx.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsXC9ZZnka7AjbspBr9eGFrMWb+GzeLr+l/M
        Fk8/9bFYXN41h83i3pr/rBY7lu5jsri+6yGjxe8fQLE5U6wsTs6azOLA5bFgU6nH5hVaHov3
        vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH1l92Hp83yXm8m/+WLYArissmJTUnsyy1SN8ugSuj
        7dQhxoLbAhWTn89hbmB8xNPFyMEhIWAisekLkMkJZt5eeo8FJMwioCpx/VY0SJhNQF3ixo2f
        zCC2iICGxKeFy9m7GLk4mAU+MEq82PqEDSQhLBAjcWLLZyYQm1fAQmLuxFVsIEVCAlMZJebM
        28IMkRCUODnzCQuIzSygJXHj30smkGXMAtISy/9xgIQ5Bewk1i68AFYuKqAscWDbcSaQORIC
        z9kkZtzZzwZxqKTEwRU3WCYwCsxCMnYWkrGzEMYuYGRexSiUmVeWm5iZY6KXUZmXWaGXnJ+7
        iREYIctq/0TvYPx0IfgQowAHoxIPr8OuOylCrIllxZW5hxglOJiVRHh7eG+lCPGmJFZWpRbl
        xxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamB083L4LLjC2PrizCiZsMy5
        jvP65s9W1bknpyavo3q6cVv0pr93veWt/d4pyu+ocxERW3Tz/KEDnDPVWz1WFqzSuDFF5lFi
        deOkP4e/pAtcy5fKDzwXuWF390/XjXpF2uqVE75t66041WrMXLRC4fD26R+MZz5ImnHDQ1mB
        O+TA/b+PJT9c2NutxFKckWioxVxUnAgA2aTwrIwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXC5WfdrCtw426KwcJWJYs569ewWXxd/4vZ
        4umnPhaLw3NPslpc3jWHzeLemv+sFjuW7mOyuL7rIaPF7x9AsTlTrCxOzprM4sDtsWBTqcfm
        FVoei/e8ZPLY9GkSu8eJGb9ZPHY+tPR4v+8qm8fiFx+YPLb+svP4vEnO4938t2wB3FFcNimp
        OZllqUX6dglcGW2nDjEW3BaomPx8DnMD4yOeLkZODgkBE4nbS++xdDFycLAIqEpcvxUNEmYT
        UJe4ceMnM4gtIqAh8WnhcvYuRi4OZoEPjBIvtj5hA0kIC8RInNjymQnE5hWwkJg7cRUbSJGQ
        wFRGiTnztjBDJAQlTs58wgJiMwtoSdz495IJZBmzgLTE8n8cIGFOATuJtQsvgJWLCihLHNh2
        nGkCI+8sJN2zkHTPQuhewMi8ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzDgl9X+mbiD8ctl
        90OMAhyMSjy8DrvupAixJpYVV+YeYpTgYFYS4e3hvZUixJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwLh+EUdknsKNS94x2yXnNlubcRbcbdLJeV19UV0t
        VXVawoe7VXdStDLnP3hskG31/OO8k1GdBstPLfK43qe3ML8rPz6kudfyhxMbw3axN4rVBVFc
        D1QT88NkVk5mSMlrsni358rCew8WGJm4XNr570Zt7K/EEwWs/eJv6lYxbdm6z+zGz09qfUos
        xRmJhlrMRcWJAGr5CbV0AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:27:26AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
> >
> > We always face the migration overhead at either promotion or demotion,
> > while working with tiered memory e.g. CXL memory and found out TLB
> > shootdown is a quite big one that is needed to get rid of if possible.
> >
> > Fortunately, TLB flush can be defered or even skipped if both source and
> > destination of folios during migration are kept until all TLB flushes
> > required will have been done, of course, only if the target PTE entries
> > have read only permission, more precisely speaking, don't have write
> > permission. Otherwise, no doubt the folio might get messed up.
> >
> > To achieve that:
> >
> >    1. For the folios that have only non-writable TLB entries, prevent
> >       TLB flush by keeping both source and destination of folios during
> >       migration, which will be handled later at a better time.
> >
> >    2. When any non-writable TLB entry changes to writable e.g. through
> >       fault handler, give up CONFIG_MIGRC mechanism so as to perform
> >       TLB flush required right away.
> >
> >    3. TLB flushes can be skipped if all TLB flushes required to free the
> >       duplicated folios have been done by any reason, which doesn't have
> >       to be done from migrations.
> >
> >    4. Adjust watermark check routine, __zone_watermark_ok(), with the
> >       number of duplicated folios because those folios can be freed
> >       and obtained right away through appropreate TLB flushes.
> >
> >    5. Perform TLB flushes and free the duplicated folios pending the
> >       flushes if page allocation routine is in trouble due to memory
> >       pressure, even more aggresively for high order allocation.
> 
> Is the optimization restricted for page migration only?  Can it be used
> for other places?  Like page reclaiming?

I don't get you but if I'm missing something here and your idea is
something good, then it can be a future work.

	Byungchul
