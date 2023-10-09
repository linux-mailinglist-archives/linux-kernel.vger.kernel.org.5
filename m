Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D197BD3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345299AbjJIGyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjJIGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:54:15 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66AAFA3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:54:13 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3996rwwm018836;
        Mon, 9 Oct 2023 08:53:58 +0200
Date:   Mon, 9 Oct 2023 08:53:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <ZSOjhgIbK8bs3Asu@1wt.eu>
References: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
 <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
 <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
 <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
 <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
 <23bc3841-4cda-4a23-a67f-a944e1104f1d@paulmck-laptop>
 <20231007070630.GB20998@1wt.eu>
 <d80c1da1-56f8-4b94-b1e2-eef75a52d022@paulmck-laptop>
 <fad7814f-0bbd-43f0-a205-9ba2c08bac22@t-8ch.de>
 <76a51116-46bb-4271-b5ac-c101e02d5a63@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a51116-46bb-4271-b5ac-c101e02d5a63@paulmck-laptop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sun, Oct 08, 2023 at 09:27:43AM -0700, Paul E. McKenney wrote:
(...)
> The other approach involves rebasing the "nolibc/next" stack
> on top of the "nolibc/fixes" stack.

That was my initial expectation as well, it's much easier, preserves
the patches ordering so it guarantees that all fixes are always present
in -next and that there won't be conflicts when they're finally submitted.

> And then I send the fixes portion of the branch to Linus after a few
> days of exposure to -next testing, and the full branch for the upcoming
> merge window.

Indeed, it also allows to test both together and can reduce the cost of
testing (unless we really want to test something specific to the fixes
branch once in a while).

> Test results for nolibc-rebase.2023.10.08a:
> "make run": 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> "make run-user": 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> 
> This approach has its strenghts and weaknesses.
> 
> 1.	It avoids all the weaknesses called out for merging.
> 
> 2.	It can require more testing when moving yet another commit
> 	down into urgent-fixes portion of the branch.
> 
> 3.	Many people are much less comfortable rebasing and mass
> 	cherry-picking than they are with merging.

I tend to think that anything called "-next" should mostly be expected
to change over time and support rebases. One good reason for this is to
remerge fixes for recently added changes so as not to needlessly leave
bogus commits in the history, since that tends to break bisect.

> While in the area, would the following (absolutely not urgent or even
> particularly important) patch be a good idea?  This gets rid of a line
> of noise from "git status" after running the tests.

Good idea, feel free to propose a patch ;-)

Thanks!
Willy
