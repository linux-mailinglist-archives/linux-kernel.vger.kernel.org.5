Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3086D8037B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjLDNlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjLDNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8521BF8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701697204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6t/lQmuA+KYylReR8Tt2Y7vgpwmnlbkgXVn4TYobKw=;
        b=CYFMgEwCecdCMW3hxjMQ2I7Agkzua4NuCJqCQi80z5yaXwLh8XAPXnQjTE474KF+DeK1jD
        HerxOsT7PTfJc5UupjbqiB+orE87jMERaMr/IwUv9A+pU+WbbU8nAwOnulZVGw6X7oJ6+w
        Mr76yWv3Wr/VtwHldHeBdiY8n59MWBQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-GQSNSLHLNc2_IgEcpAxsUw-1; Mon, 04 Dec 2023 08:40:02 -0500
X-MC-Unique: GQSNSLHLNc2_IgEcpAxsUw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3332e2b0448so344227f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697201; x=1702302001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6t/lQmuA+KYylReR8Tt2Y7vgpwmnlbkgXVn4TYobKw=;
        b=DnovKoWdQ8aPmjAsD0blYqOg5wI0cZbc7sB1BDrD8bnFv7kZFLnA8atTurY7fO2qOO
         LDHXgWjwv5+tLEjd9owVtmzdHxQiWLJqLO26JOswygJHU4udtcpKJ0txncEGr6EGzKit
         m7qpq5QTozU7Uv0FNdyBM3dDRbktg1YLx31f8f4e3nWeUql4z6U4Xib97YeTtFyi3PMC
         8DMgnWJ1OcteJHNTz1q738QzA1m6uCPpice8EXmSzHHlsVbOVZ6DYgZ+jJnwKZOjqyqM
         Mwc/YOsTFC7yQesjDRDoJf3lKTJJJBk0jZ2kOy7VY1eZbAsuEv7RyfnDtBfx6/nmy+j3
         QwuQ==
X-Gm-Message-State: AOJu0YyuQhYMIfnQT2fxgFczw0USieT1cq9XGQYkfwG5uw08/uM04Ac2
        ikpkzNina1L0C7hiJa+hmdo+OwJGD7lRDvcabpwwPKf7+7Q9aT224GpB0OYvr6e2BUTPXxxrUIv
        nF6DjUdhUWsZF2tJElSifo9wi
X-Received: by 2002:a5d:6d8c:0:b0:333:4ba7:bcca with SMTP id l12-20020a5d6d8c000000b003334ba7bccamr1530609wrs.5.1701697201674;
        Mon, 04 Dec 2023 05:40:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF68EVZkyh2dq89LJeZ2Hqh2HG/I8GyNndlUdxiJ1SFemCE2BAyi2/b4hVGpQDmHiPId/lbXQ==
X-Received: by 2002:a5d:6d8c:0:b0:333:4ba7:bcca with SMTP id l12-20020a5d6d8c000000b003334ba7bccamr1530571wrs.5.1701697201283;
        Mon, 04 Dec 2023 05:40:01 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c8:b00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id x16-20020adfec10000000b003333beb564asm6255853wrn.5.2023.12.04.05.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:40:00 -0800 (PST)
Message-ID: <2648aef32cd5a2272cd3ce8cd7ed5b29b2d21cad.camel@redhat.com>
Subject: Re: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hanjun Guo <guohanjun@huawei.com>, NeilBrown <neilb@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Yury Norov <yury.norov@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 04 Dec 2023 14:39:58 +0100
In-Reply-To: <20231204123834.29247-6-pstanner@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
         <20231204123834.29247-6-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-04 at 13:38 +0100, Philipp Stanner wrote:
> The implementation of pci_iounmap() is currently scattered over two
> files, drivers/pci/iomap.c and lib/iomap.c. Additionally,
> architectures can define their own version.
>=20
> To have only one version, it's necessary to create a helper function,
> iomem_is_ioport(), that tells pci_iounmap() whether the passed
> address
> points to an ioport or normal memory.
>=20
> iomem_is_ioport() can be provided through two different ways:
> =C2=A0 1. The architecture itself provides it. As of today, the version
> =C2=A0=C2=A0=C2=A0=C2=A0 coming from lib/iomap.c de facto is the x86-spec=
ific version and
> =C2=A0=C2=A0=C2=A0=C2=A0 comes into play when CONFIG_GENERIC_IOMAP is sel=
ected. This
> rather
> =C2=A0=C2=A0=C2=A0=C2=A0 confusing naming is an artifact left by the remo=
val of IA64.
> =C2=A0 2. As a default version in include/asm-generic/io.h for those
> =C2=A0=C2=A0=C2=A0=C2=A0 architectures that don't use CONFIG_GENERIC_IOMA=
P, but also
> don't
> =C2=A0=C2=A0=C2=A0=C2=A0 provide their own version of iomem_is_ioport().
>=20
> Once all architectures that support ports provide iomem_is_ioport(),
> the
> arch-specific definitions for pci_iounmap() can be removed and the
> archs
> can use the generic implementation, instead.
>=20
> Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
> Provide the function iomem_is_ioport() in include/asm-generic/io.h
> (generic) and lib/iomap.c ("pseudo-generic" for x86).
>=20
> Remove the CONFIG_GENERIC_IOMAP guard around
> ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
> CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
> function.
>=20
> Add TODOs for follow-up work on the "generic is not generic but
> x86-spcific"-Problem.
>=20
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/pci/iomap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 46 ++++++++++++-----------------------
> --
> =C2=A0include/asm-generic/io.h=C2=A0=C2=A0=C2=A0 | 27 +++++++++++++++++++=
+--
> =C2=A0include/asm-generic/iomap.h | 21 +++++++++++++++++
> =C2=A0lib/iomap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 ++++++++++++++++------
> =C2=A04 files changed, 82 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
> index 91285fcff1ba..439ba2e9710f 100644
> --- a/drivers/pci/iomap.c
> +++ b/drivers/pci/iomap.c
> @@ -135,44 +135,28 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev,
> int bar, unsigned long maxlen)
> =C2=A0EXPORT_SYMBOL_GPL(pci_iomap_wc);
> =C2=A0
> =C2=A0/*
> - * pci_iounmap() somewhat illogically comes from lib/iomap.c for the
> - * CONFIG_GENERIC_IOMAP case, because that's the code that knows
> about
> - * the different IOMAP ranges.
> + * This check is still necessary due to legacy reasons.
> =C2=A0 *
> - * But if the architecture does not use the generic iomap code, and
> if
> - * it has _not_ defined it's own private pci_iounmap function, we
> define
> - * it here.
> - *
> - * NOTE! This default implementation assumes that if the
> architecture
> - * support ioport mapping (HAS_IOPORT_MAP), the ioport mapping will
> - * be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT [,
> - * and does not need unmapping with 'ioport_unmap()'.
> - *
> - * If you have different rules for your architecture, you need to
> - * implement your own pci_iounmap() that knows the rules for where
> - * and how IO vs MEM get mapped.
> - *
> - * This code is odd, and the ARCH_HAS/ARCH_WANTS #define logic comes
> - * from legacy <asm-generic/io.h> header file behavior. In
> particular,
> - * it would seem to make sense to do the iounmap(p) for the non-IO-
> space
> - * case here regardless, but that's not what the old header file
> code
> - * did. Probably incorrectly, but this is meant to be bug-for-bug
> - * compatible.
> + * TODO: Have all architectures that provide their own pci_iounmap()
> provide
> + * iomem_is_ioport() instead. Remove this #if afterwards.
> =C2=A0 */
> =C2=A0#if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
> =C2=A0
> -void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> +/**
> + * pci_iounmap - Unmapp a mapping
> + * @dev: PCI device the mapping belongs to
> + * @addr: start address of the mapping
> + *
> + * Unmapp a PIO or MMIO mapping.
> + */
> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> =C2=A0{
> -#ifdef ARCH_HAS_GENERIC_IOPORT_MAP
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t start =3D (uintptr_t=
) PCI_IOBASE;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t addr =3D (uintptr_t)=
 p;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (addr >=3D start && addr < =
start + IO_SPACE_LIMIT) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ioport_unmap(p);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (iomem_is_ioport(addr)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ioport_unmap(addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> -#endif
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(p);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(addr);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(pci_iounmap);
> =C2=A0
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index bac63e874c7b..58c7bf4080da 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1129,11 +1129,34 @@ extern void ioport_unmap(void __iomem *p);
> =C2=A0#endif /* CONFIG_GENERIC_IOMAP */
> =C2=A0#endif /* CONFIG_HAS_IOPORT_MAP */
> =C2=A0
> -#ifndef CONFIG_GENERIC_IOMAP
> +/*
> + * TODO:
> + * remove this once all architectures replaced their pci_iounmap()
> with
> + * a custom implementation of iomem_is_ioport().
> + */
> =C2=A0#ifndef pci_iounmap
> +#define pci_iounmap pci_iounmap
> =C2=A0#define ARCH_WANTS_GENERIC_PCI_IOUNMAP
> +#endif /* pci_iounmap */
> +
> +/*
> + * This function is a helper only needed for the generic
> pci_iounmap().
> + * It's provided here if the architecture does not provide its own
> version.
> + */
> +#ifndef iomem_is_ioport
> +#define iomem_is_ioport iomem_is_ioport
> +static inline bool iomem_is_ioport(void __iomem *addr_raw)
> +{
> +#ifdef CONFIG_HAS_IOPORT
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t start =3D (uintptr_t=
)PCI_IOBASE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t addr =3D (uintptr_t)=
addr_raw;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (addr >=3D start && addr < =
start + IO_SPACE_LIMIT)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return true;
> =C2=A0#endif
> -#endif
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> +}
> +#endif /* iomem_is_ioport */
> =C2=A0
> =C2=A0#ifndef xlate_dev_mem_ptr
> =C2=A0#define xlate_dev_mem_ptr xlate_dev_mem_ptr
> diff --git a/include/asm-generic/iomap.h b/include/asm-
> generic/iomap.h
> index 196087a8126e..2cdc6988a102 100644
> --- a/include/asm-generic/iomap.h
> +++ b/include/asm-generic/iomap.h
> @@ -110,6 +110,27 @@ static inline void __iomem
> *ioremap_np(phys_addr_t offset, size_t size)
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> +/*
> + * If CONFIG_GENERIC_IOMAP is selected and the architecture does NOT
> provide its
> + * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that
> the generic
> + * version from asm-generic/io.h is NOT used and instead the second
> "generic"
> + * version from lib/iomap.c is used.
> + *
> + * There are currently two generic versions because of a difficult
> cleanup
> + * process. Namely, the version in lib/iomap.c once was really
> generic when IA64
> + * still existed. Today, it's only really used by x86.
> + *
> + * TODO: Move the version from lib/iomap.c to x86 specific code.
> Then, remove
> + * this ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT-mechanism.
> + */
> +#ifdef CONFIG_GENERIC_IOMAP
> +#ifndef iomem_is_ioport
> +#define iomem_is_ioport iomem_is_ioport
> +bool iomem_is_ioport(void __iomem *addr);
> +#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT
> +#endif /* iomem_is_ioport */
> +#endif /* CONFIG_GENERIC_IOMAP */
> +
> =C2=A0#include <asm-generic/pci_iomap.h>
> =C2=A0
> =C2=A0#endif
> diff --git a/lib/iomap.c b/lib/iomap.c
> index 4f8b31baa575..eb9a879ebf42 100644
> --- a/lib/iomap.c
> +++ b/lib/iomap.c
> @@ -418,12 +418,26 @@ EXPORT_SYMBOL(ioport_map);
> =C2=A0EXPORT_SYMBOL(ioport_unmap);
> =C2=A0#endif /* CONFIG_HAS_IOPORT_MAP */
> =C2=A0
> -#ifdef CONFIG_PCI
> -/* Hide the details if this is a MMIO or PIO address space and just
> do what
> - * you expect in the correct way. */
> -void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
> +/*
> + * If CONFIG_GENERIC_IOMAP is selected and the architecture does NOT
> provide its
> + * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that
> the generic
> + * version from asm-generic/io.h is NOT used and instead the second
> "generic"
> + * version from this file here is used.
> + *
> + * There are currently two generic versions because of a difficult
> cleanup
> + * process. Namely, the version in lib/iomap.c once was really
> generic when IA64
> + * still existed. Today, it's only really used by x86.
> + *
> + * TODO: Move this function to x86-specific code.
> + */
> +#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
> +bool iomem_is_ioport(void __iomem *addr)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IO_COND(addr, /* nothing */, i=
ounmap(addr));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long port =3D (unsign=
ed long __force)addr;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port > PIO_OFFSET && port =
< PIO_RESERVED)

by the way:
Reading that again my instinctive feeling would be that it should be
port >=3D PIO_OFFSET.

This is, however, the exactly copied logic from the IO_COND macro in
lib/iomap.c. Is it possible that this macro contains a bug here?

P.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return true;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> =C2=A0}
> -EXPORT_SYMBOL(pci_iounmap);
> -#endif /* CONFIG_PCI */
> +#endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */

