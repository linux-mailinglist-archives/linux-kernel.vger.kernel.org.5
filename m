Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5737FA1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjK0ODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjK0OBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:01:24 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934352D66
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:58:36 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2e4107f47so2842107b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701093516; x=1701698316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmo2BXJt4vu1ubmwTuoFwrhznc8Bcf+/X8CnL/h9xfg=;
        b=gJ3rI29guMBiS0nrH26lQVxYKSFGwlTWO7iS3xkOHel+ytBqgREUsk8h3wM4+l5KOu
         YqVnQMKZSWtn8QFXWPBr7QRJc2l71afnM4wPt2Tr9vQxaPMcseI6Jr4UOQd9TMZDhDv/
         Knc9zmZ1UgMik5MKU60O8Fd9svFzJhtOUtC+Aj2nKKvC5JmF4vlFgJr47hWk7cQaw2Eg
         CKOCr2jCB2p0uI6QZWRZ3SWORd/NXwhfV3unDN3XUsU9JQGRKyBB8QQNcrpweDK/uG4f
         x3FDAZXunD2bBRw23Hbk4Yj7KSJWmNejF+V/dIqY8QN0zDuz3018ydTcLFVbDg1ImxDY
         nqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701093516; x=1701698316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmo2BXJt4vu1ubmwTuoFwrhznc8Bcf+/X8CnL/h9xfg=;
        b=NEX9tO3smENBXzGW4Sv9s7Id1pktZY4Zox+NHDKTOjXev5l/pHbdDh4W7kv68sCQVN
         kbtjGiDEhjDF4dtHgDKMHPz2fXFZGKB8JYdZHRYk4kgHMFN0DUES8yvpgzQcdtKdfhJR
         OZZWtex5jQGlPnqnYjTUgaUvOKHInde9LuU8Xv5m3k9hJpkBipGHS6kOXde6l47/ObR1
         7SatZIHkDE8xWbeOFhpWKVJXhAkF5+bKMBSJB3u179YaX8bAo1bjfu0DIlEk8iX0jLsQ
         X+tUjJNl58CgkIdSR+LVtrF2q9XFr3ncu9bzaYzv7X2XWjPIxTXpbm8O3TJSduhyI6Q5
         1Uew==
X-Gm-Message-State: AOJu0YxO96LgdM/RE2VLFt/E/CWTHMYdiyvQTMK6moWPJNBSV8xtzxXW
        Yh1zIF9iJIGfqD/sM6Qm9xzAQ2wBu6BN9vuZEta7lA==
X-Google-Smtp-Source: AGHT+IEnf7x9cMjtRYjvssq0P5dcMj4LNZ5XXPtGxMk2IUanH6KXq2dYk3jFHBzAigZNM3g7Zrsr8HcWUx2B2UoYMA0=
X-Received: by 2002:a05:6358:5927:b0:16b:b605:d3da with SMTP id
 g39-20020a056358592700b0016bb605d3damr12692052rwf.28.1701093515725; Mon, 27
 Nov 2023 05:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20231031201752.1189213-1-mmaurer@google.com>
In-Reply-To: <20231031201752.1189213-1-mmaurer@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 27 Nov 2023 14:58:25 +0100
Message-ID: <CAH5fLgjFGTfWr-O9LPBtvwkwo5o=jYMByjqS+7gogGoYT4=x3g@mail.gmail.com>
Subject: Re: [PATCH] rust: Suppress searching builtin sysroot
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Jamie.Cunliffe@arm.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 9:18=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> By default, if Rust is passed `--target=3Dfoo` rather than a target.json
> file, it will infer a default sysroot if that component is installed. As
> the proposed aarch64 support uses `aarch64-unknown-none` rather than a
> target.json file, this is needed to prevent rustc from being confused
> between the custom kernel sysroot and the pre-installed one.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

I guess these are the only places where we need the sysroot parameter
because the other rustc invocations compile for the host target
instead?

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
