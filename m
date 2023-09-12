Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E73A79C153
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjILAsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjILAsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B35618F38C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694478172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ESV40xUlx4Zvo6LdHszoOUWYzAUZO18uva7dc5H6tc=;
        b=NxIoSqnlw8RWGm1UVOoKaF1Qq4pW23aSRMjgu0MwLrlZeL0lNB70AAEy/TG0+Bxv7+8gBc
        48fxKUSRfA5S95k1UYfV+P+ImfpkJSjCvjEhmsO55vgeuu8J5DnDK2PVomDwLfScLW43Um
        G4GZ4o8rIssfc+tEMPD2sxA4YMdJnp4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-RaSEs2UtMDOI8tJN75Wnbg-1; Mon, 11 Sep 2023 20:22:50 -0400
X-MC-Unique: RaSEs2UtMDOI8tJN75Wnbg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76f2d10edcbso556179885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694478170; x=1695082970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ESV40xUlx4Zvo6LdHszoOUWYzAUZO18uva7dc5H6tc=;
        b=lhFqt3+BI7HqKD+ipQ5XsKYM1+8PaRbiM0Ow/izHKMX/S1HEce6WmvAmn36xf4FsZb
         7TRuQqJ4rg8RXVR5wngkGcc9YhNuBs28zfgYJsSmYwKTGzfrmsoGK/H8pFXsAizYBxcA
         Q6+ztKwKpumxWrpHny2UvTYb0cfvi8IEV3ghfK3xNhY72MUlq2/iyyJW++3LcJCq7bbZ
         bYH71tgoyoAFEVWnb6MMrmR2VL+0AOeXu3KFFrKUHVax4dt0dJPZ5cUScN/jCSQTORa5
         UiqoqKtGZBoSE+9QIql0XiIMaDUXgdc+weFsmXIDMoq1WTzTtvf8YG11WkIQKMUw3PhN
         b7Ow==
X-Gm-Message-State: AOJu0YxaITp+HSaipsgf2QNg40NYJvo0OjfIGfVTNftQ4ISV9moqOanf
        WStKtPG4GMsj659sk9ouXFASi2NvgH+A1Jt2CPvlOitmtrCbFC9NFg9jl8tEmePqX9TTc5ZzhkW
        xo/UZfDElLHYZTJseHTHKnjN9Tit/AAvo4jZmRnRD
X-Received: by 2002:a05:620a:4d4:b0:76f:e1f:c0c7 with SMTP id 20-20020a05620a04d400b0076f0e1fc0c7mr10583973qks.27.1694478170396;
        Mon, 11 Sep 2023 17:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIjneWL4eV17pupEmKZzT1JMBUjL92fultN54QbYD24lyaScOqRPbkaMjuPELM3lKhP/W4wfHneM05ql+GDfQ=
X-Received: by 2002:a05:620a:4d4:b0:76f:e1f:c0c7 with SMTP id
 20-20020a05620a04d400b0076f0e1fc0c7mr10583950qks.27.1694478170068; Mon, 11
 Sep 2023 17:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230810040349.92279-2-leobras@redhat.com> <ZP2DVap64lJZj9g4@gmail.com>
In-Reply-To: <ZP2DVap64lJZj9g4@gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Mon, 11 Sep 2023 21:22:38 -0300
Message-ID: <CAJ6HWG6yED5eUVgaygHqVb7NUbHBzb8dz73dq9cyKAGj5_Sh5g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/5] Rework & improve riscv cmpxchg.h and atomic.h
To:     Guo Ren <guoren@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 5:50=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Aug 10, 2023 at 01:03:42AM -0300, Leonardo Bras wrote:
> > While studying riscv's cmpxchg.h file, I got really interested in
> > understanding how RISCV asm implemented the different versions of
> > {cmp,}xchg.
> >
> > When I understood the pattern, it made sense for me to remove the
> > duplications and create macros to make it easier to understand what exa=
ctly
> > changes between the versions: Instruction sufixes & barriers.
> >
> > Also, did the same kind of work on atomic.c.
> >
> > After that, I noted both cmpxchg and xchg only accept variables of
> > size 4 and 8, compared to x86 and arm64 which do 1,2,4,8.
> >
> > Now that deduplication is done, it is quite direct to implement them
> > for variable sizes 1 and 2, so I did it. Then Guo Ren already presented
> > me some possible users :)
> >
> > I did compare the generated asm on a test.c that contained usage for ev=
ery
> > changed function, and could not detect any change on patches 1 + 2 + 3
> > compared with upstream.
> >
> > Pathes 4 & 5 were compiled-tested, merged with guoren/qspinlock_v11 and
> > booted just fine with qemu -machine virt -append "qspinlock".
> >
> > (tree: https://gitlab.com/LeoBras/linux/-/commits/guo_qspinlock_v11)
> Tested-by: Guo Ren <guoren@kernel.org>
>
> Sorry for late reply, because we are stress testing CNA qspinlock on
> sg2042 128 cores hardware platform. This series has passed our test for
> several weeks. For more detail, ref:
> https://lore.kernel.org/linux-riscv/20230910082911.3378782-1-guoren@kerne=
l.org/
>

That's awesome!
Thanks for testing!

Leo

> >
> > Thanks!
> > Leo
> >
> > Changes since squashed cmpxchg RFCv4:
> > - Added (__typeof__(*(p))) before returning from {cmp,}xchg, as done
> >   in current upstream, (possibly) fixing the bug from kernel test robot
> > https://lore.kernel.org/all/20230809021311.1390578-2-leobras@redhat.com=
/
> >
> > Changes since squashed cmpxchg RFCv3:
> > - Fixed bug on cmpxchg macro for var size 1 & 2: now working
> > - Macros for var size 1 & 2's lr.w and sc.w now are guaranteed to recei=
ve
> >   input of a 32-bit aligned address
> > - Renamed internal macros from _mask to _masked for patches 4 & 5
> > - __rc variable on macros for var size 1 & 2 changed from register to u=
long
> > https://lore.kernel.org/all/20230804084900.1135660-2-leobras@redhat.com=
/
> >
> > Changes since squashed cmpxchg RFCv2:
> > - Removed rc parameter from the new macro: it can be internal to the ma=
cro
> > - 2 new patches: cmpxchg size 1 and 2, xchg size 1 and 2
> > https://lore.kernel.org/all/20230803051401.710236-2-leobras@redhat.com/
> >
> > Changes since squashed cmpxchg RFCv1:
> > - Unified with atomic.c patchset
> > - Rebased on top of torvalds/master (thanks Andrea Parri!)
> > - Removed helper macros that were not being used elsewhere in the kerne=
l.
> > https://lore.kernel.org/all/20230419062505.257231-1-leobras@redhat.com/
> > https://lore.kernel.org/all/20230406082018.70367-1-leobras@redhat.com/
> >
> > Changes since (cmpxchg) RFCv3:
> > - Squashed the 6 original patches in 2: one for cmpxchg and one for xch=
g
> > https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com=
/
> >
> > Changes since (cmpxchg) RFCv2:
> > - Fixed  macros that depend on having a local variable with a magic nam=
e
> > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> > https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com=
/
> >
> > Changes since (cmpxchg) RFCv1:
> > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build err=
or
> > https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com=
/
> >
> > Leonardo Bras (5):
> >   riscv/cmpxchg: Deduplicate xchg() asm functions
> >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> >   riscv/atomic.h : Deduplicate arch_atomic.*
> >   riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
> >   riscv/cmpxchg: Implement xchg for variables of size 1 and 2
> >
> >  arch/riscv/include/asm/atomic.h  | 164 ++++++-------
> >  arch/riscv/include/asm/cmpxchg.h | 404 ++++++++++---------------------
> >  2 files changed, 200 insertions(+), 368 deletions(-)
> >
> >
> > base-commit: cacc6e22932f373a91d7be55a9b992dc77f4c59b
> > --
> > 2.41.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
>

