Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339147EE3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbjKPPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjKPPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:13:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B9AD;
        Thu, 16 Nov 2023 07:13:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 436AA20503;
        Thu, 16 Nov 2023 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700147626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bJu6ar+NFH85UXuEOe3UdmDdKsVbVBwLjldg6odnbE=;
        b=KBUpa6RVruZ7aq0x9p3TFQAw3/YKqjTia0me50aAIDA9NdaPrjaR0MDKXzXBUgB1QAivGt
        gW0zd6jW3NDSvaNgjd43oXqok/khlpyQNg8FH2b0cpyCUhDsf90nsgdMuDuJkhSy3e6Dta
        /e0wUdhYD5dLN0MpZprWuPTEXGGy5Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700147626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bJu6ar+NFH85UXuEOe3UdmDdKsVbVBwLjldg6odnbE=;
        b=F0syKVjCMRFmcjEJ7ZV+IVTO/sZ1LPXCBRunywy1u77HSxa7Xcw1oHNPo923/94kZLHqT/
        aD4mJoLH9R9KTbBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D2A31377E;
        Thu, 16 Nov 2023 15:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tuZbBqoxVmVqTAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Nov 2023 15:13:46 +0000
Message-ID: <310cde93-50c1-4758-865b-4432ab3f3f12@suse.cz>
Date:   Thu, 16 Nov 2023 16:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: kmem: properly initialize local objcg variable in
 current_obj_cgroup()
Content-Language: en-US
To:     Erhard Furtner <erhard_f@mailbox.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>, stable@vger.kernel.org
References: <20231116025109.3775055-1-roman.gushchin@linux.dev>
 <4bd106d5-c3e3-6731-9a74-cff81e2392de@suse.cz> <20231116155627.3686da61@yea>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231116155627.3686da61@yea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 15:56, Erhard Furtner wrote:
> On Thu, 16 Nov 2023 08:04:18 +0100
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 11/16/23 03:51, Roman Gushchin wrote:
>> > Actually the problem is caused by uninitialized local variable in
>> > current_obj_cgroup(). If the root memory cgroup is set as an active
>> > memory cgroup for a charging scope (as in the trace, where systemd
>> > tries to create the first non-root cgroup, so the parent cgroup is
>> > the root cgroup), the "for" loop is skipped and uninitialized objcg is
>> > returned, causing a panic down the accounting stack.
>> > 
>> > The fix is trivial: initialize the objcg variable to NULL
>> > unconditionally before the "for" loop.
>> > 
>> > Fixes: e86828e5446d ("mm: kmem: scoped objcg protection")
>> > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1959
>> > Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
>> > Cc: Shakeel Butt <shakeelb@google.com>
>> > Cc: Vlastimil Babka <vbabka@suse.cz>
>> > Cc: David Rientjes <rientjes@google.com>
>> > Cc: Dennis Zhou <dennis@kernel.org>
>> > Cc: Johannes Weiner <hannes@cmpxchg.org>
>> > Cc: Michal Hocko <mhocko@kernel.org>
>> > Cc: Muchun Song <muchun.song@linux.dev>
>> > Cc: stable@vger.kernel.org  
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> We could also do this to make it less confusing?
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 774bd6e21e27..a08bcec661b6 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3175,7 +3175,6 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
>>  		objcg = rcu_dereference_check(memcg->objcg, 1);
>>  		if (likely(objcg))
>>  			break;
>> -		objcg = NULL;
>>  	}
>>  
>>  	return objcg;
>> 
>> 
> 
> I can confirm the 1st patch from Roman fixes the issue on my amd64 and on my i686 box.

Good.

> The 2nd patch from Vlastimil unfortunately does not (only tried on amd64).

Ah no, I meant mine as an additional related cleanup that's related enough
that it can be part of Roman's fix. But it's not a fix on its own.
> Regards,
> Erhard

