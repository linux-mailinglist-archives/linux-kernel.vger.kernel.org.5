Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7587C7AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJMAzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJMAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:55:12 -0400
Received: from out-208.mta1.migadu.com (out-208.mta1.migadu.com [IPv6:2001:41d0:203:375::d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EEBB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 17:55:09 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:54:57 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697158508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5XyMIwsVANAmpJnSC/+iI2o37928QdCL41M/ZBO5Do=;
        b=AYhNXKdLSEA7/AyMrxcMpj2KMLIzOcGf9Z+lHIa4jRqEXqqP3/qOrLUSJbuWvuz1/Z/GqZ
        rpJlDLcIl5zrIXpgFXep6r5rC/NSwypPaQ+wTeLpBJFOSN+5F39ujxoEL1HQZtsAjQ13aB
        IJD62qzsTKgpD70gaCOk65mTMWr+tCQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] mm, kpageflags: support folio and fix output for
 compound pages
Message-ID: <20231013005457.GA712115@ik1-406-35019.vs.sakura.ne.jp>
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
 <63d119f7-5adb-861a-00c2-69a92b19ef9b@redhat.com>
 <20231012150226.GA473412@u2004>
 <86170ebf-cbe3-1cda-dcb4-87e18695f9cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86170ebf-cbe3-1cda-dcb4-87e18695f9cd@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:30:34PM +0200, David Hildenbrand wrote:
> On 12.10.23 17:02, Naoya Horiguchi wrote:
> > On Thu, Oct 12, 2023 at 10:33:04AM +0200, David Hildenbrand wrote:
> > > On 10.10.23 16:27, Naoya Horiguchi wrote:
> > > > Hi everyone,
> > > > 
> > > > This patchset addresses 2 issues in /proc/kpageflags.
> > > > 
> > > >     1. We can't easily tell folio from thp, because currently both pages are
> > > >        judged as thp, and
> > > >     2. we see some garbage data in records of compound tail pages because
> > > >        we use tail pages to store some internal data.
> > > > 
> > > > These issues require userspace programs to do additional work to understand
> > > > the page status, which makes situation more complicated.
> > > > 
> > > > This patchset tries to solve these by defining KPF_FOLIO for issue 1., and
> > > > by hiding part of page flag info on tail pages of compound pages for issue 2.
> > > > 
> > > > I think that technically some compound pages like thp/hugetlb/slab could be
> > > > considered as folio, but in this version KPF_FOLIO is set only on folios
> > > 
> > > At least thp+hugetlb are most certainly folios. Regarding slab, I suspect we
> > > no longer call them folios (cannot be mapped to user space). But Im not sure
> > > about the type hierarchy.
> > 
> > I'm not sure about the exact definition of "folio", and I think it's better
> > to make KPF_FOLIO set based on the definition.
> 
> Me neither. But in any case a THP *is* a folio. So you'd have to set that
> flag in any case.

OK.

> 
> And any order-0 page (i.e., anon, pagecache) is also a folio. What you seem
> to imply with folio is "large folio". So KPF_FOLIO is really wrong as far as
> I can tell.

Ah, I meant "large folio" for the new flag, so it might have been better to
name it KPF_LARGE_FOLIO.

> 
> > "being mapped to userspace" can be one possible criteria for the definition.
> > But reading source code, folio_slab() and slab_folio() convert between
> > struct slab and struct folio, so I feel that someone might think a slab is
> > a kind of folio.
> 
> I keep forgetting if "folio" is just the generic term for any order-0 or
> compound page, or only for some of them. I usually live in the "anon" world,
> so I don't get reminded that often :)

I didn't notice that an order-0 page is also a folio.

> 
> 
> > > > in pagecache (so "folios in narrower meaning").  I'm not confident about
> > > > this choice, so if you have any idea about this, please let me know.
> > > 
> > > It does sound inconsistent. What exactly do you want to tell user space with
> > > the new flag?
> > 
> > The current most problematic behavior is to report folio as thp (order-2
> > pagecache page is definitely a folio but not a thp), and this is what the
> > new flag is intended to tell.
> 
> We are currently considering calling these sub-PMD sized THPs "small-sized
> THP". [1] Arguably, we're starting with the anon part where we won't get
> around exposing them to the user in sysfs.
> 
> So I wouldn't immediately say that these things are not THPs. They are not
> PMD-sized THP. A slab/hugetlb is certainly not a thp but a folio. Whereby
> slabs can also be order-0 folios, but hugetlb can't.
> 
> 
> Looking at other interfaces, we do expose:
> 
> include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_HEAD        15
> include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_TAIL        16
> 
> So maybe we should just continue talking about compound pages or do we have
> to use both terms here in this interface?

Extending the concept of thp to arbitrary size of thp sounds good to me.
If patchset [1] will be merged, then setting KPF_THP on large folios is totally
fine and one of my problem in this patchset will be automatically resolved.
So I'm thinking of not adding new flag and just focusing on garbage data issue.

Thank you very much for sharing ideas.

Naoya Horiguchi

> 
> [1] https://lkml.kernel.org/r/20230929114421.3761121-1-ryan.roberts@arm.com
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
