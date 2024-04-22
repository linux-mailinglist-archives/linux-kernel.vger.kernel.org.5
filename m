Return-Path: <linux-kernel+bounces-152711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515C8AC33D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CC61C208CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A36E10A2B;
	Mon, 22 Apr 2024 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d70w0kk1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2CF9EC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713758013; cv=none; b=NUj9Fn8DWweBVrbZTC0NpQCY0JpmTWBIVBT4qjgMsHGoh3ShE59nGONG5ZrINqIPouCeyv2QvJPcW9Kz2V12QAX7RQZSlKKNlQtutNFZ2jBjbMdf7fImn4A6ydnvYn/FaM80hFQJQbr3rf5bwr/P2qBFI0gTPB9dBeO+nmc/9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713758013; c=relaxed/simple;
	bh=tD6kiqMKmO+1my/aa9P9n8z6J8qrVBho+qlOdcCPRLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y66cdyNMNP+/6Vi0ln8TFN+FPcZe5Fi0EPqo/cql306vpeB7glPDyqYxEi8+hfi7QeXHk8961UIjZPdkd5txSANCZW/b0e4CEvYAhARKCSpI5F3/IeraZndzPQ1/fm5drb7+VwfjMoR+uC516eE11ptlpOs7crQcK88pnbAKrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d70w0kk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713758010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0XyZSlHJbiwL8Fk8e6Ao9ghbhjrrj0okROdeEG3PeA=;
	b=d70w0kk19VpTPCBkAaFUGai+6OlJ3t/h4Ad8vX9O3a6ullyACRzb6iU0N+wnHhXZ+SJUcm
	PQkxDtp1A2nOu1NtjQMorTXEDYjVnWbJvwWFWHL1YNHyDsdIQbOrtzFl6ecnjqQa3hQdkB
	DDYh+XdLKWHPkUIlMUcjfaC8nw8aTro=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-mkLAws6BOXm216Y7OUwinQ-1; Sun, 21 Apr 2024 23:53:28 -0400
X-MC-Unique: mkLAws6BOXm216Y7OUwinQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c74e617dceso3146428b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 20:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713758007; x=1714362807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0XyZSlHJbiwL8Fk8e6Ao9ghbhjrrj0okROdeEG3PeA=;
        b=kWDmPc9wWHVOdsIgrmFT2bM8U6qfPpK86gpQG5fOsEyPmwRHJ+UiVBnhZMZVFX5CQP
         jxPUu9o80IkFqwyiT/YvGNL8M5BNdF7B5luDej0tIh0sVegkvfcCe2kVTgKSO2ztZ0ts
         FgpwKT82kH5Tq2vxEIPay+3zh5wi1OiPLpyErH3Z4mP5FElMcPFWL1EwaB8rF6yUr0xr
         LXE9y4iMnO1QFjoVykdnExALLFQjTx9pNAZHVcHe+ZAox9dPIlea/6aUtkoJEK2vqtCz
         HItBIbW1ZpxKs7zqMsCc3ERZUtaGtKoHUJb8HxXMnb69cMFMaq0WnycT/WSAg0NRWGYn
         4LNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv6dKm36e2i3JQhTAtGSVwZvJxJ4xHMEGs/SmrqvBpDHGzunlI8R6R+z65wnEVomOrkIpvb1lX50wZKkS8dNMS5Z3gp2BfTrTj2Re3
X-Gm-Message-State: AOJu0YxXUrlLqG6uZgNBpKtNUjqCKGIhHuK+fgsJgU31BgJt1DuMHTnr
	i+6dise1faMHpca0Sg1YgUNkrf1AJRKQVHcVwn5S0MtGwTJEDEuhaTU0q2AVjXBTgnFguF+PEob
	nXVQsrMRIDiXPMqhe2dPleGc5jJhKgf/FcSYRDdoRUsLwT4TBhkm8kWenrD3ym00ns0up5w==
X-Received: by 2002:a05:6808:124a:b0:3c7:51f:156c with SMTP id o10-20020a056808124a00b003c7051f156cmr12703886oiv.29.1713758007401;
        Sun, 21 Apr 2024 20:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkZ3BNLKQwXsjKmL+OZ/4pqOa0EAKdoGoRtaqIZBDJxdFy4L8f2LFmwwMaKdJQp7E0m+dRqg==
X-Received: by 2002:a05:6808:124a:b0:3c7:51f:156c with SMTP id o10-20020a056808124a00b003c7051f156cmr12703871oiv.29.1713758007141;
        Sun, 21 Apr 2024 20:53:27 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id lo8-20020a056a003d0800b006ed4823671csm7078329pfb.15.2024.04.21.20.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 20:53:26 -0700 (PDT)
Message-ID: <8c3efa79-53ef-40d1-a701-5c88447c95cb@redhat.com>
Date: Mon, 22 Apr 2024 13:53:16 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/18] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-2-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240412143719.11398-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/13/24 00:37, Jonathan Cameron wrote:
> For arm64 the CPU registration cannot complete until the ACPI intepretter
> us up and running so in those cases the arch specific
   ^^

typo: s/us/is

> arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> registration will be attempted later.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v5: New patch.
>      Note that for now no arch_register_cpu() calls return -EPROBE_DEFER
>      so it has no impact until the arm64 one is added later in this series.
> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


