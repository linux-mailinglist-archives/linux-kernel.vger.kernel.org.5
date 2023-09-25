Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF17AD1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjIYHkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjIYHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:40:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99201DA;
        Mon, 25 Sep 2023 00:40:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44D3C21857;
        Mon, 25 Sep 2023 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695627605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSu4wGVek0BpbH4wGaaZGcCAl5X/0fUdoCQft3qzdm0=;
        b=CNO4eidZTSFsEwCrbZKgUsxjnL0x2ozTqiff12xj46x8FFPA5YgDrohM6ns2BU5VGOaQ1F
        atOF8BNkP153oygRxIF49wztP6mMmKBQVsAqrPs+gnV1VGL6qdd1jzGPqDpNVSUTHq2bwb
        KSv8Q+xk7S/tEvdGUx0YTNIFepXXP5w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2697A13A67;
        Mon, 25 Sep 2023 07:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZSFfBlU5EWUqQQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 25 Sep 2023 07:40:05 +0000
Date:   Mon, 25 Sep 2023 09:40:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <ZRE5VJozPZt9bRPy@dhcp22.suse.cz>
References: <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
 <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
 <ZQskGGAwlsr1YxAp@dhcp22.suse.cz>
 <CALvZod6b3=+=xXEUeWOQW3t_URJpeeVX46WjBHv5BS+436KoFA@mail.gmail.com>
 <ZQtRKzUOfdaVKRCF@dhcp22.suse.cz>
 <CALvZod5DSMoEGY0CwGz=P-2=Opbr4SmMfwHhZRROBx7yCaBdDA@mail.gmail.com>
 <ZQv2MXOynlEPW/bX@dhcp22.suse.cz>
 <f01b5d93-0f43-41c8-b3d8-40ef9696dcf8@linux.microsoft.com>
 <ZQwnUpX7FlzIOWXP@dhcp22.suse.cz>
 <20230922133017.GD124289@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922133017.GD124289@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-09-23 09:30:17, Johannes Weiner wrote:
> On Thu, Sep 21, 2023 at 01:21:54PM +0200, Michal Hocko wrote:
> > @@ -3097,6 +3097,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
> >  static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
> >  				   unsigned int nr_pages)
> >  {
> > +	struct page_counter *counter;
> >  	struct mem_cgroup *memcg;
> >  	int ret;
> >  
> > @@ -3107,6 +3108,10 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
> >  		goto out;
> >  
> >  	memcg_account_kmem(memcg, nr_pages);
> > +
> > +	/* There is no way to set up kmem hard limit so this operation cannot fail */
> > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +		WARN_ON(!page_counter_try_charge(&memcg->kmem, nr_pages, &counter));
> 
> This hunk doesn't look quite right.
> 
> static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
> {
> 	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
> 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> 		if (nr_pages > 0)
> 			page_counter_charge(&memcg->kmem, nr_pages);
> 		else
> 			page_counter_uncharge(&memcg->kmem, -nr_pages);
> 	}
> }
> 
> Other than that, please add

Good point. I have missed a8c49af3be5f ("memcg: add per-memcg total kernel memory stat")
introduced in 4.18

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Fixed version below. Andrew, it seems we have a good consensus for this.
Could you queue this up and send it to Linus please?
--- 
From 8c3cbe68bba0fe5103d8fe73a06b3608ed49bda0 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 21 Sep 2023 09:38:29 +0200
Subject: [PATCH] mm, memcg: reconsider kmem.limit_in_bytes deprecation

This reverts commits 86327e8eb94c ("memcg: drop kmem.limit_in_bytes")
and partially reverts 58056f77502f ("memcg, kmem: further deprecate
kmem.limit_in_bytes") which have incrementally removed support for the
kernel memory accounting hard limit. Unfortunately it has turned out
that there is still userspace depending on the existence of
memory.kmem.limit_in_bytes [1]. The underlying functionality is not
really required but the non-existent file just confuses the userspace
which fails in the result. The patch to fix this on the userspace side
has been submitted but it is hard to predict how it will propagate
through the maze of 3rd party consumers of the software.

Now, reverting alone 86327e8eb94c is not an option because there is
another set of userspace which cannot cope with ENOTSUPP returned when
writing to the file. Therefore we have to go and revisit 58056f77502f
as well. There are two ways to go ahead. Either we give up on the
deprecation and fully revert 58056f77502f as well or we can keep
kmem.limit_in_bytes but make the write a noop and warn about the fact.
This should work for both known breaking workloads which depend on the
existence but do not depend on the hard limit enforcement.

Note to backporters to stable trees. a8c49af3be5f ("memcg: add per-memcg
total kernel memory stat") introduced in 4.18 has added memcg_account_kmem
so the accounting is not done by obj_cgroup_charge_pages directly for v1
anymore. Prior kernels need to add it explicitly (thanks to Johannes for
pointing this out).

[1] http://lkml.kernel.org/r/20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
Cc: stable
Fixes: 86327e8eb94c ("memcg: drop kmem.limit_in_bytes")
Fixes: 58056f77502f ("memcg, kmem: further deprecate kmem.limit_in_bytes")
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  7 +++++++
 mm/memcontrol.c                                | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 5f502bf68fbc..ff456871bf4b 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -92,6 +92,13 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
+ memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
+                                     memory hard limit. Kernel hard limit is not
+                                     supported since 5.16. Writing any value to
+                                     do file will not have any effect same as if
+                                     nokmem kernel parameter was specified.
+                                     Kernel memory is still charged and reported
+                                     by memory.kmem.usage_in_bytes.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a4d3282493b6..63bdaab2a906 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3097,6 +3097,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 				   unsigned int nr_pages)
 {
+	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	int ret;
 
@@ -3867,6 +3868,13 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		case _MEMSWAP:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
+		case _KMEM:
+			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
+				     "Writing any value to this file has no effect. "
+				     "Please report your usecase to linux-mm@kvack.org if you "
+				     "depend on this functionality.\n");
+			ret = 0;
+			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
@@ -5077,6 +5085,12 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.seq_show = memcg_numa_stat_show,
 	},
 #endif
+	{
+		.name = "kmem.limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
 	{
 		.name = "kmem.usage_in_bytes",
 		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
