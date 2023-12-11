Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD580DD76
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbjLKVl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLKVlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:41:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B042C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:42:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so6667820a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702330919; x=1702935719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvsjJYhvv+f3XhbCRuq+pRr1LNIA+hk6SC/AnSsJPwU=;
        b=YvYXUSLQ+aE7L3Ul5SAU0QXmsiBcg6Zfo6d3z/rizyd1nDp74CwmdL1Za9+0ggkt7u
         5STPkvKWQnCTYEtHhoDdZVbRDRbSxj05GE/8Dz/h+/Bqofmr67xB9XQhL3NzL+QK8Q9+
         aPBAzEmTvCmlacEN4mtkjqLF4lxHMT0BsJ5CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330919; x=1702935719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvsjJYhvv+f3XhbCRuq+pRr1LNIA+hk6SC/AnSsJPwU=;
        b=KGkB0ODsBnJdKsMFncFvl/T+ByiIvxrjTmOAVIy/TqoIm5Tzra1Bwz3C8gw148040G
         cRy3IBMkNTAWCFNnDMdbz/45MI2GTHiZJA/7jcQJTemFOWvgpb1jHCLGFwlqOPVtjAkC
         JLVCHQ3SY27J08eSw1b7hNMojnq17DlmyUVrhdRgaxexMRRaDOyRHMvdNQwS4P+XizGl
         77Q4zRTJHfPLz47zwrfRMmIlddbzVD5avGNgpH+YB1cpeJb/KflANe7UNEtQWhZNAemG
         AAPXaiyFmkU7+mNOfDm82N7GkGnT2R28z2erhRzKJdMGhaT+VJt/6cVwlKcpmzvT34gt
         YPhA==
X-Gm-Message-State: AOJu0YxtGPUJsNgQTNOHRUN9QkGPJQ+qT+JqfeH4Fq5TcHos18Rk+kDt
        r5cODJbLoeu0gLzz1C20FjRA7pw+hAmRLjifTaMcGQ==
X-Google-Smtp-Source: AGHT+IGO08YwcWoHffIjPKsmKnNAUPGDJA8ps+hKzMpypaXrMSG0zTtD5hF3mlUQITNjMkYpgLnCjXwk5kWb23oeOPQ=
X-Received: by 2002:a17:907:2596:b0:a0e:d93a:3202 with SMTP id
 ad22-20020a170907259600b00a0ed93a3202mr2056769ejc.4.1702330918966; Mon, 11
 Dec 2023 13:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20231208212845.1679621-1-michael@amarulasolutions.com> <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com>
In-Reply-To: <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 11 Dec 2023 22:41:46 +0100
Message-ID: <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com>
Subject: Re: [RFC PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug

On Mon, Dec 11, 2023 at 10:39=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Fri, Dec 8, 2023 at 1:28=E2=80=AFPM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Use late_initcall_sync insted of module init to be sure that
> > serial driver is really probed and get take handover from
> > early driver.
>
> Awesome that you used the earlycon driver to debug problems with
> registering the normal driver! :-P
>
>
> > The 8250 register the platform driver after
> > the 8250 core is initialized. As shown by kdbg
> >
> > Thread 2 received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 1]
> > _outb (addr=3D<optimized out>, value=3D<optimized out>) at ./include/as=
m-generic/io.h:584
> > 584             __raw_writeb(value, PCI_IOBASE + addr);
> > (gdb) bt
> >
> > This section of the code is too early because in this case
> > the omap serial is not probed
> >
> > Thread 2 received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 1]
> > _outb (addr=3D<optimized out>, value=3D<optimized out>) at ./include/as=
m-generic/io.h:584
> > 584             __raw_writeb(value, PCI_IOBASE + addr);
> > (gdb) bt
> >
> > Thread 2 received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 1]
> > _outb (addr=3D<optimized out>, value=3D<optimized out>) at ./include/as=
m-generic/io.h:584
> > 584             __raw_writeb(value, PCI_IOBASE + addr);
> > (gdb) bt
> > 0  _outb (addr=3D<optimized out>, value=3D<optimized out>) at ./include=
/asm-generic/io.h:584
> > 1  logic_outb (value=3D0 '\000', addr=3D18446739675637874689) at lib/lo=
gic_pio.c:299
> > 2  0xffff80008082dfcc in io_serial_out (p=3D0x0, offset=3D16760830, val=
ue=3D0) at drivers/tty/serial/8250/8250_port.c:416
> > 3  0xffff80008082fe34 in serial_port_out (value=3D<optimized out>, offs=
et=3D<optimized out>, up=3D<optimized out>)
> >     at ./include/linux/serial_core.h:677
> > 4  serial8250_do_set_termios (port=3D0xffff8000828ee940 <serial8250_por=
ts+1568>, termios=3D0xffff80008292b93c, old=3D0x0)
> >     at drivers/tty/serial/8250/8250_port.c:2860
> > 5  0xffff800080830064 in serial8250_set_termios (port=3D0xfffffbfffe800=
000, termios=3D0xffbffe, old=3D0x0)
> >     at drivers/tty/serial/8250/8250_port.c:2912
> > 6  0xffff80008082571c in uart_set_options (port=3D0xffff8000828ee940 <s=
erial8250_ports+1568>, co=3D0x0, baud=3D115200, parity=3D110, bits=3D8, flo=
w=3D110)
> >     at drivers/tty/serial/serial_core.c:2285
> > 7  0xffff800080828434 in uart_poll_init (driver=3D0xfffffbfffe800000, l=
ine=3D16760830, options=3D0xffff8000828f7506 <config+6> "115200n8")
> >     at drivers/tty/serial/serial_core.c:2656
> > 8  0xffff800080801690 in tty_find_polling_driver (name=3D0xffff8000828f=
7500 <config> "ttyS2,115200n8", line=3D0xffff80008292ba90)
> >     at drivers/tty/tty_io.c:410
> > 9  0xffff80008086c0b0 in configure_kgdboc () at drivers/tty/serial/kgdb=
oc.c:194
> > 10 0xffff80008086c1ec in kgdboc_probe (pdev=3D0xfffffbfffe800000) at dr=
ivers/tty/serial/kgdboc.c:249
> > 11 0xffff8000808b399c in platform_probe (_dev=3D0xffff000000ebb810) at =
drivers/base/platform.c:1404
> > 12 0xffff8000808b0b44 in call_driver_probe (drv=3D<optimized out>, dev=
=3D<optimized out>) at drivers/base/dd.c:579
> > 13 really_probe (dev=3D0xffff000000ebb810, drv=3D0xffff80008277f138 <kg=
dboc_platform_driver+48>) at drivers/base/dd.c:658
> > 14 0xffff8000808b0d2c in __driver_probe_device (drv=3D0xffff80008277f13=
8 <kgdboc_platform_driver+48>, dev=3D0xffff000000ebb810)
> >     at drivers/base/dd.c:800
> > 15 0xffff8000808b0eb8 in driver_probe_device (drv=3D0xfffffbfffe800000,=
 dev=3D0xffff000000ebb810) at drivers/base/dd.c:830
> > 16 0xffff8000808b0ff4 in __device_attach_driver (drv=3D0xffff80008277f1=
38 <kgdboc_platform_driver+48>, _data=3D0xffff80008292bc48)
> >     at drivers/base/dd.c:958
> > 17 0xffff8000808ae970 in bus_for_each_drv (bus=3D0xfffffbfffe800000, st=
art=3D0x0, data=3D0xffff80008292bc48,
> >     fn=3D0xffff8000808b0f3c <__device_attach_driver>) at drivers/base/b=
us.c:457
> > 18 0xffff8000808b1408 in __device_attach (dev=3D0xffff000000ebb810, all=
ow_async=3Dtrue) at drivers/base/dd.c:1030
> > 19 0xffff8000808b16d8 in device_initial_probe (dev=3D0xfffffbfffe800000=
) at drivers/base/dd.c:1079
> > 20 0xffff8000808af9f4 in bus_probe_device (dev=3D0xffff000000ebb810) at=
 drivers/base/bus.c:532
> > 21 0xffff8000808ac77c in device_add (dev=3D0xfffffbfffe800000) at drive=
rs/base/core.c:3625
> > 22 0xffff8000808b3428 in platform_device_add (pdev=3D0xffff000000ebb800=
) at drivers/base/platform.c:716
> > 23 0xffff800081b5dc0c in init_kgdboc () at drivers/tty/serial/kgdboc.c:=
292
> > 24 0xffff800080014db0 in do_one_initcall (fn=3D0xffff800081b5dba4 <init=
_kgdboc>) at init/main.c:1236
> > 25 0xffff800081b0114c in do_initcall_level (command_line=3D<optimized o=
ut>, level=3D<optimized out>) at init/main.c:1298
> > 26 do_initcalls () at init/main.c:1314
> > 27 do_basic_setup () at init/main.c:1333
> > 28 kernel_init_freeable () at init/main.c:1551
> > 29 0xffff8000810271ec in kernel_init (unused=3D0xfffffbfffe800000) at i=
nit/main.c:1441
> > 30 0xffff800080015e80 in ret_from_fork () at arch/arm64/kernel/entry.S:=
857
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >  drivers/tty/serial/kgdboc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index 7ce7bb164005..7f8364507f55 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -622,7 +622,7 @@ console_initcall(kgdboc_earlycon_late_init);
> >
> >  #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
> >
> > -module_init(init_kgdboc);
> > +late_initcall_sync(init_kgdboc);
>
> While I'm not denying that you hit a bug, I don't think this is the
> correct fix. The way it's supposed to work is:
>

Yes it's a bug

> 1. init_kgdboc() runs and registers the singleton kgdb "platform driver".
>
> 2. The platform driver's probe function, kgdboc_probe(), runs and
> checks to see if the console is ready by looking at the return value
> of configure_kgdboc(). If it's ready then we're good to go. If it's
> not ready then we defer.
>
> So I think the bug here is that somehow the console looks "ready"
> (because tty_find_polling_driver() can find it) but it isn't actually
> ready yet (because it crashes). That's what you need to fix.
>

The polling driver look for uart and uart8250_core is registered and 4 fake=
 uart
are there but there are not still replaced by platform driver that can
come later.
The try_polling find it but it's the isa-8250 driver. It means that
add_uart 8250 is
not still happen

> I'll note that, in the past, I've definitely used kgdb on 8250-based
> UARTs. Is your hardware somehow special or is this a regression?
>

Michael

> -Doug



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
