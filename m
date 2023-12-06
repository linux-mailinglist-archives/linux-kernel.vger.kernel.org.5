Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DB4806E00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377612AbjLFLbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377753AbjLFLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:31:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDF1A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:31:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8A5C433C7;
        Wed,  6 Dec 2023 11:31:16 +0000 (UTC)
Date:   Wed, 6 Dec 2023 11:31:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kmemleak: Avoid RCU stalls when freeing metadata for
 per-CPU pointers
Message-ID: <ZXBbgv6is4JdfXs3@arm.com>
References: <20231201190829.825856-1-catalin.marinas@arm.com>
 <597352bb-6afa-4fa4-a5ee-1f0aa14e61be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597352bb-6afa-4fa4-a5ee-1f0aa14e61be@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:22:26PM -0500, Waiman Long wrote:
> On 12/1/23 14:08, Catalin Marinas wrote:
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index 1eacca03bedd..eb6cdc3e9af2 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -14,17 +14,15 @@
> >    * The following locks and mutexes are used by kmemleak:
> >    *
> >    * - kmemleak_lock (raw_spinlock_t): protects the object_list as well as
> > - *   del_state modifications and accesses to the object_tree_root (or
> > - *   object_phys_tree_root). The object_list is the main list holding the
> > - *   metadata (struct kmemleak_object) for the allocated memory blocks.
> > - *   The object_tree_root and object_phys_tree_root are red
> > - *   black trees used to look-up metadata based on a pointer to the
> > - *   corresponding memory block. The object_phys_tree_root is for objects
> > - *   allocated with physical address. The kmemleak_object structures are
> > - *   added to the object_list and object_tree_root (or object_phys_tree_root)
> > - *   in the create_object() function called from the kmemleak_alloc() (or
> > - *   kmemleak_alloc_phys()) callback and removed in delete_object() called from
> > - *   the kmemleak_free() callback
> > + *   del_state modifications and accesses to the object trees
> > + *   (object_tree_root, object_phys_tree_root, object_percpu_tree_root). The
> > + *   object_list is the main list holding the metadata (struct
> > + *   kmemleak_object) for the allocated memory blocks. The object trees are
> > + *   red black trees used to look-up metadata based on a pointer to the
> > + *   corresponding memory block. The kmemleak_object structures are added to
> > + *   the object_list and the object tree root in the create_object() function
> > + *   called from the kmemleak_alloc() (or kmemleak_alloc_phys()) callback and
> > + *   removed in delete_object() called from the kmemleak_free() callback
> 
> Just a minor nit. For completeness, should we mention
> kmemleak_alloc_percpu() and kmemleak_free_percpu() here?

Yeah, I was too lazy. I added some shell-style patterns and repost a v2.

> Anyway, I won't mind if you want to keep it as it is.
> 
> Reviewed-by: Waiman Long <longman@redhat.com>

Thanks.

-- 
Catalin
