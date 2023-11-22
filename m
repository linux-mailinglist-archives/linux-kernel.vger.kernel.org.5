Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6259F7F4503
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbjKVLkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbjKVLkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:40:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03910CA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:40:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C194421940;
        Wed, 22 Nov 2023 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700653225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNz9iLkKn7NBnkgFmh9fVns7t/+rvtC47m9ioDEBJEE=;
        b=QKYxkVu3bGPR5SufXL4bVsVQo3/mJPnGB82Don8ow1277vxEHKbMmTp/TRYQ/tlJ+o47ai
        0QiaiD8mEDNLe7azEU1x364Yj13Bm3NsTfzAbpKtV0pb9TqbalmlEfsXzklp29gbskbaBn
        zMOkXq/C6JbUa02vHmmQ1h4rvSDSyjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700653225;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNz9iLkKn7NBnkgFmh9fVns7t/+rvtC47m9ioDEBJEE=;
        b=ML2/+Fv1iQw1wYfLZAxqJJ7H8qaqhz4iIsGFTv5ZdecrI+FhyPIKWzb8AqlO5cjqIOlaKx
        GVSGWUpCMSEHvcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FC2E13461;
        Wed, 22 Nov 2023 11:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xgxyHqnoXWWDNwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Nov 2023 11:40:25 +0000
Message-ID: <4ebc67be-8286-17e9-da33-225ed75509a6@suse.cz>
Date:   Wed, 22 Nov 2023 12:40:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Mark Brown <broonie@kernel.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
 <83ff4b9e-94f1-8b35-1233-3dd414ea4dfe@suse.cz>
 <b62a6eee-6823-47e0-a18a-964b60d247cd@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b62a6eee-6823-47e0-a18a-964b60d247cd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         BAYES_HAM(-3.00)[100.00%];
         RCPT_COUNT_TWELVE(0.00)[13];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com,infradead.org];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 12:35, Chengming Zhou wrote:
> On 2023/11/22 17:37, Vlastimil Babka wrote:
>> On 11/20/23 19:49, Mark Brown wrote:
>>> On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrote:
>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>
>>>> Now we will freeze slabs when moving them out of node partial list to
>>>> cpu partial list, this method needs two cmpxchg_double operations:
>>>>
>>>> 1. freeze slab (acquire_slab()) under the node list_lock
>>>> 2. get_freelist() when pick used in ___slab_alloc()
>>>
>>> Recently -next has been failing to boot on a Raspberry Pi 3 with an arm
>>> multi_v7_defconfig and a NFS rootfs, a bisect appears to point to this
>>> patch (in -next as c8d312e039030edab25836a326bcaeb2a3d4db14) as having
>>> introduced the issue.  I've included the full bisect log below.
>>>
>>> When we see problems we see RCU stalls while logging in, for example:
>> 
>> Can you try this, please?
>> 
> 
> Great! I manually disabled __CMPXCHG_DOUBLE to reproduce the problem,
> and this patch can solve the machine hang problem.
> 
> BTW, I also did the performance testcase on the machine with 128 CPUs.
> 
> stress-ng --rawpkt 128 --rawpkt-ops 100000000
> 
> base    patched
> 2.22s   2.35s
> 2.21s   3.14s
> 2.19s   4.75s
> 
> Found this atomic version performance numbers are not stable.

That's weirdly too bad. Is that measured also with __CMPXCHG_DOUBLE
disabled, or just the patch? The PG_workingset flag change should be
uncontended as we are doing it under list_lock, and with __CMPXCHG_DOUBLE
there should be no interfering PG_locked interference.

