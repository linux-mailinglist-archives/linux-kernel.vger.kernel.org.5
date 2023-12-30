Return-Path: <linux-kernel+bounces-13319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A7A820371
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADC228245E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3970138C;
	Sat, 30 Dec 2023 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+RgksLq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E310E9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703905690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmyPFQZTx3DBNTrvibOLHdlFPMZhkmpr5I+XfX8iSuk=;
	b=K+RgksLqf6HMR24zw0g4OTxXGRpQ6WceGs3VEQMc22hRptZJLy465N80edpGm668M515BC
	0GHLmLZUYaXMjCprc5FvEuv3L5v+RPQJl54Vc55Fvzgr3LUql5ReadZQqkobP2N/MDAGGD
	0grttZyxHIpA9qv+HuIPJ0ij3qg4HbU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-xf0T1TxuMLivzC5vapgPuA-1; Fri,
 29 Dec 2023 22:08:04 -0500
X-MC-Unique: xf0T1TxuMLivzC5vapgPuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E58ED3C1CD0A;
	Sat, 30 Dec 2023 03:08:03 +0000 (UTC)
Received: from [10.22.16.36] (unknown [10.22.16.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4DE8B492BC6;
	Sat, 30 Dec 2023 03:08:03 +0000 (UTC)
Message-ID: <346c40b5-686f-461e-a1e3-9f255418efb2@redhat.com>
Date: Fri, 29 Dec 2023 22:08:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
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
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 12/29/23 15:57, David Laight wrote:
> this_cpu_ptr() is rather more expensive than raw_cpu_read() since
> the latter can use an 'offset from register' (%gs for x86-84).
>
> Add a 'self' field to 'struct optimistic_spin_node' that can be
> read with raw_cpu_read(), initialise on first call.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 9bb3a077ba92..b60b0add0161 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -13,7 +13,7 @@
>    */
>   
>   struct optimistic_spin_node {
> -	struct optimistic_spin_node *next, *prev;
> +	struct optimistic_spin_node *self, *next, *prev;
>   	int locked; /* 1 if lock acquired */
>   	int cpu; /* encoded CPU # + 1 value */
>   };
> @@ -93,12 +93,16 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>   
>   bool osq_lock(struct optimistic_spin_queue *lock)
>   {
> -	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> +	struct optimistic_spin_node *node = raw_cpu_read(osq_node.self);

My gcc 11 compiler produces the following x86-64 code:

92        struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
    0x0000000000000029 <+25>:    mov    %rcx,%rdx
    0x000000000000002c <+28>:    add %gs:0x0(%rip),%rdx        # 0x34 
<osq_lock+36>

Which looks pretty optimized for me. Maybe older compiler may generate 
more complex code. However, I do have some doubt as to the benefit of 
this patch at the expense of making the code a bit more complex.

Cheers,
Longman


