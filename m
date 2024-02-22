Return-Path: <linux-kernel+bounces-76954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259A85FF00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944951C2460B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743F156992;
	Thu, 22 Feb 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRuAG8ow"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755215530A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622156; cv=none; b=Cn2ym85jS7nfnFf3EPbURLLFqWQ0xTe3wRYw/p2jKd9QDIXRyTDdadTd8K48a/Y9CJDtnhkZ/4XT9Epm3eF0KEBQg5I9zPAXsB2ZtvzYQgKg57415o2iznahJD1JxowWLlTiodXgrld9V6KV/dRV55limLrKjJoTO5G4vi97xO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622156; c=relaxed/simple;
	bh=+uy9JLp+vVMfKJN72L01rcvqqBFHw2cwNGmOxKPGsos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j15Pb0M0ulkt7CLhZL+a148NWNoARqqa0hsGKAM0rRxg7aYR4lSCEoyt+piJaw/PtuEpOYvHSLq1M4D5TT9/2fQCIm4xMpgueIbj+ZrwIEuWL7/r22dUdVwmvGu6voBlENeEb7iubBhDHwfJDkBVsA4DSN45nGqZv26oNnaT9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRuAG8ow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708622153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiN/ydMpJlHjOU/e8CRpGQ/0tq27wPt1nlJOG4HNtHw=;
	b=GRuAG8owJkCdWtuCRsXTwWUpJn8ed9+jY6Z8Oug1R/tXVoUdFuoiTxBD7hVcVKwV3TWdZi
	NIN8iDkzCA2fZwg5d8sDeDh0m6T7EgB3SWW1Ng6NwJGlv5WrzKXDCaakWbqpBn/sGzRZXc
	mzA6QzeZxnRoFEoMcDwlgUL4mIPQW8g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-9FeytppEPaeVsqhTJLoe8A-1; Thu, 22 Feb 2024 12:15:51 -0500
X-MC-Unique: 9FeytppEPaeVsqhTJLoe8A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68efdf7e047so483506d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622150; x=1709226950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiN/ydMpJlHjOU/e8CRpGQ/0tq27wPt1nlJOG4HNtHw=;
        b=vwrTxRYMiywUnRtmxJqiHX6RIXcPDJA/JKP95XKqmFUSpEdVq6t+eH0pjJCl9sdC2o
         kMAFs5KPbz/Gj3NLajKW8ZJRdz5Gpzaavtq+gKbkwplJKDV6HSP3xTUCimqjmylveRZh
         70A10qBuIt9CnXQoGmTUIIpIEsucuylERBnSZUO2VcNOiTEH3D3uRuyNZ21dBN5KUjlQ
         puyI6klRSZbvj2GFCJiry6lNe6SyU4eVH5td81N+tef3GBFA2+nFylJmKiw+aTq/jrDx
         Y0MgTGz6wf2FkVWNeJFZFn8putLD3159jKjchEWbeeflvfd3h1TlKj9uIrgIzZMpNurJ
         TQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiOiA7UfQ4KRdp6sfqOBPa7JfZBKGMLWKHEpb+yjgVWYHpsl2jzfXQ//2XySfhfTyJO6HWC7PRqDk9CA1/7L8q2C5jeRxzYszpnzWA
X-Gm-Message-State: AOJu0Ywr8fB2OSMnc0Bk+b1sbC2XcS2ZV2rJCqnZnHwz/nVaz4pU3WbR
	sjo69x2YQMh02Lm8fR6O7SdQNi76aIHAiS+dyiJiTbxv0o7NCofIi6/YjQx5hmjdR3HHGL2yLaU
	s8h1szVSQqwyFPjuzZX7dW5S41K2X51HQ/Ej4lSCW31qNleMYOnxY+/dsP8aPuSHBRvnX8kKC
X-Received: by 2002:a05:6214:4001:b0:68f:36a0:5e8b with SMTP id kd1-20020a056214400100b0068f36a05e8bmr17746974qvb.47.1708622150768;
        Thu, 22 Feb 2024 09:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQlNmq9qd+GLd1QY4wiV/+KqqdndJ4NIT8fXgxGKvRPuhnpQZsa9vH0Rgd/OkImVPpJYd8Jg==
X-Received: by 2002:a05:6214:4001:b0:68f:36a0:5e8b with SMTP id kd1-20020a056214400100b0068f36a05e8bmr17746959qvb.47.1708622150467;
        Thu, 22 Feb 2024 09:15:50 -0800 (PST)
Received: from [192.168.1.169] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id ob6-20020a0562142f8600b0068c39b7a7cfsm7129510qvb.12.2024.02.22.09.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:15:50 -0800 (PST)
Message-ID: <b8474363-4eb9-ed06-2464-e958a5c9c397@redhat.com>
Date: Thu, 22 Feb 2024 12:15:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/8] dm vdo: Modify mismatched function name
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240221091731.7007-1-jiapeng.chong@linux.alibaba.com>
 <20240221091731.7007-8-jiapeng.chong@linux.alibaba.com>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240221091731.7007-8-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/21/24 04:17, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/md/dm-vdo/vdo.c:276: warning: expecting prototype for vdo_read_geometry_block(). Prototype was for read_geometry_block() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8273
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/md/dm-vdo/vdo.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-vdo/vdo.c b/drivers/md/dm-vdo/vdo.c
> index 23a4f1d1b6dc..411c58341173 100644
> --- a/drivers/md/dm-vdo/vdo.c
> +++ b/drivers/md/dm-vdo/vdo.c
> @@ -266,7 +266,7 @@ static int __must_check initialize_thread_config(struct thread_count_config coun
>   }
>   
>   /**
> - * vdo_read_geometry_block() - Synchronously read the geometry block from a vdo's underlying block
> + * read_geometry_block() - Synchronously read the geometry block from a vdo's underlying block
>    *                             device.
>    * @vdo: The vdo whose geometry is to be read.
>    *

Thanks for the reports! I'll apply these soon.

Matt


