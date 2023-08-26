Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFE3789908
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjHZU24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjHZU2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:28:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EE7CF1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=GQbLFOOBAbkQ+pMFo1tY5HOEbzfs6NK86EY1TrLGlT8=; b=LdYwvMXrpVavNV7//q6Vty51Hq
        OCPautXtKdR3XtxES41NiGunhEyaALsAfzGwvQ2cv5td32/RwX4nSr1wX9xAS+yUTbgveMc6krFr5
        KPZ+3+r+SKOa9ezWPDfjo7u/MmjI184tNuRRgwoBmS/UoVUQDha+tMVeWoBHUZ4KxSxknoZyus8rM
        7yZ+jOGT/G/DD0emJyEe7Pj1UbyUJ0LYP59u2Ha3n4BZDHvX8uPkpCI/Q+O/cDoAj403dSc7m/WPs
        1L2G1gQcIObJfkqyNUmf5GxGO7wUfAH43NnYGZy2mvjhy5dWY6q3Ms0YtBB0ykWH9agvBpIGXdQS7
        5Pvz4hlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZztE-007aFb-MY; Sat, 26 Aug 2023 20:28:12 +0000
Date:   Sat, 26 Aug 2023 21:28:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, wangkefeng.wang@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
Message-ID: <ZOpgXCAAz7PAxT7b@casper.infradead.org>
References: <20230821091312.2034844-1-tongtiangen@huawei.com>
 <ZOOt6S+I9ywyNQjP@casper.infradead.org>
 <0bbbb7d8-699b-30ac-9657-840112c41a78@huawei.com>
 <ZOSlVGxcxT9JLoUv@casper.infradead.org>
 <20230825060221.GA3948311@ik1-406-35019.vs.sakura.ne.jp>
 <9e205429-1f27-4d18-faca-8a4fe9d429e3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e205429-1f27-4d18-faca-8a4fe9d429e3@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 09:46:53AM +0800, Tong Tiangen wrote:
> " the ``task_struct`` object is freed only after one or more
> grace periods elapse, with the help of call_rcu(), which is invoked via
> put_task_struct_rcu_user(). "
> 
> Combined with the code,when the task exits：
> 
> release_task()
> 	__exit_signal()
> 		__unhash_process()
> 			list_del_rcu(&p->tasks)
> 	
> 	put_task_struct_rcu_user()
> 		call_rcu(&task->rcu, delayed_put_task_struct);
> 			
> delayed_put_task_struct()
> 	put_task_struct()
> 		if (refcount_sub_and_test(nr, &t->usage))
> 			__put_task_struct()
> 				free_task()
> 	
> The code is consistent with the description in the document.
> 
> According to this understanding, i think for_each_process() under the
> protection of rcu locl is safe, that is, task_struct in the list will not be
> destroyed, and get_task_struct() is also safe.

Aha!  This is different from the usual pattern.  What I'm used to seeing
is:

if (refcount_sub_and_test()) {
	list_del_rcu();
	rcu_free();
}

and then on the read side you need a refcount_inc_not_zero(), which we
didn't have here.  Given this new information you've found, I withdraw
my objection.  It'd be nice to include some of this analysis in an
updated changelog (and maybe improved documentation for tasklist?).
