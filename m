Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE147ADC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjIYPuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjIYPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:49:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C997199B;
        Mon, 25 Sep 2023 08:48:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70841C433C8;
        Mon, 25 Sep 2023 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695656921;
        bh=ydw6MbSohqavIDDQv26z7jnbFjP4NN+5JbvGYYNEn+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Et6bCcEb6RTZ/kaR7i4cgQdrb85R3iQhBnO3yW+Ufr5ECgAVL4Cyt46Staj9nUkZU
         qfH8UwchovmBRYj00gpCCXcY9KFw2nCL6LN8ffmXsoWLc1y5qoPo3O+zkcI41n8d4I
         fuyGb7stM4MqvlNf2YeoX/VIhBryhPvwRf2oU2Uk=
Date:   Mon, 25 Sep 2023 08:48:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang@os.amperecomputing.com>
Cc:     hughd@google.com, surenb@google.com, willy@infradead.org,
        mhocko@suse.com, vbabka@suse.cz, osalvador@suse.de,
        aquini@redhat.com, kirill@shutemov.name, rientjes@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and
 MPOL_MF_MOVE are specified
Message-Id: <20230925084840.af05fefd19a101c71308a8cf@linux-foundation.org>
In-Reply-To: <20230920223242.3425775-1-yang@os.amperecomputing.com>
References: <20230920223242.3425775-1-yang@os.amperecomputing.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 15:32:42 -0700 Yang Shi <yang@os.amperecomputing.com> wrote:

> When calling mbind() with MPOL_MF_{MOVE|MOVEALL} | MPOL_MF_STRICT,
> kernel should attempt to migrate all existing pages, and return -EIO if
> there is misplaced or unmovable page.  Then commit 6f4576e3687b
> ("mempolicy: apply page table walker on queue_pages_range()") messed up
> the return value and didn't break VMA scan early ianymore when MPOL_MF_STRICT
> alone.  The return value problem was fixed by commit a7f40cfe3b7a
> ("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified"),
> but it broke the VMA walk early if unmovable page is met, it may cause some
> pages are not migrated as expected.

So I'm thinking that a7f40cfe3b7a is the suitable Fixes: target?

> The code should conceptually do:
> 
>  if (MPOL_MF_MOVE|MOVEALL)
>      scan all vmas
>      try to migrate the existing pages
>      return success
>  else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
>      scan all vmas
>      try to migrate the existing pages
>      return -EIO if unmovable or migration failed
>  else /* MPOL_MF_STRICT alone */
>      break early if meets unmovable and don't call mbind_range() at all
>  else /* none of those flags */
>      check the ranges in test_walk, EFAULT without mbind_range() if discontig.
> 
> Fixed the behavior.
> 

