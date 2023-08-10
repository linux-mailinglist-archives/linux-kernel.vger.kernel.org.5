Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444777774F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjHJJxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHJJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:53:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B207FE7C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:53:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74CE921860;
        Thu, 10 Aug 2023 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691661195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFC9wBjADU/4Ny+WTzllIDwXI2l7q/6ouoTgKvI7xfI=;
        b=SqSxTpnXkP8/OwZ5x/DS/YXqOs78uyBHK0eeRlkxwgxuyEk5DcasRGQSEgOxOEynT7XQ7u
        0Z86NYtUAUoNUnIAXhKHXxO07GYTFGulNYgAEWkq8TmQfZxI6nbOVNimakHqKHBBZr8Bn5
        jejJ5qV5y6PcJl3FTl/qaqH93LuAPNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691661195;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFC9wBjADU/4Ny+WTzllIDwXI2l7q/6ouoTgKvI7xfI=;
        b=EMQepI+VkxvUEzYwHl8gKp9cverIarfygQCRlEIoj07B9Q8+Def6ajbrhHZUAkSVtZeeuO
        wx86v83vdEsAk4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5092A138E0;
        Thu, 10 Aug 2023 09:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c4LpEouz1GTfCwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Aug 2023 09:53:15 +0000
Message-ID: <08dd143e-3eb4-1854-eddd-508f997dd810@suse.cz>
Date:   Thu, 10 Aug 2023 11:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] lib/stackdepot: Bail out in __stack_depot_save() if
 the stack_table is not allocated
To:     Xiaolei Wang <xiaolei.wang@windriver.com>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, glider@google.com, andreyknvl@gmail.com,
        zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
 <20230810074704.2042664-2-xiaolei.wang@windriver.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230810074704.2042664-2-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 09:47, Xiaolei Wang wrote:
> The __stack_depot_save() may be used by some subsystems even before
> the stack depot is initialized.

Does that currently happen, or only after patch 2/2 it starts happening via
kmemleak?

> So add a check of stack_table in
> __stack_depot_save() to make sure no oops in this case.
> 
> Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")

In case it's only after 2/2 I don't think this is truly "Fixes"?

> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  lib/stackdepot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 2f5aa851834e..a0651d013a0d 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -376,7 +376,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  	 */
>  	nr_entries = filter_irq_stacks(entries, nr_entries);
>  
> -	if (unlikely(nr_entries == 0) || stack_depot_disabled)
> +	if (unlikely(nr_entries == 0) || stack_depot_disabled || unlikely(!stack_table))
>  		goto fast_exit;
>  
>  	hash = hash_stack(entries, nr_entries);

