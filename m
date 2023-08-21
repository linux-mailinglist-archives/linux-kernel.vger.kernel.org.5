Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137F178213B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjHUBcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjHUBcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:32:18 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B9BAA3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:31:44 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-a6-64e2be5bc41e
Date:   Mon, 21 Aug 2023 10:28:05 +0900
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
Message-ID: <20230821012804.GA43847@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC9ZZnoW70vkcpBq8+6FjMWb+GzeLFhnZG
        i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwW13c9ZLQ43nuAyeL3D6DsnClWFidn
        TWZx4PVYsKnUY/MKLY/Fe14yeWxa1cnmsenTJHaPEzN+s3jsfGjpMe9koMf7fVfZPLb+svP4
        vEnO4938t2wBPFFcNimpOZllqUX6dglcGbvO9bMV/BKteDrlKVsD4xuBLkZODgkBE4knrYfZ
        YeznG+6xgNgsAqoSP/YfYQWx2QTUJW7c+MkMYosIaEh8WrgcrJ5ZYBuTxIJ7DiC2sECMxIkt
        n5lAbF4BC4lrD9sZuxi5OIQEfjBK7N91hQ0iIShxcuYTFohmLYkb/14CNXAA2dISy/9xgIQ5
        Bewkvp+cDDZfVEBZ4sC240wgcyQEmtklNp6/yQhxqKTEwRU3WCYwCsxCMnYWkrGzEMYuYGRe
        xSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYU8tq/0TvYPx0IfgQowAHoxIPb4LMoxQh1sSy4src
        Q4wSHMxKIrzS3x+mCPGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl
        4uCUamAsmxHs+Wap8M0TnFJ5fm05mvEzoyru7ig/b5FTt9/OzkaIUdrr++rTXi9/S2sJ6vCe
        FLixKvJz7QL9SdElv76v79XpfSwpXFy74d4S9Ye5B2aolfR/9tMRr1tz7HnhoeC/4Xbh92fs
        W79Jb8GkGd17r2x/lNj2S3/Kog1eBj9YMvs5/k1qMfuixFKckWioxVxUnAgAA8kjM6UCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsXC5WfdrBu971GKwdKXahZz1q9hs3ixoZ3R
        4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCyu73rIaHG89wCTxe8fQNk5
        U6wsTs6azOLA57FgU6nH5hVaHov3vGTy2LSqk81j06dJ7B4nZvxm8dj50NJj3slAj/f7rrJ5
        LH7xgclj6y87j8+b5DzezX/LFsAbxWWTkpqTWZZapG+XwJWx61w/W8Ev0YqnU56yNTC+Eehi
        5OSQEDCReL7hHguIzSKgKvFj/xFWEJtNQF3ixo2fzCC2iICGxKeFy9lBbGaBbUwSC+45gNjC
        AjESJ7Z8ZgKxeQUsJK49bGfsYuTiEBL4wSixf9cVNoiEoMTJmU9YIJq1JG78ewnUwAFkS0ss
        /8cBEuYUsJP4fnIy2HxRAWWJA9uOM01g5J2FpHsWku5ZCN0LGJlXMYpk5pXlJmbmmOoVZ2dU
        5mVW6CXn525iBEbIsto/E3cwfrnsfohRgINRiYc3QeZRihBrYllxZe4hRgkOZiURXunvD1OE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGKddscz3Phgg
        l3HzqqRB0Ckt+zaxlOr/doFqEzseLXbh0Cu9/fuAWmSB3ZYJgYczWZS91bo3n3zzm/GM/DOe
        xZFq70OyDT5cvtzEqsEaYPgm7orpi6Kii7X7Ij6GH5iR2/Yhz1uqrXfapPhT9+a3lx6rT7fj
        8avN/pF10P7f+S1K6yv2dImqK7EUZyQaajEXFScCAMmg4uWMAgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

If you were talking about unmapping for swap while reclaiming, then I
think yes. The case can also take benefit from CONFIG_MIGRC.

	Byungchul
