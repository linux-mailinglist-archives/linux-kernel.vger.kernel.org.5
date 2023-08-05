Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474667710C3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHERIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHERID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:08:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8EE4A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uQ9RgvUaYz5ZoHkSz4TftrkTzewOwk1/pabomeJDyDQ=; b=AmKIfX/0U64+sAeS/5/upk0HBy
        lT9wElStLEcXTuLFF5qomt3n0sjH+6cAw0SqLTFl78kCR+jM/gZTMZbP/faaFX1cIkibWILBZzT1f
        eccJG/c5EuNSn5/3/8KulVBGEdLXSTwpk4uVg2Lirr5IDzoi6w6WH8j0HHoyNSNrgAVWKtgigjJk8
        A3dEZ5XWmkgtnexBs1J3Muaw9U+gJNb4cBxEAFTm7R0Uqy8vDLqduNT2DHfxWItpHolwnKPre5y5v
        dRHgsdEFeo37W1+0/TIhXxACWMURHwANbIPD1pCfAn7zsJv3G58u8GbDChorewlSfAneXOGlqdGzd
        JymtXjyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qSKk5-00H5kj-2R; Sat, 05 Aug 2023 17:07:05 +0000
Date:   Sat, 5 Aug 2023 18:07:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 04/32] mm/pgtable: allow pte_offset_map[_lock]() to
 fail
Message-ID: <ZM6BuZ+hNkhwkJn5@casper.infradead.org>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com>
 <CAMSo37X5GzFmqNAtABuibmMAF7t=_5SYCipMPZ-TB+uEMYkSUA@mail.gmail.com>
 <ZMPLFqJ192j0loCV@casper.infradead.org>
 <da591261-26f1-5cf7-1435-a98ae21f5141@google.com>
 <CAMSo37UxxZ6dc9cY=TArOP01jTuBHuLT1BGv0d=y_hJA1_7Zvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMSo37UxxZ6dc9cY=TArOP01jTuBHuLT1BGv0d=y_hJA1_7Zvw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 12:06:28AM +0800, Yongqin Liu wrote:
> On Sat, 29 Jul 2023 at 00:58, Hugh Dickins <hughd@google.com> wrote:
> >
> > On Fri, 28 Jul 2023, Matthew Wilcox wrote:
> > > On Fri, Jul 28, 2023 at 09:53:29PM +0800, Yongqin Liu wrote:
> > > > Hi, Hugh
> > > >
> > > > It seems this change makes pte_offset_map_lock not possible to be
> > > > called in out of tree modules,
> > > > otherwise it will report error like this:
> > > >         ERROR: modpost: "__pte_offset_map_lock"
> > > > [../omap-modules/android-mainline/pvr/pvrsrvkm.ko] undefined!
> > > >
> > > > Not sure if you have any idea about it, and any suggestions on how to
> > > > resolve it?
> > >
> > > Please explain why this module needs to map page tables
> >
> > +1
> Sorry, I am not able to give any explanation here,
> I am not familiar with the pvrsrvkm source, I just use it to have one
> working AOSP build.
> 
> here is the source file where pte_offset_map_lock is called,
>     https://android-git.linaro.org/kernel/omap-modules.git/tree/pvr/services4/srvkm/env/linux/osfunc.c?h=android-mainline#n3508
> in case you could know something with a quick look.

Isn't this just get_user_pages()?
