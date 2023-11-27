Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7867F9752
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjK0ByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0ByK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:54:10 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79C2EA;
        Sun, 26 Nov 2023 17:54:12 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso1854926fac.0;
        Sun, 26 Nov 2023 17:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701050052; x=1701654852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBeAq8QwgmtnDdeFjA5H99h7qAl3dbGU1CLtQZsou40=;
        b=c/yU5iIYMw1ChppLEoAkAoM66mNrtWR8CzpYf5tJM3Vi7z6mg0CoZkSwNhRNQuVSD+
         AadS2rlTriLZeq9Gh4WsRuK6nwNa4I1EjDnY8qit6UO+yjagk/FozKAMEK/CtUL2nQhK
         MM71xXnPPZ2uhxbVrgZd95grCBtPJgcgo+raEigKooEtuBLrzHb2m2p83GM8/AIMl08/
         hHk+my0K8vDTjAGSC3keCugwkGvyqfqWbsyWUThwEDu+WHGae9YxQpwGZMVObzKdg4YV
         LKpkaYMDQj24B3OhroJbiYu1xrGqIRxb0jh0mcfc6ZyV/vt65tLiPl6qUFPEKQJx/u5o
         WSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701050052; x=1701654852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBeAq8QwgmtnDdeFjA5H99h7qAl3dbGU1CLtQZsou40=;
        b=s4a7CnmfMTEMGcr/14mmCUOBFXd8PKVnROCtOxkBSw2vS+1lEEGdZJto52UCRYbSXD
         2OpXjNIWt3OwaEHR1z3jSPQ3xGhBti8p+180dqS9LcgYoHAMHygFDxrPC5/va2M+ajGL
         VXI/mlc1ljxH6GOX6TrTR/VRxWpWAU5p5NBNkFuvfQvk8jeNYGx+uUsa+xqW0LF7uNq7
         lVXv24WXmJJMhdP3m7JuXPVzEYtMyysbZpqA10LpG3cjDFUavXQjHau3irMLaBu4L3/L
         ND3xx2vfhzaT1za+nBFLjpURhDLgfBNWlgHFCW/vESQHhdCobmhxD85i7ff2fAXXZj7I
         JhmQ==
X-Gm-Message-State: AOJu0Yx3p/pX7cMrQfDsQ60a39DJRkdTGQY6MZ1BABiAbMLk9uf999jO
        iYGJh99PYsMLW4GuMRsBcl9y5xd5rGTXrcpVITy9om0FVKQ=
X-Google-Smtp-Source: AGHT+IFOPlWn7i73QXEXgqmn/4zBX8zwZFzmdFIvBALDR/k5yJ+gSq3Kj/A5GoyLrrPK58v57VsXXbLNNvf6Pv4WUg4=
X-Received: by 2002:a05:6870:6245:b0:1f9:602e:7b08 with SMTP id
 r5-20020a056870624500b001f9602e7b08mr5718109oak.11.1701050052132; Sun, 26 Nov
 2023 17:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20231124122258.1050-1-xuewen.yan@unisoc.com> <20231125074738.GJ5169@atomide.com>
In-Reply-To: <20231125074738.GJ5169@atomide.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 27 Nov 2023 09:54:01 +0800
Message-ID: <CAB8ipk_fbQO4_E7e8OovQfQzLjfWXi5Sn3OB7NMQ1Kqge5F-tQ@mail.gmail.com>
Subject: Re: [RFC PATCH] serial: core: Use pm_runtime_get_sync() in uart_start()
To:     Tony Lindgren <tony@atomide.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        john.ogness@linutronix.de, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, ke.wang@unisoc.com
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

Hi Tony

On Sat, Nov 25, 2023 at 3:48=E2=80=AFPM Tony Lindgren <tony@atomide.com> wr=
ote:
>
> * Xuewen Yan <xuewen.yan@unisoc.com> [231124 12:25]:
> > The commit 84a9582fd203("serial: core: Start managing serial controller=
s to enable runtime PM")
> > use the pm_runtime_get() after uart_port_lock() which would close the i=
rq and disable preement.
> > At this time,  pm_runtime_get may cause the following two problems:
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
> >
> > (2) scheduling while atomic:
> > uart_write()
> > uart_port_lock() <<< get lock
> > __uart_start
> > __pm_runtime_resume
> > rpm_resume
> > chedule() << sleep
>
> Are these spinlock vs raw spinlock nesting warnings from lockdep? If so
> can you please post the full warnings somewhere? Or if some extra steps
> are needed to reproduce please describe that too.

Indeed, we use pr_info in scheduler in our own kernel tree, and this
deadlock happended.
I would try to use printk_deferred and re-test.
And I also notice the warning was reported by syzbot:

https://lore.kernel.org/all/0000000000006f01f00608a16cea@google.com/
https://lore.kernel.org/all/000000000000e7765006072e9591@google.com/

These are also because the pm_runtime_put().

Thanks!

>
> Chances are very high that your serial port is already runtime active at
> this point unless you manually idle it so that's why I'm wondering as
> all that likely is happening here is a check on the runtime PM usage coun=
t.
>
> > So let us use pm_runtime_get_sync() to prevent these.
>
> We need to fix this some other way as we can't use pm_runtime_get_sync()
> here. The sync call variants require setting pm_runtime_irq_safe() for th=
e
> device. And this is what we really want to avoid as it takes a permanent
> usage count on the parent device.
>
> What we want to do here is to get runtime PM to wake-up the device if idl=
e
> and try tx again after runtime PM resume as needed.
>
> Just guessing at this point.. To me it sounds like the fix might be to
> use a raw spinlock for uart_port_lock() and uart_port_unlock()?
>
> Regards,
>
> Tony
>
>
> > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers t=
o enable runtime PM")
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index f1348a509552..902f7ed35f4d 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -145,7 +145,7 @@ static void __uart_start(struct uart_state *state)
> >       port_dev =3D port->port_dev;
> >
> >       /* Increment the runtime PM usage count for the active check belo=
w */
> > -     err =3D pm_runtime_get(&port_dev->dev);
> > +     err =3D pm_runtime_get_sync(&port_dev->dev);
> >       if (err < 0 && err !=3D -EINPROGRESS) {
> >               pm_runtime_put_noidle(&port_dev->dev);
> >               return;
> > @@ -159,7 +159,7 @@ static void __uart_start(struct uart_state *state)
> >       if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev=
))
> >               port->ops->start_tx(port);
> >       pm_runtime_mark_last_busy(&port_dev->dev);
> > -     pm_runtime_put_autosuspend(&port_dev->dev);
> > +     pm_runtime_put_sync_autosuspend(&port_dev->dev);
> >  }
> >
> >  static void uart_start(struct tty_struct *tty)
> > --
> > 2.25.1
> >
