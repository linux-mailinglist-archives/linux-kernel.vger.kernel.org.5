Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B6177D884
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbjHPCn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjHPCnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:43:40 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0665D212B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:43:37 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-09-64dc37d8d9e5
Date:   Wed, 16 Aug 2023 11:40:41 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20230816024041.GA16281@system.software.com>
References: <20230804061850.21498-1-byungchul@sk.com>
 <20230804061850.21498-3-byungchul@sk.com>
 <877cpx9jsx.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20230816001307.GA44941@system.software.com>
 <87r0o37qcn.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0o37qcn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC9ZZnoe4N8zspBiu+W1nMWb+GzeLFhnZG
        i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwW13c9ZLQ43nuAyeL3D6DsnClWFidn
        TWZx4PVYsKnUY/MKLY/Fe14yeWxa1cnmsenTJHaPEzN+s3jsfGjpMe9koMf7fVfZPLb+svP4
        vEnO4938t2wBPFFcNimpOZllqUX6dglcGZemLmIuOCBecf7cG/YGxlahLkZODgkBE4k3kycx
        w9i9V3YwgdgsAqoSC1ecYQWx2QTUJW7c+AlWIyKgIfFp4XJ2EJtZYBuTxIJ7DiC2sECMxIkt
        n8F6eQUsJG73f2fsYuTiEBL4wSixf9cVNoiEoMTJmU9YIJq1JG78ewnUwAFkS0ss/8cBEuYU
        sJP4fnIy2HxRAWWJA9uOM4HMkRBoZpdYsO0CE8ShkhIHV9xgmcAoMAvJ2FlIxs5CGLuAkXkV
        o1BmXlluYmaOiV5GZV5mhV5yfu4mRmBMLav9E72D8dOF4EOMAhyMSjy8DAtvpwixJpYVV+Ye
        YpTgYFYS4e3hvZUixJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJ
        g1OqgTH41o5iuUvNTd0XFK/sWl2QIML57+q8TywTsiW0lzr/4Fv9OVVKzfPFO/fTP6s+xSRt
        +styo56NgWf+m74FG7eIL/49JbBp3yMdIe/tSbz3lBznMHPFJRjwLdbU8vBP5nVZ+jopYrd2
        Uq22mnZyw15u9fj6TxMcfqv9LdFdy+gaEHy96++iG0osxRmJhlrMRcWJAFun5sulAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsXC5WfdrHvD/E6Kwf1F2hZz1q9hs3ixoZ3R
        4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCyu73rIaHG89wCTxe8fQNk5
        U6wsTs6azOLA57FgU6nH5hVaHov3vGTy2LSqk81j06dJ7B4nZvxm8dj50NJj3slAj/f7rrJ5
        LH7xgclj6y87j8+b5DzezX/LFsAbxWWTkpqTWZZapG+XwJVxaeoi5oID4hXnz71hb2BsFepi
        5OSQEDCR6L2ygwnEZhFQlVi44gwriM0moC5x48ZPZhBbREBD4tPC5ewgNrPANiaJBfccQGxh
        gRiJE1s+g/XyClhI3O7/ztjFyMUhJPCDUWL/ritsEAlBiZMzn7BANGtJ3Pj3EqiBA8iWllj+
        jwMkzClgJ/H95GSw+aICyhIHth1nmsDIOwtJ9ywk3bMQuhcwMq9iFMnMK8tNzMwx1SvOzqjM
        y6zQS87P3cQIjJBltX8m7mD8ctn9EKMAB6MSDy/DwtspQqyJZcWVuYcYJTiYlUR4e3hvpQjx
        piRWVqUW5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwRp15zp1wz2DL
        8uQzoV9VHsUrbQ5zmJDwuqj/yqWsdc5R1748bkpZp25l0n3q+9OtlYymHIsCFyYXeQUrfFJQ
        fp8c+qpbU3N3acX87UfUdd/tiz74e/XFA5W/3srfUC128LnJdvvNSn61rwoO6lrXPJk1Zu6f
        duGN9OlD7Oc2CWz69XK7yf9pbEosxRmJhlrMRcWJAFSHrKWMAgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:01:12AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Tue, Aug 15, 2023 at 09:27:26AM +0800, Huang, Ying wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
> >> >
> >> > We always face the migration overhead at either promotion or demotion,
> >> > while working with tiered memory e.g. CXL memory and found out TLB
> >> > shootdown is a quite big one that is needed to get rid of if possible.
> >> >
> >> > Fortunately, TLB flush can be defered or even skipped if both source and
> >> > destination of folios during migration are kept until all TLB flushes
> >> > required will have been done, of course, only if the target PTE entries
> >> > have read only permission, more precisely speaking, don't have write
> >> > permission. Otherwise, no doubt the folio might get messed up.
> >> >
> >> > To achieve that:
> >> >
> >> >    1. For the folios that have only non-writable TLB entries, prevent
> >> >       TLB flush by keeping both source and destination of folios during
> >> >       migration, which will be handled later at a better time.
> >> >
> >> >    2. When any non-writable TLB entry changes to writable e.g. through
> >> >       fault handler, give up CONFIG_MIGRC mechanism so as to perform
> >> >       TLB flush required right away.
> >> >
> >> >    3. TLB flushes can be skipped if all TLB flushes required to free the
> >> >       duplicated folios have been done by any reason, which doesn't have
> >> >       to be done from migrations.
> >> >
> >> >    4. Adjust watermark check routine, __zone_watermark_ok(), with the
> >> >       number of duplicated folios because those folios can be freed
> >> >       and obtained right away through appropreate TLB flushes.
> >> >
> >> >    5. Perform TLB flushes and free the duplicated folios pending the
> >> >       flushes if page allocation routine is in trouble due to memory
> >> >       pressure, even more aggresively for high order allocation.
> >> 
> >> Is the optimization restricted for page migration only?  Can it be used
> >> for other places?  Like page reclaiming?
> >
> > Just to make sure, are you talking about the (5) description? For now,
> > it's performed at the beginning of __alloc_pages_slowpath(), say, before
> > page recaiming. Do you think it'd be meaningful to perform it during page
> > reclaiming? Or do you mean something else?
> 
> Not for (5).  TLB needs to be flushed during page reclaiming too.  Can
> similar method be used to reduce TLB flushing there too?

Hm.. The mechanism can be used in any places where page mapping is
changing but it requires not to have write permission that might mess up
consistancy with more than one copy of page.

JFYI, one of future works is to detect read mostly pages and turn them
to read only to make use of them iff it gives a better performance.

	Byungchul
