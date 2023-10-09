Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB957BE626
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377714AbjJIQSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377656AbjJIQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:18:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914B9F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:18:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558D4C433C7;
        Mon,  9 Oct 2023 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696868328;
        bh=iNj6xbCnWC1iuaTSfQiW+lek/OcvyM13qOi/nB8VC9I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WfEJ9kwF7yUCqwEN4VzTpB18xdYhzXloIwDhkEtt8BNkxVqwqITVlh+s+lnR7bZDu
         PiChl3L7FZh5fu6InHgzY7BGKbr8/De9N4POSjXae62sLTMaPUOYv0SlqW+Nxj2Xtj
         F/dFchrghHjLj/kV4jjK6lFdL4b12mc0F/A5EXY1tGMPjKvdLPWmU7tzY8UraiN1Xa
         sD5D0jtA4i+jnQJ2vNO59mGAGlf8N0k8DZY7kF2RuBIjSzf4hgmr4xGHu6Ro1saOMR
         pckPGlbD6j6TVpYWZpqSOmewBxDQOkf6T8b44/XNoHEjagwFRzsXMzdI29fb2dvMpS
         R8yKMngvzmgog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E3BAFCE09BE; Mon,  9 Oct 2023 09:18:47 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:18:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <e488e6f6-dd62-41b1-9b77-ec1c0a6349b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
 <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
 <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
 <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
 <23bc3841-4cda-4a23-a67f-a944e1104f1d@paulmck-laptop>
 <20231007070630.GB20998@1wt.eu>
 <d80c1da1-56f8-4b94-b1e2-eef75a52d022@paulmck-laptop>
 <fad7814f-0bbd-43f0-a205-9ba2c08bac22@t-8ch.de>
 <76a51116-46bb-4271-b5ac-c101e02d5a63@paulmck-laptop>
 <cfd43fe2-41db-41e1-be43-87755f7b7cce@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfd43fe2-41db-41e1-be43-87755f7b7cce@t-8ch.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 01:25:58PM +0200, Thomas Weißschuh wrote:
> On 2023-10-08 09:27:43-0700, Paul E. McKenney wrote:
> 
> > [..]
> 
> > The other approach involves rebasing the "nolibc/next" stack
> > on top of the "nolibc/fixes" stack.  Please see the -rcu branch
> > nolibc-rebase.2023.10.08a to see how that would look.  Note that the
> > rebase process detected and eliminated the duplicate commits.
> > In this case, I actually used "git cherry-pick":
> > 
> > 	git checkout -b nolibc-rebase.2023.10.08a nolibc/fixes
> > 	git cherry-pick v6.6-rc1..nolibc/next
> > 	git cherry-pick skip # After complaint about first duplicate
> > 	git cherry-pick --continue
> > 	git cherry-pick skip # After complaint about second duplicate
> > 	git cherry-pick --continue
> > 	git diff nolibc-merge.2023.10.08a # Verify no differences
> > 
> > You could just as easily do this:
> > 
> > 	git branch nolibc-rebase.2023.10.08a nolibc/next
> > 	git rebase --onto nolibc/next v6.6-rc1 nolibc-rebase.2023.10.08a
> > 
> > There would be the same complaints about duplicate commits and
> > similar response (it prompts you with your alternatives).
> > 
> > And then I send the fixes portion of the branch to Linus after a few
> > days of exposure to -next testing, and the full branch for the upcoming
> > merge window.
> > 
> > Test results for nolibc-rebase.2023.10.08a:
> > "make run": 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> > "make run-user": 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> > 
> > This approach has its strenghts and weaknesses.
> > 
> > 1.	It avoids all the weaknesses called out for merging.
> > 
> > 2.	It can require more testing when moving yet another commit
> > 	down into urgent-fixes portion of the branch.
> > 
> > 3.	Many people are much less comfortable rebasing and mass
> > 	cherry-picking than they are with merging.
> > 
> > Again, I am happy to do this either way (especially since I now have
> > both ways set up in -rcu), but felt the need to call out the strengths
> > and weaknesses of each approach.  Your guys' choice.
> 
> Your proposed aproach sounds great, thanks for all your patience.
> 
> I implemented it now at
> https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/
> 
> Please pull the changes in this repository since the v6.6-rc1 tag.

Pulled, and thank you!

> The branch 'fixes' up to and including
> 5579b93524ab2d360e2250bdd12ba32635a4300b for the v6.6 cycle.
> 
> The branch 'next' up to and including
> d423dcd4ac21041618ab83455c09440d76dbc099 for linux-next.
> 
> The branch 'next', based upon 'fixes', was tested as follows:
> 
> i386:          160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> x86_64:        160 test(s): 160 passed,   0 skipped,   0 failed => status: success

And the tests pass for me as above for "make run" and with 158 passing
and one skipped for "make run-user".

> arm64:         160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> arm:           160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> mips:          160 test(s): 159 passed,   1 skipped,   0 failed => status: warning
> ppc:           160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> ppc64:         160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> ppc64le:       160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> riscv:         160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> s390:          160 test(s): 159 passed,   1 skipped,   0 failed => status: warning
> loongarch:     160 test(s): 159 passed,   1 skipped,   0 failed => status: warning
> 
> > While in the area, would the following (absolutely not urgent or even
> > particularly important) patch be a good idea?  This gets rid of a line
> > of noise from "git status" after running the tests.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
> > index 52f613cdad54..3487da96e12e 100644
> > --- a/tools/testing/selftests/nolibc/.gitignore
> > +++ b/tools/testing/selftests/nolibc/.gitignore
> > @@ -3,3 +3,4 @@
> >  /nolibc-test
> >  /run.out
> >  /sysroot/
> > +/initramfs.cpio
> 
> Thanks, I folded this into commit
> fdaa5901424c ("selftests/nolibc: don't embed initramfs into kernel image"),
> where it belongs.

And it is doing its job here, thank you!  ;-)

							Thanx, Paul
