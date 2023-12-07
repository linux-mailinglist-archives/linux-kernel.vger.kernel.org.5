Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7332980864C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjLGJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjLGJ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:56:34 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9711F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:56:40 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db544987c79so772674276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701943000; x=1702547800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJnq125j0YdWG47h8sgeSrpDhVFiAnTytxHlskk2EhY=;
        b=h5msvbptgCQw59PMItu4yKSNeB4votNJq7/JDvy69ZqNTpHpJTQHD7l8RKotTO+ML6
         lDus2hDTgya5dA7ZbfrEqeqVGRjlisWxJo5SLae4w65DyZxi/nROl49SKZHBIFQ1GSoD
         dOJTi/cIWKqvkcdNrvPh2WIgs0VehNfmYvtynPDAs5w1sWTOrnJJ9FFzpBxlC28PgKas
         6d6FvnW0UxYojjB4KxCvHUStWrrOsZS9vCVWU7Nzq/rp2KFYU+Z7MKt9d/cpngqcbCKi
         nQw6O3GDqUSv2ma1NZYUuH1FG9PfqUYHfim8+KkuNL9JVa18WmS54uRZE4Sjxv6SoN9l
         yvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943000; x=1702547800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJnq125j0YdWG47h8sgeSrpDhVFiAnTytxHlskk2EhY=;
        b=gT9c0SFfXBgUXgkOSEXYbeNcZ2B4imujGM2NvffUvC+7MrFT4ygUvdPUJQIicOXwhR
         FIt/PVksPj38TOrl3v5ceMG6AKy5xtKpZNuv680bFrsT6+3/djLf6pFs8igaryKKiyZF
         xohtD53VEtyrp9U+Obm48ntusu4FFUI+zCQ6LOxStIIzhV7Fb8MByBn8x5z78ot/ZGhq
         TUusrl1QyFenNV5avh8a/qxkNjhqizX4je/BsTk3kwChV2hnTmt+eJGxlyehaGhxnqsY
         kF6UOnB7UsizoUR4XGyaXnIX+XEP9XVIcSoogDjwi2teWhOPtMPlaM+HaphkGXun9R7O
         zM8A==
X-Gm-Message-State: AOJu0YyWi6x4+pIhuvLDxKLDkqrBFpCZO2Mk0oxQXpPIhqoq0hgRYGP0
        wEZkoIi67mlYimXg7umyfRQp5GyFRmy+zI83Xqjncw==
X-Google-Smtp-Source: AGHT+IFmG5Eix/w4QK05D8maIWu4NoSnt+3uvdJ7TmBB3MpQnzAeGZpXme98S/yULZnvsP6j+GPexkcwj6QKWJI6sGg=
X-Received: by 2002:a25:190a:0:b0:da3:76d3:e4fb with SMTP id
 10-20020a25190a000000b00da376d3e4fbmr1627701ybz.26.1701942999893; Thu, 07 Dec
 2023 01:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20231204203357.2897008-1-ben.wolsieffer@hefring.com> <20231204203357.2897008-3-ben.wolsieffer@hefring.com>
In-Reply-To: <20231204203357.2897008-3-ben.wolsieffer@hefring.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Dec 2023 10:56:50 +0100
Message-ID: <CACRpkdZKjcE5yMF0=E+4BRTEmrShSqFzCcyH8Rug7u7kOotUQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: stm32: fix GPIO level interrupts
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 9:35=E2=80=AFPM Ben Wolsieffer
<ben.wolsieffer@hefring.com> wrote:

> The STM32 doesn't support GPIO level interrupts in hardware, so the
> driver tries to emulate them using edge interrupts, by retriggering the
> interrupt if necessary based on the pin state after the handler
> finishes.
>
> Currently, this functionality does not work because the irqchip uses
> handle_edge_irq(), which doesn't run the irq_eoi() or irq_unmask()
> callbacks after handling the interrupt. This patch fixes this by using
> handle_level_irq() for level interrupts, which causes irq_unmask() to be
> called to retrigger the interrupt.
>
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Marc Z can apply all the patches to the irq tree once he's happy
with the solution.

Yours,
Linus Walleij
