Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CCD7ACCF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 01:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjIXXmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 19:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 19:42:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41534DA;
        Sun, 24 Sep 2023 16:42:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C93BC433C7;
        Sun, 24 Sep 2023 23:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695598922;
        bh=9ZF3IoLRXqGI/hpsI7yQNEugIBPhe+O8QyOuSML+8nw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fg5OGepykvga+q20Fne4dweBz0cYFIcjkDhMPdc4KzRZblBK7bdUJmMo+23HO5EyS
         7qJSngXA2x0axtpqHRtlqkexCs40yhQRMWK32Fq6y+uOrZtbqEFABslR/ckWA3giXx
         lYJglvDcqZPQ4O4Ll/LpwmAYyfgtkuqUCoflLC9M=
Date:   Sun, 24 Sep 2023 16:42:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: linux-next: Signed-off-bys missing for commit in the
 mm-hotfixes tree
Message-Id: <20230924164201.863ad5e63a2d555f6d33254c@linux-foundation.org>
In-Reply-To: <20230925075026.2a6b4e65@canb.auug.org.au>
References: <20230925075026.2a6b4e65@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 07:50:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commit
> 
>   48248e468270 ("mm: hugetlb: add huge page size param to set_huge_pte_at()")
> 
> is missing Signed-off-bys from its author and committer.
> 
> It looks like the commit message has been truncated.

Ah, thanks.  The changelog has a stray ^---$:

: If CONFIG_DEBUG_VM is enabled, we do at least get a BUG(), but otherwise,
: it will dereference a bad pointer in page_folio():
: 
:     static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
:     {
:         VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
: 
:         return page_folio(pfn_to_page(swp_offset_pfn(entry)));
:     }
: 
: 
: Fix

<chomp>

: ---
: 
: The simplest fix would have been to revert the dodgy cleanup commit
: 18f3962953e4 ("mm: hugetlb: kill set_huge_swap_pte_at()"), but since
: things have moved on, this would have required an audit of all the new
: set_huge_pte_at() call sites to see if they should be converted to
: set_huge_swap_pte_at().  As per the original intent of the change, it
: would also leave us open to future bugs when people invariably get it
: wrong and call the wrong helper.

That's actually from the [0/n] intro, which I pasted into the [1/n]
changelog.

It gets through my scripts OK
(https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-add-huge-page-size-param-to-set_huge_pte_at.patch),
but it looks like git-quiltimport did the deed.

Let me add a check for that...
