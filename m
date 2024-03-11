Return-Path: <linux-kernel+bounces-98901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8088780D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD57281F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2A3DB8C;
	Mon, 11 Mar 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcuanKhH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3F3D97A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164768; cv=none; b=m9c4YuRoOju5wX8fbHby6Imkidzm3VjgJFawxcpgEqRbPQPLP/+EcaNnV7nSL/a+mCQUTW+1HVpcENrixnMgkzOPdkx9P8ob30rkOymfsBhsc2+Sa3h8YFAeVBwST3fRy5ml3mXTxyPWBgjfAw/sC0zLxNBYYW3w+5fNHiPcJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164768; c=relaxed/simple;
	bh=IGgikpxQA5YTN1TUXE1XFOVsILWNGyTkicWdb23T6C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8JzEeghQjWv2EmKTz0ywRWTJgKsrGy+cR37Th4ctjYBPJXjNgVHXfDEUzeDf6xx7zVwsdINhkNg7wGYA4q65IwY5KIwlhgwl668xC1ndQUFGqXCHci0D7HZEg0MgTmhkkorL2cTfREbnmEQKfyz7U8gwfe37+2pghl8268Ax0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcuanKhH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710164765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSlrT+2IDrrNRqEUFQFgMF+IOBL1czDMXtZxeSZV+Vk=;
	b=UcuanKhHvRybOFBWK5Dxm1FpTNCOdkrR8w+YmMLpJlD0zHPRmaV3k1VsUvAEhESbWSGmJo
	pCI7Ajbe3KYMie2qtuBDoa/BDeWM3uC+O/M/sdG2j+8Csd21zAtZLzvXiGYMf9DIq40ph+
	kAgLogfS2oVxhWtSOxr/e9h0GzThBNo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-GgAJRwTVPFWGTm2ZfP6lVQ-1; Mon,
 11 Mar 2024 09:45:56 -0400
X-MC-Unique: GgAJRwTVPFWGTm2ZfP6lVQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45B0128B6AB1;
	Mon, 11 Mar 2024 13:45:56 +0000 (UTC)
Received: from [10.22.9.132] (unknown [10.22.9.132])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6716492BC4;
	Mon, 11 Mar 2024 13:45:55 +0000 (UTC)
Message-ID: <2e6c684b-bfbf-4850-b484-a1ace58a4c69@redhat.com>
Date: Mon, 11 Mar 2024 09:45:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: locking/core] locking/qspinlock: Fix 'wait_early' set but
 not used warning
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
References: <20240222150540.79981-2-longman@redhat.com>
 <170912480380.398.9234775487451824502.tip-bot2@tip-bot2>
 <Ze7jhCaWwAd3U0di@gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Ze7jhCaWwAd3U0di@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 3/11/24 06:57, Ingo Molnar wrote:
> * tip-bot2 for Waiman Long <tip-bot2@linutronix.de> wrote:
>
>> The following commit has been merged into the locking/core branch of tip:
>>
>> Commit-ID:     ca4bc2e07b716509fd279d2b449bb42f4263a9c8
>> Gitweb:        https://git.kernel.org/tip/ca4bc2e07b716509fd279d2b449bb42f4263a9c8
>> Author:        Waiman Long <longman@redhat.com>
>> AuthorDate:    Thu, 22 Feb 2024 10:05:37 -05:00
>> Committer:     Ingo Molnar <mingo@kernel.org>
>> CommitterDate: Wed, 28 Feb 2024 13:08:37 +01:00
>>
>> locking/qspinlock: Fix 'wait_early' set but not used warning
>>
>> When CONFIG_LOCK_EVENT_COUNTS is off, the wait_early variable will be
>> set but not used. This is expected. Recent compilers will not generate
>> wait_early code in this case.
>>
>> Add the __maybe_unused attribute to wait_early for suppressing this
>> W=1 warning.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Link: https://lore.kernel.org/r/20240222150540.79981-2-longman@redhat.com
>>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202312260422.f4pK3f9m-lkp@intel.com/
>> ---
>>   kernel/locking/qspinlock_paravirt.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
>> index 6a0184e..ae2b12f 100644
>> --- a/kernel/locking/qspinlock_paravirt.h
>> +++ b/kernel/locking/qspinlock_paravirt.h
>> @@ -294,8 +294,8 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>>   {
>>   	struct pv_node *pn = (struct pv_node *)node;
>>   	struct pv_node *pp = (struct pv_node *)prev;
>> +	bool __maybe_unused wait_early;
>>   	int loop;
>> -	bool wait_early;
> On a second thought, shouldn't this be solved via lockevent_cond_inc()'s
> !CONFIG_LOCK_EVENT_COUNTS stub explicitly marking the variable as used, via
> !something like:
>
>     #define lockevent_cond_inc(ev, c)		do { (void)(c); } while (0)
>
> or so, instead of uglifying the usage site?

Right, that should work too. Thanks for the suggestion. I will post 
another to do that.

Cheers,
Longman


