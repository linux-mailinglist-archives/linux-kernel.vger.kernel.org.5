Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D937BBE34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjJFR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjJFR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:58:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99062F2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:58:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD3EC433C8;
        Fri,  6 Oct 2023 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696615094;
        bh=/dh5o3vWItJHeqi+Jctz9Aohs2n01RWuS4p9vbXTwxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R3J+IEBH4g7L6uACK+OXDCCPlXx1KjCksohxDjEEzAIPhkzKTJuePVliCGN/x4iVx
         Z8j6+p/4BAOFu86exLeYgqHNbWjUgjm5aJLhxAcDOCXFE60ShxCPMSdcyu9s+79jUp
         RC4fBwVB+kk51aLQYpmZJNa27w6Pyn3t8G4ZJcy4=
Date:   Fri, 6 Oct 2023 10:58:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v4] mm/thp: fix
 "mm: thp: kill __transhuge_page_enabled()"
Message-Id: <20231006105810.17fcb352e33cbcab1645099b@linux-foundation.org>
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
>
> ...
>
> @@ -100,11 +100,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>  		return in_pf;
>  

Ryan's "mm: thp: introduce anon_orders and anon_always_mask sysfs
files" changes hugepage_vma_check() to return an unsigned int, so this
patch will need some rework to fit in after that.

However Ryan's overall series "variable-order, large folios for
anonymous memory" is in early days and might not make it.

And as I don't know what is the urgency of this patch ("mm/thp: fix
"mm: thp: kill __transhuge_page_enabled()"), I'm unable to decide which
patch needs to come first (thus requiring rework of the other patch).

Please discuss!
