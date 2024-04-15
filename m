Return-Path: <linux-kernel+bounces-145420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120A58A55F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52661F2301B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B591D524;
	Mon, 15 Apr 2024 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cfvq99B+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4478C78
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193500; cv=none; b=SxQqznWlgkCwZw3owQbKrYrb6zbeAwNS77T5iOJZVIG29KWNilKXPyKrINfrWqjIMX0JI1Yl68EibgC7O+jz85cJa5VlDxuw870/Ss15OaZIr1TlpZjG/TK5Z074DBnLiUffkjJnM4YaaqatXrOzpJ3+9QyGZ/S7397d7DZ/BOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193500; c=relaxed/simple;
	bh=d5cmappnFJ0/wDvwY88Um505JFlXsV8IcwfFnmq2FlY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HkkbE/uwZsBjPHfhMIV2hWE4ldKpNJoEi6m3j+bQe9zfdohzTIZlIFWPKUQzl8zTQdb5xzAcX12VljGefiCbNUKdzNpvIkr3DC3UvsoGDFn4seOcneaPXHcUhfEPoori4sQLd1j4QplvpFJa5XyNOOwZ3ekdjrtDn19X4KRWjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cfvq99B+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713193498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8xnurLSraf68tR7a2NWQu+yYrcYokZdoz7hggE/R38=;
	b=Cfvq99B+TAVaD7/3Bu9ibpZ8H89Up3V3NTGmH4EvCVlpDdD9zem84EP7jdkb4XIRydd+S/
	szykZ4VGRAX2NbaMml0+6i24OTD0t4ZGpUWBCXaBiGQcMmSutQpKqB4gmKVfixQqCJyiih
	sQFbWGNy98Wbr5kyUEqbtMAWs8VArvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-cJDC2KeyNx6oY9pwZQnFzA-1; Mon, 15 Apr 2024 11:04:54 -0400
X-MC-Unique: cJDC2KeyNx6oY9pwZQnFzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7F96188ACA5;
	Mon, 15 Apr 2024 15:04:53 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 11FD340C6DAE;
	Mon, 15 Apr 2024 15:04:53 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id E9A8C30C72AD; Mon, 15 Apr 2024 15:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id E51CE3FD7A;
	Mon, 15 Apr 2024 17:04:52 +0200 (CEST)
Date: Mon, 15 Apr 2024 17:04:52 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, 
    torvalds@linux-foundation.org, tglx@linutronix.de, 
    linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
    msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com, 
    houtao1@huawei.com, nhuck@google.com, peterz@infradead.org, 
    yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com, 
    lilingfeng@huaweicloud.com
Subject: Re: [PATCH 6.6] Revert "dm-crypt, dm-verity: disable tasklets"
In-Reply-To: <4e5e4634-a2d0-ce35-3884-829d385c0879@huawei.com>
Message-ID: <3bc637b9-f7b4-aef6-74a8-5066d0d646f3@redhat.com>
References: <20240411091539.361470-1-lilingfeng3@huawei.com> <7c17f31a-2cc3-1597-e2b5-832355de7647@redhat.com> <4e5e4634-a2d0-ce35-3884-829d385c0879@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="185210117-1508192850-1713191327=:1973731"
Content-ID: <57482597-77c8-9c50-5cee-a88780511284@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-1508192850-1713191327=:1973731
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d4f484f-7d14-ecbc-5c9f-5e4cc90bd23@redhat.com>



On Fri, 12 Apr 2024, Li Lingfeng wrote:

> Hi
> 
> I'm having difficulty understanding "Workqueues and ksoftirqd may be scheduled
> arbitrarily".
> This is my understanding:
> kcryptd_queue_crypt
>  tasklet_schedule
>   __tasklet_schedule
>    __tasklet_schedule_common
>     raise_softirq_irqoff
>      wakeup_softirqd
>       wake_up_process // ksoftirqd
> 
> run_ksoftirqd
>  __do_softirq
>   softirq_handle_begin
>    __local_bh_disable_ip // Turn off preemption
> <---------- [1] ---------->
>   tasklet_action // h->action
>    tasklet_action_common
>     tasklet_trylock
>      kcryptd_crypt_tasklet // t->func(t->data)
>      ...
>       queue_work(cc->io_queue, &io->work)
> <---------- [2] ---------->
>     tasklet_unlock
> 
> // workqueue process
> kcryptd_io_bio_endio
>  ...
>  // free tasklet_struct
> 
> Since preemption has been turned off at [1], I'm confused about how the CPU
> can be scheduled out to do work first at [2].
> Would you mind explaining it to me?
> 
> Thanks

Yes, you are right that scheduling is disabled when ksoftirqd processes a 
softirq task.

But the upstream kernel switched to bh workqueues anyway, so there is no 
need to submit a different solution to the stable kernels.

Mikulas
--185210117-1508192850-1713191327=:1973731--


