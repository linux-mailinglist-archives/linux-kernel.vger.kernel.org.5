Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2A7822E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjHUEf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjHUEf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:35:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB829D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u5DXn3RCOBSJ44dL6qFWPU5pU6G66h+YoZliAofL6wY=; b=XS4ka/R3I6a2u1Lf7ZwEhgEADY
        jDNbYFgT/R6B4Q9TsLi/bp32Iy9+2GtIOg2gDLYcNaxL7oqQasjWL+maul+4VXs/uswgbPRGMed5e
        peHCdNlknOqjOTBMzlTsEPu4qXhL14H9OG0rC7YOllBanDn2nXnfv54HX1Lr7RyU0vZwNjdULDGEg
        GGaF5lRt5cI8ntM2rMxVItixo6NpkMbb/xXcr6oa0jhkpLQO4qI/iGqVXWLr2rgSFNEqJTBT+t308
        n1sYy0B4gOf9SKrNu68sS41vf/jR5reHiBotO7eOWpD/o81Ynuxg4zcnK2sFKiZsSMfOyTPZECxzW
        /FUg3+Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXwcx-0089YH-Ro; Mon, 21 Aug 2023 04:34:55 +0000
Date:   Mon, 21 Aug 2023 05:34:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, wangkefeng.wang@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
Message-ID: <ZOLpbwwk4esztLaO@casper.infradead.org>
References: <20230821022534.1381092-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821022534.1381092-1-tongtiangen@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:25:34AM +0800, Tong Tiangen wrote:
> +++ b/mm/memory-failure.c
> @@ -546,24 +546,26 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
>   * Find a dedicated thread which is supposed to handle SIGBUS(BUS_MCEERR_AO)
>   * on behalf of the thread group. Return task_struct of the (first found)
>   * dedicated thread if found, and return NULL otherwise.
> - *
> - * We already hold read_lock(&tasklist_lock) in the caller, so we don't
> - * have to call rcu_read_lock/unlock() in this function.
>   */
>  static struct task_struct *find_early_kill_thread(struct task_struct *tsk)
>  {
>  	struct task_struct *t;
>  
> +	rcu_read_lock();
>  	for_each_thread(tsk, t) {
>  		if (t->flags & PF_MCE_PROCESS) {
>  			if (t->flags & PF_MCE_EARLY)
> -				return t;
> +				goto found;
>  		} else {
>  			if (sysctl_memory_failure_early_kill)
> -				return t;
> +				goto found;
>  		}
>  	}
> -	return NULL;
> +
> +	t = NULL;
> +found:
> +	rcu_read_unlock();
> +	return t;
>  }

I don't understand why you need to modify find_early_kill_thread() at
all.  It's still true that the caller holds _a_ lock protecting it; the
comment needs to be updated to reflect that it might be the RCU lock
or the tasklist_lock (or did you change all callers?), but there's no
need for this function to take the RCU lock itself, afaics?
