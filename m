Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0391E7C7640
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442087AbjJLTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:06:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2285D7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:06:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C6BC433C8;
        Thu, 12 Oct 2023 19:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697137594;
        bh=O1aUZWQnphTioOll5YmIeOSyPeoLu6J3fAATaNPXNRw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ppxGPG6OUjNAQmGWO1wX16kLfHkesHRUsUkvZ5iKedy4yDY3kxyNy49p8SU0kRpER
         Fq3TxI5gmOSwzEagQtK5Al4zyD293AFV+lkb7gIX5Tx4W4IET2QxJek4ZJCmrBjM08
         OTdZS2wyEXMkmDgpJJ5DHx+hJIiM1hzzHDyLP3JssEzJmfrUL4Ads8FUlxHxflfcCp
         bvb9xZVmhsCSN1wEjTMV56itb+MN2bRTjU9UFc6BAoDFFtzmeNddtcw0XgAU9ggRnq
         KhYE/VoIvSN93kNPRvZcvpBpWqxWLuQCG88F20FOry22u7BWL4L5AottzMA/Zu0xrc
         1gBdi6/MPT1RQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D9787CE0868; Thu, 12 Oct 2023 12:06:33 -0700 (PDT)
Date:   Thu, 12 Oct 2023 12:06:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <a5f1a910-dbac-44d8-b9f6-5725bea948b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
 <ZSea+etQwlxbi+Ok@1wt.eu>
 <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
 <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
 <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
 <ca67eb2c-3918-4a1f-b3e6-2023fda5d6a3@paulmck-laptop>
 <6b66305f-8172-463e-a50d-324c0c33a6ea@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b66305f-8172-463e-a50d-324c0c33a6ea@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:39:14PM +0200, Thomas Weißschuh wrote:
> On 2023-10-12 11:25:02-0700, Paul E. McKenney wrote:
> > [..]
> 
> > > Please pull the changes since the v6.6-rc1 tag from
> > > https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/
> > > 
> > > The branch 'fixes' up to and including
> > > 90864f0679fdbb3b2e1c3bdbe4b0a34df785cb0a for the v6.6 cycle.
> > > 
> > > The branch 'next' up to and including
> > > f2c7923763dae51226584494722349fef4df3748 for linux-next.
> > > 
> > > The branch 'next', based upon 'fixes', was tested as follows:
> > > 
> > > i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > > x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > > arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > > arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > > mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> > > ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > > ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > > ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > > riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > > s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> > > loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> > 
> > I have a signed tag urgent/nolibc.2023.10.12a in the -rcu tree, so
> > please check the lead-in text for sanity.  (Everything after the digital
> > signature is automatically generated.)
> 
> Looks good. But it's only a listing of the commit subjects, correct?

Pretty close, just a few added words on the last one.

So the question is whether there is some larger issue that Linus should
be made aware of.  If these are just simple fixes for simple bugs,
we should be good, but yes, I do need to ask.  ;-)

> > Testing for urgent/nolibc.2023.10.12a:
> > make run: 160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> > make run-user: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> > 
> > Testing for full nolibc stack:
> > make run: 162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > make run-user: 162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
> > 
> > > > But after about Wednesday of next week, getting things into the upcoming
> > > > merge window is pretty much as fast as sending them quickly to Linus,
> > > > if that makes sense.  Unless there is to be a -rc8 this time, but I
> > > > have heard no sign of that.
> > > > 
> > > > Make sense?
> > > 
> > > Sure, hopefully no more fixes are needed!
> > 
> > Ah, and have these been posted to a public mailing list?  If not, then I
> > need to send them out.
> 
> All patches went through the lists as part of the normal developent
> flow. They were not posted after rebasing.

I have been sending the group, so I might as well continue the tradition.

There are a couple of substantive checkpatch complaints:

4b4a30ea14d1 ("tools/nolibc: i386: Fix a stack misalign bug on _start")
	The Fixes SHA-1 should be limited to 12 hex digits.
	(I am ignoring this, but be prepared for Linus to gripe.
	If you decide to fix it, I would be happy to repull.)

f2c7923763da ("selftests/nolibc: add tests for multi-object linkage")
	nolibc-test-linkage.c and nolibc-test-linkage.h need
	"//" comment for the SPDX comment header.  This one needs
	to be fixed, but this is not in the urgent stack, so there
	is some time.

> For transparency I did the following follow-up changes:
> 
> * The rebase of "tools/nolibc: mark start_c as weak" required some
>   minor changes to resolve conflicts.
> * reword the message of
>   "tools/nolibc: drop test for getauxval(AT_PAGESZ)" slightly.
> * simplify the includes intruduced by
>   "selftests/nolibc: add tests for multi-object linkage".

Sounds good!

							Thanx, Paul

> > We reset the -next testing clock, so if all goes well, then I send the
> > three urgent commits to Linus on Monday.
> 
> Sounds good, thanks!
> 
> Thomas
