Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9A7CDE76
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbjJROKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344855AbjJROJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EF8134;
        Wed, 18 Oct 2023 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rpuNbd94xDpC5yviFqSYGb67pMTnatBYUkMFHMRu+WQ=; b=A82ROViWDiEH/4M8z9imm3e3/s
        x3RZpyqNnJVjq0TTDrFUnQWW0cApFYG2OBqbUdhaJ5dv7tI4kZtXZdv7Q6uMron4TrtFc4csYr81K
        IzWKOwYfwxQzxuVeilxnF09krQw/KDNK4OnstLrWDgoIDPAi3seMj2BV9TAubjJq+caaUBxekrS4g
        67ih3Qc27mQsMD/D5mIT185qkJW7k8Ij5dS2tQVLevrYTmfE24at7lH9r05KP3FBjEeJ6yY446GpW
        UZ2bC6OY1SIFkny/wEnPNHrpDc83dWl0BYXOQ4xtfDuLYKahDDeUqGRaS5DR2VaQn3L/jhjGQZbDX
        gP/2Gl+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qt7Dg-001ICr-G8; Wed, 18 Oct 2023 14:08:20 +0000
Date:   Wed, 18 Oct 2023 15:08:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sourav Panda <souravpanda@google.com>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 1/1] mm: report per-page metadata information
Message-ID: <ZS/m1KRwTLkcJY8y@casper.infradead.org>
References: <20231018005548.3505662-1-souravpanda@google.com>
 <20231018005548.3505662-2-souravpanda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018005548.3505662-2-souravpanda@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 05:55:48PM -0700, Sourav Panda wrote:
> +		mod_node_early_perpage_metadata(pgdat->node_id,
> +						PAGE_ALIGN(size) >> PAGE_SHIFT);

What a curious way of writing DIV_ROUND_UP(size, PAGE_SIZE)
(throughout).  A quick grep shows about 230 DIV_ROUND_UP and 110 of what
you wrote, so it's not something you invented, but DIV_ROUND_UP is
clearer.

> @@ -303,18 +308,25 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
>  
>  static void free_page_ext(void *addr)
>  {
> +	size_t table_size;
> +	struct page *page;
> +
> +	table_size = page_ext_size * PAGES_PER_SECTION;
> +
>  	if (is_vmalloc_addr(addr)) {
> +		page = vmalloc_to_page(addr);
>  		vfree(addr);
>  	} else {
> -		struct page *page = virt_to_page(addr);
> -		size_t table_size;
> -
> -		table_size = page_ext_size * PAGES_PER_SECTION;
> +		page = virt_to_page(addr);
>  
>  		BUG_ON(PageReserved(page));
>  		kmemleak_free(addr);
>  		free_pages_exact(addr, table_size);
>  	}
> +
> +	__mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA,
> +			      -1L * (PAGE_ALIGN(table_size) >> PAGE_SHIFT));

This troubles me.  We're freeing the memory and then dereferencing
the page that was freed.  I know that struct pages don't go away when
they're freed, and they don't change which node they're allocated to,
but it feels wrong.  I'd be happier if the page_pgdat() were extracted
prior to freeing the memory.
