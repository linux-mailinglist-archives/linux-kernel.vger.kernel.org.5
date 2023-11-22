Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C437F4312
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjKVKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjKVKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:02:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E5D62
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:02:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49CBB21907;
        Wed, 22 Nov 2023 10:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700647356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V8UXEq4tG3CrvcnhAyz5zGu6O+LKydPLS1VtSC8nRHw=;
        b=nmnKKEyemWfQTDRXkITM5LIaTg5DlCCv+QKEyJ9vjx/Oy7fEYU67YOosnuamLdKXrMi6wY
        rVhDixsmsmj1NmxQjJg5SeZhvCV/N7Ru6goNgBiReXpVfwbcajbDRq1Agx3jWx3PBarm/H
        fomFDLdRmK6VCEFIq9oe3wLUKTNJYoc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DDBE13461;
        Wed, 22 Nov 2023 10:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gdvOOrvRXWXTCQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Nov 2023 10:02:35 +0000
Date:   Wed, 22 Nov 2023 11:02:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        jack@suse.cz, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, shr@devkernel.io, neilb@suse.de
Subject: Re: Question: memcg dirty throttle caused by low per-memcg dirty
 thresh
Message-ID: <ZV3Ru1BmHaU_uW7b@tiehlicka>
References: <109029e0-1772-4102-a2a8-ab9076462454@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109029e0-1772-4102-a2a8-ab9076462454@linux.dev>
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
         RCPT_COUNT_SEVEN(0.00)[9];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[28.26%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 17:38:25, Chengming Zhou wrote:
> Hello all,
> 
> Sorry to bother you, we encountered a problem related to the memcg dirty
> throttle after migrating from cgroup v1 to v2, so want to ask for some
> comments or suggestions.
> 
> 1. Problem
> 
> We have the "containerd" service running under system.slice, with
> its memory.max set to 5GB. It will be constantly throttled in the
> balance_dirty_pages() since the memcg has dirty memory more than
> the memcg dirty thresh.
> 
> We haven't this problem on cgroup v1, because cgroup v1 doesn't have
> the per-memcg writeback and per-memcg dirty thresh. Only the global
> dirty thresh will be checked in balance_dirty_pages().

Yes, v1 didn't have any sensible IO throttling and so we had to rely on
ugly hack to wait for writeback to finish from the memcg memory reclaim
path.  This is really suboptimal because it makes memcg reclaim stalls
hard to predict. So it is essentially only a poor's man OOM prevention.

V2 on the other hand has memcg aware dirty memory throttling which is a
much better solution as it throttles at the moment when the memory is
being dirtied.

Why do you consider that to be a problem? Constant throttling as you
suggest might be a result of the limit being too small?

> 
> 2. Thinking
> 
> So we wonder if we can support the per-memcg dirty thresh interface?
> Now the memcg dirty thresh is just calculated from memcg max * ratio,
> which can be set from /proc/sys/vm/dirty_ratio.

In general I would recommend using dirty_bytes instead as the ratio
doesn't scall all that great on larger systems.
 
> We have to set it to 60 instead of the default 20 to workaround now,
> but worry about the potential side effects.
> 
> If we can support the per-memcg dirty thresh interface, we can set
> some containers to a much higher dirty_ratio, especially for hungry
> dirtier workloads like "containerd".

But why would you want that? If you allow heavy writers to dirty a lot
of memory then flushing that to the backing store will take more time.
That could starve small writers as well because they could end up queued
behind huge amount of data to be flushed.

I am no expert on the writeback so others could give you a better
arguments but from my POV the dirty data flushing and throttling is
mostly a global mechanism to optmize the IO pattern and is a function of
storage much more than workload specific. If you heavy writer hits
throttling too much then either the limit is too low or you should stard
background flushing earlier.

-- 
Michal Hocko
SUSE Labs
