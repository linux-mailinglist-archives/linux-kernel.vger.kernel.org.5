Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA87BABB4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjJEU6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjJEU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:58:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB7293
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:58:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED202C433C8;
        Thu,  5 Oct 2023 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696539488;
        bh=3b9ePAV/GGXEOSrD+P3Oy9gAEO1GIL3if6yfbYOJVsE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BFshO7R/0dTAq0jpajSzkSnLUZ0ig50IxCsZ+/xwqMXbY/x9y3oHvrQIcEcljsaHz
         ZeIuDAyNUmxKTHLJCmfLu7maRxkCM8Og2/Xe/CrD6cAdFfRHkWwUnwP2eJQQk5tLOW
         N7fczG/lgbQ4FNOG1X2XVHi73ld9inKpiP/2lT+GuB0QdL2oyoUWPlNpjJhctJQdov
         +51omX+HFf4s4KYT0IB4C+LZ4aQJJVTebfMSkC+lY/89YB+SB1uw91GFyq6h73YnS7
         nZQxjGU2XS6IxJRLkVxLTdqEvHMGVTtAl2V+Y378Va/4a6raRZjI9ZsXFGl558zmYV
         UAeavK+0eF/rQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 845EDCE090A; Thu,  5 Oct 2023 13:58:07 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:58:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
 <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
 <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 10:28:05PM +0200, Thomas Weißschuh wrote:
> On 2023-10-05 14:15:31-0600, Shuah Khan wrote:
> > Hi Thomas,
> > 
> > On 10/5/23 11:00, Thomas Weißschuh wrote:
> > > Hi Shuah,
> > > 
> > > I'd like to test the current state of nolibc in linux-next.
> > > Could pull the request below into your nolibc branch?
> > > 
> > > I'll do some manual tests this weekend, too.
> > > 
> > > 
> > > Thanks,
> > > Thomas
> > > 
> > > 
> > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > > 
> > >    Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc/next
> > > 
> > > for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> > > 
> > >    tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> > 
> > Absolutely. Do you mind tagging and pushing the tag and send
> > pull request with the tag?
> 
> Sure, here it is:
> 
> 
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> 
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-next.2023.10.05a
> 
> for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> 
>   tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)

Looks good on my laptop:

make run:

	160 test(s): 160 passed,   0 skipped,   0 failed => status: success

make run-user:

	160 test(s): 158 passed,   2 skipped,   0 failed => status: warning

Shuah, I can take nolibc for the upcoming merge window (I believe that
it is my turn to do so), but if you would prefer to take them, that also
works for me.  Either way, just let me know.

							Thanx, Paul
