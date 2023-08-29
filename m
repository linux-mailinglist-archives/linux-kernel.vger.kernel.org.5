Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED9978C77C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbjH2OZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbjH2OZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:25:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C2B8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CVKHTAOju4/Kpfxf3rY34wfjvySGLxW/e01pPFR8Jb0=; b=ni8iwXg3R/pSgOwiM/4UWsVy/+
        JU7IDy4YZ4CCuTp7Xdjn67Wn54IkOF4kkb8N+jhQwpljIpbECPz8/gofMM3Asc53AvkxwQIqhR2/F
        FTjmMfASMTB6XW8Tw0oaOHdPAFZ/dwkE9ROEJo6LvbIOQ3zbCmiiF/dw9dJCmtH2r33/yYXDRQpsO
        wdnTlP95VBtRAfjIQvhP35ajSdxBrUIhT7kRSTMshf25sGJuZJV3bO5Pop0mQOETeCYfHOBepebLo
        KJkP+K/lqpLv38PngbOhInZ/Juk5VJ8bWbqLFGhv33Bcyn+t1UCM/TZtsMEHYN5SSpvgAsBO8YW/+
        C2qBCGuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qazeH-0073hu-Un; Tue, 29 Aug 2023 14:24:53 +0000
Date:   Tue, 29 Aug 2023 15:24:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Message-ID: <ZO3/tYWCahFJAHhu@casper.infradead.org>
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <ZOgpb1Qo5B0r+mhJ@casper.infradead.org>
 <29099099-7ef2-45cb-bab7-455f58de47d1@arm.com>
 <ZO3+cQouje862QNu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO3+cQouje862QNu@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:19:29PM +0100, Matthew Wilcox wrote:
> > > You'll be glad to know I've factored out a nice little helper for that.
> > 
> > OK, what's it called? This is just copied from release_pages() at the moment.
> > Happy to use your helper in the refactored common helper.
> 
> I'll send out those patches today.

No, wait, I sent them on Friday.

https://lore.kernel.org/linux-mm/20230825135918.4164671-9-willy@infradead.org/

is the important one from your point of view.  It's
__page_cache_release() which is a little different from the current
__page_cache_release()
