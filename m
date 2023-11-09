Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1417E67BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjKIKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjKIKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:19:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D310A;
        Thu,  9 Nov 2023 02:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1699525158;
        bh=Z7EokJ1UdALEP2SiDB7dbNsZW0NCKV/oetJXlal69iM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RkjdJPjVAbZzNEKAPr8JL0kTpGz0UCZJIdVVndOCvDWZpxSw6ec518RfWPQG/IkiI
         3U4qG8PeFJgQ1oMBVz7fnILZyAKQ1zplGG4nJux7vUUQsPp8SkZBfT889gzvIRdpmw
         WUQ+WW+9cu902RASJ4kEWsLYh3rMgChUmz1/ldOW9QzCrZm2l5oTa8LM/dau5laC33
         KuCy2ECFzxgm0lOmPhhDCsKGLIbtABjZozYU/ee/LMkGnCNdVshd/3IasKaSCJFT9/
         KHxNE3JhUBjryUMosmrOQrOBshaRABEKKf3tZkVHzFqfXwk5cxkuGy4gRH9dIH1XGz
         jvo7A0kAqYwOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SQybm4Pg2z4xhd;
        Thu,  9 Nov 2023 21:19:00 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Cc:     Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        guoren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 15/22] arch: vdso: consolidate gettime prototypes
In-Reply-To: <d94de5b8-db92-4055-9484-f2666973c02a@app.fastmail.com>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-16-arnd@kernel.org>
 <ecedb0f1-9543-35c6-18bd-723e6bf21173@csgroup.eu>
 <d94de5b8-db92-4055-9484-f2666973c02a@app.fastmail.com>
Date:   Thu, 09 Nov 2023 21:18:54 +1100
Message-ID: <87o7g3qlf5.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:
> On Wed, Nov 8, 2023, at 19:31, Christophe Leroy wrote:
>> Le 08/11/2023 =C3=A0 13:58, Arnd Bergmann a =C3=A9crit=C2=A0:
>
>> powerpc has functions doing more or less the same, they are called=20
>> __c_kernel_clock_gettime() and alike with their prototypes siting in=20
>> arch/powerpc/include/asm/vdso/gettimeofday.h
>>
>> Should those prototypes be moved to include/vdso/gettime.h too and=20
>> eventually renamed, or are they considered too powerpc specific ?
>
> I don't actually know, my initial interpretation was that
> these function names are part of the user ABI for the vdso,
> but I never looked closely enough at how vdso works to
> be sure what the actual ABI is.

AFAIK the ABI is just the symbols we export, as defined in the linker
script:

/*
 * This controls what symbols we export from the DSO.
 */
VERSION
{
	VDSO_VERSION_STRING {
	global:
		__kernel_get_syscall_map;
		__kernel_gettimeofday;
		__kernel_clock_gettime;
		__kernel_clock_getres;
		__kernel_get_tbfreq;
		__kernel_sync_dicache;
		__kernel_sigtramp_rt64;
		__kernel_getcpu;
		__kernel_time;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/powerpc/kernel/vdso/vdso64.lds.S?h=3Dv6.6&#n117

> If __c_kernel_clock_gettime() etc are not part of the user-facing
> ABI, I think renaming them for consistency with the other
> architectures would be best.

The __c symbols are not part of the ABI, so we could rename them.

At the moment though they don't have the same prototype as the generic
versions, because we find the VDSO data in asm and pass it to the C
functions, eg:

int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezon=
e *tz,
			    const struct vdso_data *vd);

I think we can rework that though, by implementing
__arch_get_vdso_data() and getting the vdso_data in C. Then we'd be able
to share the prototypes.

cheers
