Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BEE776341
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjHIPDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjHIPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E7EEE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691593356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NYYbX0Ny/eDp4l06N9hZE4kvGy1+pASnAt7JajSyFo=;
        b=N1NEanMZPsOYYIgvqvV/e+6O6eH6D0n3klMO/OgpPpwG1BWfcygYmMG49jQIYIqgdl7c1N
        kJ9uI3Sgz1fY8tvPF1Dhqp6cedUNf6WoMzY7ARY/+DGyz5TrwUmBPlx96x4JWdsfoNiFn/
        Zg9rGKC/jcUKlLida1iw/CXxUCakFKU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-caSuhw_ON66arrYcryBMRQ-1; Wed, 09 Aug 2023 11:02:33 -0400
X-MC-Unique: caSuhw_ON66arrYcryBMRQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4100bd2f742so47762531cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593353; x=1692198153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NYYbX0Ny/eDp4l06N9hZE4kvGy1+pASnAt7JajSyFo=;
        b=XPdx1Ji7kFGdtJcoZZAInx81WsaIbJxpJos0Ozt6MDnbp0rwB6qfbI/aqTdrUrAsL/
         ECRcjM0+jsXwmJEkV3EcG8I0JPcivTJyqC1SA5DjybDe+oguCx89GBboNz1x3XvolAcM
         IKbjqrYhUBb3be2JZOxskvUhH8vGFavrmOKGJNeyHKT2AwpT6YMbJb5UAwhvnf67NQV2
         yAGIUZDhvf2UXspGnZpABFTAYA/fuR7URAAPmb9GrIhko/sgCdLhSyWJBWrHQFHyp1DU
         d9eshYv9alsMGXZVuY91oe+nZjPwxbqlJczS2eBQCTUIo11QIoy4DYZDqOnr4BJkQzJC
         ei8w==
X-Gm-Message-State: AOJu0YwpPqv1E2+Ui+CSv31xPW5U3lhLlETjhBwViXhKcEwWrGFzpUzc
        +jzpiMwXqaaur3RzjlX2Ed0mKFr9FH0rCoK5yy4Goqo5oXS0LVonaeuBjtqghrQ1ZLampKjQfPV
        7wajvR6APszJch4vFUjztBCxAbQIXYqU17MkRPlA0
X-Received: by 2002:ac8:4e8b:0:b0:40f:db89:8616 with SMTP id 11-20020ac84e8b000000b0040fdb898616mr4162708qtp.67.1691593353242;
        Wed, 09 Aug 2023 08:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSF647FR6HPptz0wXsij0RUWgRN1QjmtT6Jrtmo+lRqMtDdZ5gy7XDMtl5sYjvOIzXxmZxxvkvYG2dq/sizNI=
X-Received: by 2002:ac8:4e8b:0:b0:40f:db89:8616 with SMTP id
 11-20020ac84e8b000000b0040fdb898616mr4162646qtp.67.1691593352652; Wed, 09 Aug
 2023 08:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230809021311.1390578-2-leobras@redhat.com>
In-Reply-To: <20230809021311.1390578-2-leobras@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 9 Aug 2023 12:02:21 -0300
Message-ID: <CAJ6HWG525eMQxbQ8BPsy9WMZvkiqSOHBJBCUtW_wV1Cv55cWxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/5] Rework & improve riscv cmpxchg.h and atomic.h
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 11:13=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
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
> After that, I noted both cmpxchg and xchg only accept variables of
> size 4 and 8, compared to x86 and arm64 which do 1,2,4,8.
>
> Now that deduplication is done, it is quite direct to implement them
> for variable sizes 1 and 2, so I did it. Then Guo Ren already presented
> me some possible users :)
>
> I did compare the generated asm on a test.c that contained usage for ever=
y
> changed function, and could not detect any change on patches 1 + 2 + 3
> compared with upstream.
>
> Pathes 4 & 5 were compiled-tested, merged with guoren/qspinlock_v11 and
> booted just fine with qemu -machine virt -append "qspinlock".

This is the tree that I used:
https://gitlab.com/LeoBras/linux/-/commits/guo_qspinlock_v11

>
> Thanks!
> Leo
>
> Changes since squashed cmpxchg RFCv3:
> - Fixed bug on cmpxchg macro for var size 1 & 2: now working
> - Macros for var size 1 & 2's lr.w and sc.w now are guaranteed to receive
>   input of a 32-bit aligned address
> - Renamed internal macros from _mask to _masked for patches 4 & 5
> - __rc variable on macros for var size 1 & 2 changed from register to ulo=
ng
> https://lore.kernel.org/all/20230804084900.1135660-2-leobras@redhat.com/
>
> Changes since squashed cmpxchg RFCv2:
> - Removed rc parameter from the new macro: it can be internal to the macr=
o
> - 2 new patches: cmpxchg size 1 and 2, xchg size 1 and 2
> https://lore.kernel.org/all/20230803051401.710236-2-leobras@redhat.com/
>
> Changes since squashed cmpxchg RFCv1:
> - Unified with atomic.c patchset
> - Rebased on top of torvalds/master (thanks Andrea Parri!)
> - Removed helper macros that were not being used elsewhere in the kernel.
> https://lore.kernel.org/all/20230419062505.257231-1-leobras@redhat.com/
> https://lore.kernel.org/all/20230406082018.70367-1-leobras@redhat.com/
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
> Leonardo Bras (5):
>   riscv/cmpxchg: Deduplicate xchg() asm functions
>   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
>   riscv/atomic.h : Deduplicate arch_atomic.*
>   riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
>   riscv/cmpxchg: Implement xchg for variables of size 1 and 2
>
>  arch/riscv/include/asm/atomic.h  | 164 ++++++-------
>  arch/riscv/include/asm/cmpxchg.h | 394 ++++++++++---------------------
>  2 files changed, 195 insertions(+), 363 deletions(-)
>
> --
> 2.41.0
>

