Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C26B7D2CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjJWIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjJWIOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:14:36 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A27B3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:14:34 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9c1989509bso3321226276.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698048873; x=1698653673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pAoOM/x5L7ceRJaWR1rqSpO6Uc6ST5IOsVkh7Em4Gc=;
        b=p9aeh/+Lx+j2B3PTavnF8mMvkBIC4A6K64xkWbiixvo1VwGPoco1M9KyCPBhP+C0c1
         DMFX651b2VZqMXvQSZuPfYgbZLg7knELE2No1OKJuCfh8/LRGkqg7c6CUibY3hammlxr
         tgLtP5p70NpBJoJX0c8/rsb6+Z1WqVMtykZmd9R9FjgkZRiGKQI9IT5u/I1Zc6GuXgeV
         McP8SJ1RKq2KB3ooSJ0F8JLTMZKA5AY0bAaWL1D+OZ2ie1QHhue6UA9ff9nsBdu2l0Wp
         HFCGh8Fjsb9sTgsZSWdN7OMh4kOI3uDDK2oX2th3ZFxVxqCymP0CdpwF8QZby82jBTAu
         SpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698048873; x=1698653673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pAoOM/x5L7ceRJaWR1rqSpO6Uc6ST5IOsVkh7Em4Gc=;
        b=EeF2ImgJB2+I0FodKbJ00BPChUz9gll+1viANffRcfTcVat23R+goNlAIAZmcnn2JE
         7zMy5d+fIhJlYju2W9y7Vw+sLj4HkivttYfoxoacasEWkP7x0/R8O7L1CbdGeYM9BaBw
         xMIGmXkxffuvbkAKQTJ/BkbEdHkCzzaamGj2d8ouEziXhxGSb1KtNGzH8nrWitlDcQTg
         TYn6gNE5njr0YD5MI8XMNCP4MsRNmExepXKxEQH/GkGYwrOCZyCXAxKtcEDFUiTjQMhQ
         Ekgu4sAgQh8aaIb8ardhZWRrj4meD3E2Ptdmoy9GuVvWqKmut3LSxv0Dsgv02/t0tBYJ
         OpiA==
X-Gm-Message-State: AOJu0YyFeU3M0rKV2vQVTs1jUqkqzlUuX8OZNGWDIYBan/febtzvCKJY
        FVrElfTdgibMbAMhLdmLqknNEeZOVF4bqVoUiA3umg==
X-Google-Smtp-Source: AGHT+IFesKnpSIeaWL4LG9iA24tiaXeOXjLd0H73Ug8gM0szekiCXMUzURNO9Lu/RSpCzwzv0zXKsOI36iE30W7xEiM=
X-Received: by 2002:a25:40c7:0:b0:d9c:cb43:4617 with SMTP id
 n190-20020a2540c7000000b00d9ccb434617mr9431577yba.9.1698048873576; Mon, 23
 Oct 2023 01:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231017120431.68847-1-brgl@bgdev.pl>
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 Oct 2023 10:14:22 +0200
Message-ID: <CACRpkdY77keHjrf-zo9S-bzF50Xqx-5kR3ZXuSFr++G98rzdHg@mail.gmail.com>
Subject: Re: [PATCH v3 00/73] pinctrl: don't use GPIOLIB global numberspace in helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 2:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> As this is a big series and there already are conflicts between it and
> current pinctrl tree, I plan on sending it as a separate PR later in the
> merge window once the bulk of GPIO and pinctrl changes are already
> in master.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
on the whole series and the merging approach.

Yours,
Linus Walleij
