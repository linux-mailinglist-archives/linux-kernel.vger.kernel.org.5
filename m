Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3E7BBDF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJFRuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjJFRuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:50:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD7FB6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:50:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3B4C433C8;
        Fri,  6 Oct 2023 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696614617;
        bh=ezaBAA978dV4qGKI1Hk+XVCJoI17xD2mQigx1z5Hii0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sD7RhdItpYC6z9S8pZzd51a6UkqXvBynRqpuACzS6cBLRdc/z1Kor2vgtMwhB5LUO
         vMPleiMLFKRgVnBMUF37r6iuKjN8uUFs7vdjvSvWWs/34voXRZ9id779z5Ck1L2d1i
         aGtJNydxuewIGcWQCbBiDJINd/8qAvVaiBgsFca8=
Date:   Fri, 6 Oct 2023 10:50:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm/thp: fix
 "mm: thp: kill __transhuge_page_enabled()"
Message-Id: <20231006105012.61a12beefaa0f9a5adc8299f@linux-foundation.org>
In-Reply-To: <20230925200110.1979606-1-zokeefe@google.com>
References: <20230925200110.1979606-1-zokeefe@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 13:01:10 -0700 "Zach O'Keefe" <zokeefe@google.com> wrote:

> The 6.0 commits:
> 
> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> 
> merged "can we have THPs in this VMA?" logic that was previously done
> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
> 
> During the process, the semantics of the fault path check changed in two
> ways:
> 
> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
> 2) We no longer checked if non-anonymous memory had a vm_ops->huge_fault
>    handler that could satisfy the fault.  Previously, this check had been
>    done in create_huge_pud() and create_huge_pmd() routines, but after
>    the changes, we never reach those routines.
> 
> During the review of the above commits, it was determined that in-tree
> users weren't affected by the change; most notably, since the only relevant
> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> explicitly approved early in approval logic. However, this was a bad
> assumption to make as it assumes the only reason to support ->huge_fault
> was for DAX (which is not true in general).
> 
> Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> any ->huge_fault handler a chance to handle the fault.  Note that we
> don't validate the file mode or mapping alignment, which is consistent
> with the behavior before the aforementioned commits.

It's unclear what are the userspace visible impacts of this change. 
Which makes it hard for others to determine whether -stable kernels
should be patched.

> Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>

It's nice to include a Closes: link after a Reported-by:.  Then readers
are better able to answer the above question.

> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>

