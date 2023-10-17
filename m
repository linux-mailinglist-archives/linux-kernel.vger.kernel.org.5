Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2C7CBD10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjJQIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:07:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6393
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:07:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3E5D1FF03;
        Tue, 17 Oct 2023 08:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697530025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/CSsmsk8NkBoaQCYM0w1pxloTpa4pHSwaQeLlLtPko=;
        b=CqT5/EdL7YAR+axoMfQWnUdoiKNdN90c0ZpgpNpH76qNn7qII3eJEJXQ3n00ogxaGCz/Zt
        ZkpQ9nt+4YPbQOn3wgtums0J1GAdcX/Mg6omE4nAxPhFU9LQKMlBT1vREtVGXvgI3x6AGy
        cDKLPU5FwXNYF8Z68w44ta1sFiI+O4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697530025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/CSsmsk8NkBoaQCYM0w1pxloTpa4pHSwaQeLlLtPko=;
        b=jo40IeJUnzTOr6HqWPg9kologq4Y/8GuNP4oIe32KM0WMM0LfnJzzSEhbH9mlV4ZvaWeKC
        RzA/ScHKfbYWPyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5A6513597;
        Tue, 17 Oct 2023 08:07:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NbpTM6hALmXDQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Oct 2023 08:07:04 +0000
Message-ID: <993173fc-5d03-a715-64a8-d69893dc163c@suse.cz>
Date:   Tue, 17 Oct 2023 10:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] mm/page_owner: Remove free_ts from page_owner output
Content-Language: en-US
To:     Audra Mitchell <audra@redhat.com>, linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231013190350.579407-1-audra@redhat.com>
 <20231013190350.579407-2-audra@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231013190350.579407-2-audra@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 1.00
X-Spamd-Result: default: False [1.00 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 21:03, Audra Mitchell wrote:
> When printing page_owner data via the sysfs interface, no free pages will
> ever be dumped due to the series of checks in read_page_owner():
> 
>     /*
>      * Although we do have the info about past allocation of free
>      * pages, it's not relevant for current memory usage.
>      */
>      if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
> 
> The free_ts values are still used when dump_page_owner() is called, so
> keeping the field for other use cases but removing them for the typical
> page_owner case.
> 
> Fixes: 866b48526217 ("mm/page_owner: record the timestamp of all pages during free")
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_owner.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 4e2723e1b300..4f13ce7d2452 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -408,11 +408,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		return -ENOMEM;
>  
>  	ret = scnprintf(kbuf, count,
> -			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu ns, free_ts %llu ns\n",
> +			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu ns\n",
>  			page_owner->order, page_owner->gfp_mask,
>  			&page_owner->gfp_mask, page_owner->pid,
>  			page_owner->tgid, page_owner->comm,
> -			page_owner->ts_nsec, page_owner->free_ts_nsec);
> +			page_owner->ts_nsec);
>  
>  	/* Print information relevant to grouping pages by mobility */
>  	pageblock_mt = get_pageblock_migratetype(page);

