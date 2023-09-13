Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD179EB23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbjIMObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbjIMObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:31:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32679B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:31:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67772218EC;
        Wed, 13 Sep 2023 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694615475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EY/TxriRyLcQRT/QMGb4HpluzBBUSCH2N2LP0RzmfO8=;
        b=NeoBvf5VsVcl9T2Kn2QDODTiiC7qSnHJx+vjBBavdg/eaixbkUXEyz7gvKNUoP0mT2Pz9R
        t5sej4mVeuZzT2wEbYDB3CaxQLw7c1mFuTqal6sojjcFlUbWPOhHmj7UDZxSXM+nwTeLB1
        34ksygCii9pbj8b7VG2iXea8MxacYJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694615475;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EY/TxriRyLcQRT/QMGb4HpluzBBUSCH2N2LP0RzmfO8=;
        b=otSpZk/66fLfB3CFnrVlBquoqW6KRhdLNyBirtLyf/jREhi1uEp8DdaQjY11JfLOcSxy9U
        ADnCwyuUgNT3SXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4425813582;
        Wed, 13 Sep 2023 14:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JpOOD7PHAWX0ZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Sep 2023 14:31:15 +0000
Message-ID: <b9da077a-d7a6-aaf3-d64d-be432a8034ab@suse.cz>
Date:   Wed, 13 Sep 2023 16:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/6] mm: page_alloc: move free pages when converting block
 during isolation
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-4-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230911195023.247694-4-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 21:41, Johannes Weiner wrote:
> When claiming a block during compaction isolation, move any remaining
> free pages to the correct freelists as well, instead of stranding them
> on the wrong list. Otherwise, this encourages incompatible page mixing
> down the line, and thus long-term fragmentation.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3db405414174..f6f658c3d394 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2548,9 +2548,12 @@ int __isolate_free_page(struct page *page, unsigned int order)
>  			 * Only change normal pageblocks (i.e., they can merge
>  			 * with others)
>  			 */
> -			if (migratetype_is_mergeable(mt))
> +			if (migratetype_is_mergeable(mt)) {
>  				set_pageblock_migratetype(page,
>  							  MIGRATE_MOVABLE);
> +				move_freepages_block(zone, page,
> +						     MIGRATE_MOVABLE, NULL);
> +			}
>  		}
>  	}
>  

