Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90717F090A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 22:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjKSVAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 16:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKSVAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 16:00:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D30E0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 13:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ewgYBVW+Iax6CqzUrSGGjtpzlAkAA8ZMF03lgMpKaIM=; b=L7I4eUqhsu4ZZE1SCodP+CJCa5
        lYRdOOhI8LmR0CCIKa3wU5+7oLM/bhCZcjFmXsE2EfXVh5IrKBhX+la7+E9OeSncmFHwfi6/5jrJF
        M4ayq94GPqv3jN2o6ub8xvP3YV3p/v1N6H6fhVNDsNQvNcwWG++4ngyUKPQtJft61+hp6P4PcZXD/
        M1r/cPpOU+6yynFEkLk5FXGmolrrwfxMKQssZIULatYKHlIy6oIEY0fgrud9V8vigjqGNTAnQmu91
        26WPxjLWmrrz99hjnHnjkMe7wAl2aYvKkb/VuGRHZunrgggQMzkBX9EVYZAyeODiVaNNNRBMSxxfL
        BQasstSw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r4otl-0032p2-JP; Sun, 19 Nov 2023 21:00:09 +0000
Date:   Sun, 19 Nov 2023 21:00:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/24] mm/swap: move no readahead swapin code to a stand
 alone helper
Message-ID: <ZVp3WR+D4Z/UZEqO@casper.infradead.org>
References: <20231119194740.94101-1-ryncsn@gmail.com>
 <20231119194740.94101-4-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119194740.94101-4-ryncsn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:47:19AM +0800, Kairui Song wrote:
> +			/* skip swapcache and readahead */
> +			page = swapin_no_readahead(entry, GFP_HIGHUSER_MOVABLE,
> +						vmf);
> +			if (page)
> +				folio = page_folio(page);

I think this should rather be:

			folio = swapin_no_readahead(entry,
					GFP_HIGHUSER_MOVABLE, vma);
			page = &folio->page;

and have swapin_no_readahead() work entirely in terms of folios.

