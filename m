Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7FC766F04
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjG1OG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1OG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:06:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032230E2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zfhLlZEY9jrlQ/2kEYtQ+IcpResvxW4Nqgr5z97KTN4=; b=RV1/HdoOOaLQNqjA6/byw1rzTB
        YtfU6b1OVsO3YHk/qeJ85dCatzu6sFtmWuQNyc+l9tjmmqzcUfeIo60z5go1TammYWptXZwqwb+E5
        Hws7Kw/6mANlTUxkWpI6OR0YjVBAdGNnG3epD1niymrzrD9dWSJhv9+GQGGW7uOeN3+jifKy7GUnj
        Fh/2YF7kE0xcDFgdrsejedNpdINcW3mqKr2e9qaVDOxsXMCKNM5X17VjlU8YOtE/Fu9ph5KGB6SBW
        5h7RfSYucQAjZx2BERsNQmnVNEWLGQNroJT3NyzbkyJdwDRXAwadtTZiRj809vVF6lVZdDtiUB5wf
        JCfK7hzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPO5e-008YJz-Fg; Fri, 28 Jul 2023 14:05:10 +0000
Date:   Fri, 28 Jul 2023 15:05:10 +0100
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
Message-ID: <ZMPLFqJ192j0loCV@casper.infradead.org>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com>
 <CAMSo37X5GzFmqNAtABuibmMAF7t=_5SYCipMPZ-TB+uEMYkSUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMSo37X5GzFmqNAtABuibmMAF7t=_5SYCipMPZ-TB+uEMYkSUA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:53:29PM +0800, Yongqin Liu wrote:
> Hi, Hugh
> 
> It seems this change makes pte_offset_map_lock not possible to be
> called in out of tree modules,
> otherwise it will report error like this:
>         ERROR: modpost: "__pte_offset_map_lock"
> [../omap-modules/android-mainline/pvr/pvrsrvkm.ko] undefined!
> 
> Not sure if you have any idea about it, and any suggestions on how to
> resolve it?

Please explain why this module needs to map page tables
