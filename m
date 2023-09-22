Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5190F7AAAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjIVHr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIVHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:47:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C04180;
        Fri, 22 Sep 2023 00:47:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8546021954;
        Fri, 22 Sep 2023 07:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695368865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCHJWLXY/1YrhTqt01qtJc1B4rW5IBdeEn9ZMU0RfFM=;
        b=S1J6FzTlABeg7deK/pGJfYJx9Ymmo3k9fUPr9VivC/k8RORz8OkEYiQpTHfo1jZwG2HKKf
        7jAKPBYWtI6PUFnXvZNahHP7l/8ahMCv4YnhlGT3U3PGkbJ1zPfwEGH/dEjK4rTuLRu3Vc
        2F6VxtnpW05sqoRVxUXElGF6pnBjbes=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A7E482C142;
        Fri, 22 Sep 2023 07:47:44 +0000 (UTC)
Date:   Fri, 22 Sep 2023 09:47:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Enlin Mu <enlinmu@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Enlin Mu <enlin.mu@outlook.com>, rostedt@goodmis.org,
        senozhatsky@chromium.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, enlin.mu@unisoc.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: add cpu id information to printk() output
Message-ID: <ZQ1GoF4LjwRM2Ec3@alley>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
 <8734zfx2bo.fsf@jogness.linutronix.de>
 <CAAfh-jOnirbUjUYDhWqqUe8kPL=1FcDdZoSax5R-nGwO1CO60g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfh-jOnirbUjUYDhWqqUe8kPL=1FcDdZoSax5R-nGwO1CO60g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-22 15:34:44, Enlin Mu wrote:
> John Ogness <john.ogness@linutronix.de> 于2023年9月15日周五 16:34写道：
> >
> > On 2023-09-15, Enlin Mu <enlin.mu@outlook.com> wrote:
> > > Sometimes we want to print cpu id of printk() messages to consoles
> > >
> > > diff --git a/include/linux/threads.h b/include/linux/threads.h
> > > index c34173e6c5f1..6700bd9a174f 100644
> > > --- a/include/linux/threads.h
> > > +++ b/include/linux/threads.h
> > > @@ -34,6 +34,9 @@
> > >  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> > >       (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> > >
> > > +#define CPU_ID_SHIFT 23
> > > +#define CPU_ID_MASK  0xff800000
> >
> > This only supports 256 CPUs. I think it doesn't make sense to try to
> > squish CPU and Task IDs into 32 bits.
> >
> > What about introducing a caller_id option to always only print the CPU
> > ID? Or do you really need Task _and_ CPU?
>
> Yes, I need it.
> For SOC manufacturer, sometimes cpu is not stable, we need some debug
> tools for this exceptions.
> When an exception occurs, we may not be able to detect it in a timely
> manner, but through Task _and_ CPU, we can roughly locate the CPU at
> the time of the exception.

Would frace be enough in this case? It has already been suggested
earlier.

The problem is that adding CPU into would require changes in
the metadata stored in the ring buffer. And it would require
updating userspace tools which read the log from a crash dump.
It means that such a feature would need a lot of effort.
And I would prefer to avoid it when there is another solution.

If you debug the problem by adding extra printk messages
you might also print the current CPU in the debug messages.

Best Regards,
Petr
