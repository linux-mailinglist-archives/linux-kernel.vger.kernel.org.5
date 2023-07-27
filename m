Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8345F765CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjG0UI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjG0UIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:08:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D230C0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IhWA1oShucXppof+qg42YmcCjhcnT7SAUAkt3rakeD0=; b=R98/Lrn6IDomm0tcgvEXEmbsJT
        xKrwgZdwy0whwBN5p8pITyN2W8julJJeU6q2IDwmubwfSWlNRu6zdrwq2Pkm/MH6DFwcfFula7Am9
        ohP4Mz09yuE797XvlVCZuaZQRaK29J1wqhmZvv6+MKg/DmEvmnr1X/Tc64O1TcUhK77xP+d2HtwrQ
        EghO3TFO3zwiMZMKGTo9kVMWZmmGdoyqZUnrC23QAyia2PZiRtUebFEAl2onZHP0aTB/b3UxkNJmi
        5KiUGMIDCKdJfh4wkjJz1YnMvBOHnbiq+iO9Sy5KmXqW9+sOLLxC9hvByFa1FQY982PVc9vb/kLAb
        erTwwhzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qP7I0-007pjS-0V; Thu, 27 Jul 2023 20:08:48 +0000
Date:   Thu, 27 Jul 2023 21:08:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
Message-ID: <ZMLOz7rkW6hY5aW/@casper.infradead.org>
References: <000000000000607ff905ffc8e477@google.com>
 <0000000000000aeb7f06015e5cbd@google.com>
 <20230727164757.e2di75xjybxncohn@revolver>
 <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
 <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com>
 <ZMK0ony0LG2SL2Ha@casper.infradead.org>
 <CAG48ez0Qgtamxj7BieL5U+pWyQ3S+s3hVJfdJEevqk-hPAN3sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0Qgtamxj7BieL5U+pWyQ3S+s3hVJfdJEevqk-hPAN3sA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:20:33PM +0200, Jann Horn wrote:
> One kinda straightforward option would be to pass the vmf (or NULL if
> it's not in fault context) to anon_vma_prepare(), teach it to bail if
> it runs under the mm lock, and propagate a VM_FAULT_RETRY all the way
> up? It can already fail due to OOM, so the bailout paths exist, though
> you'd have to work a bit to plumb the right error code up.
> 
> And if you're feeling adventurous, you could try to build a way to
> opportunistically upgrade from vma lock to mmap lock, to avoid having
> to bail out all the way back up and then dive back in when that
> happens. Something that does mmap_read_trylock(); on failure, bail out
> with VM_FAULT_RETRY; on success, drop the VMA lock and change
> vmf->flags to note the changed locking context.

I think that's all a little more adventurous than I'd be comfortable
with right now ;-)  I just sent the fix patch that syzbot tested to
Andrew for integration.
