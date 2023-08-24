Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36D787788
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbjHXSM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbjHXSMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:12:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D35519BF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:12:14 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-410904c823bso381891cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692900733; x=1693505533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuuF/qc7JO7c6ziVtaJGSF7Qv+JRdsn1Fk4XLjNPqWs=;
        b=c7fvdJax6l2ITP0jFGXS2CgYePpQsJXtK0pFCVrv6m+QfbcCUVdy4DBiESXTqCdsgf
         fVq9HwXQCawALw4vyPnsHP0V+H2JXtFhugqbw4alavySpmLqun7s3fFCOnIUxyZTAhnA
         xAPRV+/m5O2FeQV7WZwEAQXxpNBeZMNNc/Jr4d9gdCGwWaWhdLg+lVFweiZf3MVCpsf2
         cJFXChc4i2nIWpuorrmqceuJX35KFW8YHfYmcgAeVOuTMI0DduKfuOgb8aedYpR3BgB/
         6u5yg6GhyAY9vhtspHKl5fO3pdOEDUQdNd8vcTymY+ECjYTjP3MQvAwKhV10aFJYzst8
         OtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692900733; x=1693505533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuuF/qc7JO7c6ziVtaJGSF7Qv+JRdsn1Fk4XLjNPqWs=;
        b=JP5sNDu6N05dgC16czRUf1REOVcugkmrzS/XXqMFLOzUZZPLH+N6K4Wqw+I64PWIzl
         fYcDswohcudyQg+l48ImTr31uGOP7T58e92kLTrZQKfrYusKuR7dotzlLBvHIqXd9pfH
         JKmv9O0Ur+2XNz3Zxb5+SnZNDoKpTK5jiQaN6C/ax34GxoKURAcplBwZQoWHlrr1KDw2
         Es4Q8i0eqm1wUAjP28wn7pV/OvEdJNCuLgQ5/vcBTQroLvPDroRgcj/pqnX3dOf5AUxh
         +edbjaQzmwVItXhcFZSWpumi40Vf0RaXllFzDYm+JSfDf0H4CcfaseqSn2Pa9eHE4DXn
         kz5w==
X-Gm-Message-State: AOJu0YycJQJGLCG42wjdlXygJU3fcEEiAqYEdsf/d9gPEkTKW5g6D96z
        JS+qrdfRo0ezkbVqBUPL83jaaA==
X-Google-Smtp-Source: AGHT+IHu1PsOpgvkuiM7qhf/G0nr+OTNzG8VGZrJbmP2XF9fKlAIhE1YvkAQCluLz8I0aUC+SNvW2Q==
X-Received: by 2002:ac8:5712:0:b0:410:487:27f3 with SMTP id 18-20020ac85712000000b00410048727f3mr20387054qtw.27.1692900733526;
        Thu, 24 Aug 2023 11:12:13 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-7ffd-0cf9-a739-5564.res6.spectrum.com. [2603:7000:c01:2716:7ffd:cf9:a739:5564])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87fc6000000b00410a91e9f26sm5074qtk.20.2023.08.24.11.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:12:13 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:12:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, kernel-team@meta.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, yosryahmed@google.com,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] memcontrol: ensure memcg acquired by id is properly set
 up
Message-ID: <20230824181212.GA278867@cmpxchg.org>
References: <20230823225430.166925-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823225430.166925-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Shakeel

On Wed, Aug 23, 2023 at 03:54:30PM -0700, Nhat Pham wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> In the eviction recency check, we attempt to retrieve the memcg to which
> the folio belonged when it was evicted, by the memcg id stored in the
> shadow entry. However, there is a chance that the retrieved memcg is not
> the original memcg that has been killed, but a new one which happens to
> have the same id.
> 
> This is a somewhat unfortunate, but acceptable and rare inaccuracy in
> the heuristics. However, if we retrieve this new memcg between its
> allocation and when it is properly attached to the memcg hierarchy, we
> could run into the following NULL pointer exception during the memcg
> hierarchy traversal done in mem_cgroup_get_nr_swap_pages():
> 
> [ 155757.793456] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> [ 155757.807568] #PF: supervisor read access in kernel mode
> [ 155757.818024] #PF: error_code(0x0000) - not-present page
> [ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 PMD 0
> [ 155757.839985] Oops: 0000 [#1] SMP
> [ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> [ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 c0 00 00 00 48 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 48 39 d1 74 42 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 00 00 48
> [ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 00010286
> [ 155757.947755] RAX: 00000000003a3b1c RBX: 000007ffffffffff RCX: ffff888280183000
> [ 155757.962202] RDX: 0000000000000000 RSI: 0007ffffffffffff RDI: ffff888bbc2d1000
> [ 155757.976648] RBP: 0000000000000001 R08: 000000000000000b R09: ffff888ad9cedba0
> [ 155757.991094] R10: ffffea0039c07900 R11: 0000000000000010 R12: ffff888b23a7b000
> [ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d1000 R15: 000007ffffc71354
> [ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9c0000(0000) knlGS:0000000000000000
> [ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb8004 CR4: 00000000007706e0
> [ 155758.062473] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 155758.091376] PKRU: 55555554
> [ 155758.096957] Call Trace:
> [ 155758.102016]  <TASK>
> [ 155758.106502]  ? __die+0x78/0xc0
> [ 155758.112793]  ? page_fault_oops+0x286/0x380
> [ 155758.121175]  ? exc_page_fault+0x5d/0x110
> [ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
> [ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> [ 155758.148060]  workingset_test_recent+0xda/0x1b0
> [ 155758.157133]  workingset_refault+0xca/0x1e0
> [ 155758.165508]  filemap_add_folio+0x4d/0x70
> [ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
> [ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
> [ 155758.191738]  filemap_read+0x68d/0xdf0
> [ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
> [ 155758.207981]  ? __napi_schedule+0x55/0x90
> [ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
> [ 155758.224601]  do_syscall_64+0x3d/0x80
> [ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [ 155758.242473] RIP: 0033:0x7f62c29153b5
> [ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 e8 b4 e6 f7 ff 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 ff 48 8b
> [ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
> [ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c0 RCX: 00007f62c29153b5
> [ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d2986000 RDI: 0000000000000076
> [ 155758.332678] RBP: 00007f6234c5fff0 R08: 0000000000000000 R09: 0000000064d5230c
> [ 155758.347452] R10: 000000000027d450 R11: 0000000000000293 R12: 000000000003c041
> [ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b060 R15: 000000000027d450
> [ 155758.376661]  </TASK>
> 
> This patch fixes the issue by moving the memcg's id publication from the
> alloc stage to online stage, ensuring that any memcg acquired via id
> must be connected to the memcg tree.
> 
> Fixes: f78dfc7b77d5 ("workingset: fix confusion around eviction vs refault container")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/memcontrol.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cf57fe9318d5..6d67a3a81cd9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5326,7 +5326,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
>  	memcg->deferred_split_queue.split_queue_len = 0;
>  #endif
> -	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
>  	lru_gen_init_memcg(memcg);
>  	return memcg;
>  fail:
> @@ -5398,14 +5397,27 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	if (alloc_shrinker_info(memcg))
>  		goto offline_kmem;
>  
> -	/* Online state pins memcg ID, memcg ID pins CSS */
> -	refcount_set(&memcg->id.ref, 1);
> -	css_get(css);
> -
>  	if (unlikely(mem_cgroup_is_root(memcg)))
>  		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
>  				   FLUSH_TIME);
>  	lru_gen_online_memcg(memcg);
> +
> +	/* Online state pins memcg ID, memcg ID pins CSS */
> +	refcount_set(&memcg->id.ref, 1);
> +	css_get(css);
> +
> +	/*
> +	 * Ensure mem_cgroup_from_id() works once we're fully online.
> +	 *
> +	 * We could do this earlier and require callers to filter with
> +	 * css_tryget_online(). But right now there are no users that
> +	 * need earlier access, and the workingset code relies on the
> +	 * cgroup tree linkage (mem_cgroup_get_nr_swap_pages()). So
> +	 * publish it here at the end of onlining. This matches the
> +	 * regular ID destruction during offlining.
> +	 */
> +	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
> +
>  	return 0;
>  offline_kmem:
>  	memcg_offline_kmem(memcg);
> -- 
> 2.34.1
> 
