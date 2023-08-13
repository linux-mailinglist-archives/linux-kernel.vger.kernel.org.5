Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC377A4ED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 06:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHMEYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 00:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjHMEYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 00:24:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC991709
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 21:24:33 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3491a8e6fd1so14992525ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 21:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1691900673; x=1692505473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qevkSkg5mvcMaovBYkMD/RWuGnxNRjpv07SdmrCu5Rs=;
        b=Hk8gdd1K6uj8xXjs+H7nfnTVUCr8mBs9r/vQhymMmLBSn6C7KVYyBhnVb0xatyAVt9
         EvlGzP60aJmmMvs/BXJYh6xFPQNZTY5HrcJCzVSzyMX8lHvlCnRYuvPCuyqa1xw4tWHM
         M3fVaZX7k4KeHowb2kIWcmE+2fFG36QlE+1hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691900673; x=1692505473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qevkSkg5mvcMaovBYkMD/RWuGnxNRjpv07SdmrCu5Rs=;
        b=Jp5RtB+Wtj29nW/5Qoet2WTciO63y2Vhu2ijnB5ifd1El309hCUNhH/4hoyr3ehJYO
         rOAEL3Dp05rGnFl6mrmcI3Q5ZoFERJmkOntqeMT38W8AlsHFPMp+/WApDDOXBECEyU0L
         Kl81AOXU530y0BnIAlITyoSOXd0OOft82VebNdwGcx4AI7LvO4qSE1dhue0lHaM89ZFT
         azLwzUgcT4e3nPP3LTBVrZ8yNdBs97At3tvelv9wTjPL4ElSvkJHql52aySPKWRaIGfR
         np/byDDKl7QTKoJONLia2CeSNyDuTyrb1uuazDsbaW/7NBVjT5COzGpkaflm2SflBsgO
         i0Jg==
X-Gm-Message-State: AOJu0Yz3zw3P5QXFx7S7hY4jO6nnOwbuAEf97bqJLBIaGHSNIY2d0nax
        jITLYNmRV+oDJlXnRVNqStbvn4zvUGyFrEHw3eLbZg==
X-Google-Smtp-Source: AGHT+IEyVCPxo86JO2UzAZ740JJ4NBGw2gfhoJtkdcGaQPTrx0YcdgyQlQF/U4GXjA2yLOrm88Tk5ZIIfLdemSldZmA=
X-Received: by 2002:a05:6e02:b2f:b0:348:8ebc:835d with SMTP id
 e15-20020a056e020b2f00b003488ebc835dmr9475376ilu.8.1691900672937; Sat, 12 Aug
 2023 21:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <1691792050-25042-1-git-send-email-justin.chen@broadcom.com> <2023081221-truth-footsie-b5ab@gregkh>
In-Reply-To: <2023081221-truth-footsie-b5ab@gregkh>
From:   Justin Chen <justin.chen@broadcom.com>
Date:   Sat, 12 Aug 2023 21:24:21 -0700
Message-ID: <CALSSxFZyQCCupuXC7=z3yoO7xhVY3Grw_zFsdWKrE+txk9-S1Q@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_bcm7271: improve bcm7271 8250 port
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, opendmb@gmail.com,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009e51150602c652ac"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009e51150602c652ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2023 at 3:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 11, 2023 at 03:14:01PM -0700, Justin Chen wrote:
> > The 8250 bcm7271 UART is not a direct match to PORT_16550A. The
> > Fifo is 32 and rxtrig values are {1, 8, 16, 30}. Create a PORT_BCM7271
> > to better capture the HW CAPS.
> >
> > Default the rxtrig level to 8.
> >
> > Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> > ---
> >  drivers/tty/serial/8250/8250_bcm7271.c | 4 +---
> >  drivers/tty/serial/8250/8250_port.c    | 8 ++++++++
> >  include/uapi/linux/serial_core.h       | 3 +++
> >  3 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/seria=
l/8250/8250_bcm7271.c
> > index d4b05d7ad9e8..aa5aff046756 100644
> > --- a/drivers/tty/serial/8250/8250_bcm7271.c
> > +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> > @@ -1042,7 +1042,7 @@ static int brcmuart_probe(struct platform_device =
*pdev)
> >       dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not =
");
> >
> >       memset(&up, 0, sizeof(up));
> > -     up.port.type =3D PORT_16550A;
> > +     up.port.type =3D PORT_BCM7271;
> >       up.port.uartclk =3D clk_rate;
> >       up.port.dev =3D dev;
> >       up.port.mapbase =3D mapbase;
> > @@ -1056,8 +1056,6 @@ static int brcmuart_probe(struct platform_device =
*pdev)
> >               | UPF_FIXED_PORT | UPF_FIXED_TYPE;
> >       up.port.dev =3D dev;
> >       up.port.private_data =3D priv;
> > -     up.capabilities =3D UART_CAP_FIFO | UART_CAP_AFE;
> > -     up.port.fifosize =3D 32;
> >
> >       /* Check for a fixed line number */
> >       ret =3D of_alias_get_id(np, "serial");
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 16aeb1420137..a6259a264041 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -322,6 +322,14 @@ static const struct serial8250_config uart_config[=
] =3D {
> >               .rxtrig_bytes   =3D {2, 66, 130, 194},
> >               .flags          =3D UART_CAP_FIFO,
> >       },
> > +     [PORT_BCM7271] =3D {
> > +             .name           =3D "bcm7271_uart",
> > +             .fifo_size      =3D 32,
> > +             .tx_loadsz      =3D 32,
> > +             .fcr            =3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRI=
G_01,
> > +             .rxtrig_bytes   =3D {1, 8, 16, 30},
> > +             .flags          =3D UART_CAP_FIFO | UART_CAP_AFE
> > +     },
> >  };
> >
> >  /* Uart divisor latch read */
> > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/seri=
al_core.h
> > index 281fa286555c..369f845a3d1d 100644
> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -279,4 +279,7 @@
> >  /* Sunplus UART */
> >  #define PORT_SUNPLUS 123
> >
> > +/* Broadcom 7271 UART */
> > +#define PORT_BCM7271    124
>
> Why is this new id required?  What in userspace is going to use it and
> why can't the generic value be used instead?
>

I couldn't find a generic port that matches our FIFO size and
rxtrig_bytes. That is why I created a new one. Userspace currently
misreports what the rxtrig level is.

Thanks,
Justin

> thanks,
>
> greg k-h

--0000000000009e51150602c652ac
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILJHpi9qpF0VHMaM7F+glXRgHW3e8c1hkm7c
Rm1AXG/2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgxMzA0
MjQzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQDDPjU9Ml5+2XwRMlwmmyfMGnfYiyfY9dI8ft1x97c8O9M6DogzDQLy
jCvIMRhBYmgCi5hPyIiexY5PpW8A0N7QB/dtWJkj4ZBIO2VQ49GNKDY2EabbUTWIYhaCF9Rky9X2
ner6CAyoMzlG+N6R2kKQxVj8spikzulELvJWkcVsjBUSnGO/sDzsX2yVYgAOW4Kl/Pnbvqyl7OfX
k/HStR6KyyBC0UFjudchAf///RhWL5ZCLr8Qe3cG9WmmmimE0QhFaLyRCpxScil8Pd0/YLy5noYO
8PwFZgP1bkO0hkghASzuI2e5RZakwqM9Mg0f3OXo3GllZpMbSN2JGqM0No4n
--0000000000009e51150602c652ac--
