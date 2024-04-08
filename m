Return-Path: <linux-kernel+bounces-135664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF489C97A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D869B1F22893
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4B91422BD;
	Mon,  8 Apr 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEIAmA8x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CE5B1E0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593211; cv=none; b=SvcV4UJn7HD05TXd7DdyXbroFowacPYlOPj9qXPT9cZPFD2anplf/fzXh4lmPinSEVOt++kaADOnjbOwTMXmOvl4ZKxap6UErflni2LN2Yh+HwMkZd7mycBSKX7s/gTVYxNyrGcWlf2TEQaR9F5wZNJ0/L8va1cImQrzGeCtd4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593211; c=relaxed/simple;
	bh=3YTcCvOrTIb8ztr9NoSc8FqKlvU9VhJIM/P9pQlXReo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBhS4TO74M/t4T2nqfpeSRpSMiRGJOT90+a2YL/lX/fm0DE5EKGECEPhC/0KWu/dvkwL3WsZW0KHQqfPJxUnBAc4ZfKbrK1kwmZdA39/GHqsXYEu51BhQEYOHLCyTd4h6oOBLRBQrBggeVzZdWCeicWeZnsl7wejxZtFjeSAgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEIAmA8x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712593208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h22863Hy//pfBouSlhMFbsB3REYm2hRFCV0bcbkG38I=;
	b=jEIAmA8xrVk+vzIXE6DT2LqqhJUUAjAsZ+P2A27z7wTTdiXLxIGCRh6nEOsS+Q2EJ1MEy7
	Z4dyKRYx206BzaTqkO46vRQMvy6cAII4Npbzaf7GarLME/J/oo3RE70qMI/a5beXa/Si8h
	U3BvNtyjx/5/7FfkdWX3TB8LBZV+s4o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Uf-jiDXiOlu9cOpn2Q9bzA-1; Mon, 08 Apr 2024 12:20:06 -0400
X-MC-Unique: Uf-jiDXiOlu9cOpn2Q9bzA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5199cc13b2so286192366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 09:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593205; x=1713198005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h22863Hy//pfBouSlhMFbsB3REYm2hRFCV0bcbkG38I=;
        b=hlJwsqnJ7rDslpbCpiNWtOqi9UvTtp6bQ/BWOmoQfs1ijpEPDb5oiaRO3ybZbIki60
         T+eRmEAoEoXf+VffV7GbBKLQzz4oK5x7bSV+nX2dRENXueCT8zZqA3yy4f8Alf7ks4Q4
         hz7wG8vMnxPZjQsnziNG2tIM+AGEQPg9ah+O99CbQMlMplEVCN+wWvo+F3y5HAE3oZe7
         d6zwOvjc5jy9bOdU+LgC+icraDbkdmLpmOOQiEdBSRt7dn00BxFWs27ht3N68gfJtZV7
         gTNf+YSYJmwT3tEmXRQMVxaYpKE9zkkQoiWfWiP6pCymTmG1dzGnKDykxGXXOXZokjfX
         pE7g==
X-Forwarded-Encrypted: i=1; AJvYcCVLUmRkfPqFOjqgHlH+1uRCly5egpIl7BDNom37e3V82IA5ANTXPOnfoUzI26s1rgO2bNo9vHXCALV3/bsWt/3IbBifLRtoL1u1iBE6
X-Gm-Message-State: AOJu0YyGlVQ5Y0aWM3HPSa4kTUtGKShHbPGbzj64Bk4CGQVzO0sy5UOL
	vNYXlQMjUDn3FscHe2fGcm1x5B083CNNW+QIZw3y/s9SvB2FeXzic0E9u51EklrlVAMV78KDw+V
	8Ki78ILjY+IcVFwOyjuMFjjbEgI8PFUzxp5OUwhlczYbb2KSvREMuw5+u3YAoNGnMZ/tGbij0
X-Received: by 2002:a17:906:37d5:b0:a51:985d:949e with SMTP id o21-20020a17090637d500b00a51985d949emr166448ejc.2.1712593205279;
        Mon, 08 Apr 2024 09:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa6K3OLMNW4jUMdcW9sA1jkRXcBLkNteJW1AwAA1eEenPDvlhGrrlpPIgzeeRX+lEnxq3YPQ==
X-Received: by 2002:a17:906:37d5:b0:a51:985d:949e with SMTP id o21-20020a17090637d500b00a51985d949emr166424ejc.2.1712593204916;
        Mon, 08 Apr 2024 09:20:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709067c0100b00a46aac377e8sm4611412ejo.54.2024.04.08.09.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 09:20:04 -0700 (PDT)
Message-ID: <609652ce-0336-4d69-ab79-f84c8a8506e5@redhat.com>
Date: Mon, 8 Apr 2024 18:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] platform/x86/intel: atomisp2: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240403105511.558395-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240403105511.558395-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 4/3/24 12:55 PM, Andy Shevchenko wrote:
> The UNIVERSAL_DEV_PM_OPS() macro is deprecated. Replace it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As mentioned in the description of DEFINE_RUNTIME_DEV_PM_OPS()
DEFINE_RUNTIME_DEV_PM_OPS() is NOT a 1:1 replacement for
UNIVERSAL_DEV_PM_OPS() specifically it uses pm_runtime_force_suspend() /
pm_runtime_force_resume() .

Specifically pm_runtime_force_suspend() may NOT get set (and in this case
will not set) needs_force_resume skipping a resume + suspend cycle
after a system suspend, which is a problem if firmware has touched
the state of the device during the suspend/resume cycle since the device
may now actually be left powered on.

It seems there is no direct replacement for UNIVERSAL_DEV_PM_OPS()
without a behavior change.

Regards,

Hans




> ---
>  drivers/platform/x86/intel/atomisp2/pm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/atomisp2/pm.c b/drivers/platform/x86/intel/atomisp2/pm.c
> index 805fc0d8515c..1081b632bd5e 100644
> --- a/drivers/platform/x86/intel/atomisp2/pm.c
> +++ b/drivers/platform/x86/intel/atomisp2/pm.c
> @@ -118,8 +118,7 @@ static int isp_pci_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static UNIVERSAL_DEV_PM_OPS(isp_pm_ops, isp_pci_suspend,
> -			    isp_pci_resume, NULL);
> +static DEFINE_RUNTIME_DEV_PM_OPS(isp_pm_ops, isp_pci_suspend, isp_pci_resume, NULL);
>  
>  static const struct pci_device_id isp_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0x0f38), },
> @@ -133,7 +132,7 @@ static struct pci_driver isp_pci_driver = {
>  	.id_table = isp_id_table,
>  	.probe = isp_probe,
>  	.remove = isp_remove,
> -	.driver.pm = &isp_pm_ops,
> +	.driver.pm = pm_ptr(&isp_pm_ops),
>  };
>  
>  module_pci_driver(isp_pci_driver);


