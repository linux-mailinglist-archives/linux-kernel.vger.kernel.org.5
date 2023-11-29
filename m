Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632A87FD3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjK2KRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjK2KRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:17:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2C1BC6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:17:36 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00A7221999;
        Wed, 29 Nov 2023 10:17:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C003B1388B;
        Wed, 29 Nov 2023 10:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id G8u2Kr4PZ2UnBgAAD6G6ig
        (envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 10:17:34 +0000
Date:   Wed, 29 Nov 2023 11:17:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZWcPuYzWYAvOODsH@tiehlicka>
References: <ZV3_6UH28KMt0ZDb@tiehlicka>
 <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka>
 <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWRdG49vlGzSY_Uj@tiehlicka>
 <87r0ka64v9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWW95JPQ1B0cVPY-@tiehlicka>
 <ZWZtdQKSSnLC8kZ6@google.com>
 <CAJD7tkZA2DDk259QHLnkwVqCq=v_4gBKSUV0hos8G+B6n6=rAQ@mail.gmail.com>
 <ZWZ0fJP9wq65rXtM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWZ0fJP9wq65rXtM@google.com>
X-Spamd-Bar: +++++++++++++++
X-Spam-Score: 15.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=fail (smtp-out1.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 00A7221999
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 15:15:08, Minchan Kim wrote:
> On Tue, Nov 28, 2023 at 03:05:29PM -0800, Yosry Ahmed wrote:
> > On Tue, Nov 28, 2023 at 2:45 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Tue, Nov 28, 2023 at 11:16:04AM +0100, Michal Hocko wrote:
> > > > On Tue 28-11-23 09:31:06, Huang, Ying wrote:
> > > > > Michal Hocko <mhocko@suse.com> writes:
> > > > [...]
> > > > > > Right. On the other hand we could be more aggressive when dropping the
> > > > > > swapcache. Is there any actual reason why we cannot try to folio_free_swap
> > > > > > even when mem_cgroup_swap_full == F?
> > > > >
> > > > > If there are plenty free space in swap device, why not take advantage of
> > > > > it?
> > > >
> > > > Maybe a stupid question but what is the advantage of keeping around in
> > > > the swap cache?
> > >
> > > If the page is shared, we avoids addtional IO to bring them back so
> > > swap cache.
> > 
> > I think this case is actually necessary for correctness, not just to
> > avoid additional IO. Otherwise subsequent swapins will create new
> > copies of the page, right?
> 
> I think if the page was shared by MAP_SHARED, then, yes.

In that case deleting from the swap cache would fail because there are
still swapped out ptes, no?

> I think if the page was shared by MAP_PRIVATE but CoW(e.g., fork), then, no.

OK, but we are talking about a memory pressure here and evicting
available memory. So what is the actual cost benefit model here?
Is it really better to keep swapcache around even under memory pressure
if the CoWed page could never be faulted in?
-- 
Michal Hocko
SUSE Labs
