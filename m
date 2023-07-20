Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF99F75A56F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGTFWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGTFWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:22:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322B1110
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CDKYREQdRXyTlFXvhiTxHWPhw/v5r8WPhz7dV9fWKqU=; b=tYgOcUvNE6Cg4zr2JuXcJPczFB
        DXC6CUKnyFJOBQqHeqQAoN9bj3gxTr5+AmnZ4hxKsr0pmF2lACUlK2M+NNP87bo3wnJL/DdXoIzzQ
        gxj5v0eWICQYh1S1fksK4QIh50kNiKsq/HyxQmqjU9ewjR4V4nof6B/iuCKLtD/fGq+gZyAHheox9
        JAV+ubv2L22CiXGk0iGyG8V2mVlLuSmkGJQifQSDHa2NEhb2lxtHn9zb52hlxiEbJtb1J4o1oYogK
        H9HumonrZHn7d9qmnaVYMi7pLSHJZn4LDVUmhZFsnbzUm7YpXm843JRMa/WfTYCca84Ddj6099c2o
        uxE0+aHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMM7V-009p1m-31;
        Thu, 20 Jul 2023 05:22:33 +0000
Date:   Wed, 19 Jul 2023 22:22:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sidhartha.kumar@oracle.com,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com, Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 2/6] mm/page_io: use a folio in sio_read_complete()
Message-ID: <ZLjEmULp8gQ4TkGf@infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-3-zhangpeng362@huawei.com>
 <ZLVEyG7SZMzgY7ov@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVEyG7SZMzgY7ov@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 02:40:24PM +0100, Matthew Wilcox wrote:
> >  		for (p = 0; p < sio->pages; p++) {
> > -			struct page *page = sio->bvec[p].bv_page;
> > +			struct folio *folio = page_folio(sio->bvec[p].bv_page);
> >  
> > -			SetPageUptodate(page);
> > -			unlock_page(page);
> > +			folio_mark_uptodate(folio);
> > +			folio_unlock(folio);
> >  		}
> 
> I'm kind of shocked this works today.  Usually bvecs coalesce adjacent
> pages into a single entry, so you need to use a real iterator like
> bio_for_each_folio_all() to extract individual pages from a bvec.
> Maybe the sio bvec is constructed inefficiently.

sio_read_complete is a kiocb.ki_complete handler.  There is no
coalesce going on for ITER_BVEC iov_iters, which share nothing
but the underlying data structure with the block I/O path.

