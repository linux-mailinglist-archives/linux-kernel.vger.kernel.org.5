Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3E7B6B74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbjJCO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjJCO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:27:55 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FEA3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:27:50 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0Ksx2ZCYzMpnsm;
        Tue,  3 Oct 2023 14:27:49 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0Ksw339czMppBD;
        Tue,  3 Oct 2023 16:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696343269;
        bh=/nPNuGgFr3PymBOsldDXue1xe7of6FqqnLRjBxUqizE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaJh5j9b8Ngf9NNTLtNhRxoEs3X9/6hI2dWG0P1LY+1nAMUD7RliizGc6lWM/FrYi
         UdLq2prrvK5MSRZsZhy+T2OrlOV06vtPloqKKfeQGlj1eZW75mlNBP6ZnlDIkw11R7
         IffWdX1FCs+gX4jfDlrDJY1wSPkqiVeJDyU1mLhg=
Date:   Tue, 3 Oct 2023 16:27:48 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v15 06/11] LSM: wireup Linux Security Module syscalls
Message-ID: <20231003.rohT1ai4aedu@digikod.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-7-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912205658.3432-7-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:56:51PM -0700, Casey Schaufler wrote:
> Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_list_modules
> system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Mickaël Salaün <mic@digikod.net>

> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-api@vger.kernel.org
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl              | 3 +++
>  arch/arm/tools/syscall.tbl                          | 3 +++
>  arch/arm64/include/asm/unistd.h                     | 2 +-
>  arch/arm64/include/asm/unistd32.h                   | 6 ++++++
>  arch/ia64/kernel/syscalls/syscall.tbl               | 3 +++
>  arch/m68k/kernel/syscalls/syscall.tbl               | 3 +++
>  arch/microblaze/kernel/syscalls/syscall.tbl         | 3 +++
>  arch/mips/kernel/syscalls/syscall_n32.tbl           | 3 +++
>  arch/mips/kernel/syscalls/syscall_n64.tbl           | 3 +++
>  arch/mips/kernel/syscalls/syscall_o32.tbl           | 3 +++
>  arch/parisc/kernel/syscalls/syscall.tbl             | 3 +++
>  arch/powerpc/kernel/syscalls/syscall.tbl            | 3 +++
>  arch/s390/kernel/syscalls/syscall.tbl               | 3 +++
>  arch/sh/kernel/syscalls/syscall.tbl                 | 3 +++
>  arch/sparc/kernel/syscalls/syscall.tbl              | 3 +++
>  arch/x86/entry/syscalls/syscall_32.tbl              | 3 +++
>  arch/x86/entry/syscalls/syscall_64.tbl              | 3 +++
>  arch/xtensa/kernel/syscalls/syscall.tbl             | 3 +++
>  include/uapi/asm-generic/unistd.h                   | 9 ++++++++-
>  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 3 +++
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 3 +++
>  tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 3 +++
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 3 +++
>  23 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index ad37569d0507..01f4d0889a36 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -492,3 +492,6 @@
>  560	common	set_mempolicy_home_node		sys_ni_syscall
>  561	common	cachestat			sys_cachestat
>  562	common	fchmodat2			sys_fchmodat2
> +563	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +564	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +565	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index c572d6c3dee0..e12db7b9fb8d 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -466,3 +466,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index bd77253b62e0..f33190f17ebb 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -39,7 +39,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		453
> +#define __NR_compat_syscalls		456
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 78b68311ec81..557345b38893 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -911,6 +911,12 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>  __SYSCALL(__NR_cachestat, sys_cachestat)
>  #define __NR_fchmodat2 452
>  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
> +#define __NR_lsm_get_self_attr 453
> +__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
> +#define __NR_lsm_set_self_attr 454
> +__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
> +#define __NR_lsm_list_modules 455
> +__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>  
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 83d8609aec03..b4f9746a36fb 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -373,3 +373,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 259ceb125367..215547a74374 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -452,3 +452,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index a3798c2637fd..24174dc2045f 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -458,3 +458,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 152034b8e0a0..dc3395c37b1e 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -391,3 +391,6 @@
>  450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	n32	cachestat			sys_cachestat
>  452	n32	fchmodat2			sys_fchmodat2
> +453	n32	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	n32	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	n32	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index cb5e757f6621..06cad00543e8 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -367,3 +367,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	n64	cachestat			sys_cachestat
>  452	n64	fchmodat2			sys_fchmodat2
> +453	n64	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	n64	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	n64	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 1a646813afdc..6ecc14091da3 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -440,3 +440,6 @@
>  450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	o32	cachestat			sys_cachestat
>  452	o32	fchmodat2			sys_fchmodat2
> +453	o32	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	032	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	o32	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index e97c175b56f9..5b321bb46374 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -451,3 +451,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 20e50586e8a2..491eea2f88ba 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -539,3 +539,6 @@
>  450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 0122cc156952..653400f82211 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -455,3 +455,6 @@
>  450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
>  451  common	cachestat		sys_cachestat			sys_cachestat
>  452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
> +453  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
> +454  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
> +455  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index e90d585c4d3e..a4bc4047858e 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -455,3 +455,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 4ed06c71c43f..b134ad689789 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -498,3 +498,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 2d0b1bd866ea..e921e0d6c4b3 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -457,3 +457,6 @@
>  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	i386	cachestat		sys_cachestat
>  452	i386	fchmodat2		sys_fchmodat2
> +453	i386	lsm_get_self_attr	sys_lsm_get_self_attr
> +454	i386	lsm_set_self_attr	sys_lsm_set_self_attr
> +455	i386	lsm_list_modules	sys_lsm_list_modules
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 1d6eee30eceb..b70920626b8c 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -375,6 +375,9 @@
>  451	common	cachestat		sys_cachestat
>  452	common	fchmodat2		sys_fchmodat2
>  453	64	map_shadow_stack	sys_map_shadow_stack
> +454	common	lsm_get_self_attr	sys_lsm_get_self_attr
> +455	common	lsm_set_self_attr	sys_lsm_set_self_attr
> +456	common	lsm_list_modules	sys_lsm_list_modules
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index fc1a4f3c81d9..e1fe5ed7cad8 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -423,3 +423,6 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index abe087c53b4b..f10906c71711 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -823,8 +823,15 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
>  #define __NR_fchmodat2 452
>  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
>  
> +#define __NR_lsm_get_self_attr 453
> +__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
> +#define __NR_lsm_set_self_attr 454
> +__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
> +#define __NR_lsm_list_modules 455
> +__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 453
> +#define __NR_syscalls 456
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> index cfda2511badf..371fce3750c2 100644
> --- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> +++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> @@ -366,3 +366,6 @@
>  449	n64	futex_waitv			sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	n64	cachestat			sys_cachestat
> +453	n64	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	n64	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	n64	lsm_list_modules		sys_lsm_list_modules
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> index 8c0b08b7a80e..35b07f417059 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> @@ -538,3 +538,6 @@
>  449	common  futex_waitv                     sys_futex_waitv
>  450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
> +453	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +455	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> index a6935af2235c..2d196937aff3 100644
> --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> @@ -454,3 +454,6 @@
>  449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
>  450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
>  451  common	cachestat		sys_cachestat			sys_cachestat
> +453  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
> +454  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
> +455  common	lsm_list_modules	sys_lsm_list_modules	sys_lsm_list_modules
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index 227538b0ce80..24dc86e52ddd 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -373,6 +373,9 @@
>  449	common	futex_waitv		sys_futex_waitv
>  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
>  451	common	cachestat		sys_cachestat
> +453	common	lsm_get_self_attr	sys_lsm_get_self_attr
> +454	common	lsm_set_self_attr	sys_lsm_set_self_attr
> +455	common	lsm_list_modules	sys_lsm_list_modules
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> -- 
> 2.41.0
> 
