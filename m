Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407337617EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjGYMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGYMDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:03:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E710D4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rj19k1Vm+sor8RHKIaaTyN5cpuhdwmNlFlHX6MThlJU=; b=NJaEqarAmxWfb7fTD3TOMqIgEJ
        HVBm/Mvv13s8gZSzbr85BbBjs4K4jyWqnnCi/JeSubb+peZ+MSJnAdEImZLfdM+uCgidjtlFlwSVi
        7ONWGFrMyLqP5eTsDVQmT2DJYTiSuu3B+dSxNLpYT8gra/cmu0k5idT2RegbvgIJwqKx6sMUQEDlG
        2SCK8Ky8egGiWGscZ2JGKw9+b1wM4dWmr/XBO/z/snxvS9zcUgeaw10lnVFBygvsr2KISOBHqymCS
        Ff+WMjn5qb/zucydLLzhJZRkU8FQYJhaXKayB0sbb4OtMZvCYTCz1TIU8zi9E6N6jJlJ70wrrEsgT
        lMEurEPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOGlN-0047ZH-11;
        Tue, 25 Jul 2023 12:03:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2AD8300155;
        Tue, 25 Jul 2023 14:03:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9F352612ABE5; Tue, 25 Jul 2023 14:03:36 +0200 (CEST)
Date:   Tue, 25 Jul 2023 14:03:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcuwait: Add might_sleep() annotations
Message-ID: <20230725120336.GG3765278@hirez.programming.kicks-ass.net>
References: <20230724160337.20851-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724160337.20851-1-dave@stgolabs.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:03:36AM -0700, Davidlohr Bueso wrote:
> ... as with regular waitqueues.

No immediate objection, but please, tell us more. What made you get up
this fine morning and write this patch?

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  include/linux/rcuwait.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
> index 27343424225c..c0fcac903d03 100644
> --- a/include/linux/rcuwait.h
> +++ b/include/linux/rcuwait.h
> @@ -74,7 +74,10 @@ extern void finish_rcuwait(struct rcuwait *w);
>  })
>  
>  #define rcuwait_wait_event(w, condition, state)				\
> -	___rcuwait_wait_event(w, condition, state, 0, schedule())
> +do {									\
> +	might_sleep();							\
> +	___rcuwait_wait_event(w, condition, state, 0, schedule());	\
> +} while (0)
>  
>  #define __rcuwait_wait_event_timeout(w, condition, state, timeout)	\
>  	___rcuwait_wait_event(w, ___wait_cond_timeout(condition),	\
> @@ -84,6 +87,7 @@ extern void finish_rcuwait(struct rcuwait *w);
>  #define rcuwait_wait_event_timeout(w, condition, state, timeout)	\
>  ({									\
>  	long __ret = timeout;						\
> +	might_sleep();							\
>  	if (!___wait_cond_timeout(condition))				\
>  		__ret = __rcuwait_wait_event_timeout(w, condition,	\
>  						     state, timeout);	\
> -- 
> 2.41.0
> 
