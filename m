Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB02766D85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjG1MoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjG1MoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E6187
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FCFE62130
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50F4C433C7;
        Fri, 28 Jul 2023 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690548260;
        bh=v8YrvVoPuUgOyELF1X35nwd/jvp6+wC1gtdJPz4y+Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtmW0C+sKb5EwCUN9lzSQxju06CENccgDK7vn+k/9oE8TEYvKtwlqIC4kcEhvTbZY
         UFYAJgHp8WwFvGxUctY7UOWhV1ZKQc4mJQvI2LA3Ul8bhd33KedOMJI7pOiHNyWOv+
         UIUh9zD8gj0THO7auxLeWbHPK5Yer3ye1dsb+anJq8Raa9/o7YxrF2ZjO2cAD0viZf
         f28H4YZzJVwmpduYHcM99AHY7Wp2NIsozV+frM3EgTIdipIJafDLi6kKUALefSPhR+
         lHzWdEEASTnL1GCcANUwomvqy1MttSue9OIhVgkzguWncL0rv3s9+4CISCgTJ1rGCq
         oXcf1DCZk+Pkg==
Date:   Fri, 28 Jul 2023 13:44:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jann Horn <jannh@google.com>, paulmck@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
Message-ID: <20230728124412.GA21303@willie-the-truck>
References: <BCDEA397-AA7A-4FDE-8046-C68625CDE166@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BCDEA397-AA7A-4FDE-8046-C68625CDE166@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 12:34:44PM -0400, Joel Fernandes wrote:
> > On Jul 27, 2023, at 10:57 AM, Will Deacon <will@kernel.org> wrote:
> > ﻿On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> >> if (READ_ONCE(vma->anon_vma) != NULL) {
> >>  // we now know that vma->anon_vma cannot change anymore
> >> 
> >>  // access the same memory location again with a plain load
> >>  struct anon_vma *a = vma->anon_vma;
> >> 
> >>  // this needs to be address-dependency-ordered against one of
> >>  // the loads from vma->anon_vma
> >>  struct anon_vma *root = a->root;
> >> }
> >> 
> >> 
> >> Is this fine? If it is not fine just because the compiler might
> >> reorder the plain load of vma->anon_vma before the READ_ONCE() load,
> >> would it be fine after adding a barrier() directly after the
> >> READ_ONCE()?
> > 
> > I'm _very_ wary of mixing READ_ONCE() and plain loads to the same variable,
> > as I've run into cases where you have sequences such as:
> > 
> >    // Assume *ptr is initially 0 and somebody else writes it to 1
> >    // concurrently
> > 
> >    foo = *ptr;
> >    bar = READ_ONCE(*ptr);
> >    baz = *ptr;
> > 
> > and you can get foo == baz == 0 but bar == 1 because the compiler only
> > ends up reading from memory twice.
> > 
> > That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONCE
> > when dereferencing pointer to pte table"), which was very unpleasant to
> > debug.
> 
> Will, Unless I am missing something fundamental, this case is different though.
> This case does not care about fewer reads. As long as the first read is volatile, the subsequent loads (even plain)
> should work fine, no?
> I am not seeing how the compiler can screw that up, so please do enlighten :).

I guess the thing I'm worried about is if there is some previous read of
'vma->anon_vma' which didn't use READ_ONCE() and the compiler kept the
result around in a register. In that case, 'a' could be NULL, even if
the READ_ONCE(vma->anon_vma) returned non-NULL.

The crux of the issue is that the compiler can break read-after-read
ordering if you don't use READ_ONCE() consistently. Sadly, judging by
the other part of the thread from Nadav, it's fiddly to fix this without
wrecking the codegen.

Will
