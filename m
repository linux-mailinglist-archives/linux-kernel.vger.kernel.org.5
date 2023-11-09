Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23237E6737
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjKIJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKIJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:57:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E02D51;
        Thu,  9 Nov 2023 01:57:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8D9C21980;
        Thu,  9 Nov 2023 09:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699523847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yn6JcTamlRQg3kkPapoNWj3B+9lVbO+tz0QcL4eYLzE=;
        b=MmM4jgB1VNceK0D5FOC1mtA+cxxBgYJr0x9QveuSGnwXcogW6DyAh+xPuHXwkz2Xug8+Da
        m3cTIUmqR5XdkMb1GJq2xkItTsewINuUdDuIEV6XajDHfsOgn2EBILbonEDgU9V+XNtBrG
        i5lFPcw8SQEM5YBTB8PMRf9snTPrXAk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6E7B138E5;
        Thu,  9 Nov 2023 09:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RXdFMAetTGWyYwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 09:57:27 +0000
Date:   Thu, 9 Nov 2023 10:57:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Huan Yang <link@vivo.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-ID: <ZUytB5lSwxeKkBW8@tiehlicka>
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka>
 <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-11-23 11:38:56, Huan Yang wrote:
[...]
> > If so, is it better only to reclaim private anonymous pages explicitly?
> Yes, in practice, we only proactively compress anonymous pages and do not
> want to touch file pages.

If that is the case and this is mostly application centric (which you
seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
instead.
-- 
Michal Hocko
SUSE Labs
