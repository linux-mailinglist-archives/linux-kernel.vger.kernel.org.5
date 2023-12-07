Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B65809518
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444046AbjLGWLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjLGWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:11:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABDA98
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:11:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7796BC433C8;
        Thu,  7 Dec 2023 22:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701987104;
        bh=gtl71HBKJQxQ32Agrxutqbcus3/RTRAhRHa92m2vZ9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mMYBqqBusjscmfbCqYwr4KmHVQk204C5IArYBZMGpgLsQbnnrUSV6nZeLW8KKwvIW
         eRZoP2bJN/HWrDIrvSYUtPw3wmtfLHSPu3QhWxw5GDWQc8gdkd/MmQI2f6TbqT59QV
         fh8BxwFhgNhu68GfmwE9USNL+fAMcGOQNdULY3Hs=
Date:   Thu, 7 Dec 2023 14:11:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, chrisl@kernel.org
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback
 disabling
Message-Id: <20231207141142.307745be167d044b0eec1b42@linux-foundation.org>
In-Reply-To: <20231207192406.3809579-1-nphamcs@gmail.com>
References: <20231207192406.3809579-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 11:24:06 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> During our experiment with zswap, we sometimes observe swap IOs due to
> occasional zswap store failures and writebacks-to-swap. These swapping
> IOs prevent many users who cannot tolerate swapping from adopting zswap
> to save memory and improve performance where possible.
> 
> This patch adds the option to disable this behavior entirely: do not
> writeback to backing swapping device when a zswap store attempt fail,
> and do not write pages in the zswap pool back to the backing swap
> device (both when the pool is full, and when the new zswap shrinker is
> called).
> 
> This new behavior can be opted-in/out on a per-cgroup basis via a new
> cgroup file. By default, writebacks to swap device is enabled, which is
> the previous behavior. Initially, writeback is enabled for the root
> cgroup, and a newly created cgroup will inherit the current setting of
> its parent.
> 
> Note that this is subtly different from setting memory.swap.max to 0, as
> it still allows for pages to be stored in the zswap pool (which itself
> consumes swap space in its current form).
> 
> This patch should be applied on top of the zswap shrinker series:
> 
> https://lore.kernel.org/linux-mm/20231130194023.4102148-1-nphamcs@gmail.com/
> 
> as it also disables the zswap shrinker, a major source of zswap
> writebacks.
> 
> ...
>
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -153,6 +153,12 @@ attribute, e. g.::
>  
>  Setting this parameter to 100 will disable the hysteresis.
>  
> +Some users cannot tolerate the swapping that comes with zswap store failures
> +and zswap writebacks. Swapping can be disabled entirely (without disabling
> +zswap itself) on a cgroup-basis as follows:
> +
> +	echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writeback
> +

This does seem to be getting down into the weeds.  How would a user
know (or even suspect) that these things are happening to them?  Perhaps
it would be helpful to tell people where to go look to determine this.

Also, it would be quite helpful of the changelog were to give us some
idea of how important this tunable is.  What sort of throughput
differences might it cause and under what circumstances?
