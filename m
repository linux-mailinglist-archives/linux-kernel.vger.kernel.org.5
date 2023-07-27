Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B3F765B94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjG0SrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjG0SrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:47:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA93358D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v+2d2fz9rEME7Y0Xsx/fiwIu2EBkpqU7AjglSy6mvgw=; b=h1plePO/YXRkcTPAxTeQ9SuQ8p
        5Ta7Znt8oEbDNYWorNcsi7Hhf4raQKG7hIo34yo7OfsM3+cnIF/A3djQ5LrFfE4lUpeIqXMWGYM7D
        P+eLz1Bo/zMZdRqZ30SavW5bxsJv9M1pvl7c2Ch/h5lamhNjQqeQTxSttmh7LrIGGmoWHjx3SOFBi
        8rCk3YBDL1syjT5Ld5cL3aU9wA8O1Q/9kv7ZpxH2O5H5Mm5pIga82icpoXuB0+P/8lYhXi2am22J1
        h8hycSzAwE8Ichk8xq4a5e44ObjKBYEKvfC0O4cON6OMNfws6+qIZioBQ4bJXsGIApvw0WJ9O2GXy
        g9LOXXVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qP60V-007m3X-CS; Thu, 27 Jul 2023 18:46:39 +0000
Date:   Thu, 27 Jul 2023 19:46:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Jann Horn <jannh@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
Message-ID: <ZMK7jwpI4uD6tKrF@casper.infradead.org>
References: <000000000000607ff905ffc8e477@google.com>
 <0000000000000aeb7f06015e5cbd@google.com>
 <20230727164757.e2di75xjybxncohn@revolver>
 <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
 <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com>
 <ZMK0ony0LG2SL2Ha@casper.infradead.org>
 <CAJuCfpEWfFY_JXoXDnK0X+rY6Qf==RBpLzSSJhEtgU50HHp4-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEWfFY_JXoXDnK0X+rY6Qf==RBpLzSSJhEtgU50HHp4-A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:31:01AM -0700, Suren Baghdasaryan wrote:
> A comment for __anon_vma_prepare() says "This must be called with the
> mmap_lock held for reading."
> I think adding an explicit mmap_assert_locked() in this function would
> help catch such issues.

Would it catch them faster than syzbot?

> > +++ b/mm/memory.c
> > @@ -3197,6 +3197,12 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >         struct mmu_notifier_range range;
> >         int ret;
> >
> > +       if (!vma->anon_vma) {
> > +               // check if there are other things to undo here
> > +               vma_end_read(vmf->vma);
> > +               return VM_FAULT_RETRY;
> > +       }
> > +
> 
> This one bails out later but if the path is not taken too often I
> think it's cleaner.

OK, then I think the right place to put this check is slightly before
this function is called, to avoid bouncing the folio refcount:

+++ b/mm/memory.c
@@ -3567,6 +3567,12 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
                return 0;
        }
 copy:
+       if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma->anon_vma) {
+               pte_unmap_unlock(vmf->pte, vmf->ptl);
+               vma_end_read(vmf->vma);
+               return VM_FAULT_RETRY;
+       }
+
        /*
         * Ok, we need to copy. Oh, well..
         */

... it compiles.  Guess I should figure out the syntax to ask syzbot to
test it.
