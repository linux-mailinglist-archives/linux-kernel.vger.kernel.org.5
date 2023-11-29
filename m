Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738347FD6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjK2MkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjK2MkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138810EF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701261624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o9CdZJhC6mWbHtgRNx7rPmbL35uryCNbMAEfF46nxeQ=;
        b=NXf0d4/pfFxHI49y2qzbkj+EcG2FltTBwLI5THuxIl8vV6RMY6Bj3iHWSIxYmAMrKi4Zpz
        WcpZueO3vvdhxtsVEYoq+GSFRBUOmcAJQANuRGx8H22aqmz1Ac6QzqdBQFDsYZqE3zw4sz
        D4GCy7Hk3mxiteNbuzgXBGY0PIuQwto=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-cEVxzFUQMDyW7qQSmCWRuA-1; Wed, 29 Nov 2023 07:40:23 -0500
X-MC-Unique: cEVxzFUQMDyW7qQSmCWRuA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b473b7014so4298635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261622; x=1701866422;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9CdZJhC6mWbHtgRNx7rPmbL35uryCNbMAEfF46nxeQ=;
        b=eR7MwuD3sxiX4VtbTIdycgZzDhUhA9FkFEUJShOALBB/bfGT6Gnug1bOFxuhtgIMWG
         kxTa13JFpow4IYlOYOQVlzcEQEbWxBxtbT/x1qZ1AhFYMniYzyjYefqJZ9C9OTtW58MV
         lgXOo0e9JXvzY1xqZkweQiMrqe+OT3zhm5yxtbCA28LxHUzN9IOYb1wOyYI5w0q2qWqs
         f4SmBjwmbNM7izSIyJl0ytjsGH35O2qs/oN2PtYg0mKROsO2TRthvmsp6KLhQwhdI2bt
         S0cE2xeJEWmRY8uJX5DgMG8ZbjwlKpr8lL+xeI8chuDgxISEXa02fwox3QxUc2FRU9In
         wkCw==
X-Gm-Message-State: AOJu0Ywx8XVGs88VaJ1Fxkl/ZqUfQadNAu+GYy0gNpR2q8ZNql+Qtp2P
        vVLOjwgBwm7IubtGvb0EOo9sLeM0YuKw5NoYPHLBotAPH5t/4ENrz/RqDqwCrAg8/+N41TNMslE
        dlunjmteD2F/Z2UQ2Jb32VLH7
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr10799114wmp.2.1701261622245;
        Wed, 29 Nov 2023 04:40:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDtsYehLQlGFAIq6LJfqx7ddMLE4aygnDQtPMeQpUfzDCDfQtjWHWiJiovDFxaX8BThshwZQ==
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr10799082wmp.2.1701261621881;
        Wed, 29 Nov 2023 04:40:21 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id y14-20020adff6ce000000b0033308db2576sm5830499wrp.56.2023.11.29.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:40:21 -0800 (PST)
Message-ID: <10ef8eac12c01f52ec3b8c0bedf6cf34627d1ceb.camel@redhat.com>
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
From:   Philipp Stanner <pstanner@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Neil Brown <neilb@suse.de>, John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        pstanner@redhat.com
Date:   Wed, 29 Nov 2023 13:40:19 +0100
In-Reply-To: <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
         <20231120215945.52027-6-pstanner@redhat.com>
         <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

so I thought about this for a while and want to ask some follow up
questions in addition to those by Danilo in the other mail.

(btw, -CC Herbert Xu, since the mailserver is bouncing)


On Tue, 2023-11-21 at 11:03 +0100, Arnd Bergmann wrote:
> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> > lib/iomap.c contains one of the definitions of pci_iounmap(). The
> > current comment above this out-of-place function does not clarify
> > WHY
> > the function is defined here.
> >=20
> > Linus's detailed comment above pci_iounmap() in drivers/pci/iomap.c
> > clarifies that in a far better way.
> >=20
> > Extend the existing comment with an excerpt from Linus's and hint
> > at the
> > other implementation in drivers/pci/iomap.c
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> I think instead of explaining why the code is so complicated
> here, I'd prefer to make it more logical and not have to
> explain it.
>=20
> We should be able to define a generic version like
>=20
> void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
> {
> #ifdef CONFIG_HAS_IOPORT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iomem_is_ioport(addr)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ioport_unmap(addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> #endif
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iounmap(addr)
> }

ACK, I think this makes sense =E2=80=93 if we agree (as in the other thread=
)
that we never need an empty pci_iounmap().

>=20
> and then define iomem_is_ioport() in lib/iomap.c for x86,

Wait a minute.
lib/ should never contain architecture-specific code, should it? I
assume your argument is that we write a default version of
iomem_is_ioport(), that could, in theory, be used by many
architectures, but ultimately only x86 will use that default.

> while defining it in asm-generic/io.h for the rest,

So we're not talking about the function prototypes here, but about the
actual implementation that should reside in asm-generic/io.h, aye?
Because the prototype obviously always has to be identical.

> with an override in asm/io.h for those architectures
> that need a custom inb().

So like this in ARCH/include/asm/io.h:

#define iomem_is_ioport iomem_is_ioport
bool iomem_is_ioport(...);

and in include/asm-generic/io.h:

#ifndef iomem_is_ioport
bool iomem_is_ioport(...);

correct?

Still, as Danilo has asked in his email, the question about how inb()
is related to it still stands

>=20
> Note that with ia64 gone, GENERIC_IOMAP is not at all
> generic any more and could just move it to x86 or name
> it something else. This is what currently uses it:
>=20
> arch/hexagon/Kconfig:=C2=A0=C2=A0 select GENERIC_IOMAP
> arch/um/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC=
_IOMAP
>=20
> These have no port I/O at all, so it doesn't do anything.
>=20
> arch/m68k/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_IOMAP
>=20
> on m68knommu, the default implementation from asm-generic/io.h
> as the same effect as GENERIC_IOMAP but is more efficient.
> On classic m68k, GENERIC_IOMAP does not do what it is
> meant to because I/O ports on ISA devices have port
> numbers above PIO_OFFSET. Also they don't have PCI.
>=20
> arch/mips/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_IOMAP
>=20
> This looks completely bogus because it sets PIO_RESERVED
> to 0 and always uses the mmio part of lib/iomap.c.=20
>=20
> arch/powerpc/platforms/Kconfig: select GENERIC_IOMAP
>=20
> This is only used for two platforms: cell and powernv,
> though on Cell it no longer does anything after the
> commit f4981a00636 ("powerpc: Remove the celleb support");
> I think the entire io_workarounds code now be folded
> back into spider_pci.c if we wanted to.
>=20
> The PowerNV LPC support does seem to still rely on it.
> This tries to do the exact same thing as lib/logic_pio.c
> for Huawei arm64 servers. I suspect that neither of them
> does it entirely correctly since the powerpc side appears
> to just override any non-LPC PIO support while the arm64
> side is missing the ioread/iowrite support.

I think by now I get what the issue with GENERIC_IOMAP is. But do you
want me to do something about GENERIC_IOMAP (besides the things
directly related to the PCI functionality I'm touching) for you to
approve of a modified version of this patch series?


P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20

