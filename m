Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4193C7F3FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjKVIH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjKVIHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:07:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA33110CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700640408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTL9eS606aR4jOsPXUpex7owGMXk2Et9Dz0AzsPRhrM=;
        b=dPqcJxBK8wfF0Ab39Nq99OhcWMkpbooCKOShxE37teHU5ZfIsuTkC7s0ww9CkihSJf45lH
        SfkSdwTr0exDICPGnrAP9qulmoopAwiVV2aQzwj1DDwfsElxalla1f4PMZIH+jGg6SEqM9
        MQ2rEu1VWf0JcgQtycjPbAe23NXj/5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-RLq--aGvM8SKDDM51CwVDA-1; Wed, 22 Nov 2023 03:06:47 -0500
X-MC-Unique: RLq--aGvM8SKDDM51CwVDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63FCF185A780;
        Wed, 22 Nov 2023 08:06:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 531AA36E2;
        Wed, 22 Nov 2023 08:06:42 +0000 (UTC)
Date:   Wed, 22 Nov 2023 16:06:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec: Use atomic_try_cmpxchg in crash_kexec
Message-ID: <ZV22j+C+D7ZnKzqD@MiWiFi-R3L-srv>
References: <20231114161228.108516-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114161228.108516-1-ubizjak@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 at 05:12pm, Uros Bizjak wrote:
> Use atomic_try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> crash_kexec().  x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg.
> 
> No functional change intended.

And code is simplified a little bit, so looks good to me,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  kernel/kexec_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..bc4c096ab1f3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1063,9 +1063,10 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>  	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
>  	 * may stop each other.  To exclude them, we use panic_cpu here too.
>  	 */
> +	old_cpu = PANIC_CPU_INVALID;
>  	this_cpu = raw_smp_processor_id();
> -	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
> -	if (old_cpu == PANIC_CPU_INVALID) {
> +
> +	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
>  		/* This is the 1st CPU which comes here, so go ahead. */
>  		__crash_kexec(regs);
>  
> -- 
> 2.41.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

