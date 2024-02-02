Return-Path: <linux-kernel+bounces-50259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAF84767F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E98B29F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E18314AD10;
	Fri,  2 Feb 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV71RMNi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12414A4DD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895848; cv=none; b=gfAoPzMjT8Ww6tuXyWbYaouJKQ3+Uea5id1qj13Xw8NdP1b1UKoDvWRckPJ2jn32+GUfl9FC2MxMrkOkjlWw9ukwJebbV++NSxAVB+EUmswGoToeDGRSex8i7Rrzjr/Zape6slEfIv4kzqbdADy3sfczEoYmLcCLe5hhXL0Rqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895848; c=relaxed/simple;
	bh=6/qPdGRGqcwv3m1KSfVw8PW50DkgRWx8evfvr1L5p10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sufC5MEf5SINsp1CeQPx3TsO4WEvObQGtYiG8LRgV5xZBM9KbZgmLCU2D1GMFEPi2WasQ0OPxzWbqhlxTES9YLr+mB5rbOHZa+/Tqj8o6KgzEajv/2B1hMVs008dyh4NVN+v6cdmD4o+KwC/HV9FpkwIzWu4FiGB4G2od6oyEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aV71RMNi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706895845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++pep7UK0OfxTpG5wffeR3Nq4MugK8U0/QV/c/5dIwY=;
	b=aV71RMNiZUj+kCGWnivmY0aHfbM4P/ceON6eNjcAZ0HgrZzMTHFwXKa7/I7MlTnFitux7E
	A6Zfe8cWOJ9VjaReoGJVz46MtCofTzmpjbW7bxpVeIZKvSS01EkdCVjL8TwPVFfaVRNgvk
	cn7N6FYXFGn5F1QYsZ/wPSfu+LIaP+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-Q6ONBlDTOq6Zz-CyVd-SuQ-1; Fri, 02 Feb 2024 12:44:04 -0500
X-MC-Unique: Q6ONBlDTOq6Zz-CyVd-SuQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b16845d12so826097f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895843; x=1707500643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++pep7UK0OfxTpG5wffeR3Nq4MugK8U0/QV/c/5dIwY=;
        b=crVCpKpl7SYQnPSTc7x3kvXspdILzumV05V7EbCtoaVPYt0D9ccmq7BQOWYqap90dY
         gMr91Kc7RpRym1xlZZdVUQIW2zJ5cl37nGTloLrHi84CEPVzc5EQHABs/0WGlAhLsiXP
         xkxOrG9CawB39AwxIx74ag/DkvzsdS/ji9X6rx/AtiIAQV+O8VhXfiEGkpnHTGvF2UAI
         bRiqwDLiG20xFn6Dz3lXd4btArWaaovbU+h0WDvUnyWlKaQh8G+775iJr2kGi8cCsDt1
         fkA2gDXA7Gas5ZR/ZIa0Roqc/DmqkffdQuKfE1RxdOyfrsN5UpoOgESFyoozSGsX7LqE
         VBTA==
X-Gm-Message-State: AOJu0YwnQtrYUgZXxoXXysiloeahmNOZw1xPGzEWXpMMBOqcGTAENt1Y
	NJVsAVLaMvbQR8qe9C1Xbx/aIqRsqiyVHe8RzUv14jf7N8gcSLor0czxgKGHz+WLPsX+9t9vgNk
	CSPQuleC7564o1FeMggg6sImU5+NhnuQuX7l/wupFEgvTto7pwLf8h0HjlvVR
X-Received: by 2002:a5d:59aa:0:b0:33b:1a42:cd04 with SMTP id p10-20020a5d59aa000000b0033b1a42cd04mr3770936wrr.15.1706895843235;
        Fri, 02 Feb 2024 09:44:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHptmVcjBx8/ISw3LPjFJcVumKc/wve+Wgbrv3l3RC1PT/8U9mWM7h8XDDVSL1zjLyo4EGtPQ==
X-Received: by 2002:a5d:59aa:0:b0:33b:1a42:cd04 with SMTP id p10-20020a5d59aa000000b0033b1a42cd04mr3770925wrr.15.1706895842897;
        Fri, 02 Feb 2024 09:44:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVPe9GCk+5shgZ3WfE9iMyubLBQrBBIRioAzdNByGofbVJp+KGEo1ZlaWyt3SSmxTOoE160snjMhdcV678U5RUuTYsIBNb6TnLyWT2JCdTJucFL6CWxtE7o/Nt3lypkdkcAlGVbu5LCAxKxwdefpNF+TFgdu2IKKYXOevvHR7t7TDgsFztkrAl9N38yHePVL9aaofnqNw1bAbBxNePcincnt8xxCpNJxk1w5BfK+Js+25FwSrNu42sLzw70tL348kgHrV1sF5oR1ICSfxDeUjT4AxbZVvEZ5wG8w5UsqP/lgvM0Xjy6E4cU+JmOmFrQiXRMiiXPISLCWkScQnHje4C/AABC
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b0040faf3df118sm526056wmq.32.2024.02.02.09.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 09:44:02 -0800 (PST)
Message-ID: <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
Date: Fri, 2 Feb 2024 18:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
Content-Language: en-US
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
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-30 05:31, Xu Yilun wrote:
>> +#define fpga_mgr_register_full(parent, info) \
>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>>  struct fpga_manager *
>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>> +			 struct module *owner);
>>  
>> +#define fpga_mgr_register(parent, name, mops, priv) \
>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>>  struct fpga_manager *
>> -fpga_mgr_register(struct device *parent, const char *name,
>> -		  const struct fpga_manager_ops *mops, void *priv);
>> +__fpga_mgr_register(struct device *parent, const char *name,
>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
>> +
>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>>  
>> +#define devm_fpga_mgr_register_full(parent, info) \
>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>>  struct fpga_manager *
>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>> +			      struct module *owner);
> 
> Add a line here. I can do it myself if you agree.

Sure, that is fine by me. I also spotted a typo in the commit log body
(in taken -> is taken). Do you want me to send a v6, or do you prefer
to fix that in place?

> 
> There is still a RFC prefix for this patch. Are you ready to get it merged?
> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>

I'm ready for the patch to be merged. However, I recently sent an RFC
to propose a safer implementation of try_module_get() that would
simplify the code and may also benefit other subsystems. What do you
think?

https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/

> Next time if you think patches are ready for serious review and merge, drop
> the RFC prefix. That avoids an extra query.

Okay, I'll do it like that next time.

Thanks,
Marco


