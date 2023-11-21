Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C527F44DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjKVLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856DE18C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700652252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FKyJjqN4yB5dEQXOJ/hPSQkG+aJnTkBN/bXtW33LM8I=;
        b=WhRgNPUeEmwUO6ffrhg7weAaLvJBy75e1AKHL6qNQREv1RcXKGVuKbQJUU72aJOICq09Tz
        RL92vL+f1CetEbXF0aFAoGGNDa4qHlH9NKxgJ+0Hxar/Ix1d7awdXfYfW8OO9NLHwP53Qf
        ntmhvQyCrpWMjy/batcSRVNmP14JK2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-UYTsx_zkOiKtykoe-8kyvA-1; Wed, 22 Nov 2023 06:24:09 -0500
X-MC-Unique: UYTsx_zkOiKtykoe-8kyvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2700C8007B3;
        Wed, 22 Nov 2023 11:24:09 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFA5B40C6EBB;
        Wed, 22 Nov 2023 11:24:08 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id CB4E2400DEE3E; Tue, 21 Nov 2023 10:35:21 -0300 (-03)
Date:   Tue, 21 Nov 2023 10:35:21 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 0/2] mm: too_many_isolated can stall due to out of sync
 VM counters
Message-ID: <ZVyyGfEBmN5+Df0L@tpad>
References: <20231113233420.446465795@redhat.com>
 <ZVMtuYLviLYqAI7x@tiehlicka>
 <ZVNnjVdeNblG1l8t@tpad>
 <ZVNsMVPJ5y8C_hBC@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVNsMVPJ5y8C_hBC@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 01:46:41PM +0100, Michal Hocko wrote:
> On Tue 14-11-23 09:26:53, Marcelo Tosatti wrote:
> > Hi Michal,
> > 
> > On Tue, Nov 14, 2023 at 09:20:09AM +0100, Michal Hocko wrote:
> > > On Mon 13-11-23 20:34:20, Marcelo Tosatti wrote:
> > > > A customer reported seeing processes hung at too_many_isolated,
> > > > while analysis indicated that the problem occurred due to out
> > > > of sync per-CPU stats (see below).
> > > > 
> > > > Fix is to use node_page_state_snapshot to avoid the out of stale values.
> > > > 
> > > > 2136 static unsigned long
> > > >     2137 shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
> > > >     2138                      struct scan_control *sc, enum lru_list lru)
> > > >     2139 {
> > > >     :
> > > >     2145         bool file = is_file_lru(lru);
> > > >     :
> > > >     2147         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > > >     :
> > > >     2150         while (unlikely(too_many_isolated(pgdat, file, sc))) {
> > > >     2151                 if (stalled)
> > > >     2152                         return 0;
> > > >     2153
> > > >     2154                 /* wait a bit for the reclaimer. */
> > > >     2155                 msleep(100);   <--- some processes were sleeping here, with pending SIGKILL.
> > > >     2156                 stalled = true;
> > > >     2157
> > > >     2158                 /* We are about to die and free our memory. Return now. */
> > > >     2159                 if (fatal_signal_pending(current))
> > > >     2160                         return SWAP_CLUSTER_MAX;
> > > >     2161         }
> > > > 
> > > > msleep() must be called only when there are too many isolated pages:
> > > 
> > > What do you mean here?
> > 
> > That msleep() must not be called when
> > 
> > isolated > inactive
> > 
> > is false.
> 
> Well, but the code is structured in a way that this is simply true.
> too_many_isolated might be false positive because it is a very loose
> interface and the number of isolated pages can fluctuate depending on
> the number of direct reclaimers.

OK

>  
> > > >     2019 static int too_many_isolated(struct pglist_data *pgdat, int file,
> > > >     2020                 struct scan_control *sc)
> > > >     2021 {
> > > >     :
> > > >     2030         if (file) {
> > > >     2031                 inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
> > > >     2032                 isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
> > > >     2033         } else {
> > > >     :
> > > >     2046         return isolated > inactive;
> > > > 
> > > > The return value was true since:
> > > > 
> > > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_INACTIVE_FILE]
> > > >     $8 = {
> > > >       counter = 1
> > > >     }
> > > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_ISOLATED_FILE]
> > > >     $9 = {
> > > >       counter = 2
> > > > 
> > > > while per_cpu stats had:
> > > > 
> > > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->per_cpu_nodestats
> > > >     $85 = (struct per_cpu_nodestat *) 0xffff8000118832e0
> > > >     crash> p/x 0xffff8000118832e0 + __per_cpu_offset[42]
> > > >     $86 = 0xffff00917fcc32e0
> > > >     crash> p ((struct per_cpu_nodestat *) 0xffff00917fcc32e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
> > > >     $87 = -1 '\377'
> > > > 
> > > >     crash> p/x 0xffff8000118832e0 + __per_cpu_offset[44]
> > > >     $89 = 0xffff00917fe032e0
> > > >     crash> p ((struct per_cpu_nodestat *) 0xffff00917fe032e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
> > > >     $91 = -1 '\377'
> > > 
> > > This doesn't really tell much. How much out of sync they really are
> > > cumulatively over all cpus?
> > 
> > This is the cumulative value over all CPUs (offsets for other CPUs 
> > have been omitted since they are zero).
> 
> OK, so that means the NR_ISOLATED_FILE is 0 while NR_INACTIVE_FILE is 1,
> correct? If that is the case then the value is indeed outdated but it
> also means that the NR_INACTIVE_FILE is so small that all but 1 (resp. 2
> as kswapd is never throttled) reclaimers will be stalled anyway. So does
> the exact snapshot really help? 

By looking at the data:

 >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_INACTIVE_FILE]
 >     $8 = {
 >       counter = 1
 >     }
 >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_ISOLATED_FILE]
 >     $9 = {
 >       counter = 2
 > 
 > while per_cpu stats had:
 > 
 >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->per_cpu_nodestats
 >     $85 = (struct per_cpu_nodestat *) 0xffff8000118832e0
 >     crash> p/x 0xffff8000118832e0 + __per_cpu_offset[42]
 >     $86 = 0xffff00917fcc32e0
 >     crash> p ((struct per_cpu_nodestat *) 0xffff00917fcc32e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
 >     $87 = -1 '\377'
 > 
 >     crash> p/x 0xffff8000118832e0 + __per_cpu_offset[44]
 >     $89 = 0xffff00917fe032e0
 >     crash> p ((struct per_cpu_nodestat *) 0xffff00917fe032e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
 >     $91 = -1 '\377'

Actual-Value = Global-Counter + CPU0.delta + CPU1.delta + ... + CPUn.delta

Nr-Isolated-File = Nr-Isolated-Global + CPU0.delta-isolated + CPU1.delta-isolated + ... + CPUn.delta-isolated
Nr-Inactive-File = Nr-Inactive-Global + CPU0.delta-inactive + CPU1.delta-inactive + ... + CPUn.delta-inactive

With outdated values: 
====================

Nr-Isolated-File = 2
Nr-Inactive-File = 1

Therefore isolated > inactive, since 2 > 1.

Without outdated values (snapshot):
==================================

Nr-Isolated-File = 2 - 1 - 1 = 0
Nr-Inactive-File = 1

> Do you have any means to reproduce this
> behavior and see that the patch actually changed the behavior?

No, because its not easy to test patches on the system where this was
reproduced.

However, the calculations above seem pretty unambiguous, showing that
the snapshot would fix the problem.

> [...]
> 
> > > With a very low NR_FREE_PAGES and many contending allocation the system
> > > could be easily stuck in reclaim. What are other reclaim
> > > characteristics? 
> > 
> > I can ask. What information in particular do you want to know?
> 
> When I am dealing with issues like this I heavily rely on /proc/vmstat
> counters and pgscan, pgsteal counters to see whether there is any
> progress over time.

I understand your desire for additional data, can try to grab it 
(or create a synthetic configuration where this problem is
reproducible).

However, given the calculations above, it is clear that one problem is the 
out of sync counters. Don't you agree?

> > > Is the direct reclaim successful? 
> > 
> > Processes are stuck in too_many_isolated (unnecessarily). What do you mean when you ask
> > "Is the direct reclaim successful", precisely?
> 
> With such a small LRU list it is quite likely that many processes will
> be competing over last pages on the list while rest will be throttled
> because there is nothing to reclaim. It is quite possible that all
> reclaimers will be waiting for a single reclaimer (either kswapd or
> other direct reclaimer).

Sure, but again, the calculations above show that processes are stuck
on too_many_isolated (and the proposed fix will address that situation).

>  I would like to understand whether the system
> is stuck in unproductive state where everybody just waits until the
> counter is synced or everything just progress very slowly because of the
> small LRU. 

OK.

