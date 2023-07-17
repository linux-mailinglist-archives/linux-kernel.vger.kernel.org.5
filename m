Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1F75656F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGQNse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjGQNsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:48:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6BECC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yP81tFY4pH4Uv/KB5Cd7YMQTVo773Q8/WCwZl/r6MdM=; b=IKnPkT2uyTAXvHREmWNsusoqR1
        1CJ7o0GyzM8Z2W5DaVh1jLd7ekUkkBbcFFuQTuggUbT8j1r0Ml5IzqF2odT5yrsjn4504kdm9NqUP
        usSw3GNGgi/psfXxRmVeUh6s/p7V9dGHdK4fub2jsFrwIpMOwT5ZDo/r8aKVN8M/Msd7N2rWOi4zb
        kOmD33umFyPJtLfCNiJGDcZ+OykbQb9zhYDlXWUZ4D+5bkv1tGefBaJRO3X/6YnxeEdhM4jqa8GNR
        w/msxM7G6kEv9xydANsn4G/M7uZcZeGIIGrp+Jlc88iG2T/qZIw3YgbPLbHbnsfNCw3y8QmUuPvl7
        EWB6xhlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLOaO-003xdE-Bi; Mon, 17 Jul 2023 13:48:24 +0000
Date:   Mon, 17 Jul 2023 14:48:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 5/6] mm/page_io: convert count_swpout_vm_event() to take
 in a folio
Message-ID: <ZLVGqCwN3FxoQ7cy@casper.infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-6-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717132602.2202147-6-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:26:01PM +0800, Peng Zhang wrote:
> -static inline void count_swpout_vm_event(struct page *page)
> +static inline void count_swpout_vm_event(struct folio *folio)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (unlikely(PageTransHuge(page)))
> +	if (unlikely(folio_test_large(folio)))
>  		count_vm_event(THP_SWPOUT);
>  #endif

Since this is a THP_SWPOUT event, we should do this as:

-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (unlikely(PageTransHuge(page)))
+	if (folio_test_pmd_mappable(folio))
		count_vm_event(THP_SWPOUT);
-#endif

