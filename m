Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1079B64A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbjIKVMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbjIKMYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:24:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235AFCDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:24:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4AF0211C3;
        Mon, 11 Sep 2023 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694435047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjRjylMkvo2iz067JP+nGaOoVALTdbSG3qs/RtYsLlo=;
        b=pPnVO/lZhHyOgr3kkrCIfsS59Zl+YuAiqFA6RiZseEljHgZPc/7bEwjgPlOGSNAyCtrlAf
        1duEIVHzp28tt3DRE71iBxNhzyl9z+v8kAz+9917rSIPN4OalXtsIhxSxkTYG0ULjnIIRp
        afd5mO3oP0+QWRmsyBeC4dz2DLPAv7E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B530C139CC;
        Mon, 11 Sep 2023 12:24:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N4tFKecG/2QuCQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 11 Sep 2023 12:24:07 +0000
Date:   Mon, 11 Sep 2023 14:24:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: remove redundant clear page when
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON configured
Message-ID: <ZP8G5nIwc6b0LrHC@dhcp22.suse.cz>
References: <20230911104906.2058503-1-zhaoyang.huang@unisoc.com>
 <ZP8EKWev8H9kMka3@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP8EKWev8H9kMka3@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-09-23 14:12:26, Michal Hocko wrote:
> On Mon 11-09-23 18:49:06, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > There will be redundant clear page within vma_alloc_zeroed_movable_folio
> > when CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on. Remove it by judging related
> > configs.
> 
> Thanks for spotting this. I suspect this is a fix based on a code review
> rather than a real performance issue, right? It is always good to
> mention that. From a very quick look it seems that many architectures
> just definte vma_alloc_zeroed_movable_folio to use __GFP_ZERO so they
> are not affected by this. This means that only a subset of architectures
> are really affected. This is an important information as well.
> Finally I think it would be more appropriate to mention that the double
> initialization is done when init_on_alloc is enabled rather than
> referring to the above config option which only controls whether the
> functionality is enabled by default.
> 
> I would rephrase as follows:
> Many architectures (alpha, arm64, ia64, m68k s390, x86) define their own
> vma_alloc_zeroed_movable_folio implementations which use __GFP_ZERO for
> the page allocation.
> 
> Those which rely on the default implementation, however, would currently
> go through the initialization twice (oce in the page allocator and
> second in vma_alloc_zeroed_movable_folio) if init_on_alloc is enabled
> though. Fix this by checking want_init_on_alloc before calling
> clear_user_highpage.

Btw. have you checked other places which could have a similar problem?
From a very quick look __do_huge_pmd_anonymous_page, hugetlb_no_page,
hugetlbfs_fallocate and shmem_mfill_atomic_pte all follow the same
pattern. They do allocate memory so they go through the initialization
in the allocator and then reinitialized.

-- 
Michal Hocko
SUSE Labs
