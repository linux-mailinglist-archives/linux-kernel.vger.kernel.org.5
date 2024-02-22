Return-Path: <linux-kernel+bounces-76883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829C85FE1E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8BF1C21F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022215098B;
	Thu, 22 Feb 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uq8xSbpv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE48C0B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619635; cv=none; b=YcuEYZjT/Y5SCVm/oEduXM4wVj2/kKhM8jn4bBHEv9bbRLKIQdbqYPCOakSr3NRzyvil/UGWUGnCdnuH1i2GC5fbg5P+EMJxy2a5nwIBa0suqcN/swR3IuPHh8qVUKKO70eEodkefS+gbZYVYkqCuGwdP0IAJq4iguk9y7lIr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619635; c=relaxed/simple;
	bh=Fdumt5nBczJiVUcm7uk4eAbxeHQ5Ilsn/VrJ4bxfqf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej3ATRLpLQda/h4OhW0D12Agc/SsrsN8nALiXdZEgiDYDsPvX9umV0T1O3O/KKmW+ShZw8eh7jJdZT3jnCo00rKNLr7at4HtzyYDhMUOx4pOXlhWDBVPM6tRits+wu0YpK4pIp72jac7K/EB1yVlsDxXVi4z29gTzETW9X1X/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uq8xSbpv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708619633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njZCOqSfwyB80QbQtxM7mZ+GgiYBhl+JhpjZqiRCVAA=;
	b=Uq8xSbpvvJtT4xs+yBgcP54pUYqd/+Ev3F/pK+vB8HM7vwKDWcaFA7xkVTsOaZz4D3JZCC
	ZKnAfzqi1EdCAgVxuGS1b79bD67YHd5dCG6kJchsGhYvoYT4TY4Kc4MWkbie7hnjM5aqy5
	VVH86rdrqXViKGQbk7Gz4G1FGuQqN7k=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-1gBWuY9mN6CElNPIK7AjNg-1; Thu, 22 Feb 2024 11:33:51 -0500
X-MC-Unique: 1gBWuY9mN6CElNPIK7AjNg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d243193975so34398101fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619630; x=1709224430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njZCOqSfwyB80QbQtxM7mZ+GgiYBhl+JhpjZqiRCVAA=;
        b=aeAA8V+Xl2/atc+jrKu1pr9smgt9F3yQQoHwrBrVE53R4K9TrmfusRojycd5ON0AEz
         j+6SRpga/67SENhv4fl8SUbWg8bRVb7vz0W8DTzjChpzuEVTuHy1mGbXUeJ6G16M9KTa
         /WtBREIPKnsXPFx9IwIPWqUgYpj8ZSQxqo0Mfos+Titjzb4Gyqtl3HsXmNphIha7xX+D
         vSjGYAj/jjZQ97GHQHRv9st6ZBUaDlfzI9HAyCM4p0bVgzcG85OJuJtbxx4BV2dfBsBe
         uRLd8zAkm6MSvSIfdjjSlUMsnRO+qUhF2PIlRHgIxdRk98VlyAnDiFfZhPv7tfeX5se6
         2bhw==
X-Forwarded-Encrypted: i=1; AJvYcCU+f/Yo9BRlLaay4V5o1pzzG2JRf3VoDDK5ghQx6/2Hhv1r8kU0Moej3Jpk7hlI1VReTYPu7++muTT6IvtoIyt7j+3Gja9BnxM/WmVz
X-Gm-Message-State: AOJu0YzJmqX00bho3DZFReBn26VvSq/d2lqf98wOkxDkmVuX8T9oVy2q
	lee+D2WE4ZT8N9QIM9Z2nvJCSqbfm+3bfuP1KrnULNNcXRJMah5RFyhsJ9ckD8Q6jAWpraAbMoS
	IPoR2oliGqetsx2KwaC8e7ymti1Yn17pcCC7xjzwkXHXV0q8gM/egFtYV9Eiu
X-Received: by 2002:a2e:3006:0:b0:2d2:3a0b:cafd with SMTP id w6-20020a2e3006000000b002d23a0bcafdmr10418096ljw.39.1708619630295;
        Thu, 22 Feb 2024 08:33:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI138h4lOSeCRjEurXIrOuTh8eLV27RylT4Rf4kQNmJ/ypogDBjDEPgj0+u2J83JlT0EPEWA==
X-Received: by 2002:a2e:3006:0:b0:2d2:3a0b:cafd with SMTP id w6-20020a2e3006000000b002d23a0bcafdmr10418075ljw.39.1708619629961;
        Thu, 22 Feb 2024 08:33:49 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-30-118.cust.vodafonedsl.it. [2.34.30.118])
        by smtp.gmail.com with ESMTPSA id g5-20020adffc85000000b0033d8aeb229csm3152570wrr.27.2024.02.22.08.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:33:49 -0800 (PST)
Message-ID: <ad03c582-28b9-40b2-9c7b-8372ed5a05c2@redhat.com>
Date: Thu, 22 Feb 2024 17:33:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/test: add a test suite for GEM objects backed by
 shmem
Content-Language: en-US
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
 <045bfb84-9833-442c-ac54-ed7a26451afa@redhat.com>
 <fb2ac929-6650-444e-8f24-c9b1562d2bb3@roeck-us.net>
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <fb2ac929-6650-444e-8f24-c9b1562d2bb3@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-02-22 16:52, Guenter Roeck wrote:
> Hi Marco,
> 
> On 2/22/24 07:32, Marco Pagani wrote:
>>
>>
>> On 2024-02-18 16:49, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Thu, Nov 30, 2023 at 06:14:16PM +0100, Marco Pagani wrote:
>>>> This patch introduces an initial KUnit test suite for GEM objects
>>>> backed by shmem buffers.
>>>>
>>>> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>>
>>> When running this in qemu, I get lots of warnings backtraces in the drm
>>> core.
>>>
>>> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:327
>>> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:173
>>> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:385
>>> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:211
>>> WARNING: CPU: 0 PID: 1345 at kernel/dma/mapping.c:194
>>> WARNING: CPU: 0 PID: 1347 at drivers/gpu/drm/drm_gem_shmem_helper.c:429
>>> WARNING: CPU: 0 PID: 1349 at drivers/gpu/drm/drm_gem_shmem_helper.c:445
>>>
>>> It looks like dma_resv_assert_held() asserts each time it is executed.
>>> The backtrace in kernel/dma/mapping.c is triggered by
>>>     if (WARN_ON_ONCE(!dev->dma_mask))
>>>         return 0;
>>> in __dma_map_sg_attrs().
>>>
>>> Is this a possible problem in the test code, or can it be caused by
>>> some limitations or bugs in the qemu emulation ? If so, do you have any
>>> thoughts or ideas what those limitations / bugs might be ?
>>
>> Hi Guenter,
>>
>> Thanks for reporting this issue. As you correctly noted, the warnings appear to
>> be caused by the dma_mask in the mock device being uninitialized. I'll send a
>> patch to fix it soon.
>>
> 
> Thanks a lot for the update.
> 
> In this context, the TTM unit tests fail as well in qemu, with worse result:
> It seems there is some bad cleanup after a failed test case, causing list
> corruptions in the drm core and ultimately a crash. I don't know if this
> is also caused by the missing dma_mask initialization.
> 

That's interesting. Which --arch argument are you using to run the
tests with QEMU?
Thanks,
Marco


