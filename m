Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE277755D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjHJKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjHJKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:05:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A8120
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:04:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 278371F45B;
        Thu, 10 Aug 2023 10:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691661839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i21qGjnD4E4GMjhNoOdGmGEmdrBlC1HsWtENtLCdxgM=;
        b=Q62BEw6FkURVeWKltiACy/dTzV4jpB9Na4TAFm/3b3DlwMy5Pdd0l9tmc7JHCk8opR0/Wf
        XsX6j9DavJu4ElBCypgFcA0fIZewBRkWGDbLm37GRWzl3wq2PcILQk4O0aVsDIZMWYD0+a
        JVf/aafqbHJOK6Pc2ecBFHFusBvgCBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691661839;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i21qGjnD4E4GMjhNoOdGmGEmdrBlC1HsWtENtLCdxgM=;
        b=VQ5+1JXpg+KmwEW8nADF5Kuvq0m7HBx48ssKccFpJ79F1UM/Uo+B7P0GN+Q7MgngR4qKiT
        dW9CSrX7l7J2QrCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 055DE138E0;
        Thu, 10 Aug 2023 10:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5nuMAA+21GRvEAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Aug 2023 10:03:59 +0000
Message-ID: <37397d75-c95c-8730-cf22-79e283e0bd6c@suse.cz>
Date:   Thu, 10 Aug 2023 12:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] mm/kmemleak: No need to check kmemleak_initialized in
 set_track_prepare()
Content-Language: en-US
To:     Xiaolei Wang <xiaolei.wang@windriver.com>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, glider@google.com, andreyknvl@gmail.com,
        zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
 <20230810074704.2042664-3-xiaolei.wang@windriver.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230810074704.2042664-3-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 09:47, Xiaolei Wang wrote:
> The kmemleak_late_init() is defined as a late_initcall. The current
> implementation of set_track_prepare() depends on the kmemleak init.
> That also means there is no call trace for the memory leak which object
> is created before the kmemleak_late_init().

So if I understand correctly, we have the following sequence of events durin
boot

...
A: stack_depot is initialized
...
B: kmemleak is initialized
...

before this patchset, we can miss allocations before B, aftewards only
before A (which can't be helped), so we now have between A and B.

That's nice, but it's weird that can record kmemleak when
!kmemleak_initialized. Why can't it be initialized sooner in that case?

> In a previous patch, we have fixed a bug in stack_depot_save() so that
> it can be invoked even before stack depot is initialized. So there is
> no reason to check the kmemleak_initialized in set_track_prepare().
> So delete the kmemleak_initialized judgment in set_track_prepare()
> 
> unreferenced object 0xc674ca80 (size 64):
>   comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
>   hex dump (first 32 bytes):
>     80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
>     00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........
> 
> Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  mm/kmemleak.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index a2d34226e3c8..c9f2f816db19 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -610,8 +610,6 @@ static noinline depot_stack_handle_t set_track_prepare(void)
>  	unsigned long entries[MAX_TRACE];
>  	unsigned int nr_entries;
>  
> -	if (!kmemleak_initialized)
> -		return 0;
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>  	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
>  

