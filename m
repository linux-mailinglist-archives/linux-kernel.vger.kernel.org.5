Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBC75BB58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGTXzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTXzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:55:19 -0400
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9A1BD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:55:18 -0700 (PDT)
Date:   Fri, 21 Jul 2023 08:55:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689897314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbChIIegeF8b7DBlkfq1kqpyVn4AFCoYXtz9ldaoy2E=;
        b=ClcEmJFv+fA6sN063MX5EOZtHotpyMqcnkzqcAMohi+ZzAPQE62F+/bzrPAJCmZU7IeZLy
        WSMSCuvrbdxh2gzY4uQwYfrUpz3qtciOZcG2iyfC0f2fnJ/AUwzu8fU/A5QDK2h1PgcwiP
        66i1pM+Vc6CDcxmcDpRRnaA6dlxyo/I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: memory-failure: add PageOffline() check
Message-ID: <20230720235507.GA2069669@ik1-406-35019.vs.sakura.ne.jp>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-5-linmiaohe@huawei.com>
 <20230720010953.GC1583723@ik1-406-35019.vs.sakura.ne.jp>
 <0161d32a-79d8-912c-0981-496a15f3eebf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0161d32a-79d8-912c-0981-496a15f3eebf@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:42:04PM +0800, Miaohe Lin wrote:
> On 2023/7/20 9:09, Naoya Horiguchi wrote:
> > On Sat, Jul 15, 2023 at 11:17:29AM +0800, Miaohe Lin wrote:
> >> Memory failure is not interested in logically offlined page. Skip this
> >> type of pages.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/memory-failure.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 42e63b0ab5f7..ed79b69837de 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -1559,7 +1559,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> >>  	 * Here we are interested only in user-mapped pages, so skip any
> >>  	 * other types of pages.
> >>  	 */
> >> -	if (PageReserved(p) || PageSlab(p) || PageTable(p))
> >> +	if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
> > 
> > hwpoison_user_mappings() is called after some checks are done, so I'm not
> > sure that it's the right place to check PageOffline().
> 
> hwpoison_user_mappings() is called after the "if (!PageLRU(p) && !PageWriteback(p))" check in memory_failure().
> So the page can't also be PageReserved(p) or PageSlab(p) or PageTable(p) here? I think the check here just wants
> to make things clear that only user-mapped pages are interested. Or am I miss something?

No, you're right,
So this "if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))"
can be considered as checking potential deviation.
OK, so the patch is fine.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
