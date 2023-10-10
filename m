Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328C57BEFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379268AbjJJAv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379270AbjJJAvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:51:23 -0400
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACFA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696899028; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SDPs12iEpCuYVmi9WLsnrWLSAvrWfmUxRsrJCsW/L3fNh0SO14yBkyrL7NkmTk52+o3pCtsb4iKLw9iJ04ceSZs134vqbSGVvhIDiG1kFJE+PL757/T3xK/cjVNVcmvkvzl1clLyk0z419PnTTcvBKCTRAg76jrfQ+YC4npcX7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1696899028; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=zPP4TZjAS0kwaRQP5idRmtKa2hZGTVcdNJLgECZGa4c=; 
        b=eotbbV0vH1tKPi/kA0U3ijUgpljQHBNk45t/SW7dxo1DTX5++O5PhkWmion4iaTkYoFlskB0V7AXRXXruq+O6R/JXoZyXLu8CZvFRuYy4xgZdS9UCwWPsNFRc+wKwNQ/kLPSx8FOuTjcpTiUTodTOisxquHp66xFQwbmxK84IP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1696899028;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=zPP4TZjAS0kwaRQP5idRmtKa2hZGTVcdNJLgECZGa4c=;
        b=C9btrAj9L5tixomY/As9WzDjujXEnn6qFsOdwCsEzvVdKLSpD1iih/jp8dNS4O2W
        g/SexsAYLaOdoPulg2hB05KeRDpw4m+w2C0O76FZgLSLDx9CIEpXQ6q0IWfOn6NsEmm
        mx300uEu+GCgRG+Q2g0ymcXhbVh+3B/ovZdXo9jDl8vlFdKYhewqW6DJxGqMZ1jPXX4
        NM+RPYYbCaRmyyxUFxwiPmKZRfslZiaN1rp6ils2dtxyRRrh85/ynr36YlhEULcgSxJ
        BIJDQYPcMCd/z/5Q+3Kx+iZjspSuG/sqjiMUNfcU1zMa6Lut9OLAkM+AaLS4ONpY/6S
        e0VukUcXyQ==
Received: from edelgard.fodlan.icenowy.me (120.85.97.233 [120.85.97.233]) by mx.zohomail.com
        with SMTPS id 1696899027781769.1883889449305; Mon, 9 Oct 2023 17:50:27 -0700 (PDT)
Message-ID: <e95d97c98caa525b04cf6383a74db9cadf694afb.camel@icenowy.me>
Subject: Re: [PATCH v2] loongarch/mm: disable WUC for pgprot_writecombine as
 same as ioremap_wc
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Weihao Li <liweihao@loongson.cn>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Jun Yi <yijun@loongson.cn>, Baoquan He <bhe@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhihong Dong <donmor3000@hotmail.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 10 Oct 2023 08:50:21 +0800
In-Reply-To: <4f1af31b-15be-cb47-6b34-45de1b5696be@loongson.cn>
References: <20231009042841.635366-1-uwu@icenowy.me>
         <4f1af31b-15be-cb47-6b34-45de1b5696be@loongson.cn>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-10-09=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 22:32 +0800=EF=BC=
=8CSui Jingfeng=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
>=20
> On 2023/10/9 12:28, Icenowy Zheng wrote:
> > Currently the code disables WUC only disables it for ioremap_wc(),
> > which
> > is only used when mapping writecombine pages like ioremap() (mapped
> > to
> > the kernel space). For VRAM mapped in TTM/GEM, it's mapped with a
> > crafted pgprot with pgprot_writecombine() function, which isn't
> > corrently disabled now.
> >=20
> > Disable WUC for pgprot_writecombine() (fallback to SUC) too.
> >=20
> > This improves AMDGPU driver stability on Loongson 3A5000 machines.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > Changes since v1:
> > - Removed _WC macros
> > - Mention ioremap_wc in commit message
> >=20
> > =C2=A0 arch/loongarch/include/asm/io.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++---
> > =C2=A0 arch/loongarch/include/asm/pgtable-bits.h |=C2=A0 4 +++-
> > =C2=A0 arch/loongarch/kernel/setup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++-----
> > =C2=A0 3 files changed, 10 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/arch/loongarch/include/asm/io.h
> > b/arch/loongarch/include/asm/io.h
> > index 0dcb36b32cb25..290aad87a8847 100644
> > --- a/arch/loongarch/include/asm/io.h
> > +++ b/arch/loongarch/include/asm/io.h
> > @@ -52,10 +52,9 @@ static inline void __iomem
> > *ioremap_prot(phys_addr_t offset, unsigned long size,
> > =C2=A0=C2=A0 * @offset:=C2=A0=C2=A0=C2=A0 bus address of the memory
> > =C2=A0=C2=A0 * @size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size of the resourc=
e to map
> > =C2=A0=C2=A0 */
> > -extern pgprot_t pgprot_wc;
> > -
> > =C2=A0 #define ioremap_wc(offset, size)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioremap_prot((offset), (size=
), pgprot_val(pgprot_wc))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioremap_prot((offset), (size=
), pgprot_val( \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0wc_enabled ? PAGE_KERNEL_WUC : PAGE_KERNEL_SUC))
> > =C2=A0=20
> > =C2=A0 #define ioremap_cache(offset, size)=C2=A0=C2=A0=C2=A0\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioremap_prot((offset), =
(size), pgprot_val(PAGE_KERNEL))
> > diff --git a/arch/loongarch/include/asm/pgtable-bits.h
> > b/arch/loongarch/include/asm/pgtable-bits.h
> > index 35348d4c4209a..a3d827701736d 100644
> > --- a/arch/loongarch/include/asm/pgtable-bits.h
> > +++ b/arch/loongarch/include/asm/pgtable-bits.h
> > @@ -92,6 +92,8 @@
> > =C2=A0=20
> > =C2=A0 #ifndef __ASSEMBLY__
> > =C2=A0=20
> > +extern bool wc_enabled;
> > +
> > =C2=A0 #define _PAGE_IOREMAP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0pgprot_val(PAGE_KERNEL_SUC)
> > =C2=A0=20
> > =C2=A0 #define pgprot_noncached pgprot_noncached
> > @@ -111,7 +113,7 @@ static inline pgprot_t
> > pgprot_writecombine(pgprot_t _prot)
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long prot =3D =
pgprot_val(_prot);
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prot =3D (prot & ~_CACHE_MAS=
K) | _CACHE_WUC;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prot =3D (prot & ~_CACHE_MAS=
K) | (wc_enabled ? _CACHE_WUC :
> > _CACHE_SUC);
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __pgprot(prot);
> > =C2=A0 }
> > diff --git a/arch/loongarch/kernel/setup.c
> > b/arch/loongarch/kernel/setup.c
> > index 7783f0a3d742c..465c1dbb6f4b4 100644
> > --- a/arch/loongarch/kernel/setup.c
> > +++ b/arch/loongarch/kernel/setup.c
> > @@ -161,19 +161,19 @@ static void __init smbios_parse(void)
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 #ifdef CONFIG_ARCH_WRITECOMBINE
> > -pgprot_t pgprot_wc =3D PAGE_KERNEL_WUC;
> > +bool wc_enabled =3D true;
> > =C2=A0 #else
> > -pgprot_t pgprot_wc =3D PAGE_KERNEL_SUC;
> > +bool wc_enabled;
> > =C2=A0 #endif
> > =C2=A0=20
> > -EXPORT_SYMBOL(pgprot_wc);
> > +EXPORT_SYMBOL(wc_enabled);
> > =C2=A0=20
> > =C2=A0 static int __init setup_writecombine(char *p)
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!strcmp(p, "on"))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pgprot_wc =3D PAGE_KERNEL_WUC;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0wc_enabled =3D true;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (!strcmp(p, "of=
f"))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pgprot_wc =3D PAGE_KERNEL_SUC;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0wc_enabled =3D false;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_warn("Unknown writecombine setting \"%s\".\n"=
,
> > p);
> > =C2=A0=20
>=20
>=20
> Good catch!
>=20
> But this will make the write combine(WC) mappings completely unusable
> on LoongArch.

Not completely unusable -- we always have the writecombine=3Don kernel
parameter that overrides it (or CONFIG_ARCH_WRITECOMBINE build-time
option).

People knowing what they're doing can utilize them to gain back the
performace of WUC, however for the default setup I prefer functionality
correctness to (unstable) performance.

> This is nearly equivalent to say that LoongArch don't support write
> combine at all.
> But the write combine(WC) mappings works fine for software based drm
> drivers,
> such as drm/loongson and drm/ast etc. Even include drm/radeon and
> drm/amdgpu with
> pure software rendering setup (by putting Option "Accel" "off" into
> 10-amdgpu.conf
> or 10-radeon.conf) After merge this patch, the performance drop
> dramatically for
> 2D software rendering based display controller drivers.
>=20
> Well, this patch itself is a good catch, as it is a fix for the
> commit <16c52e503043>
> ("LoongArch: Make WriteCombine configurable for ioremap()"). But I'm
> afraid that
> both of this commit and the <16c52e503043> commit are not a *real*
> fix write combine

Yes, this is a workaround rather than a fix, however I'm a software
developer and this is the best I can do.

If you can, please report this to your hardware developers and try to
get it fixed for 3A7000/7A3000 (or maybe grabbing some chicken bit that
will fix this for existing chips). I will be quite appreciated.

Thanks,
Icenowy

> related issue on LoongArch. It just negative sidestep of the real
> problem.
>=20

