Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA77F47C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbjKVNZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbjKVNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:25:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE5199;
        Wed, 22 Nov 2023 05:25:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA6D421963;
        Wed, 22 Nov 2023 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700659500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mnil+ohrFFTHGaSkTl3Q2cN64Y8ppTuLrZctm6+XJ04=;
        b=NviMH3lPaz796NW0GanNc2oVdUjsEpgwAS1bgTsNOE1S3r1SeXrEcclqbbdKOyx1fnusqF
        VyWcZqiqbbNuU49VvWRezdfO5MjuI0+1oqkznB4vxRlgRNMntMZKAUfkjkm9GLCW0qUDxI
        WXKB+sr5IyNeb+NoCv5cHyJGnYLg6GU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8628C13467;
        Wed, 22 Nov 2023 13:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ajEaHSwBXmVjaQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Nov 2023 13:25:00 +0000
Date:   Wed, 22 Nov 2023 14:24:59 +0100
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
Message-ID: <ZV4BK0wbUAZBIhmA@tiehlicka>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-3-ddrokosov@salutedevices.com>
 <ZV3WnIJMzxT-Zkt4@tiehlicka>
 <20231122105836.xhlgbwmwjdwd3g5v@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122105836.xhlgbwmwjdwd3g5v@CAB-WSD-L081021>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 13:58:36, Dmitry Rokosov wrote:
> Hello Michal,
> 
> Thank you for the quick review!
> 
> On Wed, Nov 22, 2023 at 11:23:24AM +0100, Michal Hocko wrote:
> > On Wed 22-11-23 13:01:56, Dmitry Rokosov wrote:
> > > The shrink_memcg flow plays a crucial role in memcg reclamation.
> > > Currently, it is not possible to trace this point from non-direct
> > > reclaim paths.
> > 
> > Is this really true? AFAICS we have
> > mm_vmscan_lru_isolate
> > mm_vmscan_lru_shrink_active
> > mm_vmscan_lru_shrink_inactive
> > 
> > which are in the vry core of the memory reclaim. Sure post processing
> > those is some work.
> 
> Sure, you are absolutely right. In the usual scenario, the memcg
> shrinker utilizes two sub-shrinkers: slab and LRU. We can enable the
> tracepoints you mentioned and analyze them. However, there is one
> potential issue. Enabling these tracepoints will trigger the reclaim
> events show for all pages. Although we can filter them per pid, we
> cannot filter them per cgroup. Nevertheless, there are times when it
> would be extremely beneficial to comprehend the effectiveness of the
> reclaim process within the relevant cgroup. For this reason, I am adding
> the cgroup name to the memcg tracepoints and implementing a cumulative
> tracepoint for memcg shrink (LRU + slab)."

I can see how printing memcg in mm_vmscan_memcg_reclaim_begin makes it
easier to postprocess per memcg reclaim. But you could do that just by
adding that to mm_vmscan_memcg_reclaim_{begin, end}, no? Why exactly
does this matter for kswapd and other global reclaim contexts? 
-- 
Michal Hocko
SUSE Labs
