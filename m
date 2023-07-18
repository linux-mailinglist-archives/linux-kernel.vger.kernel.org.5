Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B91757E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGRNt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjGRNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:49:56 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43CC8F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:49:53 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-78f208ebf29so1754605241.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689688193; x=1692280193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLZqFggSUuStcMw0mVYbM+cEYMUT1NJgSOLb0Az+8XI=;
        b=QCX/okn26ya5O4zr1LIYlzD2HqGfZGipyYBUkU7wvdtKuhbrj3Mal+7eat0ilcDFqT
         ihQgNdqZhsKlM4lR2x/lGM4p0FWPGUZLXox5AeSCAZ5d8Bf/E12W3/WiaCDQKdwxVNbx
         NiRlBTzNkNgkws++Y6naKLf1qI5pO9hyvWmnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689688193; x=1692280193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLZqFggSUuStcMw0mVYbM+cEYMUT1NJgSOLb0Az+8XI=;
        b=bxCxjFlgvjypckdoKOF72K1CkjwoC8crWEs2Xn7MchjMAzVNDPYRYld86MAMm06mba
         DDIYLLNqXZAcw0+uvch3D+yrGRACrUjO9f3AoC3k2RQPXh66wiIsponKY/U0yPj0jnvR
         +JyQc9U2HyfNymBCnVW7cpwjKepn6CKSFQbauRMr3Ca7G7nCMqLs3rWPtmZKALhx5BUQ
         S7dxeGpJsDhrGYNy9f2mIpT5I/loUmfFpwQaP/+G3KX6QD52fjuN3Tsg4Bs9eyBH8snr
         gUBjRjxoOAm+2StMrnMmarf3HOuU8zcP3mSxGfrPGfNPxBkujUjlhdVvFVyrHF4N35Ob
         D5JA==
X-Gm-Message-State: ABy/qLYAb7GC7AnVk9mvVO/4bqUDhCdzBmg8FjzWSm3WnV5MwMruYSNL
        j8dgguUwGH+N5iQ7pVojx+hktQ==
X-Google-Smtp-Source: APBJJlHo4OG6URNTZzB6Ts26a+xNNkBkAMRIm7XGbSuoUWaUYYEcq93VfAfBfXmb3ArqCsNZohTWsg==
X-Received: by 2002:a67:be02:0:b0:445:bd3:5b3a with SMTP id x2-20020a67be02000000b004450bd35b3amr6633464vsq.4.1689688192857;
        Tue, 18 Jul 2023 06:49:52 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id f1-20020a0ccc81000000b0062df95d7ef6sm720149qvl.115.2023.07.18.06.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:49:52 -0700 (PDT)
Message-ID: <9651c3b4-0791-5cd7-567f-f65d28bc8fae@joelfernandes.org>
Date:   Tue, 18 Jul 2023 09:49:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rcu 6/6] rcu: Use WRITE_ONCE() for assignments to ->next
 for rculist_nulls
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Alan Huang <mmpgouride@gmail.com>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-6-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230717180317.1097590-6-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 14:03, Paul E. McKenney wrote:
> From: Alan Huang <mmpgouride@gmail.com>
> 
> When the objects managed by rculist_nulls are allocated with
> SLAB_TYPESAFE_BY_RCU, old readers may still hold references to an object
> even though it is just now being added, which means the modification of
> ->next is visible to readers.  This patch therefore uses WRITE_ONCE()
> for assignments to ->next.
> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Did we ever conclude that the READ_ONCE() counterparts were not needed? ;-)

But incremental progress and all, so this LGTM:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

  - Joel


> ---
>   include/linux/rculist_nulls.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index ba4c00dd8005..89186c499dd4 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -101,7 +101,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
>   {
>   	struct hlist_nulls_node *first = h->first;
>   
> -	n->next = first;
> +	WRITE_ONCE(n->next, first);
>   	WRITE_ONCE(n->pprev, &h->first);
>   	rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
>   	if (!is_a_nulls(first))
> @@ -137,7 +137,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>   		last = i;
>   
>   	if (last) {
> -		n->next = last->next;
> +		WRITE_ONCE(n->next, last->next);
>   		n->pprev = &last->next;
>   		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>   	} else {

