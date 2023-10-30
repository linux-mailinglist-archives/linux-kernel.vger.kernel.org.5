Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81977DC313
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjJ3XWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3XWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:22:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2311EFC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vgtwIpOv7aynDs/c0Cteoh8B8jUiQYzWQhTbABw5QcA=; b=QFHqbbyRP7IuQ01xPhrltBwja/
        wGRj5o0MMuBo1SVwbo3Id+jGqP5JjzAGevnCCM7dqgNQshaYbCYpxvekqm/SuXvTEcDBALcxC2XlU
        bedNmzolHcFiKC3RW5jIUdr94BkrB60btm8Gr+o1UuYqmj2JUJd1CdVpRTUSh+3prLQ/mCgwgXCYk
        /0wAuhiN7DSPP1SaQAny8pEQVWWjTG5UlurnS0MerTNx9UZITxxrsZIRYHCX7fR2J+43udgqowujI
        OzILe30wwaH0NxueJNBfyskdx43rVw9DBn+1EkNKWomkCI3s7V1ro2BooPL0DBV37SQSD7OyuVy8y
        pmRq6oTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxbaM-006ren-HB; Mon, 30 Oct 2023 23:22:18 +0000
Date:   Mon, 30 Oct 2023 23:22:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        vbabka@suse.cz, naoya.horiguchi@linux.dev,
        linux-kernel@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v2] kpageflags: respect folio head-page flag placement
Message-ID: <ZUA6qq6zXuc0fqOE@casper.infradead.org>
References: <20231030180005.2046-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030180005.2046-1-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 02:00:05PM -0400, Gregory Price wrote:
> kpageflags reads page-flags directly from the page, even when the
> respective flag is only updated on the headpage of a folio.
> 
> Update bitchecks to use PAGEFLAG() interfaces to check folio for the
> referenced, dirty, lru, active, and unevictable bits.

But uptodate, writeback and reclaim (amongst others) are also defined
only on the head page.

>  	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
>  	u |= kpf_copy_bit(k, KPF_WRITEBACK,	PG_writeback);
>  
>  	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
>  
>  	if (PageSwapCache(page))
>  		u |= 1 << KPF_SWAPCACHE;
>  	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
>  
>  	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
