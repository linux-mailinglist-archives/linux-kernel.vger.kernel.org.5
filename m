Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C877D1DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjJUOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJUOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:52:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C025DD79
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:52:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9c496c114so117665ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697899965; x=1698504765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HsFB5tlx9FQRvIXi6ryYvjnX1UG/8hzi6eFKlM5SgY=;
        b=LbExNEax0RbR/RB6vlWzYAzyWLKDtTpdayRjZQ24DPrIjQHtHx2CbqIiIlDOVCuPr+
         Vop6VHLWqCvg/ECCh7yzbQAQhTDCq/EQys13IslhETuAitq9YHbASsECoM3HJmVZ82UP
         1HnLsKBprvitDk0GRp2OCI6nfnvsxIXWjpToY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697899965; x=1698504765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HsFB5tlx9FQRvIXi6ryYvjnX1UG/8hzi6eFKlM5SgY=;
        b=xOTSgM5zosOZmG9kX3nucbVzGaCqJnEKSn1OvlOpdkJ6JLeQ/wucEI4BFzVDFs0DRg
         5ZCuu580/2BtrKSmUgzG4br1TtnY8G3PpE320vKeUUm8atq+kpkKkKfIGAeYxSFIh/zZ
         Cxh4yyBT1R6avza4vBGB+57FKCLVUIc6qp5JQtJguGnKcIZ2lt+i5btefO5m4qXBH/6F
         slxEr4OU4WoJFMZ+/8hsAG9IsUrGsijSI1Ym+jWOC5Fqj52nys5918j4ud/olxSulXfq
         cvOe2InnlqqwEipzHrL8TaT6a4e5Va9NSdci+NNKvOMZ43SbBfIXqKW91LmlnriDaimq
         7x7w==
X-Gm-Message-State: AOJu0Yz5sAuhB5FdV2FSgU5Vr8EBBGvKCxAwptzapMoFaCbLfVhjZuWj
        k91d7RMvbP+3Wf5L/iGXdf92tr0LioBW6s839hVJNQ==
X-Google-Smtp-Source: AGHT+IHubZ+DRcpnIydaHeTMIC0WTzLW0aG0Ilm3AeFdLRSeiPMxSatpnwZZ4BjeimzRga4YfBDoS6n13h4SC3fNUAk=
X-Received: by 2002:a17:902:f70d:b0:1c9:c480:1797 with SMTP id
 h13-20020a170902f70d00b001c9c4801797mr383011plo.11.1697899964770; Sat, 21 Oct
 2023 07:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.3.I33c8decabd2e77c37524db02b4e6b9b4dbc3a8d6@changeid>
In-Reply-To: <20231020140655.v5.3.I33c8decabd2e77c37524db02b4e6b9b4dbc3a8d6@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Sat, 21 Oct 2023 07:52:33 -0700
Message-ID: <CANEJEGsdm5XokPmYgMm4NXFx0eoLdYAfgx+W88jeox337cNRbg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] r8152: Cancel hw_phy_work if we have an error in probe
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
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> The error handling in rtl8152_probe() is missing a call to cancel the
> hw_phy_work. Add it in to match what's in the cleanup code in
> rtl8152_disconnect().

Sounds like there is a future opportunity for someone (not Doug) to
refactor code.

> Fixes: a028a9e003f2 ("r8152: move the settings of PHY to a work queue")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> Changes in v5:
> - ("Cancel hw_phy_work if we have an error in probe") new for v5.
>
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 201c688e3e3f..d10b0886b652 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9783,6 +9783,7 @@ static int rtl8152_probe(struct usb_interface *intf=
,
>
>  out1:
>         tasklet_kill(&tp->tx_tl);
> +       cancel_delayed_work_sync(&tp->hw_phy_work);
>         if (tp->rtl_ops.unload)
>                 tp->rtl_ops.unload(tp);
>         usb_set_intfdata(intf, NULL);
> --
> 2.42.0.758.gaed0368e0e-goog
>
