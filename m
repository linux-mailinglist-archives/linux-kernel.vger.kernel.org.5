Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273CD7BFB85
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjJJMdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjJJMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:33:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C77BA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r7PU9+R9xblJXkgC2lGMjtnDsyoxIr/IU5up/DlfVlM=; b=lSWfStmJe7ptbqfMebM6DRSv2N
        FhFEOV+LzDWnrXag5p7bAqLzOJ7vgZW3mrtLLcKOF8h5ZaK50Tx1HVN91MmfG7iRnHnStsIo3aOAT
        IU/qg3IXsEFRtKq3xDAbIS/H1+fuxd+oANdKeVyWG8nq5yMVnrZkD2GihWUKIgsW0836WSOQfnUdc
        jFAoEDIRio54X6/xO5nPts/QapctehXsKCNbfuV+ZqnyyZVUvDJQCAZREOBJgRYd+L7LizQVBk5u2
        /2SwPCluhFgtX9VcBB0/DGGMAzweN0hCeCOwlkADeDXZc1tSTGq+BZQbmu3F9dA+vzo3o1al0GvGd
        uS3q4Z5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqBvW-004c96-FT; Tue, 10 Oct 2023 12:33:30 +0000
Date:   Tue, 10 Oct 2023 13:33:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        david@redhat.com, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH -next 1/7] mm_types: add _last_cpupid into folio
Message-ID: <ZSVEmhPCjZKyp97a@casper.infradead.org>
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
 <20231010064544.4162286-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010064544.4162286-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:45:38PM +0800, Kefeng Wang wrote:
> At present, only arc/sparc/m68k define WANT_PAGE_VIRTUAL, both of
> them don't support numa balancing, and the page struct is aligned
> to _struct_page_alignment, it is safe to move _last_cpupid before
> 'virtual' in page, meanwhile, add it into folio, which make us to
> use folio->_last_cpupid directly.

What do you mean by "safe"?  I think you mean "Does not increase the
size of struct page", but if that is what you mean, why not just say so?
If there's something else you mean, please explain.

In any event, I'd like to see some reasoning that _last_cpupid is actually
information which is logically maintained on a per-allocation basis,
not a per-page basis (I think this is true, but I honestly don't know)

And looking at all this, I think it makes sense to move _last_cpupid
before the kmsan garbage, then add both 'virtual' and '_last_cpupid'
to folio.

