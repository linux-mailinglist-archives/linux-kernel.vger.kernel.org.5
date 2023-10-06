Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850777BC10E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjJFVR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjJFVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:17:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54205DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:17:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C5BC433C7;
        Fri,  6 Oct 2023 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696627074;
        bh=KTcEpRR2Wu8nzit7cMEeg3GCHgDJhR8cJMCV1xbmfls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QHDQxPsrNvXZf4P+vLtc92DHv2/mc+/TbzRW2tYEn4c18ojOEaoLXAy/vj2iYftxz
         s8lnIjRmN1yack7WXGS/mREdmrYMNqp+e32g3J2oHjrs0WaL8A/61QQGI3JrLd5YhF
         UDwDaQDetcG/FzUlvyiyOwriGtdKC/E8KehEAY+k=
Date:   Fri, 6 Oct 2023 14:17:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: Re: [PATCHv5] mm: optimization on page allocation when CMA enabled
Message-Id: <20231006141750.5423083520f74bc0746fd249@linux-foundation.org>
In-Reply-To: <1683782550-25799-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1683782550-25799-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 13:22:30 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Let us look at the timeline of scenarios below with WMARK_LOW=25MB WMARK_MIN=5MB
> (managed pages 1.9GB). We can find that CMA begin to be used until 'C' under the
> method of 'fixed 2 times of free cma over free pages' which could have the
> scenario 'A' and 'B' into a fault state, that is, free UNMOVABLE & RECLAIMABLE
> pages is lower than corresponding watermark without reclaiming which should be
> deemed as against current memory policy. This commit try to solve this by
> checking zone_watermark_ok again with removing CMA pages which could lead to a
> proper time point of CMA's utilization.
> 
> -- Free_pages
> |
> |
> -- WMARK_LOW
> |
> -- Free_CMA
> |
> |
> --
> 
> Free_CMA/Free_pages(MB)      A(12/30) -->  B(12/25) -->  C(12/20)
> fixed 1/2 ratio                 N             N           Y
> this commit                     Y             Y           Y
> 

Roman previously asked

: Also I'm a bit concerned about potential performance implications. 
: Would be great to provide some benchmarks or some data.  Probably it's
: ok because of we have pcp caches on top, but I'm not 100% sure.

Are you able to perform such testing and tell us the result?

Thanks.

