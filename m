Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1897D7F9869
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjK0EhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0Eg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:36:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D5123
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:37:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso1459649b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701059825; x=1701664625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrkhcZr7BZmlIlQDlknFFhzCf6BgW+GunyjUL2ZUQMY=;
        b=FEAl0udMvPsWqL7yBv3wR0yKGxtrJrCjP/ZHHgqCC8t3tNKmJN2/csmqv8Yc8ZrJ6M
         7zW8s0zMOMwL+3ZLaVBKP/9mFImCbQ2h7vqdlyrW2DB3UilKEX88SjW2cSCkdqa1OI9W
         J9FC4ObrGMuV9JfXpQbBsutwsNCYDjyE+SBfMqyPwVLuKp7e2FGt5Et4Wim69PuhmlYc
         vhqW7b3PZqvUgW5Ko4LguasawhR5O9NH8+EWk178rjkoRiF93dIXgS7oJJGdd0f1QHhY
         pjI6KKz9oQ1/BxcARjOCrYex66Xxw3Zj3OTjV1TW00REsPbfqaF/LxjvROe3u1a98BCm
         i2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701059825; x=1701664625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrkhcZr7BZmlIlQDlknFFhzCf6BgW+GunyjUL2ZUQMY=;
        b=HkjbwdXG5ewzFIXyBdc7LkrF6san5tJdsiPiAUWsOzPzhg3kofTzVCpbuDuGWviN77
         E1u5GMYqNh4SzUrbRlABusMJWmNdY8QSUWWxbqWF62gCLYiI+L+ESyiudmRoSTKgfAaz
         cXvdHHnwXso39PH7+Ony5Ai8mLK7PbyLkIBG9dfi/z3K53i+xh1iuH4RvLauBCg+djZZ
         P7mdHOVkFMY9CSvUJNd+axOcQewCJGnfHu8SZLrNKxOJB6RVSSjG2Ck0i0UYTQuWq3o4
         fLZFo0sZuILtuHwwFQKNEaqJotwJ2UfY6SsMRJ3Us4E5ABaCWHTJcBke7ear5ytwYTIw
         HOxg==
X-Gm-Message-State: AOJu0Yzca7oaq3nwpCF4ujIvmxURv8J066/mPbc+m77ZAb3bi7/Ymfc0
        y5oPTyNM0sFAtBxtjVlDfi4=
X-Google-Smtp-Source: AGHT+IHwesZsTaMAmxY5AjIARHXfR+Dyw7vU44Vm1eFKSxddz6zpVn7aLU/+DeyilY0G+gQPL8pCww==
X-Received: by 2002:a05:6a21:192:b0:18b:5b7e:6b9 with SMTP id le18-20020a056a21019200b0018b5b7e06b9mr16364839pzb.2.1701059824943;
        Sun, 26 Nov 2023 20:37:04 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:6f18:c2e2:c23c:9ba2])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b002802d264240sm6663134pjz.29.2023.11.26.20.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:37:04 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     ryan.roberts@arm.com
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, david@redhat.com, fengwei.yin@intel.com,
        hughd@google.com, itaru.kitayama@gmail.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, rientjes@google.com,
        shy828301@gmail.com, vbabka@suse.cz, wangkefeng.wang@huawei.com,
        willy@infradead.org, ying.huang@intel.com, yuzhao@google.com,
        ziy@nvidia.com
Subject: Re: [RESEND PATCH v7 02/10] mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
Date:   Mon, 27 Nov 2023 17:36:44 +1300
Message-Id: <20231127043644.8072-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122162950.3854897-3-ryan.roberts@arm.com>
References: <20231122162950.3854897-3-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  		unsigned long address)
>  {
> -	int nr;
> +	int nr = folio_nr_pages(folio);
> 
> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> +	VM_BUG_ON_VMA(address < vma->vm_start ||
> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>  	__folio_set_swapbacked(folio);
> +	__folio_set_anon(folio, vma, address, true);
> 
> -	if (likely(!folio_test_pmd_mappable(folio))) {
> +	if (likely(!folio_test_large(folio))) {
>  		/* increment count (starts at -1) */
>  		atomic_set(&folio->_mapcount, 0);
> -		nr = 1;
> +		SetPageAnonExclusive(&folio->page);
> +	} else if (!folio_test_pmd_mappable(folio)) {
> +		int i;
> +
> +		for (i = 0; i < nr; i++) {
> +			struct page *page = folio_page(folio, i);
> +
> +			/* increment count (starts at -1) */
> +			atomic_set(&page->_mapcount, 0);
> +			SetPageAnonExclusive(page);

Hi Ryan,

we are doing an entire mapping, right? what is the reason to
increase mapcount for each subpage? shouldn't we only increase
mapcount of subpage in either split or doublemap case?

in page_add_anon_rmap(), are we also increasing mapcount of
each subpage for fork() case where the entire large folio
is inheritted by child processes?

> +		}
> +
> +		atomic_set(&folio->_nr_pages_mapped, nr);
>  	} else {
>  		/* increment count (starts at -1) */
>  		atomic_set(&folio->_entire_mapcount, 0);
>  		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
> -		nr = folio_nr_pages(folio);
> +		SetPageAnonExclusive(&folio->page);
>  		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>  	}
> 
>  	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
> -	__folio_set_anon(folio, vma, address, true);
> -	SetPageAnonExclusive(&folio->page);
>  }

Thanks
Barry

