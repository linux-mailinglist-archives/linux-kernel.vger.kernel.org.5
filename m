Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3009F7F63C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjKWQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKWQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:18:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5F41A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NNXxUTG8R40OhSLEVqBzS0dsS0Q8Pyvv4LmU/l+X8xE=; b=DTzQfItoUoWrSdgivicSkvfHbk
        LuUFl8J3TpwDSmzjNwoL7SR5i10AH+GQj/0ABB152Vd0/Xu4FU6jZjLoHCq9b25WXyeQ+lcX8PtZs
        Ksqha9OpHt+USc2a2yA70A5n1LBpfihkLr+YDZLR95g3xb28rMij4zqgYDCFLA2ws3Fp2ND6WOB31
        1rXaEUOY4NEI05mQyt8E+qAhw+qNs5k8YmJDN5dZ6w6J69cMAKRZIv8nIwHp2849WSKCOgzKK4bPv
        knCoYeilABV/xwstcKYlvqnD3EIKKmFEMEguPr2EyT3tnpjHAdBgUyoyRI0rA5a1GTg6zQ9U4op+c
        gJ/9F1rw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6CP6-007hXJ-21; Thu, 23 Nov 2023 16:18:12 +0000
Date:   Thu, 23 Nov 2023 16:18:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Message-ID: <ZV97RO3i02+NmwD2@casper.infradead.org>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <7f76ee6c-f0e6-443b-bcff-3637895dec66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f76ee6c-f0e6-443b-bcff-3637895dec66@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 05:05:37PM +0100, David Hildenbrand wrote:
> On 23.11.23 16:59, Matthew Wilcox wrote:
> > On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
> > > Note: I'm resending this at Andrew's suggestion due to having originally sent
> > > it during LPC. I'm hoping its in a position where the feedback is minor enough
> > > that I can rework in time for v6.8, but so far haven't had any.
> > > 
> > > Hi All,
> > > 
> > > This is v7 of a series to implement small-sized THP for anonymous memory
> > > (previously called "large anonymous folios"). The objective of this is to
> > 
> > I'm still against small-sized THP.  We've now got people asking whether
> > the THP counters should be updated when dealing with large folios that
> > are smaller than PMD sized.  It's sowing confusion, and we should go
> > back to large anon folios as a name.
> > 
> 
> I disagree.
> 
> https://lore.kernel.org/all/65dbdf2a-9281-a3c3-b7e3-a79c5b60b357@redhat.com/

And yet:
https://lore.kernel.org/linux-mm/20231106193315.GB3661273@cmpxchg.org/

"This is a small THP so we don't account it as a THP, we only account
normal THPs as THPs" is a bizarre position to take.

Not to mention that saying a foo is a small huge baz is just bizarre.
Am I a small giant?  Or just a large human?
