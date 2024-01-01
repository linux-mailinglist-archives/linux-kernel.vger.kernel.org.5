Return-Path: <linux-kernel+bounces-13822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9AA8212EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 05:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AE41F2262C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 04:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CAED9;
	Mon,  1 Jan 2024 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbPnmnRG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2A1375
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 04:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704082095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3g91HopIn3gFGM2kCJmjXT4qR4+JT3oKKMT6KCXKZU=;
	b=cbPnmnRGuhke03SSO0z8m5DODSKtry5f9bDnO1TkdEB0wB93tO7qnhYomAc5464PHexL1j
	GdvZhlDzlZnKFOcVjtJW7TrPubojqnz8eK3CCr6o7SoLa2W/yv8o47T94J2tgL2tLb6oPd
	EmpvxBD+F3H3z07VcliyTollpt6AvSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-CX7x_yuuOU-MSH7no3qi7A-1; Sun, 31 Dec 2023 23:08:09 -0500
X-MC-Unique: CX7x_yuuOU-MSH7no3qi7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A036B185A780;
	Mon,  1 Jan 2024 04:08:08 +0000 (UTC)
Received: from [10.22.16.25] (unknown [10.22.16.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6BCE51D5;
	Mon,  1 Jan 2024 04:08:07 +0000 (UTC)
Message-ID: <c617aa86-3b03-4e35-8c93-6d14d4e50398@redhat.com>
Date: Sun, 31 Dec 2023 23:08:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 1/5] locking/osq_lock: Defer clearing node->locked
 until the slow osq_lock() path.
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
 "'will@kernel.org'" <will@kernel.org>,
 "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <714ca2e587cf4cd485ae04e5afb8d5bb@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <714ca2e587cf4cd485ae04e5afb8d5bb@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 12/31/23 16:51, David Laight wrote:
> Since node->locked cannot be set before the assignment to prev->next
> it is save to clear it in the slow path.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 75a6f6133866..e0bc74d85a76 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -97,7 +97,6 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	int curr = encode_cpu(smp_processor_id());
>   	int old;
>   
> -	node->locked = 0;
>   	node->next = NULL;
>   	node->cpu = curr;
>   
> @@ -111,6 +110,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	if (old == OSQ_UNLOCKED_VAL)
>   		return true;
>   
> +	node->locked = 0;
>   	prev = decode_cpu(old);
>   	node->prev = prev;
>   

Reviewed-by: Waiman Long <longman@redhat.com>


