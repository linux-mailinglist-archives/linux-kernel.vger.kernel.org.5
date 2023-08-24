Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C80786E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbjHXLpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbjHXLpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BCD1736;
        Thu, 24 Aug 2023 04:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F75762E67;
        Thu, 24 Aug 2023 11:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9098FC433C7;
        Thu, 24 Aug 2023 11:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692877536;
        bh=bqg4AC3eDqVlX1fQcXaBKbc7lclcsa2EnTomz9BtnoM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J1exyjYTqaxQNWxzyLUgrmPhREuE80VEH/Ic3SOi2rwmZtDt7oIJz0jccx6cHvk4G
         QN+3+cuJhNM7rdG4ENXxJfVVQtKTEBC02P8FAQW3pcc/PRz1VogSSrA8zBwWI1F6Ap
         DVpgLqmqLPdUVPQ5X+HoanKHgfSfNLOqvaXRzKqlEHQTkzrzlijBKiDaH4cGG0IRTt
         kNAHcsqn38vCBxou2sbxm/wjU8e+TaAKwep9yfCK0sFnbI3X5pms6lclQctXl495vW
         M8umkX4YrVhNoFCej1GaSJc/MjVq7/tUK7m1ie84rkzzO0nPpzbndLzUKVp34nc/LQ
         L5YKBMCQRTo7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 32C7BCE035E; Thu, 24 Aug 2023 04:45:36 -0700 (PDT)
Date:   Thu, 24 Aug 2023 04:45:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: linux-next: manual merge of the nolibc tree with the mm-stable
 tree
Message-ID: <18989954-981e-46bb-a60b-973c1c58fd86@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230817133053.76d9f850@canb.auug.org.au>
 <28aeee7b-2de5-4f39-8eb5-3e3486eeed1b@t-8ch.de>
 <ZOb9OuFh/2pmkRv+@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOb9OuFh/2pmkRv+@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:48:26AM +0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Thu, Aug 24, 2023 at 08:41:18AM +0200, Thomas Weißschuh wrote:
> > Hi everybody,
> > 
> > On 2023-08-17 13:30:53+1000, Stephen Rothwell wrote:
> > > Today's linux-next merge of the nolibc tree got a conflict in:
> > > 
> > >   tools/include/nolibc/stdio.h
> > > 
> > > between commit:
> > > 
> > >   08d959738a95 ("selftests: line buffer test program's stdout")
> > > 
> > > from the mm-stable tree and commits:
> > > 
> > >   65ff4d19f792 ("tools/nolibc/stdio: add setvbuf() to set buffering mode")
> > >   2e00a8fc4f47 ("tools/nolibc: setvbuf: avoid unused parameter warnings")
> > > 
> > > from the nolibc tree.
> > >
> > > I fixed it up (I just used the latter version of this file) and can
> > > carry the fix as necessary. This is now fixed as far as linux-next is
> > > concerned, but any non trivial conflicts should be mentioned to your
> > > upstream maintainer when your tree is submitted for merging.  You may
> > > also want to consider cooperating with the maintainer of the conflicting
> > > tree to minimise any particularly complex conflicts.
> > 
> > how do we want to handle this one?
> > 
> > A small note to Linus in the PRs to him on how to resolve it seem
> > reasonable to me.
> > But I'm fairly new to the process.
> 
> My understanding is that Stephen's fix is still in his tree. We may indeed
> need to add a note to Linus in the PR about this one and the other one.

Yes, this is the usual approach.  The note to Linus normally includes the
URL for Stephen's email.  I usually also do the merge myself, publish
a branch to it, and include the name of that branch in my pull request
to Linus.  Linus usually prefers to resolve the merge conflicts himself,
but my merge gives him something to compare against.

							Thanx, Paul
