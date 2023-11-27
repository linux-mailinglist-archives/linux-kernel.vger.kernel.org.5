Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE17FACB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjK0Vm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjK0Vmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:42:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51801131
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:43:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A920C433C7;
        Mon, 27 Nov 2023 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701121380;
        bh=CoO2w1Aaayjts+dtvAb8Eh6H5/dRtPDx1TPM+uYjYAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RERa00m1APTZ4nW8M04Rfr5i0iygE8BDQ0e6DmhSMgrHZ7Jw8YuA+xtP69/WxezsS
         rJMo7RPAVGmSaP6y2uf2uCKw0+eW38cOjgSScmhCD+QpioQ4N661eUERXRrVP0Lsvr
         wLF7BGf+jgv/d4EqPdkzSwHborOYqRliIGg2SYhE=
Date:   Mon, 27 Nov 2023 13:42:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v6 2/6] memcontrol: allows mem_cgroup_iter() to check
 for onlineness
Message-Id: <20231127134259.67b69ab47f4f88c9751e5222@linux-foundation.org>
In-Reply-To: <20231127193703.1980089-3-nphamcs@gmail.com>
References: <20231127193703.1980089-1-nphamcs@gmail.com>
        <20231127193703.1980089-3-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 11:36:59 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> The new zswap writeback scheme requires an online-only memcg hierarchy
> traversal. Add a new parameter to mem_cgroup_iter() to check for
> onlineness before returning.

I get a few build errors, perhaps because of patch timing issues...

mm/shrinker_debug.c: In function 'shrinker_debugfs_count_show':
mm/shrinker_debug.c:64:17: error: too few arguments to function 'mem_cgroup_iter'
   64 |         memcg = mem_cgroup_iter(NULL, NULL, NULL);
      |                 ^~~~~~~~~~~~~~~
In file included from mm/shrinker_debug.c:7:
./include/linux/memcontrol.h:833:20: note: declared here
  833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
      |                    ^~~~~~~~~~~~~~~
mm/shrinker_debug.c:89:27: error: too few arguments to function 'mem_cgroup_iter'
   89 |         } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
      |                           ^~~~~~~~~~~~~~~
./include/linux/memcontrol.h:833:20: note: declared here
  833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
      |                    ^~~~~~~~~~~~~~~
mm/damon/sysfs-schemes.c: In function 'damon_sysfs_memcg_path_to_id':
mm/damon/sysfs-schemes.c:1594:22: error: too few arguments to function 'mem_cgroup_iter'
 1594 |         for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
      |                      ^~~~~~~~~~~~~~~
In file included from ./include/linux/damon.h:11,
                 from mm/damon/sysfs-common.h:8,
                 from mm/damon/sysfs-schemes.c:10:
./include/linux/memcontrol.h:833:20: note: declared here
  833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
      |                    ^~~~~~~~~~~~~~~
mm/damon/sysfs-schemes.c:1595:33: error: too few arguments to function 'mem_cgroup_iter'
 1595 |                         memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
      |                                 ^~~~~~~~~~~~~~~
./include/linux/memcontrol.h:833:20: note: declared here
  833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
      |                    ^~~~~~~~~~~~~~~

> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -832,7 +832,7 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  
>  struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
>  				   struct mem_cgroup *,
> -				   struct mem_cgroup_reclaim_cookie *);
> +				   struct mem_cgroup_reclaim_cookie *, bool online);

How many callsites do we expect to utilize the new `online' argument? 
Few, I suspect.

How about we fix the above and simplify the patch by adding a new
mem_cgroup_iter_online() and make mem_cgroup_iter() a one-line wrapper
which calls that and adds the online=false argument?

I also saw this, didn't investigate.

drivers/android/binder_alloc.c: In function 'binder_update_page_range':
drivers/android/binder_alloc.c:237:34: error: too few arguments to function 'list_lru_del'
  237 |                         on_lru = list_lru_del(&binder_alloc_lru, &page->lru);

