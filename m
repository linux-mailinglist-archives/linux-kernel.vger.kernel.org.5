Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906BF79C0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350407AbjIKViF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbjIKMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:47:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CCE40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AT/HwmSFNvPgul/c1kKp5PbdGjEUzpII4wStP5rXfVI=; b=GAGPBrS4O64uc1P1Dkt0dT5nbd
        wkftLVuzMLe1jQYqNe1N5/9Cs96OcwNv/MClUqUZ91ZRefOLLHW2HbHfd0oQKpWwbTDl1vC3ZJ3PY
        f1shLDG53/7qYiki3xfy5Yg1KsPVFOZWrTklRGEjq7FV01u/3rWvmfYipKn22+fiXUUPkVQ3P0/UD
        ywAyX66FLyzCCCs2349Z4YQdi+T1EojvXQkxelwPYxxCYretVYjxO3Ai5Gz+SzMssFYkheGfW0I7l
        xv8+AFC++Pj0xJIGNdWwpKvuXaA7oQUD7LUaFppzv91Oqxf1qhfILlJUBIqG9Lo7Zt4q4ecnrebZH
        ywR7pbpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfgJj-0010FI-FL; Mon, 11 Sep 2023 12:47:03 +0000
Date:   Mon, 11 Sep 2023 13:47:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: remove redundant clear page when
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON configured
Message-ID: <ZP8MR6N8512YDU/j@casper.infradead.org>
References: <20230911104906.2058503-1-zhaoyang.huang@unisoc.com>
 <ZP8EKWev8H9kMka3@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP8EKWev8H9kMka3@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:12:25PM +0200, Michal Hocko wrote:
> On Mon 11-09-23 18:49:06, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > There will be redundant clear page within vma_alloc_zeroed_movable_folio
> > when CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on. Remove it by judging related
> > configs.
> 
> Thanks for spotting this. I suspect this is a fix based on a code review
> rather than a real performance issue, right? It is always good to
> mention that. From a very quick look it seems that many architectures
> just definte vma_alloc_zeroed_movable_folio to use __GFP_ZERO so they
> are not affected by this. This means that only a subset of architectures
> are really affected. This is an important information as well.
> Finally I think it would be more appropriate to mention that the double
> initialization is done when init_on_alloc is enabled rather than
> referring to the above config option which only controls whether the
> functionality is enabled by default.

This may well be an unsaafe change to make.  We're not just zeroing the
page, we're calling clear_user_highpage() which tells the architecture
which virtual address the page will be mapped at.  It could be that
skipping the zeroing ("because the page is already zero") isn't enough;
there will be traces of the former contents of some page in the D-cache
for this address.

Or it might just be an optimisation.  The description of clear_user_page()
isn't entirely clear; the port may be relying on clear_user_page()
to have flushed the dcache aliases.

At this point, I don't think this patch is worth the risk.  My mind is
changable on this, but I think we'd need buy-in from ARM, SH and Xtensa
(who directly define clear_user_highpage()) as well as Arc, csky, ia64,
m68k, mips, nios2, parisc, powerpc, sparc who all seem to have non-trivial
clear_user_page() implementations.
