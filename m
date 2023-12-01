Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77628015C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjLAV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C86F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701467776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzB8UGnzvCMXlHDXHp/lNMLMscLApc7r9rtEsoGucVw=;
        b=evkrK01IIt5dCqEEb2bENQNDK2db72a6He9rWs7e6bA2SqlZmixuWSvlW1JzNEBEg6rxgH
        1wDVAU9D/cnMAJRfjqhjg5arQS0R5RHGDJKSL3TPXmffPVYpNvmxjPWJR4NxhFomI95bYg
        oYKnozYxjtMPbqfv3zaNu3InhhCApl4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-hKKyC5uBO-WB9t8Oh4HIoQ-1; Fri, 01 Dec 2023 16:56:10 -0500
X-MC-Unique: hKKyC5uBO-WB9t8Oh4HIoQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3333298eaabso157789f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 13:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701467769; x=1702072569;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzB8UGnzvCMXlHDXHp/lNMLMscLApc7r9rtEsoGucVw=;
        b=EWqhb5wkCmDnXPpLs98K1kJgxtfQTuxYbyxGqkeVoFT+AE9Sw9aBSb4f60y4H9xHl+
         8SlsdZEKEV1LiGrDhzyknkpfOlX7daWci6HQDrdIr5VX8Ik3oUoYubM4tZCkeQF4035j
         FXQFWXctHeCgeVyh74BE4xTwEPRLLdZZqtZRquvbedM7Lj0gnZ0Gr5uHIXj16iMly0K1
         7Iz5z2dxQtcqSdP5WS+0QOMlB0RNPceVO4tKJn8mTeYCyolOb2oX7tMOz3wI9TIG6h5W
         8XOoebmRqBoH2Ob17XiiztB7hUv8EqBS2/7SbiAsh4sjeyXyvrMQ1eMuXB/Fkf+Yutxt
         pL6Q==
X-Gm-Message-State: AOJu0YyCPFFF3WdFIEjqVZAiu6cyHzKlqgCW9ywTeROI1Qh7i+s5L1Gh
        ICjR0zV7HDjUPneSrUJ51K/P4ssru/ZaWEwg93Y67eeHNwaXHCnV7wJtNAClXomBvssJ06BMHWb
        Jjeiq/VzBXEjRzFhZAtfB1eD2
X-Received: by 2002:a05:600c:2102:b0:40b:516a:3856 with SMTP id u2-20020a05600c210200b0040b516a3856mr4459048wml.1.1701467768938;
        Fri, 01 Dec 2023 13:56:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXM3kxYRly/msq70L9DFAH2GMnkCjM7KT15x2dslgPT5qxBes146kud9w3Gs8eAIP2L9/k+g==
X-Received: by 2002:a05:600c:2102:b0:40b:516a:3856 with SMTP id u2-20020a05600c210200b0040b516a3856mr4459027wml.1.1701467768604;
        Fri, 01 Dec 2023 13:56:08 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id fk14-20020a05600c0cce00b0040b2a52ecaasm10410926wmb.2.2023.12.01.13.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 13:56:08 -0800 (PST)
Message-ID: <c902e7e690dcdf57c2e8402e083d27ce84aee21b.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] lib, pci: unify generic pci_iounmap()
From:   Philipp Stanner <pstanner@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        Neil Brown <neilb@suse.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>, pstanner@redhat.com
Date:   Fri, 01 Dec 2023 22:56:05 +0100
In-Reply-To: <330df2f8-3796-4f74-8856-06ae1e46ec9b@app.fastmail.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
         <20231201121622.16343-5-pstanner@redhat.com>
         <619ea619-29e4-42fb-9b27-1d1a32e0ee66@app.fastmail.com>
         <b54e5d57624dae0b045d8ff129ac2a41f72e182d.camel@redhat.com>
         <330df2f8-3796-4f74-8856-06ae1e46ec9b@app.fastmail.com>
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

On Fri, 2023-12-01 at 22:32 +0100, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 20:37, Philipp Stanner wrote:
> > On Fri, 2023-12-01 at 16:26 +0100, Arnd Bergmann wrote:
> > >=20
> > > static inline bool struct iomem_is_ioport(void __iomem *p)
> > > {
> > > #ifdef CONFIG_HAS_IOPORT
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t start =3D (uintp=
tr_t) PCI_IOBASE;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t addr =3D (uintpt=
r_t) p;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (addr >=3D start && add=
r < start + IO_SPACE_LIMIT)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return true;
> > > #endif
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > }
> > >=20
> > > > +#else /* CONFIG_GENERIC_IOMAP. Version from lib/iomap.c will
> > > > be
> > > > used.=20
> > > > */
> > > > +bool iomem_is_ioport(void __iomem *addr);
> > > > +#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT
> > >=20
> > > I'm not sure what this macro is for, since it appears to
> > > do the opposite of what its name suggests: rather than
> > > provide the generic version of iomem_is_ioport(), it
> > > skips that and provides a custom one to go with lib/iomap.c
> >=20
> > Hmmm well now it's getting tricky.
> >=20
> > This else-branch is the one where CONFIG_GENERIC_IOMAP is actually
> > set.
> >=20
> > I think we're running into the "generic not being generic now that
> > IA64
> > has died" problem you were hinting at.
> >=20
> > If we build for x86 and have CONFIG_GENERIC set, only then do we
> > want
> > iomem_is_ioport() from lib/iomap.c. So the macro serves avoiding a
> > collision between symbols. Because lib/iomap.c might be compiled
> > even
> > if someone else already has defined iomem_is_ioport().
> > I also don't like it, but it was the least bad solution I could
> > come up
> > with
> > Suggestions?
>=20
> The best I can think of is to move the lib/iomap.c version
> of iomem_is_ioport() to include/asm-generic/iomap.h with
> an #ifndef iomem_is_ioport / #define iomem_is_ioport
> check around it. This file is only included on parisc, alpha,
> sh and when CONFIG_GENERIC_IOMAP is set.

My implementation from lib/iomap.c basically just throws away the
IO_COND macro and does the checks manually:

#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
bool iomem_is_ioport(void __iomem *addr)
{
	unsigned long port =3D (unsigned long __force)addr;

	if (port > PIO_OFFSET && port < PIO_RESERVED)
		return true;

	return false;
}
#endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */

So we'd also need PIO_OFFSET and PIO_RESERVED, which are not present in
asm-generic/iomap.h.

Sure, we could move them there or into a common header. But I'm not
sure if that is wise, meaning: is it really better than the ugly
WANTS_GENERIC_IOMEM... macro?

Our entire goal in this series is, after all, to simplify the
implementation.


P.

>=20
> The default version in asm-generic/io.h then just needs
> one more #ifdef iomem_is_ioport check around it.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20

