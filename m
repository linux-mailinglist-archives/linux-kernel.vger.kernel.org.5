Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2227CC750
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbjJQPVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344100AbjJQPVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:21:21 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A1DFD;
        Tue, 17 Oct 2023 08:21:19 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7c93507d5so69198187b3.2;
        Tue, 17 Oct 2023 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697556079; x=1698160879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDhBgsohyNMQvgoVClOoX7HtBV2amiL9Qo+GoP49do4=;
        b=POQ3QGWumVGouV/dYmG00tv3UOAP+DciRLzg9ErdgnX0rnKVx1lqrc2m3P33fJdipi
         YXeBa2tlmgJLKGq9WGtF+dg9yogQCjTFIB+RPaF35Lu1cQCI7JYIYPzfOXBg8F9NF2g7
         88MkjK9jywP5FtCWpoGDW/qqy2F9s8IsGbUJ01eplt67Rit637mdgQ3p9NNjtIJtDUGq
         KlKjc+4Pj3DZDfP2rbwo5MeL8xGAOm8aq3NqbIh+1OOK+FknvtF0ROsMuySS+CZ0vc5d
         YBF55K02s09n3P8F+kVYT+x60Qitd31K+IVzJf5gmcVf3i/3sxo1GoE2tQf6wRbOaM1c
         BQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556079; x=1698160879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDhBgsohyNMQvgoVClOoX7HtBV2amiL9Qo+GoP49do4=;
        b=MRILaR+sF9u44l362pyV5xsylP2Y1kp/hM+7qr+SH0ZXi7uA7yanDOCzzfAdDrTuCn
         Ikh9XyAN9yMgdXezb+6c7fW75UE2Mis/APZejI6R2ewBpaqQrr4TCHlbgHdiyJW7+9Mx
         SwZgcrKj+X4jXZfGkSzFxZGQwZXV04mt7C0CktXc6WDfTga1smba5fIX0i+ABN1eE512
         JHpW1trRIo/Yn6bA3yrEq9yDgslwo5L/XPRGqRqT7mT4jAmSr36jtTaRTHE70/5PmwCV
         phstOP7DUrnJiqpBXEUrCimJnV64p5aK0S8oEVOllZ5iUyExwo/q9RN1AJGJH3Lpm9s3
         QOcg==
X-Gm-Message-State: AOJu0Ywd2oIg/xgIJ2stSwG+y51Tng+oaM27DQeS3p5Ig0805BKbtihS
        n3vxMMaoGqtSXI0hMTzZnehrtHWTPnEG+oeZbgg=
X-Google-Smtp-Source: AGHT+IFiunQfYo4Ll5L97FADwFB3QhJb7RORPsyhv1/0472jUhiU3gq14vu0tGA4HR7o2Wx5p/KM4it2UpUyOqFosTA=
X-Received: by 2002:a81:738b:0:b0:59b:e449:2d51 with SMTP id
 o133-20020a81738b000000b0059be4492d51mr2478947ywc.49.1697556078990; Tue, 17
 Oct 2023 08:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231017103742.130927-1-masahiroy@kernel.org> <20231017103742.130927-2-masahiroy@kernel.org>
In-Reply-To: <20231017103742.130927-2-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 17 Oct 2023 17:21:07 +0200
Message-ID: <CANiq72krkL_50wzZeM3C6xk_C-oU1fThykCCAXY07BWbmoxptg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: avoid too many execution of scripts/pahole-flags.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gary Guo <gary@garyguo.net>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org
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

On Tue, Oct 17, 2023 at 12:38=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Convert the shell script to a Makefile, which is included only when
> CONFIG_DEBUG_INFO_BTF=3Dy.
>
> [1]: https://savannah.gnu.org/bugs/index.php?64746
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

The field in `MAINTAINERS` should be removed:

    F: scripts/pahole-flags.sh

But other than that, it looks good to me! I tried it for a given
config and it does call `pahole` with the same flags.

Tested-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
