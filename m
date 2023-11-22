Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8A7F48FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjKVOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjKVOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:32:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DEF112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:32:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7096E1F8D7;
        Wed, 22 Nov 2023 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700663571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QulLJuAjDe2Asufg4p5yD55MvlI0qSeHT134XqKCw3Y=;
        b=NQ9RB7202p2264Ce/bOvR4JQ1T94z0e1QmSjkkr1VV6F95mO/huz9G75/lRQmgbS0GZD3m
        +BOKLHk8tOBtHv/V0AbV/CitPEHDjmmnpQjUQIyXyRjg+99Ps5RAgTKVhP0cO39SBf5qI7
        QlLE8ZaXYoN+l7mC0iYxmmEp32ZnNqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700663571;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QulLJuAjDe2Asufg4p5yD55MvlI0qSeHT134XqKCw3Y=;
        b=9NvGlG43r2vPOZw0siR4Ux659MT/mi9V5r6G8Y4Zuf+tYmUUbwTW6I745SQyLFJAZ2vRDc
        JXOrjkIgz5uFC8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4711013461;
        Wed, 22 Nov 2023 14:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E4ypEBMRXmXNCgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Nov 2023 14:32:51 +0000
Message-ID: <675cb5c3-d228-3254-2f11-9d269b0ef6c6@suse.cz>
Date:   Wed, 22 Nov 2023 15:32:50 +0100
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
 <4ebc67be-8286-17e9-da33-225ed75509a6@suse.cz>
 <2af8c92f-0de8-4528-af43-6c6e8c1ebdf3@linux.dev>
 <42867716-5d3d-0252-5fd2-0f8b62498523@suse.cz>
 <325f38f2-1c09-49a0-a882-d1818c2312ae@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <325f38f2-1c09-49a0-a882-d1818c2312ae@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.88
X-Spamd-Result: default: False [-5.88 / 50.00];
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
         BAYES_HAM(-2.08)[95.52%];
         RCPT_COUNT_TWELVE(0.00)[13];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com,infradead.org];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 15:28, Chengming Zhou wrote:
> 
> Yes, it looks so. There are some background services on the 128 CPUs machine.
> Although "stress-ng --rawpkt 128 --rawpkt-ops 100000000" has so much regression,
> I tried other less contented testcases:
> 
> 1. stress-ng --rawpkt 64 --rawpkt-ops 100000000
> 2. perf bench sched messaging -g 5 -t -l 100000
> 
> The performance numbers of this atomic version are pretty much the same.
> 
> So this atomic version should be good in most cases IMHO.

OK will fold the fix using full atomic version.

>>> And I also tested the atomic-optional version like below, found the
>>> performance numbers are much stable.
>> 
>> This gets rather ugly and fragile so I'd maybe rather go back to the
>> __unused field approach :/
>> 
> 
> Agree. If we don't want this atomic version, the __unused field approach
> seems better.
> 
> Thanks!
> 

