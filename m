Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29317B16D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjI1JFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjI1JFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:05:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D8AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=SxHL38RjHe6037MBAfXCcMCF+5KiGrNA+/J/Ios0pzA=; b=eTwumK+nrkmGvW5jDynZsL1xPN
        2DFOinky5TqWbM8vtEmOEgirgsA7o2mgW/Hxpz/8XX6uRKgu4sxP1h1d6hB7qr++O1hdozdS+HHqc
        3NPN+kU4INIShMjAiKCRRPLqiyXfo0OPJFGmYbvfbLC3zNwvzJZ8wZs+p7MhmGfquR2J6XGDcNvGS
        pAW22hyINKXFkbSZJuoP1XPNdBgNrk+114kD9CyBiaO/bVllzXJxPxjPMQhp9qqFcR1sNFuW/lYdK
        Fkfj5orENzk2Uqpouabztn+kJajDS2GKTJVMB6zXTU9d0f25VT9VkRzW76rT2sZrVE09RPSpx26vy
        V3D6xnOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlmxn-001Zto-Gx; Thu, 28 Sep 2023 09:05:39 +0000
Date:   Thu, 28 Sep 2023 10:05:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/khugepaged: Remove compound_pagelist
Message-ID: <ZRVB49PruFvT7+43@casper.infradead.org>
References: <20230922193639.10158-1-vishal.moola@gmail.com>
 <20230922193639.10158-3-vishal.moola@gmail.com>
 <CAHbLzkqt8LFFDH2a7+xaQmncwiK=Ynv6vHs9d=TDNjp9_wJ4rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkqt8LFFDH2a7+xaQmncwiK=Ynv6vHs9d=TDNjp9_wJ4rw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 03:07:18PM -0700, Yang Shi wrote:
> On Fri, Sep 22, 2023 at 9:33 PM Vishal Moola (Oracle)
> <vishal.moola@gmail.com> wrote:
> >
> > Currently, khugepaged builds a compound_pagelist while scanning, which
> > is used to properly account for compound pages. We can now account
> > for a compound page as a singular folio instead, so remove this list.
> >
> > Large folios are guaranteed to have consecutive ptes and addresses, so
> > once the first pte of a large folio is found skip over the rest.
> 
> The address space may just map a partial folio, for example, in the
> extreme case the HUGE_PMD size range may have HUGE_PMD_NR folios with
> mapping one subpage from each folio per PTE. So assuming the PTE
> mapped folio is mapped consecutively may be wrong.

How?  You can do that with two VMAs, but this is limited to scanning
within a single VMA.  If we've COWed a large folio, we currently do
so as a single page folio, and I'm not seeing any demand to change that.
If we did COW as a large folio, we'd COW every page in that folio.
How do we interleave two large folios in the same VMA?

> Please refer to collapse_compound_extreme() in
> tools/testing/selftests/mm/khugepaged.c.

I agree that running that part of the test-suite would be useful, but
could you point to which test specifically would create a problem here?
