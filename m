Return-Path: <linux-kernel+bounces-53150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746BE84A145
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC54B1F21761
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92421481A2;
	Mon,  5 Feb 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq8yMbjf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85C4779E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155265; cv=none; b=giWwtpjKyYAovVp8JrR6nL7MR8DBGVLDa2NfyXAU3bC9+l/i10JWDH/HaIvBeqEDxiIl6wYwifPEtanOQxBJHMQcF+oDUfrcwYBoeIOiR8wHNCU5DSttkZL5e9VablK8eJd68nD77/IQHi4nq+fTNUMb3XC2TRcBIwhu0/I9MVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155265; c=relaxed/simple;
	bh=YRr9xmrG/Qu7lzbwxy8pFwenZuuqtN5IUwKv14LlfiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfknbCKQZCLmEnCp4GppF7kp4o7dPAu4ZyFO1EY0b1S9SeFuTzsNEcs7CejiYl6z//Du+Kqh2/b63AzzblU9mxYegUpcdLeKkX/E3Q6k9py6y9YrXQ1AWHS8gR7ddOxMV29MW/pNnyIvbqz2iPtpvlF1Sz6aOcGmpN/dkJWuJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dq8yMbjf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707155263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brbw2jGOAYpq03eoPzMnBwz2rIsnyFqQ7SU3UeWuQGc=;
	b=dq8yMbjfII2+ze/UO0Wdzwcc2P2cgo+bwvW0YndNd1Gr+UA3QE0Is1ck+VrSyLg7H7u8GC
	hxmlu1gUXJVO1JkwmmNnZe5g3PKG46SbGJiKu0S+C1y4WrD2LrVEk/LKbVHZGdV9Or66Ho
	vCyBYNb08Byt1xb0QV+KMST9wNpIWK4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-dFsT14leP6G8HNhMoV3jAA-1; Mon, 05 Feb 2024 12:47:38 -0500
X-MC-Unique: dFsT14leP6G8HNhMoV3jAA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68c52361422so58037266d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155258; x=1707760058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brbw2jGOAYpq03eoPzMnBwz2rIsnyFqQ7SU3UeWuQGc=;
        b=VExpUayXmbV/+oUuB4t8+uJWQoRME5Ux5Vvng1Soqbg+qLjSMnbC3cJk5eC68Ne4BG
         cnKPYSjjXdH3GGFio3NrKtOhyZcCuA+NqBgFryiI1AfVWsamBaM2ASbAaAK4gbJfxJY+
         HAvk2GKR0tIe4kmXyqom073dy1k7r925881nm9VC9YzUCf8948cER5QzpMhmDMFkT60p
         PzzwSLhIzRT+1YrLeNiSkMWgcVAqD7vmeeiQMt5I+RcNeO/Cn+uLEBorKJvrujrTKKHr
         yCEICIcDtdL9B81J9fUC43f2v1+fMGbfGU81T1oLesoH4EfMixIF6sm6vmkrSJlTIUvd
         Pb9g==
X-Gm-Message-State: AOJu0YwWSJ2waeBxXzY6iAqIxowu4PSi80QDxq5zZCr5ZoZnmy5GKk3U
	E9g5w3NBSdbBcBIviBK1poATMyS0TltivKy2AAInzOkEpUgWNiNd2DnXCpBCh122jt69OxYm5e1
	gasAXqhaJ9fHPzuR1dRHAWUrt7g5G0Ch2ZT9VgAekPW/Dg+aRdrn+Mx00ff1a
X-Received: by 2002:a05:6214:29e4:b0:68c:3f60:f09a with SMTP id jv4-20020a05621429e400b0068c3f60f09amr72456qvb.47.1707155258037;
        Mon, 05 Feb 2024 09:47:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmf1krkk1UHjWg8vTRkpvKFSEejP5Vj6buHEmjj3zrC17At+WE0pDOH8XHR02kcVwsCGZiHQ==
X-Received: by 2002:a05:6214:29e4:b0:68c:3f60:f09a with SMTP id jv4-20020a05621429e400b0068c3f60f09amr72434qvb.47.1707155257710;
        Mon, 05 Feb 2024 09:47:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWkIoJ5qhW9XD5w+SJcAQkDhXheEHBHkU0/N3GUJGctO4sj9hMBEsMPEZ8/gQJMdbGzImerb6XpuGuMc0NwEuLOReSKbRvUYaL1ZQqxovBPyE97rb7pOyxHoArlI1bHnf9s7tekPkyLAl0qposTKLQ+PgH4YWShusKRZVKnbaZclgTdWqxAQtWkilHYdDYZ5xV58ituZRLVqSLzx3mjqVPO3Ei/JBvTl5keLafivnGQbp444RTxIgQfzlOjDtNO0oKjkbp2PGVabkuaUQJwso2ogffgdeN5ublgxHG63XEKwEHBWhHq4+/CX/2Of3Efjrhq/Jt+7MriqnsA+iee8ZppVnNf
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id nd23-20020a056214421700b0068ca9ea78cbsm188027qvb.21.2024.02.05.09.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 09:47:37 -0800 (PST)
Message-ID: <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
Date: Mon, 5 Feb 2024 18:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Tull <atull@opensource.altera.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20240111160242.149265-1-marpagan@redhat.com>
 <20240111160242.149265-2-marpagan@redhat.com>
 <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-04 06:15, Xu Yilun wrote:
> On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
>>
>>
>> On 2024-01-30 05:31, Xu Yilun wrote:
>>>> +#define fpga_mgr_register_full(parent, info) \
>>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>  struct fpga_manager *
>>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>> +			 struct module *owner);
>>>>  
>>>> +#define fpga_mgr_register(parent, name, mops, priv) \
>>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>>>>  struct fpga_manager *
>>>> -fpga_mgr_register(struct device *parent, const char *name,
>>>> -		  const struct fpga_manager_ops *mops, void *priv);
>>>> +__fpga_mgr_register(struct device *parent, const char *name,
>>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
>>>> +
>>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>>  
>>>> +#define devm_fpga_mgr_register_full(parent, info) \
>>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>  struct fpga_manager *
>>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>> +			      struct module *owner);
>>>
>>> Add a line here. I can do it myself if you agree.
>>
>> Sure, that is fine by me. I also spotted a typo in the commit log body
>> (in taken -> is taken). Do you want me to send a v6, or do you prefer
>> to fix that in place?
> 
> No need, I can fix it.
> 
>>
>>>
>>> There is still a RFC prefix for this patch. Are you ready to get it merged?
>>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
>>
>> I'm ready for the patch to be merged. However, I recently sent an RFC
>> to propose a safer implementation of try_module_get() that would
>> simplify the code and may also benefit other subsystems. What do you
>> think?
>>
>> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
> 
> I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
> proposal is applied before the end of this cycle, we could re-evaluate
> this patch.

That's fine by me.

Thanks,
Marco


