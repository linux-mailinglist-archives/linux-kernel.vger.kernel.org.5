Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE117736A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHHCbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHHCbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:31:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6914AB8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WHsJ5PGsU4+tfkyeNNQHPH4OunTTy5kmFE5MgCkPN04=; b=ei1FJsHcAD7Yw52EAxHZqGXK1h
        TAHwiPrB641GNDT1/jXUFn6ixPvzYWUXO7dJP4rnXTj53H7RM9CSPh9Plw4Zs6DjDlyzikvAbkhFR
        D06YMoJmEmYQWCFoBcZO2+U/Wez1wj3ZWZwpEotiPrcQYMz4tTRMf4C9qeJolJI/cDd6Rsu/AyWUj
        Le5mXggDMdIXahNr3B5ARePSKFyqL5jvh9Zs57leECNGarItFZ11mCFAIWz7IxUb1cH8/Az/gVkLf
        VZf3SmF6u2i8J3GbP/j/SpGZoJ3p9uknnGhmP1iV7wgOsOFVq7n09rJikBuJQ8kqvUzcplbXjRraR
        fhvwjdPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTCUv-00EqE4-Cv; Tue, 08 Aug 2023 02:31:01 +0000
Date:   Tue, 8 Aug 2023 03:31:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove unneeded __meminit annotation
Message-ID: <ZNGo5Y4vQ3rQn0vf@casper.infradead.org>
References: <20230808015831.608454-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808015831.608454-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:58:31AM +0800, Miaohe Lin wrote:
> kswapd_stop() and kcompactd_stop() are only called when MEMORY_HOTREMOVE
> is enabled. So wrap them under CONFIG_MEMORY_HOTREMOVE and further remove
> __meminit annotation. No functional change intended.

I don't understand why this is an improvement.  If CONFIG_MEMORY_HOTREMOVE
is disabled, the linker drops this section (... right?)  If it's enabled,
then it gets shunted off into a cold section.  So it seems like this
patch strictly makes things worse.  But maybe I misunderstood.
