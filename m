Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB67DC7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjJaIO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJaIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:14:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8186AE4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:14:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 463B721ADA;
        Tue, 31 Oct 2023 08:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698740092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AY9OCccMzkujq4sE+gwgw90jz2mOKvMAomfVopVHue4=;
        b=qIRBOpbBVxPNJwKkfhdIfC2rvF6t5lAxdpK4BlRfu63rldwT/gN4aMMMagWW2bfNiYBxwa
        Rm2BcI54BjroS5nQo1PKC1atPTcI4OY+IqK89lOiEq/RnP+7M11bWEC2XFJorepzsuNd3B
        p9vnbx33r5g/gPhz550OoY5yEVI3Q84=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 270291391B;
        Tue, 31 Oct 2023 08:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F0kXB3y3QGW2OAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 31 Oct 2023 08:14:52 +0000
Date:   Tue, 31 Oct 2023 09:14:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: unreserve highatomic page blocks before
 oom
Message-ID: <gtya2g2pdbsonelny6vpfwj5vsxdrzhi6wzkpcrke33mr3q2hf@j4ramnjmfx52>
References: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-10-23 18:09:50, Charan Teja Kalla wrote:
> __alloc_pages_direct_reclaim() is called from slowpath allocation where
> high atomic reserves can be unreserved after there is a progress in
> reclaim and yet no suitable page is found. Later should_reclaim_retry()
> gets called from slow path allocation to decide if the reclaim needs to
> be retried before OOM kill path is taken.
> 
> should_reclaim_retry() checks the available(reclaimable + free pages)
> memory against the min wmark levels of a zone and returns:
> a)  true, if it is above the min wmark so that slow path allocation will
> do the reclaim retries.
> b) false, thus slowpath allocation takes oom kill path.
> 
> should_reclaim_retry() can also unreserves the high atomic reserves
> **but only after all the reclaim retries are exhausted.**
> 
> In a case where there are almost none reclaimable memory and free pages
> contains mostly the high atomic reserves but allocation context can't
> use these high atomic reserves, makes the available memory below min
> wmark levels hence false is returned from should_reclaim_retry() leading
> the allocation request to take OOM kill path. This is an early oom kill
> because high atomic reserves are holding lot of free memory and 
> unreserving of them is not attempted.

OK, I see. So we do not release those reserved pages because OOM hits
too early. 

> (early)OOM is encountered on a machine in the below state(excerpt from
> the oom kill logs):
> [  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
> high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
> active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
> present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
> local_pcp:492kB free_cma:0kB
> [  295.998656] lowmem_reserve[]: 0 32
> [  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
> 33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
> 0*4096kB = 7752kB

OK, this is quite interesting as well. The system is really tiny and 8MB
of reserved memory is indeed really high. How come those reservations
have grown that high?
> 
> Per above log, the free memory of ~7MB exist in the high atomic
> reserves is not freed up before falling back to oom kill path.
> 
> This fix includes unreserving these atomic reserves in the OOM path
> before going for a kill. The side effect of unreserving in oom kill path
> is that these free pages are checked against the high wmark. If
> unreserved from should_reclaim_retry()/__alloc_pages_direct_reclaim(),
> they are checked against the min wmark levels.

I do not like the fix much TBH. I think the logic should live in
should_reclaim_retry. One way to approach it is to unreserve at the end
of the function, something like this:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f376302..d04e14adf2c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3813,10 +3813,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * Make sure we converge to OOM if we cannot make any progress
 	 * several times in the row.
 	 */
-	if (*no_progress_loops > MAX_RECLAIM_RETRIES) {
-		/* Before OOM, exhaust highatomic_reserve */
-		return unreserve_highatomic_pageblock(ac, true);
-	}
+	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
+		goto out;
 
 	/*
 	 * Keep reclaiming pages while there is a chance this will lead
@@ -3859,6 +3857,12 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		schedule_timeout_uninterruptible(1);
 	else
 		cond_resched();
+
+out:
+	/* Before OOM, exhaust highatomic_reserve */
+	if (!ret)
+		return unreserve_highatomic_pageblock(ac, true);
+
 	return ret;
 }
 
-- 
Michal Hocko
SUSE Labs
