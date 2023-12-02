Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF9E801EA1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjLBVMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:12:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB207C8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:12:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-280cd4e6f47so606253a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701551568; x=1702156368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QzjFyHuu4z4km46Pkr8ZYovU1LpQ45VCf9QMZMCvCw=;
        b=XpaBOSuuQqB5cc8vmI/Bgx5YaIQ/tr5+gw58AxvMvAQgtMJIgCNAAEbBfgf4c91F3n
         ZtwaGRAo+fZ4CsOFzGJPjxK0uKJ+XBrPnyyvv0Pydb2ucm2cYkC12HPpwdBga18NqE1r
         gUSCvuoP7G/H01JqC91GUAA77934cuXXWRX6gnbuL376BvbCs/JSg0yOrq6yUeoFRvHV
         AtX7NcnYz4jEc/zXwS6x3mNo5mAub/2IlEVIF4+SY242ed/UlaWvalta/ZI8fANjyDKa
         2IzcAs2REbXjwwxnWCpXlnvgbQddHBqChJ6SxjGQrB5eruQRB07eegQkZux3WLiW8xca
         ia4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701551568; x=1702156368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QzjFyHuu4z4km46Pkr8ZYovU1LpQ45VCf9QMZMCvCw=;
        b=S/QqBVQBZolCREZ9QQOhGZcZ72bewVTlrBZFxVBf6WWupgwjLylxFSajpsoowTmTj0
         khXaBIvIts469AvaAfBprZW1GY8wp/degJhfi0rBtFtZJzwuyYCF7FJxvWl1HzoKZoIj
         yvqsp+5+A68Cr7oL4LkJxmckN4XDWLMkobabOe/RHj3Aa6YA3157S7LPd0EZHXKxY8r3
         nNqwqy0nF0yJlIKiwJt3UGd4zIuIMQyMJjx0s5aslaGsXYNSKyATF+xoL7BHjMhbQ2KY
         AN+cWp0XHm7cfvQtn9uZ45Bnac3CO7gGLJc54PETZc9QkLRk0hxD/8qBZe1VVp06iJx+
         /ZlA==
X-Gm-Message-State: AOJu0YzG1vRgSVF7EaGiWWVumC2sDgf/wGK3oGslWsZDN+RFkJ8RQNlu
        2Kswt3DwL8ty5RNv63jXPQ5hUkwTlNc=
X-Google-Smtp-Source: AGHT+IGD1Vyu0AzBEb0MZPfnNnBv4EIfVMZw3DbpQ3XIpK/dHj9Y6DxNPeFsPrIeyaxOW7njHJ2YDA==
X-Received: by 2002:a17:90a:ab8e:b0:285:bc38:b747 with SMTP id n14-20020a17090aab8e00b00285bc38b747mr8895157pjq.4.1701551568360;
        Sat, 02 Dec 2023 13:12:48 -0800 (PST)
Received: from sivslab-System-Product-Name ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id y24-20020a170902b49800b001cc31dcec49sm5567101plr.146.2023.12.02.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:12:47 -0800 (PST)
Date:   Sun, 3 Dec 2023 05:12:45 +0800
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/sort: Optimize number of calls to comparison function
Message-ID: <20231202211245.GA2632691@sivslab-System-Product-Name>
References: <20231202163717.687578-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202163717.687578-1-visitorckw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 12:37:17AM +0800, Kuan-Wei Chiu wrote:
> The current implementation continues the loop when the comparison
> function returns a non-negative value, which includes the case when it
> returns 0. However, in scenarios where the comparison function returns
> 0, further comparisons are unnecessary. By making this adjustment, we
> can potentially reduce the number of comparisons by approximately 50%
> in extreme cases where all elements in the array are equal, and the
> array size is sufficiently large.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  lib/sort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/sort.c b/lib/sort.c
> index b399bf10d675..1e98a62bb2f3 100644
> --- a/lib/sort.c
> +++ b/lib/sort.c
> @@ -267,7 +267,7 @@ void sort_r(void *base, size_t num, size_t size,
>  			b = c;
>  
>  		/* Now backtrack from "b" to the correct location for "a" */
> -		while (b != a && do_cmp(base + a, base + b, cmp_func, priv) >= 0)
> +		while (b != a && do_cmp(base + a, base + b, cmp_func, priv) > 0)
>  			b = parent(b, lsbit, size);
>  		c = b;			/* Where "a" belongs */
>  		while (b != a) {	/* Shift it into place */
> -- 
> 2.25.1
>

While the patch decreases the number of comparisons, it simultaneously
leads to an increase in the number of swaps. As a result, the overall
performance improvement may not be guaranteed.

Therefore, I believe it would be more prudent to drop this patch.
I apologize for any disruption caused on the mailing list.

Best regards,
Kuan-Wei Chiu
