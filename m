Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DDE78DA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjH3Sgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbjH3RZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:25:29 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4AC193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:25:25 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWQW6nNhz9y;
        Wed, 30 Aug 2023 19:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416324; bh=MEerX7Xkc8Om9zH0WOoYOT1fiLzqssZpxTRphvNx33g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDV7DUvoBLwm1TjE8Pd3qbFd4bJC9TQgyWyEfCQF+IoMPSXPMOj1sOE4xH+CpwguT
         OgDyx7WNNcJwRzY645h9PHhnRX9e3Wx5n7f4VqtWI5zqN1qe5AINDzidL27mXq5NxC
         fWuUjgzBXdwvuxLBwbe+65mX8KoNdRpDnMFad7VSsJLlN/wC6HhNCNmCDaPPTl6n2v
         s1LsxVbu6FjNSINFWUswfmXJZo+hQmZ6lxCQZVLWpE2VqzxCFhKx4UtQvQ8bFwEt64
         m1uDXouYbmbkl72vX5Lfoj2zXXZAgQTj8sy+oMsqJtdnnT1Mb/rJGAF4LsIs+UapFB
         QlUcQW+fP0kfw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:25:22 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 6/6] regulator: core: simplify lock_two()
Message-ID: <ZO97gl1knsW8n99a@qmqm.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
 <682e260d8cb75c34f79ff7fcc3c4bb8586140cc4.1692484240.git.mirq-linux@rere.qmqm.pl>
 <CAD=FV=XbfBf9y1sdt9T=81cTCRcRUbVqo3oKrHvBQZC+hHQpCQ@mail.gmail.com>
 <ZO0DDkNUZ4FwYTrz@qmqm.qmqm.pl>
 <CAE-0n51gcN+3Ng7+bz21eS_6JomnVDzZMuWyzZVB25paj29j4g@mail.gmail.com>
 <ZO5iWlczXmX7wNn9@qmqm.qmqm.pl>
 <CAE-0n531mK2Lvt7saXySPZLbGsA1giB3at0WDadErYOhcUv6ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-0n531mK2Lvt7saXySPZLbGsA1giB3at0WDadErYOhcUv6ew@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 05:57:31PM -0500, Stephen Boyd wrote:
> Quoting Micha³ Miros³aw (2023-08-29 14:25:46)
> > On Tue, Aug 29, 2023 at 03:52:19PM -0500, Stephen Boyd wrote:
> > > Quoting Micha³ Miros³aw (2023-08-28 13:26:54)
> > > > Indeed they are quite similar. I did remove a bit more code than that,
> > > > though: in this case there is no early success return before the loop.
> > > >
> > > > Instead of saying:
> > > >
> > > > lock A
> > > > lock B
> > > > if ok return
> > > > if that failed, loop:
> > > >   unlock A
> > > >   lock B harder
> > > >   lock A
> > > >   if ok return
> > > >   swap A <-> B
> > > >   lock B
> > > >
> > > > Now it's:
> > > >
> > > > lock A
> > > > loop forever:
> > > >   lock B
> > > >   if ok, return
> > > >   unlock A
> > > >   swap them
> > > >   lock A harder
> > > >
> > > > With the same condition 'A held' at the start of an iteration.
> > > >
> > >
> > > Removing duplicate code is great! I'm primarily concerned with
> > > readability. The terms 'A' and 'B' doesn't make it easy for me. Can you
> > > maintain the 'held' and 'contended' names for the variables?
> > >
> > > That would be
> > >
> > > 1.  lock 'held'
> > > 2.  loop forever:
> > > 3.    lock 'contended'
> > > 4.    if ok, return
> > > 5.    unlock 'held'
> > > 6.    swap them
> > > 7.    lock 'held' harder
> >
> > Doesn't this make it more confusing? The lock is 'held' only in lines
> > 2-5 and looses this trait (but not the name) on the other lines.
> > 'contended' is more problematic: the contended lock is called 'held'
> > before locking it at line 7.
> >
> > The algorithm is basically: Take the locks in sequence. If that failed,
> > swap the order and try again.
> >
> > Would a comment like the sentence above help with readability?
> >
> > Or we could wrap the final lines of the iteration in a
> > 'regulator_lock_contended()' to make it self-documenting?
> >
> 
> Squash this in?

I see that you prefer the held/contended intermediary names. I'd like to
understand why we differ in the perception of readability of this part
of code so that the change is needed? The algorithm is simple enough,
and it would work even if the locks weren't swapped for each iteration
(even if slower to finish). What is missing in the context of the
function's code? Are there some assumptions not easily visible?

BTW, I went on to add the regulator_lock_contended() to see how it
would look. I'll send a v2 with it so we can apply your proposal if
needed on top.

Best Regards,
Micha³ Miros³aw
