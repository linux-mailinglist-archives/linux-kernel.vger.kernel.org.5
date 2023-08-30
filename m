Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8916278E204
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbjH3WCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbjH3WCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B604783
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693432795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCsmQQPDEzpO7dEIPUF9oZqzMMjxWy62IcLqscO/fPk=;
        b=PFQn+ZYNoE/RJYNW130ZnL6kEll6L9XDEj6SpblVj4/SnhePQwHEIMzzCs1qvywZg1crTD
        8EaCNHie+LK5mIJM8dzVnA7TBq2ZXtd7Yftrx+0D2dxx0/XdrG51m80hvth0+RQyfntLg4
        lYj5dm7hHB5KKD3xC48MzX+3iqTHe5A=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-KEPk8-PKN1C679zeLszJ7g-1; Wed, 30 Aug 2023 17:59:52 -0400
X-MC-Unique: KEPk8-PKN1C679zeLszJ7g-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a7d402fc85so136641b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432791; x=1694037591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCsmQQPDEzpO7dEIPUF9oZqzMMjxWy62IcLqscO/fPk=;
        b=AK3SQZgH5NEUcp4bcULRmJwko48LFbDUGKxgqPOY/2rt7qhKVbDWBdjf0Mr+7yg7s6
         O3VIVhuNf5UhykqYIvwqkF4rqMPseNjgUK+PVJ4IV7+69WQAJNJbTXogAgrQy8+mHTMx
         N9MFu16mULWOWGu7JyLCQXF8kVDo5Hq+mID60aPlMZJRErj6LHOVTyveRyf+AMHL1wFp
         Wd7UYBuQWAI7yi/mo1KLmBk5f6J/F9Crbcs85DsGgeW+ggChZhHZr37N/mFk+/0Dvivq
         dvZkUnRXtq41MoioqE+KwFkDnZXmnTfRF/ER3Ygsc8MqwF/nzOVhhYsRfpbXRJN3VCoE
         H9UQ==
X-Gm-Message-State: AOJu0Yx4V/MkJ3vgS/ko4IoJbeXUyRTrq0gkIYbrx5JK2lKnVTOM1E1M
        0gv2HgoMU9poX/pKmCD+ixzsW2Un554sbUtQ0tpKsyu/b14PHZGJbeQXxuK86vsXZfIuPzRyXNy
        qvPZr8YWjroPGyRnhwW01dWXn
X-Received: by 2002:a54:4017:0:b0:3a4:1c16:b1bc with SMTP id x23-20020a544017000000b003a41c16b1bcmr3765393oie.12.1693432791207;
        Wed, 30 Aug 2023 14:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwg5SrLVVQrMeLuskHMokNg/1gc9T7B5J3L1TkDvyTpxCprhAnkYx2pW90OEk85mNU2825yQ==
X-Received: by 2002:a54:4017:0:b0:3a4:1c16:b1bc with SMTP id x23-20020a544017000000b003a41c16b1bcmr3765381oie.12.1693432790991;
        Wed, 30 Aug 2023 14:59:50 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:98e3:3c98:3d83:9703:4411? ([2804:1b3:a802:98e3:3c98:3d83:9703:4411])
        by smtp.gmail.com with ESMTPSA id 15-20020aca120f000000b003a1f359ba4esm43252ois.14.2023.08.30.14.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:59:50 -0700 (PDT)
Message-ID: <2a4f1f47e945772b9fbb53a51e148636e0ae6e48.camel@redhat.com>
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables
 of size 1 and 2
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        peterz@infradead.org, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, parri.andrea@gmail.com,
        andrzej.hajda@intel.com, guoren@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Wed, 30 Aug 2023 18:59:46 -0300
In-Reply-To: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
References: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-10 at 09:23 -0700, Palmer Dabbelt wrote:
> On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > > On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > > > xchg for variables of size 1-byte and 2-bytes is not yet available =
for
> > > > riscv, even though its present in other architectures such as arm64=
 and
> > > > x86. This could lead to not being able to implement some locking me=
chanisms
> > > > or requiring some rework to make it work properly.
> > > >=20
> > > > Implement 1-byte and 2-bytes xchg in order to achieve parity with o=
ther
> > > > architectures.
> > > >=20
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > >=20
> >=20
> > Hello Arnd Bergmann, thanks for reviewing!
> >=20
> > > Parity with other architectures by itself is not a reason to do this,
> > > in particular the other architectures you listed have the instruction=
s
> > > in hardware while riscv does not.
> >=20
> > Sure, I understand RISC-V don't have native support for xchg on variabl=
es of
> > size < 4B. My argument is that it's nice to have even an emulated versi=
on for
> > this in case any future mechanism wants to use it.
> >=20
> > Not having it may mean we won't be able to enable given mechanism in RI=
SC-V.=20
>=20
> IIUC the ask is to have a user within the kernel for these functions. =
=20
> That's the general thing to do, and last time this came up there was no=
=20
> in-kernel use of it -- the qspinlock stuff would, but we haven't enabled=
=20
> it yet because we're worried about the performance/fairness stuff that=
=20
> other ports have seen and nobody's got concrete benchmarks yet (though=
=20
> there's another patch set out that I haven't had time to look through,=
=20
> so that may have changed).
>=20
> So if something uses these I'm happy to go look closer.

IIUC patches 4 & 5 will be used by qspinlock, which may not be done yet, so=
 we
don't have an use for them for the time being.

Otherwise, any comments on patches 1, 2 & 3?

>=20
> > > Emulating the small xchg() through cmpxchg() is particularly tricky
> > > since it's easy to run into a case where this does not guarantee
> > > forward progress.
> > >=20
> >=20
> > Didn't get this part:
> > By "emulating small xchg() through cmpxchg()", did you mean like emulat=
ing an
> > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> >=20
> > If so, yeah, it's a fair point: in some extreme case we could have mult=
iple
> > threads accessing given cacheline and have sc always failing. On the ot=
her hand,
> > there are 2 arguments on that:
> >=20
> > 1 - Other architectures, (such as powerpc, arm and arm64 without LSE at=
omics)
> > also seem to rely in this mechanism for every xchg size. Another archs =
like csky
> > and loongarch use asm that look like mine to handle size < 4B xchg.=20
> >    =20
> >=20
> > >  This is also something that almost no architecture
> > > specific code relies on (generic qspinlock being a notable exception)=
.
> > >=20
> >=20
> > 2 - As you mentioned, there should be very little code that will actual=
ly make
> > use of xchg for vars < 4B, so it should be safe to assume its fine to n=
ot
> > guarantee forward progress for those rare usages (like some of above me=
ntioned
> > archs).
> >=20
> > > I would recommend just dropping this patch from the series, at least
> > > until there is a need for it.
> >=20
> > While I agree this is a valid point, I believe its more interesting to =
have it
> > implemented if any future mechanism wants to make use of this.=20
> >=20
> >=20
> > Thanks!
> > Leo
>=20

