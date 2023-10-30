Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C848A7DBD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjJ3QT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3QTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:19:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484183
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:19:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A8D91F7AB;
        Mon, 30 Oct 2023 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698682761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65hZX46Ldjh7QmsBFkrp85EMDRFAD6ANd/SR2JZsnB8=;
        b=YYItWmNlj7SP9sHM3ZodJJP8W9ZQJv0Za/vMl5JwLF4poelmVIwNVrvse1+kGH+cBJWyPD
        jE53ki2zlLkK0CT/tTMMvBUyXSr63b41coyw4Mf4Vcn31W+tfn3o9KvzycsY4IA+K37pqT
        gICuF+4mjGlcq6XR2gTnmrLiW/sL+Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698682761;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65hZX46Ldjh7QmsBFkrp85EMDRFAD6ANd/SR2JZsnB8=;
        b=vSXenXUTDOsD9EA2QUBG8rlM9M52i+HkCUmmdEgXFGSZc6Y3QevVZZ+OOC9pic17IVUWW0
        pPdccO8IP3okpWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63DF613A8C;
        Mon, 30 Oct 2023 16:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LSuqF4nXP2V5CQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 30 Oct 2023 16:19:21 +0000
Message-ID: <04cbf4cd-3f62-9068-b4fd-c90158f2f116@suse.cz>
Date:   Mon, 30 Oct 2023 17:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Christoph Lameter <cl@linux.com>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com>
 <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 04:36, Chengming Zhou wrote:
>> 
>> 
>> After this patch the PG_workingset indicates the state of being on the partial lists.
>> 
>> What does "frozen slab" then mean? The slab is being allocated from? Is that information useful or can we drop the frozen flag?
> 
> Right, frozen slab is the cpu slab, which is being allocated from by the cpu that froze it.
> 
> IMHO, the "frozen" bit is useful because:
> 
> 1. PG_workingset is only useful on partial slab, which indicates the slab is on the node
>    partial list, so we can manipulate its list in the __slab_free() path.
> 
> 2. But for full slab (slab->freelist == NULL), PG_workingset is not much useful, we don't
>    safely know whether it's used as the cpu slab or not just from this flag. So __slab_free()
>    still rely on the "frozen" bit to know it.

Well, we could extend the meaning of PG_workingset to mean "not a cpu slab
or pecpu partial slab" i.e. both on node partial list and full. However it
would increase the number of cases where __slab_free() has to lock the
list_lock and check the PG_working set. "slab->freelist == NULL" might
happen often exactly because the freelist became cpu freelist.

> 3. And the maintaining of "frozen" has no extra cost now, since it's changed together with "freelist"
>    and other counter using cmpxchg, we already have the cmpxchg when start to use a slab as the cpu slab.

And together with this point, I don't see a reason to drop the frozen bit.
It's still useful for cpu slabs. It just wasn't the best possible solution
for percpu partial slabs.

> Maybe I missed something, I don't know how to drop the frozen flag.

Should be possible, but not worth it IMHO.

>> 
>> Update the definition?
>> 
> 
> Ok, will add a cleanup patch to update.
> 
> Thanks!

