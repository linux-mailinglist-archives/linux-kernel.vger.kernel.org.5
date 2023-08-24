Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609378649E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbjHXBfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbjHXBe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8AE59;
        Wed, 23 Aug 2023 18:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42B44633F6;
        Thu, 24 Aug 2023 01:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB050C433CA;
        Thu, 24 Aug 2023 01:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692840894;
        bh=/7o006Upl47rb2ZEQ0QeuFtlAN/y5ODL6RhQnYZ35vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F/wMwFv5sYBYPw5bb5L+8g0AsM90/CrCK/1zqMa2sVUuHd6YmqB5TZxVIuexeK5Uf
         AEem6KyYMkLlfpgAy3bs5xcR3gEOGBVLMS+ihy+pJ27Wes0b+h0ceJNXAIva46Yb1U
         FOmbkbAzKQXs+PmdLAa4oLDC8jFiZ7KxxCUyLfvE6p/Dj23rmn1zpR4NoCMh+ssTXs
         3raK4EwFhelhjul5Dd73id6ZN70imxh52HVEErwCQRsvFCT/3oE1pfHGabGy9OYTs/
         kF3ezcBHQ+GERvl09NCW2uxzk+tcBEuQQnKLD+AZ+PUy/a37Lun0zQ556a1f7ERgX3
         JKINSmBoAA4/A==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6bdcbde9676so775082a34.3;
        Wed, 23 Aug 2023 18:34:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwT1O0DVBMcNLCR+RRv8RWE34cAfUfO96n9SL+tKROLpVsytX2S
        Kj6b8+prpgql31bLSMGsbnuNMTZVf41Po2f6TRw=
X-Google-Smtp-Source: AGHT+IFhmF48+4FXAZTlFEpl1xwHwPMg6ABKZFmJchKVs5n7tqnKJG/XvppyKz4lWum7mjEURERigTMJXnux1oIYJEo=
X-Received: by 2002:a05:6870:ac0c:b0:1bf:4f5e:55e2 with SMTP id
 kw12-20020a056870ac0c00b001bf4f5e55e2mr18447012oab.53.1692840893819; Wed, 23
 Aug 2023 18:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230822065256.163660-1-denik@chromium.org> <20230822174835.253469-1-denik@chromium.org>
 <CAFP8O3KunP9CzT_U2cj1_oysojTxCNJRWX_kvvu_wOx4tbYHug@mail.gmail.com>
 <CAK7LNASstNj2HEfJHcRzqt7hay65T-yEgzaAuXbEQPuCS+yC6w@mail.gmail.com> <CADDJ8CWdm+cWt4UBTae0sCQ8ZDWhbMuozqqq59R+EtvMHere0g@mail.gmail.com>
In-Reply-To: <CADDJ8CWdm+cWt4UBTae0sCQ8ZDWhbMuozqqq59R+EtvMHere0g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 24 Aug 2023 10:34:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNARVi1sfBjv5a5OoQWPEeM-6bFuwPJE+i32NC=wdum-AKw@mail.gmail.com>
Message-ID: <CAK7LNARVi1sfBjv5a5OoQWPEeM-6bFuwPJE+i32NC=wdum-AKw@mail.gmail.com>
Subject: Re: [PATCH v2] modpost: Skip .llvm.call-graph-profile section check
To:     Denis Nikitin <denik@chromium.org>,
        Fangrui Song <maskray@google.com>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 8:30=E2=80=AFAM Denis Nikitin <denik@chromium.org> =
wrote:
>
> On Wed, Aug 23, 2023 at 4:02=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Wed, Aug 23, 2023 at 3:00=E2=80=AFAM Fangrui Song <maskray@google.co=
m> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 10:49=E2=80=AFAM Denis Nikitin <denik@chromiu=
m.org> wrote:
> > > >
> > > > .llvm.call-graph-profile section is added by clang when the kernel =
is
> > > > built with profiles (e.g. -fprofile-sample-use=3D or -fprofile-use=
=3D).
> > > >
> > > > The section contains edge information derived from text sections,
> > > > so .llvm.call-graph-profile itself doesn't need more analysis as
> > > > the text sections have been analyzed.
> > > >
> > > > This change fixes the kernel build with clang and a sample profile
> > > > which currently fails with:
> > > >
> > > > "FATAL: modpost: Please add code to calculate addend for this archi=
tecture"
> >
> >
> > Curious.
> >
> > This message is only displayed for REL.
> >
> > (Please not it is located in section_rel() function)
> >
> >
> > I think modern architectures use RELA instead of REL.
> > Which architecture are we talking about?
>
> Aarch64. There was also a report on x86-64 but the error message could be
> different there.
>
> >
> >
> > What does the output of this command look like?
> >
> > $ llvm-readelf -S vmlinux.o | grep  .llvm.call-graph-profile
> >
> >
> > Is it REL?
> >
>
>   [119] .llvm.call-graph-profile LLVM_CALL_GRAPH_PROFILE 0000000000000000
> 1c74a458 0104c8 08   E  0   0  1
>   [120] .rel.llvm.call-graph-profile REL 0000000000000000 1c75a920 041320=
 10
> I 26090 119  8


Fangrui,

Aarch64 uses RELA for other sections, but REL for this one.

I'd like to confirm if this is an expectation, not a toolchain bug.



--=20
Best Regards
Masahiro Yamada
