Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D07D40D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjJWUWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:22:04 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08BAB3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:22:01 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5ac376d311aso12635797b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698092521; x=1698697321; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtHnwDlzHbUiujPWw3BJpppYflbolizDxSGdCmF15lk=;
        b=y13uE7frGa+mzHmf+OxMMEAPaw60vh+MEiIg5z+9tbQ9I0uV8Wa+9K8djuqeXySWa8
         ZlRs/n2xwHTYNGi6+KU/jT+Xu2D1Ncz9543SZDqujpqIQKQbC7ekN3pRKhuzWicpG9YV
         pB5bcHa4DW4KQF9FCLRYJbiXrSvZyBh/sPY+05N8xYCHCj2K9C2EegOlwC6m30ZUTssU
         AlNJPONTwOenR5i+lB2lHlBgKG8aZEvYjThXfIkzJvjIXXReuyf0yB0LRp4+Rqqc7pgJ
         jLLkNrl4Cq5+aaCqtk2ik2oo3m+9lj2V5W3OaKrlSHGOfl2fkFk6yUCyBD/4lIIo7PKh
         a4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092521; x=1698697321;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtHnwDlzHbUiujPWw3BJpppYflbolizDxSGdCmF15lk=;
        b=QYvUZ3AZGzd7ZgfpygqBDT6l4SvKoI1B11/drW9id4ydf8z2Gkq+3DZ3II/1wav+w+
         bEeWbijeluoCFqMf/bwGhaBaJR4iQO0I/66qgXRpfZkW5GGH9FtU9slI4/30LgD9bzu9
         3JgysmKNGA+9Y8kb6scqdbrUiEKyyCegywyM8PYRTaVlWi86yVfhecJchfI7DeMuU9p6
         tCnEIUYRBMBjVgq46KANBCtl35Cqoki2FF7ZWaGESkDj9txqSdAxCVA0pRrOPd3M0kXj
         Ufl1/NTj8hNJq0br07Vt7IrOWpWyjwVVjPLf6n3sF0rl/v9/PDz0Hj1ewU+Svy6DCB0i
         xNFg==
X-Gm-Message-State: AOJu0YzkT9cDNv5zsbBjuGlJt5+suOl8/JMbRN6DPjtGX9RbYxYJiJpS
        CWqWSnalPlTnBeZb4JjaGAqQhg==
X-Google-Smtp-Source: AGHT+IGzpXSYBJLpIrDRlztOlY2da03fJMUHnPvrzFATJOI4fX/tpYrZrnGXkT4+bv0mEHPPDN7idQ==
X-Received: by 2002:a25:cac7:0:b0:d9a:4fa0:dca9 with SMTP id a190-20020a25cac7000000b00d9a4fa0dca9mr10813474ybg.25.1698092520851;
        Mon, 23 Oct 2023 13:22:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z16-20020a5b0b10000000b00d911680fd10sm2932887ybp.50.2023.10.23.13.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 13:22:00 -0700 (PDT)
Date:   Mon, 23 Oct 2023 13:21:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        postmaster@duagon.onmicrosoft.com, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (3)
In-Reply-To: <20231023175519.4jtszivgfidn6p6j@revolver>
Message-ID: <2e63bcad-f283-f13c-505a-add6e87d69a8@google.com>
References: <000000000000985ef90607610b0a@google.com> <000000000000c05f1b0608657fde@google.com> <20231023175519.4jtszivgfidn6p6j@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023, Liam R. Howlett wrote:

> * syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com> [231023 13:24]:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    e8361b005d7c Add linux-next specific files for 20231023
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1207cb05680000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=75e8fc3570ec9a74
> > dashboard link: https://syzkaller.appspot.com/bug?extid=79fcba037b6df73756d3
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107fab89680000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/e28a7944599e/disk-e8361b00.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/7dd355dbe055/vmlinux-e8361b00.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/7b2a9050635d/bzImage-e8361b00.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com
> > 
> > =============================
> > WARNING: suspicious RCU usage
> > 6.6.0-rc6-next-20231023-syzkaller #0 Not tainted
> > -----------------------------
> > lib/maple_tree.c:856 suspicious rcu_dereference_check() usage!
> > 
> > other info that might help us debug this:
> > 
> > 
> > rcu_scheduler_active = 2, debug_locks = 1
> > no locks held by syz-executor.4/5222.
> > 
> > stack backtrace:
> > CPU: 0 PID: 5222 Comm: syz-executor.4 Not tainted 6.6.0-rc6-next-20231023-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
> >  lockdep_rcu_suspicious+0x20b/0x3a0 kernel/locking/lockdep.c:6711
> >  mas_root lib/maple_tree.c:856 [inline]
> >  mas_root lib/maple_tree.c:854 [inline]
> >  mas_start lib/maple_tree.c:1385 [inline]
> >  mas_state_walk lib/maple_tree.c:3705 [inline]
> >  mas_walk+0x4d1/0x7d0 lib/maple_tree.c:4888
> >  mas_find_setup lib/maple_tree.c:5948 [inline]
> >  mas_find+0x1e6/0x400 lib/maple_tree.c:5989
> >  vma_find include/linux/mm.h:952 [inline]
> >  do_mbind+0xc8f/0x1010 mm/mempolicy.c:1328
> 
> Hugh,
> 
> 41de65c4cd27 ("mempolicy: mmap_lock is not needed while migrating
> folios") changes the do_mbind() code locking here to drop the mmap write
> lock on line 1300 in e8361b005d7c.

Thanks Liam: yes, this is a good helpful find by syzbot.  The
"mmap_lock is not needed while migrating folios" patch was and is
good, but the "attempt to match interleave nodes" patch on top of that
then broke it, by adding a vma search after the mmap_lock drop point.

> 
> This is an issue as it opens the VMA (maple) tree to being updated, but
> you then re-walk the tree later.  If this is okay, then you can add an
> rcu_read_lock()/rcu_read_unlock() to iterate over the VMAs so it is
> safe (around 1327/1332, respectively).

Oh, that's a nice suggestion, thanks.  My first inclination was to
move the mmap_write_unlock() down, but perhaps the RCU way would be
neater.  Perhaps, but perhaps not: I'll think more and send a fix
patch later in the day.

> 
> I'm not entirely sure why this is safe to do without the mmap write
> lock, but considering the change log it seems you have thought through
> it.  I'm just not sure what is going to stop the VMAs from being split
> or such by a ref count on the memory policy (or if it matters if they
> are)?

Nothing stops those VMAs from being split or unmapped or remapped or
re-mbinded or whatever while doing the migrate_pages(&pagelist).
But those changes to the VMAs do not affect the work defined for
migrate_pages(&pagelist) at all (they may make that work redundant,
but such cases would be rare in reallife workloads).  Previously,
the VMAs were required to choose the migrate-to nodes; but now
that choice depends only on the refcounted mpols.

Hugh
