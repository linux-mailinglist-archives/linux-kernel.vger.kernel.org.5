Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2CD772A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjHGQYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHGQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:24:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD710CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LglLvfSHGs7k23R/juUd/AgJcqfnL4Y+TCCHAVC/09k=; b=BMzxh/uaG48qsMwdsp6NKso+Qb
        M64ZeBCX2QpFVJrUK2AC+OAOBUqO/HBHAP5K0qAg9c1aNxSV46C6zrRdJVmmBWUlX+Wt9gpCRduGj
        DxVE7d9RYoJ7C4Sz+BjRz2jITJH08F5dXXqw7jhOsWQC2eU1EQMOu27BKW6oD0aHcaZXRi6lOo1J0
        QICx1RQ7ISBsvcMnyjlpKa+rk9cQek7B4FY2xQUJPXIdadZYX5j3B+wZGqDHfuKR8JU1/t1bGWIOk
        MuFbPMDkJP16ArtX+D7SBbB+RypHT4wejX+LjWKzTqoJ3q5uogHv6PpJjQWYtDUD+pp/pQzl11iU9
        6OxcfbQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qT30y-00C7di-8H; Mon, 07 Aug 2023 16:23:28 +0000
Date:   Mon, 7 Aug 2023 17:23:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] arm: dma-mapping: fix potential endless loop in
 __dma_page_dev_to_cpu()
Message-ID: <ZNEagJ6rVDwBKUdr@casper.infradead.org>
References: <CGME20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e@eucas1p1.samsung.com>
 <20230807152657.1692414-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807152657.1692414-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:26:57PM +0200, Marek Szyprowski wrote:
> It is possible that the folio_size() of the next folio returns zero, so

What?  How can folio_size() return zero?

        return PAGE_SIZE << folio_order(folio);

It is a minimum of PAGE_SIZE.

> avoid looping with 'left' equals to zero in D-cache cleaning loop.
> 
> This fixes the following endless loop observed by RCU stall:
> --->8---
> rcu: INFO: rcu_sched self-detected stall on CPU
> rcu:     0-....: (27320 ticks this GP) idle=e414/1/0x40000002 softirq=36/36 fqs=13044
> rcu:     (t=27385 jiffies g=-1067 q=34 ncpus=8)
> CPU: 0 PID: 93 Comm: kworker/0:1H Not tainted 6.5.0-rc5-next-20230807 #6981
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: mmc_complete mmc_blk_mq_complete_work
> PC is at _set_bit+0x28/0x44
> LR is at __dma_page_dev_to_cpu+0xdc/0x170
> ..
>  _set_bit from __dma_page_dev_to_cpu+0xdc/0x170
>  __dma_page_dev_to_cpu from dma_direct_unmap_sg+0x100/0x130
>  dma_direct_unmap_sg from dw_mci_post_req+0x68/0x6c
>  dw_mci_post_req from mmc_blk_mq_post_req+0x34/0x100

I don't know what you've actually hit here, but the explanation is wrong.
