Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203B576F7DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHDC3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjHDC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:29:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80CCA3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E0DA61F0B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22E7C433CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691116183;
        bh=zWadd+nLUkzK7Qkbi0JVFnWY+DZxXhVnu+uRMkl4cvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rWbHkLeF5jvoprucAQG1R8Avh37uG37xxu2sUcV+o8GF/yDfwXphZkafQmlfmRv1l
         H3MwogSRVk7Ke2F/Jy79Rxn6wnArkuVcymJB/Fa9RSgbiVpgtQ30b7yPCKqUfw0CU+
         JwhX35MVy5+gtiDt+FwkLIiC+VZLZOL7+HhWUfiazF2QQkNVwy4gqCHGFrvjuiNUSk
         ZdfgsWnovVcT793V5y7tnuv/6L/8z4FnumDs1ZS5MI0fELD7jp25SNiNbXrVIEMWEx
         5aFLFrwdSNwhAM6k9FDrzbRiE3YM1qTRp0b1w+rikRpmnKkco47/4r29Vz6hfomA/6
         i0atXJuJUqZNA==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso1439320f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:29:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YyqSWOljuaPoSyOpRhQW8cKXWd15dspocpZiViR72mmQH/5IDe5
        mjRvStQJaynAk4RJldoEu/9rygwwPM4xjk6jdgw=
X-Google-Smtp-Source: AGHT+IEkPAXOGnXrKYu3Sb56FrbeQ2U7eXDYfeJXqFRBo1QS/XiQ3WATCmqBu/Ez1NjatdFQ6vwQ4mjmPIWf98kZesc=
X-Received: by 2002:adf:ebcc:0:b0:317:6a07:83a7 with SMTP id
 v12-20020adfebcc000000b003176a0783a7mr217303wrn.38.1691116181741; Thu, 03 Aug
 2023 19:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230803051401.710236-2-leobras@redhat.com> <CAJF2gTShfMzVZw5TVqBvLNAzEBMzhWxNGC9JS70euPcKKN85zQ@mail.gmail.com>
 <CAJ6HWG5mzxN=txnbdi-=c+=wLsDfSe7Me+1DQE79ZX0NN6U1_g@mail.gmail.com>
In-Reply-To: <CAJ6HWG5mzxN=txnbdi-=c+=wLsDfSe7Me+1DQE79ZX0NN6U1_g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 10:29:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTag3hR7ZgM8o+yk+0Ox3A+xm4jAVTikAA0HqXQFKayRA@mail.gmail.com>
Message-ID: <CAJF2gTTag3hR7ZgM8o+yk+0Ox3A+xm4jAVTikAA0HqXQFKayRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Deduplicate RISCV cmpxchg.h and atomic.c macros
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
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

On Fri, Aug 4, 2023 at 10:20=E2=80=AFAM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> On Thu, Aug 3, 2023 at 9:53=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Thu, Aug 3, 2023 at 1:14=E2=80=AFPM Leonardo Bras <leobras@redhat.co=
m> wrote:
> > >
> > > I unified previous patchsets into a single one, since the work is rel=
ated.
> > >
> > > While studying riscv's cmpxchg.h file, I got really interested in
> > > understanding how RISCV asm implemented the different versions of
> > > {cmp,}xchg.
> > >
> > > When I understood the pattern, it made sense for me to remove the
> > > duplications and create macros to make it easier to understand what e=
xactly
> > > changes between the versions: Instruction sufixes & barriers.
> > >
> > > Also, did the same kind of work on atomic.c.
> > >
> > > Note to Guo Ren:
> > > I did some further improvement after your previous reviews, so I ende=
d
> > > up afraid including your Reviewed-by before cheching if the changes a=
re
> > > ok for you. Please check it out again, I just removed some helper mac=
ros
> > > that were not being used elsewhere in the kernel.
> > I found this optimization has conflicts with the below patches:
> > https://lore.kernel.org/linux-riscv/20230802164701.192791-15-guoren@ker=
nel.org/
> > https://lore.kernel.org/linux-riscv/20230802164701.192791-5-guoren@kern=
el.org/
> >
> > If yours merged, how do we support the inline cmpxchg/xchg_small
> > function?
>
> Oh, I actually introduced my series so I could introduce new xchg and
> cmpxchg for size 1 and 2. Is that what your patches are about, right?
>
> I was working on that yesterday, and decided to send the patchset
> without them because I was still not sure enough.
>
> About implementation strategy, I was introducing a new macros for xchg
> & cmpxchg with asm which would work for both for size 1 & size 2, and
> use the switch-case to create the mask and and_value.
>
> You think that works enough?
Good, go ahead.

>
> > It's very struggling to use macros to implement complex
> > functions.
>
> I agree, but with this we can achieve more generic code, which makes
> more clear what is the pattern for given function.
>
> > Could you consider a more relaxed optimization in which we could
> > insert inline cmpxchg/xchg_small?
>
> What about this: I finish the patches I have been working with
> (cmpxchg & xchg for sizes 1 and 2), and if they are fine we expand
> this patchset with them.  If not, I try relaxing them a little so we
> can merge with your set.
>
> Does that work for you?
Great, you could provide cmpxchg & xchg for sizes 1 and 2, then my
patch series would base on yours. After tested, I would give you
Tested-by.
>
> Best regards,
> Leo
>
>
> >
> > >
> > > Thanks!
> > > Leo
> > >
> > >
> > > Changes since squashed cmpxchg:
> > > - Unified with atomic.c patchset
> > > - Rebased on top of torvalds/master (thanks Andrea Parri!)
> > > - Removed helper macros that were not being used elsewhere in the ker=
nel.
> > >
> > > Changes since (cmpxchg) RFCv3:
> > > - Squashed the 6 original patches in 2: one for cmpxchg and one for x=
chg
> > > https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.c=
om/
> > >
> > > Changes since (cmpxchg) RFCv2:
> > > - Fixed  macros that depend on having a local variable with a magic n=
ame
> > > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> > > https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.c=
om/
> > >
> > > Changes since (cmpxchg) RFCv1:
> > > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build e=
rror
> > > https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.c=
om/
> > >
> > >
> > > Leonardo Bras (3):
> > >   riscv/cmpxchg: Deduplicate xchg() asm functions
> > >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> > >   riscv/atomic.h : Deduplicate arch_atomic.*
> > >
> > >  arch/riscv/include/asm/atomic.h  | 164 ++++++++--------
> > >  arch/riscv/include/asm/cmpxchg.h | 318 +++++------------------------=
--
> > >  2 files changed, 123 insertions(+), 359 deletions(-)
> > >
> > > --
> > > 2.41.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--=20
Best Regards
 Guo Ren
