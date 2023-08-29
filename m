Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF4E78CCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjH2TN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239839AbjH2TNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:13:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3C0193
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fxxwqPfI4ZPMl7V+SYOrn3sysRQ47yzu4QoySEktQoo=; b=ogx7s3SFQLQiyWYzlQWAnZK7lG
        FNLqdscOtjWC/sSSxEncfqfmhkBl8rxupJMDs42+XCG5iXuPt4+/RXIUeWzgStQ1qZTd4PJo6S/T6
        bb7f87eOut5C31YwG+i+Ym5F3XJjjmFDl5+fyAajyRkq+1cD4j7g1UTB65aVDrnYVsKwB2A4toF/W
        CcAFzBlQtN2YOxNuwPPG3iSnM8S8FbIAq6pCoAbFjfOs0pXCAm2vSxaXxMzI83/z2V3F8Yd1vOpB7
        tiVa8POAqeBya2dz6KFYV9lBqHDL4Y0qNCWfKh2GeTa1BSk4j5a9k5hcfWKpmZW16AVHRKZdrkRwg
        jSTzku9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qb49H-008Iun-SQ; Tue, 29 Aug 2023 19:13:11 +0000
Date:   Tue, 29 Aug 2023 20:13:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
Message-ID: <ZO5DR771Khv1d5gR@casper.infradead.org>
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:14:23PM +0200, Mirsad Todorovac wrote:
> In the vanilla torvalds tree 6.5 kernel on the Ubuntu 22.04 system, KCSAN found another data race:

KCSAN is wrong.

> [   34.102069] write (marked) to 0xffffef9a44978bc0 of 8 bytes by interrupt on cpu 28:
> [   34.108569] mpage_read_end_io (/home/marvin/linux/kernel/linux_torvalds/./arch/x86/include/asm/bitops.h:55 /home/marvin/linux/kernel/linux_torvalds/./include/asm-generic/bitops/instrumented-atomic.h:29 /home/marvin/linux/kernel/linux_torvalds/./include/linux/page-flags.h:739 /home/marvin/linux/kernel/linux_torvalds/fs/mpage.c:55)

        bio_for_each_folio_all(fi, bio) {
                if (err)
                        folio_set_error(fi.folio);
                else
                        folio_mark_uptodate(fi.folio);
                folio_unlock(fi.folio);
        }

It's noting the write to folio->flags in folio_mark_uptodate().  You can
see it's locked.  Also, the folio is under I/O.

> [   34.115221] read to 0xffffef9a44978bc0 of 8 bytes by task 348 on cpu 12:
> [   34.121702] folio_batch_move_lru (/home/marvin/linux/kernel/linux_torvalds/./include/linux/mm.h:1814 /home/marvin/linux/kernel/linux_torvalds/./include/linux/mm.h:1824 /home/marvin/linux/kernel/linux_torvalds/./include/linux/memcontrol.h:1636 /home/marvin/linux/kernel/linux_torvalds/./include/linux/memcontrol.h:1659 /home/marvin/linux/kernel/linux_torvalds/mm/swap.c:216)

Here, it's noting the read to folio->flags that's part of page_to_nid().

> [   34.121713] folio_batch_add_and_move (/home/marvin/linux/kernel/linux_torvalds/mm/swap.c:235)
> [   34.121724] folio_add_lru (/home/marvin/linux/kernel/linux_torvalds/./arch/x86/include/asm/preempt.h:95 /home/marvin/linux/kernel/linux_torvalds/mm/swap.c:518)
> [   34.121735] folio_add_lru_vma (/home/marvin/linux/kernel/linux_torvalds/mm/swap.c:538)
> [   34.121746] do_anonymous_page (/home/marvin/linux/kernel/linux_torvalds/mm/memory.c:4146)

Here we can see the page is freshly allocated.

So KCSAN has three things wrong here.  One is that the write to
folio_mark_uptodate() is setting a bit, that is nowhere near the bits
that are used for the node ID.  It can't know that; it doesn't track
writes at that granularity.

The second thing is that the node bits in folio->flags are immutable.
They're set at boot (or memory hotplug).  There is never a race risk when
reading them.  Presumably there needs to be some kind of annotation to
tell KCSAN that this is always safe.

The third thing is that these two accesses cannot race.  The write is
to a folio which is under I/O, so cannot be freed.  The read is to a
folio which has just been allocated, so cannot be under I/O.  This is
some kind of failure of KCSAN.

