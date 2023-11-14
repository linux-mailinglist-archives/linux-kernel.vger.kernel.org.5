Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8123E7EB7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjKNUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:19:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D3DD;
        Tue, 14 Nov 2023 12:19:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3FBE204B3;
        Tue, 14 Nov 2023 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699993174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3thwfoQDfeifa7EY/gfWpuitk2l6esZhSluo1Ku2wH4=;
        b=iu/6NjlVN5NFSilQN7ZoYCJuLCC3uVthk+mX2QuFGTo0BmAGYlEQj4aln8tcDpKIT+k3zm
        v9HAotOdzG7LGEg/MA43shkitx2zL82zmSjNLu4chRkCCovphjzrQ5fmLdeaml0u1JZ3I+
        mTDZM3fFmZEO+KgCT1Qt5j4LrI51LIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699993174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3thwfoQDfeifa7EY/gfWpuitk2l6esZhSluo1Ku2wH4=;
        b=P7RIBxhuxDjqiorpec9tzG+cqKzjTW8Zpdi03dqBmIoScedR1cQKItIwWfXg5+iIGHxZJ3
        RXbxtXDF1YHa7IDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86CDC13460;
        Tue, 14 Nov 2023 20:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rTEeIFbWU2VBXAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Nov 2023 20:19:34 +0000
Message-ID: <1bbabb8a-02c8-7247-0084-776a32558130@suse.cz>
Date:   Tue, 14 Nov 2023 21:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/20] mm/slab: remove CONFIG_SLAB code from slab common
 code
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-28-vbabka@suse.cz> <202311132024.80A0D5D58@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202311132024.80A0D5D58@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.66
X-Spamd-Result: default: False [-2.66 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MID_RHS_MATCH_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         BAYES_HAM(-0.06)[61.44%];
         RCPT_COUNT_TWELVE(0.00)[23];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,gmail.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,arm.com,cmpxchg.org,googlegroups.com];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 05:30, Kees Cook wrote:
> On Mon, Nov 13, 2023 at 08:13:47PM +0100, Vlastimil Babka wrote:
>> In slab_common.c and slab.h headers, we can now remove all code behind
>> CONFIG_SLAB and CONFIG_DEBUG_SLAB ifdefs, and remove all CONFIG_SLUB
>> ifdefs.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/slab.h | 13 +--------
>>  mm/slab.h            | 69 ++++----------------------------------------
>>  mm/slab_common.c     | 22 ++------------
>>  3 files changed, 8 insertions(+), 96 deletions(-)
>> 
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 34e43cddc520..90fb1f0d843a 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -24,7 +24,6 @@
>>  
>>  /*
>>   * Flags to pass to kmem_cache_create().
>> - * The ones marked DEBUG are only valid if CONFIG_DEBUG_SLAB is set.
> 
> I think this comment was wrong, yes? i.e. the "DEBUG" flags are also
> used in SLUB?

Hm yeah we could change it to CONFIG_SLUB_DEBUG. I deleted it because I
didn't think "valid" was the right word, they are always valid (part of
SLAB_FLAGS_PERMITTED thus not returning -EINVAL on cache creation), but they
would be no-op (not part of CACHE_CREATE_MASK) without CONFIG_SLUB_DEBUG.

So we coould change it to e.g.
"The ones marked DEBUG are ignored unless CONFIG_SLUB_DEBUG is enabled" ?

> Regardless:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

