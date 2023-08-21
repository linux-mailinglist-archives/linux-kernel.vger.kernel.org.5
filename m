Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6787782FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjHURz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjHURz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:55:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E9A110
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:55:55 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7921b70c1a5so74009639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692640555; x=1693245355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4LXp8BI/ZNzwYn+mG+5eDjxBLnJtrOm6ePBhlGaTD0=;
        b=Hu5+LaITbogxcRInB4RTgTaW3RfvrI2HKW10oGE8mh0mSlv7LxmfUCrLdlqgacejnZ
         TUVELCwKBVZSWN9+E+g5JxtL4R7ZNAlgeUEkR3MX9DAA2jYNiZ8xaMUZggkq3YsfTEoq
         +CqfXULnVABxeoBByjL1ExpK8RfBBpgJh09gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640555; x=1693245355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4LXp8BI/ZNzwYn+mG+5eDjxBLnJtrOm6ePBhlGaTD0=;
        b=ed4ew6eyVqTcA0w+OAuO13xO/rM7RLKYRdO6r+MH9E1mZ6rjLzjm7h9vy83uMhEIV7
         0szvQlyLzeeZRTOlBVsFUwssWaRTnP9vk5Z8pY3DR32Yf7U5NWY8U66XKTsRDyMQ8ikh
         4nWnC/4D+sG8MBX71ji4nmWEqLfR9KIVB4H1TxGubUKDiOxXZ1M1yPFpBPE8W+esD3hN
         YEY5dlKM+o0zdRhZGenW/X2P+wLiD1uFzeW7k2cgcqa2lcpR0NQZhuSGh5rtsbS/PZjM
         ffG9uz8bZIPxs6UYtSoz1bDxY14nvSQ9ssfTpsq5s2gu5Os7C9vwfmkovoGQiaSRfqg/
         cUNw==
X-Gm-Message-State: AOJu0YzNMSc9oBYsUDd2btcxKN/VcR4jYHeEhZQ1+OBfDSX8WWpPvMdo
        aQv/cOgo5N8dJtHOEWRrDtzXZA==
X-Google-Smtp-Source: AGHT+IF7TTnToC23XlxUnS7LX48Lh/k0kd/vsHG2ZzfbWw891Kpv0bPaK8uV//GK7RZHZd+Hp9T3WA==
X-Received: by 2002:a5d:9acc:0:b0:790:fa58:69d2 with SMTP id x12-20020a5d9acc000000b00790fa5869d2mr8598705ion.20.1692640555286;
        Mon, 21 Aug 2023 10:55:55 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q23-20020a02c8d7000000b0042baffe832fsm2519018jao.101.2023.08.21.10.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:55:54 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:55:54 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Tong Tiangen <tongtiangen@huawei.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] sched: Assert for_each_thread() is properly locked
Message-ID: <20230821175554.GA595469@google.com>
References: <20230821134428.2504912-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821134428.2504912-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:44:28PM +0100, Matthew Wilcox (Oracle) wrote:
> list_for_each_entry_rcu() takes an optional fourth argument which
> allows RCU to assert that the correct lock is held.  Several callers
> of for_each_thread() rely on their caller to be holding the appropriate
> lock, so this is a useful assertion to include.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  include/linux/sched/signal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 669e8cff40c7..f1eae7f53be9 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -659,7 +659,8 @@ extern bool current_is_single_threaded(void);
>  	while ((t = next_thread(t)) != g)
>  
>  #define __for_each_thread(signal, t)	\
> -	list_for_each_entry_rcu(t, &(signal)->thread_head, thread_node)
> +	list_for_each_entry_rcu(t, &(signal)->thread_head, thread_node, \
> +		lockdep_is_held(&tasklist_lock))
>  
>  #define for_each_thread(p, t)		\
>  	__for_each_thread((p)->signal, t)
> -- 
> 2.40.1
> 
