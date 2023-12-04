Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A621280360D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbjLDOJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344990AbjLDOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:09:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33452106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701698989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jre80fB5gxpOyf9zLOpdEKJWXB6ZQSAxU9A6LZTXLUU=;
        b=ROilq0nPcGmOxlMcRV+FGtpy9a8ghpKO5nKkBLgTKygAvPg7i0YUy7U74V/LrrsduvD3h/
        EwM2E6k3bMWsj3mVmRzqwgMZ9eMAiDMHP7KFJrX/KtatOrs+1dZPvk7X9AF5FZMAm8biNt
        TteB/kqcCKRc1slVU5K/Pydkab5dkV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-3C-IE55SMjGK79oQc6gdMg-1; Mon, 04 Dec 2023 09:09:47 -0500
X-MC-Unique: 3C-IE55SMjGK79oQc6gdMg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b4302eac2so7857175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698986; x=1702303786;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jre80fB5gxpOyf9zLOpdEKJWXB6ZQSAxU9A6LZTXLUU=;
        b=ogC5uo8czLnMgzirjiRh2jAGEkiUQ26ucYRyEKgx//+ulagSEiDnnvdSUaLjt0tYgQ
         Ix3kGI5YJbkiuuYL9QUHJ6RQcwpUwbsHOA4fZPz8opLp8tbkzkDCM82xWUuUHIp82Tg8
         8BDMY4RwYUug4ltGR4iDNQnujEI2Z9/lirxikpQMIJizuUTE7Kk1ecbqpAshXHwXJGdo
         9/Sg4psT0HtyfnfI1gj8cy4nv0p2Xt4NADQa3mSBEBuWJSg1/X0QrxpViUXkQvhW0Ljg
         DLCWeUURdHI6UkXPUzs/Lkb+LzacKaluUhrzGvh5apTPn0ZegMyy1ZweGGkveoolOxTp
         ND6A==
X-Gm-Message-State: AOJu0Yxj2jVtErwQdZ6Fy1OrwzMbhQ/JZjbuDX9pJdrQlygEvgrEzwLJ
        gVu5rjUBqMWrV3ZLoT5ksKtLHXHSemD/EEunUo+hkbAIUjT/tRX7aOpX/boAQ7p75vLVwa9LwW/
        dPhX4q+Ls8idXEtRQu92xJqR4
X-Received: by 2002:a05:600c:54f0:b0:40b:4b69:b1a0 with SMTP id jb16-20020a05600c54f000b0040b4b69b1a0mr13770507wmb.3.1701698986425;
        Mon, 04 Dec 2023 06:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJtBakyTXcypMCsbpyGW4pbrYduXqfybcZT8Y5r8OtdcfhfgemCNcPW36ooJSmFpsFslzUwA==
X-Received: by 2002:a05:600c:54f0:b0:40b:4b69:b1a0 with SMTP id jb16-20020a05600c54f000b0040b4b69b1a0mr13770492wmb.3.1701698986081;
        Mon, 04 Dec 2023 06:09:46 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c8:b00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b0040b54d7ebb9sm15028705wmb.41.2023.12.04.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:09:45 -0800 (PST)
Message-ID: <e5d53e44709f7da1ba4b8f8a4687efcffdd6addb.camel@redhat.com>
Subject: Re: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
From:   Philipp Stanner <pstanner@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Hanjun Guo <guohanjun@huawei.com>, Neil Brown <neilb@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Yury Norov <yury.norov@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, stable@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, pstanner@redhat.com
Date:   Mon, 04 Dec 2023 15:09:43 +0100
In-Reply-To: <05173886-444c-4bae-b1a5-d2b068e9c4a5@app.fastmail.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
         <20231204123834.29247-6-pstanner@redhat.com>
         <2648aef32cd5a2272cd3ce8cd7ed5b29b2d21cad.camel@redhat.com>
         <05173886-444c-4bae-b1a5-d2b068e9c4a5@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-04 at 14:50 +0100, Arnd Bergmann wrote:
> On Mon, Dec 4, 2023, at 14:39, Philipp Stanner wrote:
> > On Mon, 2023-12-04 at 13:38 +0100, Philipp Stanner wrote:
>=20
> > > + */
> > > +#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
> > > +bool iomem_is_ioport(void __iomem *addr)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IO_COND(addr, /* nothing *=
/, iounmap(addr));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long port =3D (un=
signed long __force)addr;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port > PIO_OFFSET && p=
ort < PIO_RESERVED)
> >=20
> > by the way:
> > Reading that again my instinctive feeling would be that it should
> > be
> > port >=3D PIO_OFFSET.
> >=20
> > This is, however, the exactly copied logic from the IO_COND macro
> > in
> > lib/iomap.c. Is it possible that this macro contains a bug here?
>=20
> Right, I think that would make more sense, but there is no
> practical difference as long as I/O port 0 is always unused,
> which is at least true on x86 because of PCIBIOS_MIN_IO.
> Commit bb356ddb78b2 ("RISC-V: PCI: Avoid handing out address
> 0 to devices") describes how setting PCIBIOS_MIN_IO to 0
> caused other problems.

Ok, makes sense.

But should we then adjust iomem_is_ioport() in asm-generic/io.h, as
well, so that it matches IO_COND()'s behavior?

It currently does this:

	uintptr_t start =3D (uintptr_t)PCI_IOBASE;
	uintptr_t addr =3D (uintptr_t)addr_raw;

	if (addr >=3D start && addr < start + IO_SPACE_LIMIT)
		return true;

and if the architecture does not set PCI_IOBASE, then it's set per
default to 0, as well.

So we have two inconsistent definitons

>=20
> I would just leave the logic consistent with IO_COND here,
> or maybe use IO_COND() directly, like
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO_COND(addr, return true, /* nothing */);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;

I considered using it to increase consistency. However, I valued
improved readability more. Considering that the mid-term goal is to
move it to x86 anyways I'd like to leave it that way for now.


P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20

