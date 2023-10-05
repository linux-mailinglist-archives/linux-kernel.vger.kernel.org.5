Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D511E7BA0F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjJEOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbjJEOoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6550E9F6E0;
        Thu,  5 Oct 2023 07:22:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB13BC32783;
        Thu,  5 Oct 2023 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696502596;
        bh=gWG0kwFgWZxRtQ6Nrksz+XK9wtbC3RLde8erZXYpo2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qpd4sTjfKqtOVaDsmk3zL0WpPOXVMVQG/L+vXgD8TKTh362Xf4Lphctvjt+8SRvxE
         hd43LSt5jnSzVWSKGILRSwNlJ4xAn8VIqJ5vdO9yWkVDr3ZZivVsMfj48s5s0YN/mo
         i5ZgBW8F29H1/UwYp/cNsxyy5SoLlZ+y9fAtz3ln2ofO0uI6bkiVG5Oa7G55MxnIkf
         8KQgCicPdTBBz/VQBxRCBhXRmUZG3mD2tya4pkBu0AWQJX9Lw3tbF9cQ+4AasA/9tA
         Xy6AVWg4RkFSJGMJUEm7lOtVTkWGl7pajLYySd2iTSzYAVqby5QgGMN0atEvYHC2Oy
         Wtv+c9dVX/pGA==
Date:   Thu, 5 Oct 2023 11:43:11 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Starke, Daniel" <daniel.starke@siemens.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com" 
        <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <20231005104311.GG83257@google.com>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <DB9PR10MB588170E923A6ED8B3D6D9613E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <2023100421-negotiate-stammer-1b35@gregkh>
 <20231004085720.GA9374@google.com>
 <2023100448-cotton-safehouse-aca2@gregkh>
 <20231004125704.GA83257@google.com>
 <2023100435-xerox-idiocy-5cf0@gregkh>
 <20231005090311.GD83257@google.com>
 <2023100528-directory-arrogant-2ca9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023100528-directory-arrogant-2ca9@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023, Greg Kroah-Hartman wrote:

> On Thu, Oct 05, 2023 at 10:03:11AM +0100, Lee Jones wrote:
> > On Wed, 04 Oct 2023, Greg Kroah-Hartman wrote:
> > 
> > > On Wed, Oct 04, 2023 at 01:57:04PM +0100, Lee Jones wrote:
> > > > On Wed, 04 Oct 2023, Greg Kroah-Hartman wrote:
> > > > 
> > > > > On Wed, Oct 04, 2023 at 09:57:20AM +0100, Lee Jones wrote:
> > > > > > On Wed, 04 Oct 2023, Greg Kroah-Hartman wrote:
> > > > > > 
> > > > > > > On Wed, Oct 04, 2023 at 05:59:09AM +0000, Starke, Daniel wrote:
> > > > > > > > > Daniel, any thoughts?
> > > > > > > > 
> > > > > > > > Our application of this protocol is only with specific modems to enable
> > > > > > > > circuit switched operation (handling calls, selecting/querying networks,
> > > > > > > > etc.) while doing packet switched communication (i.e. IP traffic over PPP).
> > > > > > > > The protocol was developed for such use cases.
> > > > > > > > 
> > > > > > > > Regarding the issue itself:
> > > > > > > > There was already an attempt to fix all this by switching from spinlocks to
> > > > > > > > mutexes resulting in ~20% performance loss. However, the patch was reverted
> > > > > > > > as it did not handle the T1 timer leading into sleep during atomic within
> > > > > > > > gsm_dlci_t1() on every mutex lock there.
> > > > > > 
> > > > > > That's correct.  When I initially saw this report, my initial thought
> > > > > > was to replace the spinlocks with mutexts, but having read the previous
> > > > > > accepted attempt and it's subsequent reversion I started to think of
> > > > > > other ways to solve this issue.  This solution, unlike the last, does
> > > > > > not involve adding sleep inducing locks into atomic contexts, nor
> > > > > > should it negatively affect performance.
> > > > > > 
> > > > > > > > There was also a suggestion to fix this in do_con_write() as
> > > > > > > > tty_operations::write() appears to be documented as "not allowed to sleep".
> > > > > > > > The patch for this was rejected. It did not fix the issue within n_gsm.
> > > > > > > > 
> > > > > > > > Link: https://lore.kernel.org/all/20221203215518.8150-1-pchelkin@ispras.ru/
> > > > > > > > Link: https://lore.kernel.org/all/20221212023530.2498025-1-zengheng4@huawei.com/
> > > > > > > > Link: https://lore.kernel.org/all/5a994a13-d1f2-87a8-09e4-a877e65ed166@kernel.org/
> > > > > > > 
> > > > > > > Ok, I thought I remembered this, I'll just drop this patch from my
> > > > > > > review queue and wait for a better solution if it ever comes up as this
> > > > > > > isn't a real issue that people are seeing on actual systems, but just a
> > > > > > > syzbot report.
> > > > > > 
> > > > > > What does the "better solution" look like?
> > > > > 
> > > > > One that actually fixes the root problem here (i.e. does not break the
> > > > > recursion loop, or cause a performance decrease for normal users, or
> > > > > prevent this from being bound to the console).
> > > > 
> > > > Does this solution break the recursion loop or affect performance?
> > > 
> > > This solution broke the recursion by returning an error, right?
> > 
> > This is the part I was least sure about.
> > 
> > If this was considered valid and we were to go forward with a solution
> > like this, what would a quality improvement look like?  Should we have
> > stayed in this function and waited for the previous occupant to leave
> > before continuing through ->write()?
> 
> This isn't valid, as it obviously never shows up in real use.
> 
> The real solution should be to prevent binding a console to this line
> discipline as it can not handle the recursion that consoles require for
> the write path.

Would something like this tick that box?

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1f3aba607cd51..5c1d2fcd5d9e2 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3716,6 +3716,10 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
        if (!gsm)
                return -ENODEV;
 
+       /* The GSM line discipline does not support binding to console */
+       if (strncmp(tty->name, "tty", 3))
+               return -EINVAL;
+
        ret = -ENOBUFS;
        spin_lock_irqsave(&gsm->tx_lock, flags);
        space = tty_write_room(tty);

> Then, if consoles are really needed, the code can be fixed up to handle
> such recursion.  That's not a trivial thing to do, as can be seen by the
 > crazy gyrations that the n_tty line discipline does in its write path...

-- 
Lee Jones [李琼斯]
