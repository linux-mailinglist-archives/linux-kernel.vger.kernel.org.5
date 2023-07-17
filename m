Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729C27568B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGQQIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjGQQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:07:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D5FC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=POTa2usJr85Ecy/FRU76IO5QdbP4btKmvKRtBlr6QsU=; b=TRnlFIosnrQPqYe4cUBoBIXlQX
        1JsxtdkBhKef9SawwdF3y9vpKE+JCCqz2VTQwjAd7WUSZfRL/zvoW80ogT9uaJJoegEpA/Q/Ml7Jd
        eS/5R04KQlfbzwvGF09gFu+1lF1bP81SBaqj8/vOHpjpxdl6iXcohb/3JngLjH/LM4b59oNc8z9EY
        +usuNpeUhaygkLWIwl+4O2Dl3sj3MApvFJZaMALZYF0Noh2ANW8cxz1y6ZLi/aISBu/AFKQfOrbOi
        wBFu/PiiUOHuGUU8AJkXDZFRjl/6B24NEMWjA7cy+1WdxVsXBEmVyj/VN0RTRTFAwaXqpQbxCUBvj
        bM6yhwCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLQlG-0043zU-8z; Mon, 17 Jul 2023 16:07:46 +0000
Date:   Mon, 17 Jul 2023 17:07:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-ID: <ZLVnUhXeZ6ptNF2l@casper.infradead.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <ZLIVleBYOm4HIGTZ@casper.infradead.org>
 <20230717141250.GA866068@cmpxchg.org>
 <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
 <20230717160227.GA867137@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717160227.GA867137@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:02:27PM -0400, Johannes Weiner wrote:
> -	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
> +	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
>  		p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
>  		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
>  		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
>  		(p->flags & SWP_DISCARDABLE) ? "D" : "",
>  		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
> -		(p->flags & SWP_PAGE_DISCARD) ? "c" : "",
> -		(frontswap_map) ? "FS" : "");
> +		(p->flags & SWP_PAGE_DISCARD) ? "c" : "");

Is it useful information (to the sysadmin) that zswap is enabled?  If so,
we might want to print a "Z" instead of a "FS" here (would need to
know whether enabling zswap succeeded ...)

