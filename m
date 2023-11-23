Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E807F5C24
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbjKWKTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjKWKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:19:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449A9F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:19:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E095FC433C7;
        Thu, 23 Nov 2023 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700734748;
        bh=BIsZoyFkGqybSMp8LsFEV/t0sEtZKTYGcLF/WgdEU8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfisG42wNKSu3613Sr6vuiVrQghiiyZTRf7R1sFUOw1Oha90RgZu8eBFpTxci+zF1
         agbbICZLrwQfHlza87s+C4NXEcoif+I8cE/Uql2TVYmm03S+sncf7anWPLPm9epCcW
         b8NvfnciZgPu9yLK1bBbA7oWJfble2vM5hsF4SB1DIHmjv4XRW784yDrPu7L5vu7eA
         rdFN0/essbPCun0V4WMDFBMNofYDMYllC1dWxjXHV0nS+4ZMoEdvncJ40jsOmz83pZ
         A2YiFWVDVNq1DNhvUvopxNOLIIgwS91e6CfYOORHvJZi2r0qtc0dEDCJS1Tuwfggng
         nrgAVeuDrFwnA==
Date:   Thu, 23 Nov 2023 12:18:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm/mm_init.c: Extend init unavailable range doc info
Message-ID: <20231123101854.GF636165@kernel.org>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-6-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122182419.30633-6-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Wed, Nov 22, 2023 at 09:24:03PM +0300, Serge Semin wrote:
> Besides of the already described reasons the pages backended memory holes
> might be persistent due to having memory mapped IO spaces behind those
> ranges in the framework of flatmem kernel config. Add such note to the
> init_unavailable_range() method kdoc in order to point out to one more
> reason of having the function executed for such regions.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
> 
> Please let me know if the IO-space pages must be initialized somehow
> differently rather relying on free_area_init() executing the
> init_unavailable_range() method.

Maybe I'm missing something, but why do you need struct pages in the
IO space?

> ---
>  mm/mm_init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 077bfe393b5e..3fa33e2d32ba 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -796,6 +796,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>   * - physical memory bank size is not necessarily the exact multiple of the
>   *   arbitrary section size
>   * - early reserved memory may not be listed in memblock.memory
> + * - memory mapped IO space
>   * - memory layouts defined with memmap= kernel parameter may not align
>   *   nicely with memmap sections
>   *
> -- 
> 2.42.1
> 

-- 
Sincerely yours,
Mike.
