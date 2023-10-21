Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01137D1B8C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjJUHmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJUHmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:42:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA2D63
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 00:42:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-694ed847889so1471381b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697874165; x=1698478965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxGZv3+nbDK0KAiEtx87UBwep5t6o6e84aXI1iP750g=;
        b=mojWqrSz2pISooIVOKmQyqUEPimMOllzeuPv9ltXy4jqtx5p9H5R3CXMSN93ZTqaya
         DKihbP+w0rQm6M2cluj/TojvP11gxlYVXc2ptccG/478QArDyCNsbQcKdPPiq6gUkU2E
         8i3bHHLQhLU2Ilzq2Pl/r0WMoDrzJxrEvNyGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697874165; x=1698478965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxGZv3+nbDK0KAiEtx87UBwep5t6o6e84aXI1iP750g=;
        b=LZr6JS96wNodv1IOjFxD+J8z3VeGrtkbzKCqDhc5e3+gr8hyONNOFWOs7xl45fMASC
         7o8R2o8aHYn3doipfpMY50ec8V9DcgzyJpejZrYw8BNs7OPey7QQgVP0xBgfZvqgdoLd
         Y75wllrK20dof0tv9qVExDeHif7pnCrREzhHIQluQ2dgzBojK8vyN8GCpPoU62We7Bpu
         apwv1xBhIDmMjusf0yh5qftI6Eggv6EqkklHZAN3nHTjsBbk0y3eGu49uwLJLPse7Uhd
         1uqMffox6sfg1XETrE+TccGYvcwez63N5FxTbC2u2mKtVs2icyCVWwWa0FFPEnoutIAi
         9CeQ==
X-Gm-Message-State: AOJu0Yy5kZ0MT25lsGfnpqTkwWJOO+YBsnBvwg2ysF5nldj9DFYVrjFG
        WBtuHB+IzqfBd6lXeZuaKHnvMQ==
X-Google-Smtp-Source: AGHT+IFNeOVWTBUsR/cSULwxlZjsVlgmePnTkaPNbn2WJpJr/jCbjh9rEgMrjUsrJyBq0Dzhj9KogA==
X-Received: by 2002:a05:6a00:84e:b0:6bd:e39c:aad5 with SMTP id q14-20020a056a00084e00b006bde39caad5mr3480220pfk.15.1697874165469;
        Sat, 21 Oct 2023 00:42:45 -0700 (PDT)
Received: from google.com (KD124209175111.ppp-bb.dion.ne.jp. [124.209.175.111])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7960e000000b0069305627491sm2664259pfg.159.2023.10.21.00.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 00:42:45 -0700 (PDT)
Date:   Sat, 21 Oct 2023 16:42:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 2/8] hugetlb: restructure pool allocations
Message-ID: <20231021074238.GA1004891@google.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
 <20231019023113.345257-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019023113.345257-3-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/10/18 19:31), Mike Kravetz wrote:
> Allocation of a hugetlb page for the hugetlb pool is done by the routine
> alloc_pool_huge_page.  This routine will allocate contiguous pages from
> a low level allocator, prep the pages for usage as a hugetlb page and
> then add the resulting hugetlb page to the pool.
> 
> In the 'prep' stage, optional vmemmap optimization is done.  For
> performance reasons we want to perform vmemmap optimization on multiple
> hugetlb pages at once.  To do this, restructure the hugetlb pool
> allocation code such that vmemmap optimization can be isolated and later
> batched.
> 
> The code to allocate hugetlb pages from bootmem was also modified to
> allow batching.
> 
> No functional changes, only code restructure.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
