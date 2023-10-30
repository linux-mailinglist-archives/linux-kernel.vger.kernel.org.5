Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22BD7DBE43
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjJ3Qwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3Qwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:52:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4414B3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:52:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so489a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698684757; x=1699289557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/BSsNWLspfthFQHwJtcXo2ADTyt8+cC4m6Msvhwdq4=;
        b=RmKSY1ex/z57HODjZlgWtUPt/mxKQbwD1EL/6r4UfBsrrT/QPdqYXOa8Ejw/uvPx/8
         LkjYdaWaP85xaCHnWmBWEfs+zGitrFdX4faCefuzYWYwkuluY7R7Pce8VcFbN3GhZ8eb
         LIv/n0DtluzSoDbg+9E1dlUuokdpbQrYIorPJ91qFnywciAJGUL+Px1Q2XZ0aLCUYmBR
         ZhBKncA9AWNUeqL2viiwDCttI3ZyIxv2FxzBU6saYExW69XaTeEGsOslPJzLdAPJa3YH
         MjzCOFr4HUhe2Lvl7ixs1un8F2MYAxJ7oIcIjbTZiqLbHRajmrK41vIqCFdlIWx2w/k8
         6fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698684757; x=1699289557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/BSsNWLspfthFQHwJtcXo2ADTyt8+cC4m6Msvhwdq4=;
        b=iVXv6iW+m/5MyPmbYzoSk12weZxjm5Ji40O5V+/KGUuAM1pE1n8/ZsSEG5IgaseD3T
         a5n772pJ7bbBQEw4Jq5r1sbhhJuWao8Az4SsjATHdIDnzEvl5fvQYUibCJlExVflftzI
         JOoOJ+XbdpT5Th1UCiCOCRhBW0g7MGle+Ib4Rtas8g2ehH0R5MYlfoAONKy0cMbS0hqU
         rnslZNHM9XGb+TKyfJsex7L4zjx4MVIxKYMkpcVsZ/ApAIz1Ufe9E2SiRJ1196Hx4JRp
         o00kYKfwuW+shJ2Gg6ALp8BJI6bhKqfxh8WMrVqiDI8z5+u1nhYt3CXyJi4MTKldJpNx
         PNaw==
X-Gm-Message-State: AOJu0YxFP2kVxX8fR3CROc+Evctr8r5VkUdf6Gumu/Jqr/ZP6yLD1pla
        Pd073NBhIX7Y+hAAThEoiWmhd/C3hL//5yX7SH0tpQ==
X-Google-Smtp-Source: AGHT+IF65SluPCi/VLGKwqVMoN830lGi2osimZ14H4dVF5gzTbHCeUGKZxc+REGpx/dAte8oKZK5ztGUNEnyr9Ekavg=
X-Received: by 2002:a05:6402:1a56:b0:543:5119:2853 with SMTP id
 bf22-20020a0564021a5600b0054351192853mr61455edb.6.1698684756998; Mon, 30 Oct
 2023 09:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231027213059.3550747-1-ptf@google.com> <415e0355-7d71-4b82-b4fc-37dad22486a9@gmail.com>
In-Reply-To: <415e0355-7d71-4b82-b4fc-37dad22486a9@gmail.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Mon, 30 Oct 2023 12:52:24 -0400
Message-ID: <CAJs+hrEi8oo1q5mMfNbaUi8x1H-sBGmYToTkRfVXs=ga9LPupQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wouldn't trust the mc filter, the eap packet being filtered is not a
multicast packet so I wonder what else could be erroneously filtered.
I do agree that it would be nice to be able to override it for testing
purposes.

Would you like me to add MAC_VER_48 to the patch? I would not be able
to test and confirm that it affects it in the same way I have for
VER_46.

It is unfortunate that the naming doesn't quite line up.

On Sat, Oct 28, 2023 at 4:38=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 27.10.2023 23:30, Patrick Thompson wrote:
> > MAC_VER_46 ethernet adapters fail to detect eapol packets unless
> > allmulti is enabled. Add exception for VER_46 in the same way VER_35
> > has an exception.
> >
> MAC_VER_48 (RTL8107E) has the same MAC, just a different PHY.
> So I would expect that the same quirk is needed for MAC_VER_48.
>
> MAC_VER_xx is a little misleading, actually it should be NIC_VER_xx
>
> > Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> > Signed-off-by: Patrick Thompson <ptf@google.com>
> > ---
> >
> > Changes in v2:
> > - add Fixes tag
> > - add net annotation
> > - update description
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 361b90007148b..a775090650e3a 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *de=
v)
> >               rx_mode |=3D AcceptAllPhys;
> >       } else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
> >                  dev->flags & IFF_ALLMULTI ||
> > -                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35) {
> > +                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35 ||
> > +                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_46) {
> >               /* accept all multicasts */
> >       } else if (netdev_mc_empty(dev)) {
> >               rx_mode &=3D ~AcceptMulticast;
>
