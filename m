Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CFF7F3E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjKVGVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:20:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957F19D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/cYE10pQhZn9hOp+ZMW+N4doTFUbECzoIMfshVyvGDY=; b=OynjtmZQLAej8/FNfkpV0sngDh
        /Lsty0gmyOn/1alVikEVLx5fJAD1nqbUAbWZS6lizITR4UhWgH6+rmZrpxro0hDsonvov1dvlm4BW
        LFfwQRDr2qjGHAAi9ktYO8wJdLhy6/CyjrORHXifUxdfMBf2TeXm5vKplX+HzR3oteydJO6EtPxVy
        uE0ApIN7gBV7W0J2Z6bRa7cDd06HyXP8QHpwmHzv6OVqP87w58/H5eMJkepsZ6tVuxzAuLd3nR2ZT
        8xjq1aqT2zxRSroI6eo763NLPHcKOWGSmcnObBpKWlVVM3hn8n3Hd5h3Mhd7N6ozl+mtVQCIOhjFL
        k+6M33lA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r5gbO-006HGc-AG; Wed, 22 Nov 2023 06:20:46 +0000
Date:   Wed, 22 Nov 2023 06:20:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v3] mm: ALLOC_HIGHATOMIC flag allocation issue
Message-ID: <ZV2dvlKYSDUu6Uit@casper.infradead.org>
References: <20231122013925.1507-1-justinjiang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122013925.1507-1-justinjiang@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:39:25AM +0800, Zhiguo Jiang wrote:
> Update base on the latest Linus' tree or Andrew's tree.
> +++ b/mm/page_alloc.c
> @@ -2851,9 +2851,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  			int alloced;
>  
>  			/*
> -			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
> -			 * it should alloc from buddy highatomic migrate freelist firstly
> -			 * to ensure quick and successful allocation.
> +			 * If pcplist is empty and alloc_flags contains
> +			 * ALLOC_HIGHATOMIC, alloc from buddy highatomic
> +			 * freelist first.

No, it's still based on your earlier patch,  is it really so hard for
you to read your patches before you send them?
