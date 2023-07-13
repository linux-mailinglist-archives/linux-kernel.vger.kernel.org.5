Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27270751FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjGMLOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjGMLOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:14:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52134211C;
        Thu, 13 Jul 2023 04:14:03 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R1sNg70PRztR5C;
        Thu, 13 Jul 2023 19:10:59 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 19:13:58 +0800
Subject: Re: [PATCH v6 02/14] x86/kexec: refactor for kernel/Kconfig.kexec
To:     Eric DeVolder <eric.devolder@oracle.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <chenhuacai@kernel.org>, <geert@linux-m68k.org>,
        <tsbogend@alpha.franken.de>,
        <James.Bottomley@HansenPartnership.com>, <deller@gmx.de>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-m68k@lists.linux-m68k.org>, <linux-mips@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>
CC:     <kernel@xen0n.name>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <paulmck@kernel.org>,
        <peterz@infradead.org>, <frederic@kernel.org>,
        <akpm@linux-foundation.org>, <ardb@kernel.org>,
        <samitolvanen@google.com>, <juerg.haefliger@canonical.com>,
        <arnd@arndb.de>, <rmk+kernel@armlinux.org.uk>,
        <linus.walleij@linaro.org>, <sebastian.reichel@collabora.com>,
        <rppt@kernel.org>, <kirill.shutemov@linux.intel.com>,
        <anshuman.khandual@arm.com>, <ziy@nvidia.com>,
        <masahiroy@kernel.org>, <ndesaulniers@google.com>,
        <mhiramat@kernel.org>, <ojeda@kernel.org>, <xin3.li@intel.com>,
        <tj@kernel.org>, <gregkh@linuxfoundation.org>, <tsi@tuyoix.net>,
        <bhe@redhat.com>, <hbathini@linux.ibm.com>,
        <sourabhjain@linux.ibm.com>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>
References: <20230712161545.87870-1-eric.devolder@oracle.com>
 <20230712161545.87870-3-eric.devolder@oracle.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d8ddd4bd-fbc9-dbe9-f5c3-daf8d89aa46d@huawei.com>
Date:   Thu, 13 Jul 2023 19:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230712161545.87870-3-eric.devolder@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/13 0:15, Eric DeVolder wrote:
> The kexec and crash kernel options are provided in the common
> kernel/Kconfig.kexec. Utilize the common options and provide
> the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
> equivalent set of KEXEC and CRASH options.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/Kconfig | 92 ++++++++++--------------------------------------
>  1 file changed, 19 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7422db409770..9767a343f7c2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2040,88 +2040,34 @@ config EFI_RUNTIME_MAP
>  
>  source "kernel/Kconfig.hz"
>  
> -config KEXEC
> -	bool "kexec system call"
> -	select KEXEC_CORE
> -	help
> -	  kexec is a system call that implements the ability to shutdown your
> -	  current kernel, and to start another kernel.  It is like a reboot
> -	  but it is independent of the system firmware.   And like a reboot
> -	  you can start any kernel with it, not just Linux.
> -
> -	  The name comes from the similarity to the exec system call.
> -
> -	  It is an ongoing process to be certain the hardware in a machine
> -	  is properly shutdown, so do not be surprised if this code does not
> -	  initially work for you.  As of this writing the exact hardware
> -	  interface is strongly in flux, so no good recommendation can be
> -	  made.
> -
> -config KEXEC_FILE
> -	bool "kexec file based system call"
> -	select KEXEC_CORE
> -	select HAVE_IMA_KEXEC if IMA
> -	depends on X86_64
> -	depends on CRYPTO=y
> -	depends on CRYPTO_SHA256=y
> -	help
> -	  This is new version of kexec system call. This system call is
> -	  file based and takes file descriptors as system call argument
> -	  for kernel and initramfs as opposed to list of segments as
> -	  accepted by previous system call.
> +config ARCH_SUPPORTS_KEXEC
> +	def_bool y

In v5, Joel Fernandes seems to suggest you change it to the following form:
In arch/Kconfig:
+config ARCH_SUPPORTS_KEXEC
+	bool

In arch/x86/Kconfig:
config X86
	... ...
+	select ARCH_SUPPORTS_KEXEC

In arch/arm64/Kconfig:
config ARM64
	... ...
+	select ARCH_SUPPORTS_KEXEC if PM_SLEEP_SMP

etc..

You can refer to ARCH_HAS_DEBUG_VIRTUAL.

>  
> -config ARCH_HAS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +config ARCH_SUPPORTS_KEXEC_FILE
> +	def_bool X86_64 && CRYPTO && CRYPTO_SHA256
>  
> -config KEXEC_SIG
> -	bool "Verify kernel signature during kexec_file_load() syscall"
> +config ARCH_SELECTS_KEXEC_FILE
> +	def_bool y
>  	depends on KEXEC_FILE
> -	help
> +	select HAVE_IMA_KEXEC if IMA
>  
> -	  This option makes the kexec_file_load() syscall check for a valid
> -	  signature of the kernel image.  The image can still be loaded without
> -	  a valid signature unless you also enable KEXEC_SIG_FORCE, though if
> -	  there's a signature that we can check, then it must be valid.
> +config ARCH_HAS_KEXEC_PURGATORY
> +	def_bool KEXEC_FILE
>  
> -	  In addition to this option, you need to enable signature
> -	  verification for the corresponding kernel image type being
> -	  loaded in order for this to work.
> +config ARCH_SUPPORTS_KEXEC_SIG
> +	def_bool y
>  
> -config KEXEC_SIG_FORCE
> -	bool "Require a valid signature in kexec_file_load() syscall"
> -	depends on KEXEC_SIG
> -	help
> -	  This option makes kernel signature verification mandatory for
> -	  the kexec_file_load() syscall.
> +config ARCH_SUPPORTS_KEXEC_SIG_FORCE
> +	def_bool y
>  
> -config KEXEC_BZIMAGE_VERIFY_SIG
> -	bool "Enable bzImage signature verification support"
> -	depends on KEXEC_SIG
> -	depends on SIGNED_PE_FILE_VERIFICATION
> -	select SYSTEM_TRUSTED_KEYRING
> -	help
> -	  Enable bzImage signature verification support.
> +config ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
> +	def_bool y
>  
> -config CRASH_DUMP
> -	bool "kernel crash dumps"
> -	depends on X86_64 || (X86_32 && HIGHMEM)
> -	help
> -	  Generate crash dump after being started by kexec.
> -	  This should be normally only set in special crash dump kernels
> -	  which are loaded in the main kernel with kexec-tools into
> -	  a specially reserved region and then later executed after
> -	  a crash by kdump/kexec. The crash dump kernel must be compiled
> -	  to a memory address not used by the main kernel or BIOS using
> -	  PHYSICAL_START, or it must be built as a relocatable image
> -	  (CONFIG_RELOCATABLE=y).
> -	  For more details see Documentation/admin-guide/kdump/kdump.rst
> +config ARCH_SUPPORTS_KEXEC_JUMP
> +	def_bool y
>  
> -config KEXEC_JUMP
> -	bool "kexec jump"
> -	depends on KEXEC && HIBERNATION
> -	help
> -	  Jump between original kernel and kexeced kernel and invoke
> -	  code in physical address mode via KEXEC
> +config ARCH_SUPPORTS_CRASH_DUMP
> +	def_bool X86_64 || (X86_32 && HIGHMEM)
>  
>  config PHYSICAL_START
>  	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
> 

-- 
Regards,
  Zhen Lei
