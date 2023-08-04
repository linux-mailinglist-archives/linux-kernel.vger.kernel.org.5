Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7D76F6AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHDAxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHDAx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A13A87
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D14961EFC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEDFC433CD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691110406;
        bh=CRmotsznYKjfyxND77PAQgXyzRhutmmLl0P7dFI46Jc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V/mVaAyZGqlEkS1DLcBC4ugem8ZUyfYTmZPgPoI2SVAEOz7xWrJ2r3DaSouk22l8B
         1hFPittVwSQFWgorxDqTjHPLmXPs4bHnao90o8YD4YYBXKrHgZvYxyZgEHg7mxizvH
         cHpk1JOyK1pwwiLu+k09UYVnghkOrxNGMoy3SPF+SFZ/iRndu95H29uzqrhPPfH92g
         qqIvRIMKlAHpgwUnuSBkzeu+y2PFGnnQ4HvQwkMIcACsFUYDIHLhp7D9LMxhZvKNHN
         iZmkoxnyUk+CYkw8bfEDBol7pIOJ0FgCnQlUch5ec0JfSotADo/5xOysjfeVVqhBV4
         Db2RtgiGtzUrg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso1936784a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:53:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMQBe1k42GKDGoVpim+bMwDYWTmliKfbscoXXt7diom/+kL11a
        O7khHIh7wEW8JDJTiEJB06SzvlmtJAxJQLudbr8=
X-Google-Smtp-Source: AGHT+IEnV9QSSBYloqeE8Xn7qAxFwf1C0m/rkTGjFo8DmCyz7GtOfrlz92sjGCS0P2GJoseOlCzNAAPS88qz2s2/i44=
X-Received: by 2002:aa7:c64f:0:b0:523:f04:b2d3 with SMTP id
 z15-20020aa7c64f000000b005230f04b2d3mr317242edr.11.1691110404557; Thu, 03 Aug
 2023 17:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230803051401.710236-2-leobras@redhat.com>
In-Reply-To: <20230803051401.710236-2-leobras@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 08:53:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTShfMzVZw5TVqBvLNAzEBMzhWxNGC9JS70euPcKKN85zQ@mail.gmail.com>
Message-ID: <CAJF2gTShfMzVZw5TVqBvLNAzEBMzhWxNGC9JS70euPcKKN85zQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Deduplicate RISCV cmpxchg.h and atomic.c macros
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 1:14=E2=80=AFPM Leonardo Bras <leobras@redhat.com> w=
rote:
>
> I unified previous patchsets into a single one, since the work is related=
.
>
> While studying riscv's cmpxchg.h file, I got really interested in
> understanding how RISCV asm implemented the different versions of
> {cmp,}xchg.
>
> When I understood the pattern, it made sense for me to remove the
> duplications and create macros to make it easier to understand what exact=
ly
> changes between the versions: Instruction sufixes & barriers.
>
> Also, did the same kind of work on atomic.c.
>
> Note to Guo Ren:
> I did some further improvement after your previous reviews, so I ended
> up afraid including your Reviewed-by before cheching if the changes are
> ok for you. Please check it out again, I just removed some helper macros
> that were not being used elsewhere in the kernel.
I found this optimization has conflicts with the below patches:
https://lore.kernel.org/linux-riscv/20230802164701.192791-15-guoren@kernel.=
org/
https://lore.kernel.org/linux-riscv/20230802164701.192791-5-guoren@kernel.o=
rg/

If yours merged, how do we support the inline cmpxchg/xchg_small
function? It's very struggling to use macros to implement complex
functions.

Could you consider a more relaxed optimization in which we could
insert inline cmpxchg/xchg_small?

>
> Thanks!
> Leo
>
>
> Changes since squashed cmpxchg:
> - Unified with atomic.c patchset
> - Rebased on top of torvalds/master (thanks Andrea Parri!)
> - Removed helper macros that were not being used elsewhere in the kernel.
>
> Changes since (cmpxchg) RFCv3:
> - Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
> https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/
>
> Changes since (cmpxchg) RFCv2:
> - Fixed  macros that depend on having a local variable with a magic name
> - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/
>
> Changes since (cmpxchg) RFCv1:
> - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
> https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/
>
>
> Leonardo Bras (3):
>   riscv/cmpxchg: Deduplicate xchg() asm functions
>   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
>   riscv/atomic.h : Deduplicate arch_atomic.*
>
>  arch/riscv/include/asm/atomic.h  | 164 ++++++++--------
>  arch/riscv/include/asm/cmpxchg.h | 318 +++++--------------------------
>  2 files changed, 123 insertions(+), 359 deletions(-)
>
> --
> 2.41.0
>


--=20
Best Regards
 Guo Ren
