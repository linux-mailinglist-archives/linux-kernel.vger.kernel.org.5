Return-Path: <linux-kernel+bounces-90653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF83D8702BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8999E28B063
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D83F8FB;
	Mon,  4 Mar 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="W7ztoCkk"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFB3F8E0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559008; cv=none; b=LahbTV7CIJUxdOoJ/9+fw7eo6XYNdac+II9/lyfgwLPysf9YtzDwLouLMFZ60lm5/IiaWQPOW6r93wN4Su994W8Xi9rX/KcL9MT4QbMxt0suH4UbWcREISOQLu7+0bEMmeMVjoRvkXZi8jL7eGU1PytGqOH2juOBeOTJyCqIaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559008; c=relaxed/simple;
	bh=gqtpqLNc5VNKPRt4nq7SmRkkJCCZ5/sRGBe9XuewtZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKpXNgQAy5rhiX+/1TQsR7iIh2OU9zDpq4dXh4j1y1b2dqgf3k1BjNV70jrsCVTsNvFRvVsBQ7Sf5HzeQbRGH7A6o/Xpp/SyDFJls4Bhe1QplyT1lqVhdpjt9DupsoeBHKacdeoAU1Z6oTZdPXcxTe/JwT/9jfjHfhavbgX9kZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=W7ztoCkk; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c84af127e3so43019839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1709559006; x=1710163806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7SwXBaphoRUbVIp4iZ+2oYSdcUsTrLJSfY5VS/Whck=;
        b=W7ztoCkke4eEvFnXIaVR6bmhTMfy4CjWbgRy1LHt8ajSPP3mzcXoP/9dhFbq2lF/VC
         YjW1K3IpgnLoNPnm8ffMfrk007dMpyJBlkOPu9atPcGIWxZAgcffHVZDZE8mscKwgHqP
         Qh8tov+uQM2cCdHluGzKvN+DyBKsJ0ZoS/J2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559006; x=1710163806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7SwXBaphoRUbVIp4iZ+2oYSdcUsTrLJSfY5VS/Whck=;
        b=noyLVOhMKmUIWcwVHAitGIypxBIPtI5Rz2HcO26aO9rv2S0st4jFtFofDcT9VlLrZx
         sxH4C9ETjogaKhlMTbRSrs1n4sqpGw1qRqxTVkIVBXblF8r6THSSeHqWX19zU28eTpuu
         BT0sPD4lkJ2cfpS5yusQ3Lf9ZaH2zjtkMIhssqcGpMKTtb5U8Zr+7TwStY1Er3R9GuQ3
         a+2LECQJj0js5Q4CHr599RFUFcbk4PoHmL9fWwNpO0ZoCE0C7OblW6E4QMNa69WTSQ+S
         wSXxBZarMvdRfepqlJkfu0tsyMmY8Ygce/OaFp9rZTPedqFi97ApuoDadTJaC4IeU8W5
         6FHw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7tWdGWAmHYX4INaev5Z6Q1SiQwUwQUfuEVFWxdNqgjdPk+tC0DoRvnLDnmz2txDU5KtTDEBrmAAAtjVbaRV5pgBY5VBNZ48yu3XD
X-Gm-Message-State: AOJu0YyijpIcqj5Wx0SSDV+0ns6Yy9w8HrkjKIKJiodgLTk2070kz3Xj
	v2XPPlgMub2jl8rEnLHu97cY/DNwRZWmnwxf1/6PqxtTaTnT+cMBrlL1nAvNgQ==
X-Google-Smtp-Source: AGHT+IHZPF+TKoIdFlXbZQRumkQ9OfKZzuKfCSc+Ixsdzf3z05qnw5Uj9WW5Md2UYTHTRGlwSbT0ZQ==
X-Received: by 2002:a05:6602:1ca:b0:7c8:4adf:cdf3 with SMTP id w10-20020a05660201ca00b007c84adfcdf3mr3814286iot.18.1709559005688;
        Mon, 04 Mar 2024 05:30:05 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e21-20020a6b6915000000b007c7e0e8edc1sm1180657ioc.52.2024.03.04.05.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 05:30:04 -0800 (PST)
Message-ID: <69825821-5b2c-44b1-b921-f077eedb3a71@ieee.org>
Date: Mon, 4 Mar 2024 07:30:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [greybus-dev] [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
Content-Language: en-US
To: Rui Miguel Silva <rmfrfs@gmail.com>,
 Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
 <07df4b96-70c2-41de-9d76-1deb80447a79@ieee.org> <m3o7bwlhgf.fsf@gmail.com>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <m3o7bwlhgf.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/24 10:35 AM, Rui Miguel Silva wrote:
>> So anyway, I think this (and Dan's suggestion) should be
>> addressed, but your fix might not be correct.
>>
>> Rui, can you please shed some light on the situation?
> As we talked,  this email was sent at the same time as my replies to
> this thread and you think I addressed your concerns in that replies.
> If not, just go ahead and ask again.

Yes.

You said the intention was to return null if not found
(rather than "the passed-in value as default").  So that
bug should be fixed.  Dan says he'll re-send that.

Either way, even if it's practically impossible, the
get_channel_from_mode() *can* return NULL, therefore
__gb_lights_flash_brightness_set() should be fixed to
avoid dereferencing the return value in such a case.

					-Alex


