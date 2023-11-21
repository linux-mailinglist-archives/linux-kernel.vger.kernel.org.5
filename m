Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A87F2BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjKULlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:41:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265759C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mrerObRNr02Wz0BKyv1zQtU+Sqe7aHjbDRQlpll/bVM=; b=phMVJX+8kFvgpyZAndCrvxhsV9
        lJFF/DIhZkQ8+k+LVLuvbHgwni/KeDDiEJf0gb4HfAyDdAXj49+JTQ5OCNJnpFWH9dlBlXTKVkyZ9
        180HXB3SUcKfwD0+GnB+099dp0Q5pNGaiHdA4XjtGB2UC7dKwYTN2cU0az5HxDjBcQwF4f41FfmrA
        OBUGQL4lQsue2AUlet+N6XAmFBjnRRMVS1wy76WRKeBT/UgLYBVjm4J3waLHHm/Jo8ZJXMmhJnyNF
        5RW2mNK8bcVMhPV3XYPOwVLhXM3yGJw4BiGDF6b6Egw+5Whr6p82Ei9oLTIglSnf5PWM9QcZmyhJT
        tZm1307A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5P8C-00BQ92-0i;
        Tue, 21 Nov 2023 11:41:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91B563006F6; Tue, 21 Nov 2023 12:41:26 +0100 (CET)
Date:   Tue, 21 Nov 2023 12:41:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: lockdep + kasan bug?
Message-ID: <20231121114126.GH8262@noisy.programming.kicks-ass.net>
References: <20231120233659.e36txv3fedbjn4sx@moria.home.lan>
 <20231121103614.GG8262@noisy.programming.kicks-ass.net>
 <ZVyRHd-MjMdkLp6S@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVyRHd-MjMdkLp6S@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:14:37AM +0000, Mark Rutland wrote:

> > > 05117 The buggy address belongs to the variable:
> > > 05117  nr_large_chain_blocks+0x3c/0x40
> > 
> > This is weird, nr_lage_chain_blocks is a single variable, if the
> > compiler keeps layout according to the source file, this would be
> > chaing_block_bucket[14] or something weird like that.
> 
> I think the size here is bogus; IIUC that's determined form the start of the
> next symbol, which happens to be 64 bytes away from the start of
> nr_lage_chain_blocks.
> 
> From the memory state dump, there's padding/redzone between two global objects,
> and I think we're accessing a negative offset from the next object. More on
> that below.
> 
> > Perhaps figure out what it things the @size argument to
> > add_chain_block() would be?
> > 
> > > 05117 
> > > 05117 The buggy address belongs to the virtual mapping at
> > > 05117  [ffffffc081710000, ffffffc088861000) created by:
> > > 05117  paging_init+0x260/0x820
> > > 05117 
> > > 05117 The buggy address belongs to the physical page:
> > > 05117 page:00000000ce625900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x41d7a
> > > 05117 flags: 0x4000(reserved|zone=0)
> > > 05117 page_type: 0xffffffff()
> > > 05117 raw: 0000000000004000 fffffffe00075e88 fffffffe00075e88 0000000000000000
> > > 05117 raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> > > 05117 page dumped because: kasan: bad access detected
> > > 05117 
> > > 05117 Memory state around the buggy address:
> > > 05117  ffffffc081b7a780: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
> > > 05117  ffffffc081b7a800: 00 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9
> > > 05117 >ffffffc081b7a880: 04 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
> > > 05117                                         ^
> 
> In this dump:
> 
> * '00' means all 8 bytes of an 8-byte region areaccessible
> * '04' means the first 4 bytes on an 8-byte region are accessible
> * 'f9' means KASAN_GLOBAL_REDZONE / padding between objects
> 
> So at 0xffffffc081b7a880 we have a 4-byte object, 60 bytes of padding, then a
> 64-byte object.
> 
> I think the 4-byte object at 0xffffffc081b7a880 is nr_large_chain_blocks, and
> the later 64-byte object is chain_block_buckets[].

Oh! That's very helpful, thanks!

> I suspect the dodgy access is to chain_block_buckets[-1], which hits the last 4
> bytes of the redzone and gets (incorrectly/misleadingly) attributed to
> nr_large_chain_blocks.

That would mean @size == 0, at which point size_to_bucket() returns -1
and the above happens.

alloc_chain_hlocks() has 'size - req', for the first with the
precondition 'size >= rq', which allows the 0.

The second is an iteration with the condition size > req, which does not
allow the 0 case.

So the first, thing, IIRC, this is trying to split a block,
del_chain_block() takes what we need, and add_chain_block() puts back
the remainder, except in the above case the remainder is 0 sized and
things go sideways or so.

Does the below help?

---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..151bd3de5936 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3497,7 +3497,8 @@ static int alloc_chain_hlocks(int req)
 		size = chain_block_size(curr);
 		if (likely(size >= req)) {
 			del_chain_block(0, size, chain_block_next(curr));
-			add_chain_block(curr + req, size - req);
+			if (size > req)
+				add_chain_block(curr + req, size - req);
 			return curr;
 		}
 	}

