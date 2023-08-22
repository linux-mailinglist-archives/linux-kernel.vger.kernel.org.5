Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401CA783A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjHVGeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjHVGeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:34:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45E1E47;
        Mon, 21 Aug 2023 23:33:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 01FC422C44;
        Tue, 22 Aug 2023 06:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692685983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0LefrGrfWIlUUodSIRfdXfGvUMxOpn3Da/x1z7+TACM=;
        b=dcW/Td18f6Fki4csXaJVH2kX+joGxDMOht06LwZTOfNsgqpMfncIfcqoPyYT4pr6k4mnSU
        M0TGSwt1po685EhpFFg+MsGQqwUnObFIRiO2wfy913FH+/Lel6/Fb2dOKqsq92KJa+2uD1
        Bu3YIapaL9IWtKzXxWr75rikpNrC41E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692685983;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0LefrGrfWIlUUodSIRfdXfGvUMxOpn3Da/x1z7+TACM=;
        b=rG0JjH04TqT5CksLvToAlLn8tIAFYWH057rgn75zDtNS/jv7ATjOlZlbjVPfguARFEVAuk
        XrENx1kzxGQ4t0Cg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B5DF2C143;
        Tue, 22 Aug 2023 06:32:58 +0000 (UTC)
Date:   Tue, 22 Aug 2023 08:32:57 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        geert@linux-m68k.org, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, peterz@infradead.org,
        linus.walleij@linaro.org, hpa@zytor.com, kernel@xen0n.name,
        ardb@kernel.org, tsi@tuyoix.net, agordeev@linux.ibm.com,
        paulmck@kernel.org, bhe@redhat.com, masahiroy@kernel.org,
        konrad.wilk@oracle.com, sebastian.reichel@collabora.com,
        samitolvanen@google.com, ojeda@kernel.org,
        juerg.haefliger@canonical.com, borntraeger@linux.ibm.com,
        frederic@kernel.org, arnd@arndb.de, mhiramat@kernel.org,
        aou@eecs.berkeley.edu, keescook@chromium.org, gor@linux.ibm.com,
        anshuman.khandual@arm.com, hca@linux.ibm.com, xin3.li@intel.com,
        npiggin@gmail.com, rmk+kernel@armlinux.org.uk,
        paul.walmsley@sifive.com, boris.ostrovsky@oracle.com,
        ziy@nvidia.com, hbathini@linux.ibm.com, gregkh@linuxfoundation.org,
        kirill.shutemov@linux.intel.com, ndesaulniers@google.com,
        sourabhjain@linux.ibm.com, palmer@dabbelt.com, svens@linux.ibm.com,
        tj@kernel.org, akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v6 02/14] x86/kexec: refactor for kernel/Kconfig.kexec
Message-ID: <20230822063257.GI8826@kitsune.suse.cz>
References: <20230712161545.87870-1-eric.devolder@oracle.com>
 <20230712161545.87870-3-eric.devolder@oracle.com>
 <d8ddd4bd-fbc9-dbe9-f5c3-daf8d89aa46d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ddd4bd-fbc9-dbe9-f5c3-daf8d89aa46d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 13, 2023 at 07:13:57PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/7/13 0:15, Eric DeVolder wrote:
> > The kexec and crash kernel options are provided in the common
> > kernel/Kconfig.kexec. Utilize the common options and provide
> > the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
> > equivalent set of KEXEC and CRASH options.
> > 
> > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > ---
> >  arch/x86/Kconfig | 92 ++++++++++--------------------------------------
> >  1 file changed, 19 insertions(+), 73 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 7422db409770..9767a343f7c2 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2040,88 +2040,34 @@ config EFI_RUNTIME_MAP
> >  
> >  source "kernel/Kconfig.hz"
> >  
> > -config KEXEC
> > -	bool "kexec system call"
> > -	select KEXEC_CORE
> > -	help
> > -	  kexec is a system call that implements the ability to shutdown your
> > -	  current kernel, and to start another kernel.  It is like a reboot
> > -	  but it is independent of the system firmware.   And like a reboot
> > -	  you can start any kernel with it, not just Linux.
> > -
> > -	  The name comes from the similarity to the exec system call.
> > -
> > -	  It is an ongoing process to be certain the hardware in a machine
> > -	  is properly shutdown, so do not be surprised if this code does not
> > -	  initially work for you.  As of this writing the exact hardware
> > -	  interface is strongly in flux, so no good recommendation can be
> > -	  made.
> > -
> > -config KEXEC_FILE
> > -	bool "kexec file based system call"
> > -	select KEXEC_CORE
> > -	select HAVE_IMA_KEXEC if IMA
> > -	depends on X86_64
> > -	depends on CRYPTO=y
> > -	depends on CRYPTO_SHA256=y
> > -	help
> > -	  This is new version of kexec system call. This system call is
> > -	  file based and takes file descriptors as system call argument
> > -	  for kernel and initramfs as opposed to list of segments as
> > -	  accepted by previous system call.
> > +config ARCH_SUPPORTS_KEXEC
> > +	def_bool y
> 
> In v5, Joel Fernandes seems to suggest you change it to the following form:

It's unfortunate that the suggestion did not make it to the mailinglist.

> In arch/Kconfig:
> +config ARCH_SUPPORTS_KEXEC
> +	bool
> 
> In arch/x86/Kconfig:
> config X86
> 	... ...
> +	select ARCH_SUPPORTS_KEXEC
> 
> In arch/arm64/Kconfig:
> config ARM64
> 	... ...
> +	select ARCH_SUPPORTS_KEXEC if PM_SLEEP_SMP

Which might work for this case

> 
> etc..
> 
> You can refer to ARCH_HAS_DEBUG_VIRTUAL.
> 
> >  
> > -config ARCH_HAS_KEXEC_PURGATORY
> > -	def_bool KEXEC_FILE
> > +config ARCH_SUPPORTS_KEXEC_FILE
> > +	def_bool X86_64 && CRYPTO && CRYPTO_SHA256
> >  
> > -config KEXEC_SIG
> > -	bool "Verify kernel signature during kexec_file_load() syscall"
> > +config ARCH_SELECTS_KEXEC_FILE
> > +	def_bool y
> >  	depends on KEXEC_FILE
> > -	help
> > +	select HAVE_IMA_KEXEC if IMA

but not this case, at least not this trivially.

Than for consistency it looks better to keep as is.

Thanks

Michal

> >  
> > -	  This option makes the kexec_file_load() syscall check for a valid
> > -	  signature of the kernel image.  The image can still be loaded without
> > -	  a valid signature unless you also enable KEXEC_SIG_FORCE, though if
> > -	  there's a signature that we can check, then it must be valid.
> > +config ARCH_HAS_KEXEC_PURGATORY
> > +	def_bool KEXEC_FILE
> >  
> > -	  In addition to this option, you need to enable signature
> > -	  verification for the corresponding kernel image type being
> > -	  loaded in order for this to work.
> > +config ARCH_SUPPORTS_KEXEC_SIG
> > +	def_bool y
> >  
> > -config KEXEC_SIG_FORCE
> > -	bool "Require a valid signature in kexec_file_load() syscall"
> > -	depends on KEXEC_SIG
> > -	help
> > -	  This option makes kernel signature verification mandatory for
> > -	  the kexec_file_load() syscall.
> > +config ARCH_SUPPORTS_KEXEC_SIG_FORCE
> > +	def_bool y
> >  
> > -config KEXEC_BZIMAGE_VERIFY_SIG
> > -	bool "Enable bzImage signature verification support"
> > -	depends on KEXEC_SIG
> > -	depends on SIGNED_PE_FILE_VERIFICATION
> > -	select SYSTEM_TRUSTED_KEYRING
> > -	help
> > -	  Enable bzImage signature verification support.
> > +config ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
> > +	def_bool y
> >  
> > -config CRASH_DUMP
> > -	bool "kernel crash dumps"
> > -	depends on X86_64 || (X86_32 && HIGHMEM)
> > -	help
> > -	  Generate crash dump after being started by kexec.
> > -	  This should be normally only set in special crash dump kernels
> > -	  which are loaded in the main kernel with kexec-tools into
> > -	  a specially reserved region and then later executed after
> > -	  a crash by kdump/kexec. The crash dump kernel must be compiled
> > -	  to a memory address not used by the main kernel or BIOS using
> > -	  PHYSICAL_START, or it must be built as a relocatable image
> > -	  (CONFIG_RELOCATABLE=y).
> > -	  For more details see Documentation/admin-guide/kdump/kdump.rst
> > +config ARCH_SUPPORTS_KEXEC_JUMP
> > +	def_bool y
> >  
> > -config KEXEC_JUMP
> > -	bool "kexec jump"
> > -	depends on KEXEC && HIBERNATION
> > -	help
> > -	  Jump between original kernel and kexeced kernel and invoke
> > -	  code in physical address mode via KEXEC
> > +config ARCH_SUPPORTS_CRASH_DUMP
> > +	def_bool X86_64 || (X86_32 && HIGHMEM)
> >  
> >  config PHYSICAL_START
> >  	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
> > 
> 
> -- 
> Regards,
>   Zhen Lei
