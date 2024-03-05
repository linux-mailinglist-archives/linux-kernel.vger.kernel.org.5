Return-Path: <linux-kernel+bounces-91984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE741871962
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E11C21D22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02330548F4;
	Tue,  5 Mar 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b="WpE4j7K+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E43548EA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630183; cv=none; b=S7L1gFDzrTEOm7c9663wRsOOjHi3sMsXmSxPRK9i2LOIGc5i2re/c58f1bC2dRT/0d97IERCL/L1nJhtJgTsUwbW0mDtfRhlWQ/6gyUzSIi8AbrROlS5JHhRZY3djuJ7B30xr51d/5mpx2Tla+hFUt3W/xmWUQIxZli38ZELquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630183; c=relaxed/simple;
	bh=yiKhp6KJcFR9q/KIu+xeAwLGxnWC+zdo5nHV1bhoK+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzzgSAAc3I17HyEclpV4kE8OSJu1h2JVbwOKYgi5Ufw3KyhXvhLs/aSmpcj4i63Q4HmAJ97MRoavAGPtF1yd26Mk0aLsMv97HnppwIWkWsnaXr6pbYdtmP0ATjkyl+JgHK+geBeub4bXI5Tln5wJJW73977liviAvQS9D06lGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com; spf=pass smtp.mailfrom=gigaio.com; dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b=WpE4j7K+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigaio.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a441d7c6125so45083366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1709630179; x=1710234979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPBi9r3lHBDng3XDD5aeE1d+492pjGn2mIX5fAf9OKA=;
        b=WpE4j7K++ukYqnM4XfdGs8Y4PkCHi8/RIb+3v7E0mycYfSdxFg/Jt++ltzgQzn5tCa
         h/jYbWRYVQOIygfHBUqjTpU+e15S7KGgAl8TuqhF7T45Wbg7PavXSem7BR92R87yhqNd
         ZiOPEixvEXgBLBHwxUmh0STYSaV+I8+f8NrAi460DVvFKfVSoE43qTeAWSnQFPJ4vF0P
         KbFlOktijsichbXYAgg71p9AVubensl0D+p2tkpwY8rFZ6z9QOdVlChLslvaH4ufPbrr
         crEbWTUZjM1Pig03GsyUNISdxAu90uw2XmDf/rMjzgfvi99L+Et+2G9R91prlGhCfJ9c
         2TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630179; x=1710234979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPBi9r3lHBDng3XDD5aeE1d+492pjGn2mIX5fAf9OKA=;
        b=QEv/M9MLGMbYl6z7yv4ae4l7/IAjbEozmuhq8aznJhMeg9efjSIMGfq5D/evRa15ab
         YyWA7T1GI2IS6qJ4w8SU3dvDKBPaGk+4cnNp0wWKHWIv/pirjmXf1BKwOr/XFgf37YB/
         oT3945VibHrwHPhAWsX+si71Gmi/K27B8/CjkSE9933xyyh68OJv1jKk82+2VP24jTjU
         TNZakp/vR1zkWm41PjTYvGlmmjZiy8eYxMZiUjGw9j+odQY+ltcymEOJctG50QZu6rrZ
         H/D9Yioz9b/TIUw8PaF2Ibc8FMr9o+fekWMHMoQVFEfThcvLl86MB+e286mlIfNgUHeY
         iGNw==
X-Forwarded-Encrypted: i=1; AJvYcCXPkrBbg0hop/ARkBIWmGcEOZZ5GpufnwtrjcuPyUeieqsQE0ijde7Kt/dm0/PAbrBT7FIJagb+ryxWOYMd6W/cHUTQm2kATpBx+fCO
X-Gm-Message-State: AOJu0YwtVdJK8boKS/OF3kq16bwcAoW99dLJBDlNl5uNC4I9iWNUy0Rq
	Dbo3dB3CXRf7YAhTiU9/1psbrQGweZJmx8sOdvVsz0vX1YRbwulOdA4GGfGxirw=
X-Google-Smtp-Source: AGHT+IHfvOhSVsYjaSCWWUD0ZFLGTx4eEbMw7HppfGGSMvr/ztDQHwlLFmMci36aLbidhc3TAhA5ww==
X-Received: by 2002:a17:906:5585:b0:a45:231:9b4b with SMTP id y5-20020a170906558500b00a4502319b4bmr4642108ejp.20.1709630178541;
        Tue, 05 Mar 2024 01:16:18 -0800 (PST)
Received: from [192.168.1.104] ([46.151.20.23])
        by smtp.gmail.com with ESMTPSA id wk15-20020a170907054f00b00a4519304f8bsm2777355ejb.14.2024.03.05.01.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 01:16:18 -0800 (PST)
Message-ID: <1a2f36bd-4913-401a-84cd-c3f77725fbaf@gigaio.com>
Date: Tue, 5 Mar 2024 10:16:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 1/2] dmaengine: amd: Add empty Kconfig and Makefile for
 AMD drivers
To: Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nishads@amd.com, sonal.santan@amd.com, max.zhen@amd.com
References: <1709053709-33742-1-git-send-email-lizhi.hou@amd.com>
 <1709053709-33742-2-git-send-email-lizhi.hou@amd.com>
Content-Language: en-US
From: Tadeusz Struk <tstruk@gigaio.com>
In-Reply-To: <1709053709-33742-2-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 18:08, Lizhi Hou wrote:
> Add amd/ for AMD dmaengine drivers. Create empty Kconfig and Makefile
> underneath.
> 
> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>
> ---
>   drivers/dma/Kconfig      | 2 ++
>   drivers/dma/Makefile     | 1 +
>   drivers/dma/amd/Kconfig  | 1 +
>   drivers/dma/amd/Makefile | 4 ++++
>   4 files changed, 8 insertions(+)
>   create mode 100644 drivers/dma/amd/Kconfig
>   create mode 100644 drivers/dma/amd/Makefile

Hi Lizhi,
I think you may want to change the order of the patches.
Adding the Kconfig and Makefile changes in the first patch,
and the code itself in the second patch will hurt git bisect.
Just swap them around.
--
Regards,
Tadeusz

