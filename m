Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5E77CEECF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJSEt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:49:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5750121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697690988;
        bh=rlQZx9JJxSdr3/h/TbJIqIbao0AYCeJ36JQgRbnJMws=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Eks/UeYwUxWgNbjQ9pv/zgvRIDI5GwHJohg39vWxMdzp3sOO4ebFRh4gVy+Ous5y2
         LRnucQQjKcAdZMedSuMJipgyKyux4AFVShCDjNakwujvQKMJm/lUgyaIxfaily6o+Q
         OmdrZ0zm/U9bRind8TgK4gML5WA1sjKZYF908uz9KoaA+HyPeQlcavjZHu3j/nAV19
         Vw6VQE/8Sb9L4Vn2qhQtjxq9Sp3vcruxlxE8w9HEawnF64di0dzoG2o7HjMD333FoN
         QcvmexOkPKA1sysVmz1t4tn4k/FG/yVsrzPir6UF82iZlBmZcOKmJCJDrV/q4CFMgV
         uSsFmtty8f9hQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9wHc3181z4x80;
        Thu, 19 Oct 2023 15:49:48 +1100 (AEDT)
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
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] powerpc/smp: Add read_mostly attribute
In-Reply-To: <20231018163751.2423181-6-srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-6-srikar@linux.vnet.ibm.com>
Date:   Thu, 19 Oct 2023 15:49:48 +1100
Message-ID: <87mswf5i8j.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> There are some variables that are only updated at boot time.
> So add read_mostly attribute to such variables

If they're only updated at boot time then __ro_after_init would be the
better annotation.

cheers

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 29da9262cb17..b1eb11a66902 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -77,10 +77,10 @@ static DEFINE_PER_CPU(int, cpu_state) = { 0 };
>  #endif
>  
>  struct task_struct *secondary_current;
> -bool has_big_cores;
> -bool coregroup_enabled;
> -bool thread_group_shares_l2;
> -bool thread_group_shares_l3;
> +bool has_big_cores __read_mostly;
> +bool coregroup_enabled __read_mostly;
> +bool thread_group_shares_l2 __read_mostly;
> +bool thread_group_shares_l3 __read_mostly;
>  
>  DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
>  DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
> @@ -987,7 +987,7 @@ static int __init init_thread_group_cache_map(int cpu, int cache_property)
>  	return 0;
>  }
>  
> -static bool shared_caches;
> +static bool shared_caches __read_mostly;
>  DEFINE_STATIC_KEY_FALSE(powerpc_asym_packing);
>  
>  #ifdef CONFIG_SCHED_SMT
> -- 
> 2.31.1
