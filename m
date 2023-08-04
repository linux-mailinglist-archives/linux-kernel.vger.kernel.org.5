Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4582E76F7C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjHDCWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjHDCVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C6746B5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691115627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zdWnPk6F5WHva5/zuaCLJfKple79vvN3Kgzu831Wvw=;
        b=iP26HaIl1RyrCw4wtCxNWe/EcE7howoaBXZ7jPyk9F3MtZZaaZZfHAMsZYmdpE6ptAB88T
        eyCmGed+u/QDAuAF2oTXjHd1yFQ7zOVx5jGdgX4H/0yfhdQCEdjcr8H2suZp09JVFuKVFd
        GRBWXrF6BFYs9iNqM/5I3R5JMpEzZf4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-QoxqVCR7P8i3R3K0F88BmQ-1; Thu, 03 Aug 2023 22:20:24 -0400
X-MC-Unique: QoxqVCR7P8i3R3K0F88BmQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40831789e55so18305061cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115623; x=1691720423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zdWnPk6F5WHva5/zuaCLJfKple79vvN3Kgzu831Wvw=;
        b=G17iOjjurW9H0VGUQHY67fOyksXsPpVG63ptrgeQQ9FXQx/qA2PEyIstbeVePbvunJ
         JAvfs1i2dy5J3DkiEl+z/uXD03QLOM2G6W9CnloSNf4IqQOP+XQCTav6O01DGeHx/rax
         3RIe2HunQbMy4yccoF7amQlRJyv/cJmc7ozbVuia5/mLRw9+4nInSClNyb+T7nv+V4wo
         NKjJgNE/WhQTA6optJ2Mmy/WYuBWEHJ9HOGEL8qnqfMjRt9Bb8jNqEyA78ljWNxX/0mP
         8Q5PPy8SkGD19e5N4N4Tn5CzLDVA2cc2EX2sSvUR+qhhuFoVID7jsW1XaXERGymDbG8r
         377Q==
X-Gm-Message-State: AOJu0Yz/sUH7Z6QTJmDmOYqjEmkjP28lxDGfV3jkQlhjMbor5EtYe2Lb
        /d7y337/ZNmf4FRxilIxbPM9nLXIO9ePLX/usUq0cC8mzpfMOWtYDMJKqGnDZTB4QW0xjqTfsn6
        tk6gRdftNnCkW+Gk+dtHVkGu9HxcNQqe8Gu8uMBl0
X-Received: by 2002:a05:622a:1746:b0:403:a9aa:571f with SMTP id l6-20020a05622a174600b00403a9aa571fmr755014qtk.16.1691115623683;
        Thu, 03 Aug 2023 19:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIDNlU9dDUknqAPNntSU8bwFxDV44Os16/hv3nXknImBVDvVlxKU8/v7gGSkdHVl8v+fMIo3sWZofirmJj1/c=
X-Received: by 2002:a05:622a:1746:b0:403:a9aa:571f with SMTP id
 l6-20020a05622a174600b00403a9aa571fmr754997qtk.16.1691115623460; Thu, 03 Aug
 2023 19:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230803051401.710236-2-leobras@redhat.com> <ZMuxYXQgR446JwUp@andrea>
In-Reply-To: <ZMuxYXQgR446JwUp@andrea>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Thu, 3 Aug 2023 23:20:12 -0300
Message-ID: <CAJ6HWG6rwi04eWuTDbx=WJABch59m5H2=N0BS3UQRTH2=c=-6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Deduplicate RISCV cmpxchg.h and atomic.c macros
To:     Andrea Parri <parri.andrea@gmail.com>
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
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 10:53=E2=80=AFAM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> On Thu, Aug 03, 2023 at 02:13:57AM -0300, Leonardo Bras wrote:
> > I unified previous patchsets into a single one, since the work is relat=
ed.
> >
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
> > Note to Guo Ren:
> > I did some further improvement after your previous reviews, so I ended
> > up afraid including your Reviewed-by before cheching if the changes are
> > ok for you. Please check it out again, I just removed some helper macro=
s
> > that were not being used elsewhere in the kernel.
> >
> > Thanks!
> > Leo
> >
> >
> > Changes since squashed cmpxchg:
> > - Unified with atomic.c patchset
> > - Rebased on top of torvalds/master (thanks Andrea Parri!)
> > - Removed helper macros that were not being used elsewhere in the kerne=
l.
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
> >
> > Leonardo Bras (3):
> >   riscv/cmpxchg: Deduplicate xchg() asm functions
> >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> >   riscv/atomic.h : Deduplicate arch_atomic.*
> >
> >  arch/riscv/include/asm/atomic.h  | 164 ++++++++--------
> >  arch/riscv/include/asm/cmpxchg.h | 318 +++++--------------------------
> >  2 files changed, 123 insertions(+), 359 deletions(-)
>
> LGTM.  For the series,
>
> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
>
>   Andrea

Thanks Andrea!

>

