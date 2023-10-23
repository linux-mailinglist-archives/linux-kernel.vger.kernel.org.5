Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3A7D3B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjJWPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjJWPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:46:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB18BC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:46:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E82C21ACA;
        Mon, 23 Oct 2023 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698075974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPoHScL+a5WWnXsYqdVwkaQU1uk8opVpnJPT0SQsd6k=;
        b=WbmBpWI0UJ3IA0s0eZgs1xZmBIZq4lA2GcowtO4P+Hv58+LQebxkr04Bh7Lzok/CiFi4LF
        ehEaFv53RjHiew8eLbw/ZWbjWeCUMwfzclZwt1X6dnO/9UlM+D+8HzbdkMOLkMNqOF+tbk
        SRD9Cmk8FXmv4vrfuafch66uMieuBnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698075974;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPoHScL+a5WWnXsYqdVwkaQU1uk8opVpnJPT0SQsd6k=;
        b=sxDLaKH0jFGJbuBLcEbLOlpQTjfftURqA7JJ9AEl15T8uPOfsvRCCEbbw0XRN7fDyvj314
        FJSxK4/Gl3Sc53CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5684132FD;
        Mon, 23 Oct 2023 15:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Sq16K0WVNmVYGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Oct 2023 15:46:13 +0000
Message-ID: <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
Date:   Mon, 23 Oct 2023 17:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, willy@infradead.org, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231021144317.3400916-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.60
X-Spamd-Result: default: False [-5.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FREEMAIL_CC(0.00)[google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,infradead.org,mit.edu,kernel.org,fujitsu.com,pku.edu.cn,vger.kernel.org,kvack.org,bytedance.com];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 16:43, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>

Hi!

> Changes in RFC v2:
>  - Reuse PG_workingset bit to keep track of whether slub is on the
>    per-node partial list, as suggested by Matthew Wilcox.
>  - Fix OOM problem on kernel without CONFIG_SLUB_CPU_PARTIAL, which
>    is caused by leak of partial slabs when get_partial_node().
>  - Add a patch to simplify acquire_slab().
>  - Reorder patches a little.
>  - v1: https://lore.kernel.org/all/20231017154439.3036608-1-chengming.zhou@linux.dev/
> 
> 1. Problem
> ==========
> Now we have to freeze the slab when get from the node partial list, and
> unfreeze the slab when put to the node partial list. Because we need to
> rely on the node list_lock to synchronize the "frozen" bit changes.
> 
> This implementation has some drawbacks:
> 
>  - Alloc path: twice cmpxchg_double.
>    It has to get some partial slabs from node when the allocator has used
>    up the CPU partial slabs. So it freeze the slab (one cmpxchg_double)
>    with node list_lock held, put those frozen slabs on its CPU partial
>    list. Later ___slab_alloc() will cmpxchg_double try-loop again if that
>    slab is picked to use.
> 
>  - Alloc path: amplified contention on node list_lock.
>    Since we have to synchronize the "frozen" bit changes under the node
>    list_lock, the contention of slab (struct page) can be transferred
>    to the node list_lock. On machine with many CPUs in one node, the
>    contention of list_lock will be amplified by all CPUs' alloc path.
> 
>    The current code has to workaround this problem by avoiding using
>    cmpxchg_double try-loop, which will just break and return when
>    contention of page encountered and the first cmpxchg_double failed.
>    But this workaround has its own problem.

I'd note here: For more context, see 9b1ea29bc0d7 ("Revert "mm, slub:
consider rest of partial list if acquire_slab() fails"")

>  - Free path: redundant unfreeze.
>    __slab_free() will freeze and cache some slabs on its partial list,
>    and flush them to the node partial list when exceed, which has to
>    unfreeze those slabs again under the node list_lock. Actually we
>    don't need to freeze slab on CPU partial list, in which case we
>    can save the unfreeze cmpxchg_double operations in flush path.
> 
> 2. Solution
> ===========
> We solve these problems by leaving slabs unfrozen when moving out of
> the node partial list and on CPU partial list, so "frozen" bit is 0.
> 
> These partial slabs won't be manipulate concurrently by alloc path,
> the only racer is free path, which may manipulate its list when !inuse.
> So we need to introduce another synchronization way to avoid it, we
> reuse PG_workingset to keep track of whether the slab is on node partial
> list or not, only in that case we can manipulate the slab list.
> 
> The slab will be delay frozen when it's picked to actively use by the
> CPU, it becomes full at the same time, in which case we still need to
> rely on "frozen" bit to avoid manipulating its list. So the slab will
> be frozen only when activate use and be unfrozen only when deactivate.

Interesting solution! I wonder if we could go a bit further and remove
acquire_slab() completely. Because AFAICS even after your changes,
acquire_slab() is still attempted including freezing the slab, which means
still doing an cmpxchg_double under the list_lock, and now also handling the
special case when it failed, but we at least filled percpu partial lists.
What if we only filled the partial list without freezing, and then froze the
first slab outside of the list_lock?

Or more precisely, instead of returning the acquired "object" we would
return the first slab removed from partial list. I think it would simplify
the code a bit, and further reduce list_lock holding times.

I'll also point out a few more details, but it's not a full detailed review
as the suggestion above, and another for 4/5, could mean a rather
significant change for v3.

Thanks!

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
> 
> It shows above there is about 10% improvement on stress-ng rawpkt
> testcase, although no much improvement on perf sched bench testcase.
> 
> Thanks for any comment and code review!
> 
> Chengming Zhou (6):
>   slub: Keep track of whether slub is on the per-node partial list
>   slub: Prepare __slab_free() for unfrozen partial slab out of node
>     partial list
>   slub: Don't freeze slabs for cpu partial
>   slub: Simplify acquire_slab()
>   slub: Introduce get_cpu_partial()
>   slub: Optimize deactivate_slab()
> 
>  include/linux/page-flags.h |   2 +
>  mm/slab.h                  |  19 +++
>  mm/slub.c                  | 245 +++++++++++++++++++------------------
>  3 files changed, 150 insertions(+), 116 deletions(-)
> 

