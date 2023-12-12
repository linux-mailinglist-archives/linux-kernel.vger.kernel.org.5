Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045980E813
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjLLJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjLLJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:47:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F76DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702374429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Z4izZCgt79zYtzyOfi1Nl1O4b1OMQ69ngPpE7NnWJE=;
        b=CUKMv/GQu9IQakyYi7p995N1rGY2yL9b00TPGzDmU5G+ANS4SxQD4UiLbfo3jvRqATalJp
        +m/L61GTIs0b0lTkKed/NudKHvXKyGrorg0hfSeKYRaaUlux7yOiZzAkbDtYzOq6OoxcAz
        vfHLw+8m45eeqww3rd+dcGzyD3qwpzQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-frAbWtWAPoaDxVKPR6b2KQ-1; Tue, 12 Dec 2023 04:47:04 -0500
X-MC-Unique: frAbWtWAPoaDxVKPR6b2KQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24DDE83538E;
        Tue, 12 Dec 2023 09:47:04 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5D111C060AF;
        Tue, 12 Dec 2023 09:46:58 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:46:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        ming.lei@redhat.com
Subject: Re: [PATCH v3 2/7] lib/group_cpus: optimize inner loop in
 grp_spread_init_one()
Message-ID: <ZXgsDcM21H/2BTck@fedora>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212042108.682072-3-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 08:21:02PM -0800, Yury Norov wrote:
> The loop starts from the beginning every time we switch to the next
> sibling mask. This is the Schlemiel the Painter's style of coding
> because we know for sure that nmsk is clear up to current CPU, and we
> can just continue from the next CPU.
> 
> Also, we can do it nicer if leverage the dedicated for_each() iterator,
> and simplify the logic of clearing a bit in nmsk.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/group_cpus.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index ee272c4cefcc..10dead3ab0e0 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -30,14 +30,13 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  
>  		/* If the cpu has siblings, use them first */
>  		siblmsk = topology_sibling_cpumask(cpu);
> -		for (sibl = -1; cpus_per_grp > 0; ) {
> -			sibl = cpumask_next(sibl, siblmsk);
> -			if (sibl >= nr_cpu_ids)
> -				break;
> -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> -				continue;
> +		sibl = cpu + 1;

It doesn't have to 'cpu + 1', see below comment.

> +
> +		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> +			cpumask_clear_cpu(sibl, nmsk);
>  			cpumask_set_cpu(sibl, irqmsk);
> -			cpus_per_grp--;
> +			if (cpus_per_grp-- == 0)

			if (--cpus_per_grp == 0)

> +				return;

I think for_each_cpu_and() should work just fine, cause cpu has been cleared
from nmsk, so the change can be something like, then patch 1 isn't
necessary.


		for_each_cpu_and(sibl, siblmsk, nmsk) {
			cpumask_clear_cpu(sibl, nmsk);
  			cpumask_set_cpu(sibl, irqmsk);
			if (--cpus_per_grp == 0)
				return;
		}


Thanks,
Ming

