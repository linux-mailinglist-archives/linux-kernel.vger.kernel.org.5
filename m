Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E727DE216
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKAOBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjKAOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:01:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D2783;
        Wed,  1 Nov 2023 07:01:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6809E2185F;
        Wed,  1 Nov 2023 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698847283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLiYVD2bRDe/aeyPHKjrOUYyw8vp2Tqf1wgU9nx85p8=;
        b=RAD9DQE3J1toU6Qil/GtsecXIktGsbpW1JkuvpiDva+38jiSQkMKdsBsDyvlA+ZO/2tuyq
        nOUa/n2tKDCtPduu0a4wuhwQrJoVvUJRJNp/coCFZZftzOkJCwv6Dl7Nuh27iG0+4CmIKL
        eHnE1cd4onUjxsMAVifKkPLa8qaF3+8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4778E13460;
        Wed,  1 Nov 2023 14:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FYU5DjNaQmVyfgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 01 Nov 2023 14:01:23 +0000
Date:   Wed, 1 Nov 2023 15:01:22 +0100
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
Message-ID: <ivhxexthtfums73nkko6yoy635h3cpetv4sqaemrmqd5pbhpq6@6zrizaoxgdwi>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <87msvy6wn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msvy6wn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-11-23 10:21:47, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
[...]
> > Well, I am not convinced about that TBH. Sure it is probably a good fit
> > for this specific CXL usecase but it just doesn't fit into many others I
> > can think of - e.g. proportional use of those tiers based on the
> > workload - you get what you pay for.
> 
> For "pay", per my understanding, we need some cgroup based
> per-memory-tier (or per-node) usage limit.  The following patchset is
> the first step for that.
> 
> https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com/

Why do we need a sysfs interface if there are plans for cgroup API?

-- 
Michal Hocko
SUSE Labs
