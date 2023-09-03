Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27D0790AC2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 06:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjICEQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 00:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjICEQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 00:16:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52144CC5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 21:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6CCD8CE0016
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 04:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C203C433C7;
        Sun,  3 Sep 2023 04:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693714582;
        bh=aO/IZv/wzze58mz67mh6aQy8ypsLG444r1X5H79j5w8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b+OL+bmnm53sm0ZLHqPyevHEkEq6acrHWb+gS8wDFxm8y3JWMnKSQ+1XTOGOA9KEx
         vDq4F7U3gQif76j0bVl/MBe9DuvIzHwr1/sRlEN8aRyOGk8f7s/Xqb89darJGaJIlx
         VRkTcPB4RGiC3I2da+Dwl+5/ObdYBB4fPyhg/BO3tbWoPzCRZehaBGUPKMHoDbFiXq
         f2eWKkBMOyJG2ydRs5LWjkPwQ5rGPnN0KXGqTDxhsFTqE1GRqwFIx0kdsITWJ7PNw7
         DHeH59Itz6bMWIrBplu+q98fzDmQ8lHlpkHq9sOLNn+XfQp+IfWzwqABdMT1snciv5
         s+uwOWP/QuItA==
Date:   Sun, 3 Sep 2023 13:16:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [GIT PULL] bootconfig: Updates for 6.6
Message-Id: <20230903131619.8b17a76a6f733c1361e102c5@kernel.org>
In-Reply-To: <CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com>
References: <20230902101046.bfe957bc51ecd91781200708@kernel.org>
        <CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for the comment.
Let us reconsider how it should be handled.

On Sat, 2 Sep 2023 11:35:00 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 1 Sept 2023 at 18:10, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> >  - fs/proc: Add /proc/raw_cmdline for boot loader arguments.
> 
> Honestly, I pulled this, and then I unpulled again.
> 
> This seems such a *silly* thing. It's also actively confusing, since
> this "raw" file internally in the kernel is called
> "boot_command_line", vs the "saved_command_line" of the regular one,
> and we also have 'extra_command_line' and 'static_command_line' etc,
> so where does this all end?
>
> So the name doesn't even make any sense. It's not "raw" in any sense
> of the word. It just happens to be the one that came from the boot
> side.

OK.

> 
> In other words, this smells like a complete hack to me. It makes no
> sense, and it should *not* be added to the top-level /proc filesystem
> as some kind of fundamental file.

Got it.

> 
> And not only is it a special case that isn't worthy of adding to the
> top-level /proc directory, it only has _one_ special case user that
> could possibly care.

Indeed. For the most users, /proc/raw_cmdline will be the same as
/proc/cmdline.

> 
> And this is all self-inflicted pain because the bootconfig code
> corrupted the original command line, and decided to expose that
> corrupted thing in /proc/cmdline.
> 
> So because you made a mess of it originally, you're now making a
> *bigger* mess of this all.
> 
> No, thank you. The way to fix a mess is not to make it worse. And this
> just makes things worse.

OK.

> 
> I suspect the fix should always have been to make the extra stuff be
> somehow clear so that you can parse it. Not make another file that has
> the exact same contents for most people.
> 
> Maybe a marker of "this is the end of the 'extra command line", the
> same way we have that "--" for "this is the end of the stuff the
> kernel should parse".

Yeah, I thought that, but it seems that any marker may introduce
another problem.

If the user need to know the bootloader command line string when the
bootconfig is enabled, what about adding a special line to the
/proc/bootconfig, e.g.

bootloader.parameters = "<params from bootloader>"

In this case, it will be only shown when the bootconfig is enabled, and
normal /proc/cmdline user does not need to care about that. Of course
bootconfig can drop "bootloader" items.


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
