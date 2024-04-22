Return-Path: <linux-kernel+bounces-153414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A28ACDD6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D9EB24D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685214F13A;
	Mon, 22 Apr 2024 13:08:40 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29314EC67
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791320; cv=none; b=rpugemHNwgAMdeoVociIcwWFrTcePVgJyauAldNTI73HkXOjkAGzcSxfM6YXbGziVju22zjUBJgvCZLyLum72EqDq2ECC/8tI+4Z4nca1vGtDlcO1tcsip+8AetZfQJQGOKOImGvV07b9RmTlVzedhyctJO0mU6tV10VrTbH/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791320; c=relaxed/simple;
	bh=Fe/jLU7y8EjYZ1hI0fi5WolQe+f8y52gdZ7hpKDSrhY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hMfQowloMDJiUF+RxYAqoc0Hw8vGCHDdVFX82FfUenj3xeCamAM3SE9Ezu3YfZOpS4H9A+G+29koEUwuFx8Czbg/EzGGyRf1SGd01KIlXTqZFazSIUZbEjR2QX8DWn+qnbp7znkHuoiDAno+6ebaUXWPfELIqJk7CMdfra874W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by andre.telenet-ops.be with bizsmtp
	id ED8U2C00M0SSLxL01D8UkT; Mon, 22 Apr 2024 15:08:28 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rytPI-001wmi-Gr;
	Mon, 22 Apr 2024 15:08:28 +0200
Date: Mon, 22 Apr 2024 15:08:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: Kent Overstreet <kent.overstreet@linux.dev>, 
    Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.9-rc5
In-Reply-To: <20240422124533.1363483-1-geert@linux-m68k.org>
Message-ID: <34dec962-474b-353-a33f-de147cffa06c@linux-m68k.org>
References: <CAHk-=wgfck-6-2YcD3Bzhjo0E0L0g2HGSZksB9pzRCah=Y4HBw@mail.gmail.com> <20240422124533.1363483-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Apr 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.9-rc5[1] to v6.9-rc4[3], the summaries are:
>  - build errors: +6/-5

   + /kisskb/src/arch/sparc/kernel/setup_64.c: error: no previous prototype for 'alloc_irqstack_bootmem' [-Werror=missing-prototypes]:  => 602:13
   + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]:  => 254:1
   + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]:  => 282:1
   + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]:  => 307:1
   + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]:  => 343:1

sparc64-gcc13/sparc64-allmodconfig (seen before in other configs)

   + /kisskb/src/fs/bcachefs/btree_io.c: error: format '%lu' expects argument of type 'long unsigned int', but argument 12 has type 'unsigned int' [-Werror=format=]:  => 891:34, 891:6

m68k-gcc8/m68k-allmodconfig
m68k-gcc8/m68k-defconfig
m68k-gcc8/sun3_defconfig
m68k-gcc11/m68k-allmodconfig
m68k-gcc11/m68k-defconfig
m68k-gcc11/sun3_defconfig
m68k-gcc13/m68k-allmodconfig
m68k-gcc13/m68k-defconfig
m68k-gcc13/sun3_defconfig
mips-gcc8/mips-allmodconfig
mips-gcc13/mips-allmodconfig
parisc-gcc13/parisc-allmodconfig
powerpc-gcc5/ppc32_allmodconfig
powerpc-gcc13/ppc32_allmodconfig
sh4-gcc13/sh-allmodconfig
sh4-gcc13/sh-allyesconfig
sparc64-gcc5/sparc-allmodconfig
sparc64-gcc13/sparc-allmodconfig
xtensa-gcc13/xtensa-allmodconfig

(Multiple) fixes available

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ed30a4a51bb196781c8058073ea720133a65596f/ (all 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0bbac3facb5d6cc0171c45c9873a2dc96bea9680/ (all 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

