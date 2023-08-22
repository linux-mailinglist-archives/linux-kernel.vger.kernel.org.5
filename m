Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD50783769
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjHVBeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjHVBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FBE11D;
        Mon, 21 Aug 2023 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bmNbB4lcik3WJImnRw+7DGlZs0+TuQ35MXGFbjoZglE=; b=m7apti+Oh9q7vU5SqSK4Q+0cXg
        CdMozgIu1G7BEXJA8fIqhg5MW9+5i2/1aIoO8J11mrqcjxgekNE8Wc6C07KdSCWNqrqpjJG9muiO9
        5erHnCDgV9OxUsIRHfeZ4K0MfCMAiAwZzFt745NB81cyb2Zs+VSeEzUhMhR72xLyTMkkIlowV/AGe
        fcIkktduEXJTVf7r2oTGJL2G+ptfwquhwGdyDmHoWB1PqrGrDH9TaOQDdeioEsysIwoebqFA55epW
        JaWKWgzz2IhiM36jSrd0kS8UxgRrZGOUaF2v950xVaNsjLJa1mnx29PnxxbIUuKCf4JpQoZ7V/6ho
        lxUddUPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYGHW-00DZ1y-PE; Tue, 22 Aug 2023 01:34:06 +0000
Date:   Tue, 22 Aug 2023 02:34:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <ZOQQjmxeLM920/Q/@casper.infradead.org>
References: <20230822095537.500047f7@canb.auug.org.au>
 <ZOQLUMBB7amLUJLY@casper.infradead.org>
 <20230822112217.185c3357@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822112217.185c3357@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:22:17AM +1000, Stephen Rothwell wrote:
> Hi Matthew,
> 
> On Tue, 22 Aug 2023 02:11:44 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Aug 22, 2023 at 09:55:37AM +1000, Stephen Rothwell wrote:
> > > In file included from include/trace/trace_events.h:27,
> > >                  from include/trace/define_trace.h:102,
> > >                  from fs/xfs/xfs_trace.h:4428,
> > >                  from fs/xfs/xfs_trace.c:45:
> > > include/linux/pgtable.h:8:25: error: initializer element is not constant
> > >     8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)  
> > 
> > Ummm.  PowerPC doesn't have a compile-time constant PMD size?
> 
> Yeah, you are not the first (or probably the last) to be caught by that.

I think this will do the trick.  Any comments?

diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 1904eaf7a2e9..d5a4e6c2dcd1 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -796,15 +796,6 @@ DEFINE_INODE_EVENT(xfs_inode_reclaiming);
 DEFINE_INODE_EVENT(xfs_inode_set_need_inactive);
 DEFINE_INODE_EVENT(xfs_inode_inactivating);
 
-/*
- * ftrace's __print_symbolic requires that all enum values be wrapped in the
- * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in the ftrace
- * ring buffer.  Somehow this was only worth mentioning in the ftrace sample
- * code.
- */
-TRACE_DEFINE_ENUM(PMD_ORDER);
-TRACE_DEFINE_ENUM(PUD_ORDER);
-
 TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_SHARED);
 TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_COW);
 
@@ -823,13 +814,10 @@ TRACE_EVENT(xfs_filemap_fault,
 		__entry->order = order;
 		__entry->write_fault = write_fault;
 	),
-	TP_printk("dev %d:%d ino 0x%llx %s write_fault %d",
+	TP_printk("dev %d:%d ino 0x%llx order:%u write_fault %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
-		  __print_symbolic(__entry->order,
-			{ 0,		"PTE" },
-			{ PMD_ORDER,	"PMD" },
-			{ PUD_ORDER,	"PUD" }),
+		  __entry->order,
 		  __entry->write_fault)
 )
 


