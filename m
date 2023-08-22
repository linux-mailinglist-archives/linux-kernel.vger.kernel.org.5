Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE4784B45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjHVUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjHVUUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:20:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17A8CC;
        Tue, 22 Aug 2023 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7/LTW4ARO//V3xdtFM8fbiG79s90dMawsmxlv8Tdz4s=; b=kNmyLNVWTPJyo1gYbyI29XsPB0
        R8OlJ9zgFHoPYUPIUnzeoLu5thoaCMOb639NKhxPvFvNAkhfiZBydiHMLBi5wH54PABEhZUmR/E1C
        DBuv7+QNmYXDQInS0dmtd24GYu6gL88QDIdGrnAPYwooLwcfdJWevbwPty7OdKQHCXvs5TfgxB/8J
        jhTNNBPWQlDb/FDzjGvsV+vJjW5DtBg91H3/2ZqNCPSAaJgV4wJhzqPEMoC4p9gE6o/gvby4SpJ6Q
        NzUdAU1x9weXyRtQmoE8LdqziEL4bR7Cd71pThbbpEsyjyUeFFPEhVYVFkaQymoZMtZ9ICsZp7+t6
        +TS4RwgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYXrG-000iCR-H4; Tue, 22 Aug 2023 20:20:10 +0000
Date:   Tue, 22 Aug 2023 21:20:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <ZOUYekbtTv+n8hYf@casper.infradead.org>
References: <20230822095537.500047f7@canb.auug.org.au>
 <ZOQLUMBB7amLUJLY@casper.infradead.org>
 <20230822112217.185c3357@canb.auug.org.au>
 <ZOQQjmxeLM920/Q/@casper.infradead.org>
 <20230822040043.GB11263@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822040043.GB11263@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:00:43PM -0700, Darrick J. Wong wrote:
> Please leave this ^^^ comment, because the need for TRACE_DEFINE_ENUM to
> make enums work in tracepoints is not at all obvious.
> 
> "order %u" to match the (non dev_t) style of the rest of the xfs
> tracepoints.

ACK, thanks.

Andrew, please add this -fix patch for "mm: Remove enum
page_entry_size".

diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 1904eaf7a2e9..fd789e00dfd6 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -802,9 +802,6 @@ DEFINE_INODE_EVENT(xfs_inode_inactivating);
  * ring buffer.  Somehow this was only worth mentioning in the ftrace sample
  * code.
  */
-TRACE_DEFINE_ENUM(PMD_ORDER);
-TRACE_DEFINE_ENUM(PUD_ORDER);
-
 TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_SHARED);
 TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_COW);
 
@@ -823,13 +820,10 @@ TRACE_EVENT(xfs_filemap_fault,
 		__entry->order = order;
 		__entry->write_fault = write_fault;
 	),
-	TP_printk("dev %d:%d ino 0x%llx %s write_fault %d",
+	TP_printk("dev %d:%d ino 0x%llx order %u write_fault %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
-		  __print_symbolic(__entry->order,
-			{ 0,		"PTE" },
-			{ PMD_ORDER,	"PMD" },
-			{ PUD_ORDER,	"PUD" }),
+		  __entry->order,
 		  __entry->write_fault)
 )
 
