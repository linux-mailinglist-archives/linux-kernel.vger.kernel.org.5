Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9666D810712
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378059AbjLMA43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjLMA41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD3CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702428992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GaNuNCakBQBQrzCKcC0GSD8P31f5TqLSevRyrBQw0D0=;
        b=cXCzgTVJu6bXTirvPDqxf3zHFlTdtSLpVZLt0Fw+R3P98tkYVjrPJq+q4QXEzliXsu5iel
        UYg4NhgaUiuavPd1Hk9kt3nI9bFhZQrsmjd5vclRYYJ3QL5nA355G7xNIHCzTl4IaPpKmb
        1Ac3dc0qYlmFDO0tXpQzxz6PprLJPwA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-rxSLypz5MPGg2IXSVqwzzg-1; Tue,
 12 Dec 2023 19:56:25 -0500
X-MC-Unique: rxSLypz5MPGg2IXSVqwzzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63B93386A0A6;
        Wed, 13 Dec 2023 00:56:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 214C42166B31;
        Wed, 13 Dec 2023 00:56:21 +0000 (UTC)
Date:   Wed, 13 Dec 2023 08:56:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 5/7] lib/cgroup_cpus: don't zero cpumasks in
 group_cpus_evenly() on allocation
Message-ID: <ZXkBMnWQK3az30iF@fedora>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212042108.682072-6-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

On Mon, Dec 11, 2023 at 08:21:05PM -0800, Yury Norov wrote:
> nmsk and npresmsk are both allocated with zalloc_cpumask_var(), but they
> are initialized by copying later in the code, and so may be allocated
> uninitialized.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/group_cpus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index cded3c8ea63b..c7fcd04c87bf 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -347,10 +347,10 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	int ret = -ENOMEM;
>  	struct cpumask *masks = NULL;
>  
> -	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
> +	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
>  		return NULL;

`nmsk` is actually used by __group_cpus_evenly() only, and it should be
local variable of __group_cpus_evenly(), can you move its allocation into
__group_cpus_evenly()?

>  
> -	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
> +	if (!alloc_cpumask_var(&npresmsk, GFP_KERNEL))
>  		goto fail_nmsk;

The above one looks fine, especially `npresmsk` is initialized in
group_cpus_evenly() explicitly.


Thanks,
Ming

