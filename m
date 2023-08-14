Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBE77C059
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjHNTGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjHNTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:06:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C30D10F7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pv/oJkWDSXTVoPVR7KmdoJv2HB07fea1hw76M762x3k=; b=m6hGr6cdg4oW3bNsImeckK9GLj
        Ve6uDVbHHzBTj44X52+cNApSIVJMg3GUMoUHFdksGMIo/ZpIDD2bdVGXiFMBbe/gIyEeLedQYiwRW
        zaPomdWFsWK7dul0BCFzQBvG1T5O4xq0IoYUWr7++Ug2fsez79fMhltiYTSNcA3HiAwqy8pDId0P9
        7l/I6bib0vfxGbSKyO/RxuIOjea2rDmE7OQ1+uTL2GiwDeyeKmW2N5EkR2q4Uaxt028Fmfb2pULPB
        Qf9qLq7WcxSMsO6Sro9ZqFB6HffJBmAXLuojwOcrpOaaLLmEeM3UjzLTh9ucnYdsxuiEDQlLO1L1G
        ulxMhamg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVctI-003iSn-R4; Mon, 14 Aug 2023 19:06:12 +0000
Date:   Mon, 14 Aug 2023 20:06:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Message-ID: <ZNp7JDaPhT3Se4de@casper.infradead.org>
References: <20230812210053.2325091-1-zokeefe@google.com>
 <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:47:50AM -0700, Zach O'Keefe wrote:
> Willy -- I'm not up-to-date on what is happening on the THP-fs front.
> Should we be checking for a ->huge_fault handler here?

Oh, thank goodness, I thought you were cc'ing me to ask a DAX question ...

From a large folios perspective, filesystems do not implement a special
handler.  They call filemap_fault() (directly or indirectly) from their
->fault handler.  If there is already a folio in the page cache which
satisfies this fault, we insert it into the page tables (no matter what
size it is).  If there is no folio, we call readahead to populate that
index in the page cache, and probably some other indices around it.
That's do_sync_mmap_readahead().

If you look at that, you'll see that we check the VM_HUGEPAGE flag, and
if set we align to a PMD boundary and read two PMD-size pages (so that we
can do async readahead for the second page, if we're doing a linear scan).
If the VM_HUGEPAGE flag isn't set, we'll use the readahead algorithm to
decide how large the folio should be that we're reading into; if it's a
random read workload, we'll stick to order-0 pages, but if we're getting
good hit rate from the linear scan, we'll increase the size (although
we won't go past PMD size)

There's also the ->map_pages() optimisation which handles page faults
locklessly, and will fail back to ->fault() if there's even a light
breeze.  I don't think that's of any particular use in answering your
question, so I'm not going into details about it.

I'm not sure I understand the code that's being modified well enough to
be able to give you a straight answer to your question, but hopefully
this is helpful to you.
