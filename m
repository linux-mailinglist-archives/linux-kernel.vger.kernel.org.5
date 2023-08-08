Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C6577377C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjHHDRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjHHDRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:17:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830FE7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ln9p3P23Q5cQA+r9dkQJP5+/EvnF6BLwETg6xCvhWkE=; b=R5FIPgJq6zOdG/CQzwebQ4Ms/P
        Jhu/sPlNgPitmuY1rrDtWWwFU9p2oeLEGmBjYUwu/+HRCNezUBbhlXdiyoF9KmHvakBRRNW2nWTKN
        tUpOrkyQ4loeruCnETQ8TazT/kZk2uwHCtqXzSQXyzFeVoR/K7Z7pzhattEJ/IRJJrVTxp7JCTLBm
        lv00soUJicxZnVJRk4Lka7t7u51BlP08u0NcTGHXxof5BxdMV+iR07sSiDmbuVsMj6dBrz7eUsGHG
        MyxRIqHHS5dI+JHfPuzlbxXD6kY6ak4C/wyakxy0gCFwZmXJhUmUODymInYulBUDs+t9j7TdfIFN4
        UDYfI3Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTDDN-00F3a3-3o; Tue, 08 Aug 2023 03:16:57 +0000
Date:   Tue, 8 Aug 2023 04:16:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove unneeded __meminit annotation
Message-ID: <ZNGzqRYzC8lbLG9s@casper.infradead.org>
References: <20230808015831.608454-1-linmiaohe@huawei.com>
 <ZNGo5Y4vQ3rQn0vf@casper.infradead.org>
 <308f326d-c7ae-be49-22af-189a81a89aa2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308f326d-c7ae-be49-22af-189a81a89aa2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 11:08:36AM +0800, Miaohe Lin wrote:
> On 2023/8/8 10:31, Matthew Wilcox wrote:
> > On Tue, Aug 08, 2023 at 09:58:31AM +0800, Miaohe Lin wrote:
> >> kswapd_stop() and kcompactd_stop() are only called when MEMORY_HOTREMOVE
> >> is enabled. So wrap them under CONFIG_MEMORY_HOTREMOVE and further remove
> >> __meminit annotation. No functional change intended.
> > 
> > I don't understand why this is an improvement.  If CONFIG_MEMORY_HOTREMOVE
> > is disabled, the linker drops this section (... right?)  If it's enabled,
> 
> When CONFIG_MEMORY_HOTREMOVE is disabled, without this patch:
> 
> size mm/compaction.o
>    text	   data	    bss	    dec	    hex	filename
>  103164	  30873	      0	 134037	  20b95	mm/compaction.o
> 
> size mm/vmscan.o
>    text	   data	    bss	    dec	    hex	filename
>  158775	  49612	     64	 208451	  32e43	mm/vmscan.o
> 
> while with this patch:
> 
> size mm/compaction.o
>    text	   data	    bss	    dec	    hex	filename
>  102915	  30865	      0	 133780	  20a94	mm/compaction.o
> 
> size mm/vmscan.o
>    text	   data	    bss	    dec	    hex	filename
>  158534	  49604	     64	 208202	  32d4a	mm/vmscan.o
> 
> We can reduce each .o by ~250 bytes.

But this is before the linker step!  That will be where the meminit
sections get dropped.  Assuming they are; I haven't verified.  You need
to compare before/after of the vmlinux, not the individual .o files.

