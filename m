Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A274C78373C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjHVBMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjHVBL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:11:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AD187;
        Mon, 21 Aug 2023 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+oF89Epzp8rU2t09SgoDNvxKdBu+3pJgx9pUxaygLvw=; b=F1xtJhYNk1h4XTTrv3ReqmxINp
        HieC3af3Dt1HbMRvxABAWnREuGbWuCwyJyu3kgI/UdhgQrfgjG4k/9czTB8V6ysaHIw5iqGhorsDR
        JqoPNj03GX8z1Zv5AWoHBUaiO4lK1ul0GbEVgO59JUMFAoF80j1P3CCVv5nnsQfICWeMjAyE2+TOz
        vsLdWt+UdO3JrQ/r2cR4h3YXBt1gcgKoWZfmMIBSXmNvxDIVY7j/RpSnc/R1Q9bk+6KkovLKFcber
        e5YqtoSejVN8bTTsUSg5C7ZD+c3ZUTdPOqgPfNtjRRgLtCWsE6U7iU7evix+U2LrrG20dGlEeycjv
        vkpKvMQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYFvs-00DRWs-DD; Tue, 22 Aug 2023 01:11:44 +0000
Date:   Tue, 22 Aug 2023 02:11:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <ZOQLUMBB7amLUJLY@casper.infradead.org>
References: <20230822095537.500047f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822095537.500047f7@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 09:55:37AM +1000, Stephen Rothwell wrote:
> In file included from include/trace/trace_events.h:27,
>                  from include/trace/define_trace.h:102,
>                  from fs/xfs/xfs_trace.h:4428,
>                  from fs/xfs/xfs_trace.c:45:
> include/linux/pgtable.h:8:25: error: initializer element is not constant
>     8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)

Ummm.  PowerPC doesn't have a compile-time constant PMD size?

arch/powerpc/include/asm/book3s/64/pgtable.h:#define PMD_SHIFT  (PAGE_SHIFT + PTE_INDEX_SIZE)
arch/powerpc/include/asm/book3s/64/pgtable.h:#define PTE_INDEX_SIZE  __pte_index_size

That's really annoying.  I'll try to work around it.

