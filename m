Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69D475A57C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGTFeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTFeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:34:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ECD1710
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hFybdOvvnOfesblq0ygtn3MBu6SceidBPg+cvmISP3Q=; b=vGqIT386WlC6G+dGehwmvQGZoA
        buFsz+rMXKRceZlZD+mTvjlQ5n5jQmUi2TdpTrSMYfguBM6aE8HAu7ApPiINW/WVjQXh5TecxAyyd
        mxTpquGrOiEFxshhsY1ht8BMVCX1YrMRebpbb1yM7nk8qH+0idECOxXnCO5qNHlw0s/R6hrnGngrH
        hWfBit/tIb2A9ZpkmyXQYvJRvsom0rJCryXYfeRg0Y71+p9BPvVCEMxVKFBWV0WgAHIHFWOFLk1jl
        qOzjTLdwPnQ9NGGv+jobG1LlwWe2+pVbE7He32UoQdy5ZpmT9/R2qzc9gy8HCsG1B7C4iDLsJISb0
        WAX4G2fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMMJA-009pxE-18;
        Thu, 20 Jul 2023 05:34:36 +0000
Date:   Wed, 19 Jul 2023 22:34:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sidhartha.kumar@oracle.com,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v2 3/9] mm/page_io: convert bio_first_page_all() to
 bio_first_folio_all()
Message-ID: <ZLjHbNNM8eyeaTpH@infradead.org>
References: <20230719095848.3422629-1-zhangpeng362@huawei.com>
 <20230719095848.3422629-4-zhangpeng362@huawei.com>
 <ZLfwfhMkegLUav/B@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLfwfhMkegLUav/B@casper.infradead.org>
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

On Wed, Jul 19, 2023 at 03:17:34PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 19, 2023 at 05:58:42PM +0800, Peng Zhang wrote:
> > From: ZhangPeng <zhangpeng362@huawei.com>
> > 
> > Convert bio_first_page_all() to bio_first_folio_all() to return a
> > folio, which makes it easier to use.
> 
> This wasn't what I was suggesting.  Indeed, this may introduce bugs.
> I was suggesting adding bio_first_folio_all() so that it can be used
> by code that knows this is what it wants.

To add another opinion:  I'd really like to see bio_first_page_all
go away.  The right way to iterate over the pages is an iterator.
If we really want to micro-opimize not setting up an iteator because
we know we have exactly one page/folio just stash it into bi_private.

