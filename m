Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90C2778A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjHKJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHKJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:35:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC502709
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:35:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F78B1F74A;
        Fri, 11 Aug 2023 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691746538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/tEynIR4U6iHt7GPkko/b/gVTYV1oL7tRpdFFRnc8k=;
        b=MepRkntqqYC9hI27B0fxkWkr4DYYrXcgwDq1ppIT40Fi9Vg8Z4DoIrLh/l6DJiVyUpbHCl
        r/LdssTYho1VoOPJ0+9eekU6HA8ZAIrggQqs+AZj5uQ92HR/sFnC2guIiiqrKV3v9auBlR
        m5E7gAy4Dy3Pbyqrhu8JIlHyJ5d817w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0224B138E2;
        Fri, 11 Aug 2023 09:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LGbxOOkA1mRiHwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 11 Aug 2023 09:35:37 +0000
Date:   Fri, 11 Aug 2023 11:35:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
Message-ID: <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
References: <20230811090819.60845-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811090819.60845-1-ying.huang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-08-23 17:08:19, Huang Ying wrote:
> If there is no memory allocation/freeing in the remote pageset after
> some time (3 seconds for now), the remote pageset will be drained to
> avoid memory wastage.
> 
> But in the current implementation, vmstat updater worker may not be
> re-queued when we are waiting for the timeout (pcp->expire != 0) if
> there are no vmstat changes, for example, when CPU goes idle.

Why is that a problem?

> This is fixed via guaranteeing that the vmstat updater worker will
> always be re-queued when we are waiting for the timeout.
> 
> We can reproduce the bug via allocating/freeing pages from remote
> node, then go idle.  And the patch can fix it.
> 
> Fixes: 7cc36bbddde5 ("vmstat: on-demand vmstat workers V8")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> ---
>  mm/vmstat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b731d57996c5..111118741abf 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -856,8 +856,10 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
>  				continue;
>  			}
>  
> -			if (__this_cpu_dec_return(pcp->expire))
> +			if (__this_cpu_dec_return(pcp->expire)) {
> +				changes++;
>  				continue;
> +			}
>  
>  			if (__this_cpu_read(pcp->count)) {
>  				drain_zone_pages(zone, this_cpu_ptr(pcp));
> -- 
> 2.39.2

-- 
Michal Hocko
SUSE Labs
