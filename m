Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5C7A5A27
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjISGtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjISGtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:49:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA5D100
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:49:16 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-770ef353b8fso347654685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695106156; x=1695710956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZcLvNMvIS9630ZAJ+yWXO2chaibTNPALRuIptGLqe0=;
        b=L2maTsKB5kYx0lWvbpd4cj7zYx3bMt32aFAZ35hUgWtNWPu7eLKdnT0XgzZmoUE0gD
         LUM0z50nZAfGm9KzyDMozfDnfWycxe0UhalJ1Dwkbrhcj57CfxND7zaaFpZ+R3JtZjxO
         cpQtG990KrvCrl3T1uDXTeJLBV9FSr5iTQMQtm/n7G3tVYWslWV+2Mm4eVH0/OrqdGLf
         p+cwCntQtGeRp5zan4NqG5LDzwf2A5E2hXjMvShlftXp/gSazsU3CYT4m7ZZhSJLkv84
         uxjt4/UUqZwKc0y2Dlgul8wRQ7XeHiAOxhVOro1KBxFCfiROCKrPdsBNXawm9/GqUb+t
         d7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695106156; x=1695710956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZcLvNMvIS9630ZAJ+yWXO2chaibTNPALRuIptGLqe0=;
        b=Tne/5qhFZZOYruVCqnQC89NbKtTQP69WLokev9Ih4KbAi6J8TVjq5I2EWRJyhrpUZT
         rfdKnAIy4pAyRkXVQ4Jq3ZvDA+tEDoDRxMP39LZyGl7ebYuJE23R3+3Wbn7ZXc3f+ojC
         c2SB+o6mwcH583AzSk4k86X66ZdWRhdxv5xqx3mN2TSOkaRmAH/RonK0m7Y2UudO/efi
         HjDYEE1eQSuZojKeIpVG2n1bUIeqxgY0dGKv1GcjP9FL+zK+D0VGkIDgNTJLThgKJn0c
         QmBf6+4l3RpvGtrpO+mIel9yECUw561f4UhAdKAeqxP0xpLv+46vcSC8UV2SE7u1Foi8
         BDBw==
X-Gm-Message-State: AOJu0Yw9yn0N+ggsVZE5GMvxCpBix8U6gKpKWIqPHmVr5lfIEkhAxhyY
        6tzfk4x1EksmCiUshojwn6/UiQ==
X-Google-Smtp-Source: AGHT+IHksFiKt0PJEIwkyv9eFPRmrlk6ySx1p5wt3SuN8Nni1F8mtf+FFpG9Fny9ralr+52sk7mFLQ==
X-Received: by 2002:a05:620a:5629:b0:76c:da86:3169 with SMTP id vv9-20020a05620a562900b0076cda863169mr10871733qkn.40.1695106155658;
        Mon, 18 Sep 2023 23:49:15 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a071000b007671b599cf5sm3747079qkc.40.2023.09.18.23.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 23:49:15 -0700 (PDT)
Date:   Tue, 19 Sep 2023 02:49:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230919064914.GA124289@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey>
 <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org>
 <20230918174037.GA112714@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918174037.GA112714@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:40:37AM -0700, Mike Kravetz wrote:
> On 09/18/23 10:52, Johannes Weiner wrote:
> > On Mon, Sep 18, 2023 at 09:16:58AM +0200, Vlastimil Babka wrote:
> > > On 9/16/23 21:57, Mike Kravetz wrote:
> > > > On 09/15/23 10:16, Johannes Weiner wrote:
> > > >> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
> > > > 
> > > > With the patch below applied, a slightly different workload triggers the
> > > > following warnings.  It seems related, and appears to go away when
> > > > reverting the series.
> > > > 
> > > > [  331.595382] ------------[ cut here ]------------
> > > > [  331.596665] page type is 5, passed migratetype is 1 (nr=512)
> > > > [  331.598121] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:662 expand+0x1c9/0x200
> > > 
> > > Initially I thought this demonstrates the possible race I was suggesting in
> > > reply to 6/6. But, assuming you have CONFIG_CMA, page type 5 is cma and we
> > > are trying to get a MOVABLE page from a CMA page block, which is something
> > > that's normally done and the pageblock stays CMA. So yeah if the warnings
> > > are to stay, they need to handle this case. Maybe the same can happen with
> > > HIGHATOMIC blocks?

Ok, the CMA thing gave me pause because Mike's pagetypeinfo didn't
show any CMA pages.

5 is actually MIGRATE_ISOLATE - see the double use of 3 for PCPTYPES
and HIGHATOMIC.

> > This means we have an order-10 page where one half is MOVABLE and the
> > other is CMA.

This means the scenario is different:

We get a MAX_ORDER page off the MOVABLE freelist. The removal checks
that the first pageblock is indeed MOVABLE. During the expand, the
second pageblock turns out to be of type MIGRATE_ISOLATE.

The page allocator wouldn't have merged those types. It triggers a bit
too fast to be a race condition.

It appears that MIGRATE_ISOLATE is simply set on the tail pageblock
while the head is on the list, and then stranded there.

Could this be an issue in the page_isolation code? Maybe a range
rounding error?

Zi Yan, does this ring a bell for you?

I don't quite see how my patches could have caused this. But AFAICS we
also didn't have warnings for this scenario so it could be an old bug.

> > Mike, could you describe the workload that is triggering this?
> 
> This 'slightly different workload' is actually a slightly different
> environment.  Sorry for mis-speaking!  The slight difference is that this
> environment does not use the 'alloc hugetlb gigantic pages from CMA'
> (hugetlb_cma) feature that triggered the previous issue.
> 
> This is still on a 16G VM.  Kernel command line here is:
> "BOOT_IMAGE=(hd0,msdos1)/vmlinuz-6.6.0-rc1-next-20230913+
> root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0
> console=ttyS0,115200 audit=0 selinux=0 transparent_hugepage=always
> hugetlb_free_vmemmap=on"
> 
> The workload is just running this script:
> while true; do
>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> done
> 
> > 
> > Does this reproduce instantly and reliably?
> > 
> 
> It is not 'instant' but will reproduce fairly reliably within a minute
> or so.
> 
> Note that the 'echo 4 > .../hugepages-1048576kB/nr_hugepages' is going
> to end up calling alloc_contig_pages -> alloc_contig_range.  Those pages
> will eventually be freed via __free_pages(folio, 9).

No luck reproducing this yet, but I have a question. In that crash
stack trace, the expand() is called via this:

 [  331.645847]  get_page_from_freelist+0x3ed/0x1040
 [  331.646837]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
 [  331.647977]  __alloc_pages+0xec/0x240
 [  331.648783]  alloc_buddy_hugetlb_folio.isra.0+0x6a/0x150
 [  331.649912]  __alloc_fresh_hugetlb_folio+0x157/0x230
 [  331.650938]  alloc_pool_huge_folio+0xad/0x110
 [  331.651909]  set_max_huge_pages+0x17d/0x390

I don't see an __alloc_fresh_hugetlb_folio() in my tree. Only
alloc_fresh_hugetlb_folio(), which has this:

        if (hstate_is_gigantic(h))
                folio = alloc_gigantic_folio(h, gfp_mask, nid, nmask);
        else
                folio = alloc_buddy_hugetlb_folio(h, gfp_mask,
                                nid, nmask, node_alloc_noretry);

where gigantic is defined as the order exceeding MAX_ORDER, which
should be the case for 1G pages on x86.

So the crashing stack must be from a 2M allocation, no? I'm confused
how that could happen with the above test case.
