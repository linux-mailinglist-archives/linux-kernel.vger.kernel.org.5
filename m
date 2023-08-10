Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D77777776
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHJLrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjHJLq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:46:59 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2131183
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:46:59 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d63457dd8b8so728427276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691668018; x=1692272818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK6gbJKDe0shzorD3XuL5DZoFclmN0M4H/xFiOklQE4=;
        b=wZoQihECP0qKmdzSH0AFkjpzPzgohj/MpAmHF57ewOuIEtxOM+/1rYK/lMIUi5JPSW
         pTBnculcbSfpTyCCS1GuviR/DT3QZ1TI+Pq2CTJZoNA7Z2o/IwrnQ33+xNOnrE3oHAT4
         Lr3dAKoU+v3smz4Og+tsdfD8SZGQSJ+r5yKBRVBop23dJm+i7idIhxycInZw7cPRGiPX
         2dWS7lM6LNuEDEZ11wTrquJXrtZpXV0sboeAQmpx8w7d47N83N1GOipGos6rohWquuB7
         3pfaBwow6i+7ItphGjStI04js43L3yJG4zlK/QyizjaegEjww4NtqFPhYut1spzQHJTW
         ODmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691668018; x=1692272818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK6gbJKDe0shzorD3XuL5DZoFclmN0M4H/xFiOklQE4=;
        b=dBIv3SDnWtkmWN2s8lI75ltnwe0xACEwn+tAtcZYUuxZoaGjQ43IYUwis8knVhJ6Sm
         4dwdEbsSi9Z48N75+/rcueMcgOOtHBMFgl2GlETszSlLxwMi3o5aJ9hhlx4B//AO1cqa
         rz4iGJFUZXPvKyUVDQ0aWf0uhXvFyBCo3x3mErcNFqMo56RiFg7Yv47uJ0ZZc+oFrSh+
         JjxpHfgi5Ns98QeWGPtZlUgskoIbwddGiTP1c3dFNQ7uciDXz2wqI9paFsVdOkp24FJ8
         L32VrxCmz30nEIUUJe4wusbiWFUtssRNhOQ+Uz2hXL10Sk8dIKxAColfIQVVW1PsYSNc
         ZYEA==
X-Gm-Message-State: AOJu0YzpGQi4G5WNpR+doNuGJtG0+YZC0FGHtFCQCnfkzA31VN6YyKFb
        U1PYmTEi5Vtq7qNAvnjcQlw5R9ljFcmLyNYi7ZkrpQ==
X-Google-Smtp-Source: AGHT+IFzUkae2xEZr0dzyo0by/2w26LhTLPG2hwdmnqT6GJvOjsbev/+UZaDJLtQEupkLyfOGVQ54xIeubQwkRbeKaI=
X-Received: by 2002:a25:58e:0:b0:d04:f936:556 with SMTP id 136-20020a25058e000000b00d04f9360556mr1878239ybf.36.1691668018380;
 Thu, 10 Aug 2023 04:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230810100335.9330-1-brgl@bgdev.pl>
In-Reply-To: <20230810100335.9330-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 13:46:47 +0200
Message-ID: <CACRpkdYVhr71pEB9wZWUTMh4MSVo9OziYsNz-9qcZGiFsr+Geg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix reference leaks when removing GPIO chips
 still in use
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:03=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> After we remove a GPIO chip that still has some requested descriptors,
> gpiod_free_commit() will fail and we will never put the references to the
> GPIO device and the owning module in gpiod_free().
>
> Rework this function to:
> - not warn on desc =3D=3D NULL as this is a use-case on which most free
>   functions silently return
> - put the references to desc->gdev and desc->gdev->owner unconditionally
>   so that the release callback actually gets called when the remaining
>   references are dropped by external GPIO users
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
