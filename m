Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE5E7E2769
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjKFOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjKFOo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:44:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB211BB;
        Mon,  6 Nov 2023 06:44:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-280cc5f3fdcso4303914a91.1;
        Mon, 06 Nov 2023 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699281893; x=1699886693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPxhZe6vheeUn9vFdJuJshoNGBm7JfADyEER9bOti4A=;
        b=eWkzxDLePggVfrSIeVrPKHW8Z3VUmjPJ6X85BcHCVu8NUXUDp8jUicpN+HvwKyGlaa
         2rIvvLACk2VVQtnzPE/l9yh+4eZ+wP9/fR+vP/egGwk+bWq7TxnmQ6Y9ckI26KvL9YRl
         yeeBsC5cQK4tyq5LqyGlMGZpJ0Y4PwzuVPH1w6kgK71t1qptbSc2TqmEUN1BaNglsy8X
         EV+3LZ4Oy9CgUmudQeSh6GWuwaINc24CBkPHbn1IrczuiUQBtQW6UUTQs2R/9svRAvu2
         8GB5L+vNgKZjCH0O86CLBdS5VQuGhEmbgxLwkq/ILjnoEBDNIY4DUI1eLwccuYFOOvec
         DqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281893; x=1699886693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPxhZe6vheeUn9vFdJuJshoNGBm7JfADyEER9bOti4A=;
        b=nKPluLRa9vrSK9zhR/4ITcKEVRyMBHzzQy5ArH0cnTspQ2h/dp2TVnr4Pt75gH0auj
         k4h1IaoI+QrqHYqRrD+FkHFPu54zspGOqzwtcxnGKaEbw+skIV1/YG/S4BHe40K1OXPM
         XRqXHsCVvkIH7yNZKA3XB8t1ouKDmFmcDHNy2anloVjcr559faluRbKYxeQnhXKa/Zh1
         ZSVyNAx9HcIPNe1jf9fQsYWluU8C512euizT6inbgmq/8myAid8uMrSKQPwwoKOvuwZw
         FeGKwxbRphGu5qKhmOus1yhsztDq2M7IjFZuZ39HAIrM5FRkjnaGjM0Cb/gaQDg+vpsN
         NHCQ==
X-Gm-Message-State: AOJu0YwfDStL406LU3VQaz39DHz/Xa9+K4jQKcWa5rU8/tYoxqBScUV3
        MM4C8JzodvE0qPou/eO0LkhZJIEiiOnr0KN7QP0=
X-Google-Smtp-Source: AGHT+IFak4d2x8lFD6pdfnTjj6PNYc0bk+F3F4X0O069zU3I6Su0oqAPEi9rf4SwI8QSR0/KkjZY6OEORErroicvkNU=
X-Received: by 2002:a17:90b:3b44:b0:280:cd49:2548 with SMTP id
 ot4-20020a17090b3b4400b00280cd492548mr11349917pjb.6.1699281892947; Mon, 06
 Nov 2023 06:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20231106141704.866455-1-zyytlz.wz@163.com> <87o7g7ueom.fsf@kernel.org>
In-Reply-To: <87o7g7ueom.fsf@kernel.org>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 6 Nov 2023 22:44:41 +0800
Message-ID: <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, aspriel@gmail.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        johannes.berg@intel.com, marcan@marcan.st,
        linus.walleij@linaro.org, jisoo.jang@yonsei.ac.kr,
        linuxlovemin@yonsei.ac.kr, wataru.gohda@cypress.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, arend.vanspriel@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        security@kernel.org, stable@vger.kernel.org
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

Thanks! I didn't test it for I don't have a device. Very appreciated
if anyone could help with that.

Kalle Valo <kvalo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=80 22:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Zheng Wang <zyytlz.wz@163.com> writes:
>
> > This is the candidate patch of CVE-2023-47233 :
> > https://nvd.nist.gov/vuln/detail/CVE-2023-47233
> >
> > In brcm80211 driver,it starts with the following invoking chain
> > to start init a timeout worker:
> >
> > ->brcmf_usb_probe
> >   ->brcmf_usb_probe_cb
> >     ->brcmf_attach
> >       ->brcmf_bus_started
> >         ->brcmf_cfg80211_attach
> >           ->wl_init_priv
> >             ->brcmf_init_escan
> >               ->INIT_WORK(&cfg->escan_timeout_work,
> >                 brcmf_cfg80211_escan_timeout_worker);
> >
> > If we disconnect the USB by hotplug, it will call
> > brcmf_usb_disconnect to make cleanup. The invoking chain is :
> >
> > brcmf_usb_disconnect
> >   ->brcmf_usb_disconnect_cb
> >     ->brcmf_detach
> >       ->brcmf_cfg80211_detach
> >         ->kfree(cfg);
> >
> > While the timeout woker may still be running. This will cause
> > a use-after-free bug on cfg in brcmf_cfg80211_escan_timeout_worker.
> >
> > Fix it by deleting the timer and canceling the worker in
> > brcmf_cfg80211_detach.
> >
> > Fixes: e756af5b30b0 ("brcmfmac: add e-scan support.")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Cc: stable@vger.kernel.org
> > ---
> > v5:
> > - replace del_timer_sync with timer_shutdown_sync suggested by
> > Arend and Takashi
> > v4:
> > - rename the subject and add CVE number as Ping-Ke Shih suggested
> > v3:
> > - rename the subject as Johannes suggested
> > v2:
> > - fix the error of kernel test bot reported
> > ---
> >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.=
c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > index 667462369a32..a8723a61c9e4 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > @@ -8431,6 +8431,8 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_=
info *cfg)
> >       if (!cfg)
> >               return;
> >
> > +     timer_shutdown_sync(&cfg->escan_timeout);
> > +     cancel_work_sync(&cfg->escan_timeout_work);
> >       brcmf_pno_detach(cfg);
> >       brcmf_btcoex_detach(cfg);
> >       wiphy_unregister(cfg->wiphy);
>
> Has anyone tested this on a real device? As v1 didn't even compile I am
> very cautious:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20231104054709.=
716585-1-zyytlz.wz@163.com/
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
