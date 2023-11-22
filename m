Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9D7F4092
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjKVIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:52:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925FF9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:52:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4708621892;
        Wed, 22 Nov 2023 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700643162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2mz72/0LNu+bIFSthGKo7T7+u/FI1qMvNujptLPaEzM=;
        b=C5+T2qlzNJFAC60Ee9b6iI/4vzhtDlTPtRrXFH4s5BWkBeVy9J9yWsBn0BJNc4HoyjKuaw
        x4SQ6urKn2C8/ibjIr1tGziXb8lQ/jRhYUjYihOiNUIzzlDiGSUZ23mmcAhQ6/WDg3uPXL
        8qE/4nbVLYRaWm3t8vGRFiuKyx14AZg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16F28139FD;
        Wed, 22 Nov 2023 08:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VVosA1rBXWXiYgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Nov 2023 08:52:42 +0000
Date:   Wed, 22 Nov 2023 09:52:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Liu Shixin <liushixin2@huawei.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZV3BWZ4ZaD5Rj_HS@tiehlicka>
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <ZVyp5eETLTT0PCYj@tiehlicka>
 <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
 <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-0.997];
         RCPT_COUNT_SEVEN(0.00)[10];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-11-23 22:44:32, Yosry Ahmed wrote:
> On Tue, Nov 21, 2023 at 10:41 PM Liu Shixin <liushixin2@huawei.com> wrote:
> >
> >
> > On 2023/11/21 21:00, Michal Hocko wrote:
> > > On Tue 21-11-23 17:06:24, Liu Shixin wrote:
> > >
> > > However, in swapcache_only mode, the scan count still increased when scan
> > > non-swapcache pages because there are large number of non-swapcache pages
> > > and rare swapcache pages in swapcache_only mode, and if the non-swapcache
> > > is skipped and do not count, the scan of pages in isolate_lru_folios() can
> > > eventually lead to hung task, just as Sachin reported [2].
> > > I find this paragraph really confusing! I guess what you meant to say is
> > > that a real swapcache_only is problematic because it can end up not
> > > making any progress, correct?
> > This paragraph is going to explain why checking swapcache_only after scan += nr_pages;
> > >
> > > AFAIU you have addressed that problem by making swapcache_only anon LRU
> > > specific, right? That would be certainly more robust as you can still
> > > reclaim from file LRUs. I cannot say I like that because swapcache_only
> > > is a bit confusing and I do not think we want to grow more special
> > > purpose reclaim types. Would it be possible/reasonable to instead put
> > > swapcache pages on the file LRU instead?
> > It looks like a good idea, but I'm not sure if it's possible. I can try it, is there anything to
> > pay attention to?
> 
> I think this might be more intrusive than we think. Every time a page
> is added to or removed from the swap cache, we will need to move it
> between LRUs. All pages on the anon LRU will need to go through the
> file LRU before being reclaimed. I think this might be too big of a
> change to achieve this patch's goal.

TBH I am not really sure how complex that might turn out to be.
Swapcache tends to be full of subtle issues. So you might be right but
it would be better to know _why_ this is not possible before we end up
phising for couple of swapcache pages on potentially huge anon LRU to
isolate them. Think of TB sized machines in this context.

-- 
Michal Hocko
SUSE Labs
