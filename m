Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47307A2A31
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjIOWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjIOWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:00:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DF0118
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:00:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16B3C433C7;
        Fri, 15 Sep 2023 22:00:53 +0000 (UTC)
Date:   Fri, 15 Sep 2023 18:01:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
Message-ID: <20230915180118.4bd1cb5f@gandalf.local.home>
In-Reply-To: <CAHk-=wiheWEbUfQy1JY_BQ6mJukOLa6hEdEzN1N_hgz1nxY9hQ@mail.gmail.com>
References: <20230913192905.0a92bcab@gandalf.local.home>
        <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
        <20230915163637.77c673a6@gandalf.local.home>
        <CAHk-=whNU3JaPMq_E7mwVGpTKxxeQxV=13o84u-tTeqfB_t05g@mail.gmail.com>
        <20230915171334.5c231ca7@gandalf.local.home>
        <CAHk-=whbDQb5VzJbn6qQswxfbcp67uzfwpJ+R1DxHk0dHdg4pQ@mail.gmail.com>
        <CAHk-=wiheWEbUfQy1JY_BQ6mJukOLa6hEdEzN1N_hgz1nxY9hQ@mail.gmail.com>
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

On Fri, 15 Sep 2023 14:35:40 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 15 Sept 2023 at 14:30, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And if you really think that people need to know what the events exist
> > in eventfs, then dammit, make 'readdir()' see them. Not some stupid
> > specialty debug interface. That's what filesystems *have* readdir for.  
> 
> .. alternatively, if you have noticed that it's just a pain to not be
> able to see the data, instead of introducing this completely separate
> and illogical debug interface, just say "ok, it was a mistake, let's
> go back to just keeping things in dentries since we can _see_ those".
> 
> Put another way: this is all self-inflicted damage, and you seem to
> argue for this debug interface purely on "I can't see what's going on
> any more, the old model was really nice because you could *see* the
> events".

The entire tracing infrastructure was created because of the "I can't see
what's going on" ;-)  Not everyone is as skilled with printk as you.

The old eventfs model was too costly because of the memory footprint, which
was the entire objective of this code patch. The BPF folks told me they
looked into use a tracing instance but said it added too much memory
overhead to do so. That's when I noticed that the copy of the entire events
directory that an instance has was the culprit, and needed to be fixed.

> 
> To me, if that's really a major issue, that just says "ok, this
> eventfs abstraction was mis-designed, and hid data that the main
> developer actually wants".
> 
> We don't add new debug interfaces just because you screwed up the
> design. Fix it.

This interface is used to make sure that things are being freed, and the
overhead is low. The bugs it found was where ref counts were screwed up,
and things were permanently there or just leaked in general.

Not sure what design you want fixed.

But I get your point. I will agree that this interface will likely be
mostly useful for the first year or two after the new code is added. But
after a few years, we could delete it too. If it's a debug option I highly
doubt that any distro will keep it on and anything will actually depend on
it.

I'm not going to fight for it. I can just keep this code in patchwork that
could be easily available, or even in a git branch on my own tree.

Consider this pull request dropped.

-- Steve
