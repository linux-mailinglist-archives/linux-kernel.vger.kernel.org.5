Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6A80E834
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbjLLJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjLLJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB612C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702374620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v0YruFUcs7CpWDgdQcyd2R9bRZBZj+vBSAemz/y0HZ4=;
        b=Rd71J2g+3EQKThxDViRCD3zf/YI5uuuaHu4FcQ7xJdeUaQBl5vDwlcPy0QukzR8P8eDXoc
        yf23fydjZE3YACKMqnvT3Areanxo2dUFkJp+5MIbsI5NasF5gA1Z7CS2un8mMT8mo27mZi
        Hn0ALAGDVPxOxuMkihliCuURnXoEPPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-2RbOY2DAPlqYvVM5NNv1bQ-1; Tue, 12 Dec 2023 04:50:14 -0500
X-MC-Unique: 2RbOY2DAPlqYvVM5NNv1bQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78EC4185A78E;
        Tue, 12 Dec 2023 09:50:14 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F4160492BC6;
        Tue, 12 Dec 2023 09:50:09 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:50:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 3/7] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-ID: <ZXgszD9tIKY1tC9r@fedora>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-4-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212042108.682072-4-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 08:21:03PM -0800, Yury Norov wrote:
> Because nmsk and irqmsk are stable, extra atomicity is not required.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/group_cpus.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 10dead3ab0e0..7ac94664230f 100644
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
> @@ -33,8 +33,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  		sibl = cpu + 1;
>  
>  		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> -			cpumask_clear_cpu(sibl, nmsk);
> -			cpumask_set_cpu(sibl, irqmsk);
> +			__cpumask_clear_cpu(sibl, nmsk);
> +			__cpumask_set_cpu(sibl, irqmsk);

I think this kind of change should be avoided, here the code is
absolutely in slow path, and we care code cleanness and readability
much more than the saved cycle from non atomicity.


Thanks,
Ming

