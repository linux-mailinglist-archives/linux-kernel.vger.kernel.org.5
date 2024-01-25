Return-Path: <linux-kernel+bounces-38782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D698E83C5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633AB1F242B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F38745DF;
	Thu, 25 Jan 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YydD7APD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226D745DA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194503; cv=none; b=iwtWYt9m4xTYGB0Rjnb5mDi5ODXL6+sTjGsT5D6GU3Ek/k4LR/1K4RhdeaOqmBf9qd3/gswXa/CLOBbpcNiQr6tHF6Z0uB224+Y6AAMl1WrOqtmphtteiKdIHwNtlcHEuCX8q/qKWDPZ8y0RRqdMoDJKXfuiL7i8A5VY7GeDz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194503; c=relaxed/simple;
	bh=GWjDGV8CYjMd0IGt9BAFpsRRMtiip3hSJ/HWJHLVBjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i9DzMlzkhl7AFUKlmSxBIhKIWpVLD9JzbkBOIPsD7fRq+AyRtZ0oBSXOCRBkaqi76ZHIsZWANI+JNzIAVhzhaGZlIGoMKC/JdGi9y9P2weQl/rlHrjTCiRbvZ1aamIfkJFltAkyR/go+xVTa2EXMIVlGrH2cdwihIOFGuc9d8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YydD7APD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706194500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/WGCtIXBNMJl2nmRzGlu8C3YqwIcqmDWHTn6bi35uU=;
	b=YydD7APDjT75ofggEIobYscDB0VsAVamQIsoaJzgpxmh5OYR3ckv5MoEoUCL1efTNOVzRG
	GH54gNwmAN8fdgjdbhel8333VzX42vMkhAk8q+rVRaHGI2w0pW/+424/2Vh3qATCKPcv3a
	9enT/0oHbhZFx6oU/VBRGv+XOprs4G4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-FTy3CG_8MuCaODrB8al90g-1; Thu, 25 Jan 2024 09:54:57 -0500
X-MC-Unique: FTy3CG_8MuCaODrB8al90g-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7cda2e17239so264513241.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194496; x=1706799296;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/WGCtIXBNMJl2nmRzGlu8C3YqwIcqmDWHTn6bi35uU=;
        b=pnOYj+j/SvN8/9gYEzIWN5M/Ni4/IGtaxsMdJQQn8+udUFwbRaiYohxwrnYh++JpcI
         XgBePaHs/PyNfww8w1qhoJSn+W51A7e/xHrNX+OehE7G1pnurRbeTKtjCBibZAnEyg4w
         ZQMiTmbzGRISQxOgQ+gZdXXH+BqdKdPgZlx5sJ72Ih5mz3e610yJGmiIlC39TF4ksG8+
         Dya4nCYZiE92WynkRSaoh4rouOljhAzkBAm4wTZ/deLrlZ89gyFFjqgi2InbtcHleK1+
         3Hz1xXKG/J12hQt66FizvD3gWqfKhnB85KGi56xvUKS372AuByTR/E4UethZEQ/nS28Y
         A5QA==
X-Gm-Message-State: AOJu0Yye4bpw40/sT+BZiOK+psXCKYjCbbUibfKtqBNd9uFmTCjRpKey
	93is339Dg/YlJhgdaQD0ZvAEIt8jtXZ0nqJU07ZSMZ1HzEL9cR9+ovyNLMdHisgye5OyIHBNiRl
	8ukBpnJ8oi28neJ7nu5KXQxbhVx8MJtOvgiERHpznar6pDTCVCEVednz/vgrLrQ==
X-Received: by 2002:a05:6122:808:b0:4b7:3417:b5a4 with SMTP id 8-20020a056122080800b004b73417b5a4mr1787304vkj.1.1706194496309;
        Thu, 25 Jan 2024 06:54:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIYCSHR2Jl31Q/OOVV4bhgLrJrw/iGrIP8lwwani5ULr2nzz2L5voOwsgw/ZamIwqY+BdBxw==
X-Received: by 2002:a05:6122:808:b0:4b7:3417:b5a4 with SMTP id 8-20020a056122080800b004b73417b5a4mr1787280vkj.1.1706194495913;
        Thu, 25 Jan 2024 06:54:55 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id z20-20020a05620a101400b0078398696088sm4525202qkj.116.2024.01.25.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:54:55 -0800 (PST)
Message-ID: <3abf071d12de5b69e146665dfb57386e3b0ddfe0.camel@redhat.com>
Subject: Re: [PATCH v5 RESEND 2/5] lib: move pci_iomap.c to drivers/pci/
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com, linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 25 Jan 2024 15:54:51 +0100
In-Reply-To: <20240123202022.GA325908@bhelgaas>
References: <20240123202022.GA325908@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 14:20 -0600, Bjorn Helgaas wrote:
> On Thu, Jan 11, 2024 at 09:55:37AM +0100, Philipp Stanner wrote:
> > This file is guarded by an #ifdef CONFIG_PCI. It, consequently,
> > does not
> > belong to lib/ because it is not generic infrastructure.
> >=20
> > Move the file to drivers/pci/ and implement the necessary changes
> > to
> > Makefiles and Kconfigs.
> > ...
>=20
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -13,6 +13,11 @@ config FORCE_PCI
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select HAVE_PCI
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select PCI
> > =C2=A0
> > +# select this to provide a generic PCI iomap,
> > +# without PCI itself having to be defined
> > +config GENERIC_PCI_IOMAP
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
>=20
> > --- a/lib/pci_iomap.c
> > +++ b/drivers/pci/iomap.c
> > @@ -9,7 +9,6 @@
> > =C2=A0
> > =C2=A0#include <linux/export.h>
> > =C2=A0
> > -#ifdef CONFIG_PCI
>=20
> IIUC, in the case where CONFIG_GENERIC_PCI_IOMAP=3Dy but CONFIG_PCI was
> not set, pci_iomap.c was compiled but produced no code because the
> entire file was wrapped with this #ifdef.
>=20
> But after this patch, it looks like pci_iomap_range(),
> pci_iomap_wc_range(), etc., *will* be compiled?
>=20
> Is that what you intend, or did I miss something?

They *will* be compiled when BOTH, CONFIG_PCI and
CONFIG_GENERIC_PCI_IOMAP have been set. It's a bit hard to see that in
the patch's diff. Here, look closely:

--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -14,6 +14,7 @@ ifdef CONFIG_PCI   <-----------
 obj-$(CONFIG_PROC_FS)		+=3D proc.o
 obj-$(CONFIG_SYSFS)		+=3D slot.o
 obj-$(CONFIG_ACPI)		+=3D pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) +=3D iomap.o  <------------
 endif

So if I am not mistaken it behaves 100% as it did before

I prefered Makefile-logic over even more C Preprocessor to implement
that. The preprocessor has caused us so much trouble... :(

P.


>=20
> Bjorn
>=20


