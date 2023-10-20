Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C167E7D11F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377618AbjJTO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377598AbjJTO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:58:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275A19E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EVzWsEuaNJGLQOuFsDllHb6GxWozS+1uqoW74dil+CA=; b=Xbp9Ale5vTnUa8U7fTCHLtSDA1
        PiPaEWiPky7CbAAeyvBkkrwmtl0E440L8Uy1QmWZkCfkZLTRvGcTsbPz9XvEmy2HtVN4sr91K8b9K
        2u0ZRbUOSrMq/X4LaZ90/7N1IMJid5sPUAbelKpoZNZ/QDbnbtvcYFwe1OtcmxvPCydtnEVCSccWd
        whSGcT/GOoEh/ZQgoV/O1e1VLioHEGSknJiAMBCcxgUYDfOyf3OJP40JEYQ8GHuatVcl5i5e+Rsc7
        kC6tnSX2wchWOXvWgLwp5XjrhZYbQ7KSC2dFZF6QkDp4XBO4lk3iCcBZ1upi7eI75zLVX/VQLV7zN
        TGcPmLcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtqww-00Dj96-Jt; Fri, 20 Oct 2023 14:58:06 +0000
Date:   Fri, 20 Oct 2023 15:58:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Zhang Zhiyu <zhiyuzhang999@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, secalert@redhat.com
Subject: Re: KASAN: slab-use-after-free Read in radix_tree_lookup in&after
 Linux Kernel 6.4-rc6
Message-ID: <ZTKVfoQZplpB8rki@casper.infradead.org>
References: <CALf2hKtDJGqmsiSykbX8EEfbthwt6a4Bs98m60dUkS7URW-C8g@mail.gmail.com>
 <CALf2hKucyJjmgE8Ry50RvytMtWz8gVXGXwoECvoVYph7xkEDEQ@mail.gmail.com>
 <ZTI5tzh_tgCBnr35@alley>
 <ZTJz4/hddcv1J6pJ@casper.infradead.org>
 <ad7f2b88-d483-47d9-9f62-12b55805e1a3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7f2b88-d483-47d9-9f62-12b55805e1a3@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:51:18PM +0800, Qi Zheng wrote:
> Hi all,
> 
> On 2023/10/20 20:34, Matthew Wilcox wrote:
> > On Fri, Oct 20, 2023 at 10:26:31AM +0200, Petr Mladek wrote:
> > > Adding Matthew into Cc in the hope that he is still familiar with the
> > > code. Also adding Andrew who accepts patches.
> > 
> > oh joy.  i love dealing with cves.
> > 
> > > > > I agree, this issue looks to be in kernel-core radix tree code in ./lib/radix-tree.c in two of any places.
> > 
> > the radix tree code is the victim here.  maybe also the perpetrator, but
> > it's rather hard to say.
> > 
> > shrink_slab_memcg()
> > 	down_read_trylock(&shrinker_rwsem)
> > 	shrinker = idr_find(&shrinker_idr, i);
> > 
> > i assume is the path to this bug.  the reporter didn't run the
> > stacktrace through scripts/decode_stacktrace.sh so it's less useful than
> > we might want.
> > 
> > prealloc_memcg_shrinker() calls idr_alloc and idr_remove under
> > shrinker_rwsem in write mode, so that should be fine.
> > 
> > unregister_memcg_shrinker() calls idr_remove after asserting &shrinker_rwsem
> > is held (although not asserting that it's held for write ... hmm ... but
> > both callers appear to hold it for write anyway)
> > 
> > so i don't see why we'd get a UAF here.
> > 
> > anyway, adding Qi Zheng to the cc since they're responsible for the
> > shrinker code.
> 
> Thanks for CC'ing me, I'd be happy to troubleshoot any issues that may
> be shrinker related.
> 
> Between v6.4-rc1 and v6.4 versions, we briefly implemented lockless slab
> shrink using the SRCU method. In these versions, we call idr_alloc and
> idr_remove under shrinker_mutex, and idr_find under srcu_read_lock.
> 
> These are all legitimate uses of the IDR APIs and the shrinker_idr
> will never be destroyed, so at a quick glance I didn't see why it would
> cause UAF here.

I'm not an expert on how all the RCU flavours interact, but I don't
think that's safe.  The IDR (radix tree) will RCU-free nodes, but I
don't think holding the srcu_read_lock is enough to prevent the nodes
being freed.  I think you'd need to take the rcu_read_lock() around
the call to idr_find().

> Anyway I will keep working on this issue, and it would be nice if
> there was a way to reproduce it.

So I think the CVE is inappropriately issued.  The SRCU code was added in
v6.4-rc1 and removed before v6.4.  I don't think CVEs are appropriate for
bugs which only existed in development kernels.  How do we revoke CVEs?
