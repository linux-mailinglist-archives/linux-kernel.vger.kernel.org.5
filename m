Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC507C5576
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbjJKNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjJKNbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:31:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7203690
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:31:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2817E1FEAE;
        Wed, 11 Oct 2023 13:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697031111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HljStu/Mi1i6SudIv7bnTBAyqUy/d41TujLNpYF5gMY=;
        b=aY11rfjxTE1FoeWh6i9Jql5jaIjxUPytLcWtK2OULeNH9XeIosVjcl49lSJGDZyiiQ7cHy
        M20he2RtrKjbkcjoo+3rja5ilfQxv4CHAHbRvKwWmX636VF65mmtSHPyVmRaeg2YNoqcWr
        Mj3A4BflLN/Rh6kui5F4I8rNOIujNBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697031111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HljStu/Mi1i6SudIv7bnTBAyqUy/d41TujLNpYF5gMY=;
        b=PAmlM41fP4rh/VdU5dAsjrnxjAWX6nOLZNJeAgeEnJBWqG69vJKdY5DTG2uB0LffBORKle
        8PfVse5bOIiYZHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A6E1134F5;
        Wed, 11 Oct 2023 13:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oB+/AcejJmVZTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 11 Oct 2023 13:31:51 +0000
Message-ID: <e20542ca-3150-e281-b677-f6f6532d8181@suse.cz>
Date:   Wed, 11 Oct 2023 15:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH] mm: slab: Do not create kmalloc caches smaller
 than arch_slab_minalign()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>
References: <20231006163934.3273940-1-catalin.marinas@arm.com>
 <a09a6fe5-2352-8922-e575-54bf74ae64e5@suse.cz> <ZSPiAE6c4rzhilRy@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZSPiAE6c4rzhilRy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 13:20, Catalin Marinas wrote:
>> >  mm/slab_common.c | 7 +++++--
>> >  1 file changed, 5 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/mm/slab_common.c b/mm/slab_common.c
>> > index cd71f9581e67..8b45922ed295 100644
>> > --- a/mm/slab_common.c
>> > +++ b/mm/slab_common.c
>> > @@ -895,10 +895,13 @@ void __init setup_kmalloc_cache_index_table(void)
>> >  
>> >  static unsigned int __kmalloc_minalign(void)
>> >  {
>> > +	unsigned int minalign = dma_get_cache_alignment();
>> > +
>> >  	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
>> >  	    is_swiotlb_allocated())
>> > -		return ARCH_KMALLOC_MINALIGN;
>> > -	return dma_get_cache_alignment();
>> > +		minalign = ARCH_KMALLOC_MINALIGN;
>> > +
>> > +	return ALIGN(minalign, arch_slab_minalign());
>> 
>> Could it be max() instead of ALIGN()? It would be more obvious, at least to
>> me :)
> 
> Yeah, max() would do since they are all a power of two. Do you want me
> to repost?

No need, picked up and changed locally. Thanks!


