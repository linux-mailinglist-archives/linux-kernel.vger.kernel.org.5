Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7987D49D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjJXIUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:20:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5A8F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:20:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D802B1FE61;
        Tue, 24 Oct 2023 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698135610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvVbgMaT6cDNfVFtjRVpQ+LIKd3Iozxm21HmFOweANk=;
        b=iU912upV5klSqCuzCr3tutf69PU2ssvPEfGowY/jLenKYbDq6acrvFRoRviGK/AcIUyjfB
        5LW0FbG9xyQ7q72H9CucIFrwPbVngIHDO890DEkg6y0HjMqoQbBS9WZfIR4V1FahMpNlg/
        42S+Rqi/mqB6a22gXcn4xFqcZH7QZb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698135610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvVbgMaT6cDNfVFtjRVpQ+LIKd3Iozxm21HmFOweANk=;
        b=321utMuP9cfe+M0NDWYUkHluxsSmLJZ8SrDN4KlhmBx3Lu3HbvIuWoxZMHgtoiBXugo0lp
        MRTJfbZpptb/7NAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F84D134F5;
        Tue, 24 Oct 2023 08:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6v9qIjp+N2U8XwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 24 Oct 2023 08:20:10 +0000
Message-ID: <4b687334-9667-2655-ab5b-a1aecedb5591@suse.cz>
Date:   Tue, 24 Oct 2023 10:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>, cl@linux.com,
        penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, willy@infradead.org, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
 <72361910-240f-4aa2-a695-117e1b14a804@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <72361910-240f-4aa2-a695-117e1b14a804@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.57
X-Spamd-Result: default: False [-7.57 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FREEMAIL_CC(0.00)[google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,infradead.org,mit.edu,kernel.org,fujitsu.com,pku.edu.cn,vger.kernel.org,kvack.org,bytedance.com];
         BAYES_HAM(-0.97)[86.84%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[19];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 04:20, Chengming Zhou wrote:
> On 2023/10/23 23:46, Vlastimil Babka wrote:
>> Or more precisely, instead of returning the acquired "object" we would
>> return the first slab removed from partial list. I think it would simplify
>> the code a bit, and further reduce list_lock holding times.
> 
> Ok, I will do this in the next version. But I find we have to return the object
> in the "IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)" case, in which
> we need to allocate a single object under the node list_lock.

Ah, right.

> Maybe we can use "struct partial_context" to return the object in this case?
> 
>  struct partial_context {
> -       struct slab **slab;
>         gfp_t flags;
>         unsigned int orig_size;
> +       void *object;
>  };
> 
> Then we can change all get_partial interfaces to return a slab. Do you agree
> with this way?

Yeah, good idea! Thanks!

