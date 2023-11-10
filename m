Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E482A7E803F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbjKJSIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjKJSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558F83367D;
        Fri, 10 Nov 2023 04:24:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A0BC21986;
        Fri, 10 Nov 2023 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699619062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEMlJTypraY6MioDn/TZVL4tcm3Oo4k57aQCpucll0g=;
        b=cIHSZ08PXwgBV4D2RmTzbFq2GyGr5+BNUU+GuQ9Fp/jFC75c8eID5PAMgs6kguz0DrNQYI
        SbSO3khkf4I2EI3HmokhHYfmtDkbYdzfpJdJTAwA8MBEhid3yd9fqH5Xf6AAKlnTp5FY1j
        O7SiT6Gk3d39XEj9inJvHDcoTJPrWL0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9BD2138FC;
        Fri, 10 Nov 2023 12:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 01Y1MvUgTmXhGwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 10 Nov 2023 12:24:21 +0000
Date:   Fri, 10 Nov 2023 13:24:21 +0100
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
Message-ID: <ZU4g9XZvi9mRQD27@tiehlicka>
References: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
 <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
 <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <ZUzTVgK_i05uiHiB@tiehlicka>
 <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
 <ZUziy-6QPdTIDJlm@tiehlicka>
 <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-11-23 11:48:49, Huan Yang wrote:
[...]
> Also, When the application enters the foreground, the startup speed
> may be slower. Also trace show that here are a lot of block I/O.
> (usually 1000+ IO count and 200+ms IO Time) We usually observe very
> little block I/O caused by zram refault.(read: 1698.39MB/s, write:
> 995.109MB/s), usually, it is faster than random disk reads.(read:
> 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I change a
> little to test UFS.
> 
> Therefore, if the proactive reclamation encounters many file pages,
> the application may become slow when it is opened.

OK, this is an interesting information. From the above it seems that
storage based IO refaults are order of magnitude more expensive than
swap (zram in this case). That means that the memory reclaim should 
_in general_ prefer anonymous memory reclaim over refaulted page cache,
right? Or is there any reason why "frozen" applications are any
different in this case?

Our traditional interface to control the anon vs. file balance has been
swappiness. It is not the best interface and it has its flaws but
have you experimented with the global swappiness to express that
preference? What were your observations? Please note that the behavior
might be really different with different kernel versions so I would
really stress out that testing with the current Linus (or akpm) tree is
necessary.

Anyway, the more I think about that the more I am convinced that
explicit anon/file extension for the memory.reclaim interface is just a
wrong way to address a more fundamental underlying problem. That is, the
default reclaim choice over anon vs file preference should consider the
cost of the refaulting IO. This is more a property of the underlying
storage than a global characteristic. In other words, say you have
mutlitple storages, one that is a network based with a high latency and
other that is a local fast SSD. Reclaiming a page backed by the slower
storage is going to be more expensive to refault than the one backed by
the fast storage.  So even page cache pages are not really all the same. 

It is quite likely that a IO cost aspect is not really easy to integrate
into the memory reclaim but it seems to me this is a better way to focus
on for a better long term solution. Our existing refaulting
infrastructure should help in that respect. Also MGLRU could fit for
that purpose better than the traditional LRU based reclaim as the higher
generations could be used for more more expensive pages.
-- 
Michal Hocko
SUSE Labs
