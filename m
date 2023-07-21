Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F3975D603
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGUUzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGUUzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:55:16 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DF330EA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:55:15 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7836272f36eso103167039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972915; x=1690577715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vwa1pffIAjGAHh+N52+iT2Ub/BHd89kMS2abs0dEss=;
        b=Xz0UaOjo2uZQZi3jQLHvHzSfOAFgxajfYa5m/KliK8+W0VvqTy7N5l3idKYAwoYYwf
         aI/XexGK5/+2RwlfpZJIbQO4Ov4AbiGk/u/L+I2wUMMTtvW+M1k6u4VpQN4ngoE01BQ6
         YhOKtxhn9bZBJeg9cciLtBqmUiCHrycFXkGuArk4Y8ew1nN7Ht05g5wAuVoor8osctqv
         txJokDoNT2TYIhDrtjt3MvaVL+fxiaynlDUYU67fY8SQi5EM5dDfrUlCFfNZhROi8E57
         kZwm03BMoPWRiADAm7ejKBTlthFb9O41yA4qqA3XzOrb0mpwYNSyNl/uG1PVvFIsw/nO
         nW/w==
X-Gm-Message-State: ABy/qLY6nu69reT9sCTfmj66h9jys2IVttCUgcTPTFLprB/5Bo5b20Gh
        IlaiwK5XQQPg6Nknhzm8GKQ=
X-Google-Smtp-Source: APBJJlGxgroo00JppSotZTG28fuUPsgirAKgpVF0HF0waF1axkvja3KxXfcYkzXP3f2zJ0kYhdGL8A==
X-Received: by 2002:a5d:9950:0:b0:785:fbe8:1da0 with SMTP id v16-20020a5d9950000000b00785fbe81da0mr1055579ios.15.1689972914935;
        Fri, 21 Jul 2023 13:55:14 -0700 (PDT)
Received: from snowbird ([2601:282:1800:1f50::d356])
        by smtp.gmail.com with ESMTPSA id h9-20020a02c4c9000000b0042b2e309f97sm1216479jaj.177.2023.07.21.13.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:55:14 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:55:12 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 1/3] mm/percpu.c: remove redundant check
Message-ID: <ZLrwsBbRIil6gm4i@snowbird>
References: <20230721131800.20003-1-bhe@redhat.com>
 <20230721131800.20003-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721131800.20003-2-bhe@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:17:58PM +0800, Baoquan He wrote:
> The conditional check "(ai->dyn_size < PERCPU_DYNAMIC_EARLY_SIZE) has
> covered the check '(!ai->dyn_size)'.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 28e07ede46f6..1480bf283d11 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2615,7 +2615,6 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  	PCPU_SETUP_BUG_ON(ai->unit_size < PCPU_MIN_UNIT_SIZE);
>  	PCPU_SETUP_BUG_ON(!IS_ALIGNED(ai->unit_size, PCPU_BITMAP_BLOCK_SIZE));
>  	PCPU_SETUP_BUG_ON(ai->dyn_size < PERCPU_DYNAMIC_EARLY_SIZE);
> -	PCPU_SETUP_BUG_ON(!ai->dyn_size);
>  	PCPU_SETUP_BUG_ON(!IS_ALIGNED(ai->reserved_size, PCPU_MIN_ALLOC_SIZE));
>  	PCPU_SETUP_BUG_ON(!(IS_ALIGNED(PCPU_BITMAP_BLOCK_SIZE, PAGE_SIZE) ||
>  			    IS_ALIGNED(PAGE_SIZE, PCPU_BITMAP_BLOCK_SIZE)));
> -- 
> 2.34.1
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
