Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C247F9C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjK0JNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjK0JKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:10:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774A187
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:10:53 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC4D321B91;
        Mon, 27 Nov 2023 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701076251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvMwrGsBjnXe9bI8YzhMj049OwPDHtYD5qQt/pXYQH8=;
        b=eGaGnJ54mrFpRwB2ko/RrgyZGa2+rJt3C8sjzD9OUPIeWTD5tjYQdSiULlwNt9gfTZNnir
        lmEDqN7KEaI5wAQ0Cw8PF9IhyxdxyDDH6IcBt1pLJaVP6J6qdW+hkIZ9se7+aFA+lNwCXl
        /gQ70/s+4xnaUsakrNZ5VLF50jjqsPQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE3771367B;
        Mon, 27 Nov 2023 09:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id lMWsKBtdZGVOOQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Mon, 27 Nov 2023 09:10:51 +0000
Date:   Mon, 27 Nov 2023 10:10:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZWRdG49vlGzSY_Uj@tiehlicka>
References: <ZVyp5eETLTT0PCYj@tiehlicka>
 <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
 <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
 <ZV3BWZ4ZaD5Rj_HS@tiehlicka>
 <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka>
 <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka>
 <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 2.14
X-Spamd-Result: default: False [2.14 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-0.977];
         NEURAL_SPAM_LONG(2.17)[0.620];
         RCPT_COUNT_SEVEN(0.00)[10];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.23)[72.66%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-11-23 10:34:46, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Thu 23-11-23 14:15:59, Huang, Ying wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> > [...]
> >> > Yes swapcache pages are indeed more complicated but most of the time
> >> > they just go away as well, no?
> >> 
> >> When we swapin a page, we will put it in swapcache too.  And the page
> >> can be in that state for long time if there is more than 50% free space
> >> in the swap device.
> >
> > True, but why is that a problem? If you encounter such a swapped in page
> > on the file LRU then the page should be referened and as such should be
> > activated, no?
> 
> This just means that anonymous pages in file LRU aren't temporary or
> short-term.  So we need to consider that.

Right. On the other hand we could be more aggressive when dropping the
swapcache. Is there any actual reason why we cannot try to folio_free_swap
even when mem_cgroup_swap_full == F?
-- 
Michal Hocko
SUSE Labs
