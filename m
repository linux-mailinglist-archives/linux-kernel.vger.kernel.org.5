Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98435797D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbjIGULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIGULX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:11:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBAEE47
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 13:11:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500b0f06136so2318302e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694117478; x=1694722278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEHxSDa9suqIfWb1cKERrinpzjakMUw8unQ7h6nJqSc=;
        b=KcyGO8UDHPBTqkTpB7rbYnQU4oHg05FzIqvnAxFi90K5CWx6GQ/pH6Lp5ajpSkpRzQ
         Sx5bh3eUTimnIj4eNOX15dWLrkLdLS0XSXLIskDkIM9gy+qggnWfR8Hem5qFzRdVxZeE
         vmIYLYzO55kTEyL4aC305tLPXSvHNgu2EjEX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694117478; x=1694722278;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEHxSDa9suqIfWb1cKERrinpzjakMUw8unQ7h6nJqSc=;
        b=mzBByAssbwKWZoBmfysRcQJUwMZsMxSfnIWLtlerO/ooHzwXuiNiRZMXgfVSBcweLD
         NIzYQWjSZDwKDNqXV9lcMRQCwVog7hSVETENU9mxJc3ElAeDUN+qU5o2hHG2kdtzmP4P
         kCTrUCu4v915Z44yz7RS94i/olViL+NPAeifMAKngSBOjsGIaTre+042CshTrnee2/vT
         L5XIGZptx/slGmxy4zvXFFmQixOuKHiMsve1kbPOTEcFyErfAvWhxr0fNhNnM51n0kBF
         Y0MtYASXG+MYDeOsIXYBGde4Q4+a5vCVL0Z04SuLmsXiTaH6hrObCPOOSMBVr5qULdIe
         8YTg==
X-Gm-Message-State: AOJu0YxfGjZAw/l7YpGxUm5W7hAu1Hn1L6tMfz3EmGnUGOjFBRl/L5fR
        AMR4Fjc39dxEDy0Dxm7HsW6EFRW62RgDgoe/eiNXKvapku4Q06r7
X-Google-Smtp-Source: AGHT+IGR5cMoVWwXVyWrK1LKM17/LRlIOSjJUog6feEzya5HRB58qZr2MIyqwOsYVySx4563NE0zbrLUR3k/No5bLKY=
X-Received: by 2002:a05:6512:3a87:b0:4fb:9712:a717 with SMTP id
 q7-20020a0565123a8700b004fb9712a717mr458584lfu.13.1694117477859; Thu, 07 Sep
 2023 13:11:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Sep 2023 13:11:17 -0700
MIME-Version: 1.0
In-Reply-To: <20230907053513.GH1599918@black.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org> <20230906180944.2197111-2-swboyd@chromium.org>
 <20230907053513.GH1599918@black.fi.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 7 Sep 2023 13:11:17 -0700
Message-ID: <CAE-0n51Ut296M2ZetuzXGpX32pS11bbWzfcbaFfqNxgSjzafJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mika Westerberg (2023-09-06 22:35:13)
> On Wed, Sep 06, 2023 at 11:09:41AM -0700, Stephen Boyd wrote:
> > It's possible for the polling loop in busy_loop() to get scheduled away
> > for a long time.
> >
> >   status = ipc_read_status(scu); // status = IPC_STATUS_BUSY
> >   <long time scheduled away>
> >   if (!(status & IPC_STATUS_BUSY))
> >
> > If this happens, then the status bit could change while the task is
> > scheduled away and this function would never read the status again after
> > timing out. Instead, the function will return -ETIMEDOUT when it's
> > possible that scheduling didn't work out and the status bit was cleared.
> > Bit polling code should always check the bit being polled one more time
> > after the timeout in case this happens.
> >
> > Fix this by reading the status once more after the while loop breaks.
> >
> > Cc: Prashant Malani <pmalani@chromium.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Fixes: e7b7ab3847c9 ("platform/x86: intel_scu_ipc: Sleeping is fine when polling")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > This is sufficiently busy so I didn't add any tags from previous round.
> >
> >  drivers/platform/x86/intel_scu_ipc.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> > index 6851d10d6582..b2a2de22b8ff 100644
> > --- a/drivers/platform/x86/intel_scu_ipc.c
> > +++ b/drivers/platform/x86/intel_scu_ipc.c
> > @@ -232,18 +232,21 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
> >  static inline int busy_loop(struct intel_scu_ipc_dev *scu)
> >  {
> >       unsigned long end = jiffies + IPC_TIMEOUT;
> > +     u32 status;
> >
> >       do {
> > -             u32 status;
> > -
> >               status = ipc_read_status(scu);
> >               if (!(status & IPC_STATUS_BUSY))
> > -                     return (status & IPC_STATUS_ERR) ? -EIO : 0;
> > +                     goto not_busy;
> >
> >               usleep_range(50, 100);
> >       } while (time_before(jiffies, end));
> >
> > -     return -ETIMEDOUT;
> > +     status = ipc_read_status(scu);
>
> Does the issue happen again if we get scheduled away here for a long
> time? ;-)

Given the smiley I'll assume you're making a joke. But to clarify, the
issue can't happen again because we've already waited at least
IPC_TIMEOUT jiffies, maybe quite a bit more, so if we get scheduled away
again it's a non-issue. If the status is still busy here then it's a
timeout guaranteed.

>
> Regardless, I'm fine with this as is but if you make any changes, I
> would prefer see readl_busy_timeout() used here instead (as was in the
> previous version).

We can't use readl_busy_timeout() (you mean readl_poll_timeout() right?)
because that implements the timeout with timekeeping and we don't know
if this is called from suspend paths after timekeeping is suspended or
from early boot paths where timekeeping isn't started.

We could use readl_poll_timeout_atomic() and then the usleep would be
changed to udelay. Not sure that is acceptable though to delay 50
microseconds vs. intentionally schedule away like the usleep call is
doing.
