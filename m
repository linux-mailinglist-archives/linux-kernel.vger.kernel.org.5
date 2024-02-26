Return-Path: <linux-kernel+bounces-82268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D65B868174
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81540283E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E73130ADB;
	Mon, 26 Feb 2024 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="bqivvzTH"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D20130AC0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977010; cv=none; b=uewRCQ2gdJhWDhnnYUS5j2Yil86CTWDg6xk2RPFB3DJzpWqmHh+vFcspBT5DqihCPPjGN5d9/qvWmnP13u/UuY1Ji5QtDX0VrpdBXVTN+RXLhM8fpbgfvaGPtu5Z9zKwT1vwJy+vt+P4fZVB1QY4UyDlmnbNsa5DZA2zvHTeM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977010; c=relaxed/simple;
	bh=cJ7HIUxiHnUtPWkj+CXbcPdYJXZ+f4CRr1LUprsJ6rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTtwfw3GkOS9TA6AmCCDDi8K60pa76chn+VoKt+YJy+6SiJ4PSLg1gzPDuYdOhXxjHd2zmqdziLpCG769BrRJl7Ji+gZEu2Vq3LFuvVhieid3kj41Lts9Dqa7OIa1GlOF2d41X1PHhPydEW9LH2z6YXsIK/JRB9n5VHXy/ko/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=bqivvzTH; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb9b28acb4so2464955b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1708977006; x=1709581806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAVCZoKYn3AEDXjkAwhVC7Z/hnkKJALO8ZdxGQStZT8=;
        b=bqivvzTHk3Y3uGhymjwxsda3orKYXv1yhsbIu93jmlQZBmiJ6Lyho2oeQNR5BZUagL
         RopmA+BuoikjYbSIssJLVLFslfeKypvvNxoBD9Le0xFb4Vq2Dsbtpz0EvjdauOio2zTS
         E5mlcGrVdPg1nL2An2xEZ1fn4TPKA35jVr8Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977006; x=1709581806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAVCZoKYn3AEDXjkAwhVC7Z/hnkKJALO8ZdxGQStZT8=;
        b=gjO9tO16zX+5ZLkgZ5rBJEWqVqiZgKMFS+ZSXjgN4LGLsApFhWZzcWbnxARmkK9sfb
         DLHuIcXTfXyq+3CV1+TiPgVT8BrjC+6iwadTz2dkVolAZUBzQg5W1URQkHDtKMbC+QHF
         AhZ6CqMaBlucklbGpOM53pwDUTIEwx0lw81Q8Y0Dt6fcVhWhhvPPbDQorFTmOAsCg4o3
         3yNN86x03DOGfw2im8/O9JwfF4fbH0hvdebvg1io690t5hS66WgnZ93UIdqFSrguN+dj
         xVTE6dKWv99UzkEUK5px+NLnKC75iP29wXcyrf7ivjylpFKc3wyJAZYFejBZrFYD/up1
         F9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWN5oPd4SIf1e5JhbkxQpvUFvdOI/luz80OEnTG4Ntbp4LXzBe18QFB0mAQa+/lf0W9qcLDK/1pES9ICYburPO7ObeE1OoHY6Hdh1gb
X-Gm-Message-State: AOJu0YxlfTSck4N51xlRP7gAyH2+1pZQID4c/wfLSUYw7k/9zM+4efXS
	oP3ronSepp4hx+KAb4k8ezT+xF1G0uB9aXxQRkYc9jRD0YiBV7aOaw7oKM9N4HiAITQCxjCApIk
	=
X-Google-Smtp-Source: AGHT+IF3F3G9Gwycez7fdEEAWLKJ7t+MFJqzKyngrVMmkrFWin+O79T5sA1qaTzEz1Hi0+dRrv84NQ==
X-Received: by 2002:a05:6870:14ca:b0:21f:dc6e:e4dc with SMTP id l10-20020a05687014ca00b0021fdc6ee4dcmr6334366oab.5.1708977005991;
        Mon, 26 Feb 2024 11:50:05 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id t10-20020a05620a034a00b00787e11574c5sm82378qkm.125.2024.02.26.11.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 11:50:05 -0800 (PST)
Message-ID: <17e89261-d46b-4845-9fca-05dac3006a39@ieee.org>
Date: Mon, 26 Feb 2024 13:50:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: constify the struct device_type usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
 <cf5b2696-d7ca-40fc-856a-52f352cd270c@ieee.org>
 <ids3525jm5zkwkgizt2xtg3do37kqqtfdy5gc2cptdduexoe7r@cr4yxh3tykkh>
 <2024022553-deepness-sublevel-73de@gregkh>
 <yru2ywkyqwhg3rpyuqkkx73fxkkgsfj3vcbttnzrjq662ctrov@boh65bhxjjgo>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <yru2ywkyqwhg3rpyuqkkx73fxkkgsfj3vcbttnzrjq662ctrov@boh65bhxjjgo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/24 5:04 AM, Ricardo B. Marliere wrote:
>>>> On another subject:
>>>>
>>>> Johan might disagree, but I think it would be nice to make
>>>> the definitions of the Greybus device types as static (private)
>>>> and make the is_gb_host_device() etc. functions real functions
>>>> rather than static inlines in <linux/greybus.h>.
>>>>
>>>> It turns out that all of the is_gb_*() functions are called only
>>>> from drivers/greybus/core.c; they could all be moved there rather
>>>> than advertising them in <linux/greybus.h>.
>>> I guess it depends whether they would be used somewhere else in the
>>> future. Perhaps it was left there with that intention when it was first
>>> being developed? I agree, though. Will happily send a patch with this if
>>> desired.
>> Let's clean the code up for what we have today.  If it's needed in the
>> future, we can move the structures then.
> Sounds good to me, will send a v2 then!

I might be misinterpreting Greg's response; I *think* he
agrees with my suggestion.

In any case, please do *not* send v2 with the purpose of
including my suggestion.

If you send a v2, keep it focused on this original patch.
You can then implement the other suggestion as a follow-on
patch (or series).

					-Alex

