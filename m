Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0D37EE1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbjKPNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345125AbjKPNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:43:57 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2377C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:43:54 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5af6c445e9eso9177227b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700142234; x=1700747034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZjmt/D3S5lfIFGtFJl+O58Jlf+7TNGbj07bIJh2uQ0=;
        b=bTBAXsy2hCIzeBI15VRO4hd6kgKm2rJMyobMYcxpW2XH5NtI3BoR5qJw64Ta+Cz6Dp
         YNJeaqmEIL2MLgeJyGOlf8vCGUnIaKSnTFs9f1Ix/9RqKISu72qj3TS8GydXAwlKSMC8
         4QQqfsZkp1eLUJYkhL80lPi6QdVGqzUbAmdxC5o30hITwPMdWclQZ4BO9ZcQZdKyMtYD
         b7pZ4RmayGE9JR98TqH54hgjfWOCe5EyuprsODIxsiwE1Y+vpVgtuG8OZ7vIgpWTIXfd
         QxBg9YOe1LqUY37l431H+IRDOZCTMExmAnBGO8WiU7u7ohLxuXO80DLXQMW5bTE0Lf0Y
         pqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700142234; x=1700747034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZjmt/D3S5lfIFGtFJl+O58Jlf+7TNGbj07bIJh2uQ0=;
        b=WnT/p26pCtzh0Ixk3mAYDqQ9Q+o0P7rbxchojxUpzH5briRfpih50o157mguxsGZw3
         sk/YXHMA4rP886vt5P1r1jLPWHPUDkMEggw08Wq7byz8mqvGz/TAekw9QwpbHQFBXBWi
         oE3MtDCAGbUIzpyb013l8O+yOa0u5ce8AuNV3ozImO0mD/7kiF+RKd9bU2bbG/WKwGC2
         WbtN93eF75kN1Y7C/7ZFeiNQTKoQDhqS5Ldxj+MVYBKkW6lSLnGFGD+lF7QbImv5H6YX
         mgPeU9AK/CtHTThx38rWidujgsbODeDdp6j/eVhVDNtU8/n4WhwQnCJ5vGVZ3BDdEdO6
         GUVg==
X-Gm-Message-State: AOJu0YxwvoP/QcFUAbyH8SFHXBaG3mF1ZpwPXGS+FgxKsMIKdbPo6EzG
        s9Xko3F8MVzCf2AZ0mLJiuH8cpVL9NQKNaJFyfJ6Og==
X-Google-Smtp-Source: AGHT+IHTheVVa1bG/lx6ddMArSjfKb7XbiwwuCkbnCXPq4s0fXQ3Xn3Rk48p8Bczi+2ndbCUxf7vIcj3riI2Cd+qR9c=
X-Received: by 2002:a0d:e8c5:0:b0:5ae:732b:ec21 with SMTP id
 r188-20020a0de8c5000000b005ae732bec21mr15855507ywe.34.1700142233950; Thu, 16
 Nov 2023 05:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20231115165001.2932350-1-brgl@bgdev.pl>
In-Reply-To: <20231115165001.2932350-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Nov 2023 14:43:42 +0100
Message-ID: <CACRpkdbDny8X3WB_qJ4h_vbwrjno5ytAtNMgTeXg4jpegdUH2w@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: don't use gpiod_to_chip()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 5:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Let's start working towards removing gpiod_to_chip() from the kernel.
> Start with pinctrl. The first patch should go through the GPIO tree
> and become available through an immutable tag so that we can get more
> conversions in this cycle elsewhere.

Fair enough, maybe an immutable branch with all three patches?
Probably best to merga all three into both subsystems I think.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
