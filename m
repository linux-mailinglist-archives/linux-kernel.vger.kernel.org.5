Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AE9767333
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjG1RYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjG1RYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E42135;
        Fri, 28 Jul 2023 10:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E6D621B0;
        Fri, 28 Jul 2023 17:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC92C433C9;
        Fri, 28 Jul 2023 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690565047;
        bh=F8PyAvW7AlD89TIBCGrOIiLigKuhVWKEHS84huiz2HA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sFJd3MIMmW6vuBJv2YzUTpDJnSy3XvPNyIJCTyTWM+hJHpTqSR2u6vpmUp+fzAGNr
         v/UuYxprIai3L+04NHsC7FO0ulr8pk5uMzz243gYipF9/I7AP7yOzkkTvmevmExjgW
         FUZIM0B5+4Mj0SJXgqXhRym6YTaeNWnQ5wzUgdH8=
Date:   Fri, 28 Jul 2023 10:24:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, yuzhao@google.com, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Message-Id: <20230728102405.7b456eb87fb46042fbce5e4b@linux-foundation.org>
In-Reply-To: <20230728161356.1784568-1-fengwei.yin@intel.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
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

On Sat, 29 Jul 2023 00:13:54 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:

> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
> folio_mapcount() is used to check whether the folio is shared. But it's
> not correct as folio_mapcount() returns total mapcount of large folio.
> 
> Use folio_estimated_sharers() here as the estimated number is enough.

What are the user-visible runtime effects of these changes?

(and please try to avoid using the same Subject: for different patches)
