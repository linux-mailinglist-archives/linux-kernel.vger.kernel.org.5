Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4427CEEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjJSEir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:38:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA811F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697690320;
        bh=Rv0RE/UnlB8ImLuckgrocUTCXXYAwShhb75jdX29cjc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JC0wjKhxL2KrO9rfTQylV0wrN1YQQTse08jfgDBNxbyiJkS4q1SvRMJIWc9XG81gy
         LcHjOsq5IYrWqiuG48TdYsX0dhkH1VpWMq1uHO5zxGpWlmKIE+tMdgcKSZpW1s1Y27
         9Gaas4gEdVokMsT90w7cSvRiQB4Wa1Yl12Myy6rlAycLx5YPkbTjG7xtcwMZx2inmA
         BlnmzP8TYW7X+Kg6wbXhogcS33ZvEpxWSp29K7T6Swpv2E+Eiq8buPG+rNlg/ta9Xg
         mOTTQKQIjXqG3MtyRMTa3b1hPWklNMPmud9M2pWbfd6LpRf9lvgCsZwZkAcWdjziyZ
         AgTu/xGIiB7ug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9w2m3N7Wz4xZS;
        Thu, 19 Oct 2023 15:38:40 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] powerpc/smp: Enable Asym packing for cores on
 shared processor
In-Reply-To: <20231018163751.2423181-3-srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-3-srikar@linux.vnet.ibm.com>
Date:   Thu, 19 Oct 2023 15:38:40 +1100
Message-ID: <87v8b35ir3.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> If there are shared processor LPARs, underlying Hypervisor can have more
> virtual cores to handle than actual physical cores.
>
> Starting with Power 9, a core has 2 nearly independent thread groups.

You need to be clearer here that you're talking about "big cores", not
SMT4 cores as seen on bare metal systems.

> On a shared processors LPARs, it helps to pack threads to lesser number
> of cores so that the overall system performance and utilization
> improves. PowerVM schedules at a core level. Hence packing to fewer
> cores helps.
>
> For example: Lets says there are two 8-core Shared LPARs that are
> actually sharing a 8 Core shared physical pool, each running 8 threads
> each. Then Consolidating 8 threads to 4 cores on each LPAR would help
> them to perform better. This is because each of the LPAR will get
> 100% time to run applications and there will no switching required by
> the Hypervisor.
>
> To achieve this, enable SD_ASYM_PACKING flag at CACHE, MC and DIE level.

.. when the system is running in shared processor mode and has big cores.

cheers

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 37c41297c9ce..498c2d51fc20 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1009,9 +1009,20 @@ static int powerpc_smt_flags(void)
>   */
>  static int powerpc_shared_cache_flags(void)
>  {
> +	if (static_branch_unlikely(&powerpc_asym_packing))
> +		return SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
> +
>  	return SD_SHARE_PKG_RESOURCES;
>  }
>  
> +static int powerpc_shared_proc_flags(void)
> +{
> +	if (static_branch_unlikely(&powerpc_asym_packing))
> +		return SD_ASYM_PACKING;
> +
> +	return 0;
> +}
> +
>  /*
>   * We can't just pass cpu_l2_cache_mask() directly because
>   * returns a non-const pointer and the compiler barfs on that.
> @@ -1048,8 +1059,8 @@ static struct sched_domain_topology_level powerpc_topology[] = {
>  	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
>  #endif
>  	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
> -	{ cpu_mc_mask, SD_INIT_NAME(MC) },
> -	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
> +	{ cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC) },
> +	{ cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(DIE) },
>  	{ NULL, },
>  };
>  
> @@ -1687,6 +1698,8 @@ static void __init fixup_topology(void)
>  	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
>  		pr_info_once("Enabling Asymmetric SMT scheduling\n");
>  		static_branch_enable(&powerpc_asym_packing);
> +	} else if (is_shared_processor() && has_big_cores) {
> +		static_branch_enable(&powerpc_asym_packing);
>  	}
>  
>  #ifdef CONFIG_SCHED_SMT
> -- 
> 2.31.1
