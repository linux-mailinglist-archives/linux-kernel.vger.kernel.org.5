Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D445480A45B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573809AbjLHNWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjLHNWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:22:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C55A1997
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iy/BnsFgH54qc/gUsqH+n1Dt1dH36pA1igQK0/A27e8=; b=qA1xTFy26X4kaYS1n6Ovfc01qh
        q6DuZLG6IQFgGDNzwWDXUE9cjwdKZkSYQWJtQPCjh213FN9hLqimR4PyUmtLc491ao2vlb6faOtoF
        baKCzIRElSptkWh9ye14i0U6MbY5uFtjNCPZfFdOT0fYyWZjkgN5g+CC6kqT5MNM77XKXO4YwAlsf
        Pt+MUziyy3rFcFRaJ/utVGIV5ujplXsYAPj+Y1C178Zfsq48btQmDxkwta9EbGk18N8gVQKYs+JNW
        EiGJGuA1vRg6d0xvhaHOspfIunCCQ7XrJIwjWugm/QwHFsmgIju9XpJtzYQYgzPGsU7F0EwjD/mmV
        YiTYV1Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rBanr-005oGS-Hm; Fri, 08 Dec 2023 13:22:03 +0000
Date:   Fri, 8 Dec 2023 13:22:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        david@redhat.com, linux-mm@kvack.org, ryan.roberts@arm.com,
        steven.price@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: support THP_SWAP on hardware with MTE
Message-ID: <ZXMYe2IDVll6pBn9@casper.infradead.org>
References: <20231208073401.70153-1-v-songbaohua@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208073401.70153-1-v-songbaohua@oppo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 08:34:01PM +1300, Barry Song wrote:
> arch_prepare_to_swap() should take folio rather than page as parameter
> because we support THP swap-out as a whole. It saves tags for all
> pages in a large folio.
> 
> Meanwhile, arch_swap_restore() now moves to use page parameter rather
> than folio because swap-in, refault and MTE tags are working at the
> granularity of base pages rather than folio:
> 1. a large folio in swapcache can be partially unmapped, thus, MTE
> tags for the unmapped pages will be invalidated;
> 2. users might use mprotect() to set MTEs on a part of a large folio.

I would argue that using mprotect() to set MTEs on part of a large folio
should cause that folio to be split.  Could the user give us any
stronger signal that this memory is being used for different purposes,
and therefore should not be managed as a single entity?

> Thus, it won't be easy to manage MTE tags at the granularity of folios
> since we do have some cases in which a part of pages in a large folios
> have valid tags, while the other part of pages haven't. Furthermore,
> trying to restore MTE tags for a whole folio can lead to many loops and
> early exiting even if the large folio in swapcache are still entirely
> mapped since do_swap_page() only sets PTE and frees swap for the base
> page where PF is happening.
> 
> But we still have a chance to restore tags for a whole large folio
> once we support swap-in large folio. So this job is deferred till we
> can do refault and swap-in as a large folio.

I strongly disagree with changing the interface to arch_swap_restore()
from folio to page.
