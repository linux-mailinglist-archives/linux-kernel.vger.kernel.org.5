Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653E380163B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441827AbjLAWW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjLAWW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA261F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701469351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gr/vivmu3OY8SoUw97PpQV6NswBnu4o/GskzZwhXj8I=;
        b=AS8Lbj1+79xHahVfMHliL/vVzXETiOp2mbnw1RF36w/nhb3CHeGp1R96MY4Dn/3uB9lNbN
        rhXjRS/Nch38i0l/gtrfwJpI35N0FSUlpJMKoNTVPZoyHjHDXrAWunGLGI7IhhI1td2HBt
        OT/udt9s5w5Tdro/WUzaajNRlwUDqzQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-0eC6rJOgP7O6kmED4n3ZYA-1; Fri,
 01 Dec 2023 17:22:27 -0500
X-MC-Unique: 0eC6rJOgP7O6kmED4n3ZYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4208529ABA39;
        Fri,  1 Dec 2023 22:22:27 +0000 (UTC)
Received: from [10.22.17.155] (unknown [10.22.17.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9FEE40C6EB9;
        Fri,  1 Dec 2023 22:22:26 +0000 (UTC)
Message-ID: <597352bb-6afa-4fa4-a5ee-1f0aa14e61be@redhat.com>
Date:   Fri, 1 Dec 2023 17:22:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kmemleak: Avoid RCU stalls when freeing metadata for
 per-CPU pointers
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231201190829.825856-1-catalin.marinas@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231201190829.825856-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 14:08, Catalin Marinas wrote:
> On systems with large number of CPUs, the following soft lockup splat
> might sometimes happen:
>
> [ 2656.001617] watchdog: BUG: soft lockup - CPU#364 stuck for 21s! [ksoftirqd/364:2206]
>    :
> [ 2656.141194] RIP: 0010:_raw_spin_unlock_irqrestore+0x3d/0x70
>    :
>   2656.241214] Call Trace:
> [ 2656.243971]  <IRQ>
> [ 2656.246237]  ? show_trace_log_lvl+0x1c4/0x2df
> [ 2656.251152]  ? show_trace_log_lvl+0x1c4/0x2df
> [ 2656.256066]  ? kmemleak_free_percpu+0x11f/0x1f0
> [ 2656.261173]  ? watchdog_timer_fn+0x379/0x470
> [ 2656.265984]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 2656.271179]  ? __hrtimer_run_queues+0x5f3/0xd00
> [ 2656.276283]  ? __pfx___hrtimer_run_queues+0x10/0x10
> [ 2656.281783]  ? ktime_get_update_offsets_now+0x95/0x2c0
> [ 2656.287573]  ? ktime_get_update_offsets_now+0xdd/0x2c0
> [ 2656.293380]  ? hrtimer_interrupt+0x2e9/0x780
> [ 2656.298221]  ? __sysvec_apic_timer_interrupt+0x184/0x640
> [ 2656.304211]  ? sysvec_apic_timer_interrupt+0x8e/0xc0
> [ 2656.309807]  </IRQ>
> [ 2656.312169]  <TASK>
> [ 2656.326110]  kmemleak_free_percpu+0x11f/0x1f0
> [ 2656.331015]  free_percpu.part.0+0x1b/0xe70
> [ 2656.335635]  free_vfsmnt+0xb9/0x100
> [ 2656.339567]  rcu_do_batch+0x3c8/0xe30
> [ 2656.363693]  rcu_core+0x3de/0x5a0
> [ 2656.367433]  __do_softirq+0x2d0/0x9a8
> [ 2656.381119]  run_ksoftirqd+0x36/0x60
> [ 2656.385145]  smpboot_thread_fn+0x556/0x910
> [ 2656.394971]  kthread+0x2a4/0x350
> [ 2656.402826]  ret_from_fork+0x29/0x50
> [ 2656.406861]  </TASK>
>
> The issue is caused by kmemleak registering each per_cpu_ptr()
> corresponding to the __percpu pointer. This is unnecessary since such
> individual per-CPU pointers are not tracked anyway. Create a new
> object_percpu_tree_root rbtree that stores a single __percpu pointer
> together with an OBJECT_PERCPU flag for the kmemleak metadata. Scanning
> needs to be done for all per_cpu_ptr() pointers with a cond_resched()
> between each CPU iteration to avoid RCU stalls.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Waiman Long <longman@redhat.com>
> Link: https://lore.kernel.org/r/20231127194153.289626-1-longman@redhat.com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> The only difference from the inlined patch I posted previously is some updated
> comments to include the new object tree.
>
>   mm/kmemleak.c | 178 +++++++++++++++++++++++++++-----------------------
>   1 file changed, 97 insertions(+), 81 deletions(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 1eacca03bedd..eb6cdc3e9af2 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -14,17 +14,15 @@
>    * The following locks and mutexes are used by kmemleak:
>    *
>    * - kmemleak_lock (raw_spinlock_t): protects the object_list as well as
> - *   del_state modifications and accesses to the object_tree_root (or
> - *   object_phys_tree_root). The object_list is the main list holding the
> - *   metadata (struct kmemleak_object) for the allocated memory blocks.
> - *   The object_tree_root and object_phys_tree_root are red
> - *   black trees used to look-up metadata based on a pointer to the
> - *   corresponding memory block. The object_phys_tree_root is for objects
> - *   allocated with physical address. The kmemleak_object structures are
> - *   added to the object_list and object_tree_root (or object_phys_tree_root)
> - *   in the create_object() function called from the kmemleak_alloc() (or
> - *   kmemleak_alloc_phys()) callback and removed in delete_object() called from
> - *   the kmemleak_free() callback
> + *   del_state modifications and accesses to the object trees
> + *   (object_tree_root, object_phys_tree_root, object_percpu_tree_root). The
> + *   object_list is the main list holding the metadata (struct
> + *   kmemleak_object) for the allocated memory blocks. The object trees are
> + *   red black trees used to look-up metadata based on a pointer to the
> + *   corresponding memory block. The kmemleak_object structures are added to
> + *   the object_list and the object tree root in the create_object() function
> + *   called from the kmemleak_alloc() (or kmemleak_alloc_phys()) callback and
> + *   removed in delete_object() called from the kmemleak_free() callback

Just a minor nit. For completeness, should we mention 
kmemleak_alloc_percpu() and kmemleak_free_percpu() here?

Anyway, I won't mind if you want to keep it as it is.

Reviewed-by: Waiman Long <longman@redhat.com>


