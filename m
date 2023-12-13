Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DEB81071D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjLMA7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjLMA7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:59:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D9A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702429191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MeC6gTSAnBVmjkuuefA5b1OJABX4rRMIDZ5Rl/0OcO8=;
        b=A1SM3byhXnb3zddKasVUPKbeLZP/D/oWlUgvi79wSZvhIcBBlwtXGAoAtdTkIvwtPgj1U0
        OdA10u7fex+R8KcAYFztB9266XP5d3PeJksRNJvoKH81BkReB9vt7aRbb1SFRhOdVL8Rdh
        cz64j6qjsLQkwjF8O8e94U2cywK8EHQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-NWjnGBwQPs-OtgRdSs-Akw-1; Tue,
 12 Dec 2023 19:59:50 -0500
X-MC-Unique: NWjnGBwQPs-OtgRdSs-Akw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4DDB380662C;
        Wed, 13 Dec 2023 00:59:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD165492BE6;
        Wed, 13 Dec 2023 00:59:46 +0000 (UTC)
Date:   Wed, 13 Dec 2023 08:59:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 6/7] lib/group_cpus: drop unneeded cpumask_empty()
 call in __group_cpus_evenly()
Message-ID: <ZXkB/qozJo2Nm9iE@fedora>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-7-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212042108.682072-7-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 08:21:06PM -0800, Yury Norov wrote:
> The function is called twice. First time it's called with
> cpumask_present as a parameter, which can't be empty. Second time it's
> called with a mask created with cpumask_andnot(), which returns false if
> the result is an empty mask.
> 
> We can safely drop redundand cpumask_empty() call from the
> __group_cpus_evenly() and save few cycles.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/group_cpus.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index c7fcd04c87bf..664a56171a1b 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -252,9 +252,6 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>  	nodemask_t nodemsk = NODE_MASK_NONE;
>  	struct node_groups *node_groups;
>  
> -	if (cpumask_empty(cpu_mask))
> -		return 0;
> -
>  	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
>  
>  	/*
> @@ -394,9 +391,14 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  		curgrp = 0;
>  	else
>  		curgrp = nr_present;
> -	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
> -	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> -				  npresmsk, nmsk, masks);
> +
> +	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk))
> +		/* If npresmsk is not empty */
> +		ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> +					  npresmsk, nmsk, masks);
> +	else
> +		ret = 0;
> +
>  	if (ret >= 0)
>  		nr_others = ret;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

