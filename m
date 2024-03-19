Return-Path: <linux-kernel+bounces-107748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB292880135
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE771F241B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5E65BA5;
	Tue, 19 Mar 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcYDTijV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296B657BA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863642; cv=none; b=WbQOdlfOphRVg3WOJrrPqV2YESRqcfdHtYJS6SAKjW0mDha1WIn5wnsChb1UUe7vL0kgEQHCQtTbL34hMc+Pvv6JACZ6I4HYXci9mjQeuRvK6Eem81XhIRPwd4iOIyUApkdJw+4TtfZApK+NPbrgmvTgr7PhQNWtJ4QQEpZiWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863642; c=relaxed/simple;
	bh=paSWeKBIFxB+F/AXMlOAQl6P1bEPAiBsLyGlr2J3chs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/5WOjljey+/fJXZ0X+68rwUfaYvv8Eo7QnQcj3jF86cXkxEgX4fnuqvzGm4hRilaZACSjlp2uERNOsuK6tpSeY40itbB4QlBCPLQpopl22NyuAEfbN15hOww6Si8h+QKirMMJN8cmSAW70iDpQMu+lds7VhyRyFr3uDII6QhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcYDTijV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710863640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ko9D6jNCbeVAgprQATdARtgHSvmfZlnh+pwV+XTC6LU=;
	b=gcYDTijVM6RpkRLGRAL5e2N6YQchIZjHELMa+Q4Rj7yxyY3mFMiHRIqdA1XYC/EmZ2HxRo
	k4h+/IP71TX9bTbQpVnraQq/t0EixYAgciGAMpQrWYGYYlUnkjvDLBUg0tf/trCuHw3sle
	sXT8lYH9LEs+4Q9F2ZpYgn6uyPy0rpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-zfuj1Uq-N6GFgh1hIK-5Tw-1; Tue, 19 Mar 2024 11:53:55 -0400
X-MC-Unique: zfuj1Uq-N6GFgh1hIK-5Tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6784D800266;
	Tue, 19 Mar 2024 15:53:55 +0000 (UTC)
Received: from [10.22.10.159] (unknown [10.22.10.159])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F06D01121306;
	Tue, 19 Mar 2024 15:53:54 +0000 (UTC)
Message-ID: <9b4f3dac-779a-4eef-945b-3ca1455c0dfe@redhat.com>
Date: Tue, 19 Mar 2024 11:53:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Locking: Let PREEMPT_RT compile again with new rwsem
 asserts.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Clark Williams <williams@redhat.com>
References: <20240319070550.ws_uO21-@linutronix.de>
 <ZfmVPid-d7cpf6Yt@casper.infradead.org>
 <20240319141506.DUd9NKl4@linutronix.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240319141506.DUd9NKl4@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 3/19/24 10:15, Sebastian Andrzej Siewior wrote:
> On 2024-03-19 13:38:06 [+0000], Matthew Wilcox wrote:
>> On Tue, Mar 19, 2024 at 08:05:50AM +0100, Sebastian Andrzej Siewior wrote:
>>> -static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
>>> +static __always_inline bool rwsem_held_write(const struct rw_semaphore *sem)
>> The locking maintainers were very clear that this predicate Should Not
>> Exist.  It encourages people to write bad code.  Assertions only!
> What do you refer to? The inline vs __always_inline or
> rwsem_held_write() should not exists and it should invoke directly
> rw_base_is_write_locked()?

Just merge rwsem_held_write() into rwsem_assert_held_write_nolockdep() 
and we should be all set.

Cheers,
Longman

>>>   {
>>> -	rw_base_assert_held_write(sem);
>>> +	return rw_base_is_write_locked(&sem->rwbase);
>>> +}
>>> +
>>> +static __always_inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
>>> +{
>>> +	WARN_ON(!rwsem_held_write(sem));
>>>   }
>>>   
>>>   static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
> Sebastian
>


