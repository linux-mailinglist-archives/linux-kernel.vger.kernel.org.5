Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804FE75D621
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGUVDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGUVDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:03:04 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2EA1FD2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:03:03 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-78625caa702so100038039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689973383; x=1690578183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmvlwLqe/HyMXG8CYpAUMk+EWmV9FBll7iWhqk+njS0=;
        b=Zb15Kt5EZYqDvvhRZhvE+IwXyR1o+/82Vi1OhLBv/fblZY24NkJkOFlhFnbq+lBDRS
         TRfHLnbPRuVQhYFFRB5GQnFG5Xz/KSXoSWJwAlyay1ElOjqTkGb5GjnZmb2o6YbRmknv
         /D8+GEo3cUDxTCTASVD+VgtfuCpLGSEANNYKlRZ74iJskZ0nIZV7cRkGR8IuRQaytxyX
         P4winADvpxd2xX9fJObZE3M834EUJVwDTtWk0kaQq7k3pX9TQO/dGIJfcTKrruzTrXIN
         trv+ocq2rJEejux/j+3HWs73Qoz5PzSAHXqtXyHAveDyWAHnYDse7/MR9CjIqs+nWJZ0
         eDTg==
X-Gm-Message-State: ABy/qLbJ47Tm/FIzJqZp2cW7AQH8QFOJEorvuAh+3QrI4p78vWjEXaBj
        IZTj6j859tGyQF59fu2i9aZISvFGOXw=
X-Google-Smtp-Source: APBJJlHvY7wYCfxPaXkagBUxDljWytFJZ72GYd/mI39m8sOcqURPaMnPfIB9a7hJTLRbQsjWXpRx0A==
X-Received: by 2002:a6b:6d02:0:b0:783:5e93:1e7f with SMTP id a2-20020a6b6d02000000b007835e931e7fmr1072143iod.18.1689973382836;
        Fri, 21 Jul 2023 14:03:02 -0700 (PDT)
Received: from snowbird ([2601:282:1800:1f50::d356])
        by smtp.gmail.com with ESMTPSA id w22-20020a05660201d600b007836a9ca101sm1343263iot.22.2023.07.21.14.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 14:03:02 -0700 (PDT)
Date:   Fri, 21 Jul 2023 14:03:00 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 3/3] mm/percpu.c: print error message too if atomic alloc
 failed
Message-ID: <ZLryhIzyDUpEPUzT@snowbird>
References: <20230721131800.20003-1-bhe@redhat.com>
 <20230721131800.20003-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721131800.20003-4-bhe@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:18:00PM +0800, Baoquan He wrote:
> The variable 'err' is assgigned to an error message if atomic alloc
> failed, while it has no chance to be printed if is_atomic is true.
> 
> Here change to print error message too if atomic alloc failed, while
> avoid to call dump_stack() if that case.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index c25b058a46ad..74f75ef0ad58 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1890,13 +1890,15 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  fail:
>  	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
>  
> -	if (!is_atomic && do_warn && warn_limit) {
> +	if (do_warn && warn_limit) {
>  		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
>  			size, align, is_atomic, err);
> -		dump_stack();
> +		if (is_atomic)
> +			dump_stack();

This should be (!is_atomic) to preserve the current logic?

>  		if (!--warn_limit)
>  			pr_info("limit reached, disable warning\n");
>  	}
> +
>  	if (is_atomic) {
>  		/* see the flag handling in pcpu_balance_workfn() */
>  		pcpu_atomic_alloc_failed = true;
> -- 
> 2.34.1
> 

Thanks,
Dennis
