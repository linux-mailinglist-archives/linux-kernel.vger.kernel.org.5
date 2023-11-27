Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6975E7F9760
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjK0CHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0CG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:06:58 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6611B;
        Sun, 26 Nov 2023 18:07:05 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1f9e6a8b00aso1767214fac.3;
        Sun, 26 Nov 2023 18:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701050824; x=1701655624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asGQFlJbseALxVoUAFeWJFbzNriZ6/364BUepF32tlM=;
        b=lNoji0S4rwNe9DRxZ4ItMsTg6Ml/Qv1OKI7geFXk26/fkU8Rw2Mb37B6qHxaTQQEYC
         vbeMCnMOQCfTwh9D7JBDvMoAWNisW4BZO3M40rm7/XudCp/6juIjJMaXBT8YspQ+4/Tj
         /OOnWLhTK0ER32dVpSbnVfQkHmLViK7WdLc9KtSTylSwBLjovb+B/ad8PhcRqkrwYvYd
         2HR1ISNVZjdPiduqnuWVM6UoscefGuTCv6JPtXmGe0UN1QZ0ZQo+hd2FxnVdh8wqN3ao
         X0SO22miSjxTm6y1LP4F+jDHWv3a5THZCHqqCay7lK4ajjwUqSJpLynQH81FxR8az1b8
         sCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701050824; x=1701655624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asGQFlJbseALxVoUAFeWJFbzNriZ6/364BUepF32tlM=;
        b=aNWXpnLxf+xc/XOkZyCo0fhBMR23Iu8T9aJfrKH01haQ1fgeBhzI3oc7TV3JlmncXZ
         PDG2E1Tpghu9cSxmvcMzMsYMOGJEg8xDBs+/20cj5yzH2ukX7IO1PM1xWpHAd+mXdmgw
         2ADdQjFuX8cRIqsUdXRRLwmHP0teUp2ezwV82U4cLw/M8AhAI8WnVBLP7QEe47zalYbG
         y4NwSPr+Jy+7dQq2erJS5lxsmVLY2DZ/hA9B5dMjzx1Jd64UddmTO7Yz+yLg8mkw1e3s
         gAKEY3kfSw0GpnVpUyXL36pQkhD0CQKgGNJtS9Ebv8ABAcA5e5S1RGNVrcNgBWMiNsAJ
         OUsQ==
X-Gm-Message-State: AOJu0YzjI2ZepFQoH8rvnXZ+sUInWwnTuRvV2hU0FSTduzJtkuH9jIjF
        o/9JrdASY2WpVkN79LJoN1Cg1vQyB4fIZGIazOU=
X-Google-Smtp-Source: AGHT+IEz1/FpIU1hEmciAxvSiSkJb68dGD3xv9+tvEeMRcIlKNgGSZzlMhUVvU28GhIFsDnGpWrZRn2xSrrvcuu6KPA=
X-Received: by 2002:a05:6870:5d93:b0:1f0:656b:5b99 with SMTP id
 fu19-20020a0568705d9300b001f0656b5b99mr16069972oab.11.1701050824197; Sun, 26
 Nov 2023 18:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20231124122258.1050-1-xuewen.yan@unisoc.com> <87il5o32w9.fsf@jogness.linutronix.de>
In-Reply-To: <87il5o32w9.fsf@jogness.linutronix.de>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 27 Nov 2023 10:06:53 +0800
Message-ID: <CAB8ipk8==8PTZPsY_VjQFgcJ0sOfQomgybkPB1sWPiGNWGB=Jw@mail.gmail.com>
Subject: Re: [RFC PATCH] serial: core: Use pm_runtime_get_sync() in uart_start()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        tony@atomide.com, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, ke.wang@unisoc.com,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

On Mon, Nov 27, 2023 at 12:17=E2=80=AFAM John Ogness <john.ogness@linutroni=
x.de> wrote:
>
> [Added printk maintainers CC.]
>
> On 2023-11-24, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
> > The commit 84a9582fd203("serial: core: Start managing serial
> > controllers to enable runtime PM") use the pm_runtime_get() after
> > uart_port_lock() which would close the irq and disable preement.  At
> > this time, pm_runtime_get may cause the following two problems:
> >
> > (1) deadlock in try_to_wake_up:
> >
> > uart_write()
> > uart_port_lock() <<< get lock
> > __uart_start
> > __pm_runtime_resume
> > rpm_resume
> > queue_work_on
> > try_to_wake_up
> > _printk
> > uart_console_write
> > ...
> > uart_port_lock() <<< wait forever
>
> I suppose you got this because of the lockdep message generated by
> #2. It probably would make sense to call __printk_safe_enter() inside
> uart_port_lock(). This would allow printk() to automatically defer the
> printing for that CPU until the port lock is released.

Thanks for the suggestion, I would use printk_deferred in our tree to
retest the case.

And I also notice the warning was reported by syzbot:
https://lore.kernel.org/all/0000000000006f01f00608a16cea@google.com/
https://lore.kernel.org/all/000000000000e7765006072e9591@google.com/

>
> > (2) scheduling while atomic:
> > uart_write()
> > uart_port_lock() <<< get lock
> > __uart_start
> > __pm_runtime_resume
> > rpm_resume
> > schedule() << sleep
>
> rpm_resume() is a fascinating function. It requires the caller to hold a
> spin_lock (dev->power.lock) with interrupts disabled. But it seems to
> believe that this is the *only* spin_lock held so that it can
> temporarily spin_unlock and call might_sleep() functions. In the case of
> uart_write(), it certainly is not the only spin_lock held.
>
> I do not know enough about the internals of RPM to suggest a proper
> solution. But it looks like rpm_resume() cannot assume dev->power.lock
> is the only spin_lock held by the caller.

I would also be very grateful if could give us more suggestions.

Thanks!

BR
---
xuewen
>
> John Ogness
