Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1927AA24D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjIUVPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjIUVPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:05 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B112AE381
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-415155b2796so13061cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695316069; x=1695920869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVDAf4WvVJJ7OSvhi+Yfiyx2UN4HVXEh6f4xLTULUGM=;
        b=PJLYVhgabyAZB/nH+Vf45P2uN9tLY2VwORnadwpUVrigSWWPwvlbkqXrFqv+CFZzUz
         aglGb6i4guSfgaJEtl3nnrZ66Q6UskZ7NMoRKDD6L+20q20tN1kpNEDA2eBwCTUJ78jv
         nXIWfqJVDW1YY8IerpBylFiSq46x/BRt75eSW4mkW7Sc2NNhPkCVPaTsbAbfcwUReKWh
         ycTTkMqyMbtqkUkAdoyaHZ3nwpqJE9qO65qGhaLH+m/+Q2kZrrs8AahfmXAb3AxCwGti
         jmiGSfwTF79i8k+qYkznFwv/4XrKwMfPCB1f4hsHEdEVfq1XB5C4fRXrksCuVGdtTmWd
         r8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316069; x=1695920869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVDAf4WvVJJ7OSvhi+Yfiyx2UN4HVXEh6f4xLTULUGM=;
        b=l97KJWqNYd2su1AeXAi5AeEydbog5UTtfaF3Pqhas7vBbyOY42bF0yuyRRuhYq8+Nc
         dFeGTm+TeIBRrC0iymF++YrrVdBG4vvJJV3PfbPaqhKkd8hG8Im5+KHswx5ylWP3paEm
         rf55WP09f/2CLEIWpUOwhHWj8Ryz1sOIrCZ3qqZUXnyHN+NUF98Q5ctUUdZNuGnmO2gx
         9YwjtSDogTGniWBuLq19s8ulMXyBFCkAPN6j8gaqGeLEqvUUkyI3JuwLqKJZPNTiFB+D
         Pz+WAI2OR0qJE3s+lrN3/ngMyfNuNvGpXvrhCpReagrn/RRhD9U+n58eKt8VAc91nzFx
         ToaA==
X-Gm-Message-State: AOJu0Yx7PkvAQk1cywiV6nVBKcTiWinTNBNIpW2DXcU01DbADfu9jq4n
        Ic98vOyMzcXw5TUPZIqpM/n469+9fhJ8yELqVyBikGv2rh1dQFL+7WsjOg==
X-Google-Smtp-Source: AGHT+IHhB5IobmDnc5veIt6gFjFNMEhSdUigSI1xxqe8K/+P5OK7t3buKoUeeDTzHcWQMy7ISbP8znADFgHSZBnWzng=
X-Received: by 2002:ac8:590d:0:b0:404:8218:83da with SMTP id
 13-20020ac8590d000000b00404821883damr135481qty.1.1695283104920; Thu, 21 Sep
 2023 00:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230920001728.1439947-1-maskray@google.com> <20230921072655.GA14803@noisy.programming.kicks-ass.net>
In-Reply-To: <20230921072655.GA14803@noisy.programming.kicks-ass.net>
From:   Fangrui Song <maskray@google.com>
Date:   Thu, 21 Sep 2023 00:58:13 -0700
Message-ID: <CAFP8O3+_8H+fetuoqwwcfqJLNtYmpsWZhY2arD7HMuPmcN+X_g@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation, objtool: Use absolute relocations for annotations
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Sep 19, 2023 at 05:17:28PM -0700, Fangrui Song wrote:
> > .discard.retpoline_safe sections do not have the SHF_ALLOC flag.  These
> > sections referencing text sections' STT_SECTION symbols with PC-relativ=
e
> > relocations like R_386_PC32 [0] is conceptually not suitable.  Newer
> > LLD will report warnings for REL relocations even for relocatable links
> > [1].
> >
> >     ld.lld: warning: vmlinux.a(drivers/i2c/busses/i2c-i801.o):(.discard=
.retpoline_safe+0x120): has non-ABS relocation R_386_PC32 against symbol ''
>
> What, why ?!? Please explain more.

This can be read as a pedantic warning from the linker.

A location relocated by an R_386_PC32 relocation in
.discard.retpoline_safe records an offset from the current location
(non-allocable) to an text symbol.
This offset is conceptually not suitable: in the ELF object file
format's model, the non-SHF_ALLOC section is not part of the memory
image, so
we cannot say that the offset from the non-memory thing to a text
symbol is a fixed value.

> > Switch to absolute relocations instead, which indicate link-time
> > addresses.  In a relocatable link, these addresses are also output
> > section offsets, used by checks in tools/objtool/check.c.  When linking
> > vmlinux, these .discard.* sections will be discarded, therefore it is
> > not a problem that R_X86_64_32 cannot represent a kernel address.
> >
> > Alternatively, we could set the SHF_ALLOC flag for .discard.* sections,
> > but I think non-SHF_ALLOC for sections to be discarded makes more sense=
.
> >
> > Note: if we decide to never support REL architectures (e.g. arm, i386),
>
> We have explicit support for REL (as opposed to RELA) architectures, so
> I don't think we can do that.
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
