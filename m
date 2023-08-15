Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4271077CBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjHOL3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbjHOL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:28:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E29E10C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:28:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso6886549a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1692098919; x=1692703719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WYCQpbHTxDID5AoQl8ERGV/5CWLvmCYGEczLSZ5Qp6E=;
        b=TYPHRYJjQHAOvggWM95vLhu5d8WfQrhbuSwMl5PhQj5NLnT+9Er6Ihe5G9YnSyyA0t
         n9gu8nufvM/jTq8xw0EiNOkPJxVbr4nPirJ9fnuj7UCR3NcVEvlx8KUNv7qFl15HICLr
         85dR5Ic46GGRJQEwlUjrOZB22FXbytEmpHv7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692098919; x=1692703719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYCQpbHTxDID5AoQl8ERGV/5CWLvmCYGEczLSZ5Qp6E=;
        b=KDwkVvJs6bGXhxzfTQVBbArbUyk+6uqVktu5uEizzYhAhgKM8aUZWl0zl6kE+msp7T
         4QJlk6FhrdCBpcgIigz7OvtGJWaB1ingi52BItVIi9fTemDjPMZFVSx0mc7ncx2ULFlN
         y31NX2sUHBxnQvXks3fXsWAYIas09+Sxck/CYthRPazBprLcoHALTU0l//yTm+FvfygF
         dhgWkgDiazE3E+p9HrcAdKrsJhfSmX4STtrD6TWy2fDQFEJ+MrHnfs9BED533Nlezlbr
         JoFdssupEmFVms9zoWmFW2WMszf+LDcWHPC6nDpjnvePsMAjuTA37bV0Cy8tljgCVApC
         5t8w==
X-Gm-Message-State: AOJu0YzVWywzuLGPgFhXSLCACSEIcTgDjXgndTk71M0BmRtkqTJu858k
        jKh+wApFg/42Ri8UCN6q3S0b0w==
X-Google-Smtp-Source: AGHT+IFT43TYVyFLWitPfOBZHoMo4oudpQRZZpWzD9LJl8NmL1FUMQlIEOuNhNt+vsNv0SC53ewTSA==
X-Received: by 2002:a50:fc0d:0:b0:525:6588:b624 with SMTP id i13-20020a50fc0d000000b005256588b624mr4346289edr.37.1692098919512;
        Tue, 15 Aug 2023 04:28:39 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7d40b000000b00525683f9b2fsm2242941edq.5.2023.08.15.04.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 04:28:38 -0700 (PDT)
Message-ID: <fcc8a158-f6e4-8963-782f-ba04b47350b8@rasmusvillemoes.dk>
Date:   Tue, 15 Aug 2023 13:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: cleanup: Make no_free_ptr() __must_check
Content-Language: en-US, da
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 12.52, Peter Zijlstra wrote:
> 
> recent discussion brought about the realization that it makes sense for
> no_free_ptr() to have __must_check semantics in order to avoid leaking
> the resource.
> 

> +static inline __must_check void * __no_free_ptr(void **pp)
> +{ void *p = *pp; *pp = NULL; return p; }
> +
>  #define no_free_ptr(p) \
> -	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
> +	(({ void * __maybe_unused ___t = (p); }), \
> +	 ((typeof(p))__no_free_ptr((void **)&(p))))

So this does seem to work as advertised, but it could perhaps use some
comments. Because at first I read this as one big statement expression,
and I had this memory of a __must_check function call being the last
expression in such had no effect at all [1]. But this is actually a
comma expression.

Also, isn't it more complicated than necessary? Can we get rid of the
inner stmt expr and tmp var by just making it

  ((void) (p), ((typeof(p))__no_free_ptr((void **)&(p)))

which is more or less the whole reason comma expressions is a thing.

Rasmus

[1]
https://lore.kernel.org/lkml/6d190601-68f1-c086-97ac-2ee1c08f5a34@rasmusvillemoes.dk/
