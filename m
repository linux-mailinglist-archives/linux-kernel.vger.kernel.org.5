Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B376739D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjG1RlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjG1RlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF4C10CB;
        Fri, 28 Jul 2023 10:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2605621BE;
        Fri, 28 Jul 2023 17:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7C8C433C8;
        Fri, 28 Jul 2023 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690566065;
        bh=9DPcgcn7pzaeyR23aOkzMKbj+QF+0Iy5kf7XOtyyU1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L1PBr6Tcnx3CaNQEzImZCiiC8GGuMXX0uCH/dKs0aevRVD6d5JIu6YMxG+VYk+KCZ
         WVk2deNn3J0NjN2Fq5eR6pBv5NTHGQv74VdNC900ARvpokqXhRTa1hlYR5Fx0p0OdZ
         2TzU7RRdMzMlUG7kOF8e/GG1Udvzh0bEMGtaGvbE=
Date:   Fri, 28 Jul 2023 10:41:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, yuzhao@google.com, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Subject: Re: [PATCH 2/2] madvise: don't use mapcount() against large folio
 for sharing check
Message-Id: <20230728104103.1357b394f9be6352a7c54c79@linux-foundation.org>
In-Reply-To: <20230728161356.1784568-3-fengwei.yin@intel.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
        <20230728161356.1784568-3-fengwei.yin@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 00:13:56 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:

> Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a folio")
> Fixes: fc986a38b670 ("mm: huge_memory: convert madvise_free_huge_pmd to use a folio")

Having two Fixes: for one patch presumably makes backporting more
complicated and adds risk of making mistakes.

So I have split this into a three-patch series and I've fixed up the patch naming:

Subject: madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check
Subject: madvise:madvise_free_huge_pmd(): don't use mapcount() against large folio for sharing check
Subject: madvise:madvise_free_pte_range(): don't use mapcount() against large folio for sharing check

I haven't added cc:stable at this time - that awaits the description of
user-visible effects.

