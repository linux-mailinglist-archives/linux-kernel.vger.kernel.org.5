Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D520B7AF586
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjIZUry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbjIZUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:47:51 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA12139
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:47:43 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59f6441215dso75978257b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695761262; x=1696366062; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1S9w5O9YAxaryW06sBN3R7x44RvnVfU5wnpnkpC1rZI=;
        b=KzJb7Z7+fBbtsaJkh7VA8o+cRCEo2EH/Ek6OfhYL/qm0ZYKpC3IKZvVZ5mwKSkTFU/
         RmX2KLWnRMX7hZI8+02NVlETyhjaBbnRheq07umtXH56KpVMCDzcrXGNjvQtSeTR99jU
         6bdXMYvbvww28p6ncRk61+SEPzv6ReLJluEHejMHUayN7/haYL/DUH6lHOSVe8FlYxhr
         8T7pG2WfbHAPIciwasVpxjRLc8PxmycLlC4GjVk4Gmzs5yzd6n99o+c00tuzd5OORfc8
         GqbxlbJiyRzCS0WuMUeoHjkaZUtPcYz74G6zBhtOL0zTW7tjAuVvy9kKh5VAjVc17B/T
         gylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761262; x=1696366062;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1S9w5O9YAxaryW06sBN3R7x44RvnVfU5wnpnkpC1rZI=;
        b=pzOO/VeGiLfUedGUzMMCSJRVQIPLu++YVAf2r1J4sbcVOD74OdmkecjI+oUE+KU+Bh
         Qj2JVQ36UJdiYw53qvTaQIENG0MyPY1MiZD2So9co/NDqNfIHvqTzvdA1OgV0k5ztly1
         0wl5CcuOvwYuwzEt4wYMl1mbePAgOFpYSYkJhzJ+qOwiO5HgAuxoQjV3y/4jtxiqaDdh
         MzRT1RAuDabY7DKvomIvvDTKNglY0q2jSVBSHWDYPrnyalPUdEsqkuri0dMRbNgfcpWz
         Zb4/Y5LkPBClzYQ9/E2U7XifjnsloAbzae0977STTMnKpnISXeHvIpydB7KhDR5A6run
         8UNw==
X-Gm-Message-State: AOJu0YzaeXZGVfrua7XcWr1OLyTzPtC8HX/CbO9n+RAPOhbT2tDIRgRX
        qOnBKhOZ+/DQqzHdF9JMhnngMA==
X-Google-Smtp-Source: AGHT+IEj95JDcUk9vMCjVVUOULMct3B5wjZR/7G6kto4XvQuG7gqpKuMfEuLi4DrhE2dbIxBDgfzrQ==
X-Received: by 2002:a81:7286:0:b0:59b:bacb:a84f with SMTP id n128-20020a817286000000b0059bbacba84fmr111050ywc.47.1695761262182;
        Tue, 26 Sep 2023 13:47:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y206-20020a81a1d7000000b00592a0cad26esm3201981ywg.26.2023.09.26.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:47:40 -0700 (PDT)
Date:   Tue, 26 Sep 2023 13:47:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 03/12] mempolicy: fix migrate_pages(2) syscall return
 nr_failed
In-Reply-To: <ZRIIIFm5IMnkGh3T@casper.infradead.org>
Message-ID: <20de9b0-39fd-76bf-ea7f-3e9df0dd79d9@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com> <ddad2cee-cbad-7b5d-935a-59f961b7c3a@google.com> <ZRIIIFm5IMnkGh3T@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023, Matthew Wilcox wrote:
> On Mon, Sep 25, 2023 at 01:24:02AM -0700, Hugh Dickins wrote:
> > "man 2 migrate_pages" says "On success migrate_pages() returns the number
> > of pages that could not be moved".  Although 5.3 and 5.4 commits fixed
> > mbind(MPOL_MF_STRICT|MPOL_MF_MOVE*) to fail with EIO when not all pages
> > could be moved (because some could not be isolated for migration),
> > migrate_pages(2) was left still reporting only those pages failing at the
> > migration stage, forgetting those failing at the earlier isolation stage.
> > 
> > Fix that by accumulating a long nr_failed count in struct queue_pages,
> > returned by queue_pages_range() when it's not returning an error, for
> > adding on to the nr_failed count from migrate_pages() in mm/migrate.c.
> > A count of pages?  It's more a count of folios, but changing it to pages
> > would entail more work (also in mm/migrate.c): does not seem justified.
> 
> I certainly see what you're saying.  If a folio is only partially mapped
> (in an extreme case, the VMA is PAGE_SIZE and maps one page of a 512-page
> folio), then setting nr_failed to folio_nr_pages() is misleading at best.

Actually, that wasn't what I was thinking when I said that: but thank you
for the comment, you've helped me to see that what I'm actually doing is
not what is claimed there.

What I was thinking, something I'm taking as an axiom, is that the units
of failure when isolating must match the units of failure when migrating,
whatever they are.

And migrate_pages(), the internal one, has this helpfully explicit comment:
 * Returns the number of {normal folio, large folio, hugetlb} that were not
 * migrated, or an error code. The number of large folio splits will be
 * considered as the number of non-migrated large folio, no matter how many
 * split folios of the large folio are migrated successfully.

(TBH I haven't spent long enough to actually understand what the second
sentence is saying: I do realize that splits complicate the issue, but the
function wouldn't be expected to return a "number of large folio splits"
anyway.  One day, I should work out what the code is actually doing, and
try to reword that sentence better.)

So above I was trying to say that migrate_pages(), the syscall, returns
that quantity: totalling the failed-isolation and failed-migration folios.

But you've alerted me to how in fact I'm doing an nr_failed++ for each
PTE of a failing-to-isolate folio, not as claimed.  It looks like I need
to record "qp->large" in the case of failure as well as success.  (And
then bother about when isolation fails on the first PTE, but succeeds
by the time of a later PTE? maybe, or maybe that just gets silly.)
I must fix that in v2.

> 
> > +static void queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> >  				unsigned long end, struct mm_walk *walk)
...
> > +	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
> > +	    !vma_migratable(walk->vma) ||
> > +	    !migrate_folio_add(folio, qp->pagelist, qp->flags))
> > +		qp->nr_failed++;
> 
> However, I think here, we would do well to increment by HPAGE_PMD_NR.
> Or whatever equivalent is flavour of the week.

I *really* wanted to do that (and increment nr_failed PTE by PTE as I'm
doing, rather than as I claimed), and gave it some thought: but I don't
think it can be done - or not without abandoning the axiom (in which
case it's impossible to say what migrate_pages(2) is counting), or
adding a layer of complication which simply isn't justifiable.

Certainly we could change the definition of what migrate_pages(internal)
returns (though I haven't researched who depends on it: IIRC-long-ago
there's maybe only one other caller who cares, to update a stat); but
that still would not help.  Because whether migrate_pages(internal)
returns 1 or HPAGE_PMD_NR for an unmigratable and unsplittable THP, it
has no idea whether that THP got into the pagelist via a PMD or via one
or some number more of PTEs.  More info would have to be passed down
separately, folio by folio: an auxiliary xarray perhaps, but let's not.

If it turns out that I'm deluded, and it can be easily done, please
clarify one point: you made this comment on queue_folios_pmd(), but
what about queue_folios_hugetlb()?  Would you nowadays prefer hugetlb
to count 1 or folio_nr_pages()?  I think the latter.

> 
> Bravo to the other changes.

Thanks - I'm guessing your enthusiasm is mainly due to that "qp->large"
realization, which we ought to have thought of before.  I'm afraid it's
going to get more complicated, once COWs are feeding on Ryan's ALFalfA -
might need large[MAX_ORDER], or some better way.  But no great hurry,
nothing will crash if it's occasionally not-quite-right.

> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Many thanks for all these rapid and encouraging reviews.

Hugh
