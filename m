Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CC3784060
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbjHVMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjHVMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:09:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E0A185
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Wx38bWn2ocEjXREWndy+Iq8q4fL7+b2AWpgeCOMij3E=; b=mdnvnBSKrWT9NQu05yJSdaK6Lf
        h09L3l9tZUeHSdLb1I9X5AH5Xj2OK9d25guBD1XJjaQWpG5Fzm8BE+b0u82yeEnjFoC0+uoCIjlud
        8sHnBy1OAdDViKXmXodzLH2FalQ/N5YNTWcBw6OfzCZyEmB7prkPXpzRA/CwR1WAi2MTOnduYzYXI
        zqIZu+O5yA2GpMdwIfcChJnKXqKvuTD1U66/wq/xbgnLaCG2UC5Q+zPr7GQBboERcYeqA+LfjqEMP
        VJI6i8PRCXY30S15lnmWmUwd+trCfW8HjNWm4mxJRKwfTXewHyVq2uXSim5J5iLvxUQw7eGXiG42i
        ZKbUIKDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYQBo-00GEKP-Br; Tue, 22 Aug 2023 12:08:52 +0000
Date:   Tue, 22 Aug 2023 13:08:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, wangkefeng.wang@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
Message-ID: <ZOSlVGxcxT9JLoUv@casper.infradead.org>
References: <20230821091312.2034844-1-tongtiangen@huawei.com>
 <ZOOt6S+I9ywyNQjP@casper.infradead.org>
 <0bbbb7d8-699b-30ac-9657-840112c41a78@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bbbb7d8-699b-30ac-9657-840112c41a78@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:41:41AM +0800, Tong Tiangen wrote:
> 在 2023/8/22 2:33, Matthew Wilcox 写道:
> > On Mon, Aug 21, 2023 at 05:13:12PM +0800, Tong Tiangen wrote:
> > > We can see that CPU1 waiting for CPU0 respond IPI，CPU0 waiting for CPU2
> > > unlock tasklist_lock, CPU2 waiting for CPU1 unlock page->ptl. As a result,
> > > softlockup is triggered.
> > > 
> > > For collect_procs_anon(), we will not modify the tasklist, but only perform
> > > read traversal. Therefore, we can use rcu lock instead of spin lock
> > > tasklist_lock, from this, we can break the softlock chain above.
> > 
> > The only thing that's giving me pause is that there's no discussion
> > about why this is safe.  "We're not modifying it" isn't really enough
> > to justify going from read_lock() to rcu_read_lock().  When you take a
> > normal read_lock(), writers are not permitted and so you see an atomic
> > snapshot of the list.  With rcu_read_lock() you can see inconsistencies.
> 
> Hi Matthew:
> 
> When rcu_read_lock() is used, the task list can be modified during the
> iteration, but cannot be seen during iteration. After the iteration is
> complete, the task list can be updated in the RCU mechanism. Therefore, the
> task list used by iteration can also be considered as a snapshot.

No, that's not true!  You are not iterating a snapshot of the list,
you're iterating the live list.  It will change under you.  RCU provides
you with some guarantees about that list.  See Documentation/RCU/listRCU.rst

> > For example, if new tasks can be added to the tasklist, they may not
> > be seen by an iteration.  Is this OK?
> 
> The newly added tasks does not access the HWPoison page, because the
> HWPoison page has been isolated from the
> buddy(memory_failure()->take_page_off_buddy()). Therefore, it is safe to see
> the newly added task during the iteration and not be seen by iteration.
> 
> Tasks may be removed from the
> > tasklist after they have been seen by the iteration.  Is this OK?
> 
> Task be seen during iteration are deleted from the task list after
> iteration, it's task_struct is not released because reference counting is
> added in __add_to_kill(). Therefore, the subsequent processing of
> kill_procs() is not affected (sending signals to the task deleted from task
> list). so i think it's safe too.

I don't know this code, but it seems unsafe to me.  Look:

collect_procs_anon:
        for_each_process(tsk) {
                struct task_struct *t = task_early_kill(tsk, force_early);
                        add_to_kill_anon_file(t, page, vma, to_kill);

add_to_kill_anon_file:
        __add_to_kill(tsk, p, vma, to_kill, 0, FSDAX_INVALID_PGOFF);

__add_to_kill:
        get_task_struct(tsk);

static inline struct task_struct *get_task_struct(struct task_struct *t)
{
        refcount_inc(&t->usage);
        return t;
}

/**
 * refcount_inc - increment a refcount
 * @r: the refcount to increment
 *
 * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
 *
 * Provides no memory ordering, it is assumed the caller already has a
 * reference on the object.
 *
 * Will WARN if the refcount is 0, as this represents a possible use-after-free
 * condition.
 */

I don't see anything that prevents that refcount_inc from seeing a zero
refcount.  Usually that would be prevented by tasklist_lock, right?

Andrew, I think this patch is bad and needs to be dropped.
