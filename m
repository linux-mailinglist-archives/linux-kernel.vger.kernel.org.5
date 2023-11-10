Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0617E8111
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbjKJSXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjKJSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:21:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE5BAF9D;
        Fri, 10 Nov 2023 01:05:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F65621985;
        Fri, 10 Nov 2023 09:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699607158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8N0qgXB3RuUcX93UjUsbFRBaIloZQvm/KDkU0Ajtwn8=;
        b=sne0KqHq0rJXX7LDtvqbXYhWk908GRUoHKXnBuXPKDEgCTehK5mPq57YZVKZFjm1kS7P7C
        lDR/X5aM9YzvcXfJnFX6zBwI8ia5Kf3T6jRtQB7SWql3inckZBrY8m1BmiFjRmcovJYw0J
        WJrEBqd+q1m43h9aur6Q49LeuppYeLA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0496213398;
        Fri, 10 Nov 2023 09:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PDtvOnXyTWUQPAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 10 Nov 2023 09:05:57 +0000
Date:   Fri, 10 Nov 2023 10:05:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, ying.huang@intel.com,
        akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, corbet@lwn.net, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZU3ydS1Puv2OHgiE@tiehlicka>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <ZUyuL9_8PPiEflnS@tiehlicka>
 <ZU0J+RU1fg8peGJH@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU0J+RU1fg8peGJH@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-11-23 11:34:01, Gregory Price wrote:
[...]
> Anyway, summarizing:  After a bit of reading, this does seem to map
> better to the "accounting consumption" subsystem than the "constrain"
> subsystem. However, if you think it's better suited for cpuset, I'm
> happy to push in that direction.

Maybe others see it differently but I stick with my previous position.
Memcg is not a great fit for reasons already mentioned - most notably
that the controller doesn't control the allocation but accounting what
has been already allocated. Cpusets on the other hand constrains the
allocations and that is exactly what you want to achieve. 
-- 
Michal Hocko
SUSE Labs
