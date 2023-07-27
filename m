Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92B5765868
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjG0QRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjG0QRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B010B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93B1861EC0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00136C433C7;
        Thu, 27 Jul 2023 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474651;
        bh=HSafwvhjnkUwgp5hjhjpcPldOQdA7vHMNcgZDr3m1Hg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=faTWUviFoFcFudqdn2L/tCQOu+vuYIqf8174cKaN9DOitIXCkTbqmegX3ENgpyEA0
         LPnAO8s/kez5qiNoxgsf/fOQ0TJ+4TCC0vOYAzibiWKt1LHUAUTf2HkW8esova1X60
         p9JJq+sBM9Nxz1P+BmahmxRobEEyE6JJdzpnPkij2q6s4am0StfXxmsZLD0d7i4KT9
         luDYvuSwxFzLZyR8PDKz8qpYYUS6CJPPtyw3K/hmg4Nan7ks+BaS3jEoVuNN7yQZ3f
         AIDWY0whvwyk3jGPZnwLw7VZrdgfD0EBRqklqvozIUDvmijGsxtRqLUNZbmOjYhqkh
         QY0RAx1a60u/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9839CCE0B66; Thu, 27 Jul 2023 09:17:30 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:17:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
Message-ID: <696f108e-ae73-4795-aae4-56a895226dfa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck>
 <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
 <CAG48ez3OXbiruoATeSp-PZ9ZdDcFuwJ4+XCS6EgY_jrtcqqGcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3OXbiruoATeSp-PZ9ZdDcFuwJ4+XCS6EgY_jrtcqqGcw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 06:10:12PM +0200, Jann Horn wrote:
> On Thu, Jul 27, 2023 at 5:44 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, Jul 27, 2023 at 03:57:47PM +0100, Will Deacon wrote:
> > > On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> >
> > > > Assume that we are holding some kind of lock that ensures that the
> > > > only possible concurrent update to "vma->anon_vma" is that it changes
> > > > from a NULL pointer to a non-NULL pointer (using smp_store_release()).
> > > >
> > > >
> > > > if (READ_ONCE(vma->anon_vma) != NULL) {
> > > >   // we now know that vma->anon_vma cannot change anymore
> > > >
> > > >   // access the same memory location again with a plain load
> > > >   struct anon_vma *a = vma->anon_vma;
> > > >
> > > >   // this needs to be address-dependency-ordered against one of
> > > >   // the loads from vma->anon_vma
> > > >   struct anon_vma *root = a->root;
> > > > }
> >
> > This reads a little oddly, perhaps because it's a fragment from a larger
> > piece of code.
> 
> Yes, exactly. The READ_ONCE() would be in anon_vma_prepare(), which is
> a helper used to ensure that a VMA is associated with an anon_vma, and
> then the vma->anon_vma is used further down inside the fault handling
> path. Something like:
> 
> do_cow_fault
>   anon_vma_prepare
>     READ_ONCE(vma->anon_vma)
>     barrier()
>   finish_fault
>     do_set_pte
>       page_add_new_anon_rmap
>         folio_add_new_anon_rmap
>           __page_set_anon_rmap
>             [reads vma->anon_vma]
> 
> Anyway, I guess I'll follow what Paul and Matthew said and go with
> smp_load_acquire().

I thank you now, and you will thank youself later.  ;-)

							Thanx, Paul
