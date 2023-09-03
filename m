Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A424790F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349813AbjICXld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 19:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjICXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 19:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26713ED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 16:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E17BB80C8D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 23:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3434C433C7;
        Sun,  3 Sep 2023 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693784485;
        bh=d2d2yCtdrnpA+uDMHDupCkno7OobYwOAfSjjRCeJYKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pm5j8fZ/yvzMHAwKFZGO64LnDDUhM83kL/2EbMODckRmquaO6SysDub+XWi8RZt7O
         EtY7rg6QeRvVXk0t3XlJW08V4vHgpyfkpZn65Pdl0QfitYOcYAbjsrBRWOt7iLBpuC
         TZv9vrScPGhHnWzx14KvfPKB+IfvshHMqP0/XhgQ=
Date:   Sun, 3 Sep 2023 16:41:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <wangkefeng.wang@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
Message-Id: <20230903164122.fb7148f8004402a7552c3ec6@linux-foundation.org>
In-Reply-To: <20230828022527.241693-1-tongtiangen@huawei.com>
References: <20230828022527.241693-1-tongtiangen@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 10:25:27 +0800 Tong Tiangen <tongtiangen@huawei.com> wrote:

> We found a softlock issue in our test, analyzed the logs, and found that
> the relevant CPU call trace as follows:
> 
> ...
> 
> By removing the use of tasklist_lock in task list iteration, we can break
> the softlock chain above.
> 

So I assume we'd like to backport this fix into -stable kernels?

If so, are we able to identify a suitble Fixes: target?
