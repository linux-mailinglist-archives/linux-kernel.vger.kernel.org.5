Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA967A41BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjIRHIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbjIRHIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:08:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D300D2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:07:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A78A521863;
        Mon, 18 Sep 2023 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695020873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZF/+oaEMMum4fNtySMS0TbtMv5W3qRUOaMV7CUK+Pfo=;
        b=Yo5U62H7Mu6PomECV37NndMZV88Ny6ZXstJMoCUOBIya+np3Mh+Oug0bWLI9594d2CMUDJ
        beTk38Vz8U1AxQoYxLDK/VlkkkUI+1ZY6p5hxoK0l5t2jdA2Th8YWefk/ve7Vqt+auo7yD
        69hmPacwFOSJdNy9nE63G8sNzvurxZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695020873;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZF/+oaEMMum4fNtySMS0TbtMv5W3qRUOaMV7CUK+Pfo=;
        b=iX3ePRuXYc1H9ClVQ1O/726rnZiSMe7GURPdUYdkNbs0lk1VUPYopo7ClEK+QY1kZIep5S
        n+6K+nQebH/MlzBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8198E13480;
        Mon, 18 Sep 2023 07:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9ojXHkn3B2XESgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 18 Sep 2023 07:07:53 +0000
Message-ID: <b344c125-af3b-f4a3-4630-40cc5bd539e7@suse.cz>
Date:   Mon, 18 Sep 2023 09:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey> <20230915141610.GA104956@cmpxchg.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230915141610.GA104956@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 16:16, Johannes Weiner wrote:
> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
>> In next-20230913, I started hitting the following BUG.  Seems related
>> to this series.  And, if series is reverted I do not see the BUG.
>> 
>> I can easily reproduce on a small 16G VM.  kernel command line contains
>> "hugetlb_free_vmemmap=on hugetlb_cma=4G".  Then run the script,
>> while true; do
>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>> done
>> 
>> For the BUG below I believe it was the first (or second) 1G page creation from
>> CMA that triggered:  cma_alloc of 1G.
>> 
>> Sorry, have not looked deeper into the issue.
> 
> Thanks for the report, and sorry about the breakage!
> 
> I was scratching my head at this:
> 
>                         /* MIGRATE_ISOLATE page should not go to pcplists */
>                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> 
> because there is nothing in page isolation that prevents setting
> MIGRATE_ISOLATE on something that's on the pcplist already. So why
> didn't this trigger before already?
> 
> Then it clicked: it used to only check the *pcpmigratetype* determined
> by free_unref_page(), which of course mustn't be MIGRATE_ISOLATE.
> 
> Pages that get isolated while *already* on the pcplist are fine, and
> are handled properly:
> 
>                         mt = get_pcppage_migratetype(page);
> 
>                         /* MIGRATE_ISOLATE page should not go to pcplists */
>                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> 
>                         /* Pageblock could have been isolated meanwhile */
>                         if (unlikely(isolated_pageblocks))
>                                 mt = get_pageblock_migratetype(page);
> 
> So this was purely a sanity check against the pcpmigratetype cache
> operations. With that gone, we can remove it.

Agreed, I assume you'll fold it in 1/6 in v3.

