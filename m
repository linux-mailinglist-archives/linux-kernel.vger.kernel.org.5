Return-Path: <linux-kernel+bounces-165133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA468B8875
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBB51C219BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF14535B7;
	Wed,  1 May 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqppKfNX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239751C54
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558736; cv=none; b=sOPBwHIoTTIvTYNCPVdRfJ0w16uO4gcInjdo62/oVr7Ad6qca1V2uszVgunsbUpM2HUIFJ/jAYPrUREi8OWzgd9tPyJqbl5XYvKnI/pSq+xKfwo2enmtmrh0K30ecS7UraRO0aMaQDFNj0inguw/2UPWkZYr7YLRI6qko9RaYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558736; c=relaxed/simple;
	bh=Ev3McdlDAs4BYS6y+XNElwdCdUSfrG/SuHrK3FK3B+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piT0zu6w+q/KEt0ysjw76E6WRlajaFMQk3rvq0Mylz8Q8fHXWb9tEgOs0KIa0+2UFiJ++/37BnX38KoHZegiKu3g9ZkCYIUa/OYOFdqW6R6bY2iCAqwdB7FEIUDM2+vUj72FdtRrQgjiHFz3cjx4p0+maWIhb6COSParAQp7li8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqppKfNX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714558734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxKl3udzzGpg1eT3+MxaYs7RsOyw5KvkU4S7GKrDV/g=;
	b=HqppKfNXGTfgv0SYVLu6TlG/eqZ4d3IpPdCIufevQdNB1SgjdWJ4rR6VZJuaBhb1lte94D
	Pk/yQ/9NhxNQ68P7GgRmtCcTx1VoT76tJFQSBgXjKR59/INjQ52yTTgM3wCTc5Z9YAAmO/
	hJOg12kAaux9BJ5UlzU9Ob2Iy/N0Loc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-hGtnCpkyNyWg69M8j8xLbw-1; Wed, 01 May 2024 06:18:52 -0400
X-MC-Unique: hGtnCpkyNyWg69M8j8xLbw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c1af8f2f3so70854005ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558732; x=1715163532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxKl3udzzGpg1eT3+MxaYs7RsOyw5KvkU4S7GKrDV/g=;
        b=hvQu1FbNVboIR7jpdsWiRhCSu1WswgnkPwaksJdpMpdU6QFIvlLE/0lprmr0QCu2cz
         sUralB6tgUxlbSGhx81F0YeLw36MBamBjT1HFdqwIQM+kl4TeKzTZwk0h9pg9HyR7y50
         oOpGe+NYC/tWBXg/83ohvOJvP2tXSUFS12j4i1rIYwz/tnugk2WwhoJKG2nuiYkhme45
         bBJ0nPsna2f6/wyTiimqtHOwo2/PvULLai0iKe6aDCNlEV7gDaOlnLZPNvxJGK9T6oR8
         +hb0tLdHdJTFLliW51WWxSCxzTOW81M0F0pWnXV6jYd2PCcF7TzbSk1pF0KyNX1PUhUr
         ZRVA==
X-Forwarded-Encrypted: i=1; AJvYcCXWCA+/JnGmPdwp+1f9mj9RrVpeusg0XoAXJXsGzVKbMCoYWZD+VdSJ5NLM7RPgeXjYnml1zvOPcrdE6AJc/J5Q3kZWH3hwg5J/ECGT
X-Gm-Message-State: AOJu0YyOKaEP7FsdgsFWMbgRFH5/RbY31DMoGdM1QcJztfjwmA5XYAkY
	NxoCt3FS/uDbvhZzmt6nJzScQUZ5Y5IVB4AVSfFSTEhzN+uRBCCHf5GPofExY1f99YB/ESmwssW
	GtrkDX2aMzJvTkynddmiSFojY6x+DkxfGUIcJldwCBkVFF7uXEpNyq427UsJTaQ==
X-Received: by 2002:a92:cda8:0:b0:36c:5092:e6a1 with SMTP id g8-20020a92cda8000000b0036c5092e6a1mr2567011ild.29.1714558732187;
        Wed, 01 May 2024 03:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXwbnm2St0QGkNYvo0Kzya2DtdxpDRe1dq5klNVqI1ZMi8KwgV+DlV3hJf4iiekAiT2koB1Q==
X-Received: by 2002:a92:cda8:0:b0:36c:5092:e6a1 with SMTP id g8-20020a92cda8000000b0036c5092e6a1mr2566984ild.29.1714558731861;
        Wed, 01 May 2024 03:18:51 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id x71-20020a63864a000000b00606dd49d3b8sm12183225pgd.57.2024.05.01.03.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:18:51 -0700 (PDT)
Message-ID: <08c6ff11-ab3d-4a4f-95ea-735134fca8cb@redhat.com>
Date: Wed, 1 May 2024 20:18:40 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] ACPI: processor: Return an error if
 acpi_processor_get_info() fails in processor_add()
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-5-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> Rafael observed [1] that returning 0 from processor_add() will result in
> acpi_default_enumeration() being called which will attempt to create a
> platform device, but that makes little sense when the processor is known
> to be not available.  So just return the error code from acpi_processor_get_info()
> instead.
> 
> Link: https://lore.kernel.org/all/CAJZ5v0iKU8ra9jR+EmgxbuNm=Uwx2m1-8vn_RAZ+aCiUVLe3Pw@mail.gmail.com/ [1]
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: New patch following through from Gavin pointing out a memory leak later
>      in the series.
> ---
>   drivers/acpi/acpi_processor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


