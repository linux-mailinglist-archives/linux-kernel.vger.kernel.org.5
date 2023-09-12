Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEA79CA17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjILIfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 04:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjILIfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:35:14 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375DD170E;
        Tue, 12 Sep 2023 01:34:59 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5925e580f12so52350687b3.3;
        Tue, 12 Sep 2023 01:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507698; x=1695112498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va0K00GDqUxBnNiJnV24w11PAu0AJJ95xu4LbYWmM+8=;
        b=ehGb+lwm1yGT5jJ+zEODgoVK78tvbDnkLQ8eL4Iq5QEeekzLalEmwBfDYRT9khwHS9
         3tcQYMJtiQqG2aA4mjUrszEEOKZUg4jlXjWia1fqNrnU50WnY1rhmbEzaMXLWyHToobG
         sZYra9WwS8fgmS9Se8S7Ve0oMmNGtGXPWZRth9Vd/ozPdplkihwUo9EekBsySCQGj7Pp
         fTa/Yx5kiGR9Gi0+cHScF+0yT31Qz4ACOSf4I2URJwAwtjTaqng4eBhd7f1asIhBfHYA
         gq047wpfBdZoxwFh9NCHAPymQ45fqbpuC9mQQCGRcqTsv3ofbgKyyZm31f8VsWbHfTzZ
         fH6Q==
X-Gm-Message-State: AOJu0Yxi86sQtXCP3MixBkcGScH869AjKxEnBRL7vLP2Rv0g6qjf90nj
        bwKg09IZ1ejzDLBVwaOPPOPfe37L/uZfWw==
X-Google-Smtp-Source: AGHT+IHhuZWnrgtlgRKuGuVTJ7r+DO90VMYiTmFmWxqSuE91YxpUSW8SNLvGr+XOsCYOsJsHctDe4Q==
X-Received: by 2002:a0d:fc07:0:b0:592:9035:8356 with SMTP id m7-20020a0dfc07000000b0059290358356mr13618824ywf.26.1694507698269;
        Tue, 12 Sep 2023 01:34:58 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id e184-20020a8169c1000000b0059a34cfa2a5sm2389774ywc.67.2023.09.12.01.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:34:56 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-58d31f142eeso52596597b3.0;
        Tue, 12 Sep 2023 01:34:56 -0700 (PDT)
X-Received: by 2002:a25:a3c5:0:b0:d77:91db:e5c6 with SMTP id
 e63-20020a25a3c5000000b00d7791dbe5c6mr12060515ybi.17.1694507696692; Tue, 12
 Sep 2023 01:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com> <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver> <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver> <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver> <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com> <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
In-Reply-To: <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 10:34:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
Message-ID: <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
To:     paulmck@kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Sep 12, 2023 at 10:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 10:14 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> > > > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrote:
> > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > > > > > > > (Adding Paul & Shanker to Cc list.. please see below for why)
> > > > > > > >
> > > > > > > > Apologies on the late response, I was away and have been struggling to
> > > > > > > > get a working PPC32 test environment.
> > > > > > > >
> > > > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > > > > > > >     Hi Liam,
> > > > > > > > >
> > > > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > > > The current implementation of append may cause duplicate data and/or
> > > > > > > > > > incorrect ranges to be returned to a reader during an update.  Although
> > > > > > > > > > this has not been reported or seen, disable the append write operation
> > > > > > > > > > while the tree is in rcu mode out of an abundance of caution.
> > > > > > > >
> > > > > > > > ...
> > > > > > > > > >
> > > >
> > > > ...
> > > >
> > > > > > > > > RCU-related configs:
> > > > > > > > >
> > > > > > > > >     $ grep RCU .config
> > > > > > > > >     # RCU Subsystem
> > > > > > > > >     CONFIG_TINY_RCU=y
> > >
> > > I must have been asleep last time I looked at this.  I was looking at
> > > Tree RCU.  Please accept my apologies for my lapse.  :-/
> > >
> > > However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I would
> > > have said the same thing, albeit after looking at a lot less RCU code.
> > >
> > > TL;DR:
> > >
> > > 1.      Try making the __setup_irq() function's call to mutex_lock()
> > >         instead be as follows:
> > >
> > >         if (!mutex_trylock(&desc->request_mutex))
> > >                 mutex_lock(&desc->request_mutex);
> > >
> > >         This might fail if __setup_irq() has other dependencies on a
> > >         fully operational scheduler.
> > >
> > > 2.      Move that ppc32 call to __setup_irq() much later, most definitely
> > >         after interrupts have been enabled and the scheduler is fully
> > >         operational.  Invoking mutex_lock() before that time is not a
> > >         good idea.  ;-)
> >
> > There is no call to __setup_irq() from arch/powerpc/?
>
> Glad it is not just me, given that I didn't see a direct call, either.  So
> later in this email, I asked Liam to put a WARN_ON_ONCE(irqs_disabled())
> just before that mutex_lock() in __setup_irq().
>
> Either way, invoking mutex_lock() early in boot before interrupts have
> been enabled is a bad idea.  ;-)

I'll add that WARN_ON_ONCE() too, and will report back later today...

> > Note that there are (possibly different) issues seen on ppc32 and on arm32
> > (Renesas RZ/A in particular, but not on other Renesas ARM systems).
> >
> > I saw an issue on arm32 with cfeb6ae8bcb96ccf, but not with cfeb6ae8bcb96ccf^.
> > Other people saw an issue on ppc32 with both cfeb6ae8bcb96ccf and
> > cfeb6ae8bcb96ccf^.
>
> I look forward to hearing what is the issue in both cases.

For RZ/A, my problem report is
https://lore.kernel.org/all/3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org/

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
