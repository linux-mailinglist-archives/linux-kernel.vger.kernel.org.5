Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01FA7F2DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjKUNA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjKUNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:00:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A931BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:00:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F2CF52192D;
        Tue, 21 Nov 2023 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700571622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ENH/10FZxHe1EFz0Z49wUOO+GPWUvmASlOlk4QldG+8=;
        b=rYdiJfglM2lxJkg5FvmnBmTB9K+CeB2vdLdsXpcRxh2qr/bixeKfsWAqNPzCtE8tOabYr5
        op3ugt38ztywBKOM6/mBpAkFAVgHEHPulCGNMDWI0zyqvez++Y+/PCu2crL6BIAcdbx+Cm
        ejaViwHbrGGWHZN1x8dTv5NguMxLv20=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C599E139FD;
        Tue, 21 Nov 2023 13:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nqMrLeWpXGVkIgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 21 Nov 2023 13:00:21 +0000
Date:   Tue, 21 Nov 2023 14:00:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZVyp5eETLTT0PCYj@tiehlicka>
References: <20231121090624.1814733-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121090624.1814733-1-liushixin2@huawei.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.60
X-Spamd-Result: default: False [-1.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_SEVEN(0.00)[10];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[16.91%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-11-23 17:06:24, Liu Shixin wrote:
> When spaces of swap devices are exhausted, only file pages can be
> reclaimed.  But there are still some swapcache pages in anon lru list.
> This can lead to a premature out-of-memory.
> 
> The problem is found with such step:
> 
>  Firstly, set a 9MB disk swap space, then create a cgroup with 10MB
>  memory limit, then runs an program to allocates about 15MB memory.
> 
> The problem occurs occasionally, which may need about 100 times [1].
> 
> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
> If the number is not zero, return true and set swapcache_only to 1.
> When scan anon lru list in swapcache_only mode, non-swapcache pages will
> be skipped to isolate in order to accelerate reclaim efficiency.
> 
> However, in swapcache_only mode, the scan count still increased when scan
> non-swapcache pages because there are large number of non-swapcache pages
> and rare swapcache pages in swapcache_only mode, and if the non-swapcache
> is skipped and do not count, the scan of pages in isolate_lru_folios() can
> eventually lead to hung task, just as Sachin reported [2].

I find this paragraph really confusing! I guess what you meant to say is
that a real swapcache_only is problematic because it can end up not
making any progress, correct? 

AFAIU you have addressed that problem by making swapcache_only anon LRU
specific, right? That would be certainly more robust as you can still
reclaim from file LRUs. I cannot say I like that because swapcache_only
is a bit confusing and I do not think we want to grow more special
purpose reclaim types. Would it be possible/reasonable to instead put
swapcache pages on the file LRU instead?
-- 
Michal Hocko
SUSE Labs
