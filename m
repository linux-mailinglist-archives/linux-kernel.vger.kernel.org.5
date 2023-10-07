Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56B7BC69A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbjJGKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjJGKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:02:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126CBD;
        Sat,  7 Oct 2023 03:01:55 -0700 (PDT)
X-QQ-mid: bizesmtp77t1696672903tvp5usk6
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 07 Oct 2023 18:01:40 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: nA8mzCjPbKiHnigyrSNt2QncUdhNDjJJS34WRMdLE0y4F8gnTGB3njnhR1HFy
        rak4LOMTDfVDpJ5RHPQKXYbyYLbJdqRpn5MKHf2n7hUlr1BbzxxH0RL4PiCJPXcP2ThCMu8
        apvW3gH4oAvBgWJhIL4XEViAzyEILpuRJ+PCt5srAHeUPFlzBJI8i2N8NhS2lvEckAqxrX2
        2+J74FxmriubHqWFe2Ra11s1aA7g8VCQ1I3McxbAWUJdnUbCzOJZ1kqNz53pkipFOkQV3Cu
        esaGPUgjy44OxzOQQWxsdnDZTopmvFcisKDizzYlBqtLjLaYyYD9qvTZOj+GlaxyL+ak4mr
        0Yj3slYYyEhU95hCW10lhW/h5G9hQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1783803011377048823
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu
Subject: Re: [PATCH v1 2/7] DCE/DSE: add unused syscalls elimination configure support
Date:   Sat,  7 Oct 2023 18:01:39 +0800
Message-Id: <20231007100139.3501-1-tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3f0eaf5fcb19f1c70cab075a97f067846f36f736.1695679700.git.falcon@tinylab.org>
References: <3f0eaf5fcb19f1c70cab075a97f067846f36f736.1695679700.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhangjin,
 
> A minimal embedded Linux system may only has a very few of functions and
> only uses a minimal subset of the posix syscalls, the unused syscalls
> will never be used and eventually in a dead status, that also means disk
> storage and memory footprint waste.
> 
> Based on dead code elimination support, it is able to further eliminate
> the above dead or unused syscalls.
> 
> Firstly, both a new common CONFIG_TRIM_UNUSED_SYSCALLS option and a new
> architecture specific HAVE_TRIM_UNUSED_SYSCALLS are added to enable or
> disable such feature.
> 
> Secondly, a new CONFIG_USED_SYSCALLS option is added to allow configure
> the syscalls used in a target system. CONFIG_USED_SYSCALLS can be a list
> of the used syscalls or a file to store such a list.
> 
> Based on the above options, it is able to only reserve the used syscalls
> and let CONFIG_LD_DEAD_CODE_DATA_ELIMINATION trim the unused ones for us
> automatically.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  init/Kconfig | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 4350d8ba7db4..aa648ce8bca1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1457,6 +1457,11 @@ config BPF
>  	bool
>  	select CRYPTO_LIB_SHA1
>  
> +config HAVE_TRIM_UNUSED_SYSCALLS
> +	bool
> +	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> +	default n
> +
>  menuconfig EXPERT
>  	bool "Configure standard kernel features (expert users)"
>  	# Unhide debug options, to make the on-by-default options visible
> @@ -1683,6 +1688,43 @@ config MEMBARRIER
>  
>  	  If unsure, say Y.
>  
> +config TRIM_UNUSED_SYSCALLS
> +	bool "Trim unused syscalls (EXPERIMENTAL)" if EXPERT
> +	default n
> +	depends on HAVE_TRIM_UNUSED_SYSCALLS
> +	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> +	select LD_DEAD_CODE_DATA_ELIMINATION
> +	help
> +	  Say Y here to trim all of the unused syscalls for a target system.

I think changing this sentence to "Say Y here to trim all of the unused
syscalls, excluding those defined in USED_SYSCALLS." would be clearer.

By the way, consider adding the three files syscall_table_used.c,
compat_syscall_table_used.c, and traps_used.c to the .gitignore file.

> +
> +	  Note, this is only for minimal embedded systems, please don't use it
> +	  for generic Linux distributions.
> +
> +	  If unsure, say N.
> +
> +config USED_SYSCALLS
> +	string "Configure used syscalls (EXPERIMENTAL)" if EXPERT
> +	depends on TRIM_UNUSED_SYSCALLS
> +	default ""
> +	help
> +	  This option allows to configure the syscalls used in a target system,
> +	  the unused ones will be disabled and trimmed by TRIM_UNUSED_SYSCALLS.
> +
> +	  The used syscalls should be listed one by one like this:
> +
> +	      write exit reboot
> +
> +	  Or put them into a file specified by this option, one syscall per
> +	  line is recommended for such a config file:
> +
> +	      write
> +	      exit
> +	      reboot
> +
> +	  Note, If keep this empty, all of the syscalls will be trimmed.
> +
> +	  If unsure, please disable TRIM_UNUSED_SYSCALLS.
> +
>  config KALLSYMS
>  	bool "Load all symbols for debugging/ksymoops" if EXPERT
>  	default y
> -- 
