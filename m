Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57AE7F615C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbjKWOZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjKWOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:25:19 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295819E;
        Thu, 23 Nov 2023 06:25:25 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b83fc26e4cso571284b6e.2;
        Thu, 23 Nov 2023 06:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700749525; x=1701354325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XODbNWJs6ANSpwkyWL+ByiCovAsp0w3fPI5hgeJVDEw=;
        b=ip8+t4UUEbyptha8ZTERXz5zDJmveq9UG7suwzUUTlAk2mFffcjIC/fxBmVjtIjdHX
         8EhhiDfp7agpRtFPSxTVBeZdw5sTkTNTl8LXqcebWJHmnwWuwtDY9IvXzqlLPtHl82lB
         +ZECAHLXzKDIHBvyoCZ2lNLFFXOVce5KaZqpuFqIWYd+sQv3wN0kmZlQK8dTkSAbs3Mr
         TkuZkkfaelLGIfcVH47wjEr7N5Qfgh+e2fITu+1kGM2AVzjVpUrYmViD+/fxrk/mT6sI
         UCFihZ5HsSdjvzlOnkPg564qLXVUXpPVJFiADyLF7JGaVolmchNMoUasHJNC5ilFdI37
         2zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700749525; x=1701354325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XODbNWJs6ANSpwkyWL+ByiCovAsp0w3fPI5hgeJVDEw=;
        b=IOSiGPZCoSr77Jrdd3CBSOEpELZED5CrI9Xp7AGNxv+627acZ3k6qezdw5BC8m3pwn
         ZvvXmNA/6v809r8HebN6ciXBIWJ7E7e4HxhdPI4kLaZVNcBMXN/lo/Tv6dEsOn+afRDt
         ognFb1Y4z4TbB4sx1Qhw17Tw+oJnjn6khX2KAfSp8wLR4TCiRZvohegNrNU303ReOIKf
         a+BsNMi3B/L1FauqDT9v06GClxi1hT+Q1V5o408ojXiDzg8ODmhxsEZy4hoYGZHNgWVl
         rjM5pR4oCQHlhj30vdlAmMcfa3J7Ui+O1tG+QQHFH5tAdI2zvdzdSqEl8T378Mj0jYWw
         eJFA==
X-Gm-Message-State: AOJu0Yz/OlccJR+q7IVZJHCFAwtWTIruETXxRtNgJyqU9qceVnwf4jgV
        lNt6/6LIMFNwv1qSnvAdJhOVF03A9QRcLF1YYV6YyCnpMx4=
X-Google-Smtp-Source: AGHT+IGHv7HCerKMPdxovHfxzdrRzIXJsAL2UbSq9AlRzcPuAjbZl2zjSbLuv8adlSKK5aeQ4BjqK43sSLUdO56+dFE=
X-Received: by 2002:a05:6871:d211:b0:1f9:6d7d:b27b with SMTP id
 pk17-20020a056871d21100b001f96d7db27bmr7437436oac.0.1700749525020; Thu, 23
 Nov 2023 06:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20231123132749.108827-1-boerge.struempfel@gmail.com>
In-Reply-To: <20231123132749.108827-1-boerge.struempfel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Nov 2023 16:24:48 +0200
Message-ID: <CAHp75VcBMbENVKhbdJnXHGxAP85_5CMNxoq7JqV5XbUyRLPoaQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: sysfs: Fix improper error handling on failed export
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bstruempfel@ultratronik.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 3:30=E2=80=AFPM Boerge Struempfel
<boerge.struempfel@gmail.com> wrote:
>
> If gpio_set_transitory fails, we should free the gpio again. Most

We refer to functions as func() in the text and comments (note parentheses)=
.

GPIO

> notably, the flag FLAG_REQUESTED has previously been set in
> gpiod_request_commit, and should be reset on failure.

Same about func().

...

Seems the correct fix, but you may also add that no existing user is
returning anything except 0 or ENOTSUPP that is converted to 0 in
GPIOLIB core code. Hence no Fixes tag is needed, but still possible if
maintainers want it.

--=20
With Best Regards,
Andy Shevchenko
