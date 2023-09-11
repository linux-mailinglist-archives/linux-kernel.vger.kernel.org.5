Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6724D79B705
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376520AbjIKWTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbjIKNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:03:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57420DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:03:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 11AB11F891;
        Mon, 11 Sep 2023 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694437393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+lkCsOrmvgMZKwdhoCy1NavBv3f9A5WVMY+v90BVt4s=;
        b=DiGitxDw/pQ+mU4nN1HJ2KIq6mOYkeHtb2wMCjQm3rgm+YXJGw7ySwLfsfMTpuI9fH7h2a
        LX4b6JRDxzY4hKG1Ev/xLnveCPt5//NYkvcZONnMD7AlQzj0zN2CXW26vs5ynKEqxij24+
        QwIraQZ/hydiUVZi3Yc9ShRs3vM01O8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E67F813780;
        Mon, 11 Sep 2023 13:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V/VJNRAQ/2RnHwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 11 Sep 2023 13:03:12 +0000
Date:   Mon, 11 Sep 2023 15:03:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: remove redundant clear page when
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON configured
Message-ID: <ZP8QEERuihh33Oki@dhcp22.suse.cz>
References: <20230911104906.2058503-1-zhaoyang.huang@unisoc.com>
 <ZP8EKWev8H9kMka3@dhcp22.suse.cz>
 <ZP8MR6N8512YDU/j@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP8MR6N8512YDU/j@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-09-23 13:47:03, Matthew Wilcox wrote:
> On Mon, Sep 11, 2023 at 02:12:25PM +0200, Michal Hocko wrote:
> > On Mon 11-09-23 18:49:06, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > 
> > > There will be redundant clear page within vma_alloc_zeroed_movable_folio
> > > when CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on. Remove it by judging related
> > > configs.
> > 
> > Thanks for spotting this. I suspect this is a fix based on a code review
> > rather than a real performance issue, right? It is always good to
> > mention that. From a very quick look it seems that many architectures
> > just definte vma_alloc_zeroed_movable_folio to use __GFP_ZERO so they
> > are not affected by this. This means that only a subset of architectures
> > are really affected. This is an important information as well.
> > Finally I think it would be more appropriate to mention that the double
> > initialization is done when init_on_alloc is enabled rather than
> > referring to the above config option which only controls whether the
> > functionality is enabled by default.
> 
> This may well be an unsaafe change to make.  We're not just zeroing the
> page, we're calling clear_user_highpage() which tells the architecture
> which virtual address the page will be mapped at.  It could be that
> skipping the zeroing ("because the page is already zero") isn't enough;
> there will be traces of the former contents of some page in the D-cache
> for this address.

I haven't realized this difference between clear_user_highpage and
kernel_init_pages  which is used by the page allocator. Thanks for
pointing this out!

> 
> Or it might just be an optimisation.  The description of clear_user_page()
> isn't entirely clear; the port may be relying on clear_user_page()
> to have flushed the dcache aliases.
> 
> At this point, I don't think this patch is worth the risk.

Agreed! Based on that I take my ack back.

> My mind is
> changable on this, but I think we'd need buy-in from ARM, SH and Xtensa
> (who directly define clear_user_highpage()) as well as Arc, csky, ia64,
> m68k, mips, nios2, parisc, powerpc, sparc who all seem to have non-trivial
> clear_user_page() implementations.

-- 
Michal Hocko
SUSE Labs
