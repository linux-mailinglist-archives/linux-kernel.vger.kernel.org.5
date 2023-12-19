Return-Path: <linux-kernel+bounces-4619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B1818008
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C4F1F24131
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512305232;
	Tue, 19 Dec 2023 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amlGXghX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567C468A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702955087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQfG9eq9ewowiFP45GZFICAofL0rLlInSQ5uXMEvGss=;
	b=amlGXghXjG9YG3cf4CGiwn2ha8DKjUcUsfmUVNUsVkQPy15oL7KFxMQJG0JJx1Exd/geNm
	6zxErOhBKOUP0mcrwzhcrslk7Kx3kvGkP5UZaDqLIWErasIZvXyzVC68sy/urcFiqUyIXb
	d2OukEfoUUoRZW3EvqNlemQc1lS+Dm0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-ywHlEbhyPYmWgska9lLskQ-1; Mon,
 18 Dec 2023 22:04:41 -0500
X-MC-Unique: ywHlEbhyPYmWgska9lLskQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AED8F3C0E206;
	Tue, 19 Dec 2023 03:04:40 +0000 (UTC)
Received: from [10.22.32.252] (unknown [10.22.32.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA957492BC6;
	Tue, 19 Dec 2023 03:04:39 +0000 (UTC)
Message-ID: <647f6ed8-c6d8-421e-b5a7-faa3c19b9bd6@redhat.com>
Date: Mon, 18 Dec 2023 22:04:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/50] locking/mutex: split out mutex_types.h
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
 tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
 paulmck@kernel.org, keescook@chromium.org, dave.hansen@linux.intel.com,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com, brauner@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-9-kent.overstreet@linux.dev>
 <7066c278-28e0-45eb-a046-eb684c4a659c@redhat.com>
 <20231219014617.dulwl3mdro6zyblt@moria.home.lan>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20231219014617.dulwl3mdro6zyblt@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 12/18/23 20:46, Kent Overstreet wrote:
> On Mon, Dec 18, 2023 at 11:53:08AM -0500, Waiman Long wrote:
>> On 12/15/23 22:26, Kent Overstreet wrote:
>>> -#include <linux/rtmutex.h>
>> Including rtmutex.h here means that mutex_types.h is no longer a simple
>> header for types only. So unless you also break out a rtmutex_types.h, it is
>> inconsistent.
> good observation, I'll have to leave it for the next round of cleanups
> though since the merge window is approaching and I'll have to redo all
> the testing.
>
>> Besides, the kernel/sched code does use mutex_lock/unlock calls quite
>> frequently. With this patch, mutex.h will not be directly included. I
>> suspect that it is indirectly included via other header files. This may be
>> an issue with some configurations.
> I've now put it through randconfig testing on every arch that debian
> includes a compiler for (excluding sh and xtensa, which throw internal
> compiler errors) and that one hasn't come up yet.
>
> could still be included indirectly though - I haven't checked for that
> one specifically yet.

If you are replacing mutex.h in include/linux/sched.h by mutex_types.h, 
I would suggest you add mutex.h to kernel/sched/sched.h to ensure this 
header file is included by the scheduler code.

Cheers,
Longman


