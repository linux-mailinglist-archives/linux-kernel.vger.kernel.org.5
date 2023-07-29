Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A37F767FE4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjG2OCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG2OCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:02:03 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72552170C;
        Sat, 29 Jul 2023 07:02:02 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5768a7e3adbso60701627b3.0;
        Sat, 29 Jul 2023 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690639321; x=1691244121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uej329s45KkVH10EqRXtGCjf7THagYVhWkJTqh/hnU0=;
        b=OdYzqFbnrfQpcK7dg0Mw1mPlqUwOFsXlLi2LjA5rrYJFfrNhKplNIsVtegWKg09U3Z
         oYp3gc2AVIZJQzSkiSi9puqWT+uuG2fxV21p/YljkGIa+OVPzsQvo4ElcNWzbWyngO6s
         62CjFspUJnFHoq+Tkdbbd66vMMDlsQ66m35sGGSxnJcYMUBiTvaPa3cl7cFWGNoB3h+k
         Dl7vBWHAUGw8gjW2wajORG456ei2ZiqTR4dBs67eWTVP8uj5Ks7Yuar5VUws+0sBjTcw
         r/Sj//k1Xb24fRVwN6gBXh/vhhhQMccvjwiwvGnmAWBwWPmDaRgrfPRaLKgMgOFaQP7x
         d02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690639321; x=1691244121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uej329s45KkVH10EqRXtGCjf7THagYVhWkJTqh/hnU0=;
        b=AlwwMKaC8ZcfgjigxdD4mB15khOgLk0luH40PE6YhgW1G7+joDmQudPPuYzP/Tc5MU
         L1Ft1rSXkFjGuKcGw+s4xiZqzTHk6DXoYEMm0yRG7XVX/GAcVG8aL0vjFat2JbOx/cTw
         us4aY1NABbogPzVfRyeYqmaSyYonLsjnYREeZnWdXV9q+Dvwr219JRlaPMvWfk+94Nvg
         2Z7vT+LEFVFJ6h6QdBMhHwpBRvJocmbUVzYvlFCDD3UE0qpGok3gQ2FGdkPs1Fh/HZeL
         mMwha2NwH1CjJ11ko4673mRpuoBlvcc8OaclQShcDdPiYJjmmZXlRXGTY1ATyKOl3HL7
         BnyQ==
X-Gm-Message-State: ABy/qLZYbvTalychDPnTfbGDjrSceoSY0frjsD93wAmm3fNfPyNQz1eI
        Hpzvv3bbZF3fCC87my27NSRapwO+EJetbhCSA5NOX06D
X-Google-Smtp-Source: APBJJlG+F2fxY/NjC4mUcah1DHm1ziY/bl94tYwS3c2gjq5X7XxVeBevUJvtC1TP8//JlZK6cYsDZcZHtqjsn711YyY=
X-Received: by 2002:a81:52d3:0:b0:56d:463b:7cf3 with SMTP id
 g202-20020a8152d3000000b0056d463b7cf3mr5902086ywb.13.1690639321309; Sat, 29
 Jul 2023 07:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230625232528.89306-1-boqun.feng@gmail.com>
In-Reply-To: <20230625232528.89306-1-boqun.feng@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 29 Jul 2023 16:01:50 +0200
Message-ID: <CANiq72kaoCNCjEVDDrrEY7QJ-rAScDCAuVsSw-oimL9ZdGOXug@mail.gmail.com>
Subject: Re: [PATCH v2] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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

On Mon, Jun 26, 2023 at 1:25=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> While there are default impls for these methods, using the respective C
> api's is faster. Currently neither the existing nor these new
> GlobalAlloc method implementations are actually called. Instead the
> __rust_* function defined below the GlobalAlloc impl are used. With
> rustc 1.71 these functions will be gone and all allocation calls will go
> through the GlobalAlloc implementation.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/68
> Signed-off-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> [boqun: add size adjustment for alignment requirement]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to `rust-next`, thanks! I will use it as a base for the 1.71 upgrad=
e.

Cheers,
Miguel
