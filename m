Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922CA7D406E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjJWTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjJWTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:48:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E6B4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:48:51 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7ad24b3aaso38622097b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698090531; x=1698695331; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjX0MTPG3PvWqJGdMc/rfblXRp2Xo1J9VRn/MIM6Ez4=;
        b=2+8Bl4x2M7K50L3BMgxIEBOg9oImIq1RCIJaX+qbNMBJ0yxA3fafiaMC9IMReVUn3/
         LTXZ2ycKvb6MRzenDTsp6hlUfo5KAvgC81vFc68f01zJ9unPr5c+oNlGpnWjBF1d9p1H
         hNc1NoJp2qDQfy9VaJKRH+qZo/OlToAa6RRkhqbk6+Tcu+HRtHR4dpIcJzxrsnzdKQ3h
         cSVvlTf+rlO5XvxgUm+xZk7esKbymOWpCug2niar3F753/d4rQpaELpTwG3k8vNa2khV
         KUqnYO3ctOCN3n/WiV4wlW6cYegFY4nMwJSfmX7iPaYb43ftNGeg/EnKRsEyuKlLx5FB
         w9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090531; x=1698695331;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjX0MTPG3PvWqJGdMc/rfblXRp2Xo1J9VRn/MIM6Ez4=;
        b=heDEFXwLfM3Jb2Hc7xmMdNwp8YzVYWy54YZPetJzkxIRI7ndI+jYSl4i89dx3ZcDPl
         7y2tsNcs47wXTZCD0/pBvknTB/GAnfBG3gXO6+PIgBJYqkxpViLWJ0bDP1p07zMyLSzf
         FqsE9ADtHTXmOGWe5bjW6z2xgEisrecp3FFYD5whcfX4mzTgbWvmlV1tDqfdRuSii10B
         UbM0DxLSvnzZILokBm8N2ar9l5xlCFOVTblh9oJbX36WWeSnggNSfa943k1M1UX/dORh
         YJATWMCK9hyNOSllsfrb6bssGW3cFTzfEEGMLLw8XowVK1REBNOAxxOCN2b9ITt7/pxO
         Ds2g==
X-Gm-Message-State: AOJu0YwawPTArw3H/aof+QRDVV+JGmPJQN+ztQF4mQjqn0fPyYiC+xe0
        V9EBY9nOKepysC/2fKg0TLHp7w==
X-Google-Smtp-Source: AGHT+IFYKLdrk053cTnoXaOGENG9pRtf7WBSlPFQ6vHTErcVoRWV6bqSTpECx/yl0nSpWdBhZllXow==
X-Received: by 2002:a05:690c:f8d:b0:5a8:dbb1:f73b with SMTP id df13-20020a05690c0f8d00b005a8dbb1f73bmr11384273ywb.14.1698090530827;
        Mon, 23 Oct 2023 12:48:50 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d136-20020a814f8e000000b005a7d9fca87dsm3354999ywb.107.2023.10.23.12.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:48:49 -0700 (PDT)
Date:   Mon, 23 Oct 2023 12:48:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     domenico cerasuolo <mimmocerasuolo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.co>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmamil.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/12] mempolicy: alloc_pages_mpol() for NUMA policy
 without vma
In-Reply-To: <20231023190555.GA1964810@cmpxchg.org>
Message-ID: <6b9b1256-f9ab-c418-ec7f-8fc74449cd68@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com> <74e34633-6060-f5e3-aee-7040d43f2e93@google.com> <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com> <CAFYChMvWFdHq-OJHBE3DycmGtGmczDOHVGfoSqdvY-BxM2hWyg@mail.gmail.com>
 <20231023105331.311373ed33a0dfe78ddaa9e5@linux-foundation.org> <CAFYChMu9DO7OeXqQmKbfMY-iGKykHB21V8nqjy=tQa+StfDAUQ@mail.gmail.com> <20231023190555.GA1964810@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023, Johannes Weiner wrote:
> On Mon, Oct 23, 2023 at 08:10:32PM +0200, domenico cerasuolo wrote:
> > Il giorno lun 23 ott 2023 alle ore 19:53 Andrew Morton
> > <akpm@linux-foundation.org> ha scritto:
> > >
> > > On Mon, 23 Oct 2023 18:53:26 +0200 domenico cerasuolo <mimmocerasuolo@gmail.com> wrote:
> > >
> > > > > Rebased to mm.git's current mm-stable, to resolve with removal of
> > > > > vma_policy() from include/linux/mempolicy.h, and temporary omission
> > > > > of Nhat's ZSWAP mods from mm/swap_state.c: no other changes.
> > > >
> > > > Hi Hugh,
> > > >
> > > > not sure if it's the rebase, but I don't see an update to
> > > > __read_swap_cache_async invocation in zswap.c at line 1078. Shouldn't we pass a
> > > > mempolicy there too?
> > >
> > > No change needed.  zswap_writeback_entry() was passing a NULL for arg
> > > `vma' and it's now passing a NULL for arg `mpol'.

Andrew's answer was indeed my thinking, and why none of us got a build error.

> > 
> > Problem is that alloc_pages_mpol is dereferencing mpol, when I test the zswap
> > writeback at 397148729f21edcf700ecb2a01749dbce955d09e it crashes, not sure if
> > I'm missing something.
> 
> I don't think you are. The NULL vma used to go to get_vma_policy(),
> which fell back to
> 
> 	pol = get_task_policy(current);
> 
> Now the NULL pol gets passed to alloc_pages_mpol() directly, which
> dereferences it. Oops.

Yes, I failed to think it through that far.

> 
> I think Hugh's patch needs zswap to pass get_task_policy(current)
> instead of NULL.

That sounds the likely fix, thank you Domenico, Andrew, Johannes.

I'll check it out and send a fix patch later today.

I don't know who runs that zswap_writeback_entry() code, but I presume
that task's mempolicy is unlikely to be relevant to the swap cache page
in question: but a whole lot better than oopsing, and will reproduce
the previous behaviour (and the assumption at this writeback point would
be that the page is unlikely to be reused after writeback anyway, so its
node unimportant).

Hugh
