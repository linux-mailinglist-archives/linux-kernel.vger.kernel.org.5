Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909E877C063
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHNTJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjHNTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:09:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E15110
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oVU9t1+lizTyVE1f/fKD/tkH+rpOHpGVs/bdM6v21qY=; b=eNqrWt3I4iP49TuR4/Nn4hjgVp
        7NR4Ch5oBDMbDI447MGCuZxWLKBTJdtA3gvJ+3HqOitb2wAkh592q2t+quvqqev2NQX6eBh4hsHJt
        2Xx1rDoE5j+amaiUfE8Ebzw8noA988kE6i8TKdBobtzZJT0LNYIzuknX1NQhjTgazSka8ZLpmqbUO
        ofvOjCh9PZ3MTaOocaWrhSiyn7d4h9N8A3vE+GUGLP4VsRmNAFxMUe6yvHruXLVtjgpy2wfehGoH4
        oU7D81fbrTcviazkqTDl0wYlvbw1CJgAYtp7YvFwb/kuKK2amKFMih5L1hJro4GTtZ1gYWpAVpYKh
        iPN3hwJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVcvx-003iZo-Bz; Mon, 14 Aug 2023 19:08:57 +0000
Date:   Mon, 14 Aug 2023 20:08:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/3] mm: Add TAIL_MAPPING_REUSED_MAX
Message-ID: <ZNp7yUgUrIpILnXu@casper.infradead.org>
References: <20230814184411.330496-1-peterx@redhat.com>
 <20230814184411.330496-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814184411.330496-2-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:44:09PM -0400, Peter Xu wrote:
> +/*
> + * This macro defines the maximum tail pages (of a folio) that can have the
> + * page->mapping field reused (offset 12 for 32bits, or 24 for 64bits).

No, don't say how many bytes into the structure something is.  It'll
only get out of date.  If somebody needs to know, use pahole.

> + * When the tail page's mapping field reused, it'll be exempted from
> + * ->mapping poisoning and checks.  Also see the macro TAIL_MAPPING.
> + */
> +#define  TAIL_MAPPING_REUSED_MAX  (2)

More importantly, I think this is over-parametrisation.  If you start to
use extra fields in struct folio, just change the code in page_alloc.c
directly.
