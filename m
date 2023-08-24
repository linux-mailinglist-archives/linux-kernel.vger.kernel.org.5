Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B10786582
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbjHXCgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbjHXCg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:36:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2126A1AD;
        Wed, 23 Aug 2023 19:36:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-52349d93c8aso1579369a12.1;
        Wed, 23 Aug 2023 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692844584; x=1693449384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+bYIC4WKLEvVJtsHYHv7wOhPkzRqfxXs68+KHMYY7k=;
        b=HDreI3hLlItTNcPU7rcO0JmtONCD+Yh/t8jrFS+iagtvUl7pARLCupfsxrUZ09WOAy
         xOTePGdPhQRMxASZ7hexKJVsmUOSOmPoVYSXZk5tH39psaYKcI+m8gM1SyJD7+uexYIo
         l6jUBITjXHNJsnZ//kbdW9XDAp100Sf5+kIPWzDTK42Ns5SGTHLN8SDzy0ns7sdKxn0F
         6Vq6g5V2X8kqJIWjl3VhLq/MKuDIYoXonoqDPqTNl5K1F6NfY/SKGWm5qSOSLw41gynA
         lkGXYex3bDha68BrCpuffHj/N14GknTxSb9jSWO4LJItohH37GYkZqOVnjU51+IM2xVF
         FCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692844584; x=1693449384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+bYIC4WKLEvVJtsHYHv7wOhPkzRqfxXs68+KHMYY7k=;
        b=KT8GxH0LwJi3M9dACtEmnNimkS34xCoR6p2AAO6snBQpbozn9Al8lp6IYG3ko1U8uF
         qa8j7tKOeb8iZngzxCL9+jaoqkqpgmWTLbvYxn+mUf8n2nivwlLxqcxiRoWdS606+61B
         o19G8AMN6lIlGjIHQNXiITx0CYFXj5qrL2gx7rihBvbDjxihN4rKNmqklp7FjjHfQbxn
         Sl7FYHKmxjE8yQFpHxwFWctgqh20U9WZsmS63dtH4axK05roZXi3NBp1cegauk6Lqc8E
         W/EAmDq1DtGTdHbRcbaT+Oq1Ow4hSJmuus0/Sisbo/5gidVe5F1bt47w6jiPDajsIY32
         DLoQ==
X-Gm-Message-State: AOJu0Yz9eKXzpnAtqsmGp2GdfDt+86NirXIhbsYzBO0r69KKXOQSOyTa
        NIKwQuL6QvGoiyVTPHipWLYs7ko6pVPQvbhTQqJDQxLpSjdesg==
X-Google-Smtp-Source: AGHT+IHmhTadpMzA0TPRmyGCY6eFr9gh+Son5yWY/I/SJaKMWMzI3X0X7I4qtr2SD6ir9ms+mM8HFgN+hREqfo7rw4w=
X-Received: by 2002:a05:6402:518f:b0:521:f2a7:d57a with SMTP id
 q15-20020a056402518f00b00521f2a7d57amr9578996edd.2.1692844584084; Wed, 23 Aug
 2023 19:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230818031532.15591-1-Wenhua.Lin@unisoc.com> <2023082205-jazz-evade-7f1a@gregkh>
In-Reply-To: <2023082205-jazz-evade-7f1a@gregkh>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 24 Aug 2023 10:36:11 +0800
Message-ID: <CAB9BWhct+pO4a6i0BE6Zt3zhyjZQr1Dv14ZozssMc4edAWwgWw@mail.gmail.com>
Subject: Re: [PATCH] tty/serial: Cancel work queue before closing uart
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 9:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 18, 2023 at 11:15:32AM +0800, Wenhua Lin wrote:
> > When the system constantly sleeps and wankes up, plugging and unpluggin=
g
> > the USB will probalility trigger a kernel crash problem. The reason is
> > that at this time, the system entered deep and turned off uart, and the
> > abnormal behavior of plugging and upplugging the USB triggered the read
> > data process of uart, causing access to uart to hang. The final solutio=
n
> > we came up with is to cancel the work queue before shutting down uart
> > , while ensuring that there is no uart business.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index b58f51296ace..eddff4360155 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/tty.h>
> >  #include <linux/tty_flip.h>
> > +#include "../tty.h"
> >
> >  /* device name */
> >  #define UART_NR_MAX          8
> > @@ -1221,7 +1222,10 @@ static int sprd_probe(struct platform_device *pd=
ev)
> >  static int sprd_suspend(struct device *dev)
> >  {
> >       struct sprd_uart_port *sup =3D dev_get_drvdata(dev);
> > +     struct uart_port *uport =3D &sup->port;
> > +     struct tty_port *tty =3D &uport->state->port;
> >
> > +     tty_buffer_cancel_work(tty);
>
> What does this serial port have to do with the USB subsystem in your
> changelog text?
>
> And as the kernel bot said, this breaks the build, you can't do this
> within a serial driver, sorry.

This modification is not directly related to the usb subsystem.
I just described a problem scenario, such as the previous comment.
There may be problems with this solution. I will make changes on patch v2,
thank you for your review

>
> greg k-h
