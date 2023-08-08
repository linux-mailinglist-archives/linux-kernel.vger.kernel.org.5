Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004D27741EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjHHRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjHHR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:29:49 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6541D8C0BB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=84aIMxuVFMuTd09rn/TyCy86mewE5GkRaaZb1AsVDgI=; b=vk+6fgxzWR2B1EmxvLOAFtvmir
        k75qjCf+u5+2qJJ7uQe/zZAZeeGWnR7LZRSxEbKRd43EKEl4gP3uYV/PaiPj4moYnNq/WPX56LK04
        WimWRtOSS+aaXET2ulvLEnlpDb12Be/6V3tqI80xS52L3vktG2YDX6qqNxkC4mxvLhAk=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:39724 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qTLdr-000461-Oq; Tue, 08 Aug 2023 08:16:53 -0400
Date:   Tue, 8 Aug 2023 08:16:51 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <20230808081651.0d8573551f87de016c018529@hugovil.com>
In-Reply-To: <20230808020555.658430-1-linmiaohe@huawei.com>
References: <20230808020555.658430-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] mm/page_alloc: remove unneeded current_order check
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 10:05:55 +0800
Miaohe Lin <linmiaohe@huawei.com> wrote:

> current_order is guaranteed to '>=' min_order while min_order always '>='
> order. So current_order must be '>=' order.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 96b7c1a7d1f2..d37ec87515d0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2072,8 +2072,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>  		 * allocation falls back into a different pageblock than this
>  		 * one, it won't cause permanent fragmentation.
>  		 */
> -		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
> -					&& current_order > order)
> +		if (!can_steal && start_migratetype == MIGRATE_MOVABLE)
>  			goto find_smallest;

Hi,
if my analysis is correct, min_order can be initialized to the value of
order before the loop begins.

In that case, in the last loop iteration, current_order will be
equal to min_order and also to order. The condition 'current_order >
order' will evaluate to false, and the 'if' block should not be
executed?

Hugo.
