Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7817A7C70E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379172AbjJLPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346817AbjJLPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:02:45 -0400
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06865E1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:02:40 -0700 (PDT)
Date:   Fri, 13 Oct 2023 00:02:26 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697122956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RjcViyd2Fhk9iMtsIB4L9gySKen/F6NsFGsZ37IiSaI=;
        b=qh+sQi2+AwZtf3yb3TP3gZd3g09JYVCgAhKSM0xfGCLiCjjbUT1m8mW0IXi82EI3en1N5y
        662DXTq/zsHoGArFquLa7xUi8nhZWazc5X+jWaJzY330XkHMienfF6P23UKc3/lVGIgLgc
        LoYahsX5YZ2pV4nsunvhAg/CM0Ks1AY=
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
Message-ID: <20231012150226.GA473412@u2004>
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
 <63d119f7-5adb-861a-00c2-69a92b19ef9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63d119f7-5adb-861a-00c2-69a92b19ef9b@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:33:04AM +0200, David Hildenbrand wrote:
> On 10.10.23 16:27, Naoya Horiguchi wrote:
> > Hi everyone,
> > 
> > This patchset addresses 2 issues in /proc/kpageflags.
> > 
> >    1. We can't easily tell folio from thp, because currently both pages are
> >       judged as thp, and
> >    2. we see some garbage data in records of compound tail pages because
> >       we use tail pages to store some internal data.
> > 
> > These issues require userspace programs to do additional work to understand
> > the page status, which makes situation more complicated.
> > 
> > This patchset tries to solve these by defining KPF_FOLIO for issue 1., and
> > by hiding part of page flag info on tail pages of compound pages for issue 2.
> > 
> > I think that technically some compound pages like thp/hugetlb/slab could be
> > considered as folio, but in this version KPF_FOLIO is set only on folios
> 
> At least thp+hugetlb are most certainly folios. Regarding slab, I suspect we
> no longer call them folios (cannot be mapped to user space). But Im not sure
> about the type hierarchy.

I'm not sure about the exact definition of "folio", and I think it's better
to make KPF_FOLIO set based on the definition.
"being mapped to userspace" can be one possible criteria for the definition.
But reading source code, folio_slab() and slab_folio() convert between
struct slab and struct folio, so I feel that someone might think a slab is
a kind of folio.

> 
> > in pagecache (so "folios in narrower meaning").  I'm not confident about
> > this choice, so if you have any idea about this, please let me know.
> 
> It does sound inconsistent. What exactly do you want to tell user space with
> the new flag?

The current most problematic behavior is to report folio as thp (order-2
pagecache page is definitely a folio but not a thp), and this is what the
new flag is intended to tell.

Thanks,
Naoya Horiguchi
