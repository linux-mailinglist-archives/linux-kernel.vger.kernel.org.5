Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF776B334
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjHAL2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjHAL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:28:40 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC7D3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1690889319;
        bh=oB+m1whzA5Poc7p8CzrPGLnshdyNojzHyilFcZEUHHA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kaeCaWOW1jSaF5FyZvKSo7L7oHxh3CidQ1yPcD2cp301VRvsumWj5bHChuN17ZOI1
         KHjq/cxdK5sk116T9akLgxaun9J4wizA8uludAvNNAmy3bEC19RDuW7kwYz+BO9AC4
         lVC3NEso/6lDSXfV2p3ohVYCJqt9s4pGa+5T4ong=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B09986599C;
        Tue,  1 Aug 2023 07:28:36 -0400 (EDT)
Message-ID: <06f228ac4afce0126337ad4a8b0ade1f12c98d40.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
From:   Xi Ruoyao <xry111@xry111.site>
To:     Guo Ren <guoren@kernel.org>, WANG Rui <wangrui@loongson.cn>
Cc:     chenhuacai@kernel.org, kernel@xen0n.name, arnd@arndb.de,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Date:   Tue, 01 Aug 2023 19:28:35 +0800
In-Reply-To: <44a99b78933afeb1b33d8c51487fe0673281af9b.camel@xry111.site>
References: <20230801011554.3950435-1-guoren@kernel.org>
         <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
         <CAJF2gTRa5erHomJzLgUFO4SGqd5zSDwn6r3WN7kM8aWpv1vesg@mail.gmail.com>
         <CAJF2gTQ1hV1vipAo3H4X4WiPO84kVVFZcdGq7u4f0bVTry_akQ@mail.gmail.com>
         <CAHirt9gVqE=9vviJEY=kY=booVRmFPHrnFsKCXPXnXiWTB8bZQ@mail.gmail.com>
         <CAJF2gTR2ON33wc87iV564rkDbNiE56h_t0kzKKXdJtGqgJ1sOQ@mail.gmail.com>
         <44a99b78933afeb1b33d8c51487fe0673281af9b.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-01 at 19:23 +0800, Xi Ruoyao wrote:
> On Tue, 2023-08-01 at 18:49 +0800, Guo Ren wrote:
> > > On Tue, Aug 1, 2023 at 5:05=E2=80=AFPM Guo Ren <guoren@kernel.org> wr=
ote:
> > > >=20
> > > > > The CoRR problem would cause wider problems than this.For this ca=
se,
> > > > > do you mean your LL -> LL would be reordered?
> > > > >=20
> > > > > CPU 0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU1
> > > > > LL(2) (set ex-monitor)
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 store (break the ex-monitor)
> > > > > LL(1) (reordered instruction set ex-monitor
> > > > > SC(3) (successes ?)
> > > > Sorry for the mail client reformat, I mean:
> > > >=20
> > > > CPU0=C2=A0 LL(2) (set ex-monitor)
> > > > CPU1=C2=A0 STORE (break the ex-monitor)
> > > > CPU0=C2=A0 LL(1) (reordered instruction set ex-monitor
> > > > CPU0=C2=A0 SC(3) (success?)
> > >=20
> > > No. LL and LL won't reorder because LL implies a memory barrier(thoug=
h
> > > not acquire semantics).
> > That means we could remove __WEAK_LLSC_MB totally, right?
>=20
> As I've said, to implement CAS on LA464 this barrier is *really* needed.
> I initially didn't believe it then I spent one night (from 11 PM to 04
> AM) debugging GCC libgomp test failures.
>=20
> On LA664 (3A6000) things may change though.

And I consider this a hardware bug, so it's out of the general concept
of general memory orders.  We are basically just applying a workaround
provided by uarch designers.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
