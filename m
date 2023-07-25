Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67324760C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjGYHuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjGYHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:49:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03873D3;
        Tue, 25 Jul 2023 00:49:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fdd31bf179so7873928e87.2;
        Tue, 25 Jul 2023 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690271393; x=1690876193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hz9CNO+vqPPbwZdw+qv1emEqR9EXaSPi9lk5lY3h5XE=;
        b=NTqbqIzHD24Vz71930+dc7E8JY/mINXjsO8xggdLkJ1AJSLfOh0n8kIKasGkL7tC5U
         7JWxVC2x9fj0SN/TdjDQCwOChcwx4gHdRwjmstwFg/S+kwdqRe8aMW98F3nD0TbRpb/0
         VxgSIQuFGuKg2p8fGqRTEAInaGCos/cBuviNTvK8naMAVoYOmMbDLM0xUIBSvFxp0lPp
         ZkD2f7tXsg5WFM8fdC/eXPF77eRAXCec0IpZnGwb2vF4dLKPOGnVqMp+vxHEjYy77u2b
         j/bx+GiByeq/wxqx9UlbnvkNfRTBr12jojrWNTkvxWuGS6ISo931sbwDgDZIGeDxXWvF
         K9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690271393; x=1690876193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz9CNO+vqPPbwZdw+qv1emEqR9EXaSPi9lk5lY3h5XE=;
        b=eMzZaGEz1y5z3Mkdkk9FtKoLCOwIsm4U6eHTsiLRG86qHxc+vAv3gTrqHJqBt2+BI7
         qVfhr/8yZBZxdIdTjrKsBfQOAlJ2XvCpZlaZEsn4zbzpoa+WgHl3WFBDsJxBgQIPQXi+
         awzOsJNRORf3c05aWxHtke6AjGNb4nx8cX88HdhfbeUxz68t+W5fpkDq1in2/QGjOOYY
         Q/0sVhbF4q3U/VwUFM3zHfNWch4H1+iFRH1sSIWsdv0r8JpNo/GKARMk0C7XgApISVRF
         GKLPdBshdGLqrxFKZL7AtLOw7M0VmTrTXO1XyL833CwCZy+kw6BcJaWXLnqon0O8QL55
         5mpg==
X-Gm-Message-State: ABy/qLaIZrnHPkFCELbUckcfIUb1uEyKldJlwqQRt8gVachVADtYDaJm
        8GJJBI63He8jIMUOjVZ8FGVzQGdtALNGX1b97Xo=
X-Google-Smtp-Source: APBJJlGTu/kXoLlkJjXTRkUdfBcDj3PtAuEm8+yc+pfPrgSIpDZ76qZhMmOndQJ9+w84HH49ROGS3sODoImQJaK/ODQ=
X-Received: by 2002:ac2:5e24:0:b0:4fe:958:88ac with SMTP id
 o4-20020ac25e24000000b004fe095888acmr194768lfg.6.1690271392924; Tue, 25 Jul
 2023 00:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230725064053.235448-1-chunyan.zhang@unisoc.com> <2023072548-jolliness-unbolted-621c@gregkh>
In-Reply-To: <2023072548-jolliness-unbolted-621c@gregkh>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 25 Jul 2023 15:49:15 +0800
Message-ID: <CAAfSe-ugFQZqNzuukghJHot71v=GoueamooFGzAdEUoPvEgh8g@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] serial: sprd: Assign sprd_port after initialized
 to avoid wrong access
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 14:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 25, 2023 at 02:40:52PM +0800, Chunyan Zhang wrote:
> > The global pointer 'sprd_port' may not zero when sprd_probe returns
> > failure, that is a risk for sprd_port to be accessed afterward, and
> > may lead to unexpected errors.
> >
> > For example:
> >
> > There are two UART ports, UART1 is used for console and configured in
> > kernel command line, i.e. "console=";
> >
> > The UART1 probe failed and the memory allocated to sprd_port[1] was
> > released, but sprd_port[1] was not set to NULL;
> >
> > In UART2 probe, the same virtual address was allocated to sprd_port[2],
> > and UART2 probe process finally will go into sprd_console_setup() to
> > register UART1 as console since it is configured as preferred console
> > (filled to console_cmdline[]), but the console parameters (sprd_port[1])
> > belong to UART2.
> >
> > So move the sprd_port[] assignment to where the port already initialized
> > can avoid the above issue.
> >
> > Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> > V3:
> > - Call uart_unregister_driver() only when the 'sprd_ports_num' decreases to 0;
> > - Add calling sprd_rx_free_buf() instread of sprd_remove() under clean_up lable.
> >
> > V2:
> > - Leave sprd_remove() to keep the unrelated code logic the same.
> > ---
> >  drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> > index b58f51296ace..fc1377029021 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -1106,7 +1106,7 @@ static bool sprd_uart_is_console(struct uart_port *uport)
> >  static int sprd_clk_init(struct uart_port *uport)
> >  {
> >       struct clk *clk_uart, *clk_parent;
> > -     struct sprd_uart_port *u = sprd_port[uport->line];
> > +     struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);
>
> Now that you are not allocaing the sprd_port[] pointers, shouldn't you
> also remove that variable entirely?

sprd_console_write() and sprd_console_setup() [1] also need sprd_port[].

So, this driver still needs to allocate the buffer for sprd_port[],
the change is using a local variable instead of allocating directly to
the global pointer.

[1] https://elixir.bootlin.com/linux/v6.5-rc1/source/drivers/tty/serial/sprd_serial.c#L1000

Thanks,
Chunyan
