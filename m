Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7E7FAB87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjK0UaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjK0U3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:29:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D291BD0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:28:32 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc79f73e58so832285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701116912; x=1701721712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5+LvDr2MpWna/CQNtxbOeulzzg8qdiriAAeLwiRcQk=;
        b=OLIfQE55f9sLqJ7pV9I5G00HvBBOdCoHRbBM5WYN3klE1oRxswvyYwc5zQ8mwwMn5M
         Vlx6fP5z5Lk0SwNHAMXq8T1JYGTNr4SnfmNyQntd10xM5tBoClkDDazHkM8CZa5FUDHo
         FFrdCM32s36EUUcTcZiGigYvjKs1A61hL2WI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116912; x=1701721712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5+LvDr2MpWna/CQNtxbOeulzzg8qdiriAAeLwiRcQk=;
        b=osqWNtXWz2aRLTxitv92qNE6bfAhunEDVDuF/bGjQnfUaRN7s7HubMwJA3vRGxdcyn
         /RjLVddkst7T9C0OYnAG+Vft7OUYTJpht5nhv0VCbDVREpdqKoGYyI95GXZcgCA/Giu/
         PCNdAZUF8QBIIpFaw652stxOt5xV8GP261ljPcQ9L5JkH9JKWgnLiu4lZ3xP4lw2d8fF
         KlGZs+gFzunX6BljWYKw6Iu/GId1uFOutCICcHLNdBdPuJZPT24V3Oy1dbMpAyq06H7q
         VSA3WqELXR3bENiyC1kVamSn6AAs7UccVj3ouf/8Sj5pZfr9DDdTWLNu8A2IGj0shrFU
         6RJg==
X-Gm-Message-State: AOJu0YygirafcEmGqPOQD0jkyHQF3DTh0nWIhXlIwNJkoGXnOOLlx6yK
        agztEn30XByeQ1mTTzaVFt2lt5G+q3v9e/vl6NhubQ==
X-Google-Smtp-Source: AGHT+IGLQQUkLIQlrE1cQRRNrLITzOJTPYT2iEhTFWC1VzJ4c69+VDRcvNaay6jRLYhoDwDQCZ7qG+pSOvFQD3jDafc=
X-Received: by 2002:a17:902:d2d1:b0:1cf:d21a:ebcc with SMTP id
 n17-20020a170902d2d100b001cfd21aebccmr265559plc.23.1701116912069; Mon, 27 Nov
 2023 12:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20231127175736.5738-1-hau@realtek.com> <20231127175736.5738-2-hau@realtek.com>
 <a5f89071-f93b-4a30-a0c5-f9dfda68367c@gmail.com>
In-Reply-To: <a5f89071-f93b-4a30-a0c5-f9dfda68367c@gmail.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Mon, 27 Nov 2023 12:28:21 -0800
Message-ID: <CANEJEGtRk85senQ3fVhV9Ek9U+Pf5NER0_gBexHEkMaUz+vDgg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] r8169: enable rtl8125b pause slot
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, grundler@chromium.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:03=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> On 27.11.2023 18:57, ChunHao Lin wrote:
> > When FIFO reach near full state, device will issue pause frame.
> > If pause slot is enabled(set to 1), in this time, device will issue
> > pause frame once. But if pause slot is disabled(set to 0), device
> > will keep sending pause frames until FIFO reach near empty state.
> >
> > When pause slot is disabled, if there is no one to handle receive
> > packets (ex. unexpected shutdown), device FIFO will reach near full
> > state and keep sending pause frames. That will impact entire local
> > area network.

The comment is correct but should mention that this is true after a
suspend. In other words, when an idle device goes into a lower power
state, eventually the NIC will start blasting PAUSE frames on the
local network.

I was able to reproduce the problem very easily with a recent
Chromebox (not Chromebook) in developer mode running a test image (and
v5.10 kernel):
1) ping -f $CHROMEBOX (from workstation on same local network)
2) run "powerd_dbus_suspend" from command line on the $CHROMEBOX
3) ping $ROUTER (wait until ping fails from workstation)

Takes about ~20-30 seconds after step 2 for the local network to stop worki=
ng.
At that point, tcpdump from the workstation is full of PAUSE frames.

I did not check that WOL still works.

The exact patches I used on chromeos-5.10 kernel branch are publicly
visible here:
    https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/5056381

> > In this patch default enable pause slot to prevent this kind of
> > situation.
> >
> Can this change have any side effect? I'm asking because apparently
> the hw engineers had a reason to make the behavior configurable.
>
> > Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: ChunHao Lin <hau@realtek.com>

Tested-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromiuim.org>

(adding my reviewed-by to indicate I think the code is fine... I
appreciate Heiner asking for better comments though.)

cheers,
grant

> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 295366a85c63..473b3245754f 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -196,6 +196,7 @@ enum rtl_registers {
> >                                       /* No threshold before first PCI =
xfer */
> >  #define      RX_FIFO_THRESH                  (7 << RXCFG_FIFO_SHIFT)
> >  #define      RX_EARLY_OFF                    (1 << 11)
> > +#define      RX_PAUSE_SLOT_ON                (1 << 11)
>
> Depending on the chip version this bit has different meanings. Therefore =
it
> would be good to add a comment that RX_PAUSE_SLOT_ON is specific to RTL81=
25B.
>
> >  #define      RXCFG_DMA_SHIFT                 8
> >                                       /* Unlimited maximum PCI burst. *=
/
> >  #define      RX_DMA_BURST                    (7 << RXCFG_DMA_SHIFT)
> > @@ -2305,9 +2306,13 @@ static void rtl_init_rxcfg(struct rtl8169_privat=
e *tp)
> >       case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
> >               RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA=
_BURST | RX_EARLY_OFF);
> >               break;
> > -     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
> > +     case RTL_GIGA_MAC_VER_61:
> >               RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
> >               break;
> > +     case RTL_GIGA_MAC_VER_63:
> > +             RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
> > +                     RX_PAUSE_SLOT_ON);
> > +             break;
> >       default:
> >               RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
> >               break;
>
