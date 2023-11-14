Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC47EAB81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjKNIUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjKNIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:20:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D211BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:20:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A211218E5;
        Tue, 14 Nov 2023 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699950010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6H7EakbDnhsb8D1NyizF9B8h3ANmbbwZmRIRDeHzN4c=;
        b=c29AEWvpe1BPv5FM/+sqaVHlTQ3dIGi3gNq7vceBJOJQ2gpTfJvNWI+JMGP9JWH5vTVUt0
        Oa7sQh/WAMM2JLjfPICCy72x8hig6QZeR4CLl71Xh9DzokSwtxsz846doJb/rnRPIGLFJu
        gMRmnmWMU8TSnYQ1f9DPBdH+NvFtkfE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18F2713460;
        Tue, 14 Nov 2023 08:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WageA7otU2UHbAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 08:20:10 +0000
Date:   Tue, 14 Nov 2023 09:20:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 0/2] mm: too_many_isolated can stall due to out of sync
 VM counters
Message-ID: <ZVMtuYLviLYqAI7x@tiehlicka>
References: <20231113233420.446465795@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113233420.446465795@redhat.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.60
X-Spamd-Result: default: False [-5.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_SEVEN(0.00)[7];
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

On Mon 13-11-23 20:34:20, Marcelo Tosatti wrote:
> A customer reported seeing processes hung at too_many_isolated,
> while analysis indicated that the problem occurred due to out
> of sync per-CPU stats (see below).
> 
> Fix is to use node_page_state_snapshot to avoid the out of stale values.
> 
> 2136 static unsigned long
>     2137 shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>     2138                      struct scan_control *sc, enum lru_list lru)
>     2139 {
>     :
>     2145         bool file = is_file_lru(lru);
>     :
>     2147         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>     :
>     2150         while (unlikely(too_many_isolated(pgdat, file, sc))) {
>     2151                 if (stalled)
>     2152                         return 0;
>     2153
>     2154                 /* wait a bit for the reclaimer. */
>     2155                 msleep(100);   <--- some processes were sleeping here, with pending SIGKILL.
>     2156                 stalled = true;
>     2157
>     2158                 /* We are about to die and free our memory. Return now. */
>     2159                 if (fatal_signal_pending(current))
>     2160                         return SWAP_CLUSTER_MAX;
>     2161         }
> 
> msleep() must be called only when there are too many isolated pages:

What do you mean here?

>     2019 static int too_many_isolated(struct pglist_data *pgdat, int file,
>     2020                 struct scan_control *sc)
>     2021 {
>     :
>     2030         if (file) {
>     2031                 inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
>     2032                 isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
>     2033         } else {
>     :
>     2046         return isolated > inactive;
> 
> The return value was true since:
> 
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

This doesn't really tell much. How much out of sync they really are
cumulatively over all cpus?
 
> It seems that processes were trapped in direct reclaim/compaction loop
> because these nodes had few free pages lower than watermark min.
> 
>   crash> kmem -z | grep -A 3 Normal
>   :
>   NODE: 4  ZONE: 1  ADDR: ffff00817fffec40  NAME: "Normal"
>     SIZE: 8454144  PRESENT: 98304  MIN/LOW/HIGH: 68/166/264
>     VM_STAT:
>           NR_FREE_PAGES: 68
>   --
>   NODE: 5  ZONE: 1  ADDR: ffff00897fffec40  NAME: "Normal"
>     SIZE: 118784  MIN/LOW/HIGH: 82/200/318
>     VM_STAT:
>           NR_FREE_PAGES: 45
>   --
>   NODE: 6  ZONE: 1  ADDR: ffff00917fffec40  NAME: "Normal"
>     SIZE: 118784  MIN/LOW/HIGH: 82/200/318
>     VM_STAT:
>           NR_FREE_PAGES: 53
>   --
>   NODE: 7  ZONE: 1  ADDR: ffff00997fbbec40  NAME: "Normal"
>     SIZE: 118784  MIN/LOW/HIGH: 82/200/318
>     VM_STAT:
>           NR_FREE_PAGES: 52

How have you concluded that too_many_isolated is at root of this issue.
With a very low NR_FREE_PAGES and many contending allocation the system
could be easily stuck in reclaim. What are other reclaim
characteristics? Is the direct reclaim successful? 

-- 
Michal Hocko
SUSE Labs
