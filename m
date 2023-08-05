Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A991D7710C7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHERLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHERLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376C1E51
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD91A60C59
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 17:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF1CC433C8;
        Sat,  5 Aug 2023 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691255471;
        bh=kIW2ToFnM5JhLxQbr+hFkYlTARFnsrqMHbJ+6K7FJDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2XN9wsHU0mB5AAZhW+OTNCDcQ0xanRYZHpbgozUxdNJ2zOBGHeKQ8lXBaHEH9Kj5k
         Ozp1an1x6HFCggQayOPNoQ3aU+2QP5uX+mm3VRL5FVjfe6Ol1ec7DxRVEjBSl/jqQ1
         cuAakzhvsk2U1YWTCde+RradwvVF8dVaZHleZqxs=
Date:   Sat, 5 Aug 2023 10:11:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        david@redhat.com
Subject: Re: [PATCH 1/9] mm/compaction: use correct list in
 move_freelist_{head}/{tail}
Message-Id: <20230805101109.740fdc21418d0753c4658df1@linux-foundation.org>
In-Reply-To: <20230805110711.2975149-2-shikemeng@huaweicloud.com>
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
        <20230805110711.2975149-2-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Aug 2023 19:07:03 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> The freepage is chained with buddy_list in freelist head. Use buddy_list
> instead of lru to correct the list operation.
> 
> ...
>
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1395,8 +1395,8 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
>  {
>  	LIST_HEAD(sublist);
>  
> -	if (!list_is_last(freelist, &freepage->lru)) {
> -		list_cut_before(&sublist, freelist, &freepage->lru);
> +	if (!list_is_last(freelist, &freepage->buddy_list)) {
> +		list_cut_before(&sublist, freelist, &freepage->buddy_list);
>  		list_splice_tail(&sublist, freelist);
>  	}
>  }
> @@ -1412,8 +1412,8 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
>  {
>  	LIST_HEAD(sublist);
>  
> -	if (!list_is_first(freelist, &freepage->lru)) {
> -		list_cut_position(&sublist, freelist, &freepage->lru);
> +	if (!list_is_first(freelist, &freepage->buddy_list)) {
> +		list_cut_position(&sublist, freelist, &freepage->buddy_list);
>  		list_splice_tail(&sublist, freelist);
>  	}
>  }

This looks like a significant error.  Can we speculate about the
possible runtime effects?

