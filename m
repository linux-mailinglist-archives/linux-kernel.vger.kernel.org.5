Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E847B4CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjJBHmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJBHmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:42:44 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4781B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:42:40 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49a319c9e17so4769945e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696232559; x=1696837359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSh85qp98TAtPCnT67pcz20dczDxxqTD4YcLwPP44io=;
        b=kCNawjjI/f4n+biV+vLjAA/Cfl6jcOXHeKOk6l1DA+XWCEw7e9oVx73OoewqH0LByQ
         +bzuu0sAWaZYVwCLahYw+AukSMGBd7pll8bDsGEWTI0KsZB6jskePOTvjQBwKXBM0XAB
         bwFAZNoS3nvrC759EuJ9C5P8R/AeSST675QPXxop/lqONFbnhx4tzfwsP+2aS1+tuq9y
         3g6AnYWtZMCAniGXwxEg8IO43lILdpQBB9hVZ0p68LFPBqFrN+OuQWhR6tJLKxp804S+
         +SjVQNgF7PS52qa5Lel7ragBcrINhcf0LT7zRq7aGv2DSQI47Hl5DsAw6T4OaJg6tGqm
         l/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232559; x=1696837359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSh85qp98TAtPCnT67pcz20dczDxxqTD4YcLwPP44io=;
        b=mEtnZ8FmiNGq2cALfDO+XSLgO96WLZnY39AVTx3dshTOWZnNdLs9fc09H8YdoaulGU
         CAYikp6QdlVj+mp6twQoe4Chgc8MwUAh7x4jv9ZVbd+Kicq6qDd6/gt11LwYuDBL+qoG
         ajjJLKZpKhWcqYqL4/eBK22eEvL81Pv63hHf0BReqd3GXGrLoghTFGR4qyZSROGDHG9m
         7f68fKeFAHS5idMLaHJV5Ej+YwcXEG1rvMGParafurNbGad8n02DVWYw8Aw5OeSzn14x
         ZdBVc1LOhlz2SqSyi46vY5a6byNRzwRWnwavo3NsnOHlFdV9WnQ448E6upaW+602lcrP
         IXwg==
X-Gm-Message-State: AOJu0YwA59fTe+BvJ3D4AnEdnrQdFiBjvwhjE0YzvwIq5U3ApCwPqlSz
        tPt5KuWdrAbgsGOrW/YxiEq0fKWr/+bLRqMsNejJxA==
X-Google-Smtp-Source: AGHT+IHiH489RsoEvG5mrvyEeCxTptwArpNqWcQAsB6rSnXOWlpgRvQ3FVsqD93DxR1muZRoq/7CFunpI/fq4emM2Mw=
X-Received: by 2002:a1f:ca82:0:b0:496:f00a:88b2 with SMTP id
 a124-20020a1fca82000000b00496f00a88b2mr6397262vkg.7.1696232559619; Mon, 02
 Oct 2023 00:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230928194801.2278999-1-mmaurer@google.com>
In-Reply-To: <20230928194801.2278999-1-mmaurer@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 2 Oct 2023 09:42:28 +0200
Message-ID: <CAH5fLgjUa+TRO_xOQp-uRo5wC8+iVgSh+MA573EjfFtiHbA4mg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 9:48=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined,
> resulting in build failures in hermetic environments where `cc` does not
> exist. This includes both hostprogs and proc-macros.
>
> Since we are setting the linker to `HOSTCC`, we set the linker flavor to
> `gcc` explicitly. The linker-flavor selects both which linker to search
> for if the linker is unset, and which kind of linker flags to pass.
> Without this flag, `rustc` would attempt to determine which flags to
> pass based on the name of the binary passed as `HOSTCC`. `gcc` is the
> name of the linker-flavor used by `rustc` for all C compilers, including
> both `gcc` and `clang`.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Tested-by: Alice Ryhl <aliceryhl@google.com>
