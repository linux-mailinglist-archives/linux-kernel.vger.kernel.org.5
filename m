Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646CD7A9E12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjIUTzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjIUTye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:54:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56797803FC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:02:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c0327b75dso17245137b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322919; x=1695927719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5idGDJHajfRBbMuSzPd4i5/t54vfHNdbr48RChRWzqM=;
        b=2BooiXDRdGdVMAlVcBWQCNkTEkbZrHYrWY31LpUZEk3fc9eDkThZx1AwQUhKMDHkf5
         UEyShVv3rLaiV+P0txfMCu8MFamgMEoSeykzTzRYfhJiK7l3FTwudW7TF2GY6cMIItPu
         mapw67pjL/Xp6/6FZWKO4aDatRspS7w3PvHw5jx+fYJzj3jiq7O10CBFxYbRTpZvkvKO
         C2UAyiwt4K87AE6oq/qeak2O6pgrFVjeVTPo7Sbv1PJyk5ia01xFsOHhPoGnk6TJRTWW
         uj4QSq4wDmgUk9K61I2I/5B6GmcisxUc0apclpo1nVwVDm0qZVujLDa51jAfqqcswzI2
         UNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322919; x=1695927719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5idGDJHajfRBbMuSzPd4i5/t54vfHNdbr48RChRWzqM=;
        b=YoS++JbXKOKSDFefQKbfy5TrKBBFO6j78aKvysutL+vedRZCa3y252UMHHqke0AHE/
         T+KbyoUlLc5P2p9uX91ZIZ08Od7qnuszYsUAsqq1iBGhuv0T6UkuTBY8W+ztY5mz1Y71
         acxi5eRlazxIVCuaswQFkdKnGNAD/613LzFbVLKhmJhTzgZK/zAJGrWWuMunTKQiT2/V
         R4lh5MtRLLwQbEOE+ANi+fmwaKWu5A1z7nH0UUR37qBK9HguRjtsXIcfT1154B6QWkP9
         ccEr6Cf06T9KTPN7tYWqQBOmHj/QMmxwOUmfxj3pf3W9VxxeVXWtjz0FyjxBOvPmAPkC
         DOHw==
X-Gm-Message-State: AOJu0YxSuiBGu8mYFkc5y8geKpa7hwxuCrxnuoDzDs0wTmnBuQ+5Ct9E
        pFvrkcj/4dkI7p3jC4KiChJsx4PS6JIa0g==
X-Google-Smtp-Source: AGHT+IGiWhkZQI2qsIIIWvhihaksfZHxJa3nw+xhY08FFXLOqY3cnBSLU1oGhU9kfs+YQ6I22pIVz3FchgxXQA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:a84:b0:d7b:94f5:1301 with SMTP
 id cd4-20020a0569020a8400b00d7b94f51301mr93080ybb.9.1695322919028; Thu, 21
 Sep 2023 12:01:59 -0700 (PDT)
Date:   Thu, 21 Sep 2023 19:01:56 +0000
In-Reply-To: <20230920132545.56834-2-wuyun.abel@bytedance.com>
Mime-Version: 1.0
References: <20230920132545.56834-1-wuyun.abel@bytedance.com> <20230920132545.56834-2-wuyun.abel@bytedance.com>
Message-ID: <20230921190156.s4oygohw4hud42tx@google.com>
Subject: Re: [PATCH net-next 2/2] sock: Fix improper heuristic on raising memory
From:   Shakeel Butt <shakeelb@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Glauber Costa <glommer@parallels.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:25:41PM +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
> 
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> Fix this by skipping this heuristic when under memcg pressure.
> 
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  net/core/sock.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 379eb8b65562..ef5cf6250f17 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3093,8 +3093,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>  	if (sk_has_memory_pressure(sk)) {
>  		u64 alloc;
>  
> -		if (!sk_under_memory_pressure(sk))
> +		if (memcg && mem_cgroup_under_socket_pressure(memcg))
> +			goto suppress_allocation;
> +
> +		if (!sk_under_global_memory_pressure(sk))
>  			return 1;

I am onboard with replacing sk_under_memory_pressure() with
sk_under_global_memory_pressure(). However suppressing on memcg pressure
is a behavior change from status quo and need more thought and testing.

I think there are three options for this hunk:

1. proposed patch
2. Consider memcg pressure only for !in_softirq().
3. Don't consider memcg pressure at all.

All three options are behavior change from the status quo but with
different risk levels. (1) may reintroduce the regression fixed by
720ca52bcef22 ("net-memcg: avoid stalls when under memory pressure").
(2) is more inlined with 720ca52bcef22. (3) has the risk to making memcg
limits ineffective.

IMHO we should go with (2) as there is already a precedence in
720ca52bcef22.

thanks,
Shakeel
