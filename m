Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D77E2C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjKFTA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjKFTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:00:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017E134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S1v0S2JecaFdDuKteJQPQfqSbMeszz0DlIV0jVMrBEs=; b=iAUlm6oERK7x44Sld/Wg5L+uUl
        NdFtvZIpve6t49PqXASj+HLAVbCkH/1V8oiMJXxmIgF5UaY4JmhLiROqZjH/wI8gT2Hkyinonpvhg
        SV1bFvn0KNo1lBi2heNS96mlIP+1LbsNWMkpOMk1MmQg4+IHpvfw6m3Wlvf5xU8T0upPE5CQtDhXw
        xSx038MlfmTDx0KLeioKVvgBdXIk/AF7T81tg+L7j8GSE1Lo+g3aiLn13n96ykvPPIx/OjQVZgG54
        9BPCoY9SIoeM3pZskimmZtEqsenTTz+QFkzpddqwc5CbZ4zycHoOydwxMcKMAIjcy9N3ZrtSqzenT
        Zs7yNhlg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r04pH-007dUy-GT; Mon, 06 Nov 2023 18:59:55 +0000
Date:   Mon, 6 Nov 2023 18:59:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <ZUk3q/H/swmDPRo+@casper.infradead.org>
References: <20231106181918.1091043-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106181918.1091043-1-shr@devkernel.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:19:18AM -0800, Stefan Roesch wrote:
> +++ b/mm/huge_memory.c
> @@ -2740,7 +2740,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  			if (folio_test_swapbacked(folio)) {
>  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
>  							-nr);
> -			} else {
> +			} else if (folio_test_pmd_mappable(folio)) {
> +
>  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
>  							-nr);
>  				filemap_nr_thps_dec(mapping);

Good catch.  Two things:

1. No blank line after the 'else if'.

2. We're leaving a bit of a landmine for shmem when it gets support for
arbitrary folio sizes.  Really all of this should be under a
test_pmd_mappable.
