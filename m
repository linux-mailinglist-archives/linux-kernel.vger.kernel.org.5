Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDB3806DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378135AbjLFLWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378005AbjLFLWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:22:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DBDC3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:22:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF6CC433C8;
        Wed,  6 Dec 2023 11:22:25 +0000 (UTC)
Date:   Wed, 6 Dec 2023 11:22:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kmemleak: Avoid RCU stalls when freeing metadata for
 per-CPU pointers
Message-ID: <ZXBZbopxmmJFxO6x@arm.com>
References: <20231201190829.825856-1-catalin.marinas@arm.com>
 <20231202075055.1142-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202075055.1142-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 03:50:55PM +0800, Hillf Danton wrote:
> On Fri,  1 Dec 2023 19:08:29 +0000 Catalin Marinas <catalin.marinas@arm.com>
> > @@ -1472,14 +1474,27 @@ static void scan_object(struct kmemleak_object *object)
> >  		/* already freed object */
> >  		goto out;
> >  
> > -	obj_ptr = object->flags & OBJECT_PHYS ?
> > -		  __va((phys_addr_t)object->pointer) :
> > -		  (void *)object->pointer;
> > +	if (object->flags & OBJECT_PERCPU) {
> > +		unsigned int cpu;
> >  
> > -	if (hlist_empty(&object->area_list) ||
> > +		for_each_possible_cpu(cpu) {
> > +			void *start = per_cpu_ptr((void __percpu *)object->pointer, cpu);
> > +			void *end = start + object->size;
> > +
> > +			scan_block(start, end, object);
> > +
> > +			raw_spin_unlock_irqrestore(&object->lock, flags);
> > +			cond_resched();
> > +			raw_spin_lock_irqsave(&object->lock, flags);
> 
> Nit, spin_lock/unlock can be collapsed into need_resched().
> 
> 			if (need_resched()) {
> 				raw_spin_unlock_irqrestore(&object->lock, flags);
> 				cond_resched();
> 				raw_spin_lock_irqsave(&object->lock, flags);
> 			}

The reason I'd not do this is that we also want the interrupts to be
re-enabled regularly. Keeping them disabled may not even mark the
current thread as need_resched().

-- 
Catalin
