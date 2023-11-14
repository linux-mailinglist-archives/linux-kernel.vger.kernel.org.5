Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4542A7EAD77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjKNJ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjKNJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:56:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2D196;
        Tue, 14 Nov 2023 01:56:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 676541F88C;
        Tue, 14 Nov 2023 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699955774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GG7NCpHlhpgiMdgXsq8txfPY7HgpMI0ELvqXsyMN+B0=;
        b=hzCYTQBJV6q9NahjU4QC8ODSVzO4KARfcX97NAUs4WT+dSDgRUqFx8rsLI30drDqNlZTdU
        jbH86i3mWSFr/g0leK9WamFVwbAVE5oXrRU8Ym4KrIqqFolONbutgSEZzXSMszmonbzd5b
        AHwy543zVn+4Ib+X9Afgd5Y8XFB8kWs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4553C13416;
        Tue, 14 Nov 2023 09:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sBznDT5EU2XaHgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 09:56:14 +0000
Date:   Tue, 14 Nov 2023 10:56:13 +0100
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
Message-ID: <ZVNEPRE_JxUaqw94@tiehlicka>
References: <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
 <ZUziy-6QPdTIDJlm@tiehlicka>
 <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>
 <ZU4g9XZvi9mRQD27@tiehlicka>
 <b4694fbf-92df-4067-878e-6035df46582f@vivo.com>
 <87edgufakm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a09e21a6-6a1e-44ec-9187-600a0a969a45@vivo.com>
 <87a5rif58s.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <97a3dbb3-9e73-4dcc-877d-f491ff47363b@vivo.com>
 <ZVNDvNok1B8qVHOe@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVNDvNok1B8qVHOe@tiehlicka>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.43
X-Spamd-Result: default: False [-2.43 / 50.00];
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
         BAYES_HAM(-0.33)[75.79%];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[23];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[intel.com,kernel.org,bytedance.com,cmpxchg.org,lwn.net,linux.dev,google.com,linux-foundation.org,redhat.com,infradead.org,huawei.com,gmail.com,vger.kernel.org,kvack.org,vivo.com];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-11-23 10:54:05, Michal Hocko wrote:
> On Mon 13-11-23 16:26:00, Huan Yang wrote:
> [...]
> > However, considering that we need to perform proactive reclaim in batches,
> > suppose that only 5% of the use-once page cache in this memcg can be
> > reclaimed,
> > but we need to call proactive memory reclaim step by step, such as 5%, 10%,
> > 15% ... 100%.
> 
> You haven't really explained this and I have asked several times IIRC.
> Why do you even need to do those batches? Why cannot you simply relly on
> the memory pressure triggering the memory reclaim? Do you have any
> actual numbers showing that being pro-active results in smaller
> latencies or anything that would show this is actually needed?

Just noticed dcd2eff8-400b-4ade-a5b2-becfe26b437b@vivo.com, will reply
there.

-- 
Michal Hocko
SUSE Labs
