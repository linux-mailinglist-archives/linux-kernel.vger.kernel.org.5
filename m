Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B3E777CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjHJP4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjHJP4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:56:42 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515032115;
        Thu, 10 Aug 2023 08:56:41 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 259413F5DF;
        Thu, 10 Aug 2023 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691683000;
        bh=oxknFFrhSoPalhOwgpfwiHLnhnBFvsaBmfQjf+JFwQA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=QY4gZItvT4qpeiOjYq3oejPjOORAj5wFXT+zcSEKDTC7yDMnecstPu/NwMnorlQIO
         JaMqK4GsX6SXDe+Jykz5xIXjynqsFiUPEhUQkNiDt44OtS0brjiXLWAQU7k0K9sILm
         CasS+9KQedkOPmqwR8aYeLr1LpPEU0xd4oBhI6EBSN5r8JC2hUhNNU/qSO4q8v8Hh7
         i9rxYl8IbHpp240NDBujOJtZKgJqx2lFADA3/Gi39cpljr5Pq4el3HV8ztlONs+H48
         7xHuiZ7chVAYNGE46Nx2BcQb4EjWbrOj6hFDUiP8qyYPu3IW7q8trDcTroUGMAOxg6
         e1it7+fHQkRbw==
Message-ID: <191e4bbe-ed4e-562f-aba8-97042a3d442f@canonical.com>
Date:   Thu, 10 Aug 2023 08:56:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 06/11] LSM: wireup Linux Security Module syscalls
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-7-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230802174435.11928-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 10:44, Casey Schaufler wrote:
> Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_list_modules
> system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-api@vger.kernel.org

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>   arch/alpha/kernel/syscalls/syscall.tbl              | 3 +++
>   arch/arm/tools/syscall.tbl                          | 3 +++
>   arch/arm64/include/asm/unistd.h                     | 2 +-
>   arch/arm64/include/asm/unistd32.h                   | 6 ++++++
>   arch/ia64/kernel/syscalls/syscall.tbl               | 3 +++
>   arch/m68k/kernel/syscalls/syscall.tbl               | 3 +++
>   arch/microblaze/kernel/syscalls/syscall.tbl         | 3 +++
>   arch/mips/kernel/syscalls/syscall_n32.tbl           | 3 +++
>   arch/mips/kernel/syscalls/syscall_n64.tbl           | 3 +++
>   arch/mips/kernel/syscalls/syscall_o32.tbl           | 3 +++
>   arch/parisc/kernel/syscalls/syscall.tbl             | 3 +++
>   arch/powerpc/kernel/syscalls/syscall.tbl            | 3 +++
>   arch/s390/kernel/syscalls/syscall.tbl               | 3 +++
>   arch/sh/kernel/syscalls/syscall.tbl                 | 3 +++
>   arch/sparc/kernel/syscalls/syscall.tbl              | 3 +++
>   arch/x86/entry/syscalls/syscall_32.tbl              | 3 +++
>   arch/x86/entry/syscalls/syscall_64.tbl              | 3 +++
>   arch/xtensa/kernel/syscalls/syscall.tbl             | 3 +++
>   include/uapi/asm-generic/unistd.h                   | 9 ++++++++-
>   tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 3 +++
>   tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 3 +++
>   tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 3 +++
>   tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 3 +++
>   23 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 1f13995d00d7..bb00aecf1dc4 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -491,3 +491,6 @@
>   559	common  futex_waitv                     sys_futex_waitv
>   560	common	set_mempolicy_home_node		sys_ni_syscall
>   561	common	cachestat			sys_cachestat
> +562	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +563	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +564	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 8ebed8a13874..a148e71905a7 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -465,3 +465,6 @@
>   449	common	futex_waitv			sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 64a514f90131..63a8a9c4abc1 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -39,7 +39,7 @@
>   #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>   #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>   
> -#define __NR_compat_syscalls		452
> +#define __NR_compat_syscalls		455
>   #endif
>   
>   #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index d952a28463e0..df214b7ec5dd 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -909,6 +909,12 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>   __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>   #define __NR_cachestat 451
>   __SYSCALL(__NR_cachestat, sys_cachestat)
> +#define __NR_lsm_get_self_attr 452
> +__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
> +#define __NR_lsm_set_self_attr 453
> +__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
> +#define __NR_lsm_list_modules 454
> +__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>   
>   /*
>    * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index f8c74ffeeefb..1b53f9d28514 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -372,3 +372,6 @@
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 4f504783371f..f7a91d458f0c 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -451,3 +451,6 @@
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 858d22bf275c..2b24b19a9bec 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -457,3 +457,6 @@
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 1976317d4e8b..0ff4072ed024 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -390,3 +390,6 @@
>   449	n32	futex_waitv			sys_futex_waitv
>   450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	n32	cachestat			sys_cachestat
> +452	n32	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	n32	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	n32	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index cfda2511badf..9c38818dd9f9 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -366,3 +366,6 @@
>   449	n64	futex_waitv			sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	n64	cachestat			sys_cachestat
> +452	n64	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	n64	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 7692234c3768..a07e1ba91511 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -439,3 +439,6 @@
>   449	o32	futex_waitv			sys_futex_waitv
>   450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	o32	cachestat			sys_cachestat
> +452	o32	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	032	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	o32	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index a0a9145b6dd4..36cc0130ee1d 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -450,3 +450,6 @@
>   449	common	futex_waitv			sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 8c0b08b7a80e..fe2ba9e8a413 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -538,3 +538,6 @@
>   449	common  futex_waitv                     sys_futex_waitv
>   450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index a6935af2235c..fe3fc23697b0 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -454,3 +454,6 @@
>   449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
>   450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
>   451  common	cachestat		sys_cachestat			sys_cachestat
> +452  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
> +453  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
> +454  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 97377e8c5025..319968dccde9 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -454,3 +454,6 @@
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index faa835f3c54a..9ca3fb4c05de 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -497,3 +497,6 @@
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index bc0a3c941b35..4caa3c415528 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -456,3 +456,6 @@
>   449	i386	futex_waitv		sys_futex_waitv
>   450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	i386	cachestat		sys_cachestat
> +452	i386	lsm_get_self_attr	sys_lsm_get_self_attr
> +453	i386	lsm_set_self_attr	sys_lsm_set_self_attr
> +454	i386	lsm_list_modules	sys_lsm_list_modules
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 227538b0ce80..c5f85f93e80b 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -373,6 +373,9 @@
>   449	common	futex_waitv		sys_futex_waitv
>   450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
>   451	common	cachestat		sys_cachestat
> +452	common	lsm_get_self_attr	sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr	sys_lsm_set_self_attr
> +454	common	lsm_list_modules	sys_lsm_list_modules
>   
>   #
>   # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 2b69c3c035b6..509379512c27 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -422,3 +422,6 @@
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index fd6c1cb585db..b5588efc0933 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -820,8 +820,15 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>   #define __NR_cachestat 451
>   __SYSCALL(__NR_cachestat, sys_cachestat)
>   
> +#define __NR_lsm_get_self_attr 452
> +__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
> +#define __NR_lsm_set_self_attr 453
> +__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
> +#define __NR_lsm_list_modules 454
> +__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
> +
>   #undef __NR_syscalls
> -#define __NR_syscalls 452
> +#define __NR_syscalls 455
>   
>   /*
>    * 32 bit systems traditionally used different
> diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> index cfda2511badf..9c38818dd9f9 100644
> --- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> +++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> @@ -366,3 +366,6 @@
>   449	n64	futex_waitv			sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	n64	cachestat			sys_cachestat
> +452	n64	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	n64	lsm_list_modules		sys_lsm_list_modules
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> index 8c0b08b7a80e..fe2ba9e8a413 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> @@ -538,3 +538,6 @@
>   449	common  futex_waitv                     sys_futex_waitv
>   450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	common	cachestat			sys_cachestat
> +452	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> +454	common	lsm_list_modules		sys_lsm_list_modules
> diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> index a6935af2235c..a18e9d7cf92b 100644
> --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> @@ -454,3 +454,6 @@
>   449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
>   450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
>   451  common	cachestat		sys_cachestat			sys_cachestat
> +452  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
> +453  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
> +454  common	lsm_list_modules	sys_lsm_list_modules	sys_lsm_list_modules
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index 227538b0ce80..c5f85f93e80b 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -373,6 +373,9 @@
>   449	common	futex_waitv		sys_futex_waitv
>   450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
>   451	common	cachestat		sys_cachestat
> +452	common	lsm_get_self_attr	sys_lsm_get_self_attr
> +453	common	lsm_set_self_attr	sys_lsm_set_self_attr
> +454	common	lsm_list_modules	sys_lsm_list_modules
>   
>   #
>   # Due to a historical design error, certain syscalls are numbered differently

