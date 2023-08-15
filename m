Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDC577C916
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjHOIEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjHOIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:04:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FA310D8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:04:44 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so3777299276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692086683; x=1692691483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeskwxWPTAiQIffQy7Rdk/9Z2xH0Wh4AYqgu5I7jUPw=;
        b=w++0d/sTBQUse03QTVnNfW2leS/LaaScvbvrGxJCKIqA/29UxMa3lVFkFKjA9bpIE1
         Cp6D3zDmk4W2Klb6uqkJDyhI5Mrb63QLIMGsPmCb5zK1EBb8cwch2+HbqIpz23nZnp4U
         3IGOx0skHtzvGHUgFkYnLa66jBz8JitFqw9Ej4XYPk4BubTrhS1wXbWIovr88HnzrWda
         AZPhZ3VRhjsj8AR3JlGDAJibFMCPyRUgIOFMVbMxCNbI+7fkh3s8eGKn7MLr/DI8mObn
         u7zCHlSLQdv4zwFQZh2uf8luBqfCOv82fwgHiP1dUEKfEr4nI6brKkqtKDiihjPVVhLo
         JTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692086683; x=1692691483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeskwxWPTAiQIffQy7Rdk/9Z2xH0Wh4AYqgu5I7jUPw=;
        b=Jz8KZxkQCFa7shE3AACal4x78c/DVjVmDR8J0Z8zdTmIw0OpdC1b9tdzV0GRkY//gp
         jNbo82HZgwDimqirJvD6oa+gmHPEzNr3JROjVZv0v7CcpsLvb3kHv9Pse4zhQuptuwZY
         a3SRqohR2WxpSrsozcEzPlGuW3epn0+QrSVnP/wp/LPCmi9+EEXdjDs0Xxp6CX8YMYt3
         WyiOd0mZSDn7fddo7sNZd73ksTB/+ZVjd3/P6D+hb4P55XJs0H6wzRKPvsu+hAEhdGVL
         w9Llks0yjWHb3pB7LZspC1DrNogeRnPn8bBk+VD1TcKMXizGazHvgXkKSw9X3f68dwaA
         Sy7w==
X-Gm-Message-State: AOJu0YyNoETXq4ire6IQCz9eeMc8OP9/DibKzKe4mRnd6lCoslsaGCCo
        C6tqBn78nw0mivIU9WpRmYhMBJGSr2AMCtflbqEgHg==
X-Google-Smtp-Source: AGHT+IHI9XLp9TKeTxxt8PykqJrhPgYXUjPhN/04BUGDhaTm6KhyzshKT2GuowB4nu+++Ul4Sj40cHOwNpj89N+0JaQ=
X-Received: by 2002:a25:b4a:0:b0:d6b:75e5:f2fd with SMTP id
 71-20020a250b4a000000b00d6b75e5f2fdmr4315483ybl.37.1692086683533; Tue, 15 Aug
 2023 01:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230809131442.25524-1-brgl@bgdev.pl> <20230809131442.25524-2-brgl@bgdev.pl>
In-Reply-To: <20230809131442.25524-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Aug 2023 10:04:32 +0200
Message-ID: <CACRpkdavsv3nJnhtdqW8ANAVfxbgHdM-SpcfOv4p_t-7EOaOHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 3:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the gpio-simulator.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
(...)
> -       mutex_lock(&chip->lock);
> +       guard(mutex)(&chip->lock);
(...)
> -       mutex_lock(&chip->lock);
> -       ret =3D !!test_bit(offset, chip->value_map);
> -       mutex_unlock(&chip->lock);
> +       scoped_guard(mutex, &chip->lock)
> +               ret =3D !!test_bit(offset, chip->value_map);

This is really neat. When I grep:ed around in linux-next this seemed like
the first user of the scoped guards, so maybe Peter Z want to take a look?
I bet there is other code using it coming for this next merge window as
well, but this is really the first that will land in linux-next as it seems=
.

It looks good to me FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
