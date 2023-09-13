Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9831179E964
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbjIMNes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjIMNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:34:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FFB19B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:34:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F3341F385;
        Wed, 13 Sep 2023 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694612081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+RU0KIou9w9utdTOlx7DUMD1ZLCYn2PIUlTEIwiPpQ=;
        b=aCFCxXd6M2W+F3UzYQaNY77FvUcYJ8khNloHjjQtvOvMWDWoOut6dh0nHef5yWXRhWn1wD
        Wf21nb56OtPECrnLRO+jLxC2Lz/oDags+po3ayu+WQW/Je43EMNMpr2bvSm9xY0oM86Yfu
        uLq/vyzRMBh03DbYk2YRcGGHgCw10CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694612081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+RU0KIou9w9utdTOlx7DUMD1ZLCYn2PIUlTEIwiPpQ=;
        b=l4wqlyRCrqZWIrDDXO1m6/Gv1kjwqx0BpcdarYxHEY5KwbWpK5OeZ6ThGY1Nu8OPyOTBI4
        1TwptIIoeGmSlLBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 539EA13582;
        Wed, 13 Sep 2023 13:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KYO6E3G6AWXLSAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Sep 2023 13:34:41 +0000
Message-ID: <0ab2495b-c110-c1b6-bd37-dbd163412a48@suse.cz>
Date:   Wed, 13 Sep 2023 15:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
 <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
 <20230912145028.GA3228@cmpxchg.org>
 <320c16a7-96b7-65ec-3d80-2eace0ddb290@suse.cz>
 <20230913132412.GA45543@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230913132412.GA45543@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 15:24, Johannes Weiner wrote:
> Hello Vlastimil,
> 
> On Wed, Sep 13, 2023 at 11:33:52AM +0200, Vlastimil Babka wrote:
>> On 9/12/23 16:50, Johannes Weiner wrote:
>> > From 429d13322819ab38b3ba2fad6d1495997819ccc2 Mon Sep 17 00:00:00 2001
>> > From: Johannes Weiner <hannes@cmpxchg.org>
>> > Date: Tue, 12 Sep 2023 10:16:10 -0400
>> > Subject: [PATCH] mm: page_alloc: optimize free_unref_page_list()
>> > 
>> > Move direct freeing of isolated pages to the lock-breaking block in
>> > the second loop. This saves an unnecessary migratetype reassessment.
>> > 
>> > Minor comment and local variable scoping cleanups.
>> 
>> Looks like batch_count and locked_zone could be moved to the loop scope as well.
> 
> Hm they both maintain values over multiple iterations, so I don't
> think that's possible. Am I missing something?

True, disregard :D

>> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> 
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Thanks! I'll send this out properly with your tag.

np!
