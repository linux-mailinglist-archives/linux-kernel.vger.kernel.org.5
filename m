Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD77A1B38
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjIOJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjIOJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:51:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D032717
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:47:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f71b25a99so1800606f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771232; x=1695376032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+nJAJwe0UDJzttNbv8oHth+6FLlunmo95hq60vDU30=;
        b=hTzslHoi3agOcMv0SoBObFS6gtuBTy3NlUXoY95bmnilsZPwGchLH84cmEy+FyoLoh
         mUON6Ib10dIbTm96kJFjU6qVo3lYpIm0o3mLD3vQ1dF3hJDAPkVh3jB2fR+KoNn8mdru
         fpVoSoqdCe0JmH0VfZ3kMtyT0zNjCqt2TxISy98cZKyfYmKRDiMKAgtLluorzxKnL9/f
         A21gR/iWi3RHJDizn7fXpiACQhOxYxwYx1vjflX7lDFmx0PJxVr8Z93dXm1nNcFA5khZ
         6HNRfJRRLuo1Qzzto5ptqVBfp/OLHH8YRQl9jxaF4crV+d2Kqzgtfugqh3rZ9i9P1St/
         zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771232; x=1695376032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+nJAJwe0UDJzttNbv8oHth+6FLlunmo95hq60vDU30=;
        b=k/6u2fpbsZmFujD/iBrQ77O9LX3Cfv6pYiH1q1InsgfRctHom+1dOAlZd14Z1uNW9R
         Lz0PVwBcqPHX20/41Pj2gd87omlnpWtHfWCKkgtXb1C+h8CgDfgLMYIKXJAvCvXqhPTi
         vHwRL5PnZb2w0xCYy31OhQnGdur4KRZD2n0pbQuR+YKJlwgSO1a2J5QEZWODJ+M0aIQh
         W4JtKLOkqQLBNNCbtUkIlPnNe38BnS7cgOLKEOHSH6xunwvyroIIEfukK+ci1fXeAa8z
         PBREeHNwWIng/mZTS1V2du6P0gSwBSnlhNn/SxP9q6l6JRJOg3iJ+vJmKe98lF9FVpKE
         02iQ==
X-Gm-Message-State: AOJu0Yxn922CrWKN0AkFj7c7OfAvVBw2RhCMtbp0A+1DZ4wzghZGJDet
        Nxht1XCHIG0q4dJY+ThgZyfXzIEb/38=
X-Google-Smtp-Source: AGHT+IH74A4AWcuVCL4mcKaZhu79A3E44kI+RNGtRyN63BHIQ32/0QKB1k5KSh0Ejwwahc8rpl+8ZA==
X-Received: by 2002:adf:f5ce:0:b0:31d:c3d2:4300 with SMTP id k14-20020adff5ce000000b0031dc3d24300mr744504wrp.71.1694771232069;
        Fri, 15 Sep 2023 02:47:12 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b0031fbbe347e1sm3975128wrv.65.2023.09.15.02.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:47:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 11:47:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/percpu: Use raw_cpu_try_cmpxchg in
 preempt_count_set
Message-ID: <ZQQoHWkJ5or/K7UH@gmail.com>
References: <20230830151623.3900-1-ubizjak@gmail.com>
 <20230830151623.3900-2-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830151623.3900-2-ubizjak@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Use raw_cpu_try_cmpxchg instead of raw_cpu_cmpxchg (*ptr, old, new) == old.
> x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
> compare after cmpxchg (and related move instruction in front of cmpxchg).
> 
> Also, raw_cpu_try_cmpxchg implicitly assigns old *ptr value to "old" when
> cmpxchg fails. There is no need to re-read the value in the loop.
> 
> No functional change intended.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/include/asm/preempt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> index 2d13f25b1bd8..4527e1430c6d 100644
> --- a/arch/x86/include/asm/preempt.h
> +++ b/arch/x86/include/asm/preempt.h
> @@ -31,11 +31,11 @@ static __always_inline void preempt_count_set(int pc)
>  {
>  	int old, new;
>  
> +	old = raw_cpu_read_4(pcpu_hot.preempt_count);
>  	do {
> -		old = raw_cpu_read_4(pcpu_hot.preempt_count);
>  		new = (old & PREEMPT_NEED_RESCHED) |
>  			(pc & ~PREEMPT_NEED_RESCHED);
> -	} while (raw_cpu_cmpxchg_4(pcpu_hot.preempt_count, old, new) != old);
> +	} while (!raw_cpu_try_cmpxchg_4(pcpu_hot.preempt_count, &old, new));

It would be really nice to have a before/after comparison of generated 
assembly code in the changelog, to demonstrate the effectiveness of this 
optimization.

Thanks,

	Ingo
