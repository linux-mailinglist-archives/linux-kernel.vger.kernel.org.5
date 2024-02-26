Return-Path: <linux-kernel+bounces-80981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C58866EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8342B261B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB661677;
	Mon, 26 Feb 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq2L7gxk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7F60871
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937660; cv=none; b=p6CeiOUcvGl7AIHb3uxKpvRYsZsHld67125QBme0UYu3A0L52PrCo2SV3TJ28TcAGx9XYR5Ka3IH0xsX1JWmtqYJpP5HBQr5qHkF3Skg5AwFJbgqO5ip3pmPnOizuJW+ggk/3nv1dGzCmVwvLKqRESFZ93Ntr1hlF6alNAFdGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937660; c=relaxed/simple;
	bh=5rmuGovVj23y9tnoyw6Jh9PR3P6pgiflK+yqXuAlWpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lih8/IfVQss5auoOu5+6n2o1+QKOL3q3dmHPgRV9DA6sh7VpulRob4g7mnqYUyOzU+kVhVg2OeyBHMYNDYrCP3isD7eAt2goGbqyPrpapoALuGdg7AShYykPdLIiq6rNXyJIWM+R1kjX1dxyM52yTXQrEIy72ga6wvaKl5WR3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iq2L7gxk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708937658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74RKReSheiCBlSpk+QjmiZByTze9J0mvwNQaQ7Ez7Gw=;
	b=Iq2L7gxkTfO91fPMleM+vBcL2gKVQXKJ1JFIxQFqd9pzaf5yJwEJOY2V/FwYuPGJzNeFR8
	RZRoaAGKgML72REFZ9QkKoS4j+Bm8Oc5JXi9H9ECa5taYPdyDpV3bVMYR1cSM6Y20EuWLf
	rNtUYzQXoEQb7DnAv4EOg4Q9zutMi0s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-JywvlVd7PbetLkn97wbh7g-1; Mon, 26 Feb 2024 03:54:16 -0500
X-MC-Unique: JywvlVd7PbetLkn97wbh7g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412a6bdd67fso1747385e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937655; x=1709542455;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74RKReSheiCBlSpk+QjmiZByTze9J0mvwNQaQ7Ez7Gw=;
        b=wkeH/nIQpouo+4CXY0JPJEzRHjmpP0nj9kl5w9xRSCdPxpl00YaGFCBjVtYcZ4xUNP
         OOqGLZ/F+rWTLS1L2ubK+OG81qGGo3ljdKpJR36HkW+26DVJ2K4FIYnZIZ9pm2L9d7BL
         CIoibRRFG9z0IQehfCHMq7yXczYFVvZRe6bThXNX/c+MZ9PAEvBjcAsGsg50Qa7zFNGa
         73B22q2OQ1ibq8iy+eieCg1x+N0ZkfL3frhMIpPa3xCzKLlGn6DiYMzs6cyZ7cdMs7oI
         A95L/JlWYpevbQee6NFl22bF9Dpc2NgfFargHx7dw9XtF8rTzYUrBlh8GbJV3DraY+kR
         +Deg==
X-Forwarded-Encrypted: i=1; AJvYcCV4b8EkH7Yjtfw6N46TIjTHaVH+gdyZrwIptIcGRlhs8Y855D2vg5KZcgsWmBo76TeA7f6zWnRvhc6bW7Dhj8wJzO18kzposQSKDUjN
X-Gm-Message-State: AOJu0YzNXkzI5B6wjDkdRqaG/LmvEp3zqFHLszE6uy21+EyYHi6PKst2
	anUGf6tLqJsuZ5NrEzYGwOyELwHYLgGTj7XOOZFl6pMWfsCDYq+G+uJiYRD1p7ePRWp2Q4p4R/a
	wI4EdP8w20FsxvVXd2Xfvg/zUlGiQ4NmyaLr6OrDN5pwsei2pFvOkhGt3hbPxFe4NymA4Bg==
X-Received: by 2002:a05:600c:468e:b0:412:6250:7179 with SMTP id p14-20020a05600c468e00b0041262507179mr4760530wmo.32.1708937655152;
        Mon, 26 Feb 2024 00:54:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMJAt7GeBhPRYkCSVO+k/YUhbgy2w29H3RnCZMdyybNcgJwbaLAokXxD4AuYxzf8lQOWygrQ==
X-Received: by 2002:a05:600c:468e:b0:412:6250:7179 with SMTP id p14-20020a05600c468e00b0041262507179mr4760517wmo.32.1708937654728;
        Mon, 26 Feb 2024 00:54:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b00412945d2051sm7400674wmg.12.2024.02.26.00.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:54:14 -0800 (PST)
Message-ID: <8a723092-347d-443a-82e1-4093f6a1ba0e@redhat.com>
Date: Mon, 26 Feb 2024 09:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, thp: display [never] for defrag when THP is set to
 never
Content-Language: en-US
To: Liu Song <liusong@linux.alibaba.com>,
 Yuanhe Shu <xiangzao@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240222115323.4925-1-xiangzao@linux.alibaba.com>
 <ec6f2c48-3010-4a02-8f42-fc6b912039cf@redhat.com>
 <d9eb6672-788e-414d-8138-37a3038e3c47@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d9eb6672-788e-414d-8138-37a3038e3c47@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.02.24 12:01, Liu Song wrote:
> 
> 在 2024/2/22 20:14, David Hildenbrand 写道:
>> On 22.02.24 12:53, Yuanhe Shu wrote:
>>> When transparent_hugepage is set to never by cmdline or echo, defrag
>>> still show what it used to be and can be modified which makes user
>>> confusing whether defrag would take effect.
>>>
>>> Actually if transparent_hugepage is set to never, defrag will not take
>>> effect. Just Display never and remain unchangeable to for defrag when
>>> transparent_hugepage is set to never.
>>>
>>> Suggested-by: Liu Song <liusong@linux.alibaba.com>
>>> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
>>> ---
>>
>> No, I don't think we want such a dependency between both options.
>>
>> You might just end up breaking existing scripts (enable defrag before
>> enabling THP) for no good reason.
>>
> In certain situations where khugepaged_thread is NULL, it would be more
> reasonable for the value of
> /sys/kernel/mm/transparent_hugepage/khugepaged/defrag to be 0. The patch
> should include a fix for this case.

Why?

We have a bunch of THP toggles. They reside in 
"/sys/kernel/mm/transparent_hugepage/", indicating that they are THP 
specific.

Some of them are only in effect if some other toggles are set.

That is very common practice.

If you think something could be confusing, maybe clarify the doc? I 
don't immediately see why any code changes are required, really.

-- 
Cheers,

David / dhildenb


