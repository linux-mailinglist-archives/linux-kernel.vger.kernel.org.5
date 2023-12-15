Return-Path: <linux-kernel+bounces-1567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CA815032
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED7A1C2154E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B71405F7;
	Fri, 15 Dec 2023 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wYjuLjNN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804EC3C486;
	Fri, 15 Dec 2023 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.209.70])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BFJVn1u3759634
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 15 Dec 2023 11:31:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BFJVn1u3759634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1702668714;
	bh=lEZogfLkuQTBdhS1oT4n+uuFxGNt+Mg/2j/DlYXfmD8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=wYjuLjNNcJXBOhbx8QYqCQ8C8O5S21qbIVm6MJbF1vKzrOW0LoFeyoxetPfmSPUpP
	 jJP2FGpa3pG2sdDqYCFuF+w/eDXV5va+ZJ+Z0GE7EV+ifShjiZVcobloo6/R1OMYzA
	 WtTjnox4DWo9OpX5QlB0kpcsCr0FQt9T3vMdlVdSIiA2a5fj5HZDJtRVy7+tvYcYvz
	 K7Vacy+ulQTvyqZCOaXa4mBr+04KIslDg9V/8eKM+tFtEFLLdgzLJdxMcpk9z2wPUe
	 kfPGEPoTYKcWKD5vFNo5GIj7fAuBjsS7QKawPD3K9IkCeGxwy+YuTAU2JnGVGhEmuA
	 A1VfIoJZdSVHQ==
Date: Fri, 15 Dec 2023 11:31:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Chris Koch <chrisko@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
CC: Cloud Hsu <cloudhsu@google.com>
Subject: Re: [PATCH] kexec: allocate kernel above bzImage's pref_address
User-Agent: K-9 Mail for Android
In-Reply-To: <20231215190521.3796022-1-chrisko@google.com>
References: <20231215190521.3796022-1-chrisko@google.com>
Message-ID: <36486D80-D0AE-4594-B337-71B3A84FC3DD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 15, 2023 11:05:21 AM PST, Chris Koch <chrisko@google=2Ecom> wro=
te:
>A relocatable kernel will relocate itself to pref_address if it is
>loaded below pref_address=2E This means a booted kernel may be relocating
>itself to an area with reserved memory on modern systems, potentially
>clobbering arbitrary data that may be important to the system=2E
>
>This is often the case, as the default value of PHYSICAL_START is
>0x1000000 and kernels are typically loaded at 0x100000 or above by
>bootloaders like iPXE or kexec=2E GRUB behaves like this patch does=2E
>
>Also fixes the documentation around pref_address and PHYSICAL_START to
>be accurate=2E
>
>Co-developed-by: Cloud Hsu <cloudhsu@google=2Ecom>
>Signed-off-by: Cloud Hsu <cloudhsu@google=2Ecom>
>Signed-off-by: Chris Koch <chrisko@google=2Ecom>
>---
> Documentation/arch/x86/boot=2Erst   |  3 ++-
> arch/x86/Kconfig                  | 10 +++++-----
> arch/x86/kernel/kexec-bzimage64=2Ec |  5 ++++-
> 3 files changed, 11 insertions(+), 7 deletions(-)
>
>diff --git a/Documentation/arch/x86/boot=2Erst b/Documentation/arch/x86/b=
oot=2Erst
>index 22cc7a040dae=2E=2E49bea8986620 100644
>--- a/Documentation/arch/x86/boot=2Erst
>+++ b/Documentation/arch/x86/boot=2Erst
>@@ -878,7 +878,8 @@ Protocol:	2=2E10+
>   address if possible=2E
>=20
>   A non-relocatable kernel will unconditionally move itself and to run
>-  at this address=2E
>+  at this address=2E A relocatable kernel will move itself to this addre=
ss if it
>+  loaded below this address=2E
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D
> Field name:	init_size
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 3762f41bb092=2E=2E1370f43328d7 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -2109,11 +2109,11 @@ config PHYSICAL_START
> 	help
> 	  This gives the physical address where the kernel is loaded=2E
>=20
>-	  If kernel is a not relocatable (CONFIG_RELOCATABLE=3Dn) then
>-	  bzImage will decompress itself to above physical address and
>-	  run from there=2E Otherwise, bzImage will run from the address where
>-	  it has been loaded by the boot loader and will ignore above physical
>-	  address=2E
>+	  If the kernel is not relocatable (CONFIG_RELOCATABLE=3Dn) then bzImag=
e
>+	  will decompress itself to above physical address and run from there=
=2E
>+	  Otherwise, bzImage will run from the address where it has been loaded
>+	  by the boot loader=2E The only exception is if it is loaded below the
>+	  above physical address, in which case it will relocate itself there=
=2E
>=20
> 	  In normal kdump cases one does not have to set/change this option
> 	  as now bzImage can be compiled as a completely relocatable image
>diff --git a/arch/x86/kernel/kexec-bzimage64=2Ec b/arch/x86/kernel/kexec-=
bzimage64=2Ec
>index a61c12c01270=2E=2E5dcd232d58bf 100644
>--- a/arch/x86/kernel/kexec-bzimage64=2Ec
>+++ b/arch/x86/kernel/kexec-bzimage64=2Ec
>@@ -498,7 +498,10 @@ static void *bzImage64_load(struct kimage *image, ch=
ar *kernel,
> 	kbuf=2Ebufsz =3D  kernel_len - kern16_size;
> 	kbuf=2Ememsz =3D PAGE_ALIGN(header->init_size);
> 	kbuf=2Ebuf_align =3D header->kernel_alignment;
>-	kbuf=2Ebuf_min =3D MIN_KERNEL_LOAD_ADDR;
>+	if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
>+		kbuf=2Ebuf_min =3D MIN_KERNEL_LOAD_ADDR;
>+	else
>+		kbuf=2Ebuf_min =3D header->pref_address;
> 	kbuf=2Emem =3D KEXEC_BUF_MEM_UNKNOWN;
> 	ret =3D kexec_add_buffer(&kbuf);
> 	if (ret)

Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>

