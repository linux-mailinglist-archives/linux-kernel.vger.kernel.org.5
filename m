Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2EB784850
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHVRSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHVRSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:18:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86107D88
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:17:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2703488f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692724676; x=1693329476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVxH8gZtgJYxnVhZVMJiqe8tMcZ7bLjPOLe18Ze4lL0=;
        b=lPJQqMMDcohJF2JdOsK63KunlvjahCqtIQcc/RYTdukta+Dp6uZ20GNq+fQnzNPrtx
         zE0Yw1wuqLQtgpFziCB01PGnkAqotVgacE8aIY6L/jfvH6QhkaZiVdVxc81h7wZJjoz/
         gN96ucsushvA81Ntq2eWLfTdDwwZWk0ZyQN54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692724676; x=1693329476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVxH8gZtgJYxnVhZVMJiqe8tMcZ7bLjPOLe18Ze4lL0=;
        b=KrvNqlqUhTw3feRxD84Cky4Jn6ScNB2xFu13FtpPZjKH2Zg75b3zeGRLzn8TqmHfB4
         HJuVBe4OUfNznMekECC9acfRcgCJzvVPDKpd2YTtCnnDDnAR3EGJZFNxjOmhuTu7Lmye
         m0yVk9PnrUOp6JS7cXi3itWpGZqy0yS8x4tAyYARVPAIDOOwGXVUpAqQGdNTuwDsvZNm
         u9Ycx2GmUi4oQPUtl2u2MVfM660fWDC5uCknJEWPRTQx8vQLm93adsesrKs5+X/43xAe
         vpzDkXSxQJ5YkUfDxeQicy7rCRQMOMhyJA1T/M8bNfOpbsJFqNMjXaeaBQkrRRTLJWlF
         TqrQ==
X-Gm-Message-State: AOJu0Yy7K1nuZDgOzdd8CeUY3T5KD5odK+j+JBYTcCr10SZ4xOBZj4D6
        aXm80OVWwI4ZGswCxSQ+ns9AuSiqLDjn+rGUTiuz5w==
X-Google-Smtp-Source: AGHT+IEQzodyd9vz4B621/6cy5AO6Fbt3D8H/LzvFpY5S44hM1nSd7SCg1qWjxx8fR3UGrUZPBRPQY8eS6S5g0RbKIg=
X-Received: by 2002:adf:f70c:0:b0:317:5af3:caa4 with SMTP id
 r12-20020adff70c000000b003175af3caa4mr7859759wrp.38.1692724676163; Tue, 22
 Aug 2023 10:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230822065256.163660-1-denik@chromium.org> <CAFP8O3J2pUddEfL+W2j=tpjdj1ufsQMJqjcARbYvY3+khtBPig@mail.gmail.com>
In-Reply-To: <CAFP8O3J2pUddEfL+W2j=tpjdj1ufsQMJqjcARbYvY3+khtBPig@mail.gmail.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Tue, 22 Aug 2023 10:17:45 -0700
Message-ID: <CADDJ8CWon2yh=vW73W-88pSaU+J1UfPwhJ7++iAWwnUXvTJD9g@mail.gmail.com>
Subject: Re: [PATCH] modpost: Skip .llvm.call-graph-profile section check
To:     Fangrui Song <maskray@google.com>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the prompt review!

On Tue, Aug 22, 2023 at 12:06=E2=80=AFAM Fangrui Song <maskray@google.com> =
wrote:
>
> On Mon, Aug 21, 2023 at 11:54=E2=80=AFPM Denis Nikitin <denik@chromium.or=
g> wrote:
> >
> > .llvm.call-graph-profile section is added when the kernel is built with
> > profiles (e.g. -fprofile-sample-use=3D<llvm.profile>).
>
> Right. .llvm.call-graph-profile may also be added when the kernel is
> built with clang -fprofile-use=3D (though instrumentation-based PGO
> support is not upstreamed yet).

OK, I will add -fprofile-use.

> > The section holds
> > metadata for symbols beloning to other sections and hence doesn't need
> > modpost checks.
>
> Typo: belonging.
>
> .llvm.call-graph-profile contains edge information derived from text
> sections, so .llvm.call-graph-profile itself doesn't need more
> analysis as the text sections have been analyzed.

Ack.

Thanks,
Denis
