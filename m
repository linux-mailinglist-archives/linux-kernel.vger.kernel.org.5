Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6024379E886
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjIMNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjIMNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:01:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658B51989
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:01:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C846C433C8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694610090;
        bh=9VsP3SfBCgbMmQLBpB/Uo49Wn9M5w2DLBgBZIQ+HGZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eBwi1wzuMcJHorOJFaidjvD1g0sslam5fE0VCNZnON9u86OwI8LlZMgo5btiA7NIz
         aKZK97qXupU2Owa2R8oW+fJcsRfETAu3anhuTFqEXLDBrV8K4ggG7NZRxr55sYk1Lz
         BB5dblB6lPWF7p7zqGn6gf5gPQtHQ9D85MXQe1oushCZB9p2677+X4pXEZ/t6p8Ze4
         KPqkDSOMpYCPLG7rtLf/DweQ417zEmMipsbqUfN4R20MOnrl5c/3HNkSeOv7kq9dO2
         PSU3EktjrIsOdGXIAgpcEHBp0efaEiSjQTQt3l0MWnIcsgdx2URSg27NqhDmXicyIj
         qOI5bPYzRiZQw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-500cfb168c6so11145901e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:01:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNAQhsW9lduCTelGiWkL499ro98hUiwNti5qJ6ds3M1leNstjm
        yWERbgqEVLsOF2oLRioMOwScULdnfgYkdDp3qA==
X-Google-Smtp-Source: AGHT+IEgTKRhLIPGhgkZulS6vA3X/owGoKjXEe0+hsm23KxCVGEZHPZ12keLOPHwSyoAmUIskv58vWHJ1QLVCZN/0Wc=
X-Received: by 2002:a05:6512:3e08:b0:500:77c4:108 with SMTP id
 i8-20020a0565123e0800b0050077c40108mr2444873lfv.9.1694610088278; Wed, 13 Sep
 2023 06:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220615090517.3961621-1-windhl@126.com>
In-Reply-To: <20220615090517.3961621-1-windhl@126.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Sep 2023 08:01:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+609wEjMLsiLAMjSfAcMc-ashF9+f0rhbZRhM2FVPhmA@mail.gmail.com>
Message-ID: <CAL_Jsq+609wEjMLsiLAMjSfAcMc-ashF9+f0rhbZRhM2FVPhmA@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: mach-versatile: Add missing of_node_put in integrator.c
To:     heliang <windhl@126.com>
Cc:     linus.walleij@linaro.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 4:06=E2=80=AFAM heliang <windhl@126.com> wrote:
>
> In cm_init(), of_find_matching_node() will return a node pointer with
> refcount incremented. We should use of_node_put() when the pointer is
> not used anymore.
>
> Signed-off-by: heliang <windhl@126.com>
> ---
>  arch/arm/mach-versatile/integrator.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-versatile/integrator.c b/arch/arm/mach-versati=
le/integrator.c
> index fdf9c4db08a7..fba19357171a 100644
> --- a/arch/arm/mach-versatile/integrator.c
> +++ b/arch/arm/mach-versatile/integrator.c
> @@ -76,6 +76,7 @@ void cm_init(void)
>                 return;
>         }
>         cm_base =3D of_iomap(cm, 0);
> +       of_node_put(cm);

Not really sure this is right. It is in the sense that the DT node is
never accessed again. However, the device itself is still accessed and
I tend to think a ref to the DT node should be held for that lifetime
which in this case is forever. Really, none of this matters because
nodes are never removed and these fixes are kind of pointless.

Note that cm_get() and cm_control() are never used and can be removed.
That would be the more useful clean-up.

Rob
