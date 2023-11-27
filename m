Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2210E7F9BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjK0I1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjK0I12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:27:28 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C01124
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:27:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbe716b511so2656585b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701073655; x=1701678455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12pAzWJJAL9CEsKClU9orc2LqYiIa3VtbG+bAji6D0k=;
        b=aVRClv5YQGMpAc9v/PFe07JR9PZIi+F0irSUcWZ7UXvIbgPzNL3pjAwEVtfw0n7Z74
         /QD8Rq/50Y/L5v9Ue0aUuo3fouIH/3GeAWIp6oXBLDBzgl1SPRr17BivYzh4onwciADd
         76EZJmBEMlpXWtYme7wilCvtI+tO7Xsj6tAg9y2v9oKh3/ygzspH+9e2nulm9tTkAp9a
         5DNyFDfcueaj6RB6FeVhQS74KJlmEPYe+XsjWl/B0YSxmk2clcI7SEi4YTy0rvjCqQOB
         ICV0aixieizI4vP4XE2Ma2su7ttYJIm/DZv9sem/CVNn+DsG4kQ9BsQJ0UdrmSrojW/J
         a+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073655; x=1701678455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12pAzWJJAL9CEsKClU9orc2LqYiIa3VtbG+bAji6D0k=;
        b=TKnzE0aILeQGbzWevDRpVVVDs41uahs4heOsEPUQgeAooNflHgP0ksdZAZ+CZg71Kp
         DBbDWeZWxLl8Oi90sYjUn1iu0/UpQcEXIz2PV7+oUYyy/DfB4mvxzAgPQ5QCJiQ4Jfp9
         Db2XfQyd4J2imST/FSrSzy+fkKjA1o5Z+JU2md2hy8Gh//jJfXzP7a1GS/rwfD2aVaS3
         XYjkzCvgIBxEZVGUqB85ERzYXEVM6Bt14Iebqq6hJKXQWrBzWWnYDPF4+5kw/Xc5AUMu
         z9gdStit1whZO41+Pi51hSb3biWrHt639l3UGAnVqwkby+2alc3ytWnDRJtOuroI0VvO
         emTg==
X-Gm-Message-State: AOJu0YxjqXT+orY3uq9RLdt/lEvVB+F16T7O472IXu6g/mbPp/tDjzGR
        eUf77vD/7fTokD1dUQqsk+Q=
X-Google-Smtp-Source: AGHT+IHnl4BHxZBeCv4Dm3wpOycnDFVQjCWcpTbEYovka2o7m2bvyuyxSJg80qjK9+X/ZTtZ5Qr8+g==
X-Received: by 2002:a05:6a00:130f:b0:6cb:a60c:1d with SMTP id j15-20020a056a00130f00b006cba60c001dmr10109127pfu.17.1701073654731;
        Mon, 27 Nov 2023 00:27:34 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:19a0:3eee:b37f:15f2])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78c10000000b006905f6bfc37sm6694946pfd.31.2023.11.27.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:27:34 -0800 (PST)
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
        ziy@nvidia.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [RESEND PATCH v7 01/10] mm: Allow deferred splitting of arbitrary anon large folios
Date:   Mon, 27 Nov 2023 21:27:11 +1300
Message-Id: <20231127082711.12885-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122162950.3854897-2-ryan.roberts@arm.com>
References: <20231122162950.3854897-2-ryan.roberts@arm.com>
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

> In preparation for the introduction of anonymous small-sized THP, we
> would like to be able to split them when they have unmapped subpages, in
> order to free those unused pages under memory pressure. So remove the
> artificial requirement that the large folio needed to be at least
> PMD-sized.
> 
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Reviewed-by: Barry Song <v-songbaohua@oppo.com>

>  mm/rmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 7a27a2b41802..49e4d86a4f70 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1488,11 +1488,11 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  		__lruvec_stat_mod_folio(folio, idx, -nr);
> 
>  		/*
> -		 * Queue anon THP for deferred split if at least one
> +		 * Queue anon large folio for deferred split if at least one
>  		 * page of the folio is unmapped and at least one page
>  		 * is still mapped.
>  		 */
> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
> +		if (folio_test_large(folio) && folio_test_anon(folio))
>  			if (!compound || nr < nr_pmdmapped)
>  				deferred_split_folio(folio);
>  	}
> --
> 2.25.1

Thanks
Barry

