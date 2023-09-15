Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8B7A2A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbjIOWK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbjIOWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:10:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B88B7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:10:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D109C433C8;
        Fri, 15 Sep 2023 22:10:46 +0000 (UTC)
Date:   Fri, 15 Sep 2023 18:11:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
Message-ID: <20230915181110.1cbf1ff0@gandalf.local.home>
In-Reply-To: <20230915180118.4bd1cb5f@gandalf.local.home>
References: <20230913192905.0a92bcab@gandalf.local.home>
        <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
        <20230915163637.77c673a6@gandalf.local.home>
        <CAHk-=whNU3JaPMq_E7mwVGpTKxxeQxV=13o84u-tTeqfB_t05g@mail.gmail.com>
        <20230915171334.5c231ca7@gandalf.local.home>
        <CAHk-=whbDQb5VzJbn6qQswxfbcp67uzfwpJ+R1DxHk0dHdg4pQ@mail.gmail.com>
        <CAHk-=wiheWEbUfQy1JY_BQ6mJukOLa6hEdEzN1N_hgz1nxY9hQ@mail.gmail.com>
        <20230915180118.4bd1cb5f@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 18:01:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > To me, if that's really a major issue, that just says "ok, this
> > eventfs abstraction was mis-designed, and hid data that the main
> > developer actually wants".

Just to clarify the objective of the show_event_dentries file was the
heisenberg effect.

Just doing a 'ls' in the eventfs will create the dentries.

I'm interested in knowing that the dentries do not exist before the 'ls',
so I look at that file to make sure they are not there.

Then I do an 'ls' where I see all the files.

I then look at the file again to make sure the ref counts are correct.

I then run a memory pressure test, and look at the file to make sure that
the dentries are all cleaned up.

For kicks I'll do another 'ls' and see all the files again.

You may be correct that once I did the above, the code could be considered
working. My fear is that something might change in vfs that causes it to
break, and this file could be useful in catching that.

But if it never breaks, then the file becomes useless, which I guess is
what you are saying.

I'll keep the code around locally, and if vfs ever changes and breaks this
code where this file helps in solving it, I'll then do another pull request
to put this file upstream ;-)

-- Steve
