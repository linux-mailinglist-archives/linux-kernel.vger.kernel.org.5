Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0147E8335
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346578AbjKJTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346596AbjKJTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:48:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C92120C22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sETFuFqSJGaVbgEWP5OyduOIoGx5CUEWS4/wqpSOq54=; b=CmXw2fQN5Ge3CBTGk9+fHqp0II
        LzZta3QGOFDQQW/PB6dn/7IHGfAe6k4yIhUUp90cat9UqHDx4hosFan46felTGtLdxY4QC+eRl0+L
        +X6qmY2l5XzVML4o6dP8mv7CsKxv4oK8q/gfeAD06Ej9qsPXza8TaaxJqN8bc7bfe1U3d6rLHyO/9
        ExjM+LME3B1J30ZCGhKYozS5zT/BTinnBntTOrOz44WTtYtF7Q86biEz7tIogOcMWzAI4skF+wsI2
        bb3LG3vpKDxDoZZnZoySBnZt/Ts3e7O/5XrwynFthd/2aDnPW+69YOdjU55QKo1HEup3d490diNiP
        83MWtomA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1WG1-00Ew5q-Jg; Fri, 10 Nov 2023 18:29:29 +0000
Date:   Fri, 10 Nov 2023 18:29:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v2 5/7] mm: task_mmu: use a folio in smaps_account()
Message-ID: <ZU52ifwZcNhmz0rA@casper.infradead.org>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-6-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110033324.2455523-6-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:33:22AM +0800, Kefeng Wang wrote:
> Replace seven implicit calls to compound_head() with one page_folio().

You're so focused on trying to accomplish your goal (killing off the
page_idle and page_young functions) that you're doing a poor job thinkig
about the conversions you're doing along the way.

> +++ b/fs/proc/task_mmu.c
> @@ -445,23 +445,25 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>  {
>  	int i, nr = compound ? compound_nr(page) : 1;
>  	unsigned long size = nr * PAGE_SIZE;
> +	struct folio *folio = page_folio(page);

Stop right here.  The use of compound_nr() should give you pause.

After looking at how smaps_account() is used, it seems to me that the
two callers should each pass in PAGE_SIZE or PMD_SIZE instead of doing
this calculation.

More generally, step back from this series.  Do a good job of
transforming fs/proc/task_mmu.c to use folios.  Once you've done
that, you can approach the young/idle work again.

