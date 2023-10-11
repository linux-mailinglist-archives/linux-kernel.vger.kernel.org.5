Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2197C582C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjJKPgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJKPgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:36:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0F792;
        Wed, 11 Oct 2023 08:36:48 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66afd39c8edso31199586d6.2;
        Wed, 11 Oct 2023 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697038607; x=1697643407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d70RV8D3q4Lw0yJT/tGgP8JEXxsa+Fuj9xKAysUS94=;
        b=GJJ3GkeJIbVcj9S9gKeyxcUcrTIrt4F1xmKIMCuR6iFFiZCuSkCVy/+0YXx6q8Wn5C
         ikMekwNuV3AKCUx1pvpedym6dq6WxYDDYcsAcspRLvTFu/T4rf4JogLiN4PAPiAvGXJH
         oCf1lV1mdCIII3qKo6DmBlowhkZqoSz7JOMfht9hsLPD+aw4NvjM8ELB61wZrMXb9NeE
         6tGobG8pCHld4xtK4mAzJPM6+VehgGLQCffcSUOuw6cwj569M3hW3kutJfW1hC80vylD
         3ciM7YKfqSLRFeydfvaSIuuLscCOdvwgE8g8RSEdpTgcZH9K/BxsaPxq9qG1URYGG5CO
         juFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038607; x=1697643407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3d70RV8D3q4Lw0yJT/tGgP8JEXxsa+Fuj9xKAysUS94=;
        b=jSAF6r36VpUHXY4SUwTATGRw5ViHh1UGILlEQFlb3i5sqt3v4s1ZnR9wczo5UAY82w
         JC3Ztv90dJgwTFDsmn9e9o6lTPMTQ6r9qgvlD9K/BJpu1IN8mTfpYnWSDoQQIfoCp4P5
         iFMRCUxEuIR5Dggh5zpJRzP/zIaMa1DbvLzgdochGXy4iHRuYXuuNnL7oSXV4ZXVAc3q
         fVqw1EB8wgNmkAqj6uBf913Lfumz036cnxihX8Y3oKJNbMDAiQSsaf8iORRELvwullwC
         LcrnuXayK2/Tsbs1XdUqokpFcvrp2dyzf1S1PAh8pgb6+q/z2Kd470B/gX9lwJnE/qFR
         /VfQ==
X-Gm-Message-State: AOJu0Yx0VDA7rnCLLSGjDQfSfoU5x5RVrMyGKBX/mR4moxI8pWpHgULD
        9uM/Sg3qMtULDmSllxcpQPSMvSyY/KHl25iteFrtQVWzTYGqvA==
X-Google-Smtp-Source: AGHT+IFU1SyCP9HwZEqNMLh2P+CII7WW5qTkTr5uJLytAwl8ChOtAUnXs0neArcgm7RUqu0fppbZXGkflHXFbWQDwrI=
X-Received: by 2002:a0c:8cca:0:b0:65b:1802:4f3c with SMTP id
 q10-20020a0c8cca000000b0065b18024f3cmr18358578qvb.21.1697038607513; Wed, 11
 Oct 2023 08:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231011093412.7994-1-kkartik@nvidia.com> <20231011093412.7994-2-kkartik@nvidia.com>
In-Reply-To: <20231011093412.7994-2-kkartik@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Oct 2023 18:36:11 +0300
Message-ID: <CAHp75VdBh0k_XU3GG99EvgLOztOFWn87QXknpokcDy=29yu=Aw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] mm/util: Introduce kmemdup_array() to duplicate an array
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        keescook@chromium.org, andy@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, petlozup@nvidia.com, pshete@nvidia.com,
        ulf.hansson@linaro.org, frank.li@vivo.com, robh@kernel.org,
        stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Oct 11, 2023 at 2:17=E2=80=AFPM Kartik <kkartik@nvidia.com> wrote:
>
> Introduce function kmemdup_array(), that will copy `n` number of
> elements from a given array `src` to `dst`.
>
> On success, kmemdup_array() returns 0 and copy the elements from `src`
> to newly allocated array `dst`, it also stores number of elements
> copied from `src` array to `dst_count` parameter. On failure, this
> returns a negative integer value containing the error value.

Hmm... Why is it so complicated?

Can it be as simple as

  return kmemdup(size_mul());

?

--
With Best Regards,
Andy Shevchenko
