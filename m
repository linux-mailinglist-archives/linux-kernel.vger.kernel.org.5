Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53F476F308
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjHCSwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHCSwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3FE4219;
        Thu,  3 Aug 2023 11:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FAD261E67;
        Thu,  3 Aug 2023 18:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD36FC433C7;
        Thu,  3 Aug 2023 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691088726;
        bh=C4EW4wbKCHTYy6MNIaLyL7a1gGIegviHQ8l+Ecex1SQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H2C7gNwNpz8RClNWocDqQRDE8DGjNnPE6tJd4q10HUbE0iwB4z0IsH1/GPe0yB1c5
         1+bZR2EYET3zvXmCCKtfFMBjVc/6DbZOpMXFvvcWJyltoA3mKnMfXXU1zEuVig+8j3
         HeXmq2nGSe+vwQdzm5XVpgaTj1i/vNBWJHlrfJDnyUHK6OOcZY/JaYgc9ZzOILxvOf
         O2XUOZKoarBoCwdyn0bL6Ygc9DBlY68A5Lzq/NC/QSP7CbsEC+5wexdePO4DXvJRdV
         ydHeSFYXrUgXl85O4TZx/t5VSqUsMKp1H1qlMeCXwp0HO3vC6XefVHpCkoV4I4NKQc
         S9mlIyA83T0Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3DE1ACE0AE0; Thu,  3 Aug 2023 11:52:06 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:52:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/2] docs: memory-barriers: Add note on plain-accesses to
 address-dependency barriers
Message-ID: <626d1b48-de6a-4a0b-95d3-3ac438878757@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230803032408.2514989-1-joel@joelfernandes.org>
 <20230803032408.2514989-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803032408.2514989-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 03:24:07AM +0000, Joel Fernandes (Google) wrote:
> The compiler has the ability to cause misordering by destroying
> address-dependency barriers if comparison operations are used. Add a
> note about this to memory-barriers.txt and point to rcu-dereference.rst
> for more information.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/memory-barriers.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 06e14efd8662..acc8ec5ce563 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -435,6 +435,11 @@ Memory barriers come in four basic varieties:
>       variables such as READ_ONCE() and rcu_dereference() provide implicit
>       address-dependency barriers.
>  
> +     [!] Note that address dependency barriers can be destroyed by comparison
> +     of a pointer obtained by a marked accessor such as READ_ONCE() or
> +     rcu_dereference() with some value.  For an example of this, see
> +     rcu_dereference.rst (part where the comparison of pointers is discussed).

Hmmm...

Given that this is in a section marked "historical" (for the old
smp_read_barrier_depends() API), why not instead add a pointer to
Documentation/RCU/rcu_dereference.rst to the beginning of the section,
noted as the updated material?

							Thanx, Paul

> +
>   (3) Read (or load) memory barriers.
>  
>       A read barrier is an address-dependency barrier plus a guarantee that all
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
