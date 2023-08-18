Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4E78154D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbjHRWPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241101AbjHRWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:14:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A83ABC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eX2vIZMS8ssxhxsbyPHJWvxPLuQicV1dHreCWKMt4ZI=; b=i6f1Z6aiar+OqEKAayGlXBUrnh
        fnEntktUEZejD9Od5jliQpopPz5QiYvfVW9GZh93w/mIV9z1rc3gAaA8EsxSa+tyhlLsRoarxgn0B
        5GCnGnEDKhGLPf4acfZ0gWiQSA4SsP6dowdY7KW7G7GBUjHcQYsOEyI+x5U6fAytoo6WmnluEEzgu
        KZRQiFTV/lvGGCjecgZIGh1iOxqQr9H2ldlTpNbUEuB8QCD1MD/eEb7OOTxcCjSEha8W4U8FGWPK+
        ILD9s1yaNXTZDtpyUlqN9evkNXSVDtsmlmfwl6DEAbBnQdwZ6vqWLjGzLH4E7HOA5WAeKtMbtY/UV
        TyyaLQ5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX7jg-00ByNs-Pr; Fri, 18 Aug 2023 22:14:28 +0000
Date:   Fri, 18 Aug 2023 23:14:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Wire up tail page poisoning over ->mappings
Message-ID: <ZN/tRLy0e+Iod9z3@casper.infradead.org>
References: <20230815210659.430010-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815210659.430010-1-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 05:06:59PM -0400, Peter Xu wrote:
> I split this out from another rfc series.  Removed RFC tag because it
> wasn't for this patch but for the documentation updates.  I'll post the rfc
> part alone.  Comments welcomed, thanks.

I still hate it, as I explained here:

https://lore.kernel.org/linux-mm/ZNp7yUgUrIpILnXu@casper.infradead.org/

> > + * When the tail page's mapping field reused, it'll be exempted from
> > + * ->mapping poisoning and checks.  Also see the macro TAIL_MAPPING.
> > + */
> > +#define  TAIL_MAPPING_REUSED_MAX  (2)
> 
> More importantly, I think this is over-parametrisation.  If you start to
> use extra fields in struct folio, just change the code in page_alloc.c
> directly.

