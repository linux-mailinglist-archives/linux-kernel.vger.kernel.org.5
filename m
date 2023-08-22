Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD227838A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 06:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjHVEAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 00:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHVEAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 00:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3676C18D;
        Mon, 21 Aug 2023 21:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5D4760C27;
        Tue, 22 Aug 2023 04:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E24C433C7;
        Tue, 22 Aug 2023 04:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692676844;
        bh=wF7a9DTAEc49b0LtDfqEP844tiSjl8LoV4OyVI84GrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fc8rKzY4a6NetmVD0Ho2yK279RGwV6y2FgZFgttHBRx7f8WzmFqM8tmWigz1DznfN
         2K44pbbAm/BlD9hp9bYFmXCa3Rhg3Xhq7MWr2jPVIjB8VyO7Zt6d5PgPVqGgFQHdyQ
         qszgAydz84pRpkftlQ0C7Lwnv6IYTu95rJmqCJbKCzgqePq6vpoI0Z51KozWW7xcKw
         qLjcT7UzTqVVTMNz+dJFFWnWi2Ec+p8ACc9djXjXB8+SxGeZO8D7FAaLWgYyZTWQu+
         8zSjo4c2TLMErstWhrj7rPhOpdcOuYR+S54H2VN3pVK95MgPzS3NxmKAtvLI0jg74j
         vZtxLgnFBuuqA==
Date:   Mon, 21 Aug 2023 21:00:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230822040043.GB11263@frogsfrogsfrogs>
References: <20230822095537.500047f7@canb.auug.org.au>
 <ZOQLUMBB7amLUJLY@casper.infradead.org>
 <20230822112217.185c3357@canb.auug.org.au>
 <ZOQQjmxeLM920/Q/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOQQjmxeLM920/Q/@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:34:06AM +0100, Matthew Wilcox wrote:
> On Tue, Aug 22, 2023 at 11:22:17AM +1000, Stephen Rothwell wrote:
> > Hi Matthew,
> > 
> > On Tue, 22 Aug 2023 02:11:44 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 09:55:37AM +1000, Stephen Rothwell wrote:
> > > > In file included from include/trace/trace_events.h:27,
> > > >                  from include/trace/define_trace.h:102,
> > > >                  from fs/xfs/xfs_trace.h:4428,
> > > >                  from fs/xfs/xfs_trace.c:45:
> > > > include/linux/pgtable.h:8:25: error: initializer element is not constant
> > > >     8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)  
> > > 
> > > Ummm.  PowerPC doesn't have a compile-time constant PMD size?
> > 
> > Yeah, you are not the first (or probably the last) to be caught by that.
> 
> I think this will do the trick.  Any comments?
> 
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 1904eaf7a2e9..d5a4e6c2dcd1 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -796,15 +796,6 @@ DEFINE_INODE_EVENT(xfs_inode_reclaiming);
>  DEFINE_INODE_EVENT(xfs_inode_set_need_inactive);
>  DEFINE_INODE_EVENT(xfs_inode_inactivating);
>  
> -/*
> - * ftrace's __print_symbolic requires that all enum values be wrapped in the
> - * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in the ftrace
> - * ring buffer.  Somehow this was only worth mentioning in the ftrace sample
> - * code.
> - */

Please leave this ^^^ comment, because the need for TRACE_DEFINE_ENUM to
make enums work in tracepoints is not at all obvious.

> -TRACE_DEFINE_ENUM(PMD_ORDER);
> -TRACE_DEFINE_ENUM(PUD_ORDER);
> -
>  TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_SHARED);
>  TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_COW);
>  
> @@ -823,13 +814,10 @@ TRACE_EVENT(xfs_filemap_fault,
>  		__entry->order = order;
>  		__entry->write_fault = write_fault;
>  	),
> -	TP_printk("dev %d:%d ino 0x%llx %s write_fault %d",
> +	TP_printk("dev %d:%d ino 0x%llx order:%u write_fault %d",

"order %u" to match the (non dev_t) style of the rest of the xfs
tracepoints.

--D

>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->ino,
> -		  __print_symbolic(__entry->order,
> -			{ 0,		"PTE" },
> -			{ PMD_ORDER,	"PMD" },
> -			{ PUD_ORDER,	"PUD" }),
> +		  __entry->order,
>  		  __entry->write_fault)
>  )
>  
> 
> 
