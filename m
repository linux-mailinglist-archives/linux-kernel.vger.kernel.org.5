Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB67EB020
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjKNMqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNMqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:46:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCA188
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:46:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D7B51F86A;
        Tue, 14 Nov 2023 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699966002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNAmZc/h0Qn920knBrNSBJHjjOcELL6JYd/Oi6WCTf0=;
        b=RYhjiO6KtHBY6C7PWMVN65uGPd4AWaLtExHAHt3sspPmqvtR6KAVfCErbP9UuWcU2o1wST
        vmkNgB291pJIQSX1Q2wWOhj3jiydp1P/wh/7rtpjEPYYjuzAA1YAO7EJ8GMXeFfmcrIkpF
        ltk06biBkpugwH6HSkAtsB1jQgGjjls=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FBD113416;
        Tue, 14 Nov 2023 12:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f4BwEDJsU2XMdAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 12:46:42 +0000
Date:   Tue, 14 Nov 2023 13:46:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 0/2] mm: too_many_isolated can stall due to out of sync
 VM counters
Message-ID: <ZVNsMVPJ5y8C_hBC@tiehlicka>
References: <20231113233420.446465795@redhat.com>
 <ZVMtuYLviLYqAI7x@tiehlicka>
 <ZVNnjVdeNblG1l8t@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVNnjVdeNblG1l8t@tpad>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -10.60
X-Spamd-Result: default: False [-10.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-11-23 09:26:53, Marcelo Tosatti wrote:
> Hi Michal,
> 
> On Tue, Nov 14, 2023 at 09:20:09AM +0100, Michal Hocko wrote:
> > On Mon 13-11-23 20:34:20, Marcelo Tosatti wrote:
> > > A customer reported seeing processes hung at too_many_isolated,
> > > while analysis indicated that the problem occurred due to out
> > > of sync per-CPU stats (see below).
> > > 
> > > Fix is to use node_page_state_snapshot to avoid the out of stale values.
> > > 
> > > 2136 static unsigned long
> > >     2137 shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
> > >     2138                      struct scan_control *sc, enum lru_list lru)
> > >     2139 {
> > >     :
> > >     2145         bool file = is_file_lru(lru);
> > >     :
> > >     2147         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > >     :
> > >     2150         while (unlikely(too_many_isolated(pgdat, file, sc))) {
> > >     2151                 if (stalled)
> > >     2152                         return 0;
> > >     2153
> > >     2154                 /* wait a bit for the reclaimer. */
> > >     2155                 msleep(100);   <--- some processes were sleeping here, with pending SIGKILL.
> > >     2156                 stalled = true;
> > >     2157
> > >     2158                 /* We are about to die and free our memory. Return now. */
> > >     2159                 if (fatal_signal_pending(current))
> > >     2160                         return SWAP_CLUSTER_MAX;
> > >     2161         }
> > > 
> > > msleep() must be called only when there are too many isolated pages:
> > 
> > What do you mean here?
> 
> That msleep() must not be called when
> 
> isolated > inactive
> 
> is false.

Well, but the code is structured in a way that this is simply true.
too_many_isolated might be false positive because it is a very loose
interface and the number of isolated pages can fluctuate depending on
the number of direct reclaimers.
 
> > >     2019 static int too_many_isolated(struct pglist_data *pgdat, int file,
> > >     2020                 struct scan_control *sc)
> > >     2021 {
> > >     :
> > >     2030         if (file) {
> > >     2031                 inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
> > >     2032                 isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
> > >     2033         } else {
> > >     :
> > >     2046         return isolated > inactive;
> > > 
> > > The return value was true since:
> > > 
> > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_INACTIVE_FILE]
> > >     $8 = {
> > >       counter = 1
> > >     }
> > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_ISOLATED_FILE]
> > >     $9 = {
> > >       counter = 2
> > > 
> > > while per_cpu stats had:
> > > 
> > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->per_cpu_nodestats
> > >     $85 = (struct per_cpu_nodestat *) 0xffff8000118832e0
> > >     crash> p/x 0xffff8000118832e0 + __per_cpu_offset[42]
> > >     $86 = 0xffff00917fcc32e0
> > >     crash> p ((struct per_cpu_nodestat *) 0xffff00917fcc32e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
> > >     $87 = -1 '\377'
> > > 
> > >     crash> p/x 0xffff8000118832e0 + __per_cpu_offset[44]
> > >     $89 = 0xffff00917fe032e0
> > >     crash> p ((struct per_cpu_nodestat *) 0xffff00917fe032e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
> > >     $91 = -1 '\377'
> > 
> > This doesn't really tell much. How much out of sync they really are
> > cumulatively over all cpus?
> 
> This is the cumulative value over all CPUs (offsets for other CPUs 
> have been omitted since they are zero).

OK, so that means the NR_ISOLATED_FILE is 0 while NR_INACTIVE_FILE is 1,
correct? If that is the case then the value is indeed outdated but it
also means that the NR_INACTIVE_FILE is so small that all but 1 (resp. 2
as kswapd is never throttled) reclaimers will be stalled anyway. So does
the exact snapshot really help? Do you have any means to reproduce this
behavior and see that the patch actually changed the behavior?

[...]

> > With a very low NR_FREE_PAGES and many contending allocation the system
> > could be easily stuck in reclaim. What are other reclaim
> > characteristics? 
> 
> I can ask. What information in particular do you want to know?

When I am dealing with issues like this I heavily rely on /proc/vmstat
counters and pgscan, pgsteal counters to see whether there is any
progress over time.

> > Is the direct reclaim successful? 
> 
> Processes are stuck in too_many_isolated (unnecessarily). What do you mean when you ask
> "Is the direct reclaim successful", precisely?

With such a small LRU list it is quite likely that many processes will
be competing over last pages on the list while rest will be throttled
because there is nothing to reclaim. It is quite possible that all
reclaimers will be waiting for a single reclaimer (either kswapd or
other direct reclaimer). I would like to understand whether the system
is stuck in unproductive state where everybody just waits until the
counter is synced or everything just progress very slowly because of the
small LRU. 
-- 
Michal Hocko
SUSE Labs
