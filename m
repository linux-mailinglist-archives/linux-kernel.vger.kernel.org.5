Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085B47F44E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjKVL0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVL0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7E112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700652393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2nxiX3zTK96N3iDK7/DQy2rA2pN7GRHmvt3F8JWaDVo=;
        b=Wb077uZC4OI6Ak2eB/8ot/yEQHiLMdnTq86rEdgAkhJ702iKmBiTlXa6oBQWvQ1ZwNyaJe
        z9JTZYOSwDQEFZU2vWas+8kparx0lEsARwdtCuKLnY5UZPq1YQKd0g7PIShwawO7B8WifH
        PA9Z0WRCXXvzxr7I/4NZm1irU1nXMtc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-xWDN6sCRN1-B6CyhZcZiNw-1; Wed,
 22 Nov 2023 06:26:29 -0500
X-MC-Unique: xWDN6sCRN1-B6CyhZcZiNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7993C1C18CC3;
        Wed, 22 Nov 2023 11:26:29 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DE062166B27;
        Wed, 22 Nov 2023 11:26:29 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 8B600400E56F9; Wed, 22 Nov 2023 08:26:02 -0300 (-03)
Date:   Wed, 22 Nov 2023 08:26:02 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 0/2] mm: too_many_isolated can stall due to out of sync
 VM counters
Message-ID: <ZV3lSttsGq1fuPyG@tpad>
References: <20231113233420.446465795@redhat.com>
 <ZVMtuYLviLYqAI7x@tiehlicka>
 <ZVNnjVdeNblG1l8t@tpad>
 <ZVNsMVPJ5y8C_hBC@tiehlicka>
 <ZV3kxwqedKH+LDum@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV3kxwqedKH+LDum@tpad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:23:51AM -0300, Marcelo Tosatti wrote:
> On Tue, Nov 14, 2023 at 01:46:41PM +0100, Michal Hocko wrote:
> > On Tue 14-11-23 09:26:53, Marcelo Tosatti wrote:
> > > Hi Michal,
> > > 
> > > On Tue, Nov 14, 2023 at 09:20:09AM +0100, Michal Hocko wrote:
> > > > On Mon 13-11-23 20:34:20, Marcelo Tosatti wrote:
> > > > > A customer reported seeing processes hung at too_many_isolated,
> > > > > while analysis indicated that the problem occurred due to out
> > > > > of sync per-CPU stats (see below).
> > > > > 
> > > > > Fix is to use node_page_state_snapshot to avoid the out of stale values.
> > > > > 
> > > > > 2136 static unsigned long
> > > > >     2137 shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
> > > > >     2138                      struct scan_control *sc, enum lru_list lru)
> > > > >     2139 {
> > > > >     :
> > > > >     2145         bool file = is_file_lru(lru);
> > > > >     :
> > > > >     2147         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > > > >     :
> > > > >     2150         while (unlikely(too_many_isolated(pgdat, file, sc))) {
> > > > >     2151                 if (stalled)
> > > > >     2152                         return 0;
> > > > >     2153
> > > > >     2154                 /* wait a bit for the reclaimer. */
> > > > >     2155                 msleep(100);   <--- some processes were sleeping here, with pending SIGKILL.
> > > > >     2156                 stalled = true;
> > > > >     2157
> > > > >     2158                 /* We are about to die and free our memory. Return now. */
> > > > >     2159                 if (fatal_signal_pending(current))
> > > > >     2160                         return SWAP_CLUSTER_MAX;
> > > > >     2161         }
> > > > > 
> > > > > msleep() must be called only when there are too many isolated pages:
> > > > 
> > > > What do you mean here?
> > > 
> > > That msleep() must not be called when
> > > 
> > > isolated > inactive
> > > 
> > > is false.
> > 
> > Well, but the code is structured in a way that this is simply true.
> > too_many_isolated might be false positive because it is a very loose
> > interface and the number of isolated pages can fluctuate depending on
> > the number of direct reclaimers.
> >  
> > > > >     2019 static int too_many_isolated(struct pglist_data *pgdat, int file,
> > > > >     2020                 struct scan_control *sc)
> > > > >     2021 {
> > > > >     :
> > > > >     2030         if (file) {
> > > > >     2031                 inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
> > > > >     2032                 isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
> > > > >     2033         } else {
> > > > >     :
> > > > >     2046         return isolated > inactive;
> > > > > 
> > > > > The return value was true since:
> > > > > 
> > > > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_INACTIVE_FILE]
> > > > >     $8 = {
> > > > >       counter = 1
> > > > >     }
> > > > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_ISOLATED_FILE]
> > > > >     $9 = {
> > > > >       counter = 2
> > > > > 
> > > > > while per_cpu stats had:
> > > > > 
> > > > >     crash> p ((struct pglist_data *) 0xffff00817fffe580)->per_cpu_nodestats
> > > > >     $85 = (struct per_cpu_nodestat *) 0xffff8000118832e0
> > > > >     crash> p/x 0xffff8000118832e0 + __per_cpu_offset[42]
> > > > >     $86 = 0xffff00917fcc32e0
> > > > >     crash> p ((struct per_cpu_nodestat *) 0xffff00917fcc32e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
> > > > >     $87 = -1 '\377'
> > > > > 
> > > > >     crash> p/x 0xffff8000118832e0 + __per_cpu_offset[44]
> > > > >     $89 = 0xffff00917fe032e0
> > > > >     crash> p ((struct per_cpu_nodestat *) 0xffff00917fe032e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
> > > > >     $91 = -1 '\377'
> > > > 
> > > > This doesn't really tell much. How much out of sync they really are
> > > > cumulatively over all cpus?
> > > 
> > > This is the cumulative value over all CPUs (offsets for other CPUs 
> > > have been omitted since they are zero).
> > 
> > OK, so that means the NR_ISOLATED_FILE is 0 while NR_INACTIVE_FILE is 1,
> > correct? If that is the case then the value is indeed outdated but it
> > also means that the NR_INACTIVE_FILE is so small that all but 1 (resp. 2
> > as kswapd is never throttled) reclaimers will be stalled anyway. So does
> > the exact snapshot really help? Do you have any means to reproduce this
> > behavior and see that the patch actually changed the behavior?
> > 
> > [...]
> > 
> > > > With a very low NR_FREE_PAGES and many contending allocation the system
> > > > could be easily stuck in reclaim. What are other reclaim
> > > > characteristics? 
> > > 
> > > I can ask. What information in particular do you want to know?
> > 
> > When I am dealing with issues like this I heavily rely on /proc/vmstat
> > counters and pgscan, pgsteal counters to see whether there is any
> > progress over time.
> > 
> > > > Is the direct reclaim successful? 
> > > 
> > > Processes are stuck in too_many_isolated (unnecessarily). What do you mean when you ask
> > > "Is the direct reclaim successful", precisely?
> > 
> > With such a small LRU list it is quite likely that many processes will
> > be competing over last pages on the list while rest will be throttled
> > because there is nothing to reclaim. It is quite possible that all
> > reclaimers will be waiting for a single reclaimer (either kswapd or
> > other direct reclaimer). I would like to understand whether the system
> > is stuck in unproductive state where everybody just waits until the
> > counter is synced or everything just progress very slowly because of the
> > small LRU. 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
> Michal,
> 
> I think this provides the data you are looking for:
> 
> It seems that the situation was invoking memory-consuming user program
> in pallarel expecting that the system will kick oom-killer at the end.
> 
> The node 0-3 are small containing system data and almost all files.
> The node 4-7 are large prepared to contain user data only. 
> The issue described in above was observed on node 4-7, where
> had very few memory for files.
> 
> The node 4-7 has more cpu than node 0-3.
> Only cpus on node 4-7 are configuerd to be nohz_full.
> So we often found unflushed percpu vmstat on cpus of node 4-7.
> 
> 

Michal,

Let me know if you have any objections to the patch, thanks.

