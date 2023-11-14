Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BBA7EAD61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjKNJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjKNJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:50:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB791AC;
        Tue, 14 Nov 2023 01:50:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 66AAB218D6;
        Tue, 14 Nov 2023 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699955447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xk27T3NxTwbnlJ5P3tH7QSavlHidd8/4W2N+WOglPOs=;
        b=o9+byrf9oaOteVJp06CiArSYrYnZpqhQXZmvmMM5LOiuPUsTg8RzF/X5qetT9q4sS1a4i/
        uujODQOVmJnUNizVf1cLqjYuavqPDYK5rt0HDcoost94BdF9NCVeU8aO0n46pt9y0zLB4B
        9VbdGAnoF+RLE8+GtvsEqo/PON4evFg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BDD813416;
        Tue, 14 Nov 2023 09:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3RVnC/dCU2U1HAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 09:50:47 +0000
Date:   Tue, 14 Nov 2023 10:50:46 +0100
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
Message-ID: <ZVNC9mDOOWgjen7U@tiehlicka>
References: <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
 <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <ZUzTVgK_i05uiHiB@tiehlicka>
 <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
 <ZUziy-6QPdTIDJlm@tiehlicka>
 <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>
 <ZU4g9XZvi9mRQD27@tiehlicka>
 <b4694fbf-92df-4067-878e-6035df46582f@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4694fbf-92df-4067-878e-6035df46582f@vivo.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.21
X-Spamd-Result: default: False [-2.21 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         BAYES_HAM(-0.11)[66.40%];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[23];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[intel.com,kernel.org,bytedance.com,cmpxchg.org,lwn.net,linux.dev,google.com,linux-foundation.org,redhat.com,infradead.org,huawei.com,gmail.com,vger.kernel.org,kvack.org,vivo.com];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-11-23 10:17:57, Huan Yang wrote:
> 
> 在 2023/11/10 20:24, Michal Hocko 写道:
> > On Fri 10-11-23 11:48:49, Huan Yang wrote:
> > [...]
> > > Also, When the application enters the foreground, the startup speed
> > > may be slower. Also trace show that here are a lot of block I/O.
> > > (usually 1000+ IO count and 200+ms IO Time) We usually observe very
> > > little block I/O caused by zram refault.(read: 1698.39MB/s, write:
> > > 995.109MB/s), usually, it is faster than random disk reads.(read:
> > > 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I change a
> > > little to test UFS.
> > > 
> > > Therefore, if the proactive reclamation encounters many file pages,
> > > the application may become slow when it is opened.
> > OK, this is an interesting information. From the above it seems that
> > storage based IO refaults are order of magnitude more expensive than
> > swap (zram in this case). That means that the memory reclaim should
> > _in general_ prefer anonymous memory reclaim over refaulted page cache,
> > right? Or is there any reason why "frozen" applications are any
> > different in this case?
> Frozen applications mean that the application process is no longer active,
> so once its private anonymous page data is swapped out, the anonymous
> pages will not be refaulted until the application becomes active again.

I was probably not clear in my question. It is quite clear that frozen
applications are inactive. It is not really clear why they should be
treated any differently though. Their memory will be naturally cold as
the memory is not in use so why cannot we realy on the standard memory
reclaim to deal with the implicit inactivity and you need to handle that
explicitly?

[...]
> > Our traditional interface to control the anon vs. file balance has been
> > swappiness. It is not the best interface and it has its flaws but
> > have you experimented with the global swappiness to express that
> > preference? What were your observations? Please note that the behavior
> We have tested this part and found that no version of the code has the
> priority control over swappiness.
> 
> This means that even if we modify swappiness to 0 or 200,
> we cannot achieve the goal of unbalanced reclaim if some conditions
> are not met during the reclaim process. Under certain conditions,
> we may mistakenly reclaim file pages, and since we usually trigger
> active reclaim when there is sufficient memory(before LMKD trigger),
> this will cause higher block IO.

Yes there are heuristics which might override the global swappinness but
have you investigated those cases and can show that those heuristics
could be changed?

[...]
> > It is quite likely that a IO cost aspect is not really easy to integrate
> > into the memory reclaim but it seems to me this is a better way to focus
> > on for a better long term solution. Our existing refaulting
> > infrastructure should help in that respect. Also MGLRU could fit for
> > that purpose better than the traditional LRU based reclaim as the higher
> > generations could be used for more more expensive pages.
> 
> Yes, your insights are very informative.
> 
> However, before our algorithm is perfected, I think it is reasonable
> to provide different reclaim tendencies for the active reclaim
> interface. This will provide greater flexibility for the strategy
> layer.

Flexibility is really nice but it comes with a price and interface cost
can be really high. There were several attempts to make memory reclaim
LRU type specific but I still maintain my opinion that this is not
really a good abstraction. As stated above even page cache is not all
the same. A more future proof interface should really consider the IO
refault cost rather than all anon/file.

-- 
Michal Hocko
SUSE Labs
