Return-Path: <linux-kernel+bounces-39644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80583D42E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF11B21FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0748F12B8F;
	Fri, 26 Jan 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DU0CFc04"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834411C88
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249259; cv=none; b=A1pAW2D24LdHbDKn02cZJ7z4kADz+Sxg05ofZzuFsomJk+YhQQl4TmsngOeKHGa6lZa3FOw2m+SCHH3Plt+Wl40BZWRJpv1r2Fckq0QCL6MFhH74Z/+EhuU54yAQVWdxsD8NtUQsv/sXcuxD+rdcV5se0OM8FVw3RmQBywLd4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249259; c=relaxed/simple;
	bh=DAbJ/11kkWV3NfOW/ZZ47OvYR00ddrGOrBip2EkiS9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxXGADP/KvdlyTJDuRnBqxT2SaWbsifVHI8Xy60AcUDcO1iKChKkEGdL1PxmU3v/UKBbjP/zDseA5zcjK5zmcqZ3pLFMAx58KdVpI45Bf8vLR0okYMP2PxXIMIlA6Y3Nmg7N0ufe+exyWqcUwWfApbxzOkfZg3Qo6buC9KNASkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DU0CFc04; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706249256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z72p/1NCFMOucyopgj4TN6714b15v6kjfWKT6hd64FE=;
	b=DU0CFc04VHmtu8ZLll/iRJhhcriw3TXzpgiHxUwNFZXgkEa/mfy5OAChi7EKfUUi+w95KP
	ikpU+H8JLdMAelFyRmPNPXx41hFnFywhnkJkxSb1u8lmdVsBWJZfC7JSPl5JEaXu1pOC9t
	lh7KL7c6hbYjIVfvjybBUjFre5sqaew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Dvx_BaF4N36KKDvV0yy-Nw-1; Fri, 26 Jan 2024 01:07:33 -0500
X-MC-Unique: Dvx_BaF4N36KKDvV0yy-Nw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19D621013664;
	Fri, 26 Jan 2024 06:07:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 925AD492BC6;
	Fri, 26 Jan 2024 06:07:30 +0000 (UTC)
Date: Fri, 26 Jan 2024 14:07:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, akpm@linux-foundation.org,
	ebiederm@xmission.com, hbathini@linux.ibm.com, piliu@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH linux-next v3 00/14] Split crash out from kexec and clean
 up related config items
Message-ID: <ZbNMHwVhWxMyvKH/@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240126045551.GA126645@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126045551.GA126645@dev-arch.thelio-3990X>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 01/25/24 at 09:55pm, Nathan Chancellor wrote:
..... 
> I am seeing a few build failures in my test matrix on next-20240125 that
> appear to be caused by this series although I have not bisected. Some
> reproduction steps:

Thanks for trying this, I have reproduced the linking failure on arm,
will work out a way to fix it.

It's weird, I remember I have built these and passed.

> 
> $ curl -LSso .config https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.armv7
> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- olddefconfig all
> ...
> arm-linux-gnueabi-ld: arch/arm/kernel/machine_kexec.o: in function `arch_crash_save_vmcoreinfo':
> machine_kexec.c:(.text+0x488): undefined reference to `vmcoreinfo_append_str'
> ...
> 
> $ curl -LSso .config https://github.com/archlinuxarm/PKGBUILDs/raw/master/core/linux-aarch64/config
> $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig all
> ...
> aarch64-linux-ld: kernel/kexec_file.o: in function `kexec_walk_memblock.constprop.0':
> kexec_file.c:(.text+0x314): undefined reference to `crashk_res'
> aarch64-linux-ld: kernel/kexec_file.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
> kexec_file.c:(.text+0x314): dangerous relocation: unsupported relocation
> aarch64-linux-ld: kexec_file.c:(.text+0x318): undefined reference to `crashk_res'
> aarch64-linux-ld: drivers/of/kexec.o: in function `of_kexec_alloc_and_setup_fdt':
> kexec.c:(.text+0x580): undefined reference to `crashk_res'
> aarch64-linux-ld: drivers/of/kexec.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
> kexec.c:(.text+0x580): dangerous relocation: unsupported relocation
> aarch64-linux-ld: kexec.c:(.text+0x584): undefined reference to `crashk_res'
> aarch64-linux-ld: kexec.c:(.text+0x590): undefined reference to `crashk_res'
> aarch64-linux-ld: kexec.c:(.text+0x5b0): undefined reference to `crashk_low_res'
> aarch64-linux-ld: drivers/of/kexec.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_low_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
> kexec.c:(.text+0x5b0): dangerous relocation: unsupported relocation
> aarch64-linux-ld: kexec.c:(.text+0x5b4): undefined reference to `crashk_low_res'
> aarch64-linux-ld: kexec.c:(.text+0x5c0): undefined reference to `crashk_low_res'
> ...
> 
> $ curl -LSso .config https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.x86_64
> $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- olddefconfig all
> ...
> x86_64-linux-ld: arch/x86/xen/mmu_pv.o: in function `paddr_vmcoreinfo_note':
> mmu_pv.c:(.text+0x3af3): undefined reference to `vmcoreinfo_note'
> ...
> 
> Cheers,
> Nathan
> 


