Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65D7F313C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjKUOjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjKUOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A691726
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700577530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qgy9FU1P/mtjjmGhgeXi9H78tlxIy2hISiHhoOKv2hU=;
        b=WcVT+Te3+PApezdBFRpc48MuTR+X5ORsI9MfkAVFZ3oGoPKHu1oegkudYWpNdoSZLKq+fU
        W6BW+f5nsdD36PQTHhfcu+BaS9lN/CuV42GcI3SZJw7zy+egmhiuINByDI+AmeLBhyvNC3
        KwjsfKG/QyeLyLgKPProfaxLFZYnZhg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-vAAlKhokN6yuOd2Ezdt6TQ-1; Tue, 21 Nov 2023 09:38:47 -0500
X-MC-Unique: vAAlKhokN6yuOd2Ezdt6TQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-677fb270eacso10327326d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577526; x=1701182326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgy9FU1P/mtjjmGhgeXi9H78tlxIy2hISiHhoOKv2hU=;
        b=PBF2JtlgEeMTZtngt7jc2xhQ92zdQkwiSU6NdmkHTASMK1xr5z2SGWqPiroS6LBhNs
         Nv9g4VhTmVrE2S9uyTcwSl2eayShU6Mm+7wPqvtDmSuGeZKH9OW9DHkuExVAA0+k0lRi
         qED5pw8dgDneIyjdN+MpokBuhjdzTIyPxmlDQEnFmHVSszyQVF8RxdkdNi8BFWj+Ym4i
         UNNMdDr/ID6yQikUuiXAZBE3GTzoYd98zYmtAS72NrndHdye0DHBXXWGXxuGaaE4G2BH
         xWc7nhZigApVH9lrv8MgnR+7UrZrabCIhcMzRPgXkVbB9K5YvNpCvTNU25p+4udosnIn
         IMdg==
X-Gm-Message-State: AOJu0Yxkbxv+wZp5QhIGlxcVUt55YAEHk1cgt6fK2NUV4G2yeUxl39gR
        hgePqLECMIVc74VdrbLbPwNSNNy6r0K23268IQrNyLiRHy97jjZaUpNoSCE8Ci+Pt2NQLBfzHSe
        DTSCBrTnGLI6uyDxxWhxeXmTs
X-Received: by 2002:a05:620a:1994:b0:77b:dce8:737 with SMTP id bm20-20020a05620a199400b0077bdce80737mr10669001qkb.7.1700577526614;
        Tue, 21 Nov 2023 06:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIPpkU+2GCN9FoFyUK9CChv2vU5606IxhwK6RzXGPX/QXF9WkCmnmU726ssCw+wPxvrSAQ6w==
X-Received: by 2002:a05:620a:1994:b0:77b:dce8:737 with SMTP id bm20-20020a05620a199400b0077bdce80737mr10668980qkb.7.1700577526343;
        Tue, 21 Nov 2023 06:38:46 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id p10-20020ae9f30a000000b0076d08d5f93asm3657668qkg.60.2023.11.21.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:38:46 -0800 (PST)
Message-ID: <9a5f21b69709121c8b342bb44e0b7f83deacd10d.camel@redhat.com>
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Tue, 21 Nov 2023 15:38:41 +0100
In-Reply-To: <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
         <20231120215945.52027-6-pstanner@redhat.com>
         <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

And where would you like such a function to reside?
drivers/pci/iomap.c?

P.

>=20
> and then define iomem_is_ioport() in lib/iomap.c for x86,
> while defining it in asm-generic/io.h for the rest,
> with an override in asm/io.h for those architectures
> that need a custom inb().
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
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20

