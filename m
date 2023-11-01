Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B667DE238
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjKAN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjKAN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:59:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF89102
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:59:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C62D421A48;
        Wed,  1 Nov 2023 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698847146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxKyeScCyPMpGbC3rBZNL7gdUoMTssyAdK9u/UECHK4=;
        b=Yn24vEYJHd9IjbeXVJhDErDtI99tIo3lFtK4moGRu2qFrhZ7Lsw4Our5e+rgVmps+h4oO6
        lV4yhcZGZKNmfz1mGP+IT72xmReWZgceCjAwpTrwSU4Snc86jbNIDZAPC8AQeDJjWoOue5
        boWDSuQ15Q6Ks0RzewHnE9j8HavgBAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698847146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxKyeScCyPMpGbC3rBZNL7gdUoMTssyAdK9u/UECHK4=;
        b=ka5soFs1WDXt65FEk7z5Lc8I2DaGkh+F1HsD4DY5bZp5UBsloxKMgTQtpr3Itplq4y8iFV
        l+cs60OYVYpFHSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ED1B13460;
        Wed,  1 Nov 2023 13:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ux3nIapZQmVOfQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Nov 2023 13:59:06 +0000
Message-ID: <029f5042-e41d-5079-fdba-fbe3d4e60dcf@suse.cz>
Date:   Wed, 1 Nov 2023 14:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v4 0/9] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231031140741.79387-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. Testing
> ==========
> We just did some simple testing on a server with 128 CPUs (2 nodes) to
> compare performance for now.
> 
>  - perf bench sched messaging -g 5 -t -l 100000
>    baseline	RFC
>    7.042s	6.966s
>    7.022s	7.045s
>    7.054s	6.985s
> 
>  - stress-ng --rawpkt 128 --rawpkt-ops 100000000
>    baseline	RFC
>    2.42s	2.15s
>    2.45s	2.16s
>    2.44s	2.17s

Looks like these numbers are carried over from the first RFC. Could you
please retest with v4 as there were some bigger changes (i.e. getting
rid of acquire_slab()).

Otherwise I think v5 can drop "RFC" and will add it to slab tree after
the merge window and 6.7-rc1. Thanks!

> It shows above there is about 10% improvement on stress-ng rawpkt
> testcase, although no much improvement on perf sched bench testcase.
> 
> Thanks for any comment and code review!
> 
> Chengming Zhou (9):
>   slub: Reflow ___slab_alloc()
>   slub: Change get_partial() interfaces to return slab
>   slub: Keep track of whether slub is on the per-node partial list
>   slub: Prepare __slab_free() for unfrozen partial slab out of node
>     partial list
>   slub: Introduce freeze_slab()
>   slub: Delay freezing of partial slabs
>   slub: Optimize deactivate_slab()
>   slub: Rename all *unfreeze_partials* functions to *put_partials*
>   slub: Update frozen slabs documentations in the source
> 
>  mm/slub.c | 381 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 180 insertions(+), 201 deletions(-)
> 
