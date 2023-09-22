Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041417AB4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjIVPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjIVPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:30:17 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CBDA3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:30:11 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-495bcd861ccso906372e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695396610; x=1696001410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy/RfO3zn4ylyaZcM6jpLeM6PDtn4HoNfcn9A4ihbHA=;
        b=Vha+qa6nvTcf7jlLZcZKBB0HhXbk9nREif1xvvXOH3wSTl9W0LpbEH3CskBG5lRtrv
         Lu0h7asrshqLz2FACEDC/HqqE0vPLuknu8tQntJe76bSkAVEGhuEnp1uK9UbkoSiU8L9
         FRdfYOmgdUUYQj4svMHTzByRhOF7vSTrWr+Zqe9wiZ4mSWXuicTJYKDPBlDm1gsN08w7
         z2/7Mfnpnh6QLhzF2aw57ttNOa1wDVv4evE90yLCCZS5Jslb1+HpW83kRUIXJaZfnxZq
         riX+NjLFND6LADQK4F6NQsmYWU2Nmo/ddStMRdE2960PIbqYwKmll3GteWNc0kH5Vxsv
         CSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695396610; x=1696001410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy/RfO3zn4ylyaZcM6jpLeM6PDtn4HoNfcn9A4ihbHA=;
        b=K+N+1g64wU8/g4xT+zHl0WDTk1+4q395dPzfjALNTGrcxA17Cm7c1PkGBT4ul77Y9v
         Y1jdMLXQOPEM1SnOxBeTz+KxC66431pdVqHMcUqo8NwUPROhX5tX7WVmXhwCLysM5aoA
         4bH0RInKz4MkaOJHFNrG654sdgKnAlKnJ8uUllErtZmmy3om5I/N1rJRvb25Pp7TOTNg
         Lxetb/x+1WsDuFJ4Td/ZTyippC1ncI+XhJ5NrE7QmxN52/nX2oy0tIJGRsKyW6Gq0TUQ
         870DT3TOvSGaxeX+xIxDMudRBlRdA32fcX6sux3ehd3O5e7aBAGROCZA9XHv6Ne8Xl0k
         qdfQ==
X-Gm-Message-State: AOJu0YwJt/Xf6LK40tLuHqwsyMwfkcaD0e2yALqUJsjVDF/DIrak0OcL
        u73F7Yf8OPZLnfv21B83f8wDC+Akv+BMxsws2mNklg==
X-Google-Smtp-Source: AGHT+IHdk61U4PYzvGr/Ngg5pjZczOmu81+1AngBgUDzN/+gAODCnFVKjyavIjkP+OrtLjNbnyovqObUsLtGPTH+hW4=
X-Received: by 2002:a1f:4fc7:0:b0:488:23bc:6d0f with SMTP id
 d190-20020a1f4fc7000000b0048823bc6d0fmr7395023vkb.16.1695396609288; Fri, 22
 Sep 2023 08:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230921213440.202017-1-wedsonaf@gmail.com> <20230921213440.202017-3-wedsonaf@gmail.com>
In-Reply-To: <20230921213440.202017-3-wedsonaf@gmail.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Fri, 22 Sep 2023 17:29:58 +0200
Message-ID: <CAH5fLgj_wQtmW4A6-4wPeP-Qmk2ga2NoVRwZDujjYvHWY7Bk3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
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

On Thu, Sep 21, 2023 at 11:35=E2=80=AFPM Wedson Almeida Filho
<wedsonaf@gmail.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> With GATs, we don't need a separate type to represent a borrowed object
> with a refcount, we can just use Rust's regular shared borrowing. In
> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

I wonder whether "WithArc" is a better name? After all, arc is short
for "atomic refcount".
I also think it's nice to include Arc in the name of the type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
