Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA07D1DC4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjJUPDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJUPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:03:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47420E7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:03:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso122685ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697900613; x=1698505413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuPSmAl7Gc08Rh/pvJ8sfj5/IRqjGMuojTRoU/8OXYE=;
        b=QNlNBCBoy05xt0KD1KD48HNlwcuASk5aj32NtGTPpc15s/53yLCT3H/+qOymWQdT8e
         /aeIe0PiyL0Ik9lD/65yusPh6GjlnGe0llonlYvpXBQMS902bcHdcY+FZltZbqQAU+n7
         veCP4VjbZ4C/ym9Ud5QlUcb6xgRfNSPYp9sn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697900613; x=1698505413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuPSmAl7Gc08Rh/pvJ8sfj5/IRqjGMuojTRoU/8OXYE=;
        b=T5cANOQdewgLnWwuzBbEg1UiPnbEZNhnVYFxgotVZdy7w3ykQ2NbhRCe4ggRQXFa5h
         CN100gfOu6Q+bEOey8Jjj7pkEDz2N6DNl9RrmEuHcc+Rw5UXHp0DP4PxaWxBueFNgOXR
         o+4SziItibyM+HsRe07efKdmN/5eTb/zCF/9JAQdFEqA3wI+g4az1qFlqBeEmHz8CbYC
         DsadpJYVePwhVZoIBIr/DFUIv0oqsGCYzaC1s8KpD4aVVxhjybREavLgYCcmr/ev0R6x
         56QISgl7bIxUvgNAHR0/m9Olm9IIj4gPyJ273tAzEdnDBJRmFniB9QdrFJDWyaRPpNdv
         Z2Qg==
X-Gm-Message-State: AOJu0YyKOmBZKzwxOnvMFbCrB4FMzcpLC613by5L+RuFU6l9igztr5X2
        F3MA36C1dZvdqpzuyrFQn4Eq2kThaO6/2CMyXz9gGA==
X-Google-Smtp-Source: AGHT+IEUrjQpbqzmBCjf5tVoCSi89bnrApkE030h0X34HlZN2zt0Z3EiPkzND/i5smqKbYe58V947QrGj8SmVsPevu8=
X-Received: by 2002:a17:902:d551:b0:1c7:47ca:f075 with SMTP id
 z17-20020a170902d55100b001c747caf075mr408500plf.15.1697900612332; Sat, 21 Oct
 2023 08:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.5.I300ed6c3269c77756bdd10dd0d6f97db85470186@changeid>
In-Reply-To: <20231020140655.v5.5.I300ed6c3269c77756bdd10dd0d6f97db85470186@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Sat, 21 Oct 2023 08:03:21 -0700
Message-ID: <CANEJEGsrJvss-MGfGwV+M5kgTokrF+HX_nZb+ASoEKuUKV7gGg@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] r8152: Check for unplug in rtl_phy_patch_request()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> If the adapter is unplugged while we're looping in
> rtl_phy_patch_request() we could end up looping for 10 seconds (2 ms *
> 5000 loops). Add code similar to what's done in other places in the
> driver to check for unplug and bail.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> (no changes since v2)
>
> Changes in v2:
> - ("Check for unplug in rtl_phy_patch_request()") new for v2.
>
>  drivers/net/usb/r8152.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 656fe90734fc..9888bc43e903 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -4046,6 +4046,9 @@ static int rtl_phy_patch_request(struct r8152 *tp, =
bool request, bool wait)
>         for (i =3D 0; wait && i < 5000; i++) {
>                 u32 ocp_data;
>
> +               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +                       break;
> +
>                 usleep_range(1000, 2000);
>                 ocp_data =3D ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
>                 if ((ocp_data & PATCH_READY) ^ check)
> --
> 2.42.0.758.gaed0368e0e-goog
>
