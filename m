Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B227D49D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjJXITS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:19:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F948F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:19:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8724B21888;
        Tue, 24 Oct 2023 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698135553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bKhT6DWHAl4xdjKeEqFwPa3uxBHETJeq/QKHVPucw0=;
        b=zT6M7EhfSz1JGoBWmacLdEZrGLoa36NoKYRTZLeHc/Isp7CWC2pO8G5bn38tRZUKcQj2lw
        NbLAcAxtwphqqfOz3SmA8OLpSZqV24XeAMDdLuCTU/Pvk+D9NKWri2Iw7R5lPWY5CcfGq+
        +kjLkuuld6Ec8dVbSRNrrjA2tDzJP2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698135553;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bKhT6DWHAl4xdjKeEqFwPa3uxBHETJeq/QKHVPucw0=;
        b=6ZnyPIiGw4N0eEiLD8CLoZjS48DJxau+hlnOgqe6Z3WU1L8ZE51UnZe5BuiHc1fTMVkfiY
        PiKnt3AEkR8LlWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4492B134F5;
        Tue, 24 Oct 2023 08:19:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6aEMEAF+N2WbXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 24 Oct 2023 08:19:13 +0000
Message-ID: <dccaf41a-96d1-5c37-ccf2-8971d68f8a23@suse.cz>
Date:   Tue, 24 Oct 2023 10:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
To:     "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc:     chengming.zhou@linux.dev, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, willy@infradead.org,
        pcc@google.com, tytso@mit.edu, maz@kernel.org,
        ruansy.fnst@fujitsu.com, vishal.moola@gmail.com,
        lrh2000@pku.edu.cn, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
 <fcb9b7f0-fb21-cce8-d452-766a5cc73d4a@gentwo.org>
 <ba3d6ac7-6900-3e8d-46b5-8302ca61f8ef@suse.cz>
 <c6f12967-e7bc-bf36-9c6b-0111dea1f0de@gentwo.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <c6f12967-e7bc-bf36-9c6b-0111dea1f0de@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.55
X-Spamd-Result: default: False [-7.55 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FREEMAIL_CC(0.00)[linux.dev,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com,infradead.org,mit.edu,fujitsu.com,pku.edu.cn,vger.kernel.org,kvack.org,bytedance.com];
         BAYES_HAM(-0.95)[86.57%];
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

On 10/23/23 23:05, Christoph Lameter (Ampere) wrote:
> On Mon, 23 Oct 2023, Vlastimil Babka wrote:
> 
>>> For much of the frozen handling we must be holding the node list lock
>>> anyways in order to add/remove from the list. So we already have a lock
>>> that could be used to protect flag operations.
>>
>> I can see the following differences between the traditional frozen bit and
>> the new flag:
>>
>> frozen bit advantage:
>> - __slab_free() on an already-frozen slab can ignore list operations and
>> list_lock completely
>>
>> frozen bit disadvantage:
>> - acquire_slab() trying to do cmpxchg_double() under list_lock (see commit
>> 9b1ea29bc0d7)
> 
> 
> Ok so a slab is frozen if either of those conditions are met. That gets a 
> bit complicated to test for. Can we just get away with the 
> slab_node_partial flag?

Might be worth trying, but I'd try only as a next separate step. I think
freezing the slab that becomes cpu slab (not partial cpu) still has benefits
and no extra cost as that's when we're doing the cmpxchg_double anyway. And
the complicated tests are confined to __slab_free() and it's not *that* bad
IMHO, one condition checks for was_frozen, another for slab_test_node_partial().

> The advantage with the frozen state is that it can be changed with a 
> cmpxchg together with some other values (list pointer, counter) that need 
> updating at free and allocation.

Exactly, but for taking a slab off the node partial list we don't need to
deal with those, so that's where it makes sense to delay the frozen bit
handling.

> But frozen updates are rarer so maybe its worth to completely drop the 
> frozen bit. If both need to be updates then we would have two atomic ops. 
> One is the cmpxchg and the other the operation on the page flag.

The flag update doesn't even have to be atomic as it's only done under
list_lock.
