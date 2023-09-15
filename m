Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8037A23F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjIOQyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjIOQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:54:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924872703
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:53:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c43fe0c0bfso4727225ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694796825; x=1695401625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpolqE+SEAVwVFTY41H2JAWAfBtJPW7sGVhV9bEg07M=;
        b=CQoJAZf2DPyEeIF0GPKbgSpRbPiC9jlPkemdJxNWLnCXVZWAgXIVIfqdp+bkQa+x+I
         vCTybrud6QJatCwbZJ7HJBXB5gppAkHx0D5KYaFRQyZTmdjLhTwWNz9X5TiyOgdl62gM
         QMgDdEOW0myMC7EN5+SBuOCsemuZNRpjAYhS/9oHpkYoKgArIAgChFlA3N7+8rR7wE+p
         jAAQuMMVlyzMSSVybtWBnsz39SbeDoY1F+ltTXGnBPhalPOd3JOkDdELPutiZckcl5Zs
         axq/yf/CQC9qsSDuveyypy0/VkzhY/vc1RIIwDR6ohuFQLfsRmh1JZ0d1OyLyQYZB4lJ
         WpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796825; x=1695401625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpolqE+SEAVwVFTY41H2JAWAfBtJPW7sGVhV9bEg07M=;
        b=sVu289B97ysOtixsSKh3Q3hDN4SeF/9bSc8Vo83mRTq6NSiPaE7cZvE9a65HFpJYMs
         4+MHtj1p637QDWkJkwqE92pkRxnclYa4fu72MXYWoHxBx+PzeGiHOOfHgWhw9FplwOan
         XjVMh0BQ3+j1bE01xCj9Ng3OrMbjIrw2PCQeeadg0fgiLwK6k4uG7IqH57NS03iN+mLk
         9vyQKzhaemKSVKZ7bsfjea2vMr8bT4b4+F4vryhfk79oMJUSEIdwW4pkIUuh+guXaMFj
         iFq0VqE/qAQ7BGyRKNtuyRQugECJkbled0P5ZVgIieV3k7tHDrVYuKAGiZScc68KZiLy
         HYrA==
X-Gm-Message-State: AOJu0Yyh4dC6EdTzxIW7SBMWPLPYtKulfmC6INmpuEQyAeJbjEMOag9K
        I1ykyG+gAPYcmp4/ya6Zqyu20vENZV8oazmU0Co=
X-Google-Smtp-Source: AGHT+IHdg5qFvGAFmPjYLsoqHgR9aVE+mxhLvc6aKZLyM2Lf8HzCOCEXGWDSsjgJmyQBolmCaP2cdGU4Fzy9TenO3Dw=
X-Received: by 2002:a17:903:1109:b0:1c3:bbad:9b7c with SMTP id
 n9-20020a170903110900b001c3bbad9b7cmr2546503plh.31.1694796825027; Fri, 15 Sep
 2023 09:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230915024559.32806-1-haibo.li@mediatek.com> <20230915094004.113104-1-haibo.li@mediatek.com>
In-Reply-To: <20230915094004.113104-1-haibo.li@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 15 Sep 2023 18:53:34 +0200
Message-ID: <CA+fCnZd0FkKNf1ZQxbXWvNM8NAt=ML+yXu5n4VgLOmhFf9TPfQ@mail.gmail.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     akpm@linux-foundation.org, angelogioacchino.delregno@collabora.com,
        dvyukov@google.com, glider@google.com, jannh@google.com,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mm@kvack.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com,
        xiaoming.yu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:40=E2=80=AFAM 'Haibo Li' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> I checked inline mode just now.kasan_non_canonical_hook can print
> something like below:
>
> Unable to handle kernel paging request at virtual address ffffffb80aaaaaa=
a
> KASAN: maybe wild-memory-access in range [0xffffff80aaaaaaa0-0xffffff80aa=
aaaaaf]
>
> When addr < KASAN_SHADOW_OFFSET meets,the original addr_has_metadata shou=
ld return false
> and trigger kasan_report in kasan_check_range.

It should, but I don't think it always does. But if it works for you,
let's leave it at that. I'll double check why it failed for me later.

Thanks!
