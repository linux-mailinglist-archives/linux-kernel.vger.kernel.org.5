Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D197643D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjG0Cf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjG0Cfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:35:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A42FD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8+mMYSePRim9fJuojp56HwKaFw2Rt3EE2Z0pVt0WtwQ=; b=aKfbDybu2x46T8mL8mBiHX+XNR
        b03TRFMgx4k3CYXkpnBYwXtL71Lzk25bxLE0EDBKqF2tMhfzdykQf/KqIfQ2sA322eD5zCapWkr8m
        2DWATcajZ6vgm5ey3DpGfKEYBHPvo0aH9LvEqYQ7Wv8/w1Z796Rvj0e665wPQTEXqumIShjM3Y93O
        pAKBQa2aSdvK3qhxKnFnUszJW1/2Ktfd/ri2nI9YdVHKF2DaEjFrNrrkhGTxkqMmXAI9ef6QKmKlh
        9nWzbGD3M4RPU2Ui8CAKNUKG/s+DdGArr5DYXzMePjboTfktOAa2ym1VaSPiw+A9vDfGCQqb87gUo
        mEn6lrzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOqqm-00742b-Pu; Thu, 27 Jul 2023 02:35:36 +0000
Date:   Thu, 27 Jul 2023 03:35:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] mm: Implement folio_remove_rmap_range()
Message-ID: <ZMHX+O0wmjuPXdTi@casper.infradead.org>
References: <20230720112955.643283-1-ryan.roberts@arm.com>
 <20230720112955.643283-3-ryan.roberts@arm.com>
 <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
 <ZMFNgmlT1JpI0z5+@casper.infradead.org>
 <87r0ouw39n.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0ouw39n.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:29:24AM +0800, Huang, Ying wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > I think that can make sense.  Because we limit to a single page table,
> > specifying 'nr = 1 << PMD_ORDER' is the same as 'compound = true'.
> > Just make it folio, page, nr, vma.  I'd actually prefer it as (vma,
> > folio, page, nr), but that isn't the convention we've had in rmap up
> > until now.
> 
> IIUC, even if 'nr = 1 << PMD_ORDER', we may remove one PMD 'compound'
> mapping, or 'nr' PTE mapping.  So, we will still need 'compound' (or
> some better name) as parameter.

Oh, this is removing ... so you're concerned with the case where we've
split the PMD into PTEs, but all the PTEs are still present in a single
page table?  OK, I don't have a good answer to that.  Maybe that torpedoes
the whole idea; I'll think about it.
