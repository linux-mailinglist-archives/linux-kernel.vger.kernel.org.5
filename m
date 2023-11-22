Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA37F485B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjKVN4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjKVN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:56:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B774B199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:56:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A1AE21979;
        Wed, 22 Nov 2023 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700661384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4PL01vdipAxXI2et46ovWIE1C2j61g1DsIeVKK4hMJ8=;
        b=a8PFBE4bG4ry/xym88djaUEBZuMT6DkQChwAEsfDOWoIXWMauOOabCr1VcT2jZ/XMqyOrE
        7fj98k6G520QLOvWtK0Dqur9JjfkfdgEXvKy4shV9GKRKT6ig2M2/f0SbhW4x0HUSmQryG
        wFVgLZoKlK6bFq7HzJJdpMEMVqVQLPk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 524FF13467;
        Wed, 22 Nov 2023 13:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qv2DEIgIXmWndwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Nov 2023 13:56:24 +0000
Date:   Wed, 22 Nov 2023 14:56:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 0/2] mm: too_many_isolated can stall due to out of sync
 VM counters
Message-ID: <ZV4Ih4MwuHO4BMGy@tiehlicka>
References: <20231113233420.446465795@redhat.com>
 <ZVMtuYLviLYqAI7x@tiehlicka>
 <ZVNnjVdeNblG1l8t@tpad>
 <ZVNsMVPJ5y8C_hBC@tiehlicka>
 <ZV3kxwqedKH+LDum@tpad>
 <ZV3lSttsGq1fuPyG@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV3lSttsGq1fuPyG@tpad>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.87
X-Spamd-Result: default: False [-6.87 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.07)[95.48%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 08:26:02, Marcelo Tosatti wrote:
[...]
> Michal,
> 
> Let me know if you have any objections to the patch, thanks.

I do not think you have exaplained how the patch helps nor you have
shown it has fixed the described problem. You seem to be very focused on
the specific snapshot which I do agree shows that the data is out of
sync and that there is throttling happening when strictly speaking it
should noti. But (let me repeat) those discrepancies are so small that
it is very likely that concurrent reclaimers will be stalled (just take
one to isolate those pages) anyway. Maybe this leads to an earlier OOM
killer invocation as untrottled reclaimers will be able to conclude
there is no progress rather than being throttled on the direct reclaim.

That being said I am not saying the patch is incorrect. Nevertheless, I
do not think we want to merge this patch without a better understanding
what is going on in your specific case and what kind of runtime
difference does the patch make in that case. From your previous email it
seems like the actual case is mostly memory stress test that manages to
fill out the memory to push almost all the file LRU while anon LRU is
not reclaimable for some reason. That shouldn't be terribly hard to
reproduce.

-- 
Michal Hocko
SUSE Labs
