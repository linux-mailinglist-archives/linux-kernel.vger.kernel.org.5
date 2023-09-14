Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F987A0DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbjINTJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjINTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:09:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD3D1FC7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7/m3bz/FMIYfip9hzUryY5fsZo8BtjCMUb7iqvvNxc8=; b=KBQHYU+OC2p0pEcUvBBR0Be/w3
        g5TVCjkKEIo7PSyc6KjLHHhobgiWZGpRszgsixVRz3zDMHXAKV/mS7d+r1zhcXJ9tZe+uHIZkPhQQ
        d79lQHtWTNXPq03Mzly1jE08YbUvHNIdlCpSXW7YefWSf7FUfAJlhPUE5ywPX9XLa+CkYcLoAhLLQ
        9nznEIOxVBg5MHP/zQ7eezP0NgPoypT91tJ1RvbOx+4zFvl+KLI7fgLtoxOwp+BOKU/SEfb+gBKnx
        jxA7Y8l4ORamvaeN2oP5IGzMFtTBu6oLKjHGju9pdfpr1JxSHssXh68Q5y9OjaeFEfoy9CR1wzR5p
        DCqOIWsw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgri3-004eEd-Ck; Thu, 14 Sep 2023 19:09:03 +0000
Date:   Thu, 14 Sep 2023 20:09:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
Message-ID: <ZQNaT/3xPxATKJVR@casper.infradead.org>
References: <000000000000f392a60604a65085@google.com>
 <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org>
 <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
 <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
 <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 06:20:56PM +0000, Suren Baghdasaryan wrote:
> I think I found the problem and the explanation is much simpler. While
> walking the page range, queue_folios_pte_range() encounters an
> unmovable page and queue_folios_pte_range() returns 1. That causes a
> break from the loop inside walk_page_range() and no more VMAs get
> locked. After that the loop calling mbind_range() walks over all VMAs,
> even the ones which were skipped by queue_folios_pte_range() and that
> causes this BUG assertion.
> 
> Thinking what's the right way to handle this situation (what's the
> expected behavior here)...
> I think the safest way would be to modify walk_page_range() and make
> it continue calling process_vma_walk_lock() for all VMAs in the range
> even when __walk_page_range() returns a positive err. Any objection or
> alternative suggestions?

So we only return 1 here if MPOL_MF_MOVE* & MPOL_MF_STRICT were
specified.  That means we're going to return an error, no matter what,
and there's no point in calling mbind_range().  Right?

+++ b/mm/mempolicy.c
@@ -1334,6 +1334,8 @@ static long do_mbind(unsigned long start, unsigned long len,
        ret = queue_pages_range(mm, start, end, nmask,
                          flags | MPOL_MF_INVERT, &pagelist, true);

+       if (ret == 1)
+               ret = -EIO;
        if (ret < 0) {
                err = ret;
                goto up_out;

(I don't really understand this code, so it can't be this simple, can
it?  Why don't we just return -EIO from queue_folios_pte_range() if
this is the right answer?)
