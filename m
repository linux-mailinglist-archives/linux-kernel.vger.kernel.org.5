Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4880F8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377468AbjLLU55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjLLU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:57:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B9D66
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uITo0Guj0fvGl1HiaxKOp67qOA6E5V8qn2kdwMvT6sI=; b=JCJxZjqqjUowDP4pNyoBpmBOIu
        ECYAvUk8kQTATukZso13qhi/8JOSGmjS5263QfDm47xDoR8+6LXRDgQz3kFVVh+YiGHCAfbLje9JY
        rNp0AE1M6F0GfSYqxtQTxOofQhn4XNw8AvV8JGV0bBko4bNyRNAQK9VBBOGJ9BFZp+nsOizGm608f
        1xi5KupnhwRLgwKKSGqJsM3mVamf3OTQWtdtbt8Rm3n87urVek7fuPLFbDXZ2BLqv+n406P4XmOz1
        t65/177xyXmgwjnF3wkOdOK/ba/g2oMP7HwzDLdy0p3dhJmx0gaHKUIlja6YLej+S8jFgFM4xa5C/
        bxON2U3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rD9p6-00BBis-OI; Tue, 12 Dec 2023 20:57:48 +0000
Date:   Tue, 12 Dec 2023 20:57:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com
Subject: Re: [PATCH] maple_tree: do not preallocate nodes for slot stores
Message-ID: <ZXjJTM0pDksnslgo@casper.infradead.org>
References: <20231212194640.217966-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212194640.217966-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:46:40AM -0800, Sidhartha Kumar wrote:
> +	/* Slot store, does not require additional nodes */
> +	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
> +		|| (wr_mas.offset_end - mas->offset == 1)))
> +		return 0;

Should we refactor this into a mas_is_slot_store() predicate?

A few coding-style problems with it as it's currently written:

1. The indentation on the second line is wrong.  It makes the
continuation of the condition look like part of the statement.  Use
extra whitespace to indent.  eg:

	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
			|| (wr_mas.offset_end - mas->offset == 1)))
		return 0;

2. The operator goes last on the line, not at the beginning of the
continuation line.  ie:

	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree)) ||
			(wr_mas.offset_end - mas->offset == 1)))
		return 0;

3. You don't need parens around the !mt_in_rcu(mas->tree).  There's
no ambiguity to solve here:

	if ((node_size == mas->end) && (!mt_in_rcu(mas->tree) ||
			(wr_mas.offset_end - mas->offset == 1)))
		return 0;

But I'd write it as:

	if ((node_size == mas->end) &&
	    (!mt_in_rcu(mas->tree) || (wr_mas.offset_end - mas->offset == 1)))
		return 0;

because then the whitespace matches how you're supposed to parse the
condition, and so the next person to read this code will have an easier
time of it.

