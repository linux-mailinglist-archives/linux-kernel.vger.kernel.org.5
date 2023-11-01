Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3327DDC15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbjKAEuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345092AbjKAEuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:50:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F5C103
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:50:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so7748a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698814200; x=1699419000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhQrGrRiXOP6T/LjlMKW+7pqde7WtEKCtrVNN6uAKIY=;
        b=GFGQ5JyxZLdxHR4X1IudqTZgn0B9fhT2jThnnP88CsB5w6UHDavcl1wvaMKeTJOQ5U
         NIM9nzE1qbb52hq+c6JV3NQNUYDi5jtUphaFM0ss5S+9tnzNztjP7/B0AX6LGUr6/aic
         wjAJfm7pIIcdf/zmlX5KnuioGyFFIGTs0KC/fNwhgKPGzWz8s3KhAO+TJw8WrnVYK8KN
         G0c97pWdPJwdH/n2/+a5lKbzNuJyo7I+4EYH6YyCiqFu+E8DJYvfDBMRmbOkGodw4Cg/
         cx3ZY5sZ5WPiVV+WQ5dbUX5f9OhCWmYWR0zrIVVowD4+Z/r/hZ/66Mc/gsYrNP90m4Md
         rA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698814200; x=1699419000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhQrGrRiXOP6T/LjlMKW+7pqde7WtEKCtrVNN6uAKIY=;
        b=mQWdKAz3wYurft7YRg6qUfbhXOJvqE2xcEDadqck1dHxI0627VlWsTVLAhUIiJ3976
         9Kuuc1/SWFgUO5cE5DNF+cl1XCczls7z435cgD6H87ggeg25Xk7PUSU+87yBV5mLLBMm
         +RLH0AMEBorGx7128IXRDYDQBZgW5zfQCSUnKmwwk4o6Ta6epnylTQg/d/z/g+TJieQd
         OL2jXcTyzLoA/R7qe03FC4p/uU7s2Zxvgjuq3PySADeQT8vOGzerP/7Ppbohjt+l8NdJ
         aSOMWQlewnNAm42raetNnkcKV8dghqrZbvdiVV6mfR3sGdnND5zSZFjtmp5Hhg3izqgt
         qQXA==
X-Gm-Message-State: AOJu0YzRlnVXSY6g1mHMWmCYn01fBCi+c+wuE+v9Qqfb3VHkmoaUZtuE
        4iQvGWPX2zpDeTj2sxB9p2Xo7aEpnqXf9kSL0dse4g==
X-Google-Smtp-Source: AGHT+IHxAeRmRNwusd8SDjsAoXM6juVtUd+PfRg+3YUq/OHZ9FhyQX9RugH2kSnb5B3Bir6sLB+JT2x3UIjYR1Fpsdk=
X-Received: by 2002:a50:c04f:0:b0:542:d737:dc7e with SMTP id
 u15-20020a50c04f000000b00542d737dc7emr258881edd.0.1698814199560; Tue, 31 Oct
 2023 21:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
In-Reply-To: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 1 Nov 2023 05:49:45 +0100
Message-ID: <CANn89i+YpJ+y23f=b0uByVJCqh1Rjau44vP-saRD60kFG7J4fw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com,
        0x7f454c46@gmail.com, fruggeri@arista.com, noureddine@arista.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
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

On Tue, Oct 31, 2023 at 9:23=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=3Dy) when CONFIG_TCP_AO is set:
>
>   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement =
is a C23 extension [-Werror,-Wc23-extensions]
>     663 |         }
>         |         ^
>   1 error generated.
>
> On earlier releases (such as clang-11, the current minimum supported
> version for building the kernel) that do not support C23, this was a
> hard error unconditionally:


Reviewed-by: Eric Dumazet <edumazet@google.com>
