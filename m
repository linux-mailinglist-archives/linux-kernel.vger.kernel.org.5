Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61927CB8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjJQDAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQDAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:00:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331A8F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fg5u4Ni/fJPhlXtP8RuU5gJThlc0Dsqdf5DWdaCP7Uo=; b=OTc3hkTSBgADddbhne7CT/aF2H
        8b5+MvzRTNqsZElplGNgkesxKdue7rxgYjjIefnxhIfIH6lL4HffbkEhZxmHzLqRLolVEacFdq7Wq
        KvbXwCcg4dE4oUBuiQvnGtTAlxmIAIs5vQLfbvUbIPs/SiPMGxc8FBeXSskvl79mYTxci8VqkI+Dn
        BgMCZgH3dwGIU9PPgq6oYg/oinrEH/ACLIA6IFsfXq5jlklHR9bTv9JZfli4Ff4UKdhYC7M0JD8n/
        4jwQzqcGEDD7HO0+E/QpTxc4hOSzWXnUpDYkchuIn7GB56s6bLjac4yzgMMeDi6+GrnPJ2vvKo/dN
        mi0e9MHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsaJb-009qU7-3o; Tue, 17 Oct 2023 03:00:15 +0000
Date:   Tue, 17 Oct 2023 04:00:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: avoid a xa load for swapout path
Message-ID: <ZS34v5PGWhCdmBjI@casper.infradead.org>
References: <20231017011728.37508-1-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017011728.37508-1-ryncsn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:17:28AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> A variable is never used for swapout path (shadowp is NULL) and compiler
> is unable to optimize out the unneeded load since it's a function call.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Matthew Wilcox (Oracle)

Possibly worth adding a reference to
3852f6768ede ("mm/swapcache: support to handle the shadow entries")

Not sure it's worth a Fixes:, but that's where it was introduced.
