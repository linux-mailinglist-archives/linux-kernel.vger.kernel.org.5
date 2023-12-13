Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A40810B68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjLMHVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjLMHVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:21:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75EAD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:21:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso788030066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702452116; x=1703056916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBgfcgQyAM0ZH2e9t97pZtF0A7py8/HaZt62MojergQ=;
        b=arbT6q5vrNDXBX9LrY4NiSU0AR6ddqHb4CSe659wptvRD8FN0gjGe/ESmKs7A2+pE3
         vTsaCfQyvU99aK77eV9owenEZmXYiOHuDwlzxkurYiLeWkxwne/yW+zecc6GN55Rb417
         /QbW+Xv0EUyzqWkGO/DSDvs+y1siOiIuMbOaU38mKJN9Y/1TPvqUsNWxXvOI41hDVt0G
         SusO1m1/DT1CK5o/SEfis58gSK5/jq9daikM8WdAxbIV9/mmIwIBTBmT3PyJ84URrxVl
         MGVizE0UxI5ba9+OfYnSFAU3Vv24pfl0fYAgCcrmHyAYRN/IOtwaKKob4WfnZ+KEJh7E
         s8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702452116; x=1703056916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBgfcgQyAM0ZH2e9t97pZtF0A7py8/HaZt62MojergQ=;
        b=RgHh1/cU73AgJMTsMYxm3DqkA01f/wK8PzPa2ZXjGRUP7SB+HSMUHvaIRvXSjyQwPS
         QcTHvQguVkZdo1zMXA021gm5Q3lmx4OwlLn7oHQxoC9EJH6iXYx3Z39y85JJ2fITXh6A
         d1QwDBEQvaj7LAx054K7ZNm6r1s2b4kJOXLYZpaQdFEAYeXGTFffLBnce8DTHrN5iVaE
         Fka1geVKD23LbxuUn+feaUKKnKv0XznWqVEeatOZY4RaaN50Fn8OWO03dwZS2cAoAM/F
         knBUNrb/y4aTabV71BXICpOEw8N+1cl34gNFKvKLYFaz4/iSdENdqRxNj3drFqnW5qeg
         eY9g==
X-Gm-Message-State: AOJu0Yxh1OgKN8lBwr7Y30M11iLkqRRuWOSu6jIuH72oBCZWm7nGdiy8
        +Avgl8gGeyKB4YSsq8cNwzW84g==
X-Google-Smtp-Source: AGHT+IH1OjwtFoJO2AZU9jEj+yASotY0eU0/XYtVgOtVA7CV5IX+jiPRAVK4pDGYJ0jZ4AjQCvHHPg==
X-Received: by 2002:a17:906:1359:b0:a04:a274:2a0a with SMTP id x25-20020a170906135900b00a04a2742a0amr4337206ejb.73.1702452116628;
        Tue, 12 Dec 2023 23:21:56 -0800 (PST)
Received: from localhost (h3220.n1.ips.mtn.co.ug. [41.210.178.32])
        by smtp.gmail.com with ESMTPSA id si10-20020a170906ceca00b00a1e377ea789sm7187848ejb.203.2023.12.12.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 23:21:56 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:21:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Message-ID: <cb1fe352-ca47-4c3b-ab51-ecf51a83ce50@moroto.mountain>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-5-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207161211.2374093-5-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:12:05PM +0000, Ryan Roberts wrote:
> @@ -4176,10 +4260,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	/* Allocate our own private page. */
>  	if (unlikely(anon_vma_prepare(vma)))
>  		goto oom;
> -	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +	folio = alloc_anon_folio(vmf);
> +	if (IS_ERR(folio))
> +		return 0;
>  	if (!folio)
>  		goto oom;

Returning zero is weird.  I think it should be a vm_fault_t code.

This mixing of error pointers and NULL is going to cause problems.
Normally when we have a mix of error pointers and NULL then the NULL is
not an error but instead means that the feature has been deliberately
turned off.  I'm unable to figure out what the meaning is here.

It should return one or the other, or if it's a mix then add a giant
comment explaining what they mean.

regards,
dan carpenter

>  
> +	nr_pages = folio_nr_pages(folio);
> +	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
> +
>  	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>  		goto oom_free_page;
>  	folio_throttle_swaprate(folio, GFP_KERNEL);

