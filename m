Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA0750DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjGLQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjGLQN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:13:28 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E7211C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:13:00 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b5d7e60015so6269884a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689178344; x=1691770344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyVC8plAjDRDlIDMwD83lQmMSOA5t9Sq9p0cX84tJA0=;
        b=GVbvj3Ub2MRN+329HTjHjHIXoF69LQ86Xo63zFqB4H+ufHV/1dmU9V5Q/J7v7J5aSn
         E926nQZzoelukS9/6m97WrneT6NLtBwreXuY3XD3dyvz1hYcNsIxxZi+dpMkG8Knoi5u
         gXMfTv4lIGXU3RjdpoLKiLq2F9imrqgJU2wQfga/RZCNYXEzd9Wy7MsVISIvt+8WV8XT
         QXq1qfgQOK0BWTw4thyC7a5H/HKejpx9fJc+QB+0G4hF8kgCkpo1TKs49KqJcF3PnWXw
         Kn3BHJ8xBd8V6ds6rOze1DDOMomgFnYQk+/6a0oP4vL9jzAPoo9IwTUv1WEn9hOTYTeJ
         bbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689178344; x=1691770344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyVC8plAjDRDlIDMwD83lQmMSOA5t9Sq9p0cX84tJA0=;
        b=UzEvZpuKE7o8VqaSHSB06HDdNsueqLj27BlPDy6YdXa+eFtdDDdW0VNaPWfBctjC3i
         K2Xw0v/fKbRViM67E88/m0txzCv+HR9Ma94e4as7IqJ0poexZ+3zmOz8tUdipBdZOcAI
         PVO4dFUkTcdvfHoX9ClVX7d1/cwx+wxprcDdZ+A0N18ARoMihGkSv5ptVpDXKOzp7yco
         VNnFZK6JKW6s76QAIAHM9blgrRI+n0wwpfsSgoCgErjOP16Lu2IZQio4ie7cyXSrlcFJ
         6Dq/iRWz4uqnTFZEVAmFvvVI82pE/hm/Tfa+/tFoFo10twN6WfmedsED5uZYx4UzuJlg
         NA5w==
X-Gm-Message-State: ABy/qLanxb9jf9szViUCOqxL9Qv/7LxySx3wNmjcjnMF6okViZEMRibK
        xqS+GXvkqAhxdCPbutWuRNCepAu15rk/uGGqJT0=
X-Google-Smtp-Source: APBJJlHD7UPTV2H1fW8GCpeOOpFrYiOI/zaN1LPF0XW7OmR+lcquAog3zZQ7xsqyylSnQPg6yk30CmTRfY3kgU9/yuQ=
X-Received: by 2002:a05:6870:d1ca:b0:1b0:35b2:a19a with SMTP id
 b10-20020a056870d1ca00b001b035b2a19amr25457083oac.36.1689178344616; Wed, 12
 Jul 2023 09:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230712101344.2714626-1-chenhuacai@loongson.cn>
In-Reply-To: <20230712101344.2714626-1-chenhuacai@loongson.cn>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 12 Jul 2023 18:12:13 +0200
Message-ID: <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tests by removing -ffreestanding
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Marco Elver <elver@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:14=E2=80=AFPM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for memset()/
> memcpy()/memmove() if instrumentation is needed. This is the default
> behavior but some archs pass -ffreestanding which implies -fno-builtin,
> and then causes some kasan tests fail. So we remove -ffreestanding for
> kasan tests.

Could you clarify on which architecture you observed tests failures?

>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  mm/kasan/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 7634dd2a6128..edd1977a6b88 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -45,7 +45,9 @@ CFLAGS_KASAN_TEST +=3D -fno-builtin
>  endif
>
>  CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> +CFLAGS_REMOVE_kasan_test.o :=3D -ffreestanding
>  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
> +CFLAGS_REMOVE_kasan_test_module.o :=3D -ffreestanding
>
>  obj-y :=3D common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) +=3D init.o generic.o report_generic.o shado=
w.o quarantine.o
> --
> 2.39.3

+Marco
