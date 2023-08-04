Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7612276FCBF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjHDJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHDJCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF36A44
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691139355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmFvw/Mh8eaY2DQHYAo5BT2xSMzuqSWVjumlqqmuk1g=;
        b=DMZBWJjk/wafghZ+UnFsC9dd/5jD8wMl/R77kud1uliKjsFKbExXOdXJOTMLfcyrsE5jz1
        0krh9PBDOBEaCZNXoC0C91XNRSeiHdtU7lkZRsFl+zNRyoph3LfFMtlYoQV2DRR6laesiq
        aOE8fE1dOItZ5ErBkUWKl9KJN81e9n8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-NLgYPqI2P-qO5X8Yx3ua0A-1; Fri, 04 Aug 2023 04:55:53 -0400
X-MC-Unique: NLgYPqI2P-qO5X8Yx3ua0A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40ff2434811so11570771cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691139353; x=1691744153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmFvw/Mh8eaY2DQHYAo5BT2xSMzuqSWVjumlqqmuk1g=;
        b=C3eNEGUznNtL9Mq+6Q4JD73NBLfcJR13N90BaYXzlPso1f8SJyxO26fo9FGCEmseBm
         fgiypgBwUC++gEhYzrgknLMCZ/SzvFFfZjNkMx7W3uRT8hSRiRbR3ErL3gR2HCWqamef
         iUf1n38O1oSEOjEeQftKKxstOU0XLDltu+rY/CRj0FgYaeNldD8XfbISFXpy9jx9+EQ5
         HIybJCj2tPfBWc7pvpEti41ClOw5ZLnSmabPp8DEOvzc6rO/HCpZuCakP232eSFPEvU1
         HzzM4K3FgpeDIrevMaBC3yQtH0SthQGW4LPLGYGQ4eHg5/Ai1LPqZ52U0B/4a6WfpLhm
         r7yw==
X-Gm-Message-State: AOJu0YyLdy3IJ//UtzsdDUAhv6I9BsKqpq3jFO1aOfViXvzxhKYlDmeX
        IWn1aD5nq5fnMkC1YmdaR518HIuwBWDDESxYLAZAw0G2con3d846CCuvlqYCMTj2QBjOuc+UWwy
        2GRynNHfK4nSaBFdgeT5eJPxu771K5LaQ1DD1IEvS
X-Received: by 2002:ac8:7d07:0:b0:403:b85c:2ac8 with SMTP id g7-20020ac87d07000000b00403b85c2ac8mr1485083qtb.14.1691139353139;
        Fri, 04 Aug 2023 01:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIZPea69SCRbWLURCOrbR2294YeOg0GledRktnAs6K7El9K92k3Tn9DK6LgGE8n4FfrEbd3AFj/ROm2JS2HBY=
X-Received: by 2002:ac8:7d07:0:b0:403:b85c:2ac8 with SMTP id
 g7-20020ac87d07000000b00403b85c2ac8mr1485072qtb.14.1691139352892; Fri, 04 Aug
 2023 01:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230803051401.710236-2-leobras@redhat.com> <CAJF2gTShfMzVZw5TVqBvLNAzEBMzhWxNGC9JS70euPcKKN85zQ@mail.gmail.com>
 <CAJ6HWG5mzxN=txnbdi-=c+=wLsDfSe7Me+1DQE79ZX0NN6U1_g@mail.gmail.com>
 <CAJF2gTTag3hR7ZgM8o+yk+0Ox3A+xm4jAVTikAA0HqXQFKayRA@mail.gmail.com> <CAJ6HWG6ofyiLRq-HZFmocxPFzQhM+HwBQVOqwp-XSfctFHLNTQ@mail.gmail.com>
In-Reply-To: <CAJ6HWG6ofyiLRq-HZFmocxPFzQhM+HwBQVOqwp-XSfctFHLNTQ@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Fri, 4 Aug 2023 05:55:42 -0300
Message-ID: <CAJ6HWG5ps2fZoSM1dPg8TFTLgxZeXGSmjRG5Drg-g0HWH9c3sg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Deduplicate RISCV cmpxchg.h and atomic.c macros
To:     Guo Ren <guoren@kernel.org>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 5:05=E2=80=AFAM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> On Thu, Aug 3, 2023 at 11:29=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Fri, Aug 4, 2023 at 10:20=E2=80=AFAM Leonardo Bras Soares Passos
> > <leobras@redhat.com> wrote:
> > >
> > > On Thu, Aug 3, 2023 at 9:53=E2=80=AFPM Guo Ren <guoren@kernel.org> wr=
ote:
> > > >
> > > > On Thu, Aug 3, 2023 at 1:14=E2=80=AFPM Leonardo Bras <leobras@redha=
t.com> wrote:
> > > > >
> > > > > I unified previous patchsets into a single one, since the work is=
 related.
> > > > >
> > > > > While studying riscv's cmpxchg.h file, I got really interested in
> > > > > understanding how RISCV asm implemented the different versions of
> > > > > {cmp,}xchg.
> > > > >
> > > > > When I understood the pattern, it made sense for me to remove the
> > > > > duplications and create macros to make it easier to understand wh=
at exactly
> > > > > changes between the versions: Instruction sufixes & barriers.
> > > > >
> > > > > Also, did the same kind of work on atomic.c.
> > > > >
> > > > > Note to Guo Ren:
> > > > > I did some further improvement after your previous reviews, so I =
ended
> > > > > up afraid including your Reviewed-by before cheching if the chang=
es are
> > > > > ok for you. Please check it out again, I just removed some helper=
 macros
> > > > > that were not being used elsewhere in the kernel.
> > > > I found this optimization has conflicts with the below patches:
> > > > https://lore.kernel.org/linux-riscv/20230802164701.192791-15-guoren=
@kernel.org/
> > > > https://lore.kernel.org/linux-riscv/20230802164701.192791-5-guoren@=
kernel.org/
> > > >
> > > > If yours merged, how do we support the inline cmpxchg/xchg_small
> > > > function?
> > >
> > > Oh, I actually introduced my series so I could introduce new xchg and
> > > cmpxchg for size 1 and 2. Is that what your patches are about, right?
> > >
> > > I was working on that yesterday, and decided to send the patchset
> > > without them because I was still not sure enough.
> > >
> > > About implementation strategy, I was introducing a new macros for xch=
g
> > > & cmpxchg with asm which would work for both for size 1 & size 2, and
> > > use the switch-case to create the mask and and_value.
> > >
> > > You think that works enough?
> > Good, go ahead.
> >
> > >
> > > > It's very struggling to use macros to implement complex
> > > > functions.
> > >
> > > I agree, but with this we can achieve more generic code, which makes
> > > more clear what is the pattern for given function.
> > >
> > > > Could you consider a more relaxed optimization in which we could
> > > > insert inline cmpxchg/xchg_small?
> > >
> > > What about this: I finish the patches I have been working with
> > > (cmpxchg & xchg for sizes 1 and 2), and if they are fine we expand
> > > this patchset with them.  If not, I try relaxing them a little so we
> > > can merge with your set.
> > >
> > > Does that work for you?
> > Great, you could provide cmpxchg & xchg for sizes 1 and 2, then my
> > patch series would base on yours. After tested, I would give you
> > Tested-by.
>
> Awesome! Thanks!
>
> I will send it shortly, just compile-testing the kernel.
>

v3:
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D772986&stat=
e=3D%2A&archive=3Dboth

> > >
> > > Best regards,
> > > Leo
> > >
> > >
> > > >
> > > > >
> > > > > Thanks!
> > > > > Leo
> > > > >
> > > > >
> > > > > Changes since squashed cmpxchg:
> > > > > - Unified with atomic.c patchset
> > > > > - Rebased on top of torvalds/master (thanks Andrea Parri!)
> > > > > - Removed helper macros that were not being used elsewhere in the=
 kernel.
> > > > >
> > > > > Changes since (cmpxchg) RFCv3:
> > > > > - Squashed the 6 original patches in 2: one for cmpxchg and one f=
or xchg
> > > > > https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redh=
at.com/
> > > > >
> > > > > Changes since (cmpxchg) RFCv2:
> > > > > - Fixed  macros that depend on having a local variable with a mag=
ic name
> > > > > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> > > > > https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redh=
at.com/
> > > > >
> > > > > Changes since (cmpxchg) RFCv1:
> > > > > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid bui=
ld error
> > > > > https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redh=
at.com/
> > > > >
> > > > >
> > > > > Leonardo Bras (3):
> > > > >   riscv/cmpxchg: Deduplicate xchg() asm functions
> > > > >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> > > > >   riscv/atomic.h : Deduplicate arch_atomic.*
> > > > >
> > > > >  arch/riscv/include/asm/atomic.h  | 164 ++++++++--------
> > > > >  arch/riscv/include/asm/cmpxchg.h | 318 +++++--------------------=
------
> > > > >  2 files changed, 123 insertions(+), 359 deletions(-)
> > > > >
> > > > > --
> > > > > 2.41.0
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > >
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >

