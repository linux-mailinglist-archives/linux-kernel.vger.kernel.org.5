Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AFD770558
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjHDP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:56:15 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D0170F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1691164570;
        bh=UamAAPVxLlb4vLDRTAEBwV6EBxinnwPqEAjS6+WRhUE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mm6arzXTW2JF1RsjidNfqSIiw1lbWWRWOlaqLM+OF1IR2XYrXNuzKz27Rm7VQ6oNJ
         0aLNFrShYbd+6mLzPHc8J54W5c88wEVFJCjyRMXbTwYs06jl5gtynbfXTZGwOqDI/u
         a1PRqp1+oF7NDFA64LkPU0DW8ujDgKJmIcIeaTbA=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 110BA6599C;
        Fri,  4 Aug 2023 11:56:08 -0400 (EDT)
Message-ID: <b1617fe221f137b49b9a2ba9c864e6b85f89de81.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Drop -ffreestanding from CFLAGS
From:   Xi Ruoyao <xry111@xry111.site>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Nathan Chancellor <nathan@kernel.org>,
        loongarch@lists.linux.dev, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Date:   Fri, 04 Aug 2023 23:56:07 +0800
In-Reply-To: <CAKwvOdmt+p3KM23hz2BfheoWgEa0G9QKnAFYUP+EL2Ta5LXUUg@mail.gmail.com>
References: <20230804125609.2054719-1-kernel@xen0n.name>
         <CAAhV-H5g-jmeQMhicrqhpStV9n0Z-EZ1dZAsuT2hmOaHki4ucg@mail.gmail.com>
         <CAKwvOdmt+p3KM23hz2BfheoWgEa0G9QKnAFYUP+EL2Ta5LXUUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 08:46 -0700, Nick Desaulniers wrote:
> > Not all processors support unaligned access, so we need the
> > alternative mechanism to select memset/memcpy/memmove implementations.
> > If remove -ffreestanding, the builtin implementation cannot be used on
> > all hardware.
>=20
> That sounds like a compiler bug in that compiler's implementation of
> string.h builtins then; it should default to the safest implementation
> (aligned accesses) until instructed otherwise.=C2=A0 Have you filed a bug
> against your compiler vendor for which compiler you observe that
> behavior from?

AFAIK there is no such bug in GCC.

But GCC indeed has a bug about builtin expansion: it generates really
stupid code for __builtin_memcpy and friends.  See
https://gcc.gnu.org/PR109465.  The bug is fixed for GCC 14, but GCC 14
won't be released soon.

> At the very least, there should be a comment above the addition of
> -ffreestanding justifying why it's being used, probably with a link to
> the above bug report.
>=20
> I would expect either -mcpu or perhaps some other -m flag to guide the
> compiler when it is safe to emit memcpy (and friends) in terms of
> unaligned access or not.

It's controlled by -m{no-,}strict-align.  LoongArch kernel defaults to -
mstrict-align, with this the compiler should not generate unaligned
access.  -mno-strict-align is hidden behind CONFIG_EXPERT (FWIW I
personally dislike the decision to hide it).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
