Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BAC7D1DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjJUPCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjJUPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:02:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341C9E7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:02:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9c496c114so118145ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697900531; x=1698505331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v632NyyyfUP7uNKA1gCSbOgDbWOBBu1PYAKFjKlYN5A=;
        b=bX8TV3Rl+A5C2DLIwB/tLM+WmFc1DYz4fpr81UK3b4wKIXG4RIxbB8l8EfEB/OJAvU
         3Zm9SVugEYZF60FQEGz4wO1/31igGhLB3aUdhzaw+5Wgqm1H4kKp0d7QOylao9LbwCI/
         FFzzjRRNCSkj7XzHJ1/D3reXvlOWQvqR18Kcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697900531; x=1698505331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v632NyyyfUP7uNKA1gCSbOgDbWOBBu1PYAKFjKlYN5A=;
        b=j+anhcngrU10dKsPD5TjUac32AYI6R14ymxNcaCDXZgAAh+7TDVA8RVe/2nKn9sk1u
         IAybHtDHlzFk/uqBQ39DYmcqxXPSx8Cji9MkPyKKLKP6Fur1AEfEtNXDJW5ZO5m9geox
         zvSYDlERC80tFU67yMLAPtMULQIntbPxw3Tsf8vQF6z6jcZVJa76BszAJBgbflJKolMh
         g6zepgixYyOnn6+WFivrhoE73Y6FvqCnjcM/z0JFTmiWbs6s+HJlaIOxVtvi5Zh4geN7
         FXDnehu57xA0aeEEbeDPcDhsPSQ+nY7Okpdia6239BRBcFI+m/RDUgts4qJYp4bvh1j3
         osfw==
X-Gm-Message-State: AOJu0YzLW3Y0l1XWc6tlWvO5DLHS+mvR68raXbH6TLw0ytnIN/CGuue0
        zoQyvmgaWVpCIkX8DHp/VXBdWPP586goISl/24qUoA==
X-Google-Smtp-Source: AGHT+IGQEYY5fHfxWtQQzUCGwA0rZbif4bEKqr/BunucKyMALe/6gqi3yossh11tQ+2fyZqnOiYONpjQkLnUt3FtrUs=
X-Received: by 2002:a17:902:eb8f:b0:1b8:9551:de55 with SMTP id
 q15-20020a170902eb8f00b001b89551de55mr385745plg.26.1697900530966; Sat, 21 Oct
 2023 08:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.4.I5cd5dd190df0826e38444df217f63918a8b4ad39@changeid>
In-Reply-To: <20231020140655.v5.4.I5cd5dd190df0826e38444df217f63918a8b4ad39@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Sat, 21 Oct 2023 08:01:59 -0700
Message-ID: <CANEJEGsFOy9urtoBtDQ8LEJo3uVROg27KKwaKb5fCPYO_nTfaA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] r8152: Release firmware if we have an error in probe
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
        Paolo Abeni <pabeni@redhat.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
> The error handling in rtl8152_probe() is missing a call to release
> firmware. Add it in to match what's in the cleanup code in
> rtl8152_disconnect().
>
> Fixes: 9370f2d05a2a ("r8152: support request_firmware for RTL8153")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> Changes in v5:
> - ("Release firmware if we have an error in probe") new for v5.
>
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index d10b0886b652..656fe90734fc 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9786,6 +9786,7 @@ static int rtl8152_probe(struct usb_interface *intf=
,
>         cancel_delayed_work_sync(&tp->hw_phy_work);
>         if (tp->rtl_ops.unload)
>                 tp->rtl_ops.unload(tp);
> +       rtl8152_release_firmware(tp);
>         usb_set_intfdata(intf, NULL);
>  out:
>         free_netdev(netdev);
> --
> 2.42.0.758.gaed0368e0e-goog
>
