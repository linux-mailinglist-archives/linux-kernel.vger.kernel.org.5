Return-Path: <linux-kernel+bounces-20345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB650827D86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3C8B23917
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67993847D;
	Tue,  9 Jan 2024 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGonJbCR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224FA566D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704772177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTfyJ0n3w4TT5PYd+Uem/XQgjKHsnfqZgaIdLhgNUL8=;
	b=KGonJbCR5QdxAAb6YDxwMhDOIYt4XyWboCwKoHWvfNNrc0KZcpKPwSuYosTl+rId2LwLz/
	WQcabgCAuSTREXqaZhURtM/ZYXLsoxP+ONKdygMpvMM2g3X6GuStI+CdJb9ddNp2RyBIfj
	6TNuuycnDIQ0qTcQ+j6j99US5jAUEx8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-Tn6IMJMmOi-BvWKCm98MJg-1; Mon,
 08 Jan 2024 22:49:31 -0500
X-MC-Unique: Tn6IMJMmOi-BvWKCm98MJg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A56E1C0BB44;
	Tue,  9 Jan 2024 03:49:28 +0000 (UTC)
Received: from [10.22.16.105] (unknown [10.22.16.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91EE0492BC9;
	Tue,  9 Jan 2024 03:49:30 +0000 (UTC)
Message-ID: <a8023072-0900-4be9-bb34-02850276404b@redhat.com>
Date: Mon, 8 Jan 2024 22:49:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lockdep: Add missing graph_unlock in check_prev_add
Content-Language: en-US
To: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc: zhiguo.niu@unisoc.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
References: <20240105060456.15331-1-xuewen.yan@unisoc.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240105060456.15331-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 1/5/24 01:04, Xuewen Yan wrote:
> The check_prev_add() is held graph_lock, and it should unlock
> the graph_lock before return 0.
> But there is one condition where it will return 0 without unlock,
> that is:
>
> /* <prev> is not found in <next>::locks_before */
> 	return 0;
>
> So add graph_unlock before return 0.
>
> Fixes: 3454a36d6a39 ("lockdep: Introduce lock_list::dep")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> Change in V2:
> -move the graph_unlock to check_prev_add from validate_chain(Boqun)
> -Add fix tag
> ---
> ---
>   kernel/locking/lockdep.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..c8602a251bec 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3178,6 +3178,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
>   			}
>   
>   			/* <prev> is not found in <next>::locks_before */
> +			graph_unlock();
>   			return 0;
>   		}
>   	}

There are multiple places in check_prev_add() that will return 0. It 
will be odd to have just one of them has a graph_unlock(). It makes the 
code hard to understand. You should insert graph_unlock() in a place 
that matches the other places where graph_unlock() will be called. My 
suggestion is as follows:

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..d9f2df36332c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3252,7 +3252,7 @@ check_prevs_add(struct task_struct *curr, struct 
held_loc>
                 if (hlock->check) {
                         int ret = check_prev_add(curr, hlock, next, 
distance, &>
                         if (!ret)
-                               return 0;
+                               goto out_bug;

                         /*
                          * Stop after the first non-trylock entry,

It looks like this bug was first introduced by commit 910b1b2e6d 
("[PATCH] lockdep: internal locking fixes"). So you may also add a fixes 
tag.

Cheers,
Longman


