Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3078B98C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjH1U1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjH1U07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:26:59 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF4A8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:26:57 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RZMXv6rpHzB9;
        Mon, 28 Aug 2023 22:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693254416; bh=uHHF3nZhiVLDjoHVhsmpzg+C/ZezK9ES/3zOBvv6Ljc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqvRf9Qh9iG+pJUK5O4J7+iTBB/6T54G428X7Atf39IOIsxNprxpLGBoBTDUtZEu8
         tGFLNb95IJRQ9POO3yPOnqh8VfG2Xq1+5OLZ9lQK0a9Je7hXfsVJfBWjitmXWgzZJI
         jqHntPDacY7xHrASCCettdbiH6Be5hZNG2MZPMkKLAKlN+NpRWPFxPg7Azxh/geXij
         3YLhgg9sohkTx5MWuETVkHE1bHIjhmeTkA2U4tjHH/oKpnUGads7jRAh2blZQ0PaLK
         8Tu9K25DbOEUm0yPAvNRKDxwklm+Xwga5tDmhEST7yjQ3ayxOrFTkSAmThQ+QQPCJ/
         SV+j2BAI2HQ9A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Mon, 28 Aug 2023 22:26:54 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 6/6] regulator: core: simplify lock_two()
Message-ID: <ZO0DDkNUZ4FwYTrz@qmqm.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
 <682e260d8cb75c34f79ff7fcc3c4bb8586140cc4.1692484240.git.mirq-linux@rere.qmqm.pl>
 <CAD=FV=XbfBf9y1sdt9T=81cTCRcRUbVqo3oKrHvBQZC+hHQpCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XbfBf9y1sdt9T=81cTCRcRUbVqo3oKrHvBQZC+hHQpCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:51:08AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sat, Aug 19, 2023 at 3:46 PM Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> >
> > Make regulator_lock_two() shorter by observing that we have only two
> > locks and when swapped earlier the retry code becomes identical to the
> > normal (optimistic) path.
> >
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/regulator/core.c | 28 ++++++++++------------------
> >  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> This is quite nearly a direct revert of commit 37473397b852
> ("regulator: core: Make regulator_lock_two() logic easier to follow"),
> which was requested by Stephen in:
> 
> https://lore.kernel.org/r/CAE-0n53Eb1BeDPmjBycXUaQAF4ppiAM6UDWje_jiB9GAmR8MMw@mail.gmail.com
> 
> I don't personally have a strong opinion, but do prefer not to flip-flop. ;-)

Indeed they are quite similar. I did remove a bit more code than that,
though: in this case there is no early success return before the loop.

Instead of saying:

lock A
lock B
if ok return
if that failed, loop:
  unlock A
  lock B harder
  lock A
  if ok return
  swap A <-> B
  lock B

Now it's:

lock A
loop forever:
  lock B
  if ok, return
  unlock A
  swap them
  lock A harder

With the same condition 'A held' at the start of an iteration.

Best Regards
Michał Mirosław
