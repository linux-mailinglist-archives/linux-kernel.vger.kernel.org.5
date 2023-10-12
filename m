Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B87C75CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjJLSZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379676AbjJLSZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:25:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4019C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:25:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B088C433C8;
        Thu, 12 Oct 2023 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697135102;
        bh=zgR+pS03VvFmqe0w7hJ5NS/7f3+7ZheUXgpeE+u0RQY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QEk9z4C5PC3A2OI6ZZ8L2XnUP2aFran46glqKH8ggIhfA0YyNKgqTX4FXP7LYdI1K
         zEfLn348EuJdGLv1q/RY2b9HCkgGpuBgpp/FB8p3uHGbgvxsrNb/mh05GNk4tm+HjQ
         feUFivTj0NoYb8Vzaj8CBZb4WQC6byw9ny4qLz8k/M+K8Qvl+n1XbHIkBLJR9eUINx
         nwMPMaZ6gkYQ+ReQOdT0BqwUzDZ0Rjb7zzEYDfNxji+1x1O3bqGsfDNGHQYRdiF2Br
         9ELhcgZQYG4RqgGoVN/NOcnoM0lwVSWkA1asFCO7mnT3mUlFso40RBBOSYMw4MU3cl
         5d4xTj3oPdSkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 29132CE0593; Thu, 12 Oct 2023 11:25:02 -0700 (PDT)
Date:   Thu, 12 Oct 2023 11:25:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <ca67eb2c-3918-4a1f-b3e6-2023fda5d6a3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
 <ZSea+etQwlxbi+Ok@1wt.eu>
 <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
 <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
 <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:51:28PM +0200, Thomas Weiﬂschuh wrote:
> On 2023-10-12 03:41:50-0700, Paul E. McKenney wrote:
> > On Thu, Oct 12, 2023 at 09:23:29AM +0200, Thomas Weiﬂschuh wrote:
> > > Hi Willy, Paul,
> > > 
> > > On 2023-10-12 09:06:33+0200, Willy Tarreau wrote:
> > > > On Thu, Oct 12, 2023 at 01:13:37AM +0200, Thomas Weiﬂschuh wrote:
> > > > > While uncommon, nolibc executables can be linked together from multiple
> > > > > compilation units.
> > > > > Add some tests to make sure everything works in that case.
> > > > (...)
> > > 
> > > [..]
> > > 
> > > > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > > > ---
> > > > > Note:
> > > > > 
> > > > > This depends on path "tools/nolibc: mark start_c as weak".
> > > > > https://lore.kernel.org/lkml/20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net/
> > > > 
> > > > For these two patches: Acked-by: Willy Tarreau <w@1wt.eu>
> > > 
> > > Thanks, applied locally.
> > > 
> > > I guess the linked patch "tools/nolibc: mark start_c as weak" should
> > > also go into nolibc/fixes.
> > > 
> > > @Paul, would it introduce too much churn for you if I submit another
> > > nolibc pull with an updated nolibc/fixes?
> > > (And the rebased nolibc/next with this commit while we are at it)
> > 
> > Not a problem this week!
> 
> Great, then:
> 
> Please pull the changes since the v6.6-rc1 tag from
> https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/
> 
> The branch 'fixes' up to and including
> 90864f0679fdbb3b2e1c3bdbe4b0a34df785cb0a for the v6.6 cycle.
> 
> The branch 'next' up to and including
> f2c7923763dae51226584494722349fef4df3748 for linux-next.
> 
> The branch 'next', based upon 'fixes', was tested as follows:
> 
> i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning

I have a signed tag urgent/nolibc.2023.10.12a in the -rcu tree, so
please check the lead-in text for sanity.  (Everything after the digital
signature is automatically generated.)

Testing for urgent/nolibc.2023.10.12a:
make run: 160 test(s): 160 passed,   0 skipped,   0 failed => status: success
make run-user: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning

Testing for full nolibc stack:
make run: 162 test(s): 162 passed,   0 skipped,   0 failed => status: success
make run-user: 162 test(s): 160 passed,   2 skipped,   0 failed => status: warning

> > But after about Wednesday of next week, getting things into the upcoming
> > merge window is pretty much as fast as sending them quickly to Linus,
> > if that makes sense.  Unless there is to be a -rc8 this time, but I
> > have heard no sign of that.
> > 
> > Make sense?
> 
> Sure, hopefully no more fixes are needed!

Ah, and have these been posted to a public mailing list?  If not, then I
need to send them out.

We reset the -next testing clock, so if all goes well, then I send the
three urgent commits to Linus on Monday.

							Thanx, Paul
