Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EFC764369
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjG0BbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjG0BbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:31:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B151985
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690421465; x=1721957465;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=NDV92DL8w7Vy/CvizZ8BwdNttadDo9vdLl+Mid7imWc=;
  b=mPi24KRdH3ymxrRLjXf03+Lu85dHDYwqQpNPx/1kK0Z69GJOSKc3z+cp
   ELq/JaEGYR736vbnwvYLp3Lb49Tbwj1pc0CnG7LuMiqWHILkp28QEiVld
   BWiaLx+Ce7STAEiUgZyk1UbqQwh8p1eJdsHnbr2Nes0mXORmZX5aKalgE
   3M8xPxlLPDM+L5LEW7WfFC3wWmfbhhp0+gj75gSJncLg6qa9FGc+NJevD
   Wb4aUzXiIw/9Kqf0PyNVrwPldJHIJXMTyoLcTrIfpSfF4h/uaG5/bPPbU
   mnhYs/I5ehVbf2ud02qAEEwMfA1+OW291b67Ash9VYj8oo9+URog4oVfq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="431974745"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="431974745"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 18:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792114036"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="792114036"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 18:31:01 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] mm: Implement folio_remove_rmap_range()
References: <20230720112955.643283-1-ryan.roberts@arm.com>
        <20230720112955.643283-3-ryan.roberts@arm.com>
        <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
        <ZMFNgmlT1JpI0z5+@casper.infradead.org>
Date:   Thu, 27 Jul 2023 09:29:24 +0800
In-Reply-To: <ZMFNgmlT1JpI0z5+@casper.infradead.org> (Matthew Wilcox's message
        of "Wed, 26 Jul 2023 17:44:50 +0100")
Message-ID: <87r0ouw39n.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Jul 25, 2023 at 11:53:26PM -0600, Yu Zhao wrote:
>> > +void folio_remove_rmap_range(struct folio *folio, struct page *page,
>> > +               int nr, struct vm_area_struct *vma);
>> 
>> I prefer folio_remove_rmap_range(page, nr, vma). Passing both the
>> folio and the starting page seems redundant to me.
>> 
>> Matthew, is there a convention (function names, parameters, etc.) for
>> operations on a range of pages within a folio?
>
> We've been establishing that convention recently, yes.  It seems
> pointless to re-derive the folio from the page when the caller already
> has the folio.  I also like Ryan's point that it reinforces that all
> pages must be from the same folio.
>
>> And regarding the refactor, what I have in mind is that
>> folio_remove_rmap_range() is the core API and page_remove_rmap() is
>> just a wrapper around it, i.e., folio_remove_rmap_range(page, 1, vma).
>> 
>> Let me post a diff later and see if it makes sense to you.
>
> I think that can make sense.  Because we limit to a single page table,
> specifying 'nr = 1 << PMD_ORDER' is the same as 'compound = true'.
> Just make it folio, page, nr, vma.  I'd actually prefer it as (vma,
> folio, page, nr), but that isn't the convention we've had in rmap up
> until now.

IIUC, even if 'nr = 1 << PMD_ORDER', we may remove one PMD 'compound'
mapping, or 'nr' PTE mapping.  So, we will still need 'compound' (or
some better name) as parameter.

--
Best Regards,
Huang, Ying
