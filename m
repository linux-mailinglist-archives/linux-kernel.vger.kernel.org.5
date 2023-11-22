Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63F57F43AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbjKVKXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbjKVKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:23:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F231A2;
        Wed, 22 Nov 2023 02:23:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BCE021963;
        Wed, 22 Nov 2023 10:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700648606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PlrtFUbphp1xKwmhddTZK3avXJcT+X0HqDrgDSKr+Yk=;
        b=P77qLai85rWBMrGTsafkxgHKUUvxfCmTbGAwFiMJZ+lmIITCQ0veHfNqJoA4Mvs6DsTxck
        FhDypOKa7BVuH7clX/MsfXpCbzBXtgePjuY8c4tNM9NR6u8ESVjAg8MWSd5+IVCRSDoBMk
        FBD2PFW7rhHGuHVgUv5bfatiAmN9kCk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0909113461;
        Wed, 22 Nov 2023 10:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qLLKOp3WXWVEEwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Nov 2023 10:23:25 +0000
Date:   Wed, 22 Nov 2023 11:23:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        kernel@sberdevices.ru, rockosov@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <ZV3WnIJMzxT-Zkt4@tiehlicka>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-3-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122100156.6568-3-ddrokosov@salutedevices.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.41
X-Spamd-Result: default: False [-5.41 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.61)[81.89%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[14];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[goodmis.org,kernel.org,cmpxchg.org,linux.dev,google.com,linux-foundation.org,sberdevices.ru,gmail.com,vger.kernel.org,kvack.org];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 13:01:56, Dmitry Rokosov wrote:
> The shrink_memcg flow plays a crucial role in memcg reclamation.
> Currently, it is not possible to trace this point from non-direct
> reclaim paths.

Is this really true? AFAICS we have
mm_vmscan_lru_isolate
mm_vmscan_lru_shrink_active
mm_vmscan_lru_shrink_inactive

which are in the vry core of the memory reclaim. Sure post processing
those is some work.

[...]
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 45780952f4b5..6d89b39d9a91 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6461,6 +6461,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  		 */
>  		cond_resched();
>  
> +#ifdef CONFIG_MEMCG
> +		trace_mm_vmscan_memcg_shrink_begin(sc->order,
> +						   sc->gfp_mask,
> +						   memcg);
> +#endif

this is a common code path for node and direct reclaim which means that
we will have multiple begin/end tracepoints covering similar operations.
To me that sounds excessive. If you are missing a cumulative kswapd
alternative to 
mm_vmscan_direct_reclaim_begin
mm_vmscan_direct_reclaim_end
mm_vmscan_memcg_reclaim_begin
mm_vmscan_memcg_reclaim_end
mm_vmscan_memcg_softlimit_reclaim_begin
mm_vmscan_memcg_softlimit_reclaim_end
mm_vmscan_node_reclaim_begin
mm_vmscan_node_reclaim_end

then place it into kswapd path. But it would be really great to
elaborate some more why this is really needed. Cannot you simply
aggregate stats for kswapd from existing tracepoints?

-- 
Michal Hocko
SUSE Labs
