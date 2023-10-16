Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D1D7CB6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjJPWkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjJPWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:40:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110AC95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:40:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D75BC433C7;
        Mon, 16 Oct 2023 22:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697496000;
        bh=V1BRkFF3SiBUx+bZijH3HFIpyiSAqaYK+1MwBJFCW8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGzIbEYfJPfxFebbfPS6y0TCzRwc8CO4iz0XFaW46fUfSJGwS8LK/FYoAOlvS/fak
         X6Z520q7KjmF2IwR+NQOTYOWA/s8L2YY5Hr9OvQ8j2OUnsA7Jm6zKEM+1JRlSujze2
         LXn8lFZVrsszFzPTsCPDH0+ggogUlyCzinUHjjas=
Date:   Mon, 16 Oct 2023 15:39:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <steve.kang@unisoc.com>
Subject: Re: [PATCHv6 1/1] mm: optimization on page allocation when CMA
 enabled
Message-Id: <20231016153959.c218e1ae876426b9193eb294@linux-foundation.org>
In-Reply-To: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com>
References: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 15:12:45 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> According to current CMA utilization policy, an alloc_pages(GFP_USER)
> could 'steal' UNMOVABLE & RECLAIMABLE page blocks via the help of
> CMA(pass zone_watermark_ok by counting CMA in but use U&R in rmqueue),
> which could lead to following alloc_pages(GFP_KERNEL) fail.
> Solving this by introducing second watermark checking for GFP_MOVABLE,
> which could have the allocation use CMA when proper.
> 
> -- Free_pages(30MB)
> |
> |
> -- WMARK_LOW(25MB)
> |
> -- Free_CMA(12MB)
> |
> |
> --
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v6: update comments

The patch itself is identical to the v5 patch.  So either you meant
"update changelog" above or you sent the wrong diff?

Also, have we resolved any concerns regarding possible performance
impacts of this change?

