Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1ED7FE433
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjK2XlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjK2XlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:41:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC61410C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:41:07 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc79f73e58so31645ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701301267; x=1701906067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAafIotfNLeEwiBYbu95S1M0tQmMdEiW9EUaH/ugkoU=;
        b=U/zRtwo+aQZrG+nwhUiUjVwBkM8E6E7anILz6pLZnjg3APyoMCqXtnjs3EjorKRqEG
         mq+DG/zr2BC83zA+M1FiFfb7nDYv4Y+ae1HlVdYrDp6B+eadXhrrqreb5twL3l4w402f
         ez4U71mypQC0n4seK/fW9eNEicCBJPlz+iOJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701301267; x=1701906067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAafIotfNLeEwiBYbu95S1M0tQmMdEiW9EUaH/ugkoU=;
        b=ZtElmAqc/3AvS1gsPQ0VUh/U19n+gpb6v6WBLMaobTFncznx9AgBx+/fhZEBVxFPpk
         HRthcrRtDs94oYHZPtAo5XoUBOwE6+Ct/tTycp1wzFV6HWbFvCYSuzaIE/Zr5+CKUGzI
         LH66ytTUSoiuW9R92H2q4FoivvclmbLnD/CftfPyS2nD1UBivUD7mEk58JXCZp8lL/e+
         Gw+SbBExhYRWcxx0Xrb4wg9e2HDe6eM2B8tZyvQ/yz4R4nOl3DdfCJ5T+DIUlOu2vmbR
         4dPXH7nxOJktEP1j8CzTqdh87r+PJ3x4BbHljWlQhSFQ5965HqGZE9ZbTtIP+9eveDFe
         emyA==
X-Gm-Message-State: AOJu0YzDKun0BX2preqmbw/9inGGOhMI+BHb+Mmb5Y03J7RFzlvkgYmN
        3pgmCWNByN36HWRhwoXAy7aYO5/7tzTm1QOBEL/tj0uw/OHowiJ9DnfzpA==
X-Google-Smtp-Source: AGHT+IE1XSh+nbdNnRVKnLfSK/CPmIMOuq4e8h34HbM9E0oL/vYe5Unt0pVpjf63jESDwVXLVbmvwh3w0v7G4uQZ93o=
X-Received: by 2002:a17:903:5c5:b0:1cf:c366:9921 with SMTP id
 kf5-20020a17090305c500b001cfc3669921mr32999plb.9.1701301266715; Wed, 29 Nov
 2023 15:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20231129155350.5843-1-hau@realtek.com> <4aeebf95-cf12-4462-80c7-dd1dafddb611@intel.com>
In-Reply-To: <4aeebf95-cf12-4462-80c7-dd1dafddb611@intel.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 29 Nov 2023 15:40:50 -0800
Message-ID: <CANEJEGs9r0vq9QkGTcLryPnviMPgztJDsFjHqnRH65KbCqeF7g@mail.gmail.com>
Subject: Re: [PATCH net v2] r8169: fix rtl8125b PAUSE frames blasting when suspended
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     ChunHao Lin <hau@realtek.com>, hkallweit1@gmail.com,
        nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, grundler@chromium.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 3:05=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> On 11/29/2023 7:53 AM, ChunHao Lin wrote:
> > When FIFO reaches near full state, device will issue pause frame.
> > If pause slot is enabled(set to 1), in this time, device will issue
> > pause frame only once. But if pause slot is disabled(set to 0), device
> > will keep sending pause frames until FIFO reaches near empty state.
> >
> > When pause slot is disabled, if there is no one to handle receive
> > packets, device FIFO will reach near full state and keep sending
> > pause frames. That will impact entire local area network.
> >
> > This issue can be reproduced in Chromebox (not Chromebook) in
> > developer mode running a test image (and v5.10 kernel):
> > 1) ping -f $CHROMEBOX (from workstation on same local network)
> > 2) run "powerd_dbus_suspend" from command line on the $CHROMEBOX
> > 3) ping $ROUTER (wait until ping fails from workstation)
> >
> > Takes about ~20-30 seconds after step 2 for the local network to
> > stop working.
> >
> > Fix this issue by enabling pause slot to only send pause frame once
> > when FIFO reaches near full state.
> >
>
> Makes sense. Avoiding the spam is good.  The naming is a bit confusing
> but I guess that comes from realtek datasheet?

I don't know. It doesn't matter to me what it's called since I don't
have access to the data sheet anyway. :/

> > Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
> > Reported-by: Grant Grundler <grundler@chromium.org>
> > Tested-by: Grant Grundler <grundler@chromium.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: ChunHao Lin <hau@realtek.com>
> > ---
> > v2:
> > - update comment and title.
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 62cabeeb842a..bb787a52bc75 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -196,6 +196,7 @@ enum rtl_registers {
> >                                       /* No threshold before first PCI =
xfer */
> >  #define      RX_FIFO_THRESH                  (7 << RXCFG_FIFO_SHIFT)
> >  #define      RX_EARLY_OFF                    (1 << 11)
> > +#define      RX_PAUSE_SLOT_ON                (1 << 11)       /* 8125b =
and later */
>
> This confuses me though: RX_EARLY_OFF is (1 << 11) as well.. Is that
> from a different set of devices?

Yes, for a different HW version of the device.

> We're writing to the same register
> RxConfig here I think in both cases?

Yes. But to different versions of the HW which use this bit
differently. Ergo the comment about "8125b and later".

> Can you clarify if these are supposed to be the same bit?

Yes, they are the same bit - but different versions of HW use BIT(11)
differently.

>
> >  #define      RXCFG_DMA_SHIFT                 8
> >                                       /* Unlimited maximum PCI burst. *=
/
> >  #define      RX_DMA_BURST                    (7 << RXCFG_DMA_SHIFT)
> > @@ -2306,9 +2307,13 @@ static void rtl_init_rxcfg(struct rtl8169_privat=
e *tp)
> >       case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
> >               RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA=
_BURST | RX_EARLY_OFF);
> >               break;
> > -     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
> > +     case RTL_GIGA_MAC_VER_61:
> >               RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
> >               break;
>
> I assume there isn't a VER_62 between these?

Correct. My clue is this code near the top of this file:

 149         [RTL_GIGA_MAC_VER_61] =3D {"RTL8125A",            FIRMWARE_812=
5A_3},
 150         /* reserve 62 for CFG_METHOD_4 in the vendor driver */
 151         [RTL_GIGA_MAC_VER_63] =3D {"RTL8125B",            FIRMWARE_812=
5B_2},

>
> > +     case RTL_GIGA_MAC_VER_63:
> > +             RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
> > +                     RX_PAUSE_SLOT_ON);
>
> We add RX_PAUSE_SLOT_ON now for RTL_GIGA_MAC_VER_63 in addition. Makes
> sense.

Exactly.

thanks for reviewing!

cheers,
grant

> > +             break;
> >       default:
> >               RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
> >               break;
