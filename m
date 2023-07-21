Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ECC75BDB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGUFTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUFS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C23B4;
        Thu, 20 Jul 2023 22:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B776106D;
        Fri, 21 Jul 2023 05:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B047DC433C7;
        Fri, 21 Jul 2023 05:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689916735;
        bh=TTI/GlElwDYyih0KOVoE5zW1kAkMrgogNBmCmy5UeQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eB4YsL4nxl0qIm/TpuKDY5S2GXuAh7qGicWKVqPsmqj1DSokXbdb4/nHPW8ZQI4Ug
         vP1f7ciEphR0wgaHQ+b7zviAYPPivdW7iK2rb12SZWX0YiDJFaZwygnyLFw4aZgtUH
         0GCssRGE0VB8x3pHjshGBuCRKO+snluglPtNdOYo=
Date:   Fri, 21 Jul 2023 07:18:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     ryan.roberts@arm.com, akpm@linux-foundation.org, hch@lst.de,
        kirill.shutemov@linux.intel.com, lstoakes@gmail.com,
        rppt@kernel.org, stable@vger.kernel.org, urezki@gmail.com,
        willy@infradead.org, yuzhao@google.com, ziy@nvidia.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] mm/damon/ops-common: atomically test and clear
 young on ptes and pmds
Message-ID: <2023072144-item-cosmic-5c73@gregkh>
References: <2023071613-reminder-relapse-b922@gregkh>
 <20230717193008.122040-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717193008.122040-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 07:30:08PM +0000, SeongJae Park wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> commit c11d34fa139e4b0fb4249a30f37b178353533fa1 upstream.
> 
> It is racy to non-atomically read a pte, then clear the young bit, then
> write it back as this could discard dirty information.  Further, it is bad
> practice to directly set a pte entry within a table.  Instead clearing
> young must go through the arch-provided helper,
> ptep_test_and_clear_young() to ensure it is modified atomically and to
> give the arch code visibility and allow it to check (and potentially
> modify) the operation.
> 
> Link: https://lkml.kernel.org/r/20230602092949.545577-3-ryan.roberts@arm.com
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> This is a manual backport of the commit, which cannot cleanly
> cherry-picked on 5.15.y[1], on 5.15.y, specifically 5.15.120.
> 
> [1] https://lore.kernel.org/stable/2023071613-reminder-relapse-b922@gregkh/

Now queued up, thanks.

greg k-h
