Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E62757C58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGRM6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGRM6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:58:48 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0D6E4C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:58:48 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5636426c1b3so3572379eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689685127; x=1692277127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3kTN4YamSI+ko6dM/L7aHZSrCBexbIuSEJDZBtJUAU=;
        b=V+gPh2q0SUEyDUZvPYeclcaF/8fPibKR2Mh4HcvaG7m+e1W9m2jy6j86KjZKJqPyli
         Ex5mdJMaInMua4Pci1caiiBmH9NhSkantEJiqAe9/wrWVklSVmW1JyJRgMkRKd59QlVM
         Emtpvet9H93Uwl5XzgunsWYR+Xhp9Ts6EBKlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685127; x=1692277127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3kTN4YamSI+ko6dM/L7aHZSrCBexbIuSEJDZBtJUAU=;
        b=H/uIJCkvqGL7FhtmZwyBS31zgfYSlTtsdW9fPREyptLMWnFbwzsiaBSMpuvaQEE7hE
         BwHSd27iO7DM8zDsUvmiTowT1rqaw8RpJ9f/e48TOyeRzqTnfZ6dflU7ga4TcVNitwms
         vppaQsr+x+izcswjD3fsYNTrCzh+04mhhHyqFLavF1JdX3FEvfFfdT0N6r8nxGxh/H4X
         c38FyCTcSB4ajL/uU3SlRxDttfVK3SUz+jC5/rb8JGf81SqHnz83v+IAY+AYJb+ARCg2
         TKWiPGcc7ipcSo6I9M15qyfKqJZuoFdJFunHCIgiVIxQkMupkh1PSDYTwce7mKCM31ZP
         ZbBg==
X-Gm-Message-State: ABy/qLamd2IJOc/jWgB2lQbX1L4yxqIiLziuWxLfl2FF7oHps9Rize8X
        qWeTlqXlE7IYaXErYEaRAt4lKQ==
X-Google-Smtp-Source: APBJJlEeGKkl9XfQikXV6rHJcKhcxgaZv0WTquFZ9YpiKbVJxip385yT/48/pCqV0JXTJun8tsNziw==
X-Received: by 2002:aca:bd03:0:b0:3a4:1539:afff with SMTP id n3-20020acabd03000000b003a41539afffmr12850777oif.25.1689685127233;
        Tue, 18 Jul 2023 05:58:47 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a0cde08000000b00635efe2f65csm709096qvk.30.2023.07.18.05.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:58:46 -0700 (PDT)
Message-ID: <e34dd41a-b48c-578d-e45b-8c3b4a5df93a@joelfernandes.org>
Date:   Tue, 18 Jul 2023 08:58:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rcu 4/6] rcu: Mark __rcu_irq_enter_check_tick()
 ->rcu_urgent_qs load
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-4-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230717180317.1097590-4-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 14:03, Paul E. McKenney wrote:
> The rcu_request_urgent_qs_task() function does a cross-CPU store
> to ->rcu_urgent_qs, so this commit therefore marks the load in
> __rcu_irq_enter_check_tick() with READ_ONCE().
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/rcu/tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fae9b4e29c93..aec07f2ec638 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -632,7 +632,7 @@ void __rcu_irq_enter_check_tick(void)
>   	// prevents self-deadlock.  So we can safely recheck under the lock.
>   	// Note that the nohz_full state currently cannot change.
>   	raw_spin_lock_rcu_node(rdp->mynode);
> -	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> +	if (READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
>   		// A nohz_full CPU is in the kernel and RCU needs a
>   		// quiescent state.  Turn on the tick!
>   		WRITE_ONCE(rdp->rcu_forced_tick, 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>


thanks,

- Joel
