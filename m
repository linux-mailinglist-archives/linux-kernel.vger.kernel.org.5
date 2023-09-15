Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D177A23DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjIOQqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjIOQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:46:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4462126
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:46:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-273ca7ab3f5so2046776a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694796398; x=1695401198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSRPmYTgQYAS8/W7DnTR2CfDhO5J0xkkJUsesS4GK9E=;
        b=Vit4AOoM1pfZLosrGDWXMErQi6wxAhNKlZRB0TXIxYZp5/VrMrSaTyR1+qJlc4omKX
         Ehi/wbxkxzNhsC487xdQduvAAitCFH4lAFtEHpQ9ZdH3Q4fdj3WOD5NPagzelvJi63Xy
         ZQAwrr/2qx8KvEEarx14MSWMj8N5TOqRzIgDbFu/t4oUjUsZzoK6q55cld0c8Ou79OOz
         XAyp9zpZeCnFTT/B16UnjdoPkpjqI8jVzTBmhiDbqoSfbQ97q1FcEyQ1DkrNYamDUGOM
         G9+w7cIaSJSiIvGLEKNeQ2VRyrez7l7qc0wGZDS1UH5dXJ/GgLKTQmUoxsyeBRuALmfy
         f9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796398; x=1695401198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSRPmYTgQYAS8/W7DnTR2CfDhO5J0xkkJUsesS4GK9E=;
        b=J5pXFKWESAImPIK71tv/TaEoBJhj58b59t/ZGxcMOgECXJg1OAp8F9znBtO5Q/BwlH
         35pP5aLuZu/5g7M0WJbmniU6G0wjgMles20iZCh+Ohrk5zslxqUjgwwhpCTJHRA+bz42
         qCQukQGdENx5Upg8hAFRwqrCL/xg52fASR20ppXAr96nhBp44+q3CDcIa7bJJ5cwZeYa
         LH9PrS3w3HXUePKGunOjlBGbDEnaFXcrSQEn1Yu6k/FhFnL+4sI6S2SrK7Wv1HSWxMC1
         RV/7+xg1G6Nj6hubrNZw3mfR1cgpauGn7mFgWOCbiVuDrjYTbkXvJ5hgiYi2mQi+wKaf
         RZyw==
X-Gm-Message-State: AOJu0Yy5rppCFj4PqYIypcISKv2nsr0ZKU4SUkwKXsMfCMODUmEJrR+L
        LvDF7RgWCTL+qJgtrQAfkYHF3WcDkmlGBe9lhi+JIkv4
X-Google-Smtp-Source: AGHT+IEOtjirqqcCLbCJZlVginOX7AS80MzI8LVvOQ0btY7fBc41HeWsM460QdZ43c9w8NOJfuT3+XsWmuae+ebovy8=
X-Received: by 2002:a17:90a:300e:b0:274:922d:4b35 with SMTP id
 g14-20020a17090a300e00b00274922d4b35mr2051394pjb.1.1694796397759; Fri, 15 Sep
 2023 09:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <658f5f34d4f94721844ad8ba41452d54b4f8ace5.1694625260.git.andreyknvl@google.com>
 <CANpmjNP8O-GLQ9m06riX+kjbPSD9sBo+XGtTE2xW=pq9uJFGAg@mail.gmail.com>
In-Reply-To: <CANpmjNP8O-GLQ9m06riX+kjbPSD9sBo+XGtTE2xW=pq9uJFGAg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 15 Sep 2023 18:46:26 +0200
Message-ID: <CA+fCnZdS1LobT9Wg3zxtq1Lec9hbgM8gRSmy=A=UyQzAr-BCtQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] lib/stackdepot: use fixed-sized slots for stack records
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:56=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -708,13 +708,19 @@ config ARCH_STACKWALK
> >         bool
> >
> >  config STACKDEPOT
> > -       bool
> > +       bool "Stack depot: stack trace storage that avoids duplication"
> >         select STACKTRACE
> >
> >  config STACKDEPOT_ALWAYS_INIT
> > -       bool
> > +       bool "Always initialize stack depot during early boot"
> >         select STACKDEPOT
>
> This makes both STACKDEPOT and STACKDEPOT_ALWAYS_INIT configurable by
> users: https://www.kernel.org/doc/html/next/kbuild/kconfig-language.html#=
menu-attributes
>
> Usually the way to add documentation for non-user-configurable options
> is to add text in the "help" section of the config.
>
> I think the change here is not what was intended.

Ah, didn't know about that. Will fix in v3. Thanks!
