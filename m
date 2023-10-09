Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA037BD40E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345360AbjJIHJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjJIHJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:09:05 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15355A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:09:04 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49dc95be894so1389679e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696835343; x=1697440143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDogVcerh+G9iofbW967gGcNtdTdhsym4LkTtBiowNc=;
        b=iZ8p4cYSAetGuyEk3iYhhyloEGwNfAB9YMEggd0ZBywHYU4XstiTAB5c1TlVqjIyTv
         jLLsIvW7WkIW7u+IsARrriZRmwFVAkUtgla2RrhCE1HlGtJqjumhsAS0/BD2Z3T/HvE6
         V/+rGKNl5FISLZyIYxvNBW+UtadT+Q4w3R3PcZEO6YMwc3n8R5P4j0WUR8JB/fMBYYDx
         D7erTlfWa4VxyumAmEAdWjVlaZgajpXP1Zkje/9OOlGr03lBIoGHBtjm8XBZKVBbrK9T
         MvM/Cd8QJTGLf4St3cYj/JLOZaPZeTaVdfHCyGlfhLenVPoA7331rElza/c8Smagwzyp
         b4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696835343; x=1697440143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDogVcerh+G9iofbW967gGcNtdTdhsym4LkTtBiowNc=;
        b=exKJ0faLF/fmA+eho2G15L6KsEhcUND2xIwHsiyixrcbXb5YQNliW9VqX54Q4MthLg
         AXYNGcP85ovDjspR2aODwlpPHi64iHNjOLYpkMuLRr/KddLCzlnViEROXIJqZj8CesLF
         tRmKB6WHmqfh7kQcMz4YCQOU5xeqlNecyqvhD0GTsQoniMSKxTI2NsAmbngyby77Vg2f
         DTg+eIGTvIubTrANJWo/THjNToEXz+Yp2D0FpbMg3bfKgh0Icf/XWDcRZACWTqas1Wv4
         QwU00BdKd2its4MC9I+ki2RtuX6bJP/ggQYzR+k46zo7PMt/oR/k/5uDcGNvJ2Oq7UZB
         4ZDQ==
X-Gm-Message-State: AOJu0YyKAEXDfGkO3CUtMswtBqpd2Ra1aJZmkvmAjp0FuZgl4VeunSxB
        74wMF4UyzMTewRBLHuLM2FKtLAKxftC+pBSGGxufYA==
X-Google-Smtp-Source: AGHT+IHdHI5tSF4xSDZKG0RbgF68Qiv+Tm556g1rBcJLf3dQZU5eyA/aP0vwiK2e4WrWKjMREkD6fNv/GAr0oY7+G8o=
X-Received: by 2002:a1f:e3c4:0:b0:493:8019:ea65 with SMTP id
 a187-20020a1fe3c4000000b004938019ea65mr7476409vkh.6.1696835342986; Mon, 09
 Oct 2023 00:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231006224507.443486-1-robh@kernel.org>
In-Reply-To: <20231006224507.443486-1-robh@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Oct 2023 09:08:52 +0200
Message-ID: <CAMRc=Mf4Fmz6cU132MUPPKZBi0ntyGPYZnfHPDZhZCBdsoVZzw@mail.gmail.com>
Subject: Re: [PATCH] gpio: Use device_get_match_data()
To:     Rob Herring <robh@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 12:45=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied, thanks!

Bart
