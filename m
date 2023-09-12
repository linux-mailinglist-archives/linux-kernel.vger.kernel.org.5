Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39679D353
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjILOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjILOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:10:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637110D;
        Tue, 12 Sep 2023 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1H8ls+IQkRjOoHBohtS89ylg9Re+cJdFS9AQQT8Ndhg=; b=q0IYV6V/ayldHIS9jOHJgEblCA
        l0sDCPR7g5Kxq7OOYmWyXC9GIx8gQP9d42a/jxpZrr1T+kvOvU2XJFacUARSih9SEGoHSjJU+Pc6j
        KS3WngUvRlzMrudf2Aoy28JxpeIyMlnXOelIdmVEVSLuungSmw4Nrh0E/YMnf5lona7sYSxHq87yF
        6xfa5G6QaSU+u7teIIdNjgu9UjHDfnApcbaS2cjToufYF4XsGyw088elsxEkm4q9Vghw4H3Ys0Hzw
        hNFP+xoau2giFfvRvE715f/C3qmTeWWd8gk9nRAgxM+qwWeKnyoPkal6WvEp9QGaJnfX2jGEkmk4t
        b0Q/U0fQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg45e-007yYW-7T; Tue, 12 Sep 2023 14:10:06 +0000
Date:   Tue, 12 Sep 2023 15:10:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <ZQBxPmVmBJ7J+b4B@casper.infradead.org>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911235452.xhtnt7ply7ayr53x@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> Taking the mutex lock in kernel/irq/manage.c __setup_irq() is calling a
> cond_resched().
> 
> >From what Michael said [1] in this thread, since something has already
> set TIF_NEED_RESCHED, it will eventually enable interrupts on us.
> 
> I've traced this to running call_rcu() in kernel/rcu/tiny.c and
> is_idle_task(current) is true, which means rcu runs:
> 		/* force scheduling for rcu_qs() */                                                                     
>                 resched_cpu(0);
> 
> the task is set idle in sched_init() -> init_idle() and never changed,
> afaict.

Should calling init_idle() be deferred until after interrupts are
all set up?

