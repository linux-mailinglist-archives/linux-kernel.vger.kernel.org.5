Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901A4810747
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378093AbjLMBGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjLMBGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D10ACE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702429584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D0SnZLCy81+dYJzS4wut67vLKnCWkGca6Y+iC19IrjA=;
        b=DeH0wR79US59/2WBkbxR/aQNh08C3UzJ4YICFjcuMDuX+Q/uWoMn6nkCkAKjMozMoVqNWz
        Z7E2RUKVXiR5T9SRonvuCv+NiXgpMeoJg0nnO3Qv2fPX+YB/Jiwf6argBfviJ3rxosNkrh
        MGDGFKc1lmLm2oH/49B7vddIghL5C7s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75--M6I3TC7ONq7bLk6cP72TQ-1; Tue, 12 Dec 2023 20:06:20 -0500
X-MC-Unique: -M6I3TC7ONq7bLk6cP72TQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33A5E8489E4;
        Wed, 13 Dec 2023 01:06:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D49583C25;
        Wed, 13 Dec 2023 01:06:16 +0000 (UTC)
Date:   Wed, 13 Dec 2023 09:06:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 7/7] lib/group_cpus: simplify grp_spread_init_one()
 for more
Message-ID: <ZXkDhBqtLAg054ub@fedora>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-8-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212042108.682072-8-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

On Mon, Dec 11, 2023 at 08:21:07PM -0800, Yury Norov wrote:
> The outer and inner loops of grp_spread_init_one() do the same thing -
> move a bit from nmsk to irqmsk.
> 
> The inner loop iterates the sibling group, which includes the CPU picked
> by outer loop. And it means that we can drop the part that moves the bit
> in the outer loop.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/group_cpus.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 664a56171a1b..7aa7a6289355 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -18,14 +18,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  	int cpu, sibl;
>  
>  	for_each_cpu(cpu, nmsk) {
> -		__cpumask_clear_cpu(cpu, nmsk);
> -		__cpumask_set_cpu(cpu, irqmsk);
> -		if (cpus_per_grp-- == 0)
> -			return;
> -
> -		/* If the cpu has siblings, use them first */
>  		siblmsk = topology_sibling_cpumask(cpu);
> -		sibl = cpu + 1;
> +		sibl = cpu;
>  
>  		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
>  			__cpumask_clear_cpu(sibl, nmsk);

Correctness of the above change requires that 'cpu' has to be included
into topology_sibling_cpumask(cpu), however, not sure it is always true,
see the following comment in Documentation/arch/x86/topology.rst

`
  - topology_sibling_cpumask():

    The cpumask contains all online threads in the core to which a thread
    belongs.
`

Thanks, 
Ming

