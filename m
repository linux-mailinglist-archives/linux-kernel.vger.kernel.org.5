Return-Path: <linux-kernel+bounces-159779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC18B33DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD891C22735
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF013E8AE;
	Fri, 26 Apr 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWeOtios"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576FA13D621
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123461; cv=none; b=IylzLr36UjJnwZt35oIhbGGF+SxTADJ2LTK5I40I5YS5LingYFH5CXAngsybOAMRa/yRrAxIO4hpkQiB8ryVk1y5SrjtKIJdQ69LzfrZ3PjzdlX+ROpNmPNdWRhn1uejPPvdzcSR7sG2LAOncIBvqbQAoyqGlY6CYR2/KMBcpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123461; c=relaxed/simple;
	bh=3prmVvb4CSFrMQtGQGohzxkB5EGRjQF5LNfCJibjaRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf4pX+qzeziJax2uwADUJp6zOHnq3iZLBStsnTfA5Tv9C3yrbpML9QJo9qenOerKB8NJ6o+MavDByQEVtfXpf/vQt5qLqSrhs6c+seyKBp/ufLZmYfRQ5S/1GtcWJAF0X3XY419bgCzH5HVy9SY4mofD+QdjFLy0nqSPVpy/gVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWeOtios; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDf1iJ0rcFw5r9tjCYtJ1fcG4v1z0nEnImYLXEpzCjM=;
	b=bWeOtios20C3eqi+Q4VeUWCZXhWTd7xhoCJO6XcYib8pofcXg58PMuBt/wGWhHDsmd7qcm
	X0JemTsn3VlQxeyN3cPwDoCxkI92oZDfP2ceji57H0/x20hRM5D+uONsZpbB7XYSo4iq9Y
	kimwgenCglgLBsq4bKVVQiJl2dC5ZSE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-kujds6tZP2uAlyWSXgbGGA-1; Fri, 26 Apr 2024 05:24:17 -0400
X-MC-Unique: kujds6tZP2uAlyWSXgbGGA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6089c86e4d9so2148170a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123456; x=1714728256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDf1iJ0rcFw5r9tjCYtJ1fcG4v1z0nEnImYLXEpzCjM=;
        b=Dy8NlMnnzTvRfU173+KWGI02rKKgZUv/0vR9J4aLX9qtgNHnJgSnl6lNORPGb0hJng
         Z64q/qu1mjs/nFHQ1n67PNhUS8oBWJboPkTOol//zGfufh8MZpY+hlHU7CAUfNL3mPJ7
         W/X/i0aamq+48qRB5pFa2sbiKz4Xvkpn5Q7gANXEn0eseI8xo9CLO6ZbbCrvKmE7D8UA
         4lcika5TlxTqH81nuaNSHPbFDr/LuLblJdxOfBfoe+Vnfxhyz9ykOX698w3KR4HxTUSn
         owzRMAmoVnx9cDsyLOCRu9XvI5xuIvsCaNZ9i6n9pdrr7p6Hy+dWSv098NuPQaeC/fI0
         iorg==
X-Forwarded-Encrypted: i=1; AJvYcCWKCzNE0mh0YKyfgRs1H+din3zteNc+hgXoAqA+k8jJ/wNQNj7j3gvW0lzaPz6eaf5yKf8vSpBt52Nj9F4Nk6AmGZUfdq7FSVVD9OUZ
X-Gm-Message-State: AOJu0YybCoUU7ANqGmCPo3JQIYFCz1m8hZZa9WbgzK53BPr7KOIeb6cl
	ZNQAvR/W4PM6kEn+mx0lZ7/aKu2vfErlesxXLgkssjJZueb8XFwMLKTbDpPUdXNlIdNieWuPApq
	q8UqC+sFqtb/RUZDYCUyMf1rV9AcmgKRBkpi/WvJDfeu4bCdU4bA8rvwP9w4hkg==
X-Received: by 2002:a05:6a21:3a44:b0:1a7:7b92:e0ed with SMTP id zu4-20020a056a213a4400b001a77b92e0edmr2325164pzb.51.1714123456709;
        Fri, 26 Apr 2024 02:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxVT+GN5mxbf+mMtYjbokc8FhufYwX7eAOxYXMmkBU6lBE5Xi1LluATczohJhaBcs7ECSJrQ==
X-Received: by 2002:a05:6a21:3a44:b0:1a7:7b92:e0ed with SMTP id zu4-20020a056a213a4400b001a77b92e0edmr2325150pzb.51.1714123456389;
        Fri, 26 Apr 2024 02:24:16 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm15054500pls.61.2024.04.26.02.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:24:15 -0700 (PDT)
Message-ID: <e3fb151e-8d79-439d-9eea-131a23f1d48c@redhat.com>
Date: Fri, 26 Apr 2024 19:24:07 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/16] ACPI: processor: Drop duplicated check on _STA
 (enabled + present)
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:53, Jonathan Cameron wrote:
> The ACPI bus scan will only result in acpi_processor_add() being called
> if _STA has already been checked and the result is that the
> processor is enabled and present.  Hence drop this additional check.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: No change
> v6: New patch to drop this unnecessary code. Now I think we only
>      need to explicitly read STA to print a warning in the ARM64
>      arch_unregister_cpu() path where we want to know if the
>      present bit has been unset as well.
> ---
>   drivers/acpi/acpi_processor.c | 6 ------
>   1 file changed, 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


