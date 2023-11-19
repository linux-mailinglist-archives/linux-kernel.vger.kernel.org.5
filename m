Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507987F0917
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 22:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjKSVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 16:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 16:12:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C93E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 13:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4yGkltmM8hvQ5Y+Wmub3JiXWUCK7R5wHysZVImu3ung=; b=PhRXGdulG6GFPYCO+YRKK+9dp1
        ojal+WbNlTGQxgQKxVrvQ+5t2coN3Q56h7HHJPCDxEUKUs6USZF/ICEIfM4697dc1A6Thhd1OiB+y
        UyX7H5Y+7wJcrEcrQyPz6hyLqkLLXCTVP4vOiRL15FbBSqVorMRwVPFRXk6Gwc9zPIyNKD4so2xtG
        UBy3klULNmlxbdR6lV8LO5HgGfNlKVAKn6JS7dZyqtQmUg9bh+yVUk8ado/hOc+ohAUXW1gH+Hcmc
        T6VeiWFq+srCpYWt87bB6WFbj098kZEnnsg2NMXe7kmDJTHWEnHi6NLkM+fuvYRkS455+yX9MVzOA
        /tNCEzGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r4p5S-00342X-32; Sun, 19 Nov 2023 21:12:14 +0000
Date:   Sun, 19 Nov 2023 21:12:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] mm/swap: reduce scope of get_swap_device in swapin
 path
Message-ID: <ZVp6Lt0socttCB9+@casper.infradead.org>
References: <20231119194740.94101-1-ryncsn@gmail.com>
 <20231119194740.94101-17-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119194740.94101-17-ryncsn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:47:32AM +0800, Kairui Song wrote:
>  	page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
>  				vmf, &cache_result);
> -	if (page) {
> +	if (PTR_ERR(page) == -EBUSY) {

	if (page == ERR_PTR(-EBUSY)) {

