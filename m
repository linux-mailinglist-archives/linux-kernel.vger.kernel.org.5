Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517A7792D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbjIESJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbjIESIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:08:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD346B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:05:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 223FE1FF15;
        Tue,  5 Sep 2023 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693932750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOpVu7FAOAEi5tGhm2bC+pLU4kK9U5QMp8h4plkfkCw=;
        b=J5YtlzzVXcyQV0r8CRdJm1gnoBob18A/TUUHboh+j8xe6v38f3Chh2ErOYdvQ3l1oNWSIL
        l/+jJjDIMr5nXiYraB2pJTcPEaEJCGGwPMU96G6HvbtOLbwQXudPFwRihPKJDaf4KV9EKD
        U+TUO7RpamQIfIVdIKNNmRMk7jRu7bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693932750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOpVu7FAOAEi5tGhm2bC+pLU4kK9U5QMp8h4plkfkCw=;
        b=iRWdCeE3AAkYPWf+EIZGFDvyrqgqLNWIs2FJZwd397dsDrooM5aWKFWho9Ksf5NN8Rq6xx
        Nqy4aDOXR5r3AtBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDFFC13911;
        Tue,  5 Sep 2023 16:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fuUqOc1c92TGJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Sep 2023 16:52:29 +0000
Message-ID: <703e284d-186a-5699-f06c-761e51115ae0@suse.cz>
Date:   Tue, 5 Sep 2023 18:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] mm: fix draining remote pageset
Content-Language: en-US
To:     "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230811090819.60845-1-ying.huang@intel.com>
 <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
 <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZNxxaFnM9W8+imHD@dhcp22.suse.cz>
 <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOMYb27IulTpDFpe@dhcp22.suse.cz>
 <87v8d8dch1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOMuCiZ07N+L/ljG@dhcp22.suse.cz>
 <87msykc9ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZORtHmDeDCMcCb7Q@dhcp22.suse.cz>
 <94b0e0c6-a626-46a1-e746-a336d20cdc08@os.amperecomputing.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <94b0e0c6-a626-46a1-e746-a336d20cdc08@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 19:06, Lameter, Christopher wrote:
> On Tue, 22 Aug 2023, Michal Hocko wrote:
> 
>> Yes, this doesn't really show any actual correctness problem so I do not
>> think this is sufficient to change the code. You would need to show that
>> the existing behavior is actively harmful.
> 
> Having some pages from a remote NUMA node stuck in a pcp somewhere is 
> making that memory unusable. It is usually rate that these remote pages 
> are needed again and so they may remain there for a long time if the 
> situation is right.
> 
> And he is right that the intended behavior of freeing the remote pages 
> has been disabled by the patch.
> 
> So I think there is sufficient rationale to apply these fixes.

I wonder if this the optimum way to handle the NOHZ case? IIUC there we use
quiet_vmstat() to call refresh_cpu_vm_stats(). I'd expect if there were
pending remote pages to flush, it would be best to do it immediately, and
not keep a worker being requeued and only do that after the pcp->expires
goes zero.

However quiet_vmstat() even calls the refresh with do_pagesets == false. Why
do we even refresh the stats at that moment if the delayed update is pending
anyway? And could we maybe make sure that in that case the flush is done on
the first delayed update in that case and not expiring like this?
