Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1C7568E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGQQRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjGQQR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:17:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358AEE2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iUlrfwzo5Lu7oQ5BuafotnOrx3OuKcCmu7TXtpiBn0A=; b=VPAEIFsF7TUL7NDZQJYEMgMvfX
        dzPReuf3A4aeAaGhG94yzt+M4sL1pzgicIPDtlD3meIvpALekhC7l6rZK1g6a1XKrW7Rp6fV3SHIX
        pU4Ge46g8fJ+9FpNVeAbLKHeSNqxmMAwyhAgFBSnvh/T6pbIC920eXzpbdYY7y109moc9ixLML13a
        5K/86oUJLRrbiMKNBt5pr23Ugk28FRK40pVIVwzhDrTyrIOJUUs39D9WhduM+9R7MJkH4qqqKpQeJ
        VOGOivVkzd+4+BSCveWaE4R7fTsd1HkEfWynCRIcJQtmVAg66QzrAZdko0mmoZrmbcx9MB9TJKRKL
        D/naxS9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLQuU-0044Ly-56; Mon, 17 Jul 2023 16:17:18 +0000
Date:   Mon, 17 Jul 2023 17:17:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
Message-ID: <ZLVpjhAvk/nAquiY@casper.infradead.org>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
 <ZLVeeDmPDWupYzSH@casper.infradead.org>
 <283e4122-c23f-35a1-4782-fddde32f4ad4@arm.com>
 <c10ae780-c405-b2d2-ecc0-78ef35a892f3@redhat.com>
 <ZLVkUlQXmPH1BXEx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVkUlQXmPH1BXEx@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:54:58PM +0100, Matthew Wilcox wrote:
> Those are page->flags and page->compound_head for the third page in
> the folio.  They don't really need a name; nothing refers to them,
> but it's important that space not be reused ;-)
> 
> This is slightly different from _flags_1; we do have some flags which
> reuse the bits (they're labelled as PF_SECOND).  Right now, it's only
> PG_has_hwpoisoned, but we used to have PG_double_map.  Others may arise.

Sorry, this was incomplete.  We do still have per-page flags!  HWPoison
is the obvious one, but PG_head is per-page (... think about it ...)
PG_anon_exclusive is actually per-page.

Most of the flags labelled as PF_ANY are mislabelled.  PG_private and
PG_private2 are never set/cleared/tested on tail pages.  PG_young and
PG_idle are only ever tested on the head page, but some code incorrectly
sets them on tail pages, where those bits are ignored.  I tried to fix
that a while ago, but the patch was overlooked and I couldn't be bothered
to try all that hard.  I have no clue about PG_vmemmap_self_hosted.
I think PG_isolated is probably never set on compound pages.
PG_owner_priv_1 is a disaster, as you might expect.
