Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9E7E008C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347257AbjKCJjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbjKCJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:39:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417071BD;
        Fri,  3 Nov 2023 02:39:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 707481FD65;
        Fri,  3 Nov 2023 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699004341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4jQ1t6Qttv+buPxaS9aV1Pqc3DF6sKVx91vpC38npY=;
        b=rN1523AAByVvwQQ/Qv9+31L7Z+WHkVB7hPMA096juan6k4125M0ZQOhzSO7JZhqZMrZ1JS
        pFxT/lA0OJTUYGlaY1TNJ48TlWQcrVj/cDTMOytZZDztDCgBpTpSkgRd5yFDZHnBab6FTK
        cGuwQvdUA8Ofc+FocFMkm6rdt2ZHQvA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51D3F13907;
        Fri,  3 Nov 2023 09:39:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2sE+EbW/RGWqewAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 03 Nov 2023 09:39:01 +0000
Date:   Fri, 3 Nov 2023 10:39:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <2i3awgkx2i4a5op7rtcqzv4yub376l66tevfvlyccf6wrjia4v@5x4ar4f6i5eh>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <87msvy6wn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ivhxexthtfums73nkko6yoy635h3cpetv4sqaemrmqd5pbhpq6@6zrizaoxgdwi>
 <87il6k1y82.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <fe7ns7dvrhwp6o7fnn53wt7tuidsncjctgav4bdirwfmjxarne@3oyfe22mxc35>
 <87jzqzz502.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzqzz502.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-11-23 15:10:37, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Thu 02-11-23 14:11:09, Huang, Ying wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> >> 
> >> > On Wed 01-11-23 10:21:47, Huang, Ying wrote:
> >> >> Michal Hocko <mhocko@suse.com> writes:
> >> > [...]
> >> >> > Well, I am not convinced about that TBH. Sure it is probably a good fit
> >> >> > for this specific CXL usecase but it just doesn't fit into many others I
> >> >> > can think of - e.g. proportional use of those tiers based on the
> >> >> > workload - you get what you pay for.
> >> >> 
> >> >> For "pay", per my understanding, we need some cgroup based
> >> >> per-memory-tier (or per-node) usage limit.  The following patchset is
> >> >> the first step for that.
> >> >> 
> >> >> https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com/
> >> >
> >> > Why do we need a sysfs interface if there are plans for cgroup API?
> >> 
> >> They are for different target.  The cgroup API proposed here is to
> >> constrain the DRAM usage in a system with DRAM and CXL memory.  The less
> >> you pay, the less DRAM and more CXL memory you use.
> >
> > Right, but why the usage distribution requires its own interface and
> > cannot be combined with the access control part of it?
> 
> Per my understanding, they are orthogonal.
> 
> Weighted-interleave is a memory allocation policy, other memory
> allocation policies include local first, etc.
> 
> Usage limit is to constrain the usage of specific memory types
> (e.g. DRAM) for a cgroup.  It can be used together with local first
> policy and some other memory allocation policy.

Bad wording from me. Sorry for the confusion. Sure those are two
orthogonal things and I didn't mean to suggest a single API to cover
both. But if cgroup semantic can be reasonably defined for the usage
enforcement can we put the interleaving behavior API under the same
cgroup controller as well?
-- 
Michal Hocko
SUSE Labs
