Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74E773301
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjHGWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjHGWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:37:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E78B3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:37:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso17025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691447832; x=1692052632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdgZ+yKdFSOFiY00JEX4rMGwnQcYiswrUXgyH1Y7NI8=;
        b=zmwt3+VhE/zISQHArzy0S2xng2eRXEBRjH7vY5M6DhOL7yCzeQQrj93fhG6GLN15FV
         XyjlkGW16ZLDgOh/nunApLS2HRoVieiyhYqAhJoTN1WLXoZjHuu/QsBuCvgZeytytsgo
         ZPtwtuY3men0q2NUExwdbgTjTWggH5a2/RDxI6GJYjU8ChdvJMVD10L+Sy61oBNiWqpR
         iVaBz4GP1ZdKSAiUnqxK4CZx/fj6y5xm/SRCNm3Aa780rxcazX/CE8ERan5CkXKcGjXR
         Ej2xGEHDIPWt2fAVc3ervijwKK5jXKQuplnugTBOGwkOrN+i2Xo4LAC7L8VhlOQaC5pB
         MVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691447832; x=1692052632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdgZ+yKdFSOFiY00JEX4rMGwnQcYiswrUXgyH1Y7NI8=;
        b=KdWniJKMIH4UbztWpk43gT5iUVoYSU1vtFEAPoiU9mttCy4qnS+ATWWPN833HBT233
         mxZM3wn/Amt7VzdwfuGVPCYffD0+HWDmjNw19npKuO9d84lLy9PW7xoPpypktHDX12QZ
         mcsbM8s9UybZV4/PQVKaNolDJy2+rIy19lCAQ81aoJJY5DCDXnFxfeOSJXI8m80wUOzz
         ogh8vhgQbB13WVpxYTsVBZKqx3wIRkR+7zjPteUQMTYhdFieEDLjFyAo+GZqXlpHEDSu
         TMOF6VxmPNzw0ks4nPrjOjr3jhTKlHfQpaed2zARz5LVSaaKzjJ1DdcIlfMQDya9opue
         zOUA==
X-Gm-Message-State: AOJu0YxRTlOwmqnjyXdqrgI4U8bLG62M1oeSIN8KiTfwkohx0XZfDdKS
        v/obc40AjoCqpjNs9qZpyvIuqB7RP+XNq8C7S7UO
X-Google-Smtp-Source: AGHT+IGzgdIUbivb2zwdikjRtkP7BIwhj4BTYu6hyXTOMC7jmF9THDOVGX6dmbylOsLRZI7Jua6/H2NK3ns/5JRiZso=
X-Received: by 2002:a05:600c:1d13:b0:3fe:b38:5596 with SMTP id
 l19-20020a05600c1d1300b003fe0b385596mr234589wms.6.1691447831991; Mon, 07 Aug
 2023 15:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
In-Reply-To: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 7 Aug 2023 15:36:55 -0700
Message-ID: <CAGG=3QVUqVdkzBo-=vGWprPBUhuV8p3bRSx3Qsvtqx_LDct05w@mail.gmail.com>
Subject: Re: [PATCH] um: refactor deprecated strncpy to strtomem
To:     Justin Stitt <justinstitt@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:18=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Use `strtomem` here since `console_buf` is not expected to be
> NUL-terminated. We should probably also just use `MCONSOLE_MAX_DATA`
> instead of using `ARRAY_SIZE()` for every iteration of the loop.
>
Is this change necessary? I have a general preference for ARRAY_SIZE,
because a change in size is less likely to be overlooked (unless that
goes against the coding standard).

> Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]
>
> Finally, follow checkpatch's recommendation of using `min_t` over `min`
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Notes:
> I only build tested this patch.
> ---
>  arch/um/drivers/mconsole_kern.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_k=
ern.c
> index 5026e7b9adfe..fd4c024202ae 100644
> --- a/arch/um/drivers/mconsole_kern.c
> +++ b/arch/um/drivers/mconsole_kern.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2001 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>   */
>
> +#include "linux/compiler_attributes.h"

nit: Should this include be in angle brackets?

#include <linux/compiler_attributes.h>

>  #include <linux/console.h>
>  #include <linux/ctype.h>
>  #include <linux/string.h>
> @@ -554,7 +555,7 @@ struct mconsole_output {
>
>  static DEFINE_SPINLOCK(client_lock);
>  static LIST_HEAD(clients);
> -static char console_buf[MCONSOLE_MAX_DATA];
> +static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
>
>  static void console_write(struct console *console, const char *string,
>                           unsigned int len)
> @@ -566,8 +567,8 @@ static void console_write(struct console *console, co=
nst char *string,
>                 return;
>
>         while (len > 0) {
> -               n =3D min((size_t) len, ARRAY_SIZE(console_buf));
> -               strncpy(console_buf, string, n);
> +               n =3D min_t(size_t, len, MCONSOLE_MAX_DATA);
> +               strtomem(console_buf, string);
>                 string +=3D n;
>                 len -=3D n;
>
>
> ---
> base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
> change-id: 20230807-arch-um-3ef24413427e
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
