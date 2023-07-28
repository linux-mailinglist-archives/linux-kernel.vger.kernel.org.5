Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D9776728E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjG1Q6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG1Q6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:58:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0BB5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:58:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d066d72eb12so3242183276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690563516; x=1691168316;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GShiyClog5JSkUZzXvC/x80xpfvHryo9mYUqQG38Cyg=;
        b=Ucc+IvgzgYZ0O9vdpuyWtxAY2hyIte0l1ud1lTHNqf3oz+BHJOulr13wgd/5mqLYWE
         wsmBBCQ4ISMtw6+WgTwGz5ov1T81nFuUlYYzVU62nm7J3vwvq6bCQeHf6AsIIk10GxEG
         oPdx5sRvSt/k6mhtJgP1YhjZC6qoQRfRPKbvnpKqm4gMIChhgpCEmeWc0w0SCR47ENYN
         +En4cvk+uyC35wOQWNDyT9flOQHvJfa8+/Vz729j6L4BmClQFiHKFazBQEubog0Xb34u
         6QK5K6cSEgMtvFwurFRdKYFASlK6rYxs+QOnkG7+Syfdvu2K/uFVPtL4rOv0L9tmd0Js
         Zb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690563516; x=1691168316;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GShiyClog5JSkUZzXvC/x80xpfvHryo9mYUqQG38Cyg=;
        b=NPVOA7E+nCEcDEOoVYNZB/xvKkv+cmXyo+pdllA0o4X50EOSgHExKhRQtld+51shVE
         ulNwQBVEuavxtM4/1XrZgSOW70z8KvlGtRr3ig6cFIoTY1xlmcHC4nkSuBHGv5NUxb1X
         hW3/rdGDH4S8X1BGRMVljp+yB8LNMPFHG0nei8YaCWC7pyXF6i52xG7TVG43bvpDLQI7
         u7XTwOuq8Vk80ncgVXOglH8YJxDJS3JKW6eyBt0LOZrIWpoI8P5K62YDvYbI0EDd0g5j
         LdBBmTm3MHB2WTiQg6zdFz/dO2CK+Z7CkBc4sGyuR0Sup9Oby3vLH2nNiHtygdezpnbU
         dOmw==
X-Gm-Message-State: ABy/qLaDOoS7TS0pgOVL3Y5rBC4Cjk2bacDdFk1tteB7MUUdLhmjoDlI
        6cZEcnPFiEXgeY/jhHKekYwFhA==
X-Google-Smtp-Source: APBJJlHBFbMizlgcqeLaat734RR0N6/qgmeCbKXzz/m5ekuONhKnRvLKwdVWxRCif5G55jvVMt82Ag==
X-Received: by 2002:a25:a362:0:b0:d07:2183:f547 with SMTP id d89-20020a25a362000000b00d072183f547mr2206323ybi.32.1690563515748;
        Fri, 28 Jul 2023 09:58:35 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y200-20020a25dcd1000000b00d1e6e93e8f5sm913403ybe.51.2023.07.28.09.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:58:35 -0700 (PDT)
Date:   Fri, 28 Jul 2023 09:58:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yongqin Liu <yongqin.liu@linaro.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
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
In-Reply-To: <ZMPLFqJ192j0loCV@casper.infradead.org>
Message-ID: <da591261-26f1-5cf7-1435-a98ae21f5141@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com> <CAMSo37X5GzFmqNAtABuibmMAF7t=_5SYCipMPZ-TB+uEMYkSUA@mail.gmail.com> <ZMPLFqJ192j0loCV@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023, Matthew Wilcox wrote:
> On Fri, Jul 28, 2023 at 09:53:29PM +0800, Yongqin Liu wrote:
> > Hi, Hugh
> > 
> > It seems this change makes pte_offset_map_lock not possible to be
> > called in out of tree modules,
> > otherwise it will report error like this:
> >         ERROR: modpost: "__pte_offset_map_lock"
> > [../omap-modules/android-mainline/pvr/pvrsrvkm.ko] undefined!
> > 
> > Not sure if you have any idea about it, and any suggestions on how to
> > resolve it?
> 
> Please explain why this module needs to map page tables

+1

Thank you for testing 6.5-rc, and I am sorry to have inconvenienced you.

But there is not one example of an in-tree module needing that,
which is a very strong hint that no module should be needing that.

Sounds like pvrsrvkm.ko wants to muck around with page table entries,
without the core mm knowing.  Not something core mm can encourage!

If what pvrsrvkm.ko is aiming to do there would be useful for others,
maybe its owner can share that, and work with core mm developers to
expose a generally useful interface - but that is not likely to be
__pte_offset_map_lock itself.

Hugh
