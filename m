Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896B27BC21A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjJFWO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJFWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:14:27 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2C9BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:14:26 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59bf1dde73fso31918347b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696630466; x=1697235266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qti7Kwj81qHM/etaR2hk1GyZRCJxyG+q5Re3Vl2xp6I=;
        b=lBmkwH/ItZuVUWk6FvPdaztvI9Fq60egh8IXuulDjlwMbgxLSHg5JMAf0106GaIBYf
         jzejzeqn2sy4uZS57756h9yM+ciAQeTJaIqri7SOUht7/4sTXtcZ+DEpCTj3rZ4PNmuB
         Z4TsLLxRBIUXc61rURV3trLfasAe7h+GpoXKDPjtDpHRpLR27iwZR8fxhPPbPBcl1zOJ
         xNgZ/dn4Ao21osf5wK49btk+V4QjhtntN9Do17ZDyp59Di3P0/WuUnTxRyJ9niSnMLmE
         jjaPtcFkmf5xg5Z7DJ2BUq1y/U2HezutC86JhJUI58eAYqqiSe6CKpXKfjiC4ljZf8uL
         tNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630466; x=1697235266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qti7Kwj81qHM/etaR2hk1GyZRCJxyG+q5Re3Vl2xp6I=;
        b=lgHMa8X/BFmjGNZyvKnDwx0anIt9MOafEHdkQhNGONnmFuRqNEB3eOdD8kLJeppgcT
         gQAdmK6yd58D9r238dTDsmul/4FO3CMg61NfUgVMZPCB321mKKDD7SyW6McB8nunF+zX
         RxCxu5Jwey4yICqjHEfwjtWEctmZvM2QTlfVMZlM/muOH9UnPd9a6qTqFUvA/2tG9xBj
         lqUtBwUzUrY9IxpwGhQHGUmC/Ton76DWUjq3QuLltv1P83wCfqy7Y4M/FzacpRV/mDZz
         D2kDE9qi2w+BR/m7vkZ+ZXkRzgKwz4CBOEexYETfhEz+vGh9Xk3hR5Vtvg6A/PuTFrPV
         Br2w==
X-Gm-Message-State: AOJu0YxOOawg4+wBc+EQNqx4jux7luqUCLwRDB5ry5tItKSXtBDciiWP
        nwyX/WBwXJ5q38SbmTTZAJ4HT2dWtSCThpYUj3Y6vl0c8GkJdftl23I=
X-Google-Smtp-Source: AGHT+IEjjPhlzeBCckE+WNx7knXLTQF5SjtrWJlkgEyFis9aGq5IiNd3ydHNXWtzPLZdqW+tTe70TpiO7NlIzmK7Vho=
X-Received: by 2002:a81:a546:0:b0:592:5def:5c0d with SMTP id
 v6-20020a81a546000000b005925def5c0dmr10090456ywg.45.1696630465842; Fri, 06
 Oct 2023 15:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231006115147.18559-1-brgl@bgdev.pl>
In-Reply-To: <20231006115147.18559-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 7 Oct 2023 00:14:14 +0200
Message-ID: <CACRpkdZP_nOgj77iek_V28Ny8Pb03Xyy-=ho+WqzMHzXajtfqA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct gpio_chip
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 1:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> struct gpio_chip is not only used to carry the information needed to
> set-up a GPIO device but is also used in all GPIOLIB callbacks and is
> passed to the matching functions of lookup helpers.
>
> In that last case, it is currently impossible to match a GPIO device by
> fwnode unless it was explicitly assigned to the chip in the provider
> code. If the fwnode is taken from the parent device, the pointer in
> struct gpio_chip will remain NULL.
>
> If we have a parent device but gc->fwnode was not assigned by the
> provider, let's assign it ourselves so that lookup by fwnode can work in
> all cases.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

because we want the code to work (rough consensus and running code)

> -       if (gc->fwnode)
> +       if (gc->fwnode) {
>                 device_set_node(&gdev->dev, gc->fwnode);
> -       else if (gc->parent)
> -               device_set_node(&gdev->dev, dev_fwnode(gc->parent));
> +       } else if (gc->parent) {
> +               parent_fwnode =3D dev_fwnode(gc->parent);
> +               device_set_node(&gdev->dev, parent_fwnode);
> +               gc->fwnode =3D parent_fwnode;

The core of the crux is that we have
information duplication with a reference to the fwnode in two
places. One in gdev->dev and one in gc->fwnode.

gc->of_node was the same duplicated before.

A gdev is created for each gpio_chip so in my naive brain we could
get rid of gc->fwnode and only have the one inside gdev->dev?
+/- some helpful getters/setters if need be.

Or what am I thinking wrong here?

Yours,
Linus Walleij
