Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5577A303
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjHLVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHLVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 17:08:35 -0400
Received: from out-116.mta0.migadu.com (out-116.mta0.migadu.com [IPv6:2001:41d0:1004:224b::74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72869171F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 14:08:37 -0700 (PDT)
Date:   Sat, 12 Aug 2023 17:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691874515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eaM9Ujbos99cyrU1uB877mFFJPMvCQ+OsuRoTMN5V4=;
        b=FecZxpFFVUspz1h+6lEkNxYH+mFj66mNpl3thjCM4xhpqPfgbWzeAvhS2Fn62tRWDvL9+k
        VVZAJjBUeu0Te/Tgl0QRezhv7lI8LaKex1qM0vYQDagvS7K0jGwCgieg3Xx++1AX8rUd0g
        JJBrlGpPBPd0pSWa5faVmeMzH1XwCl0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] bcachefs: six locks: Fix missing barrier on
 wait->lock_acquired
Message-ID: <20230812210830.qomi2jacnkc6ogfo@moria.home.lan>
References: <20230812192720.2703874-1-kent.overstreet@linux.dev>
 <ZNfkaqfGwM8fIG7q@boqun-archlinux>
 <ZNfykqAGhT6RT8BH@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNfykqAGhT6RT8BH@boqun-archlinux>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 01:58:58PM -0700, Boqun Feng wrote:
> Given the whole percpu counters for readers thing is similar to
> percpu_rw_semaphore, I took a look at percpu_rwsem and wonder there is
> a path to combine that with SIX lock. And that makes me realize another
> fix may be needed here, considering the following case:
> 
> 	Task A					Task B
> 	======					======
> 	__six_lock_wakeup():
> 	  task = w->task;
> 	  ...
> 	  smp_store_release(&w->locked_acquire, true);
> 	  					six_lock_slowpath():
> 						  while (1) {
> 						    if (smp_load_acquire(->lock_acquired))
> 						      break;
> 						  }
> 
> 						six_unlock();
> 						do_exit(); // Task B ends its life :(
> 
> 	  wake_up_process(task); // @task is a dangling task pointer!!!
> 
> Looks like get_task_struct() and put_task_struct() are needed here:
> similar to percpu_rwsem_wake_function().

yeah, looks like you're right. Shame about adding more atomics here,
maybe we can convert task->ref to a percpu refcount at some point.
