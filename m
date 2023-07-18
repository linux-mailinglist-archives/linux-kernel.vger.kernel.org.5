Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1087581F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjGRQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGRQVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:21:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CAB5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TdiwBYnKVgHToYOqCtggmYuSE9dqhBgEjjLNd2yVWR8=; b=PcX/1CaPcviCJ5CUGVLKaRf2IT
        0CXhGX79GcVEmxpKAqyEpy+k+zzpgnDbc4WzSw/1ptvFZM2AANyCuSxWrfSQsZahABzVBtwhGxeKO
        eRifyehR9RUSFF88AXpkTC3b6GpgbqJFwlf1ljfqANjRZN2Nle0fdOUALPb2F8cvzrPlIGl8CRREU
        JNjDrNxuAUmU0aXX2gC6FZVJ0ZACQIl3F0FSiugKtCcuwOXaCst+shtERxskpjFaY/WDCzkSAzUMV
        BDNMdAcdajpNChaCv+ARhPBX6dJ7vriFbozR7as2Rt3JqrUiEKuEf/gPHxZh8SCpqQz5luwPSo4tK
        ZOetqnXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLnSD-00558e-0k; Tue, 18 Jul 2023 16:21:37 +0000
Date:   Tue, 18 Jul 2023 17:21:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 2/6] mm/page_io: use a folio in sio_read_complete()
Message-ID: <ZLa8EKH/C5/7L/Oq@casper.infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-3-zhangpeng362@huawei.com>
 <ZLVEyG7SZMzgY7ov@casper.infradead.org>
 <48a73879-6d25-4350-a8cb-8cee58878b1c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a73879-6d25-4350-a8cb-8cee58878b1c@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 08:58:17PM +0800, zhangpeng (AS) wrote:
> On 2023/7/17 21:40, Matthew Wilcox wrote:
> 
> > On Mon, Jul 17, 2023 at 09:25:58PM +0800, Peng Zhang wrote:
> > > +++ b/mm/page_io.c
> > > @@ -406,19 +406,19 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
> > >   	if (ret == sio->len) {
> > >   		for (p = 0; p < sio->pages; p++) {
> > > -			struct page *page = sio->bvec[p].bv_page;
> > > +			struct folio *folio = page_folio(sio->bvec[p].bv_page);
> > > -			SetPageUptodate(page);
> > > -			unlock_page(page);
> > > +			folio_mark_uptodate(folio);
> > > +			folio_unlock(folio);
> > >   		}
> > I'm kind of shocked this works today.  Usually bvecs coalesce adjacent
> > pages into a single entry, so you need to use a real iterator like
> > bio_for_each_folio_all() to extract individual pages from a bvec.
> > Maybe the sio bvec is constructed inefficiently.
> > 
> > I think Kent had some bvec folio iterators in progress?
> 
> I'll convert bio_first_page_all() to bio_first_folio_all() in a v2.

That isn't my point at all.  What I'm saying is that when you call a
function like bio_add_folio(), if @folio is physically adjacent to the
immediately prior folio already in the bio, it will extend the bv_len
instead of adding the new folio to the bvec.  Maybe there's nothing like
that for sio.
