Return-Path: <linux-kernel+bounces-91048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802228708E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDD6B26B65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AFF6214A;
	Mon,  4 Mar 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="YLP1sK5P"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1E62144
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575157; cv=none; b=WuC/HBXgLdxvO3FBRnQ7kC3ANNKwpGXtWFls3OOflO3nOzyeUR3l5q3j4vAbUTBgnzqD69nsbG0ksF+PeqS/6dHhbPeQYMCulhwi5E2aQVsgpMDxthY1e8ihpayWzi+aiRlhq/vSs3jjngC04XAxqUzkUH5oJqOLWr65S9Sr7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575157; c=relaxed/simple;
	bh=QLV4otpC/iCigb560l//jVarJg6qMxWTbZBnLBsPxAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHJxrKUirZ23EnX0FWFsBdk2Trjt8EgS8NHGpbjzfCVUI01TFWiSBR7Ypoyb9lNlhXsn2Y4wAzA4yxp9yealJgsHY5Q+Bza1mzIodRqAmp6Zx3fpEzRMgvGlq62uh4cFDrhKFzPNEmUbQRjd0v9XrtjwjaMB4I0kNm0HMSBvazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=YLP1sK5P; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso5509689276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1709575155; x=1710179955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thA/I2PqPVLK4SnspFOCxqgcMVG1ux25WaxY6rArXhk=;
        b=YLP1sK5PqRwVlvTHEpfqzI0kdksrkFwlnB8GRU49oubD5OmjosQ6x9NiT23VHbHYcu
         KdWsfCsV7GXXrqGKww/9QUIlnrWOgahS9Eu/UHY9spAjjLun57wTOLHICbhmDtgzsLqk
         eQcAa0zFuHpnhnhmAyxo9WCTTMh6//MG3ztBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575155; x=1710179955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thA/I2PqPVLK4SnspFOCxqgcMVG1ux25WaxY6rArXhk=;
        b=Svmzf2fg5LwqpOSbTOIX/0HymOGoYTKVfzVaSrenRWyskagi+Umqv7uYR6ZcnH3Z9g
         Vbq+TuenwnNlXk4oxMFCntgyI2wvZuGFDJzVQS/SiAbhKzeEUpBCiNKpBdKTyTkEK1iL
         Cbx4XUQQWDerVpNQhH0VqcUpgv3IZZ/vovwKlaf1ClSvVLwKJH7+wVlJZ5trbPEcPcSM
         0EZfNVu48TqXqpJnti6IyZ0MZXJWjG/+xCOByqbQ86BsNcO7JlMmN2Zq8pueKNF/csJn
         7fwqkdcK5C//V3ME1yf4Oqe+rxBq7fnpeT5Eh4hJiQEgI+CAFvce+DOQceMTzbFymmq4
         jAUA==
X-Forwarded-Encrypted: i=1; AJvYcCUUX/0QRrCGjZ/OWi60XBVjpwjihjUQhyw8vHMeXum6SS20zHDGkdzorswuYx3e91DntbUBczuaXU5sEEz3vrQNS9IOkMC33NwbwLvo
X-Gm-Message-State: AOJu0Yz/PfjSoCGVS3AhoPkXyw44jKFfJAtGXOiGcTtHm14LczrdeXfB
	O3ANXPfUoO6GLalu+i3npYRFcHHCqxLHtVwZ7ni7vKf2leEpsYZrf1NA6RNXvQ==
X-Google-Smtp-Source: AGHT+IExfeM10ZB/js7EB+v7jDmQcldpolr3vewnoOnOzAtVxGnjlDaiuVf+mmkl78AiuvoB2YKsrA==
X-Received: by 2002:a25:68d1:0:b0:dc6:3610:c344 with SMTP id d200-20020a2568d1000000b00dc63610c344mr6983088ybc.13.1709575155031;
        Mon, 04 Mar 2024 09:59:15 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id t106-20020a25aaf3000000b00dcc7b9115fcsm2365520ybi.3.2024.03.04.09.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:59:14 -0800 (PST)
Message-ID: <b6cee7a2-d702-4248-977e-25a91c210c93@ieee.org>
Date: Mon, 4 Mar 2024 11:59:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: put macro in a do - while loop
Content-Language: en-US
To: Dileep Sankhla <dileepsankhla.ds@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, pure.logic@nexus-software.ie,
 johan@kernel.org, elder@kernel.org
References: <20240225084017.418773-1-dileepsankhla.ds@gmail.com>
 <2024022538-buffoon-praising-f748@gregkh>
 <CAHxc4bsFj1=VFVDWbdwo3W3CmSyPG1585p2zBePpsD9qy6VKdA@mail.gmail.com>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <CAHxc4bsFj1=VFVDWbdwo3W3CmSyPG1585p2zBePpsD9qy6VKdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/24 3:49 AM, Dileep Sankhla wrote:
> On Sun, Feb 25, 2024 at 2:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>> Did you test build this?
> 
> Hello Greg,
> 
> Yes. No new warning/error was encountered on building the kernel.

Then your build must not have been compiling your changed
code, because the result of your change produces code that
will not compile successfully.

If you look at where gb_loopback_stats_attrs() is called, it's
used only at outer scope, in "drivers/staging/greybus/loopback.c".

Adding do { ... } while() at outer scope is nonsensical.

> 
>>>   #define gb_loopback_attr(field, type)                                        \
>>>   static ssize_t field##_show(struct device *dev,                              \
>>
>> Why did you only change one if you thought this was a valid change?
> 
> 1. As per my C background, I think no other macros in the above source
> code file need to be enclosed in a do - while loop.

gb_loopback_stats_attrs() must *not* be enclosed in a do..while loop.

> 2. I am writing the patch because of the Eudyptula Challenge, and I
> have to fix "one coding style problem" in any of the files in
> drivers/staging/. The above one was one of them.

I support the challenge.  But you need to be sure your fix actually
works, and in particular (in this case) that it compiles correctly.

					-Alex

> 
> Regards,
> Dileep


