Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC1777337
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjHJIoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHJIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:43:59 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A5211D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:43:57 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 37A8hXq5021431;
        Thu, 10 Aug 2023 16:43:33 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 10 Aug 2023
 16:43:29 +0800
Date:   Thu, 10 Aug 2023 16:43:29 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] mm: Add a call to flush_cache_vmap() in vmap_pfn()
Message-ID: <ZNSjMUb5pzZu66i5@atctrx.andestech.com>
References: <20230809164633.1556126-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809164633.1556126-1-alexghiti@rivosinc.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 37A8hXq5021431
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:46:33PM +0200, Alexandre Ghiti wrote:
> flush_cache_vmap() must be called after new vmalloc mappings are
> installed in the page table in order to allow architectures to make sure
> the new mapping is visible.
> 
> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> Reported-by: Dylan Jhong <dylan@andestech.com>
> Closes: https://lore.kernel.org/linux-riscv/ZMytNY2J8iyjbPPy@atctrx.andestech.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  mm/vmalloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 93cf99aba335..228a4a5312f2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2979,6 +2979,10 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
>  		free_vm_area(area);
>  		return NULL;
>  	}
> +
> +	flush_cache_vmap((unsigned long)area->addr,
> +			 (unsigned long)area->addr + count * PAGE_SIZE);
> +
>  	return area->addr;
>  }
>  EXPORT_SYMBOL_GPL(vmap_pfn);
> -- 
> 2.39.2
> 

Hi Alex,

Looks good to me. Thanks.
Reviewed-by: Dylan Jhong <dylan@andestech.com>

Best regards,
Dylan Jhong

