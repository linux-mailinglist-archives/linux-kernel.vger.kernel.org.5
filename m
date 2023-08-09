Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C227750B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHICKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHICKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:10:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB321BCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:10:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76d1dc1ebfdso23857785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 19:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691547030; x=1692151830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EilzzrhESGX6VzHKBYdGUjOlrbXMTnQwoUfi/ZyvcEM=;
        b=Yp2CYl8+W28LK+/PpQfZM1HdFk6CSkRhywi6HQO79D3WDRhoI6CMcBk3yQoXxseVt4
         DObH0Za4N0euVfh7OK+tgxzbLELNPsbKBUskqPge+fsCbSMAZesWUp7fFOlbHM2KhtNl
         La3Vh8+PdZDwvrV4b246txvap3fviXgCNZ5w6tAZKyaHPX4iynIZT6u9toGQdLeQkAK6
         AJFLXsTXX3eR+Ju5dsJzN/hPU+ZOGLTI76KOAbSJCD49qTh0B3a0CSSIEU/Jvauh9gIp
         33HWpglxuSxAM2PTZ9NirC9Dz3zzcKTzPhIh/JBALS8b+f5ESkp9ow2lxO9b0XIWgEzQ
         sriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691547030; x=1692151830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EilzzrhESGX6VzHKBYdGUjOlrbXMTnQwoUfi/ZyvcEM=;
        b=IuZh5yfXaQgxH650Q5eiMt68EiUDPR30SFovLGqJrTSi835S/CX7r3LUpuwDLVxDBr
         B8EoZkGFqK5g5L5dX4QhbqbayT8svlpgeRP+/OIqlN9fsIk+5AR/2S5Zqa76ofOnly9o
         IozRTgofeZi/FV4dY7FVVD6vxDvGCPc8MTp4o3HECTsO1Mg+KlL0lcM5aM4+op+HG/4a
         88x2rS1NExV7WiYRroFrz0bYGpEtYpcV7B+QQmZF3BMPcBCrIMfOsoRT8aZhrkZjQzGb
         HtqN5KHx/4F21pcWmMctkQ01ZTDp/6B7dZm7uOaeXtD8ru/85EG4eSeZdzSfixbn6Y61
         9Erw==
X-Gm-Message-State: AOJu0YwUDHcJplGq0qNA+51LKV0QyRMTUA4izDuSqBpIqEwH2dW88V+T
        NeXYz2/HVrQWDcaGsEqxGGcdwzbDvViyaH4MdDX6Sg==
X-Google-Smtp-Source: AGHT+IHL5MiHhnfOrGlXbnpKj4kVQi9XXq0Y0EGJ+FxK+XGOaRJbYzS4AhakRm3A1CM2YklVkOxLZS1M56pHfxoySxo=
X-Received: by 2002:a05:6214:f01:b0:63c:913f:2b18 with SMTP id
 gw1-20020a0562140f0100b0063c913f2b18mr16432596qvb.2.1691547030277; Tue, 08
 Aug 2023 19:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072625.2109564-1-nick.hu@sifive.com> <12c1e981-b664-b80c-d0df-7e7a098e32b1@codethink.co.uk>
In-Reply-To: <12c1e981-b664-b80c-d0df-7e7a098e32b1@codethink.co.uk>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Wed, 9 Aug 2023 10:10:19 +0800
Message-ID: <CAKddAkDBQSTf1Z9QDUghmV8GoyuuUYfz+T+rJPoMZ2qtd=TGfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sifive: Add suspend and resume operations
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben



On Tue, Aug 8, 2023 at 4:47=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.uk=
> wrote:
>
> On 08/08/2023 08:26, Nick Hu wrote:
> > If the Sifive Uart is not used as the wake up source, suspend the uart
> > before the system enter the suspend state to prevent it woken up by
> > unexpected uart interrupt. Resume the uart once the system woken up.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> ^ This should be Reviewed-by, as I did review on this earlier.
>
I'll correct it in V2
> > ---
> >   drivers/tty/serial/sifive.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> > index a19db49327e2..87994cb69007 100644
> > --- a/drivers/tty/serial/sifive.c
> > +++ b/drivers/tty/serial/sifive.c
> > @@ -1022,6 +1022,31 @@ static int sifive_serial_remove(struct platform_=
device *dev)
> >       return 0;
> >   }
> >
> > +static int sifive_serial_suspend(struct device *dev)
> > +{
> > +     int ret =3D 0;
> > +     struct sifive_serial_port *ssp =3D dev_get_drvdata(dev);
>
> Minor annyonance is ordering of ssp and ret, I think the showrter one
> last is the nicest looking.
>
> > +     if (ssp && ssp->port.type !=3D PORT_UNKNOWN)
> > +             ret =3D uart_suspend_port(&sifive_serial_uart_driver, &ss=
p->port);
>
> Do we really need a test for ssp being valid if the device is bound.
> Not sure if the port.type is also useful?
>
You are right. This might be an unnecessary check.
The ssp is bound in the probe function and the PORT_UNKNOWN only be
set when we do the sifive_serial_remove().
And for the ordering of ret, We don't need the ret if we move the check.
We can just return uart_suspend_port(&sifive_serial_uart_driver, &ssp->port=
);

Will correct it in V2.
> > +     return ret;
> > +}
> > +
> > +static int sifive_serial_resume(struct device *dev)
> > +{
> > +     int ret =3D 0;
> > +     struct sifive_serial_port *ssp =3D dev_get_drvdata(dev);
> > +
> > +     if (ssp && ssp->port.type !=3D PORT_UNKNOWN)
> > +             ret =3D uart_resume_port(&sifive_serial_uart_driver, &ssp=
->port);
> > +
> > +     return ret;
> > +}
> > +
> > +DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
> > +                      sifive_serial_resume);
> > +
> >   static const struct of_device_id sifive_serial_of_match[] =3D {
> >       { .compatible =3D "sifive,fu540-c000-uart0" },
> >       { .compatible =3D "sifive,uart0" },
> > @@ -1034,6 +1059,7 @@ static struct platform_driver sifive_serial_platf=
orm_driver =3D {
> >       .remove         =3D sifive_serial_remove,
> >       .driver         =3D {
> >               .name   =3D SIFIVE_SERIAL_NAME,
> > +             .pm =3D pm_sleep_ptr(&sifive_uart_pm_ops),
> >               .of_match_table =3D of_match_ptr(sifive_serial_of_match),
> >       },
> >   };
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
>
