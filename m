Return-Path: <linux-kernel+bounces-122915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EBF88FF61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075311C24783
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1428004B;
	Thu, 28 Mar 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOPKzIbB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A88004A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629680; cv=none; b=u3QdXAEROrR7rNymYdWxYlDNKcb8etc19UggIriGr12xxZtAdZfFoXFY0CyKbZg/UeLBUWKWHfrWH7bBp0cQUB/zTaCUnOSqxxJYsjYJjsM5RbYsVCEmgmJ0XeGgc9i2ALgFRVEyyt/L1y6cUb3rZc67ioNFT54wPvWqM6ZNpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629680; c=relaxed/simple;
	bh=gWnlaW8LZL1wZ69PEGGLMwZiyLxgmZeR9EPAdAwAqyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+Ao6tnZ1ZxvnshGL+ZS0rBR2HZyU8hwXer3l2mPnYDXFiKgnauC5xm/7BHf+h/p1zlbakdJbKBbHpBr59B/8w6Wp+eUlJyPmGXZauWfoSd963hGQQgkT9WS6cWowRX/BPuSn+nMkCclVVQV7WbagC1tE+GOI6PRn5CAHjnJduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOPKzIbB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711629676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNWi9PDkJybSv2Ekqt8s2egj3Hex4qjep5ZKFQ1qOHk=;
	b=BOPKzIbBYkA3rw6fxHDNOKSQeuXn3Xgm7jrrLRqhx0j2AGHSOq0p/t9wZZFR7cB4GeyheT
	UXe2i6KS8tjskLKlk3uUzFTc4JBObxx2HTNPM7oC/HFj8ZnFPAh0s3gKO/s7IqjR4GNYHl
	WkpfOuw1Ul1ZqxjaZcs4t8mbmf0FQ6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-ktgfc1VaPPuGCzQhBYrbvQ-1; Thu, 28 Mar 2024 08:41:12 -0400
X-MC-Unique: ktgfc1VaPPuGCzQhBYrbvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF01B181B203;
	Thu, 28 Mar 2024 12:41:11 +0000 (UTC)
Received: from [10.22.9.3] (unknown [10.22.9.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC5F111E3F3;
	Thu, 28 Mar 2024 12:41:11 +0000 (UTC)
Message-ID: <9b15de60-b593-4b0c-bacc-ebe79de5d541@redhat.com>
Date: Thu, 28 Mar 2024 08:41:10 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Use str_plural() to fix Coccinelle warning
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20240328100952.200379-3-thorsten.blum@toblux.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240328100952.200379-3-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 3/28/24 06:09, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
>
> 	opportunity for str_plural(depth)
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>   kernel/locking/lockdep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..31d7720c9b8d 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -786,7 +786,7 @@ static void lockdep_print_held_locks(struct task_struct *p)
>   		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
>   	else
>   		printk("%d lock%s held by %s/%d:\n", depth,
> -		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
> +		       str_plural(depth), p->comm, task_pid_nr(p));
>   	/*
>   	 * It's not reliable to print a task's held locks if it's not sleeping
>   	 * and it's not the current task.
Acked-by: Waiman Long <longman@redhat.com>


