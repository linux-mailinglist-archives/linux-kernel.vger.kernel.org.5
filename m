Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862BA7737B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjHHD2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjHHD2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:28:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B8010F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ee8YYW05CME00ewErNo+UK3igS6KjVnj9z96msv9rA=; b=az3Vx6msxNlYZ1nos7n6Svx9AH
        p/4XOlHlGWxK3iRcHiHgw1n+jK2cbUQLPZY7FkSSyUQ/JvyME+JSGn3mGuXDn7sLDhvp89o6cHcor
        4+CegyF9ccoXkS8FL+QHFBeXU+DZD3a3mEbhpX7Bqd7VqLpok2TtJm7cIjRzH251AJ24IRCt6yykm
        lIIsstxXAUtDnZgfD/+8Lkl9ENYvQhO0PZwVU8bDmhVEqpWwutNyJL26a06qw/zGqw62HXF1zswbG
        ISkq0ueA5lvd9DzRA85O2Rov/lP8mgkaRLun+O0OrMeRYXmggp2nal6XWeI5cxiL29m7PXLxjCZcM
        A0tkbL4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTDMu-00F6HF-D9; Tue, 08 Aug 2023 03:26:48 +0000
Date:   Tue, 8 Aug 2023 04:26:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove unneeded __meminit annotation
Message-ID: <ZNG1+PV5nG8YZDev@casper.infradead.org>
References: <20230808015831.608454-1-linmiaohe@huawei.com>
 <ZNGo5Y4vQ3rQn0vf@casper.infradead.org>
 <308f326d-c7ae-be49-22af-189a81a89aa2@huawei.com>
 <ZNGzqRYzC8lbLG9s@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNGzqRYzC8lbLG9s@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 04:16:57AM +0100, Matthew Wilcox wrote:
> On Tue, Aug 08, 2023 at 11:08:36AM +0800, Miaohe Lin wrote:
> > On 2023/8/8 10:31, Matthew Wilcox wrote:
> > > On Tue, Aug 08, 2023 at 09:58:31AM +0800, Miaohe Lin wrote:
> > >> kswapd_stop() and kcompactd_stop() are only called when MEMORY_HOTREMOVE
> > >> is enabled. So wrap them under CONFIG_MEMORY_HOTREMOVE and further remove
> > >> __meminit annotation. No functional change intended.
> > > 
> > > I don't understand why this is an improvement.  If CONFIG_MEMORY_HOTREMOVE
> > > is disabled, the linker drops this section (... right?)  If it's enabled,
> > 
> > When CONFIG_MEMORY_HOTREMOVE is disabled, without this patch:
> > 
> > size mm/compaction.o
> >    text	   data	    bss	    dec	    hex	filename
> >  103164	  30873	      0	 134037	  20b95	mm/compaction.o
> > 
> > size mm/vmscan.o
> >    text	   data	    bss	    dec	    hex	filename
> >  158775	  49612	     64	 208451	  32e43	mm/vmscan.o
> > 
> > while with this patch:
> > 
> > size mm/compaction.o
> >    text	   data	    bss	    dec	    hex	filename
> >  102915	  30865	      0	 133780	  20a94	mm/compaction.o
> > 
> > size mm/vmscan.o
> >    text	   data	    bss	    dec	    hex	filename
> >  158534	  49604	     64	 208202	  32d4a	mm/vmscan.o
> > 
> > We can reduce each .o by ~250 bytes.
> 
> But this is before the linker step!  That will be where the meminit
> sections get dropped.  Assuming they are; I haven't verified.  You need
> to compare before/after of the vmlinux, not the individual .o files.

Ah, found it:

#if defined(CONFIG_MEMORY_HOTPLUG)
#define MEM_KEEP(sec)    *(.mem##sec)
#define MEM_DISCARD(sec)
#else
#define MEM_KEEP(sec)
#define MEM_DISCARD(sec) *(.mem##sec)
#endif

in include/asm-generic/vmlinux.lds.h

So yeah, I think this patch is garbage.
