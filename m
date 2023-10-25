Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787AA7D71BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjJYQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJYQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:29:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD510E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:29:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A95FC433C8;
        Wed, 25 Oct 2023 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698251348;
        bh=N32nvEq5O286yd+ttiB1pgrNAbStdRL1vSHhePO5p0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJBS0L4RzSG8tAourCAatHd0t27wxqx8mQnqr4y5By27WRVpfn2BXehziF2KmREXj
         MZVZH4vcriS6lBRTmcAEdbAGQDfnxFuCBS8M24OFi/Ogy5higVYOFHSC9GXqpaCguA
         0q51N8GaqwijL9vxlmuTJFpmvucCIFb3pAgfJw3qkji4L7ydB/b43Y1IM+yc23t5II
         RT8T65Rb5Xd32zOPveTOLhmwHWJtdtRgokcEpn6jXvtqdkOS4ohIC1/V/2fwtfHVO/
         15nJLKdow1zhWjhWyq34r6zEpNPnAhswfBgZ1k4a0YnvzkT1bqJTcN/cUF7S7m8YgQ
         XmS2nlmzDc8Yw==
Date:   Wed, 25 Oct 2023 09:29:06 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 12/12] x86/bugs: Add a separate config for missing
 mitigation
Message-ID: <20231025162906.abnyb7xum7cpjwxy@treble>
References: <20231019181158.1982205-1-leitao@debian.org>
 <20231019181158.1982205-13-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019181158.1982205-13-leitao@debian.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:11:58AM -0700, Breno Leitao wrote:
> Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
> where some mitigations have entries in Kconfig, and they could be
> modified, while others mitigations do not have Kconfig entries, and
> could not be controlled at build time.
> 
> Create an entry for each CPU mitigation under
> CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
> them at compilation time.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

We also probably need a CONFIG_MITIGATION_MELTDOWN.

> ---
>  arch/x86/Kconfig           | 93 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/bugs.c | 39 ++++++++++------
>  2 files changed, 117 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a5cada7443ea..ccdcb1dcdc0c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2591,6 +2591,99 @@ config MITIGATION_GDS_FORCE
>  
>  	  If in doubt, say N.
>  
> +config MITIGATION_MDS
> +	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
> +	depends on CPU_SUP_INTEL
> +	default y
> +	help
> +	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
> +	  a hardware vulnerability which allows unprivileged speculative access
> +	  to data which is available in various CPU internal buffer. Deeper

buffers

> +	  technical information is available in the MDS specific x86 architecture
> +	  section: Documentation/arch/x86/mds.rst.

I believe the high-level document is actually
Documentation/admin-guide/hw-vuln/mds.rst.

> +config MITIGATION_TAA
> +	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
> +	depends on CPU_SUP_INTEL
> +	default y
> +	help
> +	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
> +	  vulnerability that allows unprivileged speculative access to data
> +	  which is available in various CPU internal buffers by using
> +	  asynchronous aborts within an Intel TSX transactional region.

Refer to Documentation/admin-guide/hw-vuln/tsx_async_abort.rst

> +config MITIGATION_MMIO_STALE_DATA
> +	bool "Mitigate MMIO Stale Data hardware bug"
> +	depends on CPU_SUP_INTEL
> +	default y
> +	help
> +	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
> +	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
> +	  vulnerabilities that can expose data. The vulnerabilities require the
> +	  attacker to have access to MMIO.

Refer to Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst

> +config MITIGATION_L1TF
> +	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"

	depends on CPU_SUP_INTEL

> +	default y
> +	help
> +	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
> +	  hardware vulnerability which allows unprivileged speculative access to data
> +	  which is available in the Level 1 Data Cache when the page table
> +	  entry controlling the virtual address.

-EGRAMMAR

Also refer to Documentation/admin-guide/hw-vuln/l1tf.rst

> +config MITIGATION_RETBLEED
> +	bool "Mitigate RETBleed hardware bug"

	depends on CPU_SUP_INTEL || (CPU_SUP_AMD && MITIGATION_UNRET_ENTRY)

> +config MITIGATION_SPECTRE_V1
> +	bool "Mitigate SPECTRE V1 hardware bug"
> +	default y
> +	help
> +	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
> +	  class of side channel attacks that takes advantage of speculative
> +	  execution that bypasses conditional branch instructions used for
> +	  memory access bounds check.

Refer to Documentation/admin-guide/hw-vuln/spectre.rst

> +config MITIGATION_SPECTRE_V2
> +	bool "Mitigate SPECTRE V2 hardware bug"
> +	default y
> +	help
> +	  Enable mitigation for Spectre V2 (Branch Target Injection). Spectre
> +	  V2 is a class of side channel attacks that takes advantage of
> +	  indirect branch predictors inside the processor. In Spectre variant 2
> +	  attacks, the attacker can steer speculative indirect branches in the
> +	  victim to gadget code by poisoning the branch target buffer of a CPU
> +	  used for predicting indirect branch addresses.

Refer to Documentation/admin-guide/hw-vuln/spectre.rst

> +config MITIGATION_SRBDS
> +	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
> +	depends on CPU_SUP_INTEL
> +	default y
> +	help
> +	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
> +	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
> +	  Sampling (MDS) techniques to infer values returned from special
> +	  register accesses. An unprivileged user can extract values returned
> +	  from RDRAND and RDSEED executed on another core or sibling thread
> +	  using MDS techniques.

Refer to Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst

> +	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
>  	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
>  	    cpu_mitigations_off())
>  		return SPECTRE_V2_CMD_NONE;

I'm thinking CONFIG_MITIGATION_SPECTRE_V2 should also affect whether the spectre v2 user
mitigation gets enabled.

-- 
Josh
