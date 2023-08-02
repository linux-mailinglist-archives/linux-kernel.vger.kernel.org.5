Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413DB76D743
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjHBSzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjHBSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:54:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4759126BD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:54:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-407db3e9669so44991cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691002494; x=1691607294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP6AUbuQ4hb9Or4QdvG8nqcEVIonxr5jd7wasq4u8qQ=;
        b=5jUIP39X/Jx3VAY88P+qLpbQeSDGy7+0Zn5EVxl/eDymAtnLF7TKBjGrI6f3sN3kLt
         Fa3NB5IVuMN/UasiWKVupI8/7N2ex3yjLlkzbqFNF8Bsd0aGgZlHIHjU2pMBYpLIQfMu
         UbcUrjfddO0XvnzwUef8L40cAEmcJAD/nRDA/fU4qMZUmoYBkATCdTgv3VkfExSFM0c6
         W9+jgHMk4pyVxXxGl8WrhrG0Mm+BTP95C/lBJb4wqI73iBAYD12Am13LjIcoD5njijsX
         fpqzMuOm495g96PuoQ5K0sGXlE6vIYP62k1vqdtHkfMD+p/hoAxoojZhhQnPSblE/Db1
         QuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002494; x=1691607294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP6AUbuQ4hb9Or4QdvG8nqcEVIonxr5jd7wasq4u8qQ=;
        b=N5lCdPQE2arQRVFvWtEvmCz0AbzmY4nH17cts9Mjzv0shrYrew6F6krxZ38izLCEMc
         /54aHMG2QM9HDxzdUhEWk69UeacxHmGdOcUK1+cE7pZA1g6L3xpQCvrtYJx08P88z1Tk
         QBzbebd+zGHYR1z6x6l3cQuTGtwscDKxguti6nHrokMzST3lsXYi2cwSchIwI9CovCY1
         UD9tS0Z2I9P9T+RsN6C4d38M2P6U8ZuOAeG++E1svkRdMVoVuNi+yOZNGjSankHoDTkD
         FpVvwqbRFO7pWzvq99VB/YWGu6vBo4504SSd2NVXKCwbE6+1iQFca70IwamiumdpxOnW
         wE5Q==
X-Gm-Message-State: ABy/qLZlXJI72E1jGlymIgg9it4jK7kdsYkLve/D64mogVr50CgNyuZq
        ZXVIgOVxb0RdrTXIgrEFip2UbeuJWMSVh9LJpRbx2A==
X-Google-Smtp-Source: APBJJlHKZ+CsaEPZsx3CV6Js57iyo/EFCvUjefGlgik5Dkd1Sll37HUGQd1RJNEtsUrJl1iX/OZCw/vfaLAq6xzy4BQ=
X-Received: by 2002:a05:622a:1006:b0:3f9:ab2c:88b9 with SMTP id
 d6-20020a05622a100600b003f9ab2c88b9mr1436417qte.25.1691002494273; Wed, 02 Aug
 2023 11:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230802175847.1.Ie9fc53b6a1f4c6661c5376286a50e0cf51b3e961@changeid>
In-Reply-To: <20230802175847.1.Ie9fc53b6a1f4c6661c5376286a50e0cf51b3e961@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 2 Aug 2023 11:54:41 -0700
Message-ID: <CABXOdTd0B2YwXkrr6t7Mx-LwOuV+9O9Q91P7M_=8d3iqGQ+=cg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Remove EC panic shutdown timeout
To:     Rob Barnes <robbarnes@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        dtor@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 10:59=E2=80=AFAM Rob Barnes <robbarnes@google.com> w=
rote:
>
> Remove the 1 second timeout applied to hw_protection_shutdown after an
> EC panic. On some platforms this 1 second timeout is insufficient to
> allow the filesystem to fully sync. Independently the EC will force a
> full system reset after a short period. So this backup timeout is
> unnecessary.
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index 500a61b093e47..356572452898d 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -327,8 +327,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle devic=
e, u32 value, void *data)
>                 dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown =
is imminent!");
>                 blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, =
ec_dev);
>                 kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char=
 **)env);
> -               /* Begin orderly shutdown. Force shutdown after 1 second.=
 */
> -               hw_protection_shutdown("CrOS EC Panic", 1000);
> +               /* Begin orderly shutdown. EC will force reset after a sh=
ort period. */
> +               hw_protection_shutdown("CrOS EC Panic", -1);
>                 /* Do not query for other events after a panic is reporte=
d */
>                 return;
>         }
> --
> 2.41.0.585.gd2178a4bd4-goog
>
