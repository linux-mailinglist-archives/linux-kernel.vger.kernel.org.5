Return-Path: <linux-kernel+bounces-13315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D98820363
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA292821BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409C2587;
	Sat, 30 Dec 2023 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwNt3MaL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F802561
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703904891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxnW03wmmSgu3Wsd0E5JoInO4BxSGZQ3EkhRS+WLmuE=;
	b=iwNt3MaLc77ivNohh+4+xoQRLQuGzB6DJx+RqAAQIK/rMtDWeRMOISsJMJApuoLQqFm2SV
	IWS2NCeC3dSyFkCSlaHXCpTga/aN8DDMLk4DizxcTic0aYKSMmwt+s8tZk0IFnmkbdY2VI
	G0an+eTiVqfwNNbx2VMgIhu8yHKjFdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-yLI7PEG7PJSGaOHEB6Mysw-1; Fri, 29 Dec 2023 21:54:49 -0500
X-MC-Unique: yLI7PEG7PJSGaOHEB6Mysw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D63380B62C;
	Sat, 30 Dec 2023 02:54:49 +0000 (UTC)
Received: from [10.22.16.36] (unknown [10.22.16.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 89E5A492BC6;
	Sat, 30 Dec 2023 02:54:48 +0000 (UTC)
Message-ID: <2899b471-b009-4bb5-bc81-19a8b8c9c955@redhat.com>
Date: Fri, 29 Dec 2023 21:54:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/5] locking/osq_lock: Clarify osq_wait_next()
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
 "'will@kernel.org'" <will@kernel.org>,
 "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 12/29/23 15:56, David Laight wrote:
> osq_wait_next() is passed 'prev' from osq_lock() and NULL from osq_unlock()
> but only needs the 'cpu' value to write to lock->tail.
> Just pass prev->cpu or OSQ_UNLOCKED_VAL instead.
>
> Also directly return NULL or 'next' instead of breaking the loop.
>
> Should have no effect on the generated code since gcc manages to
> assume that 'prev != NULL' due to an earlier dereference.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 55f5db896c02..9bb3a077ba92 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -48,18 +48,17 @@ static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
>   static inline struct optimistic_spin_node *
>   osq_wait_next(struct optimistic_spin_queue *lock,
>   	      struct optimistic_spin_node *node,
> -	      struct optimistic_spin_node *prev)
> +	      int old)

Make the last argument name more descriptive, like "old_cpu" as the 
"int" type does not provide enough context to allow people to guess what 
"old" may be.

Cheers,
Longman



