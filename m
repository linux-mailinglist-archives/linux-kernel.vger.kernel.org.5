Return-Path: <linux-kernel+bounces-76777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270485FC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1BD1F253C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059A714E2DC;
	Thu, 22 Feb 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQ5UlCAF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2FC14A0BD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615938; cv=none; b=MkrsbAGbyCbv8HvDftFkx5vCxAAFGZjzCyxz3h2iH3X79uhzUaCSWbOm8WR8BOLzRyQq3j/QwH5c4TWWWxz64uv1iIkRcfP+dnC4HEPtCvZaGoTMEIq09lH9Spgxx2M5EZH/+FU+PTORpyzl/y7pLtj3f1+qlaC7tNJGhS7k3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615938; c=relaxed/simple;
	bh=ILZ+ytHMYKacBLXIoRoUpJ+AFIhaDE8jQlHaknZBlaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNJ5rHPLSBTqgH5XQwvxVAk42xzfm38vh+CS8olOZicaiWctCfafqj/zRBPcpvcd/VudK0B8/5Ytl/6f0LvVYxk8r4PBB/RlhzwYjYdmTTbgGjSkKgRcT4/Tof56KyBaVuxEv2QxG3OnqMOKY17gkugES6RfncVtRBkj22wSOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQ5UlCAF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708615935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COOOv66KH1+SApkaaFo0J6m3wbUnEio+qyBcuJNmFkI=;
	b=gQ5UlCAFVaKhIvFRXuiLnmG1q8s47eyfidfT/AXPBc7JdGBtLARDVD2UaFRHHoJCgL7iaa
	Up8o4iIuwshLC0GLK5JwUiO8BLXGMwKVyF8W/XB5yoZNorKGfN0u6zMfCgJjUSIjuPQLCU
	LoymMvwqMN86fXx6xeSK6S9qISQwBrU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-aqL5R3eSO8OXxYPF9DSwUw-1; Thu, 22 Feb 2024 10:32:14 -0500
X-MC-Unique: aqL5R3eSO8OXxYPF9DSwUw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-512b0c46e34so4087750e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615932; x=1709220732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COOOv66KH1+SApkaaFo0J6m3wbUnEio+qyBcuJNmFkI=;
        b=p7EfC4JpLtL3Nx8e18tPc1NwpUHiW3aQWKvTmUDAjkL3TRJivL0DrfWCodYbwHYAyj
         Abwr+x409xWvX9GERV9WD2CoEajcDk1WgI3DyYdJ2So/z7vJQRBMFcb8Uo09lKj2rWZL
         s9rjL14OmE9SfIV1Ryx7cfbs1bSx+OOwfQjsLBQIiM+traI3O8I+VzxP6CqyOztuC6Ti
         3OMHFCf7arEIirqNXQ11yxHNknQqityhTJ8jMreZhzYRVywNxCG9ra2U8Tb6Gh5/6Bgj
         anC5bJ9ZbLOn3ps6SqU5bRyJPPL6hU9XTLUxx2/t0TEK/y7OJ3yvJiKwt7W75v/UCrZc
         rx2w==
X-Forwarded-Encrypted: i=1; AJvYcCVWoKev2+Wd2+Av4kGUehCWzSuoF8j0F+nJ0/cP5HaJEYx/6eTReWIyz57ZUAKb2tTrPAMy3St+u29jNdmsbCBhuSG3NeDkWKRT4dWM
X-Gm-Message-State: AOJu0YwTIR50UXmJig5NaCQLV0IwiDBZ+2krvkhIgqADxAHFRkNCQPUQ
	oAP1p3P7IUhp2IILHjQWAPcfAIQm0ZrkKifLdKlmbb6gcJIh4o0QaM+UWI54TNHtNXmGvUlsB2K
	mpSNoX9mqYFl10TzAtr2O3EorjqEjQLQhaeFXtZdNU+N4h8B0wz94iLI5dydQ
X-Received: by 2002:a05:6512:242:b0:511:75a7:1513 with SMTP id b2-20020a056512024200b0051175a71513mr12875612lfo.67.1708615932303;
        Thu, 22 Feb 2024 07:32:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYzUCJ58Rq0YBrFgbCy6cdgYwzft9rG3rl8YAo9DDi+bclXTMokpgpGlzD+Y2Qn6bNjH/hxA==
X-Received: by 2002:a05:6512:242:b0:511:75a7:1513 with SMTP id b2-20020a056512024200b0051175a71513mr12875601lfo.67.1708615931943;
        Thu, 22 Feb 2024 07:32:11 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-30-118.cust.vodafonedsl.it. [2.34.30.118])
        by smtp.gmail.com with ESMTPSA id e2-20020a056000120200b0033cf80ad6f5sm20582039wrx.60.2024.02.22.07.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:32:11 -0800 (PST)
Message-ID: <045bfb84-9833-442c-ac54-ed7a26451afa@redhat.com>
Date: Thu, 22 Feb 2024 16:32:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/test: add a test suite for GEM objects backed by
 shmem
To: Guenter Roeck <linux@roeck-us.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20231130171417.74162-1-marpagan@redhat.com>
 <a45b796d-5e04-4eac-b5ba-ea6bb3b6131b@roeck-us.net>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <a45b796d-5e04-4eac-b5ba-ea6bb3b6131b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-18 16:49, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Nov 30, 2023 at 06:14:16PM +0100, Marco Pagani wrote:
>> This patch introduces an initial KUnit test suite for GEM objects
>> backed by shmem buffers.
>>
>> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> When running this in qemu, I get lots of warnings backtraces in the drm
> core.
> 
> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:327
> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:173
> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:385
> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:211
> WARNING: CPU: 0 PID: 1345 at kernel/dma/mapping.c:194
> WARNING: CPU: 0 PID: 1347 at drivers/gpu/drm/drm_gem_shmem_helper.c:429
> WARNING: CPU: 0 PID: 1349 at drivers/gpu/drm/drm_gem_shmem_helper.c:445 
> 
> It looks like dma_resv_assert_held() asserts each time it is executed.
> The backtrace in kernel/dma/mapping.c is triggered by
> 	if (WARN_ON_ONCE(!dev->dma_mask))
> 		return 0;
> in __dma_map_sg_attrs().
> 
> Is this a possible problem in the test code, or can it be caused by
> some limitations or bugs in the qemu emulation ? If so, do you have any
> thoughts or ideas what those limitations / bugs might be ? 

Hi Guenter,

Thanks for reporting this issue. As you correctly noted, the warnings appear to
be caused by the dma_mask in the mock device being uninitialized. I'll send a
patch to fix it soon.

Marco


