Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231FC7E5154
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjKHHtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHHtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:49:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF402125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:49:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88FCA21906;
        Wed,  8 Nov 2023 07:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699429759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sfamsY5tQMo15iI3g5wJCazSiiez2z7T2FU7l3Y1bo=;
        b=xbxQDA0oQnPFGGR/mC7uwe+rScD/diz4aeQO1cflsXaNdH3Nl+GfWSTWR+hDwSo+kIxqg2
        dLaBfu9PSWjp2LZ+VgCjTGKxO9wi2H/B7Lynmis1UHICgFMjs4izPOwgH9JXKybvNeSYGw
        3Q2cJDJLIa/ZaY6Q6AFixCXoDgDT6yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699429759;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sfamsY5tQMo15iI3g5wJCazSiiez2z7T2FU7l3Y1bo=;
        b=aqopCXkkJtNHpmvdDMe5ZdlBe0dqj0lwGixuMiMtdQDpdrZYFvia16fOFAUxuVwHj3KEq9
        g32ycUgZP3/wcFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99C92133F5;
        Wed,  8 Nov 2023 07:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VX3RJH49S2VuIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Nov 2023 07:49:18 +0000
Message-ID: <7155f21f-a7e5-cc36-89e5-c1ce257b9420@suse.cz>
Date:   Wed, 8 Nov 2023 08:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 68/86] treewide: mm: remove cond_resched()
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        SeongJae Park <sj@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Hugh Dickins <hughd@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-12-ankur.a.arora@oracle.com>
 <20231108012823.GD11577@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231108012823.GD11577@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 02:28, Sergey Senozhatsky wrote:
> On (23/11/07 15:08), Ankur Arora wrote:
> [..]
>> +++ b/mm/zsmalloc.c
>> @@ -2029,7 +2029,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>>  			dst_zspage = NULL;
>>  
>>  			spin_unlock(&pool->lock);
>> -			cond_resched();
>>  			spin_lock(&pool->lock);
>>  		}
>>  	}
> 
> I'd personally prefer to have a comment explaining why we do that
> spin_unlock/spin_lock sequence, which may look confusing to people.

Wonder if it would make sense to have a lock operation that does the
unlock/lock as a self-documenting thing, and maybe could also be optimized
to first check if there's a actually a need for it (because TIF_NEED_RESCHED
or lock is contended).

> Maybe would make sense to put a nice comment in all similar cases.
> For instance:
> 
>   	rcu_read_unlock();
>  -	cond_resched();
>   	rcu_read_lock();

