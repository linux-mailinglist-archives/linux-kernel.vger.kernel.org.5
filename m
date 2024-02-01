Return-Path: <linux-kernel+bounces-48321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C892A845A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C089B21474
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5885D492;
	Thu,  1 Feb 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NU5zhqya"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EB5D482
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797684; cv=none; b=qCV9lO8/GsND1ubRiqqP21xj4Kfyg3yOhThSAZP5eSIOv6+/2qLuuMjGQ4fERy9PMQWlJyTe2ofkis6YnM4BOM2IXBJYu3xqqhJV4AsIbeZsVtdBkFTgCTl4gWcy1bZeRmf6aQ6bVDJfYOF65e+B66uygpOFsyojcflT6NLL2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797684; c=relaxed/simple;
	bh=xvOyY477R5AaJWaI5WYYMVxT5ndpWlRf/o4MJHBKjZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaXRizhI/NYKehlIHBRp6oaQlxExukKbvRTlVv6KVPr0fBzy7uj1T/t+29SFaGGSKtY3G7sx5Cuh+nAcU4+SWAXZIH130VTvHx9uMibyvVDth5lldOxVW1JF1pLUlEqTOXnv/gEEht3FVMumEOM9vRt9T30zSWUWZqDSpJLHEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NU5zhqya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706797681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhriPA+e3pr6OImmjGEObkRctf6AV9P0DFfhi2MkV/o=;
	b=NU5zhqyaqGlB+YOXa1TbOi/uo0Q53tLuKCQHGSA6R92GtpWrTNrHiH9SwKXaQTpVfyNdn9
	v3SToB4gJqjxY21XVHQgeybd7vZhpJgslcJZQtfbJgyekbdsGH+FEQnSBbKK4pDSR5mtLt
	1ZY2i0cjIAgFKl56GnNGP5MlXmsoG9I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-neTE2yk3PK6pWcovvitW3g-1; Thu, 01 Feb 2024 09:28:00 -0500
X-MC-Unique: neTE2yk3PK6pWcovvitW3g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-783f4a68727so172280685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706797679; x=1707402479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhriPA+e3pr6OImmjGEObkRctf6AV9P0DFfhi2MkV/o=;
        b=aggvnr4X8FcjOf1AZkHq1rmfUQa6eBhDnYNyEyJQrPKAie0ybS42VIuPj2cwSHxMH3
         OJVdCk5KZO7HixHAPl1Ec27OtAfJ5+L7tAc0Aun+wcK8tf4AESLVk9AVDhWCC+8OZPtf
         +HER/wYYzLcw3wzFkgzTttgIUDdvXZEpexUIm7kcUZTNatXhdGQ7jJ++62g9JFuLDxJH
         r7UHCff3NhairAWC4fnk8RPTqipdGSQUhiH+Aal5+Xe2xDPzoxFphbLqwRO+LHdD0OxQ
         DeGm6DExgSHHkygbjbAhrsUpavvlAsBc+fW1xJGSiKWaOAUhGXlcsHYXC+RqYR+wuEbE
         +UIA==
X-Gm-Message-State: AOJu0YxwPobvNKUep/3W8zAWIP4PnAGMRhX27VMPTC0gehA9syPmtnME
	FvSOj6To1PyKPG/1OGAnhzdGwEZS7w5GMHJ9zg2BBLjdG8DbYBYs/zLQ8beEEnrFdaHFA/80obw
	V2vyMu6KS0bnyfCkboXd7f0R4pSChhVXzHDZpE2sbN0wUIST6mUF2/2RzbEuF
X-Received: by 2002:a05:620a:3182:b0:783:6eae:547 with SMTP id bi2-20020a05620a318200b007836eae0547mr4245002qkb.22.1706797679597;
        Thu, 01 Feb 2024 06:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuyCrYMRRmqU1NLxhcE6IYFawk7gjD0GjIF8sKvzAb4++daSvzxgCEO2r1yYtOPj5iMsr0Pg==
X-Received: by 2002:a05:620a:3182:b0:783:6eae:547 with SMTP id bi2-20020a05620a318200b007836eae0547mr4244972qkb.22.1706797679284;
        Thu, 01 Feb 2024 06:27:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpkZk13bonEQp7JKJxcGUrn6x/3W27GczNweVWBULskC+KgkGIds17t4+6lhWrXNT848zZmtjjEauXYHff+Jba9jj2m/vo1ULK83uH
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id h6-20020ad45446000000b00686a51526fbsm6534568qvt.110.2024.02.01.06.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:27:59 -0800 (PST)
Message-ID: <cfa6cb2b-9432-4ed4-87ea-16be499d2806@redhat.com>
Date: Thu, 1 Feb 2024 15:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] kernel/module: add a safer implementation of
 try_module_get()
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130193614.49772-1-marpagan@redhat.com>
 <ZblgV0ApD-9cQWwl@bombadil.infradead.org>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZblgV0ApD-9cQWwl@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-30 21:47, Luis Chamberlain wrote:
> On Tue, Jan 30, 2024 at 08:36:14PM +0100, Marco Pagani wrote:
>> The current implementation of try_module_get() requires the module to
>> exist and be live as a precondition. While this may seem intuitive at
>> first glance, enforcing the precondition can be tricky, considering that
>> modules can be unloaded at any time if not previously taken. For
>> instance, the caller could be preempted just before calling
>> try_module_get(), and while preempted, the module could be unloaded and
>> freed. More subtly, the module could also be unloaded at any point while
>> executing try_module_get() before incrementing the refount with
>> atomic_inc_not_zero().
>>
>> Neglecting the precondition that the module must exist and be live can
>> cause unexpected race conditions that can lead to crashes. However,
>> ensuring that the precondition is met may require additional locking
>> that increases the complexity of the code and can make it more
>> error-prone.
>>
>> This patch adds a slower yet safer implementation of try_module_get()
>> that checks if the module is valid by looking into the mod_tree before
>> taking the module's refcount. This new function can be safely called on
>> stale and invalid module pointers, relieving developers from the burden
>> of ensuring that the module exists and is live before attempting to take
>> it.
>>
>> The tree lookup and refcount increment are executed after taking the
>> module_mutex to prevent the module from being unloaded after looking up
>> the tree.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> It very much sounds like there is a desire to have this but without a
> user, there is no justification.

I was working on a set of patches to fix an issue in the fpga subsystem
when I came across your commit 557aafac1153 ("kernel/module: add
documentation for try_module_get()") that made me realize we also had a
safety problem. 

To solve this problem for the fpga manager, we had to add a mutex to
ensure the low-level module still exists before calling
try_module_get(). However, having a safer version of try_module_get()
would have simplified the code and made it more robust against changes.

https://lore.kernel.org/linux-fpga/20240111160242.149265-1-marpagan@redhat.com/

I suspect there may be other cases where try_module_get() is
inadvertently called without ensuring that the module still exists
that may benefit from a safer implementation.

>> +bool try_module_get_safe(struct module *module)
>> +{
>> +	struct module *mod;
>> +	bool ret = true;
>> +
>> +	if (!module)
>> +		goto out;
>> +
>> +	mutex_lock(&module_mutex);
> 
> If a user comes around then this should be mutex_lock_interruptible(),
> and add might_sleep()

Would it be okay to return false if it gets interrupted, or should I
change the return type to int to propagate -EINTR? My concern with
changing the signature is that it would be less straightforward to
use the function in place of try_module_get().

>> +
>> +	/*
>> +	 * Check if the address points to a valid live module and take
>> +	 * the refcount only if it points to the module struct.
>> +	 */
>> +	mod = __module_address((unsigned long)module);
>> +	if (mod && mod == module && module_is_live(mod))
>> +		__module_get(mod);
>> +	else
>> +		ret = false;
>> +
>> +	mutex_unlock(&module_mutex);
>> +
>> +out:
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(try_module_get_safe);
> 
> And EXPORT_SYMBOL_GPL() would need to be used.

Okay, I initially used EXPORT_SYMBOL() to be compatible with
try_module_get().

> 
> I'd also expect selftests to be expanded for this case, but again,
> without a user, this is just trying to resolve a problem which does not
> exist.

I can add selftests in the next versions.
Thanks,
Marco


