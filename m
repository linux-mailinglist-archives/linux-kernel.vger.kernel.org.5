Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0328098A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572908AbjLHBbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjLHBbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED21712
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701999098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyLK474iLRCVjM9/S7HxhA2tux3/UIG2K/rlVdDLtwA=;
        b=bBL1qHaQmZpJc8tuBKISX8SLR4Ro32TRCxOawIyRmbRC69Ze4y4PS/yeVXxg5heeIDNv61
        a21WN6jVOWYsGMX+DOjCGl4GdFrrJFYxnKAGJNVMU3aI7qsN0ETrH+/C8xnPIa/uhXwnx6
        +nOpEtcooof7bMbigYl+9XvGCoMWFG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-KfAOKfVyMEyFVsgb8DP7Yw-1; Thu, 07 Dec 2023 20:31:37 -0500
X-MC-Unique: KfAOKfVyMEyFVsgb8DP7Yw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFA8085A589;
        Fri,  8 Dec 2023 01:31:36 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA7E6C185A0;
        Fri,  8 Dec 2023 01:31:32 +0000 (UTC)
Date:   Fri, 8 Dec 2023 09:31:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 2/6] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-ID: <ZXJx72/YOGn0l4pI@fedora>
References: <20231207203900.859776-1-yury.norov@gmail.com>
 <20231207203900.859776-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207203900.859776-3-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 12:38:56PM -0800, Yury Norov wrote:
> Because nmsk and irqmsk are stable, extra atomicity is not required.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/group_cpus.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index ee272c4cefcc..8eb18c6bbf3b 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  		if (cpu >= nr_cpu_ids)
>  			return;
>  
> -		cpumask_clear_cpu(cpu, nmsk);
> -		cpumask_set_cpu(cpu, irqmsk);
> +		__cpumask_clear_cpu(cpu, nmsk);
> +		__cpumask_set_cpu(cpu, irqmsk);
>  		cpus_per_grp--;
>  
>  		/* If the cpu has siblings, use them first */
> @@ -34,9 +34,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  			sibl = cpumask_next(sibl, siblmsk);
>  			if (sibl >= nr_cpu_ids)
>  				break;
> -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> -				continue;
> -			cpumask_set_cpu(sibl, irqmsk);
> +			__cpumask_clear_cpu(sibl, nmsk);
> +			__cpumask_set_cpu(sibl, irqmsk);
>  			cpus_per_grp--;

Here the change isn't simply to remove atomicity, and the test
part of cpumask_test_and_clear_cpu() is removed, so logic is changed,
I feel the correct change should be:

	if (cpumask_test_cpu(sibl, nmsk)) {
		__cpumask_clear_cpu(sibl, nmsk);
		__cpumask_set_cpu(sibl, irqmsk);
  		cpus_per_grp--;
	}



Thanks,
Ming

