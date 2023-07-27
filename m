Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25133766021
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjG0XIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0XIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:08:14 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAC13D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:08:13 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-55fcc15e109so859538a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690499293; x=1691104093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBYOBoJLYiNWyPBZ8JtjEPNaBvs8n9DfL50KMt5h7Ws=;
        b=JTCMpVG2JLtBJ2PJlkB0uJJfdraZWPgYfQaemem2ASYYMJ0om7GOwArZu645thBTQP
         XibjETXWbWklyjkABoAZAl+bSde67lwHUAzD/Lf1QedIy/wT7g31EAXGPRgIy7JA/M2K
         SUdl6Y1nJj7wZQotOT9m3SyTbe8+wd5Paf4vR163Tcq1bU90eBydoSqfwygz3x8Y9TDy
         0vdndN8MKV4FN5Z/Ldz7o99B+mDRZuY34uTsHtHk9pLfph/c6FQN+UKq4VAooIkyq8V9
         A0M0nl4Tku401D9SDQMPCg0pwoYn6uQzluVglVTEowVEfUEVuR3VDxIXxPLHFDD6zWO8
         k6nw==
X-Gm-Message-State: ABy/qLZsn3fs1DzJW4xeSa6GS7+eHtYkH2g3ZMlw2kjmlLBNjKC4ffs9
        ipVKWwdfkJpvwR8py8bR9w0XLBNGIPI4Jg==
X-Google-Smtp-Source: APBJJlGz/uqkDGdyOYbooK4qi3urMgjXZdj674zcDvx65lAKgWJKRtnlfPgUlQsBJq29niDw8iMIwQ==
X-Received: by 2002:a17:90a:bb12:b0:267:faba:705 with SMTP id u18-20020a17090abb1200b00267faba0705mr8961pjr.10.1690499292643;
        Thu, 27 Jul 2023 16:08:12 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a4d8800b0026822cb85casm1631801pjh.18.2023.07.27.16.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 16:08:12 -0700 (PDT)
Date:   Thu, 27 Jul 2023 16:08:07 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH 1/3] mm/percpu: Remove some local variables in
 pcpu_populate_pte
Message-ID: <ZML414eLkT78bO5G@snowbird>
References: <20230712031622.1888321-1-maobibo@loongson.cn>
 <20230712031622.1888321-2-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712031622.1888321-2-maobibo@loongson.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 12, 2023 at 11:16:20AM +0800, Bibo Mao wrote:
> In function pcpu_populate_pte there are already variable defined,
> it can be reused for later use, here remove duplicated local
> variables.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  mm/percpu.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 28e07ede46f6..85e3f9b2a61f 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -3189,32 +3189,26 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
>  	pmd_t *pmd;
>  
>  	if (pgd_none(*pgd)) {
> -		p4d_t *new;
> -
> -		new = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
> -		if (!new)
> +		p4d = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
> +		if (!p4d)
>  			goto err_alloc;
> -		pgd_populate(&init_mm, pgd, new);
> +		pgd_populate(&init_mm, pgd, p4d);
>  	}
>  
>  	p4d = p4d_offset(pgd, addr);
>  	if (p4d_none(*p4d)) {
> -		pud_t *new;
> -
> -		new = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
> -		if (!new)
> +		pud = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
> +		if (!pud)
>  			goto err_alloc;
> -		p4d_populate(&init_mm, p4d, new);
> +		p4d_populate(&init_mm, p4d, pud);
>  	}
>  
>  	pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud)) {
> -		pmd_t *new;
> -
> -		new = memblock_alloc(PMD_TABLE_SIZE, PMD_TABLE_SIZE);
> -		if (!new)
> +		pmd = memblock_alloc(PMD_TABLE_SIZE, PMD_TABLE_SIZE);
> +		if (!pmd)
>  			goto err_alloc;
> -		pud_populate(&init_mm, pud, new);
> +		pud_populate(&init_mm, pud, pmd);
>  	}
>  
>  	pmd = pmd_offset(pud, addr);
> -- 
> 2.27.0
> 

I've pulled this, but the other 2 are part of loongarch and should be
reviewed and pulled by those maintainers.

Thanks,
Dennis
