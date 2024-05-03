Return-Path: <linux-kernel+bounces-167863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B7B8BB07A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3486B2211B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF791155328;
	Fri,  3 May 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VftR7GSO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B6155312
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751995; cv=none; b=js0PaoewtZsqfeJhikyjrtwdac+vksbveU4d1jwJaZb1WJhr7X79df3skODA7jngGc4wZH6MyJwEbtlIbKuuNoKC3zr2lpt/o9B1/oguvOx0INurHX977wKLwsI3Q1GtDmGJQVbKocfuCG4Nb1qbsqF703nYj7s5/QjpO1AlYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751995; c=relaxed/simple;
	bh=62Oiyyi9HhrZbSTOPmcYG6s9RTji4r+qlEEYxy+w26Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bBgFTtAIcbKOgy97I+AgyPcnTWjzqDqdCSq1O9R1JVFtisb7OKpfL1JnXhlPhuuHZ8Sa1iqP4ceGrR/5vFezOgxYqgofPlTOqpUv8N1yJ8OsDTd3EUdXKQuchaVoAJLko2Uzz6yCOiNu/1fe8Bc/M5Bs/eE0z5L7rm9CL/7Z4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VftR7GSO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714751992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dotrxA6jk+pxTdtbX79vKTZRiS20tBeZ4KHr0DfXaIM=;
	b=VftR7GSOwmX5LIQJSpXQ0QfnRzS5rU1AmriYOrlA1fN0L/sry4HkEXywGNIHKGr5U5XH7a
	C5vNYny46WPfArzzswEw2m2liMj0cZU8iH+Zgd2XoAVSecMjIZzgIMFizBDpFsft/DS4GH
	fvPGCadQrquH39n3aYU+CeToJQnZqbc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-YsEe4rRvPmiC4aoDpGZaTg-1; Fri,
 03 May 2024 11:59:47 -0400
X-MC-Unique: YsEe4rRvPmiC4aoDpGZaTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E1C93C3D0CA;
	Fri,  3 May 2024 15:59:46 +0000 (UTC)
Received: from [10.22.34.156] (unknown [10.22.34.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6C1B2166B31;
	Fri,  3 May 2024 15:59:45 +0000 (UTC)
Message-ID: <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
Date: Fri, 3 May 2024 11:59:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
From: Waiman Long <longman@redhat.com>
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
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
 <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
Content-Language: en-US
In-Reply-To: <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 12/31/23 23:14, Waiman Long wrote:
>
> On 12/31/23 16:55, David Laight wrote:
>> per_cpu_ptr() indexes __per_cpu_offset[] with the cpu number.
>> This requires the cpu number be 64bit.
>> However the value is osq_lock() comes from a 32bit xchg() and there
>> isn't a way of telling gcc the high bits are zero (they are) so
>> there will always be an instruction to clear the high bits.
>>
>> The cpu number is also offset by one (to make the initialiser 0)
>> It seems to be impossible to get gcc to convert 
>> __per_cpu_offset[cpu_p1 - 1]
>> into (__per_cpu_offset - 1)[cpu_p1] (transferring the offset to the 
>> address).
>>
>> Converting the cpu number to 32bit unsigned prior to the decrement means
>> that gcc knows the decrement has set the high bits to zero and doesn't
>> add a register-register move (or cltq) to zero/sign extend the value.
>>
>> Not massive but saves two instructions.
>>
>> Signed-off-by: David Laight <david.laight@aculab.com>
>> ---
>>   kernel/locking/osq_lock.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>> index 35bb99e96697..37a4fa872989 100644
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -29,11 +29,9 @@ static inline int encode_cpu(int cpu_nr)
>>       return cpu_nr + 1;
>>   }
>>   -static inline struct optimistic_spin_node *decode_cpu(int 
>> encoded_cpu_val)
>> +static inline struct optimistic_spin_node *decode_cpu(unsigned int 
>> encoded_cpu_val)
>>   {
>> -    int cpu_nr = encoded_cpu_val - 1;
>> -
>> -    return per_cpu_ptr(&osq_node, cpu_nr);
>> +    return per_cpu_ptr(&osq_node, encoded_cpu_val - 1);
>>   }
>>     /*
>
> You really like micro-optimization.
>
> Anyway,
>
> Reviewed-by: Waiman Long <longman@redhat.com>
>
David,

Could you respin the series based on the latest upstream code?

Thanks,
Longman


