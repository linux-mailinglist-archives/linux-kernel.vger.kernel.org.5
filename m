Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB27C88D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjJMPiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjJMPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:38:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF10BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nIvCCdy1XG+H8Wg1HwoDHOGu2NtliluWxAZAtaron5k=; b=CLSPltngKWwQZ0Fgf/Lu8NGihP
        6Sit9fIrkm/ThLkMwmxqLVQ/1O/RCT1Ujh3mgoslXVmHv1rQtqQnMfV9br4am3Lzfme7MQ6DeY6a9
        x8mSVawNdgg2FUGtYfFqzYDdV6Xwrzz3LEPhfdIVRHaW1LlDgnuUxgdVHgyFTzG4QfRNOeFTYkTea
        0wNOKdbTmBxwrrwrPpGWKLw84Y6ljikPz4GCgHXnysWZOeY/rCp2LdUxuRpt1sDrB1XktkzpM1sKH
        XQC/LY2ojHY0Afzr/wIKpLFxEbixyZH4gnIN59BTMO3jC2nbT168iog/gQkv4d5HhlIlVjb385XsY
        9lDcArxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qrKFA-006A5i-Gv; Fri, 13 Oct 2023 15:38:28 +0000
Date:   Fri, 13 Oct 2023 16:38:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [RFC PATCH 1/1] mm: only use old generation and stable tier for
 madv_pageout
Message-ID: <ZSlkdGk2KG+zHAkg@casper.infradead.org>
References: <20231013113028.2720996-1-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013113028.2720996-1-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 07:30:28PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Dropping pages of young generation or unstable tier via madvise could
> make the system experience heavy page thrashing and IO pressure.

... then userspace should not do that?

> @@ -5091,6 +5091,7 @@ static int get_tier_idx(struct lruvec *lruvec, int type)
>  
>  	return tier - 1;
>  }
> +EXPORT_SYMBOL_GPL(get_tier_idx);

Why would this need to be exported to modules in order to be used by
madvise?  Is this patch just a trojan horse so you can use get_tier_idx
in your own module?  NAK.
